Return-Path: <SRS0=t5UG=4W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8649C3F2D8
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8905A20848
	for <linux-block@archiver.kernel.org>; Thu,  5 Mar 2020 11:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgCELxC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 06:53:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:51158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgCELxB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 06:53:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50A1FAF82;
        Thu,  5 Mar 2020 11:52:59 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme/033: add test for ANA state transition
Date:   Thu,  5 Mar 2020 12:52:38 +0100
Message-Id: <20200305115239.29794-3-hare@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200305115239.29794-1-hare@suse.de>
References: <20200305115239.29794-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a test to check ANA state transitions.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/033     | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  18 +++++++
 tests/nvme/rc      |  16 ++++++
 3 files changed, 173 insertions(+)
 create mode 100644 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100644
index 0000000..44182fc
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,139 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Regression test for ANA base support
+#
+# Copyright (C) 2018 Hannes Reinecke, SUSE Linux GmbH
+#
+
+. tests/nvme/rc
+
+DESCRIPTION="test ANA optimized/transitioning/inaccessible support"
+QUICK=1
+
+switch_nvmet_anagroup() {
+	local port1="$1"
+	local port2="$2"
+	local mode="$3"
+
+	echo "ANA state ${mode}"
+
+	if [ "${mode}" = "change" ] ; then
+		_set_nvmet_anagroup_state "${port1}" "1" "change"
+		_set_nvmet_anagroup_state "${port1}" "2" "change"
+		_set_nvmet_anagroup_state "${port2}" "1" "change"
+		_set_nvmet_anagroup_state "${port2}" "2" "change"
+	elif [ "${mode}" = "failover" ] ; then
+		_set_nvmet_anagroup_state "${port1}" "1" "inaccessible"
+		_set_nvmet_anagroup_state "${port1}" "2" "optimized"
+		_set_nvmet_anagroup_state "${port2}" "1" "optimized"
+		_set_nvmet_anagroup_state "${port2}" "2" "inaccessible"
+	else
+		_set_nvmet_anagroup_state "${port1}" "1" "optimized"
+		_set_nvmet_anagroup_state "${port1}" "2" "inaccessible"
+		_set_nvmet_anagroup_state "${port2}" "1" "inaccessible"
+		_set_nvmet_anagroup_state "${port2}" "2" "optimized"
+	fi
+}
+
+requires() {
+	_have_program nvme && _have_modules nvme-loop && \
+		_have_configfs && _have_fio
+}
+
+test() {
+	local mount_dir="/mnt/blktests"
+	local subsys="blktests-subsystem-1"
+	local port1
+	local port2
+	local loop_dev1
+	local loop_dev2
+	local nvmedev
+
+	echo "Running ${TEST_NAME}"
+
+	modprobe nvmet
+	modprobe nvme-loop
+
+	mkdir -p "${mount_dir}" > /dev/null 2>&1
+
+	port1="$(_create_nvmet_port "loop")"
+	ag1="$(_create_nvmet_anagroup "${port1}")"
+
+	port2="$(_create_nvmet_port "loop")"
+	ag2="$(_create_nvmet_anagroup "${port2}")"
+
+	truncate -s 1G "$TMPDIR/img1"
+
+	loop_dev1="$(losetup -f --show "$TMPDIR/img1")"
+
+	_create_nvmet_subsystem "${subsys}" "${loop_dev1}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" "1"
+
+	truncate -s 1G "$TMPDIR/img2"
+
+	loop_dev2="$(losetup -f --show "$TMPDIR/img2")"
+
+	_create_nvmet_ns "${subsys}" "2" "${loop_dev2}" \
+		"9aed0138-bfd9-46f5-92ac-24c70377fd49" "2"
+
+	_add_nvmet_subsys_to_port "${port1}" "${subsys}"
+	_add_nvmet_subsys_to_port "${port2}" "${subsys}"
+
+	switch_nvmet_anagroup "${port1}" "${port2}" failback
+
+	nvme connect -t loop -a "${port1}" -n "${subsys}"
+	nvme connect -t loop -a "${port2}" -n "${subsys}"
+
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	nvmedev="$(_find_nvme_ns 91fdba0d-f87b-4c25-b80f-db7be1418b9e)"
+
+	mkfs.xfs -f /dev/"${nvmedev}" > /dev/null 2>&1
+
+	mount /dev/"${nvmedev}" "${mount_dir}"
+
+	_run_fio_rand_io --size=32m --directory="${mount_dir}" --runtime=20s --time_based &
+	trap "kill $!" EXIT
+
+	sleep 10
+
+	switch_nvmet_anagroup "${port1}" "${port2}" "change"
+
+	# Insert a delay to allow the AEN to be processed
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	sleep 6
+
+	switch_nvmet_anagroup "${port1}" "${port2}" "failover"
+
+	# Insert a delay to allow the AEN to be processed
+	sleep 1
+
+	_display_ana_state "${subsys}"
+
+	wait
+	trap - EXIT
+
+	umount "${mount_dir}" > /dev/null 2>&1
+
+	nvme disconnect -n "${subsys}"
+
+	_remove_nvmet_subsystem_from_port "${port1}" "${subsys}"
+	_remove_nvmet_subsystem_from_port "${port2}" "${subsys}"
+	_remove_nvmet_ns "${subsys}" "2"
+	_remove_nvmet_subsystem "${subsys}"
+	_remove_nvmet_anagroup "${port1}" "${ag1}"
+	_remove_nvmet_port "${port1}"
+	_remove_nvmet_anagroup "${port2}" "${ag2}"
+	_remove_nvmet_port "${port2}"
+	losetup -d "${loop_dev2}"
+	rm "$TMPDIR/img2"
+	losetup -d "${loop_dev1}"
+	rm "$TMPDIR/img1"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
new file mode 100644
index 0000000..782656f
--- /dev/null
+++ b/tests/nvme/033.out
@@ -0,0 +1,18 @@
+Running nvme/033
+ANA state failback
+1: grpid 1 state optimized
+1: grpid 2 state inaccessible
+2: grpid 1 state inaccessible
+2: grpid 2 state optimized
+ANA state change
+1: grpid 1 state change
+1: grpid 2 state change
+2: grpid 1 state change
+2: grpid 2 state change
+ANA state failover
+1: grpid 1 state inaccessible
+1: grpid 2 state optimized
+2: grpid 1 state optimized
+2: grpid 2 state inaccessible
+NQN:blktests-subsystem-1 disconnected 2 controller(s)
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 72e33c1..1787725 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -246,6 +246,22 @@ _find_nvme_loop_dev() {
 	done
 }
 
+_find_nvme_ns() {
+	local uuid=$1
+	local dev
+	local hidden
+
+	for dev in /sys/block/nvme*; do
+		hidden="$(cat "${dev}/hidden")"
+		[[ "$hidden" -eq 1 ]] && continue
+		u="$(cat "${dev}/uuid")"
+		if [[ "$uuid" = "$u" ]] ; then
+			echo "$(basename "${dev}")"
+			break
+                fi
+        done
+}
+
 _filter_discovery() {
 	sed -n -r -e "s/Generation counter [0-9]+/Generation counter X/" \
 		  -e '/Discovery Log Number|Log Entry|trtype|subnqn/p'
-- 
2.13.7

