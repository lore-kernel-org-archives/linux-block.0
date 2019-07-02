Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F22C06510
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 15:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449FC206A3
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 15:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfGBP1H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:27:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:38319 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfGBP1H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 11:27:07 -0400
Received: by mail-io1-f71.google.com with SMTP id h4so19287989iol.5
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 08:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Oirv5tvI28Y/2P5/D//E+9UIAiSWk3he7f7mxriBA74=;
        b=MlZRf5jL7NKD4QxK94XYnHX/Ygv7OymNtTjUKTr3gHas78qnwUWtIyD3gH54mPTnec
         J4yiEO+a1fEa47SC/M3ORYq9HCx0xt+1UFArKUbJp5Hq24cIji6PV9/BQ+RO84r2+47Y
         twG6EYTvRROc4gC6YHC/Fwrt+8X5Q14AlQM0swCcWOq6J5j/MihgQ2rLDOwKEInNM6SM
         1uNYhe8z5LiEhWsmTfOgBIImENtRU+jC6g1sKtwdOXladUH+beuiQYRV6Y+ZPxGZA5m4
         bWC2LweoMht086uj+9FFjwHI/iAUwgEpzEYWueyYw83HL1QYg4BKrtKiUf5ghFqTL7Yx
         Tmmw==
X-Gm-Message-State: APjAAAUExAe1kIr/NUvmcgFEw8fN8GPHHz2MtAlC7CYFzyb1hlZgcOjm
        fnQhoXCxYdCGykieFi1Xxltgt5Scb0a391mIQgMjqHTw4dC4
X-Google-Smtp-Source: APXvYqxv7gu3pohlc+pqZedRwSU1QtjtXvFgV65KO/my/6TNLIFWUpJYb7nr2EHYtPwt+AXGX/E7tONzTUI3iR4Wl++AExbA3uMe
MIME-Version: 1.0
X-Received: by 2002:a5d:8f99:: with SMTP id l25mr1214309iol.92.1562081226426;
 Tue, 02 Jul 2019 08:27:06 -0700 (PDT)
Date:   Tue, 02 Jul 2019 08:27:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c93d5058cb46073@google.com>
Subject: INFO: task hung in blkdev_issue_flush (2)
From:   syzbot <syzbot+e7624af9c1ef3b617512@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, idryomov@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sagi@grimberg.me, snitzer@redhat.com,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        wgh@torlan.ru, zkabelac@redhat.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6fbc7275 Linux 5.2-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1218ee83a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6451f0da3d42d53
dashboard link: https://syzkaller.appspot.com/bug?extid=e7624af9c1ef3b617512
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13105d6da00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120c261ba00000

The bug was bisected to:

commit a32e236eb93e62a0f692e79b7c3c9636689559b9
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri Aug 3 19:22:09 2018 +0000

     Partially revert "block: fail op_is_write() requests to read-only  
partitions"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fc732ba00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12fc732ba00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14fc732ba00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e7624af9c1ef3b617512@syzkaller.appspotmail.com
Fixes: a32e236eb93e ("Partially revert "block: fail op_is_write() requests  
to read-only partitions"")

INFO: task syz-executor485:8568 blocked for more than 143 seconds.
       Not tainted 5.2.0-rc7 #46
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor485 D28528  8568   8564 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:2818 [inline]
  __schedule+0x7cb/0x1560 kernel/sched/core.c:3445
  schedule+0xa8/0x260 kernel/sched/core.c:3509
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1783
  io_schedule_timeout+0x26/0x80 kernel/sched/core.c:5119
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common_io kernel/sched/completion.c:121 [inline]
  wait_for_completion_io+0x29c/0x440 kernel/sched/completion.c:169
  submit_bio_wait+0x11d/0x1c0 block/bio.c:1003
  blkdev_issue_flush+0x20d/0x300 block/blk-flush.c:449
  blkdev_fsync+0x95/0xd0 fs/block_dev.c:687
  vfs_fsync_range+0x141/0x230 fs/sync.c:197
  vfs_fsync fs/sync.c:211 [inline]
  do_fsync+0x54/0xa0 fs/sync.c:221
  __do_sys_fdatasync fs/sync.c:234 [inline]
  __se_sys_fdatasync fs/sync.c:232 [inline]
  __x64_sys_fdatasync+0x36/0x50 fs/sync.c:232
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x449749
Code: Bad RIP value.
RSP: 002b:00007fa817de2ce8 EFLAGS: 00000246 ORIG_RAX: 000000000000004b
RAX: ffffffffffffffda RBX: 00000000006dac58 RCX: 0000000000449749
RDX: 0000000000449749 RSI: 0000000000000000 RDI: 0000000000000009
RBP: 00000000006dac50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac5c
R13: 00007fff567b6b5f R14: 00007fa817de39c0 R15: 20c49ba5e353f7cf

Showing all locks held in the system:
1 lock held by khungtaskd/1043:
  #0: 00000000f7c610b3 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5149
2 locks held by rsyslogd/8451:
  #0: 00000000dfc1566f (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
  #1: 0000000054220207 (&rq->lock){-.-.}, at: rq_lock  
kernel/sched/sched.h:1168 [inline]
  #1: 0000000054220207 (&rq->lock){-.-.}, at: __schedule+0x1f5/0x1560  
kernel/sched/core.c:3397
2 locks held by getty/8541:
  #0: 000000004ff543bd (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000002a3905f3 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8542:
  #0: 000000006e67fcec (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000ee71e4f3 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8543:
  #0: 00000000bd0907a0 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000000876abce (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8544:
  #0: 00000000710d6f7d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000af289586 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8545:
  #0: 000000003399e62d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000ee97f91a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8546:
  #0: 00000000ff2274c6 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000b96c5a9f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8547:
  #0: 000000005165f028 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000e89d5b4a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1043 Comm: khungtaskd Not tainted 5.2.0-rc7 #46
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
  watchdog+0x9b7/0xec0 kernel/hung_task.c:289
  kthread+0x354/0x420 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0 skipped: idling at native_safe_halt+0xe/0x10  
arch/x86/include/asm/irqflags.h:60


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
