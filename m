Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CCECAAD1
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 12:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiHaMJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 08:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiHaMJI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 08:09:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1EBD2B3F
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 05:09:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C96801F93E;
        Wed, 31 Aug 2022 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661947744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Kz0JXPIDYKgo5aOfP3LCFkGL5fdyOJGFYCwmtVUIALU=;
        b=XSZfnXO72UIpyZTe7LApwsfKfp0vHD9bfcTFp57Dvclv2GdI1y90Q0zmRsBToBORX3n85t
        robEEENstNuW39DBr6QZk9KXhzytLteJNhu9sfZ8oeHu2hLsY72nHO/lrVSdLUHaQQ78aK
        qjayqcqpu8j5je9/QG7L6ZS3qKNjzkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661947744;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Kz0JXPIDYKgo5aOfP3LCFkGL5fdyOJGFYCwmtVUIALU=;
        b=uMOpzVC9+xe5S7qpj/H2VuN4c8PIzKHEDxvSrohxo8mYBqoZGNTmYVVlGSxRQTbHABRJ8y
        qHBL95W/yWexWXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC53F1332D;
        Wed, 31 Aug 2022 12:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0ekCKmBPD2PyEQAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 31 Aug 2022 12:09:04 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1] nvme/045: test queue count changes on reconnect
Date:   Wed, 31 Aug 2022 14:09:00 +0200
Message-Id: <20220831120900.13129-1-dwagner@suse.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The target is allowed to change the number of I/O queues. Test if the
host is able to reconnect in this scenario.

This test depends that the target supporting setting the amount of I/O
queues via attr_qid_max configfs file. If this not the case, the test
will always pass. Unfortunatly, we can't test if the file exist before
creating a subsystem.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

This is based on top of Hannes' "Enable 'fc' as transport for
blktests"

  https://github.com/osandov/blktests/pull/100

Running it with nvme-tcp works pretty well:


[  739.382061] run blktests nvme/046 at 2022-08-31 13:59:43
[  739.418293] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[  739.422653] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  739.432970] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
[  739.433327] nvme nvme1: creating 8 I/O queues.
[  739.433617] nvme nvme1: mapped 8/0/0 default/read/poll queues.
[  739.434663] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420
[  744.695433] nvme nvme1: failed to send request -32
[  744.695557] nvme nvme1: failed nvme_keep_alive_end_io error=4
[  744.695630] nvme nvme1: starting error recovery
[  744.696026] nvme nvme1: Reconnecting in 10 seconds...
[  745.529765] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  754.935599] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
[  754.936960] nvme nvme1: creating 1 I/O queues.
[  754.937514] nvme nvme1: mapped 1/0/0 default/read/poll queues.
[  754.937801] nvme nvme1: Successfully reconnected (1 attempt)
[  760.055415] nvme nvme1: failed to send request -32
[  760.055543] nvme nvme1: failed nvme_keep_alive_end_io error=4
[  760.055614] nvme nvme1: starting error recovery
[  760.057046] nvme nvme1: Reconnecting in 10 seconds...
[  760.679753] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[  770.295738] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
[  770.296172] nvme nvme1: creating 8 I/O queues.
[  770.296996] nvme nvme1: mapped 8/0/0 default/read/poll queues.
[  770.298999] nvme nvme1: Successfully reconnected (1 attempt)
[  770.773724] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"


Though with fc we get a nasty crash though I am not on the lastet
kernel version so it might just be noise.


[ 1142.274597] run blktests nvme/046 at 2022-08-31 14:06:26
[ 1142.314532] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1142.323709] nvme nvme1: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
[ 1142.323735] (NULL device *): {0:0} Association created
[ 1142.323756] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
[ 1142.324150] nvme nvme1: NVME-FC{0}: controller connect complete
[ 1142.324374] nvme nvme1: NVME-FC{0}: new ctrl: NQN "blktests-subsystem-1"
[ 1142.367562] nvme nvme2: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1142.367579] (NULL device *): {0:1} Association created
[ 1142.367591] nvmet: creating discovery controller 2 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8606620e-0d41-46b7-bf43-5f444810a564.
[ 1142.367635] nvme nvme2: NVME-FC{1}: controller connect complete
[ 1142.367641] nvme nvme2: NVME-FC{1}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1142.367773] nvme nvme2: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[ 1142.448395] (NULL device *): {0:1} Association deleted
[ 1142.448408] (NULL device *): {0:1} Association freed
[ 1142.448412] (NULL device *): Disconnect LS failed: No Association
[ 1143.418829] BUG: kernel NULL pointer dereference, address: 00000000000006f8
[ 1143.418843] #PF: supervisor read access in kernel mode
[ 1143.418849] #PF: error_code(0x0000) - not-present page
[ 1143.418854] PGD 0 P4D 0 
[ 1143.418858] Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1143.418864] CPU: 6 PID: 141 Comm: kworker/6:1 Not tainted 5.19.0+ #12 feb49800ed29ebfc8670b2faebb40b53112e216d
[ 1143.418874] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[ 1143.418881] Workqueue: nvmet-wq fcloop_fcp_recv_work [nvme_fcloop]
[ 1143.418891] RIP: 0010:nvmet_execute_identify+0x29f/0x780 [nvmet]
[ 1143.418904] Code: ff ff 84 c0 0f 85 74 04 00 00 48 8b 43 20 8b 48 28 48 8b 50 30 48 d3 fa 48 8b 8b 88 01 00 00 48 89 55 00 48 89 55 08 8b 70 58 <48> 8b 89 f8 06 00 00 8b 0c b1 83 e9 03 83 f9 01 76 04 48 89 55 10
[ 1143.418919] RSP: 0018:ffff9ff9c051fde8 EFLAGS: 00010206
[ 1143.418925] RAX: ffff8c9586ecba00 RBX: ffff8c9581443b48 RCX: 0000000000000000
[ 1143.418932] RDX: 0000000000020000 RSI: 0000000000000001 RDI: ffff8c9586ecba00
[ 1143.418939] RBP: ffff8c95d3b3c000 R08: 0000000000000000 R09: 0000000000001000
[ 1143.418946] R10: fffff11fc04c2200 R11: 0000000000000000 R12: ffff8c9588450000
[ 1143.418952] R13: ffff8c958144001c R14: ffff8c9581443d38 R15: ffff8c958f602018
[ 1143.418959] FS:  0000000000000000(0000) GS:ffff8c95fb980000(0000) knlGS:0000000000000000
[ 1143.418967] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1143.418973] CR2: 00000000000006f8 CR3: 000000001309c001 CR4: 0000000000770ee0
[ 1143.418982] PKRU: 55555554
[ 1143.418986] Call Trace:
[ 1143.418991]  <TASK>
[ 1143.418995]  ? nvmet_fc_handle_fcp_rqst+0x367/0x390 [nvmet_fc d80d5d18a91a391c7f77cca859d8047f20a24e12]
[ 1143.419007]  nvmet_fc_rcv_fcp_req+0x21d/0x395 [nvmet_fc d80d5d18a91a391c7f77cca859d8047f20a24e12]
[ 1143.419017]  fcloop_fcp_recv_work+0x78/0xb0 [nvme_fcloop 22d20387c023a333a89ae9a2a06592a0779a6b5c]
[ 1143.419027]  process_one_work+0x20c/0x3d0
[ 1143.419042]  worker_thread+0x4a/0x3b0
[ 1143.419048]  ? process_one_work+0x3d0/0x3d0
[ 1143.419238]  kthread+0xd7/0x100
[ 1143.419429]  ? kthread_complete_and_exit+0x20/0x20
[ 1143.419608]  ret_from_fork+0x1f/0x30
[ 1143.419806]  </TASK>



 tests/nvme/046     | 103 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |   3 ++
 tests/nvme/rc      |  10 +++++
 3 files changed, 116 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 000000000000..3cc260b7348b
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,103 @@
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
+			     "reached within $timeout seconds"
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

