Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1842DC6FA82
	for <linux-block@archiver.kernel.org>; Tue, 13 Sep 2022 06:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiIMG6J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Sep 2022 02:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiIMG6I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Sep 2022 02:58:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F1910FF2
        for <linux-block@vger.kernel.org>; Mon, 12 Sep 2022 23:58:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E04105BE81;
        Tue, 13 Sep 2022 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663052283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qdF9ETyrpD52bE/cRlz2CJsV4x1+g1pk8SFY1Hm3XBs=;
        b=fcLY0qhb+5fYJhmUBm20Oc3A05xaAzEpln2EVM8qpe+23vbVubYgdpb9hHx2V4/cEZYYej
        IjTB5I/ENmKtPF/KhDYXki14vIDs5h9+IfNG1K2Kb73OLNv4npjR8DgTvYueudbKv/ljs3
        QlTfXXn/6peZHrZUO5phV88tBrYyxPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663052283;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qdF9ETyrpD52bE/cRlz2CJsV4x1+g1pk8SFY1Hm3XBs=;
        b=QDQ8kB1ROGE1uVv2OJ8SAaIfVzHVqYFrsjy1zIQIjYxcmyCHnguiXulEny2erTZIjrV6OD
        vC9hVKOvikqYKtAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D89C42C142;
        Tue, 13 Sep 2022 06:58:03 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id CDC2751AB1A1; Tue, 13 Sep 2022 08:58:03 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3] nvme/046: test queue count changes on reconnect
Date:   Tue, 13 Sep 2022 08:57:58 +0200
Message-Id: <20220913065758.134668-1-dwagner@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The target is allowed to change the number of I/O queues. Test if the
host is able to reconnect in this scenario.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
I've send a fix for the bug reported in nvmet_subsys_attr_qid_max_show()

Though I have found another problem with this test:

 nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
 nvme nvme0: creating 8 I/O queues.
 nvme nvme0: mapped 8/0/0 default/read/poll queues.
 nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr 10.161.61.228:4420
 nvme nvme0: starting error recovery

 ======================================================
 WARNING: possible circular locking dependency detected
 6.0.0-rc2+ #26 Not tainted
 ------------------------------------------------------
 kworker/6:6/17471 is trying to acquire lock:
 ffff888103d76440 (&id_priv->handler_mutex){+.+.}-{3:3}, at: rdma_destroy_id+0x17/0x20 [rdma_cm]
 
 but task is already holding lock:
 ffffc90002497de0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x4ec/0xa90
 
 which lock already depends on the new lock.

 
 the existing dependency chain (in reverse order) is:
 
 -> #3 ((work_completion)(&queue->release_work)){+.+.}-{0:0}:
        process_one_work+0x565/0xa90
        worker_thread+0x2c0/0x710
        kthread+0x16c/0x1a0
        ret_from_fork+0x1f/0x30
 
 -> #2 ((wq_completion)nvmet-wq){+.+.}-{0:0}:
        __flush_workqueue+0x105/0x850
        nvmet_rdma_cm_handler+0xf9f/0x174e [nvmet_rdma]
        cma_cm_event_handler+0x77/0x2d0 [rdma_cm]
        cma_ib_req_handler+0xbd4/0x23c0 [rdma_cm]
        cm_process_work+0x2f/0x210 [ib_cm]
        cm_req_handler+0xf73/0x2020 [ib_cm]
        cm_work_handler+0x6d6/0x37c0 [ib_cm]
        process_one_work+0x5b6/0xa90
        worker_thread+0x2c0/0x710
        kthread+0x16c/0x1a0
        ret_from_fork+0x1f/0x30
 
 -> #1 (&id_priv->handler_mutex/1){+.+.}-{3:3}:
        __mutex_lock+0x12d/0xe40
        cma_ib_req_handler+0x956/0x23c0 [rdma_cm]
        cm_process_work+0x2f/0x210 [ib_cm]
        cm_req_handler+0xf73/0x2020 [ib_cm]
        cm_work_handler+0x6d6/0x37c0 [ib_cm]
        process_one_work+0x5b6/0xa90
        worker_thread+0x2c0/0x710
        kthread+0x16c/0x1a0
        ret_from_fork+0x1f/0x30
 
 -> #0 (&id_priv->handler_mutex){+.+.}-{3:3}:
        __lock_acquire+0x1a9d/0x2d90
        lock_acquire+0x15d/0x3f0
        __mutex_lock+0x12d/0xe40
        rdma_destroy_id+0x17/0x20 [rdma_cm]
        nvmet_rdma_free_queue+0x54/0x180 [nvmet_rdma]
        nvmet_rdma_release_queue_work+0x2c/0x70 [nvmet_rdma]
        process_one_work+0x5b6/0xa90
        worker_thread+0x2c0/0x710
        kthread+0x16c/0x1a0
        ret_from_fork+0x1f/0x30
 
 other info that might help us debug this:

 Chain exists of:
   &id_priv->handler_mutex --> (wq_completion)nvmet-wq --> (work_completion)(&queue->release_work)

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&queue->release_work));
                                lock((wq_completion)nvmet-wq);
                                lock((work_completion)(&queue->release_work));
   lock(&id_priv->handler_mutex);
 
  *** DEADLOCK ***

 2 locks held by kworker/6:6/17471:
  #0: ffff888150207948 ((wq_completion)nvmet-wq){+.+.}-{0:0}, at: process_one_work+0x4ec/0xa90
  #1: ffffc90002497de0 ((work_completion)(&queue->release_work)){+.+.}-{0:0}, at: process_one_work+0x4ec/0xa90
 
 stack backtrace:
 CPU: 6 PID: 17471 Comm: kworker/6:6 Not tainted 6.0.0-rc2+ #26 a3543a403f60337b00194a751e59d1695bae8a5b
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
 Workqueue: nvmet-wq nvmet_rdma_release_queue_work [nvmet_rdma]
 Call Trace:
  <TASK>
  dump_stack_lvl+0x56/0x73
  check_noncircular+0x1e8/0x220
  ? print_circular_bug+0x110/0x110
  ? kvm_sched_clock_read+0x14/0x40
  ? sched_clock_cpu+0x63/0x1b0
  ? lockdep_lock+0xa7/0x160
  ? call_rcu_zapped+0x90/0x90
  ? add_chain_block+0x1e0/0x290
  __lock_acquire+0x1a9d/0x2d90
  ? lockdep_hardirqs_on_prepare+0x200/0x200
  ? rxe_post_recv+0x139/0x150 [rdma_rxe 81c8d5ac4ddc7eb0ce33e9cb903fbd3fbfb05634]
  lock_acquire+0x15d/0x3f0
  ? rdma_destroy_id+0x17/0x20 [rdma_cm 5f1d19776772fb2bf4a8bb0e22480d1c5839d7fd]
  ? lock_release+0x710/0x710
  ? kvm_sched_clock_read+0x14/0x40
  ? __rdma_block_iter_next+0x110/0x110 [ib_core 0fb68d9b3dd88438bf20acf0ab9fc3d4d71a3097]
  ? lock_is_held_type+0xac/0x130
  __mutex_lock+0x12d/0xe40
  ? rdma_destroy_id+0x17/0x20 [rdma_cm 5f1d19776772fb2bf4a8bb0e22480d1c5839d7fd]
  ? rdma_destroy_id+0x17/0x20 [rdma_cm 5f1d19776772fb2bf4a8bb0e22480d1c5839d7fd]
  ? mutex_lock_io_nested+0xcf0/0xcf0
  ? kfree+0x203/0x4c0
  ? lock_is_held_type+0xac/0x130
  ? lock_is_held_type+0xac/0x130
  ? rdma_destroy_id+0x17/0x20 [rdma_cm 5f1d19776772fb2bf4a8bb0e22480d1c5839d7fd]
  ? trace_cq_drain_complete+0xd4/0x130 [ib_core 0fb68d9b3dd88438bf20acf0ab9fc3d4d71a3097]
  rdma_destroy_id+0x17/0x20 [rdma_cm 5f1d19776772fb2bf4a8bb0e22480d1c5839d7fd]
  nvmet_rdma_free_queue+0x54/0x180 [nvmet_rdma 870a8126b1a0d73aa27d7cf6abb08aa5abd53fe3]
  nvmet_rdma_release_queue_work+0x2c/0x70 [nvmet_rdma 870a8126b1a0d73aa27d7cf6abb08aa5abd53fe3]
  process_one_work+0x5b6/0xa90
  ? pwq_dec_nr_in_flight+0x100/0x100
  ? lock_acquired+0x33d/0x5b0
  ? _raw_spin_unlock_irq+0x24/0x50
  worker_thread+0x2c0/0x710
  ? process_one_work+0xa90/0xa90
  kthread+0x16c/0x1a0
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>
 nvme nvme0: Reconnecting in 10 seconds...
 nvmet_rdma: enabling port 0 (10.161.61.228:4420)


And there is the question how to handle the different kernel logs output:

c740:~/blktests # nvme_trtype=tcp ./check nvme/046
nvme/046 (Test queue count changes on reconnect)             [passed]
    runtime  32.750s  ...  32.340s
c740:~/blktests # nvme_trtype=rdma ./check nvme/046
nvme/046 (Test queue count changes on reconnect)             [failed]
    runtime  32.340s  ...  24.716s
    something found in dmesg:
    [307171.053929] run blktests nvme/046 at 2022-09-13 08:32:07
    [307171.884448] rdma_rxe: loaded
    [307171.965507] eth0 speed is unknown, defaulting to 1000
    [307171.967049] eth0 speed is unknown, defaulting to 1000
    [307171.968671] eth0 speed is unknown, defaulting to 1000
    [307172.057714] infiniband eth0_rxe: set active
    [307172.058544] eth0 speed is unknown, defaulting to 1000
    [307172.058630] infiniband eth0_rxe: added eth0
    [307172.107627] eth0 speed is unknown, defaulting to 1000
    [307172.230771] nvmet: adding nsid 1 to subsystem blktests-feature-detect
    ...
    (See '/root/blktests/results/nodev/nvme/046.dmesg' for the entire message)
c740:~/blktests # nvme_trtype=fc ./check nvme/046
nvme/046 (Test queue count changes on reconnect)             [failed]
    runtime  24.716s  ...  87.454s
    --- tests/nvme/046.out      2022-09-09 16:23:22.926123227 +0200
    +++ /root/blktests/results/nodev/nvme/046.out.bad   2022-09-13 08:35:03.716097654 +0200
    @@ -1,3 +1,89 @@
     Running nvme/046
    -NQN:blktests-subsystem-1 disconnected 1 controller(s)
    +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or directory
    +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or directory
    +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or directory
    +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or directory
    +grep: /sys/class/nvme-fabrics/ctl/nvme0/state: No such file or directory
    ...
    (Run 'diff -u tests/nvme/046.out /root/blktests/results/nodev/nvme/046.out.bad' to see the entire diff)

The grep error is something I can fix in the test but I don't know how
to handle the 'eth0 speed is unknown' kernel message which will make
the test always fail. Is it possible to ignore them when parsing the
kernel log for errors?


v3:
 - Added comment why at least 2 CPUs are needed for the test
 - Fixed shell quoting in _set_nvmet_attr_qid_max
v2:
 - detect if attr_qid_max is available
 - https://lore.kernel.org/linux-block/20220831153506.28234-1-dwagner@suse.de/
v1:
 - https://lore.kernel.org/linux-block/20220831120900.13129-1-dwagner@suse.de/

 tests/nvme/046     | 137 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |   3 +
 tests/nvme/rc      |  10 ++++
 3 files changed, 150 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 000000000000..4ffd4dcff832
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,137 @@
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
2.35.3

