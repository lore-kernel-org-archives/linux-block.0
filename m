Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634CA283121
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601419; cv=none; b=pvg/Mn7YOeIGmTrXtiXL7mvFK33jpjMR7bxjzZVTSsVel6lEyuhHKz/ERnEMpfZIgT/nC/1LVyKvHF88cTgfVdluDZ6y9CiZOTu2gMw75UBtt6d83NCU0dR70NeAmya28n4KElVkYxjaiAGgAoS51dNYbw+Ah9czHKJvoTRIAaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601419; c=relaxed/simple;
	bh=MLsrhBCv+lrewjtW0t59wVcC205WGCzpHVijue31PVA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mqcjX0plj8h5UU4XIVQSrHSozh1QzwDMYHSR0DxXmwFZHmvSx6bJ7hV3pMkUoPzYDrpSCAKiq7uGryLOKzQfyia04F2gqMxCkx6GCt8pcp+e8QY3FgFoDoAAfiJWPo+wkzy1QqkjVjmFyS8IR+nSxXpmXbmBpOgebQheTbqApnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86d0aa2dc99so595441039f.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 10:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752601415; x=1753206215;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxSTspO63Qnw2Sym30jqs7WFpRsKguI0ZmO3vd0+C+k=;
        b=wtsb9P3bsHeLGx5TaFQKO7u97WYZ0fBcrfGcTTNkXsPu9Y5amg7K3S5dRIIXUaNi1W
         QalDGOmQFCfol6dYbkFIlTq5ZnyybQLkGgsF4N86WGnhLrYXXDrXXJbwoxVBHRxuiM9Q
         F9ITUfOipBYsN18qjf7etXJ7DtPLj3CBFDWTFnMTy0u75noZy18lXHARtUk+ULDil+i6
         SQRrzypuxQEy6a3yHWH+K0VYsJYPtyH0kprzslv58duDu26H9RjA97TaFkddZpYTHVWt
         ZFbY0xhDfF8G9uE98QvOlZvdQtzOxrhsy6LlhJEMEg1NnqFAOw/lcVJKkzml5GD3CL4R
         zwng==
X-Forwarded-Encrypted: i=1; AJvYcCVRA6M6lYVWfapIXQzwBBMvtWSbdMrcF4EKA2rC0p/TSxCZz1WHJ0rRGBko59jJ35YnlsH8YZidyMUjiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yybmo28d/6rtLNUSLrMgYzePd9uYxcZrNUnSz2Ad30ktqVQbYpE
	EYdn6NbZDBfPYuPf3Ls5q0L63rYaWsfy2Dh/tVMhMZ13O1o2/1eqihx1jg/W5kzBDqTbTxrNp4c
	58A0fnGfzz7Su7/q6vKymUcNEz1/1czrHgGPDX+fi99Mas9I6fCZUoJDyOEQ=
X-Google-Smtp-Source: AGHT+IH3FyOGdiQt3VjMSwi5Mn+39dleinUt2VhdBjDQArwetRZIQlntM+3dKWAgsg/Qx4EpN3zpmxDnNBtF9G9EvRtI2pv6quZB
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b89:b0:867:40d9:bf7e with SMTP id
 ca18e2360f4ac-879c08c53bcmr33551839f.9.1752601415391; Tue, 15 Jul 2025
 10:43:35 -0700 (PDT)
Date: Tue, 15 Jul 2025 10:43:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68769347.a70a0220.693ce.0013.GAE@google.com>
Subject: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_setup (4)
From: syzbot <syzbot+9c1ebb9957045e00ac63@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    347e9f5043c8 Linux 6.16-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13da518c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
dashboard link: https://syzkaller.appspot.com/bug?extid=9c1ebb9957045e00ac63
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=138dfd82580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f084467d9f0c/disk-347e9f50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6a4f59125249/vmlinux-347e9f50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/04618886a1ca/bzImage-347e9f50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c1ebb9957045e00ac63@syzkaller.appspotmail.com

INFO: task syz.3.19:6139 blocked for more than 143 seconds.
      Not tainted 6.16.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.19        state:D stack:28328 pid:6139  tgid:6138  ppid:5983   task_flags:0x400040 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5397 [inline]
 __schedule+0x16f5/0x4d00 kernel/sched/core.c:6786
 __schedule_loop kernel/sched/core.c:6864 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6879
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6936
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x724/0xe80 kernel/locking/mutex.c:747
 blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:631
 blk_trace_ioctl+0x181/0x430 kernel/trace/blktrace.c:730
 blkdev_ioctl+0x416/0x6d0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5074b8e929
RSP: 002b:00007f5075a4b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5074db5fa0 RCX: 00007f5074b8e929
RDX: 0000200000000000 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007f5074c10b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5074db5fa0 R15: 00007ffd7bffb438
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:0/12:
 #0: ffff88802fd1b148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88802fd1b148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc90000117bc0 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc90000117bc0 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4733
1 lock held by khungtaskd/31:
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8e13f0e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6770
6 locks held by kworker/u8:4/66:
 #0: ffff88801b2fe148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3213 [inline]
 #0: ffff88801b2fe148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x17b0 kernel/workqueue.c:3321
 #1: ffffc9000213fbc0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3214 [inline]
 #1: ffffc9000213fbc0 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x17b0 kernel/workqueue.c:3321
 #2: ffffffff8f510e10
 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf7/0x800 net/core/net_namespace.c:662
 #3: ffff88805d0c00e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:884 [inline]
 #3: ffff88805d0c00e8 (&dev->mutex){....}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
 #3: ffff88805d0c00e8 (&dev->mutex){....}-{4:4}, at: devlink_pernet_pre_exit+0x10a/0x3d0 net/devlink/core.c:506
 #4: ffff8880206bc250 (&devlink->lock_key#8){+.+.}-{4:4}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff8880206bc250 (&devlink->lock_key#8){+.+.}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff8880206bc250 (&devlink->lock_key#8){+.+.}-{4:4}, at: devlink_pernet_pre_exit+0x11c/0x3d0 net/devlink/core.c:506
 #5: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #5: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_dev_lock+0x257/0x2f0 net/core/dev.c:2143
1 lock held by kswapd0/87:
3 locks held by kworker/u8:9/3465:
 #0: ffff8880b8739f98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:606
 #1: 
ffff8880b8723f08 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x39a/0x6d0 kernel/sched/psi.c:987
 #2: ffff8880b8725958 (&base->lock){-.-.}-{2:2}, at: lock_timer_base kernel/time/timer.c:1004 [inline]
 #2: ffff8880b8725958 (&base->lock){-.-.}-{2:2}, at: __mod_timer+0x1ae/0xf30 kernel/time/timer.c:1085
3 locks held by kworker/u8:10/3557:
2 locks held by getty/5611:
 #0: ffff88814df180a0 (&tty->ldisc_sem
){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000333b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz.0.16/6130:
1 lock held by syz.3.19/6139:
 #0: ffff8881427843d0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:631
1 lock held by syz.2.18/6146:
 #0: ffff8881427843d0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:631
1 lock held by syz.4.20/6153:
 #0: ffff8881427843d0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:631
1 lock held by syz.1.17/6157:
 #0: ffff8881427843d0 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0xfb/0x1f0 kernel/trace/blktrace.c:631
2 locks held by syz-executor/6324:
 #0: ffffffff8f510e10 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x304/0x4d0 net/core/net_namespace.c:570
 #1: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock_killable include/linux/rtnetlink.h:145 [inline]
 #1: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: register_netdev+0x18/0x60 net/core/dev.c:11218
2 locks held by syz-executor/6328:
 #0: ffffffff8f510e10 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x304/0x4d0 net/core/net_namespace.c:570
 #1: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: ip_tunnel_init_net+0x2ab/0x800 net/ipv4/ip_tunnel.c:1160
2 locks held by syz-executor/6329:
 #0: ffffffff8f510e10 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x304/0x4d0 net/core/net_namespace.c:570
 #1: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock_killable include/linux/rtnetlink.h:145 [inline]
 #1: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: register_netdev+0x18/0x60 net/core/dev.c:11218
2 locks held by syz-executor/6335:
 #0: ffffffff8f510e10 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x304/0x4d0 net/core/net_namespace.c:570
 #1: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: ip_tunnel_init_net+0x2ab/0x800 net/ipv4/ip_tunnel.c:1160
2 locks held by syz-executor/6336:
 #0: ffffffff8f510e10 (pernet_ops_rwsem){++++}-{4:4}, at: copy_net_ns+0x304/0x4d0 net/core/net_namespace.c:570
 #1: ffffffff8f51da08 (rtnl_mutex){+.+.}-{4:4}, at: ip_tunnel_init_net+0x2ab/0x800 net/ipv4/ip_tunnel.c:1160
2 locks held by dhcpcd-run-hook/6347:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.16.0-rc6-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:307 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:470
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5982 Comm: kworker/u9:4 Not tainted 6.16.0-rc6-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci12 hci_cmd_timeout
RIP: 0010:io_serial_in+0x77/0xc0 drivers/tty/serial/8250/8250_port.c:409
Code: e8 ce 9c 78 fc 44 89 f9 d3 e3 49 83 c6 40 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 cf 1c dc fc 41 03 1e 89 da ec <0f> b6 c0 5b 41 5c 41 5e 41 5f e9 ca 8c 2a 06 cc 44 89 f9 80 e1 07
RSP: 0018:ffffc90003a8f2b0 EFLAGS: 00000002
RAX: 1ffffffff33bfc00 RBX: 00000000000003fd RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: ffffffff99dfe990 R08: ffff888024590237 R09: 1ffff110048b2046
R10: dffffc0000000000 R11: ffffffff85479650 R12: dffffc0000000000
R13: 0000000000000000 R14: ffffffff99dfe700 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125c1b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3868e19368 CR3: 0000000033be2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr+0x1a1/0x2f0 drivers/tty/serial/8250/8250_port.c:2094
 fifo_wait_for_lsr drivers/tty/serial/8250/8250_port.c:3348 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3371 [inline]
 serial8250_console_write+0x134c/0x1ba0 drivers/tty/serial/8250/8250_port.c:3456
 console_emit_next_record kernel/printk/printk.c:3138 [inline]
 console_flush_all+0x728/0xc40 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 bt_err+0x10b/0x160 net/bluetooth/lib.c:296
 hci_cmd_timeout+0xff/0x1e0 net/bluetooth/hci_core.c:1475
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
