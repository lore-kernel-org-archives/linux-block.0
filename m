Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBECC433F5
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 01:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E056161B6F
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 01:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhKRBOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbhKRBOH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 20:14:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497B5C061570;
        Wed, 17 Nov 2021 17:11:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so4145869pjb.1;
        Wed, 17 Nov 2021 17:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=D6R/MJICvRLVnEzyvFZEeGjtwBpaND/THRSeYnjqFZM=;
        b=c+UmB/aehv4MZlRIvcFrOzo76QT326SkBQ8dlRZNyapUkuZwCydY3aSWHn9YxZovlP
         tuwqntJfvuJ2veXmdRQjHSmEj0n/gdQrQP2VtDBNlZlxUBMMUGICJY5TfDy//Ri/Z3FB
         2ktt4eIiwHr3jekwYsBgbbFxVXFyW2++UXdij6AF1q0xP5QRlE48isDPevApwT1sPvk+
         t2giMEjVbaQwCDGCreIiDB7GqnCpuVH9JJW2NRHtMaOqOuVVxnJAZFc7K3BpPRjqd95H
         SMzfFLmw2aXjnH5UAc9ArWOEmBbl2EkcMLSbQ40yxNxz5352Ts3UI7zfO7F5HrGcKdVD
         u/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D6R/MJICvRLVnEzyvFZEeGjtwBpaND/THRSeYnjqFZM=;
        b=GElQHzCqAkxggl6pFCaGcpv5CRyVeHRw2JRUC96d1YUhd/n7D3V0xJvt56HvKGB3cM
         z5k1+647KxFTBAVhmEw49ar8UKssZKdP6P7r6cu04EofWvljzn2t4DcUUvitqfyoLmjh
         G0qZH0k7u5G1JGplASpxUDRGOo8Nc6RtKVQ1SnDAh3eVAQ8h6YEZ3QoKmulrs6YpdspQ
         SqeNZHgqzZgXhS7tBCbbXHa/eqyu2dl6JRUHLWLp1IJLh2AlrV56L4V7b9Kf5tl6Wbxa
         dAQvzr5pzVgAHuydN0Zk9Q6fPJevfsO2U7J2OWOjSCbayw8mhcvkDmOjn0zMNWCbMhQG
         ezxg==
X-Gm-Message-State: AOAM531bBCpiHS0JXv1WovNjApMZrSgH1+wLah3BkoYqrDJOlxmY9rLm
        TAlfNox9sNOwwUnyP6mzkOrp1WpopXpPoXp9w7eLt3rgRbRM0JTLGw==
X-Google-Smtp-Source: ABdhPJx5leTgmUxod9rHXJPAEb6daGzSw08jslWvNdQ1Wjkglq2c8tH5RFS67pC7L69Z2nMPZHRr1SjNNF2Y47ImbtU=
X-Received: by 2002:a17:90b:3b83:: with SMTP id pc3mr5352186pjb.106.1637197867758;
 Wed, 17 Nov 2021 17:11:07 -0800 (PST)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Thu, 18 Nov 2021 09:10:55 +0800
Message-ID: <CACkBjsbmCGnS37q8Z2H_eRJMYhPJBzN2OsEfn4Cx+D2mfbm=KQ@mail.gmail.com>
Subject: INFO: task hung in __loop_clr_fd
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 8ab774587903 Merge tag 'trace-v5.16-5'
git tree: upstream
console output: https://paste.ubuntu.com/p/hjFJMh2mcT/plain/
kernel config: https://paste.ubuntu.com/p/cFf8tS9V8w/plain/
C reproducer: https://paste.ubuntu.com/p/hyHTmH5JtP/plain/
Syzlang reproducer: https://paste.ubuntu.com/p/GqttBp86F8/plain/

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:7502 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1+ #7
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:24440 pid: 7502 ppid:  6632 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 __loop_clr_fd+0x1ae/0x1080 drivers/block/loop.c:1122
 loop_clr_fd drivers/block/loop.c:1237 [inline]
 lo_ioctl+0x398/0x1680 drivers/block/loop.c:1562
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f41609fb9db
RSP: 002b:00007f415df63a68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000020000180 RCX: 00007f41609fb9db
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000006
RBP: 00007f415df646bc R08: 00007f415df63b00 R09: 0000000020000100
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000016 R14: 00007f415df63ac0 R15: 0000000020000680
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/39:
 #0: ffffffff8bb80a60 (rcu_read_lock){....}-{1:2}, at:
debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6333:
 #0: ffff88810634e170 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0xe9/0x100 fs/file.c:990
1 lock held by syz-executor/7502:
 #0: ffff8880198ccb60 (&lo->lo_mutex){+.+.}-{3:3}, at:
__loop_clr_fd+0x7a/0x1080 drivers/block/loop.c:1106
2 locks held by syz-executor/9352:
 #0: ffff8880198d9118 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev block/bdev.c:819 [inline]
 #0: ffff8880198d9118 (&disk->open_mutex){+.+.}-{3:3}, at:
blkdev_get_by_dev+0x39a/0x8d0 block/bdev.c:792
 #1: ffff8880198ccb60 (&lo->lo_mutex){+.+.}-{3:3}, at:
lo_open+0x75/0x120 drivers/block/loop.c:1733

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 39 Comm: khungtaskd Not tainted 5.16.0-rc1+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 0 to CPUs 1-3:
NMI backtrace for cpu 2
CPU: 2 PID: 7532 Comm: kworker/u8:3 Not tainted 5.16.0-rc1+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: bat_events batadv_nc_worker
RIP: 0010:debug_lockdep_rcu_enabled+0x23/0x30 kernel/rcu/update.c:280
Code: cc cc cc cc cc cc cc 8b 05 7a ae 41 04 85 c0 74 21 8b 05 ac e1
41 04 85 c0 74 17 65 48 8b 04 25 40 70 02 00 8b 80 1c 0a 00 00 <85> c0
0f 94 c0 0f b6 c0 c3 cc cc cc cc 41 54 55 48 c7 c5 50 aa 03
RSP: 0018:ffffc900080cfb90 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffffc900080cfbc8 RCX: ffffffff815c72b1
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffc900080cfbc8
RBP: 1ffff92001019f85 R08: ffffffff88eba16a R09: fffffbfff1b210c3
R10: ffffffff8d908617 R11: fffffbfff1b210c2 R12: ffffffff8bb80a60
R13: 0000000000000048 R14: dffffc0000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff888063f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558c721da758 CR3: 0000000106d0a000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 rcu_read_lock_held_common+0x9/0x90 kernel/rcu/update.c:104
 rcu_read_lock_sched_held+0x5a/0xd0 kernel/rcu/update.c:123
 trace_lock_release include/trace/events/lock.h:58 [inline]
 lock_release+0x4e6/0x670 kernel/locking/lockdep.c:5648
 rcu_lock_release include/linux/rcupdate.h:273 [inline]
 rcu_read_unlock include/linux/rcupdate.h:721 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:416 [inline]
 batadv_nc_worker+0x1dd/0x770 net/batman-adv/network-coding.c:723
 process_one_work+0x9df/0x16d0 kernel/workqueue.c:2298
 worker_thread+0x90/0xed0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
NMI backtrace for cpu 3 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 3 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 3 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:733
NMI backtrace for cpu 1
CPU: 1 PID: 3045 Comm: systemd-journal Not tainted 5.16.0-rc1+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:__lock_acquire+0x198/0x57e0 kernel/locking/lockdep.c:4930
Code: 90 83 e2 07 83 c2 03 89 44 24 18 40 38 f2 7c 09 40 84 f6 0f 85
97 14 00 00 44 8b 25 b2 e8 ef 0e 45 85 e4 75 0b 83 7c 24 18 2f <0f> 87
b8 12 00 00 49 8d bd 20 0a 00 00 48 81 eb 60 1d f7 8f 48 b8
RSP: 0018:ffffc900012dfac0 EFLAGS: 00000097
RAX: 0000000000000000 RBX: ffffffff8ff7bea0 RCX: 0000000000000000
RDX: 0000000000000003 RSI: 0000000000000004 RDI: ffff88801b07ede0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff8d908617 R11: fffffbfff1b210c2 R12: 0000000000000000
R13: ffff888016d18000 R14: ffff88801b07edd8 R15: 0000000000000000
FS:  00007f28184058c0(0000) GS:ffff888135c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f281578e050 CR3: 000000001b577000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5637 [inline]
 lock_acquire+0x1ab/0x520 kernel/locking/lockdep.c:5602
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 alloc_fd+0x6e/0x660 fs/file.c:477
 do_sys_openat2+0x490/0x9a0 fs/open.c:1210
 do_sys_open+0xc3/0x140 fs/open.c:1228
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f2817995840
Code: 73 01 c3 48 8b 0d 68 77 20 00 f7 d8 64 89 01 48 83 c8 ff c3 66
0f 1f 44 00 00 83 3d 89 bb 20 00 00 75 10 b8 02 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 31 c3 48 83 ec 08 e8 1e f6 ff ff 48 89 04 24
RSP: 002b:00007ffd65ddf8f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007ffd65ddfc00 RCX: 00007f2817995840
RDX: 00000000000001a0 RSI: 0000000000080042 RDI: 0000557a9fff42a0
RBP: 000000000000000d R08: 000000000000ffc0 R09: 00000000ffffffff
R10: 0000000000000069 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000557a9ffe9040 R14: 00007ffd65ddfbc0 R15: 0000557a9fff5a20
 </TASK>
----------------
Code disassembly (best guess):
   0:    cc                       int3
   1:    cc                       int3
   2:    cc                       int3
   3:    cc                       int3
   4:    cc                       int3
   5:    cc                       int3
   6:    cc                       int3
   7:    8b 05 7a ae 41 04        mov    0x441ae7a(%rip),%eax        # 0x441ae87
   d:    85 c0                    test   %eax,%eax
   f:    74 21                    je     0x32
  11:    8b 05 ac e1 41 04        mov    0x441e1ac(%rip),%eax        # 0x441e1c3
  17:    85 c0                    test   %eax,%eax
  19:    74 17                    je     0x32
  1b:    65 48 8b 04 25 40 70     mov    %gs:0x27040,%rax
  22:    02 00
  24:    8b 80 1c 0a 00 00        mov    0xa1c(%rax),%eax
* 2a:    85 c0                    test   %eax,%eax <-- trapping instruction
  2c:    0f 94 c0                 sete   %al
  2f:    0f b6 c0                 movzbl %al,%eax
  32:    c3                       retq
  33:    cc                       int3
  34:    cc                       int3
  35:    cc                       int3
  36:    cc                       int3
  37:    41 54                    push   %r12
  39:    55                       push   %rbp
  3a:    48                       rex.W
  3b:    c7                       .byte 0xc7
  3c:    c5 50 aa                 (bad)
  3f:    03                       .byte 0x3
