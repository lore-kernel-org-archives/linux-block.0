Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03E0C55ABD
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 16:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554C820797
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 16:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725866AbgKMQ2O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:28:14 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:49101 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKMQ2N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Nov 2020 11:28:13 -0500
Received: by mail-io1-f71.google.com with SMTP id r16so6761006ioc.15
        for <linux-block@vger.kernel.org>; Fri, 13 Nov 2020 08:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7AM+kSWVRwQyYcxrui6SCyL6DLKfBRVJuynLqycUlx8=;
        b=XF2o3fxzJ0nFquXAt/28pvKz47plTLH8AHmdRmdH3AEBbd4fvoi0ki1qApeiN9fjWS
         6mIWkWsD7VI0b7jRAKkGF6k0wKGAR3XysHgU9KT4GJBwDOwnTh7O4UXX3csfOoWj6z57
         duxKKpRSArN0qr+0K9GZ/VtE8mr2OnhkdpoIVx0+OUdiTYNn9y5eEKf+g/6+vhA82ed2
         IWU5k07h0lIBSg+M/3YwGHNHAJEHKfzyns0JI4q94+Fke8Qw6kUIQ19ecssa6QRE10GS
         c7zzW6XSet1jQZ0V3B+NgFtceKz3Yo6vLVX3nFodq1u6D/GA7mY1IvCYYFOfo1n66nOL
         u0oA==
X-Gm-Message-State: AOAM531x9fVWr08zBHsbstKXFjk+BexqUp353shRR4SQOU6EmxBycB/X
        9WLOo6yiO6bkfqrQdZyXHX2+PrdRWhCt9ppu0lDGPzAVgpFf
X-Google-Smtp-Source: ABdhPJyM6NhJ4FtjqW9LmRhesunVwTi4uzDHZbage4ISfyRLnauWIBc8Lsl4gAzWKkRx/8TeP7G3lvRwks8993nR2rFr+ilCDRAR
MIME-Version: 1.0
X-Received: by 2002:a6b:e012:: with SMTP id z18mr409588iog.157.1605284890251;
 Fri, 13 Nov 2020 08:28:10 -0800 (PST)
Date:   Fri, 13 Nov 2020 08:28:10 -0800
In-Reply-To: <CACT4Y+YrLRueFzXqNrWcy5ic-TsAJz393G+fg_4x1zfMo061oQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a597d705b3ff83bb@google.com>
Subject: Re: INFO: task can't die in nbd_ioctl
From:   syzbot <syzbot+69a90a5e8f6b59086b2a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, dvyukov@google.com, josef@toxicpanda.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com,
        tom.leiming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task can't die in nbd_ioctl

INFO: task syz-executor.1:10354 can't die for more than 143 seconds.
task:syz-executor.1  state:D stack:28664 pid:10354 ppid:  8887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3773 [inline]
 __schedule+0x893/0x2170 kernel/sched/core.c:4522
 schedule+0xcf/0x270 kernel/sched/core.c:4600
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1847
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 flush_workqueue+0x3ff/0x13e0 kernel/workqueue.c:2835
 nbd_start_device_ioctl drivers/block/nbd.c:1331 [inline]
 __nbd_ioctl drivers/block/nbd.c:1408 [inline]
 nbd_ioctl+0x76d/0xbe0 drivers/block/nbd.c:1448
 __blkdev_driver_ioctl block/ioctl.c:228 [inline]
 blkdev_ioctl+0x28b/0x700 block/ioctl.c:623
 block_ioctl+0xf9/0x140 fs/block_dev.c:1869
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45deb9
Code: Unable to access opcode bytes at RIP 0x45de8f.
RSP: 002b:00007fa187726c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000012f00 RCX: 000000000045deb9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 000000000118c000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfd4
R13: 00007fff019bb39f R14: 00007fa1877279c0 R15: 000000000118bfd4
INFO: task syz-executor.1:10354 blocked for more than 143 seconds.
      Not tainted 5.10.0-rc1-next-20201030-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:28664 pid:10354 ppid:  8887 flags:0x00004004
Call Trace:
 context_switch kernel/sched/core.c:3773 [inline]
 __schedule+0x893/0x2170 kernel/sched/core.c:4522
 schedule+0xcf/0x270 kernel/sched/core.c:4600
 schedule_timeout+0x1d8/0x250 kernel/time/timer.c:1847
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x163/0x260 kernel/sched/completion.c:138
 flush_workqueue+0x3ff/0x13e0 kernel/workqueue.c:2835
 nbd_start_device_ioctl drivers/block/nbd.c:1331 [inline]
 __nbd_ioctl drivers/block/nbd.c:1408 [inline]
 nbd_ioctl+0x76d/0xbe0 drivers/block/nbd.c:1448
 __blkdev_driver_ioctl block/ioctl.c:228 [inline]
 blkdev_ioctl+0x28b/0x700 block/ioctl.c:623
 block_ioctl+0xf9/0x140 fs/block_dev.c:1869
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45deb9
Code: Unable to access opcode bytes at RIP 0x45de8f.
RSP: 002b:00007fa187726c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000012f00 RCX: 000000000045deb9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 000000000118c000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bfd4
R13: 00007fff019bb39f R14: 00007fa1877279c0 R15: 000000000118bfd4

Showing all locks held in the system:
1 lock held by khungtaskd/1655:
 #0: ffffffff8b337f60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6253
2 locks held by in:imklog/8188:
 #0: ffff88801a8bb270 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:932
 #1: ffffffff8b337f60 (rcu_read_lock){....}-{1:2}, at: rq_lock kernel/sched/sched.h:1292 [inline]
 #1: ffffffff8b337f60 (rcu_read_lock){....}-{1:2}, at: ttwu_queue kernel/sched/core.c:2694 [inline]
 #1: ffffffff8b337f60 (rcu_read_lock){....}-{1:2}, at: try_to_wake_up+0x535/0x1300 kernel/sched/core.c:2974
2 locks held by kworker/u5:3/8900:
 #0: ffff888028f71138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888028f71138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: atomic64_set include/asm-generic/atomic-instrumented.h:856 [inline]
 #0: ffff888028f71138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff888028f71138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:616 [inline]
 #0: ffff888028f71138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: ffff888028f71138 ((wq_completion)knbd1-recv){+.+.}-{0:0}, at: process_one_work+0x821/0x15a0 kernel/workqueue.c:2243
 #1: ffffc90001c6fda8 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work+0x854/0x15a0 kernel/workqueue.c:2247

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1655 Comm: khungtaskd Not tainted 5.10.0-rc1-next-20201030-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:147 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:253 [inline]
 watchdog+0xd89/0xf30 kernel/hung_task.c:338
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 8713 Comm: kworker/1:4 Not tainted 5.10.0-rc1-next-20201030-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:__lock_acquire+0xa/0x5590 kernel/locking/lockdep.c:4689
Code: 09 ed 8c e8 b8 f7 5b 00 e9 46 ff ff ff 48 c7 c7 58 09 ed 8c e8 a7 f7 5b 00 e9 58 fe ff ff 66 90 41 57 41 89 cf 41 56 49 89 fe <41> 55 41 89 d5 41 54 55 89 f5 53 44 89 c3 48 81 ec e8 00 00 00 48
RSP: 0018:ffffc9000242f9d8 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 1ffff92000485f44 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801019fb60
RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
R10: fffffbfff19d9af1 R11: 0000000024d1c2bd R12: 0000000000000000
R13: ffff88801019fb60 R14: ffff88801019fb60 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f8f8f2000 CR3: 00000000117bd000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 lock_acquire kernel/locking/lockdep.c:5436 [inline]
 lock_acquire+0x1af/0x8b0 kernel/locking/lockdep.c:5401
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:159
 _crng_backtrack_protect+0x71/0x1a0 drivers/char/random.c:1045
 crng_backtrack_protect drivers/char/random.c:1063 [inline]
 _get_random_bytes+0x295/0x670 drivers/char/random.c:1564
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:533 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:562 [inline]
 nsim_dev_trap_report_work+0x74e/0xbd0 drivers/net/netdevsim/dev.c:603
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3af/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


Tested on:

commit:         4e78c578 Add linux-next specific files for 20201030
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next-history.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15118af6500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83318758268dc331
dashboard link: https://syzkaller.appspot.com/bug?extid=69a90a5e8f6b59086b2a
compiler:       gcc (GCC) 10.1.0-syz 20200507

