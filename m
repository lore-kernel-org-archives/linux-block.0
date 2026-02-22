Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EED1F4634
	for <linux-block@vger.kernel.org>; Sun, 22 Feb 2026 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771768594; cv=none; b=Na1JdWiS9gsdz6jaYP72JS6SD1spQce5OrGvgKhomYUzYxYKzbljeHzxNieOO9DrHCnprNy8beXo2K79PaZi35BJ7S54pm5X1kWt4m+4jsV3hcMWKf4f93F1WambzsJLDtsJEnlgHL/AIcRm+fayoGiO9ME+743Tmtoi1eeAV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771768594; c=relaxed/simple;
	bh=aLGyszScfG88zpJsmh6m2O8SPGz8HKCUg+QV7+eH6h0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JgaXVuH9hqAPuzy4EGDT5LKQBy6RDazhHW0PUq4tweIGLL8wKIS3oLcDDmM0nAITMw7ri8e+QRHMI1fj/8vZWQm02l3xgCi50KiQjImzQb7DGVGWq2XuM6LmSpBp8okIF69Lh4HWCogMJ4mkIJ1P/kLrGzIBcQS1nifv0ZJFH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d1950b48f3so46453679a34.0
        for <linux-block@vger.kernel.org>; Sun, 22 Feb 2026 05:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771768591; x=1772373391;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jZWVlXHYWsZX0/4ugwKb6I3934vSiG3kuLXU5AEmWwk=;
        b=uY+HqT02tvZYiXQ7ppgTVC8IKkfaADXRqq7EGsW1ME2HhN1O/CG2/pPMkIFNQuNsB2
         8osKwaZI+Bsxxvc6UkhE9sxntmSubD47coJ+2Lk2gLvdlPEIv8l3V66TQmMcSBhys2D9
         1ipRKa5ApB2NTmdNei1YLWuAJv4BZi13dRLsJ04ioA58zxZk3X4lHmhfk/FFvhgT9cdx
         XoncP2ymK6Fri/PIoj9xRtfB1BgA2ato6ToqjkgJwSdbaDySEjLo7g5pGnwwI2dvXB1/
         hkEde5VmxDfZBp8BrC9KSOuHmGat3Crsl9HnJJ4L+BTK7QHWjYfevtxrWKkJTQ3VJNj+
         j0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVlK2Vf79HIVD/cVxcdMbz7mgJpd7Hg8Ow4g/YU9/McqkF4EO1bTk8yC2VauyFcgx8YALPhaL81i9QcEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fMlZHVTkQdU+g5kHQX3sUDP980imbgNWlrbE5pbiJRTvJzQI
	lWeGsKgbIyxS09sGeBEKtBU6HxjPODT+XCwVDnCadz8GydkhdiUPl/usnCZlHF9ndQIKghnQwwa
	PS0dIsUtNgjivciRvDFWurVs3lnuUuUjxeMu/GOB7lh5oTXYE14Q+HGAoorM=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178b:b0:679:a527:2a5 with SMTP id
 006d021491bc7-679c4268230mr3697529eaf.24.1771768591373; Sun, 22 Feb 2026
 05:56:31 -0800 (PST)
Date: Sun, 22 Feb 2026 05:56:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <699b0b0f.a70a0220.2c38d7.017a.GAE@google.com>
Subject: [syzbot] [block?] INFO: task hung in blkdev_write_iter
From: syzbot <syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2961f841b025 Merge tag 'turbostat-2026.02.14' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14776722580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=665cbf0979cda6c5
dashboard link: https://syzkaller.appspot.com/bug?extid=d31a3b77e5cba96b9f69
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1246effa580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1532695a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c0f9ea6efef0/disk-2961f841.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f9c7c51af597/vmlinux-2961f841.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b4664a55988/bzImage-2961f841.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com

INFO: task syz.0.17:6033 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:23944 pid:6033  tgid:6032  ppid:5951   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0x1585/0x5340 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7004
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7061
 rwsem_down_read_slowpath+0x61e/0x920 kernel/locking/rwsem.c:1086
 __down_read_common kernel/locking/rwsem.c:1261 [inline]
 __down_read kernel/locking/rwsem.c:1274 [inline]
 down_read+0x99/0x2e0 kernel/locking/rwsem.c:1539
 inode_lock_shared include/linux/fs.h:1043 [inline]
 blkdev_write_iter+0x50b/0x710 block/fops.c:801
 iter_file_splice_write+0x99b/0x1100 fs/splice.c:738
 do_splice_from fs/splice.c:938 [inline]
 direct_splice_actor+0x101/0x160 fs/splice.c:1161
 splice_direct_to_actor+0x53a/0xc70 fs/splice.c:1105
 do_splice_direct_actor fs/splice.c:1204 [inline]
 do_splice_direct+0x195/0x290 fs/splice.c:1230
 do_sendfile+0x535/0x7d0 fs/read_write.c:1372
 __do_sys_sendfile64 fs/read_write.c:1433 [inline]
 __se_sys_sendfile64+0x144/0x1a0 fs/read_write.c:1419
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0b3a59c629
RSP: 002b:00007f0b3b4e0028 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f0b3a815fa0 RCX: 00007f0b3a59c629
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 00007f0b3a632b39 R08: 0000000000000000 R09: 0000000000000000
R10: 000400000000003f R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0b3a816038 R14: 00007f0b3a815fa0 R15: 00007ffe34502d38
 </TASK>

Showing all locks held in the system:
1 lock held by ksoftirqd/1/23:
 #0: ffff8880b873ade0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x31/0x150 kernel/sched/core.c:647
1 lock held by khungtaskd/31:
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff8e7602e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
2 locks held by getty/5585:
 #0: ffff8880370010a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000331e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x45c/0x13c0 drivers/tty/n_tty.c:2211
1 lock held by syz.0.17/6033:
 #0: ffff88802384aa28 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:1043 [inline]
 #0: ffff88802384aa28 (&sb->s_type->i_mutex_key#11){++++}-{4:4}, at: blkdev_write_iter+0x50b/0x710 block/fops.c:801
3 locks held by syz.0.17/6036:
4 locks held by syz-executor/13728:

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xfd9/0x1030 kernel/hung_task.c:515
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 1331 Comm: kworker/u8:9 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:switch_mm_irqs_off+0x354/0x690 arch/x86/include/asm/bitops.h:-1
Code: 93 4c 39 e0 0f 85 9d 00 00 00 e9 8f 01 00 00 83 fd 08 0f 83 0d 02 00 00 4c 89 f7 be 08 00 00 00 e8 21 3d b7 00 f0 4d 0f ab 27 <48> 8b 6c 24 10 4c 8d b3 b8 08 00 00 4c 89 f7 be 08 00 00 00 e8 d3
RSP: 0018:ffffc90005d6f710 EFLAGS: 00000056
RAX: 0000000000000001 RBX: ffff88813fe38c40 RCX: ffffffff8178590f
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88813fe397c0
RBP: 0000000000000001 R08: ffff88813fe397c7 R09: 1ffff11027fc72f8
R10: dffffc0000000000 R11: ffffed1027fc72f9 R12: 0000000000000001
R13: dffffc0000000000 R14: ffff88813fe397c0 R15: ffff88813fe397c0
FS:  0000000000000000(0000) GS:ffff888125566000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3561456b8 CR3: 000000000e54c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 use_temporary_mm+0x98/0x140 arch/x86/mm/tlb.c:1029
 __text_poke+0x632/0x9a0 arch/x86/kernel/alternative.c:2581
 text_poke arch/x86/kernel/alternative.c:2645 [inline]
 smp_text_poke_batch_finish+0xd36/0x1160 arch/x86/kernel/alternative.c:3034
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x128/0x240 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate+0xab/0x290 mm/kfence/core.c:899
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xb02/0x1830 kernel/workqueue.c:3358
 worker_thread+0xa50/0xfc0 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
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
