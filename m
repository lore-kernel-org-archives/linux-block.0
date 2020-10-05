Return-Path: <SRS0=syOM=DM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46017C4727E
	for <linux-block@archiver.kernel.org>; Mon,  5 Oct 2020 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBC320756
	for <linux-block@archiver.kernel.org>; Mon,  5 Oct 2020 07:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgJEHUT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:20:19 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:33823 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEHUT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Oct 2020 03:20:19 -0400
Received: by mail-il1-f207.google.com with SMTP id f89so3703728ill.1
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2020 00:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=kzMGDAH+V64bIGovKN39nOfSz9YJKwgFw2a9Jzw6lbo=;
        b=ewy80oOOVftvYitfKhD2kyoQAS7kI3NWmXt7+DeZiK5w24yo9SIoRF7twocLmHjYfs
         +TYK4vUT7FZL8cyoag2wcEpDDsljU5d73QhI3OwzjhUQFQN3ovdV5sI1fWn2VZPga56k
         S8/4HwJ9mHI+hWZ+1X1x1DIFAvuDxP5kkPgXil0vFVqzv9kQ9FS95H40yDnBjRX5E1BZ
         NsVvjRgAYc3NwqHUYZc0806gS/C/IbRsgPG5w7vPi1jXqVCXTjhuzlEE0HR4+DOeukeo
         8lmzZhNhCg0Up0lkfT+wcDqR3KAY9jkg+D9rrU9M0SHWs93xbEnBgHF6KkqXDfMxyRWZ
         a7FQ==
X-Gm-Message-State: AOAM533SZc58Y5eHh3oDD1sE06oq3BGhriXzrTKBRrEFuKLsNLvvKr1F
        LaVatnA4047PsYrf9+cLtvhcNXvj/fxnAauI+g35CBldfl92
X-Google-Smtp-Source: ABdhPJzHc7LVZOCZAe7g5aj4GBJ7rRwimuX126H26qnDxJRMqenI7HGdF5mcdb3iRGA9LvHkbRA9iwL0CesW9xIpX3Fobe/vf572
MIME-Version: 1.0
X-Received: by 2002:a5e:9e49:: with SMTP id j9mr2604544ioq.107.1601882416032;
 Mon, 05 Oct 2020 00:20:16 -0700 (PDT)
Date:   Mon, 05 Oct 2020 00:20:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061316205b0e750fc@google.com>
Subject: INFO: task can't die in nbd_ioctl
From:   syzbot <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    de69ee6d Add linux-next specific files for 20200930
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10d04f17900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4919771fba5919e5
dashboard link: https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com

INFO: task syz-executor.0:4417 can't die for more than 143 seconds.
task:syz-executor.0  state:D stack:28472 pid: 4417 ppid:  6852 flags:0x10004004
Call Trace:
 context_switch kernel/sched/core.c:3777 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4526
 schedule+0xcf/0x270 kernel/sched/core.c:4604
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 flush_workqueue+0x3ff/0x13e0 kernel/workqueue.c:2832
 nbd_start_device_ioctl drivers/block/nbd.c:1331 [inline]
 __nbd_ioctl drivers/block/nbd.c:1408 [inline]
 nbd_ioctl+0x76d/0xbe0 drivers/block/nbd.c:1448
 __blkdev_driver_ioctl block/ioctl.c:228 [inline]
 blkdev_ioctl+0x2a7/0x7f0 block/ioctl.c:623
 block_ioctl+0xf9/0x140 fs/block_dev.c:1866
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45dd99
Code: Bad RIP value.
RSP: 002b:00007f39f37eac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000012e80 RCX: 000000000045dd99
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 000000000118bf58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007fff8753a28f R14: 00007f39f37eb9c0 R15: 000000000118bf2c
INFO: task syz-executor.0:4417 blocked for more than 144 seconds.
      Not tainted 5.9.0-rc7-next-20200930-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:28472 pid: 4417 ppid:  6852 flags:0x10004004
Call Trace:
 context_switch kernel/sched/core.c:3777 [inline]
 __schedule+0xec5/0x2200 kernel/sched/core.c:4526
 schedule+0xcf/0x270 kernel/sched/core.c:4604
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1855
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 flush_workqueue+0x3ff/0x13e0 kernel/workqueue.c:2832
 nbd_start_device_ioctl drivers/block/nbd.c:1331 [inline]
 __nbd_ioctl drivers/block/nbd.c:1408 [inline]
 nbd_ioctl+0x76d/0xbe0 drivers/block/nbd.c:1448
 __blkdev_driver_ioctl block/ioctl.c:228 [inline]
 blkdev_ioctl+0x2a7/0x7f0 block/ioctl.c:623
 block_ioctl+0xf9/0x140 fs/block_dev.c:1866
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45dd99
Code: Bad RIP value.
RSP: 002b:00007f39f37eac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000012e80 RCX: 000000000045dd99
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 000000000118bf58 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 00007fff8753a28f R14: 00007f39f37eb9c0 R15: 000000000118bf2c

Showing all locks held in the system:
1 lock held by khungtaskd/1178:
 #0: ffffffff8a553d00 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6221
1 lock held by in:imklog/6557:
 #0: ffff8880a0a526b0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:930
2 locks held by kworker/u5:2/6867:
 #0: ffff888093c7f138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888093c7f138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888093c7f138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888093c7f138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888093c7f138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888093c7f138 ((wq_completion)knbd0-recv){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2240
 #1: ffffc900017b7da8 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2244

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1178 Comm: khungtaskd Not tainted 5.9.0-rc7-next-20200930-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fb lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:339
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6835 Comm: syz-fuzzer Not tainted 5.9.0-rc7-next-20200930-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0033:0x415b7a
Code: 89 ac 24 c8 00 00 00 48 8d ac 24 c8 00 00 00 48 8b 94 24 e0 00 00 00 48 83 fa 08 0f 84 4d 09 00 00 48 8b 1d 98 4a 5a 01 84 03 <90> 48 8b b4 24 d8 00 00 00 48 bf 00 00 00 00 00 80 00 00 48 8d 04
RSP: 002b:000000c026e52b98 EFLAGS: 00000246
RAX: 000000c026e52c18 RBX: 00007f1f2ef8f000 RCX: 000000c000083980
RDX: 0000000000000030 RSI: 0000000000000000 RDI: 0000000000000030
RBP: 000000c026e52c60 R08: 00000000008f7880 R09: 0000000000203000
R10: 000000c011bb4cf0 R11: 0000000000000001 R12: ffffffffffffffff
R13: 0000000000000046 R14: 0000000000000045 R15: 00000000000000aa
FS:  0000000001992df0 GS:  0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
