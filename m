Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525BE2E175F
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756795633; cv=none; b=B5FF7X11FxJr+YucwgRp+Dfo8VQ0vYaKQ9S+G8XVGcffy94v8Jck443FpUsmkJZfJSP8vbksssdfgc2uOND6+3K7Kqb3/a5beEUQF6C//83cwCbpHaCw5RGUmhZTCD9ab/hfinqg9fuZgL4OpjNRCANgANHaFwMAXEPyF3uejJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756795633; c=relaxed/simple;
	bh=ozWWqIbgoU/NajLhSsOzZNleWXGGn+tK9Hpnd3ud2LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGZQnODpDc1d2Y2Yvp5m/ua8lDOOp/W8yaMeQOtGrNTxJrr5LSMK47EtqMWsbzkgDY9LKtJH0C16G2SNbi7PQPMoR4gl13H6eW7K09N4mgpMfB2DzKio0qz2Zy5UMd42JSBgHF02NUNkFmLa+kWfRuXWxBktULTpVNDr6t867XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=iY/X2tEs; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="iY/X2tEs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756795626;
	bh=cfWmZjgZ7JzZ8t9RCs6Yo4Kc385FM8hAFRrU9s2mWyA=;
	h=From:Subject:Date:Message-ID;
	b=iY/X2tEszKbySeslmm4NyiUw5tMG7CscpBAY2UbV6aTG7H507yJsxUe0jaEr3c0Fs
	 U+4UbW9tTkDnDAV99hpk15xCol58K8vprdBloazjW8r9+umQOP4gCauYMaxy+PkJ/O
	 469icLhNH+G8MM9x5KVPlVOpE9y3/xWOzvJRXZcY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68B692E50000044B; Tue, 2 Sep 2025 14:47:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2208976816260
X-SMAIL-UIID: 34D3DA63F4544A8DAFA9566402950A72-20250902-144703-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+4032319a6a907f69e985@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk,
	edumazet@google.com,
	Dmitry Vyukov <dvyukov@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] BUG: soft lockup in sys_sendmsg (2)
Date: Tue,  2 Sep 2025 14:46:50 +0800
Message-ID: <20250902064651.6359-1-hdanton@sina.com>
In-Reply-To: <68b6726d.a70a0220.1c57d1.0594.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 01 Sep 2025 21:28:29 -0700
> syzbot has found a reproducer for the following issue on:
> 
This report makes no sense even with a reproducer because

> HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16094a42580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
> dashboard link: https://syzkaller.appspot.com/bug?extid=4032319a6a907f69e985
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15990312580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/63178c6ef3f8/disk-7fa4d8dc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c5c27b0841e0/vmlinux-7fa4d8dc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9a8832715cca/bzImage-7fa4d8dc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4032319a6a907f69e985@syzkaller.appspotmail.com
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5234/1:b..l
> rcu: 	(detected by 1, t=10503 jiffies, g=7533, q=653 ncpus=2)
> task:udevd           state:R  running task     stack:26096 pid:5234  tgid:5234  ppid:1      task_flags:0x400140 flags:0x00004002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5357 [inline]
>  __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
>  preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7288
>  irqentry_exit+0x6f/0x90 kernel/entry/common.c:197
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
> RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:206 [inline]
> RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:238 [inline]
> RIP: 0010:tif_test_bit include/linux/thread_info.h:192 [inline]
> RIP: 0010:tif_need_resched include/linux/thread_info.h:208 [inline]
> RIP: 0010:need_resched include/linux/sched.h:2211 [inline]
> RIP: 0010:preempt_schedule_common+0x11/0xd0 kernel/sched/core.c:7153
> Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 53 49 bf 00 00 00 00 00 fc ff df eb 0d <48> f7 03 08 00 00 00 0f 84 9b 00 00 00 65 ff 05 0b 76 5e 07 65 8b
> RSP: 0018:ffffc900030c7540 EFLAGS: 00000246
> RAX: 1ffff11008494b40 RBX: ffff8880424a5a00 RCX: aa2a76cb3742ae00
> RDX: 0000000000000000 RSI: ffffffff8c04e5e0 RDI: ffffffff8c04e5a0
> RBP: ffffc900030c75d8 R08: ffffffff8fe52d37 R09: 1ffffffff1fca5a6
> R10: dffffc0000000000 R11: fffffbfff1fca5a7 R12: dffffc0000000000
> R13: ffff88807da4ce80 R14: ffff8880424a6ee0 R15: dffffc0000000000
>  preempt_schedule+0xae/0xc0 kernel/sched/core.c:7169
>  preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
>  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
>  _raw_spin_unlock_irqrestore+0xfd/0x110 kernel/locking/spinlock.c:194
>  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
>  __wake_up_common_lock+0x190/0x1f0 kernel/sched/wait.c:127
>  sock_def_readable+0x1fb/0x550 net/core/sock.c:3564
>  __netlink_sendskb net/netlink/af_netlink.c:1265 [inline]
>  netlink_sendskb+0xa1/0x140 net/netlink/af_netlink.c:1271
>  netlink_unicast+0x397/0x9e0 net/netlink/af_netlink.c:1361
>  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
>  sock_sendmsg_nosec net/socket.c:714 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:729
>  ____sys_sendmsg+0x505/0x830 net/socket.c:2614
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
>  __sys_sendmsg net/socket.c:2700 [inline]
>  __do_sys_sendmsg net/socket.c:2705 [inline]
>  __se_sys_sendmsg net/socket.c:2703 [inline]
>  __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa3432a7407
> RSP: 002b:00007ffded507800 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fa343a95880 RCX: 00007fa3432a7407
> RDX: 0000000000000000 RSI: 00007ffded507860 RDI: 0000000000000004
> RBP: 0000562320cd2f40 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000000b2
> R13: 0000562320cb09e0 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> rcu: rcu_preempt kthread starved for 10543 jiffies! g7533 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:28008 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5357 [inline]
>  __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
>  __schedule_loop kernel/sched/core.c:7043 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:7058
>  schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
>  rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
>  rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
> rcu: Stack dump where RCU GP kthread last ran:
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 6072 Comm: syz.2.32 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> RIP: 0010:list_empty include/linux/list.h:381 [inline]
> RIP: 0010:plist_del+0x88/0x3f0 lib/plist.c:126
> Code: 5e f0 3f f6 48 89 df e8 56 07 00 00 4d 8d 7e 08 4c 89 fd 48 c1 ed 03 42 80 7c 25 00 00 74 08 4c 89 ff e8 0b 9a a3 f6 4d 8b 2f <4d> 39 fd 74 6d 4d 8d 66 18 4c 89 e0 48 c1 e8 03 48 b9 00 00 00 00
> RSP: 0018:ffffc900030d76d0 EFLAGS: 00000046
> RAX: ffffffff8b80e8df RBX: ffff8880b863a8e8 RCX: ffff888027c59e00
> RDX: 0000000000000000 RSI: ffff8880b863a8e8 RDI: ffff8880b863a8e8
> RBP: 1ffff11004f8b464 R08: ffff888140a911f7 R09: 1ffff1102815223e
> R10: dffffc0000000000 R11: ffffed102815223f R12: dffffc0000000000
> R13: ffff888027c5a320 R14: ffff888027c5a318 R15: ffff888027c5a320
> FS:  00007ffbb84b56c0(0000) GS:ffff8881257c4000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000200000000058 CR3: 000000007dd24000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  dequeue_pushable_task+0x2e/0x2d0 kernel/sched/rt.c:415
>  dequeue_task_rt+0x25e/0x790 kernel/sched/rt.c:1457

RT task can turn scheduler into the guy in the oval office if they like.
That is why running syzbot with RT turned on wastes minutes at the first
place.

>  block_task kernel/sched/core.c:2155 [inline]
>  try_to_block_task kernel/sched/core.c:6585 [inline]
>  __schedule+0x5f1/0x4cc0 kernel/sched/core.c:6896
>  __schedule_loop kernel/sched/core.c:7043 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:7058
>  futex_do_wait kernel/futex/waitwake.c:358 [inline]
>  __futex_wait+0x1c3/0x3e0 kernel/futex/waitwake.c:687
>  futex_wait+0x104/0x360 kernel/futex/waitwake.c:715
>  do_futex+0x333/0x420 kernel/futex/syscalls.c:102
>  __do_sys_futex kernel/futex/syscalls.c:179 [inline]
>  __se_sys_futex+0x36f/0x400 kernel/futex/syscalls.c:160
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ffbb758ebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffbb84b50e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: ffffffffffffffda RBX: 00007ffbb77c5fa8 RCX: 00007ffbb758ebe9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007ffbb77c5fa8
> RBP: 00007ffbb77c5fa0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffbb77c6038 R14: 00007ffea00f5430 R15: 00007ffea00f5518
>  </TASK>
> 
> 
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
