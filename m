Return-Path: <SRS0=7JbN=AR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227CFC433DF
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07BA5206CD
	for <linux-block@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgGFPWg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:22:36 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:52934 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729415AbgGFPW2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Jul 2020 11:22:28 -0400
Received: by mail-il1-f197.google.com with SMTP id o17so20270042ilt.19
        for <linux-block@vger.kernel.org>; Mon, 06 Jul 2020 08:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=hXaLsIT3Tx3nT+zfmLLoY9e6JwD3KiiSDXuXDtLB5AQ=;
        b=EXaV6EYB4yJhKuz3JQHXVw+Vq7IWIWvPhT12zlOHjfUAr52aK2VrHG+KitiH2bzOs+
         gxwN3K4iknBXulEbTwH+F2dINeC7H4uI446AJX3Hx8+BvDKLjGXHfFHYps3l7pbz/guX
         KtW5D0F6yZwOe5t7h8EtZI4gBp35L2v3F+CipLiTXHU6YQy7dacIAAOxVzuMHzotrWdn
         bahJMY93Q51+y76QY33TqXwjbU4NFNyyIoK6Hdvo+4HQVa9xWRRZIc0YXC2DenZUa7Xn
         jTFdE5O5NnkwDrFkvtDylQD8PMeeervOwEjMs4UmtuNlGv+e7XUEouuOXc2mNjr7rcgn
         KKEg==
X-Gm-Message-State: AOAM531QvVthvy5L7qDqhCNtOzyd8N7mSVSOzBQzV/Gs8+WrlvYwYRL2
        Aq2efvOrPejnJo2ak5o9NY76aMfudHcc+zIoX6B3BmElT+wW
X-Google-Smtp-Source: ABdhPJzYLAvt/2K6zOopO0TuBu83mFpeZcmafRuTqB1RqWdGV8knHtuQRg+1FaERE2T3cRDyD7+xIqnyqRIn31RMAvOKnBGNtLd2
MIME-Version: 1.0
X-Received: by 2002:a02:3501:: with SMTP id k1mr52940514jaa.133.1594048947151;
 Mon, 06 Jul 2020 08:22:27 -0700 (PDT)
Date:   Mon, 06 Jul 2020 08:22:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003feb9805a9c77128@google.com>
Subject: INFO: task hung in nbd_ioctl (2)
From:   syzbot <syzbot+e36f41d207137b5d12f7@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1124dead100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=e36f41d207137b5d12f7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e36f41d207137b5d12f7@syzkaller.appspotmail.com

INFO: task syz-executor.1:13143 blocked for more than 143 seconds.
      Not tainted 5.7.0-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.1  D27616 13143   6943 0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3430 [inline]
 __schedule+0x8f3/0x1fc0 kernel/sched/core.c:4156
 schedule+0xd0/0x2a0 kernel/sched/core.c:4231
 schedule_timeout+0x55b/0x850 kernel/time/timer.c:1873
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x16a/0x270 kernel/sched/completion.c:138
 flush_workqueue+0x403/0x14f0 kernel/workqueue.c:2831
 nbd_start_device_ioctl drivers/block/nbd.c:1322 [inline]
 __nbd_ioctl drivers/block/nbd.c:1397 [inline]
 nbd_ioctl+0x7ae/0xb7f drivers/block/nbd.c:1437
 __blkdev_driver_ioctl block/ioctl.c:224 [inline]
 blkdev_ioctl+0x25e/0x6c0 block/ioctl.c:620
 block_ioctl+0xf9/0x140 fs/block_dev.c:1987
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl+0x11a/0x180 fs/ioctl.c:771
 __do_sys_ioctl fs/ioctl.c:780 [inline]
 __se_sys_ioctl fs/ioctl.c:778 [inline]
 __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:778
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45ca59
Code: Bad RIP value.
RSP: 002b:00007fc5b74b2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004e98c0 RCX: 000000000045ca59
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000415 R14: 00000000004c6d6f R15: 00007fc5b74b36d4

Showing all locks held in the system:
1 lock held by khungtaskd/1147:
 #0: ffffffff899bdd80 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:5779
2 locks held by kworker/u5:0/1521:
 #0: ffff888097167138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: __write_once_size include/linux/compiler.h:279 [inline]
 #0: ffff888097167138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888097167138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff888097167138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff888097167138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff888097167138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff888097167138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: process_one_work+0x844/0x16a0 kernel/workqueue.c:2239
 #1: ffffc90005357dc0 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work+0x878/0x16a0 kernel/workqueue.c:2243
1 lock held by in:imklog/6476:
2 locks held by agetty/6489:
 #0: ffff88809ebb3098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:267
 #1: ffffc90000eb42e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x220/0x1b30 drivers/tty/n_tty.c:2156

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1147 Comm: khungtaskd Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1e6/0x221 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xa8c/0x1010 kernel/hung_task.c:289
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 3858 Comm: systemd-journal Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:getname_flags fs/namei.c:150 [inline]
RIP: 0010:getname_flags+0x122/0x5b0 fs/namei.c:128
Code: 03 80 3c 02 00 0f 85 be 01 00 00 4c 89 f7 4d 89 34 24 ba e0 0f 00 00 48 89 de e8 e9 f1 ec 01 31 ff 49 89 c6 89 c6 89 44 24 04 <e8> a9 67 b2 ff 45 85 f6 0f 88 9e 01 00 00 e8 fb 65 b2 ff 44 89 f6
RSP: 0018:ffffc90001627df8 EFLAGS: 00000246
RAX: 000000000000001c RBX: 000055e1d31c89a3 RCX: ffffffff83ae5c52
RDX: 0000000000000000 RSI: 000000000000001c RDI: 0000000000000000
RBP: 0000000000000001 R08: ffff888094f5a480 R09: ffff8880aa1ec000
R10: 000000000000001c R11: fffff9400053f070 R12: ffff8880a7e0e940
R13: 0000000000000000 R14: 000000000000001c R15: ffffffff8a8b9b48
FS:  00007fb1526cd8c0(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb14fb8c000 CR3: 0000000094814000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 user_path_at_empty+0x2a/0x50 fs/namei.c:2632
 user_path_at include/linux/namei.h:59 [inline]
 do_faccessat+0x12c/0x830 fs/open.c:423
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7fb1519899c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe422e0be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007ffe422e3b00 RCX: 00007fb1519899c7
RDX: 00007fb1523faa00 RSI: 0000000000000000 RDI: 000055e1d31c89a3
RBP: 00007ffe422e0c20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffe422e3b00 R15: 00007ffe422e1110


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
