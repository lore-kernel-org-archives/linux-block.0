Return-Path: <SRS0=cicp=DF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83B1C2D0A8
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994012080C
	for <linux-block@archiver.kernel.org>; Mon, 28 Sep 2020 07:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1HR0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:17:26 -0400
Received: from mail-il1-f206.google.com ([209.85.166.206]:40312 "EHLO
        mail-il1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgI1HR0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Sep 2020 03:17:26 -0400
Received: by mail-il1-f206.google.com with SMTP id e9so77112ils.7
        for <linux-block@vger.kernel.org>; Mon, 28 Sep 2020 00:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cw8IfAAyf9/YqndxElsygNT0dvulcAEoPctFJ4YZ6ak=;
        b=rpoBLHQgO/EAla++jW4O0kppOlgrIdlhdfhwl4MvPyD/Sgig3a4LCENRrcBbcCOjAO
         xzw4NMiFGw3JRGvtp3WC663hQttkz1iceQ939KOhMMbvtpU8PrVzGiqRzFcJLrXRrCWO
         7s3S0pCY0HhPe4kEAy5irlX0Xedpc2vuO8W8Ges7W3plOKPApS9F/Jml7lynIe0VG8Ht
         PiZpBq88Gaa2G6pk1OyKQuvC7u6g/go8rDLgmmNbXFxfA/ZCYdJdEWq2XMP3dpv/8YNX
         tnUUTFlJAGYjwKKbdwRkIdnCYW7R2D7LF8JDxnYJO9KlGC2QwFBuFFzMbc1nD020KKrW
         yyLg==
X-Gm-Message-State: AOAM533UPmCxgG9R3Spb2Rb+RT3qOnROmhUSh2qTNPCPiwp+kD4SHVG1
        Frrqu47woOuapfc6WXgYEUiiX17z4yI/FYMXteD7k+qXcw1Z
X-Google-Smtp-Source: ABdhPJy1U0w0Qhqx6Eawi88isJ0zTwFz5Rsf+DRl/PZBz5ABtzt5mgySuK6QfvEUX9NHFsaZFbmThNRU6sPhuLqALy5QW7y/RhDs
MIME-Version: 1.0
X-Received: by 2002:a92:d20b:: with SMTP id y11mr82654ily.132.1601277444906;
 Mon, 28 Sep 2020 00:17:24 -0700 (PDT)
Date:   Mon, 28 Sep 2020 00:17:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a624a05b05a756d@google.com>
Subject: INFO: task hung in nbd_ioctl (3)
From:   syzbot <syzbot+fe03c50d25c0188f7487@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a1bffa48 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1106c3d3900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=240e2ebab67245c7
dashboard link: https://syzkaller.appspot.com/bug?extid=fe03c50d25c0188f7487
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134bb14b900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fe03c50d25c0188f7487@syzkaller.appspotmail.com

INFO: task syz-executor.0:12689 blocked for more than 143 seconds.
      Not tainted 5.9.0-rc6-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28544 pid:12689 ppid:  6920 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3778 [inline]
 __schedule+0xec9/0x2280 kernel/sched/core.c:4527
 schedule+0xd0/0x2a0 kernel/sched/core.c:4602
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 flush_workqueue+0x3ff/0x13e0 kernel/workqueue.c:2832
 nbd_start_device_ioctl drivers/block/nbd.c:1330 [inline]
 __nbd_ioctl drivers/block/nbd.c:1407 [inline]
 nbd_ioctl+0x7ac/0xbc4 drivers/block/nbd.c:1447
 __blkdev_driver_ioctl block/ioctl.c:224 [inline]
 blkdev_ioctl+0x28c/0x700 block/ioctl.c:620
 block_ioctl+0xf9/0x140 fs/block_dev.c:1871
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45e179
Code: Bad RIP value.
RSP: 002b:00007f67f9e2bc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000012e80 RCX: 000000000045e179
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 000000000118d020 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cff4
R13: 00007fff04dc253f R14: 00007f67f9e2c9c0 R15: 000000000118cff4

Showing all locks held in the system:
1 lock held by khungtaskd/1170:
 #0: ffffffff8a067f40 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5852
2 locks held by systemd-journal/3919:
2 locks held by in:imklog/6562:
 #0: ffff88809765b170 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
 #1: ffff8880ae435e18 (&rq->lock){-.-.}-{2:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #1: ffff8880ae435e18 (&rq->lock){-.-.}-{2:2}, at: __schedule+0x287/0x2280 kernel/sched/core.c:4445
2 locks held by kworker/u5:5/6940:
 #0: ffff88809ee0e138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88809ee0e138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff88809ee0e138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88809ee0e138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff88809ee0e138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff88809ee0e138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: process_one_work+0x82b/0x1670 kernel/workqueue.c:2240
 #1: ffffc90005e77da8 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work+0x85f/0x1670 kernel/workqueue.c:2244

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1170 Comm: khungtaskd Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1b3/0x223 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:209 [inline]
 watchdog+0xd7d/0x1000 kernel/hung_task.c:295
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3919 Comm: systemd-journal Not tainted 5.9.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:rcu_lockdep_current_cpu_online kernel/rcu/tree.c:1162 [inline]
RIP: 0010:rcu_lockdep_current_cpu_online+0x83/0x120 kernel/rcu/tree.c:1152
Code: 3c 02 00 0f 85 92 00 00 00 48 03 1c ed 00 69 cb 89 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 18 48 89 fa 48 c1 ea 03 80 3c 02 00 <75> 79 48 8d 7b 20 48 8b 6b 18 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc90005287ee0 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffff8880ae536c00 RCX: ffffffff817c170d
RDX: 1ffff11015ca6d83 RSI: 0000000000000002 RDI: ffff8880ae536c18
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8b59688f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffffffff88264678 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f0056f198c0(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0054483020 CR3: 0000000092420000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 rcu_read_lock_held_common kernel/rcu/update.c:123 [inline]
 rcu_read_lock_held_common kernel/rcu/update.c:113 [inline]
 rcu_read_lock_sched_held+0x25/0xb0 kernel/rcu/update.c:134
 trace_irq_disable include/trace/events/preemptirq.h:36 [inline]
 trace_hardirqs_off_finish kernel/trace/trace_preemptirq.c:67 [inline]
 trace_hardirqs_off_finish+0x26b/0x2d0 kernel/trace/trace_preemptirq.c:61
 enter_from_user_mode kernel/entry/common.c:30 [inline]
 syscall_enter_from_user_mode+0x18/0x60 kernel/entry/common.c:95
 do_syscall_64+0xf/0x70 arch/x86/entry/common.c:41
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f00561e32e3
Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 83 3d 29 54 2b 00 00 75 13 49 89 ca b8 e8 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 34 c3 48 83 ec 08 e8 0b c2 00 00 48 89 04 24
RSP: 002b:00007ffd636fe6f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e8
RAX: ffffffffffffffda RBX: 000056459af4d1e0 RCX: 00007f00561e32e3
RDX: 0000000000000013 RSI: 00007ffd636fe700 RDI: 0000000000000008
RBP: 00007ffd636fe8f0 R08: 000056459af57a60 R09: 00007ffd637f8080
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd636fe700
R13: 0000000000000001 R14: ffffffffffffffff R15: 0005b057a90e6ccf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
