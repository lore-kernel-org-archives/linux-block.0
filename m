Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B87C433F5
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 15:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF61A610F8
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 15:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhKRPtV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:49:21 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:54113 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhKRPtU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Nov 2021 10:49:20 -0500
Received: by mail-il1-f198.google.com with SMTP id g11-20020a056e021a2b00b0026ef3cb57beso4288042ile.20
        for <linux-block@vger.kernel.org>; Thu, 18 Nov 2021 07:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=r3G9eWiEPF61cNJax6flr3yrlZpg5PXCRWyesFfunPs=;
        b=1k+ZOa7XBwcQsGgO4vEVX3SsfAFeYNUOevxrN7uyldPGKEuV5hwD4EoecHR8C9uODK
         CmhhWOi22DkENarZZoQ5CnJk5TCRdOcI2md9AAsUBVjZ7hw/mQFLHZp+09eUIHsKqP+Z
         OUlssQ9IY38iDfInqgP08dhcnFXDLgpGAxL5aokV5ulMNBslktQHyL+3qcizoJtoi1NF
         qhUZLqVlzxkgazXa/6bMbqllmG5k85GUhPgyaS9iO/W22tDeb8oBdbzu6aolMe/bnkMc
         8Nj0GYO75hn0aHxwGiGCZYqykex/OyG7M7NH8GsU4dyFgTCI96zB4jLYOjXzEnyrJyrS
         G1LQ==
X-Gm-Message-State: AOAM5316cO2k9VFrLp+KQLI+eEIVLq4ZS5Zw2sS9huDCuhwG1xYLIVDI
        +f1+qWWIpwOpJbiLVoiSOnD9eSqtxuJ6qcdoQeL8NFfqIP9A
X-Google-Smtp-Source: ABdhPJwaub4l7zb3MSK8LUd+zPkWHsyjgfMRJWXFFTUz7dQXHYLP+LmL9fAhMBJPFAOwxupHPP3VxBhx3uLHHPwZPiN9LbIbZtV5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1607:: with SMTP id x7mr21588561jas.27.1637250380163;
 Thu, 18 Nov 2021 07:46:20 -0800 (PST)
Date:   Thu, 18 Nov 2021 07:46:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000516cc305d1120f44@google.com>
Subject: [syzbot] INFO: task hung in loop_set_status
From:   syzbot <syzbot+62ab33bb3f09cebaf3cf@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    42eb8fdac2fc Merge tag 'gfs2-v5.16-rc2-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105e0ca1b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c3ab72998e7f1a4
dashboard link: https://syzkaller.appspot.com/bug?extid=62ab33bb3f09cebaf3cf
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+62ab33bb3f09cebaf3cf@syzkaller.appspotmail.com

INFO: task syz-executor.5:24868 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:22960 pid:24868 ppid: 12949 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0x105/0x190 block/blk-mq.c:178
 loop_set_status+0x22f/0xa50 drivers/block/loop.c:1264
 lo_ioctl+0xbc9/0x1f40
 blkdev_ioctl+0x3ac/0x790 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0caf979ae9
RSP: 002b:00007f0caceef188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0cafa8cf60 RCX: 00007f0caf979ae9
RDX: 0000000020000440 RSI: 0000000000004c02 RDI: 0000000000000006
RBP: 00007f0caf9d3f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc4c42f58f R14: 00007f0caceef300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8cd1db00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by in:imklog/6208:
 #0: ffff88801d65d770 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x24e/0x2f0 fs/file.c:990
1 lock held by syz-executor.5/24868:
 #0: ffff88801ace9b60 (&lo->lo_mutex){+.+.}-{3:3}, at: loop_set_status+0x2a/0xa50 drivers/block/loop.c:1248
2 locks held by systemd-udevd/24918:
 #0: ffff88801acee118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0xb80 block/bdev.c:819
 #1: ffff88801ace9b60 (&lo->lo_mutex){+.+.}-{3:3}, at: lo_open+0x68/0x100 drivers/block/loop.c:1733

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x45f/0x490 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc82/0xcd0 kernel/hung_task.c:295
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 33 Comm: khugepaged Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:check_prev_add kernel/locking/lockdep.c:3101 [inline]
RIP: 0010:check_prevs_add kernel/locking/lockdep.c:3186 [inline]
RIP: 0010:validate_chain+0x35a1/0x8240 kernel/locking/lockdep.c:3801
Code: 04 5b 48 c1 e0 06 48 8d 80 00 db ae 8f 48 83 c0 30 49 39 c7 0f 84 59 e4 ff ff 49 8d 5f 10 48 89 d8 48 c1 e8 03 42 80 3c 20 00 <74> 08 48 89 df e8 55 52 69 00 4c 8b 33 48 8b 44 24 68 42 0f b6 04
RSP: 0018:ffffc9000109efe0 EFLAGS: 00000046
RAX: 1ffffffff215a323 RBX: ffffffff90ad1918 RCX: ffffffff8166efd8
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff901a6ee0
RBP: ffffc9000109f2f0 R08: dffffc0000000000 R09: fffffbfff2034ddd
R10: fffffbfff2034ddd R11: 0000000000000000 R12: dffffc0000000000
R13: ffffc9000109f1f0 R14: ffffffff8faee100 R15: ffffffff90ad1908
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f00bfc28000 CR3: 000000007edff000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
 _raw_spin_lock_nested+0x2d/0x40 kernel/locking/spinlock.c:368
 raw_spin_rq_lock_nested+0x25/0x110 kernel/sched/core.c:478
 raw_spin_rq_lock kernel/sched/sched.h:1316 [inline]
 rq_lock kernel/sched/sched.h:1614 [inline]
 __schedule+0x194/0x1460 kernel/sched/core.c:6167
 preempt_schedule_irq+0xf7/0x1c0 kernel/sched/core.c:6668
 irqentry_exit+0x56/0x90 kernel/entry/common.c:425
 asm_sysvec_reschedule_ipi+0x12/0x20
RIP: 0010:lock_acquire+0x21f/0x4d0 kernel/locking/lockdep.c:5641
Code: 08 4c 89 f7 e8 32 6a 6a 00 f6 84 24 81 00 00 00 02 0f 85 13 02 00 00 41 f7 c4 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 04 2f 00 00 00 00 43 c7 44 2f 09 00 00 00 00 43 c7 44 2f 11
RSP: 0018:ffffc9000109f8e0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000213f2c RCX: ffff888012440a58
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000109fa40 R08: dffffc0000000000 R09: fffffbfff2034de3
R10: fffffbfff2034de3 R11: 0000000000000000 R12: 0000000000000246
R13: 1ffff92000213f24 R14: ffffc9000109f960 R15: dffffc0000000000
 start_flush_work+0x613/0x860 kernel/workqueue.c:3057
 __flush_work+0x123/0x1b0 kernel/workqueue.c:3083
 __lru_add_drain_all+0x8d3/0x9d0 mm/swap.c:848
 khugepaged_do_scan+0xd1/0x640 mm/khugepaged.c:2222
 khugepaged+0xf5/0x890 mm/khugepaged.c:2283
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
----------------
Code disassembly (best guess):
   0:	04 5b                	add    $0x5b,%al
   2:	48 c1 e0 06          	shl    $0x6,%rax
   6:	48 8d 80 00 db ae 8f 	lea    -0x70512500(%rax),%rax
   d:	48 83 c0 30          	add    $0x30,%rax
  11:	49 39 c7             	cmp    %rax,%r15
  14:	0f 84 59 e4 ff ff    	je     0xffffe473
  1a:	49 8d 5f 10          	lea    0x10(%r15),%rbx
  1e:	48 89 d8             	mov    %rbx,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
* 2a:	74 08                	je     0x34 <-- trapping instruction
  2c:	48 89 df             	mov    %rbx,%rdi
  2f:	e8 55 52 69 00       	callq  0x695289
  34:	4c 8b 33             	mov    (%rbx),%r14
  37:	48 8b 44 24 68       	mov    0x68(%rsp),%rax
  3c:	42                   	rex.X
  3d:	0f                   	.byte 0xf
  3e:	b6 04                	mov    $0x4,%dh


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
