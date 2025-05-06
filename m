Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041D726989A
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746525931; cv=none; b=HXkM7Hg0l2+HdO7CkeBGeSNClF5qcu0kpoADaXXxxcuEsa6MAiuoED04PnyEPaNm6hVv0BFrgMEXiR3xAk90RwYxs9Nk1je+W+JkfPRSHAS34bdnQF6deuHI239H4BCtFJAoqlKgPel86VES9VXbjX2Wa/L+OoTxgNqx+tBYy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746525931; c=relaxed/simple;
	bh=mbaqMlGgn0O2m1V1FsJrdner0BCcF8u6WbMVG6mnqXo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=o7u/VohjmKK9gQtSqG/PZyM1V1lcNC3B5g2SCYUs5mws3Lw5OK61v2aoBjuc5470WTN0rw5Bnj0v79KjUoBahZmpIKzqIUQVfVcPoWEdJYf16edZDp3XqUmLMyJv51wCbR3ipiN2X7Xt6jKhySS8vnr6qVx2Pef6ficCSjVq5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85b4ee2e69bso604814339f.2
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 03:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746525929; x=1747130729;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAnScUYl7mbKpNFlUShHyzhwIQ4t1swm+4ckWItM8S4=;
        b=CiS4m+gudlj82JUKzLL2dAsjWaOsp6S/68C5ivWZJZBy3ceLEsV5D9pcTg/gXGbeV+
         aAl29cqeW4B5Qo1/AQyUo6mkoYbixAVe7bmvIz+HpjLrVeiAt5D9bHY6QGIF1thUPPTH
         zWxX0wCeKszEMuBToJk9vQHnKqVM6qw8YeOsYUctw7KUb2+aV0NEr7JAiBy0pEIXvhFc
         MrcXdO5TAXb60xnMUl99xyIpuVfoUUnNYXXD6axuSNV6HVQ7qYaGAmq0+qXg6U8DjS8r
         NWjw2MTPUvGcZRZ34HgfCpzb7s6F0vK/700rx0n35yivIJPQStgZSn+gsOMTE5wKW6Jb
         Jfxw==
X-Forwarded-Encrypted: i=1; AJvYcCXan1vq1XabeQT6oydR0jBKGKb+utMurzASE0u066QKYfT9CYkW+LD7r2J2bTdLCS138INKA1lQik4Kag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6Kn6cew/kItchKXceOOV5mzywM/M+wnEsuEvq+/K+uwbagaV
	BT/PhtGePqSwBin0zaubrYzdzw9rglHE0HO2SOtXKMSSFiEOYrCjw63WDidFj76qCJJtcsl6EXL
	KCf29Ryw76jZ2WjSPpELzuxJ4MsEGbyCDTSp/5XrCM8nJEnI+QYiuajU=
X-Google-Smtp-Source: AGHT+IEukJL442XIymUOtyI4u9zTAa7kkoADVWnoWKwfqZHG7bU1VDsXZykx+E23/MtJeL3A3lEoU+DBQKM1XoPpyJSQC/PPKaYA
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152f:b0:3d0:4e57:bbda with SMTP id
 e9e14a558f8ab-3da6cdc61a6mr27910065ab.1.1746525929006; Tue, 06 May 2025
 03:05:29 -0700 (PDT)
Date: Tue, 06 May 2025 03:05:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6819dee8.050a0220.a19a9.0008.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in blkdev_read_iter
From: syzbot <syzbot+afa7aef0c237038586e7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ebd297a2affa Merge tag 'net-6.15-rc5' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=137ab774580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=afa7aef0c237038586e7
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177ab774580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ed0b68580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f2a7906b8354/disk-ebd297a2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f84d6953ac72/vmlinux-ebd297a2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/24673ab81bd7/bzImage-ebd297a2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afa7aef0c237038586e7@syzkaller.appspotmail.com

INFO: task syz-executor467:5849 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor467 state:D stack:26936 pid:5849  tgid:5849  ppid:5839   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 rwsem_down_read_slowpath+0x552/0x880 kernel/locking/rwsem.c:1084
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x98/0x2e0 kernel/locking/rwsem.c:1526
 inode_lock_shared include/linux/fs.h:877 [inline]
 blkdev_read_iter+0x2f8/0x440 block/fops.c:808
 aio_read+0x30e/0x470 fs/aio.c:1602
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x6ec/0x1240 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x185/0x2f0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbea1957ea9
RSP: 002b:00007ffe0d65d0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000200000000080 RCX: 00007fbea1957ea9
RDX: 00002000000000c0 RSI: 00000000000000ca RDI: 00007fbea1910000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe0d65d110
R13: 00007ffe0d65d130 R14: 000000000001a993 R15: 00007ffe0d65d10c
 </TASK>
INFO: task syz-executor467:5850 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor467 state:D stack:26936 pid:5850  tgid:5850  ppid:5841   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 rwsem_down_read_slowpath+0x552/0x880 kernel/locking/rwsem.c:1084
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x98/0x2e0 kernel/locking/rwsem.c:1526
 inode_lock_shared include/linux/fs.h:877 [inline]
 blkdev_read_iter+0x2f8/0x440 block/fops.c:808
 aio_read+0x30e/0x470 fs/aio.c:1602
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x6ec/0x1240 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x185/0x2f0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbea1957ea9
RSP: 002b:00007ffe0d65d0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000200000000080 RCX: 00007fbea1957ea9
RDX: 00002000000000c0 RSI: 00000000000000ca RDI: 00007fbea1910000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe0d65d110
R13: 00007ffe0d65d130 R14: 000000000001a9ab R15: 00007ffe0d65d10c
 </TASK>
INFO: task syz-executor467:5851 blocked for more than 144 seconds.
      Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor467 state:D stack:26936 pid:5851  tgid:5851  ppid:5842   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 rwsem_down_read_slowpath+0x552/0x880 kernel/locking/rwsem.c:1084
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x98/0x2e0 kernel/locking/rwsem.c:1526
 inode_lock_shared include/linux/fs.h:877 [inline]
 blkdev_read_iter+0x2f8/0x440 block/fops.c:808
 aio_read+0x30e/0x470 fs/aio.c:1602
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x6ec/0x1240 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x185/0x2f0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbea1957ea9
RSP: 002b:00007ffe0d65d0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000200000000080 RCX: 00007fbea1957ea9
RDX: 00002000000000c0 RSI: 00000000000000ca RDI: 00007fbea1910000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe0d65d110
R13: 00007ffe0d65d130 R14: 000000000001a9b9 R15: 00007ffe0d65d10c
 </TASK>
INFO: task syz-executor467:5852 blocked for more than 144 seconds.
      Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor467 state:D stack:26936 pid:5852  tgid:5852  ppid:5844   task_flags:0x400040 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x16e2/0x4cd0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 rwsem_down_read_slowpath+0x552/0x880 kernel/locking/rwsem.c:1084
 __down_read_common kernel/locking/rwsem.c:1248 [inline]
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x98/0x2e0 kernel/locking/rwsem.c:1526
 inode_lock_shared include/linux/fs.h:877 [inline]
 blkdev_read_iter+0x2f8/0x440 block/fops.c:808
 aio_read+0x30e/0x470 fs/aio.c:1602
 __io_submit_one fs/aio.c:-1 [inline]
 io_submit_one+0x6ec/0x1240 fs/aio.c:2052
 __do_sys_io_submit fs/aio.c:2111 [inline]
 __se_sys_io_submit+0x185/0x2f0 fs/aio.c:2081
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbea1957ea9
RSP: 002b:00007ffe0d65d0f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 0000200000000080 RCX: 00007fbea1957ea9
RDX: 00002000000000c0 RSI: 00000000000000ca RDI: 00007fbea1910000
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe0d65d110
R13: 00007ffe0d65d130 R14: 000000000001a9bf R15: 00007ffe0d65d10c
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8df3b860 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6764
2 locks held by getty/5585:
 #0: ffff88802ffee0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000333b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
2 locks held by syz-executor467/5848:
1 lock held by syz-executor467/5849:
 #0: ffff8880228887a0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:877 [inline]
 #0: ffff8880228887a0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:808
1 lock held by syz-executor467/5850:
 #0: ffff8880228887a0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:877 [inline]
 #0: ffff8880228887a0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:808
1 lock held by syz-executor467/5851:
 #0: ffff8880228887a0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:877 [inline]
 #0: ffff8880228887a0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:808
1 lock held by syz-executor467/5852:
 #0: ffff8880228887a0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:877 [inline]
 #0: ffff8880228887a0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}, at: blkdev_read_iter+0x2f8/0x440 block/fops.c:808

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:437
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 13 Comm: kworker/u8:1 Not tainted 6.15.0-rc4-syzkaller-00147-gebd297a2affa #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:mark_held_locks kernel/locking/lockdep.c:4323 [inline]
RIP: 0010:__trace_hardirqs_on_caller kernel/locking/lockdep.c:4344 [inline]
RIP: 0010:lockdep_hardirqs_on_prepare+0x107/0x2a0 kernel/locking/lockdep.c:4411
Code: f0 0a 00 00 45 31 ff 4d 89 f4 eb 13 49 ff c7 48 63 83 e8 0a 00 00 49 83 c4 28 49 39 c7 7d 44 49 83 ff 31 73 2d 41 8b 44 24 20 <a9> 00 00 04 00 74 db 25 00 00 03 00 83 f8 01 ba 03 00 00 00 83 da
RSP: 0018:ffffc900001276c0 EFLAGS: 00000087
RAX: 0000000000050003 RBX: ffff88801c6e0000 RCX: ffffffff931e7578
RDX: 0000000000000002 RSI: ffff88801c6e0b18 RDI: ffff88801c6e0000
RBP: ffffc90000127860 R08: ffffffff8f7ed377 R09: 1ffffffff1efda6e
R10: dffffc0000000000 R11: fffffbfff1efda6f R12: ffff88801c6e0b40
R13: dffffc0000000000 R14: ffff88801c6e0af0 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8881261cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564f24f42600 CR3: 000000000dd36000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 trace_hardirqs_on+0x28/0x40 kernel/trace/trace_preemptirq.c:78
 smp_call_function_many_cond+0xac1/0x11c0 kernel/smp.c:877
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1052
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2455 [inline]
 text_poke_bp_batch+0x84d/0x940 arch/x86/kernel/alternative.c:-1
 text_poke_flush arch/x86/kernel/alternative.c:2856 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2863
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x128/0x250 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate+0xad/0x240 mm/kfence/core.c:850
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
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
