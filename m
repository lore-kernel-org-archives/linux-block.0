Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B575FC54EE9
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiI0OoM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiI0OnZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 10:43:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE527B06
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 07:38:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 76C641FD32;
        Tue, 27 Sep 2022 14:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664289445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QJozRc8YfYfLkPhIF64BydoxI63siiDwmTzB+AMY7QE=;
        b=Ga2n5oeTlQiLVUNXXfyiTMmmXqG/TYq3UqFOwhICibSExBDygmLQ3hJECjUiIefUZ3lany
        0fsu1mF/YdOSyoKpJvnzeXHcMl/DidAXxTU94TCI8Q+ZJrU07SGc9D/JhOArUYrjn8h8LZ
        tVJJ/281/x8oUv79qOoK5ISkNSVmFKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664289445;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QJozRc8YfYfLkPhIF64BydoxI63siiDwmTzB+AMY7QE=;
        b=9vbZ6KSr6Uw8SrOGfJj9+cEEBXxTSGbW800nwGx1A2oi1W7i2IXLfYOpcPQBtKwQNPksYW
        Gr6ss8yNL6GgUWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 697CE139B3;
        Tue, 27 Sep 2022 14:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SZyzGaUKM2PcRAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 27 Sep 2022 14:37:25 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4] nvme/046: test queue count changes on reconnect
Date:   Tue, 27 Sep 2022 16:37:19 +0200
Message-Id: <20220927143719.4214-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The target is allowed to change the number of I/O queues. Test if the
host is able to reconnect in this scenario.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

This version is significantly faster, as we don't have to do the port
toggling instead just wait for the state transitions on the host, live
-> connecting -> live.

As with the previous version, only the tcp transport passes. rdma
fails due lockdep reporting a possible deadlock. fc crashes due a NULL
pointer access.

v4:
 - do not remove ports instead depend on host removing
   controllers, see
   https://lore.kernel.org/linux-nvme/20220927143157.3659-1-dwagner@suse.de/
v3:
 - Added comment why at least 2 CPUs are needed for the test
 - Fixed shell quoting in _set_nvmet_attr_qid_max
v2:
 - detect if attr_qid_max is available
 - https://lore.kernel.org/linux-block/20220831153506.28234-1-dwagner@suse.de/
v1:
 - https://lore.kernel.org/linux-block/20220831120900.13129-1-dwagner@suse.de/

 tests/nvme/046     | 134 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |   3 +
 tests/nvme/rc      |  10 ++++
 3 files changed, 147 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 000000000000..4c7562e9a81c
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,134 @@
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
+# This test requires at least two CPUs on the host side to be available. The
+# host will create for each CPU a queue.  As this tests starts with the number
+# of queues requested by the host and then limits the queues count to one on the
+# target side we need to have more than one queue initially.
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
+	_set_nvmet_attr_qid_max "${subsys_name}" "${max_qid}"
+
+	nvmf_wait_for_state "${subsys_name}" "connecting"
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
index 6d4397a7f043..eab7c6773c60 100644
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
+		echo "${qid_max}" > "${cfs_path}/attr_qid_max"
+	fi
+}
+
 _find_nvme_dev() {
 	local subsys=$1
 	local subsysnqn
-- 
2.37.3

