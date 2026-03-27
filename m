Received: from server.eikel.org (server.eikel.org [178.77.101.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E5A306486;
	Fri, 27 Mar 2026 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.77.101.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639732; cv=none; b=jtmjAthad53XBYB5xzu7532jGEQUDclKxcxXfVsqkPCQBO2yPZ6DyKz8o2ZyP7pXSDEE+eu7x8rb3euNFv4vCFJj6cu9GBIHw5omxQsTgvHz+G+/hIRr4YPwxA1bOi4kX6BOjrUPv3jVPz9c/WIyd4VRBwzlKZuE1cYWXVb4LGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639732; c=relaxed/simple;
	bh=TLUa8H0kROc44JJuIAAvDgoj2wILgzCWjQXst2wIp1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eh3lPGh+uo7ld49TeCB+1LxbYODGDeenffxr05W03NktLBb1hhhN6jvyEKpADwh0f/gGPwixrmF4kJBxBZKYywF7FKRhme3nnsi2VHHVUiGT1SIA58+KzrsZEV3qYX8FNuVQflhoVDMA3RgJ/Yh1NOTOysJQT2pf+HS4lzlMtA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eikel.org; spf=fail smtp.mailfrom=eikel.org; dkim=pass (1024-bit key) header.d=eikel.org header.i=@eikel.org header.b=kQcbSK8F; arc=none smtp.client-ip=178.77.101.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=eikel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=eikel.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eikel.org header.i=@eikel.org header.b="kQcbSK8F"
Received: from thinkpad-benjamin.localnet (p200300fd1f076e00deea16d2b6147fa9.dip0.t-ipconnect.de [IPv6:2003:fd:1f07:6e00:deea:16d2:b614:7fa9])
	by server.eikel.org (Postfix) with ESMTPSA id 529C11F209;
	Fri, 27 Mar 2026 20:28:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eikel.org;
	s=default; t=1774639726;
	bh=cfByAY7MDBY1Qp6JbV2CF1LNB/wVewG6CwMsJrYVHko=; h=From:To:Subject;
	b=kQcbSK8FxeYXIU4tLQgVYG5iXd04inzrzC2GXYtVmVlOHnmU22buR6LTX5/cvgwxK
	 JAgMvWoxulItGYmRl6Gi5UBXUYKOTN6qARGQ5h92wzW8IFcYY880TvLVHlM02t7z8N
	 G9BCyXcitaOEp8vGNtahkpFF0BOVwxVCtqmlgoKU=
Authentication-Results: server.eikel.org;
        spf=pass (sender IP is 2003:fd:1f07:6e00:deea:16d2:b614:7fa9) smtp.mailfrom=debian@eikel.org smtp.helo=thinkpad-benjamin.localnet
Received-SPF: pass (server.eikel.org: connection is authenticated)
From: Benjamin Eikel <debian@eikel.org>
To: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 
 [BUG] RCU stall in blk_mq_timeout_work (potentially a regression in 6.19.7 or
 6.19.8)
Date: Fri, 27 Mar 2026 20:28:45 +0100
Message-ID: <21608811.f9utdCOAlc@thinkpad-benjamin>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dear Linux kernel developers,

I experience repeated RCU stalls in blk_mq_timeout_work causing system freezes.
The NVMe drive (more info at the end) shows no errors or controller resets in
the kernel log: the hardware appears healthy. No I/O timeout messages precede
the stalls.

The stall cascades: khugepaged blocks on __lru_add_drain_all waiting for a
workqueue flush that cannot complete, and additional kworkers block on a
mutex held by the kblockd rescuer thread. The system becomes noticeably
unresponsive and then I notice it in the logs.

In case the logs are too condensed, please tell me and I can provide them
fully. If you have pointers on how this could be reproduced and a commit range,
 I could try to bisect the problem.

I've assembled the following table by grepping my `journalctl -t kernel` logs
over several boots and letting Claude Opus 4.6 analyze it, to detect when the
problems could have started.

Analysis of journalctl across all boots since March 09 shows:

  Kernel                   Boots  blk_mq_timeout_work stalls
  6.18.13 (Debian)             2   0
  6.18.13-bisect (self-built) 10   0
  6.18.14 (Debian)             2   0
  6.18.15 (Debian)             7   0
  6.19.6 (Debian)              3   0
  6.19.8 (Debian)              5   8 stalls across 2 boots
  7.0.0-rc4 (self-built)       5   1 stall on 1 boot
  7.0.0-rc5 (self-built)       5  14 stalls across 2 boots

Zero stalls on any 6.18.x kernel (21 boots total) and on 6.19.6 (3 boots).
Stalls begin with 6.19.8. The bug is intermittent, not every boot triggers
it, but when it does, stalls come in clusters.

== Trace from 6.19.8+deb14-amd64 (March 26) ==

Mar 26 16:25:16 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Mar 26 16:25:16 thinkpad-benjamin kernel: rcu:         Tasks blocked on level-0 rcu_node (CPUs 0-15): P80
Mar 26 16:25:16 thinkpad-benjamin kernel: rcu:         (detected by 5, t=5252 jiffies, g=1882657, q=10144 ncpus=16)
Mar 26 16:25:16 thinkpad-benjamin kernel: task:kworker/5:0H    state:R  running task     stack:0     pid:80    tgid:80    ppid:2      task_flags:0x4208060 flags:0x00080010
Mar 26 16:25:16 thinkpad-benjamin kernel: Workqueue: kblockd blk_mq_timeout_work
Mar 26 16:25:16 thinkpad-benjamin kernel: Call Trace:
Mar 26 16:25:16 thinkpad-benjamin kernel:  <IRQ>
Mar 26 16:25:16 thinkpad-benjamin kernel:  sched_show_task+0x172/0x1c0
Mar 26 16:25:16 thinkpad-benjamin kernel:  rcu_sched_clock_irq.cold+0x4b8/0x5d7
Mar 26 16:25:16 thinkpad-benjamin kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 26 16:25:16 thinkpad-benjamin kernel:  ? __pfx_tick_nohz_handler+0x10/0x10
Mar 26 16:25:16 thinkpad-benjamin kernel:  update_process_times+0x70/0xc0
Mar 26 16:25:16 thinkpad-benjamin kernel:  tick_nohz_handler+0x8f/0x180
Mar 26 16:25:16 thinkpad-benjamin kernel:  __hrtimer_run_queues+0x10b/0x240
Mar 26 16:25:16 thinkpad-benjamin kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
Mar 26 16:25:16 thinkpad-benjamin kernel:  hrtimer_interrupt+0xfc/0x230
Mar 26 16:25:16 thinkpad-benjamin kernel:  __sysvec_apic_timer_interrupt+0x58/0x100
Mar 26 16:25:16 thinkpad-benjamin kernel:  ? __irq_exit_rcu+0x3d/0xe0
Mar 26 16:25:16 thinkpad-benjamin kernel:  sysvec_apic_timer_interrupt+0x6c/0x90
Mar 26 16:25:16 thinkpad-benjamin kernel:  </IRQ>
Mar 26 16:25:16 thinkpad-benjamin kernel:  <TASK>
Mar 26 16:25:16 thinkpad-benjamin kernel:  asm_sysvec_apic_timer_interrupt+0x1a/0x20
Mar 26 16:25:16 thinkpad-benjamin kernel: RIP: 0010:finish_task_switch.isra.0+0x9b/0x2c0
Mar 26 16:25:16 thinkpad-benjamin kernel:  __schedule+0x492/0xfc0
Mar 26 16:25:16 thinkpad-benjamin kernel:  preempt_schedule_irq+0x38/0x60
Mar 26 16:25:16 thinkpad-benjamin kernel:  asm_common_interrupt+0x26/0x40
Mar 26 16:25:16 thinkpad-benjamin kernel: RIP: 0010:blk_mq_timeout_work+0x194/0x1c0
Mar 26 16:25:16 thinkpad-benjamin kernel:  process_one_work+0x192/0x350
Mar 26 16:25:16 thinkpad-benjamin kernel:  worker_thread+0x196/0x300
Mar 26 16:25:16 thinkpad-benjamin kernel:  kthread+0xfc/0x240
Mar 26 16:25:16 thinkpad-benjamin kernel:  ret_from_fork+0x24d/0x290
Mar 26 16:25:16 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Mar 26 16:25:16 thinkpad-benjamin kernel:  </TASK>
Mar 26 16:25:31 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P80 } 5334 jiffies s: 4617 root: 0x0/T

Cascading hung tasks:

Mar 26 16:26:14 thinkpad-benjamin kernel: INFO: task khugepaged:138 blocked for more than 120 seconds.
  khugepaged -> __lru_add_drain_all -> __flush_work -> wait_for_completion

== Trace from 7.0.0-rc5 (self-built, March 27) ==

Mar 27 12:38:23 thinkpad-benjamin kernel: rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
Mar 27 12:38:23 thinkpad-benjamin kernel: rcu:         Tasks blocked on level-0 rcu_node (CPUs 0-15): P32704/1:b..l
Mar 27 12:38:23 thinkpad-benjamin kernel: rcu:         (detected by 5, t=5252 jiffies, g=464621, q=10641 ncpus=16)
Mar 27 12:38:23 thinkpad-benjamin kernel: task:kworker/5:2H    state:R  running task     stack:0     pid:32704 tgid:32704 ppid:2      task_flags:0x4208060 flags:0x00080000
Mar 27 12:38:23 thinkpad-benjamin kernel: Workqueue: kblockd blk_mq_timeout_work
Mar 27 12:38:23 thinkpad-benjamin kernel: Call Trace:
Mar 27 12:38:23 thinkpad-benjamin kernel:  <TASK>
Mar 27 12:38:23 thinkpad-benjamin kernel:  __schedule+0x47c/0x1000
Mar 27 12:38:23 thinkpad-benjamin kernel:  preempt_schedule_irq+0x38/0x60
Mar 27 12:38:23 thinkpad-benjamin kernel:  asm_common_interrupt+0x26/0x40
Mar 27 12:38:23 thinkpad-benjamin kernel: RIP: 0010:blk_mq_timeout_work+0x4c/0x1c0
Mar 27 12:38:23 thinkpad-benjamin kernel:  ? blk_mq_timeout_work+0x45/0x1c0
Mar 27 12:38:23 thinkpad-benjamin kernel:  process_one_work+0x19d/0x3a0
Mar 27 12:38:23 thinkpad-benjamin kernel:  worker_thread+0x1af/0x320
Mar 27 12:38:23 thinkpad-benjamin kernel:  kthread+0xe3/0x120
Mar 27 12:38:23 thinkpad-benjamin kernel:  ret_from_fork+0x2c9/0x360
Mar 27 12:38:23 thinkpad-benjamin kernel:  ret_from_fork_asm+0x1a/0x30
Mar 27 12:38:23 thinkpad-benjamin kernel:  </TASK>

Cascading hung tasks 3 minutes later:

Mar 27 12:41:33 thinkpad-benjamin kernel: INFO: task khugepaged:138 blocked for more than 120 seconds.
  khugepaged -> __lru_add_drain_all -> __flush_work -> wait_for_completion

Mar 27 12:41:33 thinkpad-benjamin kernel: INFO: task kworker/2:0:28992 blocked for more than 120 seconds.
  kworker/2:0 -> worker_attach_to_pool -> __mutex_lock (blocked on mutex held by kworker/R-kbloc:139)

Mar 27 12:41:33 thinkpad-benjamin kernel: INFO: task kworker/R-kbloc:139 is the mutex owner:
  rescuer_thread -> worker_attach_to_pool -> set_cpus_allowed_ptr -> affine_move_task -> wake_up_var

The stall recurred 6 times on this boot:
  12:38, 12:47, 13:55, 13:59, 14:10, 14:12

== NVMe device info ==

No NVMe errors in dmesg, hardware appears healthy:
  nvme 0000:03:00.0: platform quirk: setting simple suspend
  nvme nvme0: pci function 0000:03:00.0
  nvme nvme0: 16/0/0 default/read/poll queues

PCI: 03:00.0 Non-Volatile memory controller: SK hynix Platinum P41/PC801 [1c5c:1959]

Kind regards
Benjamin


