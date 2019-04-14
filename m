Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E994EC10F13
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 11:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3AD7218D3
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 11:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDNL2F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 07:28:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48053 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNL2F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 07:28:05 -0400
Received: by mail-io1-f71.google.com with SMTP id b199so11856243iof.14
        for <linux-block@vger.kernel.org>; Sun, 14 Apr 2019 04:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=769YfXKssij9gZTfBkexrYXVFn8YvgOBBOpY/r95PmU=;
        b=GvVIJ0GVqnVgyxApYyHuFi8DgkEiA4Cl9nOPYCFgjQKJnExh997ZY1As0BolnM5CmK
         HS5LVZhuyyRC/CeRV+Od5RYf96DHUUCsyyTDPpN4l8bXjHOFsjLMWDDOx93NcFHcBe+v
         OXB1V7LQdDt5XCD1xln9hNQ65fhKv+yf73ApcAMbgc1elc9Oqd39vPyHuDCRdDcxjfY2
         Dbvnxlgu1wae9vNY65T/LV/JF4rLzEICj/wtLIXm9or7sQa31Rpua/1SW5owMkD4w6Hh
         fBIJLZSX8M0uhMftGgLjq7oQnEPrE9+tHsvUteWJiHApUsGBXtQdfZQMdKehTLqlFiYh
         ylLQ==
X-Gm-Message-State: APjAAAVSOH6HfpyN7IPZN3tx8gbCrowllrbjgWoXyxXgNCZY1GUNYCBw
        Ejz5m/l7qZ11jClDf2Zjd4STIln21e8NgZyQSw0Ys/d+r43n
X-Google-Smtp-Source: APXvYqx6TKnL5341UFyVF3+LROvh+Iamt2pmZa1OOOoon4ncgK7Rmh2h3eCnRwF94S9uVn4qwMP+q0WEVESkqPF/grd0VXDLyR5I
MIME-Version: 1.0
X-Received: by 2002:a6b:ea14:: with SMTP id m20mr2982294ioc.33.1555241284579;
 Sun, 14 Apr 2019 04:28:04 -0700 (PDT)
Date:   Sun, 14 Apr 2019 04:28:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ebb8a05867bd4ee@google.com>
Subject: INFO: task hung in __ia32_sys_io_uring_enter
From:   syzbot <syzbot+96642d282922abc6ef90@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8ee15f32 Merge tag 'dma-mapping-5.1-1' of git://git.infrad..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b2e69f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=96642d282922abc6ef90
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+96642d282922abc6ef90@syzkaller.appspotmail.com

INFO: task syz-executor.2:6936 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4+ #64
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.2  D27432  6936   7877 0x20020004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  __do_sys_io_uring_enter fs/io_uring.c:2674 [inline]
  __se_sys_io_uring_enter fs/io_uring.c:2633 [inline]
  __ia32_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2633
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fdf869
Code: Bad RIP value.
RSP: 002b:00000000f5ddb0cc EFLAGS: 00000296 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000009
RDX: 0000000000000006 RSI: 0000000000000002 RDI: 0000000020000180
RBP: 0000000000000008 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor.2:6941 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4+ #64
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.2  D30304  6941   7877 0x20020004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_timeout+0x8ca/0xfd0 kernel/time/timer.c:1779
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
  __io_uring_register+0xb6/0x1fd0 fs/io_uring.c:2925
  __do_sys_io_uring_register fs/io_uring.c:2975 [inline]
  __se_sys_io_uring_register fs/io_uring.c:2957 [inline]
  __ia32_sys_io_uring_register+0x193/0x1f0 fs/io_uring.c:2957
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fdf869
Code: Bad RIP value.
RSP: 002b:00000000f5dba0cc EFLAGS: 00000296 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1042:
  #0: 000000000fd6a12d (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5061
1 lock held by rsyslogd/7748:
  #0: 00000000b7bd7c78 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/7837:
  #0: 000000002675dd1e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000008bb68d6f (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7838:
  #0: 000000000272332d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000006c00cca5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7839:
  #0: 0000000083b27adb (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000778dee56 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7840:
  #0: 00000000919ed15e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000dc8f8c82 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7841:
  #0: 00000000a69742ff (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000cc818dd5 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7842:
  #0: 0000000031f786e7 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000c793de16 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7843:
  #0: 00000000c09fbaf2 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000000915b78b (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by kworker/u4:4/3512:
  #0: 00000000c5d7093f (&rq->lock){-.-.}, at: idle_balance  
kernel/sched/fair.c:10053 [inline]
  #0: 00000000c5d7093f (&rq->lock){-.-.}, at:  
pick_next_task_fair+0x1214/0x19a0 kernel/sched/fair.c:7062
  #1: 000000000fd6a12d (rcu_read_lock){....}, at:  
__update_idle_core+0x45/0x3f0 kernel/sched/fair.c:6059
1 lock held by syz-executor.2/6936:
  #0: 0000000020d6f30f (&ctx->uring_lock){+.+.}, at: __do_sys_io_uring_enter  
fs/io_uring.c:2674 [inline]
  #0: 0000000020d6f30f (&ctx->uring_lock){+.+.}, at: __se_sys_io_uring_enter  
fs/io_uring.c:2633 [inline]
  #0: 0000000020d6f30f (&ctx->uring_lock){+.+.}, at:  
__ia32_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2633
1 lock held by syz-executor.2/6941:
  #0: 0000000020d6f30f (&ctx->uring_lock){+.+.}, at:  
__do_sys_io_uring_register fs/io_uring.c:2974 [inline]
  #0: 0000000020d6f30f (&ctx->uring_lock){+.+.}, at:  
__se_sys_io_uring_register fs/io_uring.c:2957 [inline]
  #0: 0000000020d6f30f (&ctx->uring_lock){+.+.}, at:  
__ia32_sys_io_uring_register+0x182/0x1f0 fs/io_uring.c:2957

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 1042 Comm: khungtaskd Not tainted 5.1.0-rc4+ #64
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  nmi_cpu_backtrace.cold+0x63/0xa4 lib/nmi_backtrace.c:101
  nmi_trigger_cpumask_backtrace+0x1be/0x236 lib/nmi_backtrace.c:62
  arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:38
  trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
  check_hung_uninterruptible_tasks kernel/hung_task.c:204 [inline]
  watchdog+0x9b7/0xec0 kernel/hung_task.c:288
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
