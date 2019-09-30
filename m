Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0343C32792
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 22:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98304218DE
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 22:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfI3WjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:39:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:45380 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfI3WjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 18:39:14 -0400
Received: by mail-io1-f69.google.com with SMTP id o11so33180041iop.12
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 15:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Mm23RPk3oeYYCPUBhTV9cqnjpR3WFLEojN5++EyBzhk=;
        b=tx6wcdNrRmQPUB5GY1B2lkha8995y5+pU6s5KWhWmKgk44JX4bhEAyqkZVLccVQKFZ
         cSogOE3oQsRBOh14PdNtIgKokGgokSxl6i/jYDZCJozcy4bolWRbWPkjbliFmUmTCkeM
         0e3xF8WiItNJUDBIAwqM8C4sq2eLCiId4Wg0Vf4FrvN2PdDfDszGEKnpX+Y862toECtu
         tblDwCSOx8AaBdRRqNNfDp1iNojotHt10sk6/focVqtNcbCelQhyA0dRxj3iujbO2Kx+
         0tZfjZshIOi7D6cnJjV/d9m1DxRbjTCDlUZD9wn99jo24uy2+2uieSPJI4315CSGf+Dl
         viTA==
X-Gm-Message-State: APjAAAUnMSgRXXT4qS5pMt0+UH8XilQYxyjD8zFRT6Fr6skBKMcrs3Hd
        UxvJtaVyuipAE29Qaehr97cHefQ9GH9zJTjz0Iof04xgZJhG
X-Google-Smtp-Source: APXvYqyZYofbeX0XN0FynGEsjt0Gw8NXHV/8emyEk2oS/rrVLHcVqmALm7ql9TC7pSrxRbMoGjlIuQVjO9Hfvxhm3qoG6ofPcUei
MIME-Version: 1.0
X-Received: by 2002:a6b:d307:: with SMTP id s7mr24161536iob.39.1569883153343;
 Mon, 30 Sep 2019 15:39:13 -0700 (PDT)
Date:   Mon, 30 Sep 2019 15:39:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1b1ee0593cce78f@google.com>
Subject: INFO: task hung in nbd_ioctl
From:   syzbot <syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchristi@redhat.com,
        nbd@other.debian.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bb2aee77 Add linux-next specific files for 20190926
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13385ca3600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e60af4ac5a01e964
dashboard link: https://syzkaller.appspot.com/bug?extid=24c12fa8d218ed26011a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12abc2a3600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11712c05600000

The bug was bisected to:

commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
Author: Mike Christie <mchristi@redhat.com>
Date:   Sun Aug 4 19:10:06 2019 +0000

     nbd: fix max number of supported devs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1226f3c5600000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1126f3c5600000
console output: https://syzkaller.appspot.com/x/log.txt?x=1626f3c5600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com
Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")

INFO: task syz-executor390:8778 can't die for more than 143 seconds.
syz-executor390 D27432  8778   8777 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x828/0x1c20 kernel/sched/core.c:4065
  schedule+0xd9/0x260 kernel/sched/core.c:4132
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
  flush_workqueue+0x40f/0x14c0 kernel/workqueue.c:2826
  nbd_start_device_ioctl drivers/block/nbd.c:1272 [inline]
  __nbd_ioctl drivers/block/nbd.c:1347 [inline]
  nbd_ioctl+0xb2e/0xc44 drivers/block/nbd.c:1387
  __blkdev_driver_ioctl block/ioctl.c:304 [inline]
  blkdev_ioctl+0xedb/0x1c20 block/ioctl.c:606
  block_ioctl+0xee/0x130 fs/block_dev.c:1954
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:539 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:726
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:743
  __do_sys_ioctl fs/ioctl.c:750 [inline]
  __se_sys_ioctl fs/ioctl.c:748 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:748
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4452d9
Code: Bad RIP value.
RSP: 002b:00007ffde928d288 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004452d9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000004025b0 R09: 00000000004025b0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402520
R13: 00000000004025b0 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor390:8778 blocked for more than 143 seconds.
       Not tainted 5.3.0-next-20190926 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor390 D27432  8778   8777 0x00004004
Call Trace:
  context_switch kernel/sched/core.c:3384 [inline]
  __schedule+0x828/0x1c20 kernel/sched/core.c:4065
  schedule+0xd9/0x260 kernel/sched/core.c:4132
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1871
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
  flush_workqueue+0x40f/0x14c0 kernel/workqueue.c:2826
  nbd_start_device_ioctl drivers/block/nbd.c:1272 [inline]
  __nbd_ioctl drivers/block/nbd.c:1347 [inline]
  nbd_ioctl+0xb2e/0xc44 drivers/block/nbd.c:1387
  __blkdev_driver_ioctl block/ioctl.c:304 [inline]
  blkdev_ioctl+0xedb/0x1c20 block/ioctl.c:606
  block_ioctl+0xee/0x130 fs/block_dev.c:1954
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:539 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:726
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:743
  __do_sys_ioctl fs/ioctl.c:750 [inline]
  __se_sys_ioctl fs/ioctl.c:748 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:748
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4452d9
Code: Bad RIP value.
RSP: 002b:00007ffde928d288 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00000000004452d9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00000000004025b0 R09: 00000000004025b0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402520
R13: 00000000004025b0 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1066:
  #0: ffffffff88faad80 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5337
2 locks held by kworker/u5:0/1525:
  #0: ffff8880923d0d28 ((wq_completion)knbd0-recv){+.+.}, at:  
__write_once_size include/linux/compiler.h:226 [inline]
  #0: ffff8880923d0d28 ((wq_completion)knbd0-recv){+.+.}, at:  
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
  #0: ffff8880923d0d28 ((wq_completion)knbd0-recv){+.+.}, at: atomic64_set  
include/asm-generic/atomic-instrumented.h:855 [inline]
  #0: ffff8880923d0d28 ((wq_completion)knbd0-recv){+.+.}, at:  
atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
  #0: ffff8880923d0d28 ((wq_completion)knbd0-recv){+.+.}, at: set_work_data  
kernel/workqueue.c:620 [inline]
  #0: ffff8880923d0d28 ((wq_completion)knbd0-recv){+.+.}, at:  
set_work_pool_and_clear_pending kernel/workqueue.c:647 [inline]
  #0: ffff8880923d0d28 ((wq_completion)knbd0-recv){+.+.}, at:  
process_one_work+0x88b/0x1740 kernel/workqueue.c:2240
  #1: ffff8880a63b7dc0 ((work_completion)(&args->work)){+.+.}, at:  
process_one_work+0x8c1/0x1740 kernel/workqueue.c:2244
1 lock held by rsyslogd/8659:
2 locks held by getty/8749:
  #0: ffff888098c08090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f112e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8750:
  #0: ffff88808f10b090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f2d2e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8751:
  #0: ffff88809a6be090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f192e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8752:
  #0: ffff8880a48af090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f352e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8753:
  #0: ffff88808c599090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f212e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8754:
  #0: ffff88808f1a8090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f392e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156
2 locks held by getty/8755:
  #0: ffff88809ab33090 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:340
  #1: ffffc90005f012e0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1c10 drivers/tty/n_tty.c:2156

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1066 Comm: khungtaskd Not tainted 5.3.0-next-20190926 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x70/0xb2 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x23b/0x28b lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:269 [inline]
  watchdog+0xc99/0x1360 kernel/hung_task.c:353
  kthread+0x361/0x430 kernel/kthread.c:255
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
