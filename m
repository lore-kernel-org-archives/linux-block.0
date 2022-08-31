Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C93FECAAD4
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiHaPfU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiHaPfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 11:35:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61935543FA
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 08:35:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 88E231F37F;
        Wed, 31 Aug 2022 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661960113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=trrkY591c5st3byh+F0E2ziWNSsMYB4bhkWSq5zwiyM=;
        b=ahe55cM/aF7nCMqPNoswYaKrHLhj3XBx5pBu2Qw27FmzIJ4y62DJBv6NU0KrpVljNNJDPP
        RTwjFxRF1aoGBrZUXdh4jmpyClTbcpaz7mNNid6m/VtNNJs5HREWBzWBSgxVy+3CVZb9nD
        EE7x2PJk/MTJH/tznQKZfsdGU/p2maw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661960113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=trrkY591c5st3byh+F0E2ziWNSsMYB4bhkWSq5zwiyM=;
        b=9Fo7Unrr3TcTyqe75vKu9R6Gxfq37QHRN6L+JRw5JzLVNNmb4X6jeMMQ2B+nqthSXQd66R
        cLyIteX5LjyqSMBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 787F513A7C;
        Wed, 31 Aug 2022 15:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VktkHbF/D2PGbwAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 31 Aug 2022 15:35:13 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2] nvme/045: test queue count changes on reconnect
Date:   Wed, 31 Aug 2022 17:35:06 +0200
Message-Id: <20220831153506.28234-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The target is allowed to change the number of I/O queues. Test if the
host is able to reconnect in this scenario.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

changes
v2:
 - detect if attr_qid_max is available
v1:
 - https://lore.kernel.org/linux-block/20220831120900.13129-1-dwagner@suse.de/

 tests/nvme/046     | 133 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |   3 +
 tests/nvme/rc      |  10 ++++
 3 files changed, 146 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 000000000000..428d596c93b9
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,133 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Daniel Wagner, SUSE Labs
+#
+# Test queue count changes on reconnect
+
+. tests/nvme/rc
+
+DESCRIPTION="Test queue count changes on reconnect"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+	_require_min_cpus 2
+}
+
+_detect_subsys_attr() {
+	local attr="$1"
+	local file_path="${TMPDIR}/img"
+	local subsys_name="blktests-feature-detect"
+	local cfs_path="${NVMET_CFS}/subsystems/${subsys_name}"
+	local port
+
+	truncate -s 1M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"b92842df-a394-44b1-84a4-92ae7d112332"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	local val=1
+	[[ -f "${cfs_path}/${attr}" ]] && val=0
+
+	_remove_nvmet_subsystem "${subsys_name}"
+
+	_remove_nvmet_port "${port}"
+
+	rm "${file_path}"
+
+	return "${val}"
+}
+
+def_state_timeout=20
+
+nvmf_wait_for_state() {
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+
+	local nvmedev=$(_find_nvme_dev "${subsys_name}")
+	local state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	local start_time=$(date +%s)
+	local end_time
+
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+                if (( end_time - start_time > timeout )); then
+                        echo "expected state \"${state}\" not " \
+			     "reached within ${timeout} seconds"
+                        break
+                fi
+	done
+}
+
+nvmet_set_max_qid() {
+	local port="$1"
+	local subsys_name="$2"
+	local max_qid="$3"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	nvmf_wait_for_state "${subsys_name}" "connecting"
+
+	_set_nvmet_attr_qid_max "${subsys_name}" "${max_qid}"
+
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	nvmf_wait_for_state "${subsys_name}" "live"
+}
+
+test() {
+	local port
+	local subsys_name="blktests-subsystem-1"
+	local hostid
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local file_path="${TMPDIR}/img"
+
+	echo "Running ${TEST_NAME}"
+
+	hostid="$(uuidgen)"
+	if [ -z "$hostid" ] ; then
+		echo "uuidgen failed"
+		return 1
+	fi
+
+	_setup_nvmet
+
+	if ! _detect_subsys_attr "attr_qid_max"; then
+		SKIP_REASONS+=("missing attr_qid_max feature")
+		return 1
+	fi
+
+	truncate -s 512M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"b92842df-a394-44b1-84a4-92ae7d112861"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${hostnqn}"
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     "" "" \
+			     "${hostnqn}" "${hostid}"
+
+	nvmf_wait_for_state "${subsys_name}" "live"
+
+	nvmet_set_max_qid "${port}" "${subsys_name}" 1
+	nvmet_set_max_qid "${port}" "${subsys_name}" 128
+
+	_nvme_disconnect_subsys "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/046.out b/tests/nvme/046.out
new file mode 100644
index 000000000000..f1a967d540b7
--- /dev/null
+++ b/tests/nvme/046.out
@@ -0,0 +1,3 @@
+Running nvme/046
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6d4397a7f043..9e4fe9c8ba6c 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -544,6 +544,16 @@ _set_nvmet_dhgroup() {
 	     "${cfs_path}/dhchap_dhgroup"
 }
 
+_set_nvmet_attr_qid_max() {
+	local nvmet_subsystem="$1"
+	local qid_max="$2"
+	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
+
+	if [[ -f "${cfs_path}/attr_qid_max" ]]; then
+		echo $qid_max > "${cfs_path}/attr_qid_max"
+	fi
+}
+
 _find_nvme_dev() {
 	local subsys=$1
 	local subsysnqn
-- 
2.37.2

