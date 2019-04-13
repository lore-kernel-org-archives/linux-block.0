Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D11C10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B69620869
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 09:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfDMJJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 05:09:09 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:34972 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfDMJJJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 05:09:09 -0400
Received: by mail-it1-f200.google.com with SMTP id a64so11007844ith.0
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 02:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LiJbXUtu5xUodZXvFh3I6wLvKqCAhDgzTKjsH9pmR90=;
        b=Za2ZK5Gcosd2s1TQmPPdoYPRU/kO0NRf/ntc07iKjo5XclGsPfXVGOhh3gMTJPR32P
         sfu9Y4n4PvSq9ZY9fQmGmzwGkVrncQsBF+4A/epuH0GWNblFCRl3Sy9sU/11urQ+VjTH
         JqaDAhM7vCeR+UfJK8kkKs+iGX/aT3hjNb1/rfF/SaOavLnEMYsky1Nn9gGRAi62qC0B
         jMm0EGq7DoOlCW72faDOdwOO5KLrkt+cG2V6837djtfwUgjQp/X29EnEovr8/rK6UQ+R
         Uurf8ypQs/zlGzNxgVi1CdQHgRBhW2fDt4dqqDLl1Pb90AEc9QcmPvULEaJEFUv0Lwie
         OysA==
X-Gm-Message-State: APjAAAV5KKGf0JNPBf1FuC2/hnqEhy9fVvfCW30YlZo/z9dYrBTpemg2
        ZDfwO3xOQYcD+izAkBiQnAgY4OI2+He25iaIgvSMAX5m2ahS
X-Google-Smtp-Source: APXvYqxtHP+gcZP0Tp28//gwMAwbX7hbkCCwisGAj8/WBEFkTspePtPlq8QTIhuRgt0rRugfPiz8KKrmg2bYMdiRam1x2J2BxxBU
MIME-Version: 1.0
X-Received: by 2002:a02:4e46:: with SMTP id r67mr11204956jaa.8.1555146548728;
 Sat, 13 Apr 2019 02:09:08 -0700 (PDT)
Date:   Sat, 13 Apr 2019 02:09:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c60fe058665c584@google.com>
Subject: INFO: task hung in __io_uring_register
From:   syzbot <syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1057cedd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fb64439e07a1ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=16dc03452dee970a0c3e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com

INFO: task syz-executor.3:10489 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4+ #65
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D29480 10489   8136 0x00000004
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
  __x64_sys_io_uring_register+0x193/0x1f0 fs/io_uring.c:2957
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 df 00 00 00 48 83 ec  
30 48 89 6c 24 28 48 8d 6c 24 28 48 8b 42 08 48 8b 48 70 <48> 89 4c 24 20  
48 8b 10 48 89 54 24 18 48 8b 40 08 48 89 44 24 10
RSP: 002b:00007f1b68525c78 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1b685266d4
R13: 00000000004cb720 R14: 00000000004d2180 R15: 00000000ffffffff
INFO: task syz-executor.3:10495 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4+ #65
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D30336 10495   8136 0x00000004
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
  __x64_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2633
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 df 00 00 00 48 83 ec  
30 48 89 6c 24 28 48 8d 6c 24 28 48 8b 42 08 48 8b 48 70 <48> 89 4c 24 20  
48 8b 10 48 89 54 24 18 48 8b 40 08 48 89 44 24 10
RSP: 002b:00007f1b68504c78 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000003
RBP: 000000000073bfa0 R08: 0000000000000000 R09: 000000000000050d
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1b685056d4
R13: 00000000004bfe3c R14: 00000000004d2120 R15: 00000000ffffffff
INFO: task syz-executor.3:10500 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4+ #65
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D29928 10500   8136 0x00000004
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
  __x64_sys_io_uring_register+0x193/0x1f0 fs/io_uring.c:2957
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 df 00 00 00 48 83 ec  
30 48 89 6c 24 28 48 8d 6c 24 28 48 8b 42 08 48 8b 48 70 <48> 89 4c 24 20  
48 8b 10 48 89 54 24 18 48 8b 40 08 48 89 44 24 10
RSP: 002b:00007f1b684e3c78 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1b684e46d4
R13: 00000000004cb720 R14: 00000000004d2180 R15: 00000000ffffffff
INFO: task syz-executor.3:10721 blocked for more than 144 seconds.
       Not tainted 5.1.0-rc4+ #65
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D30728 10721   8136 0x00000004
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
  __x64_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2633
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 df 00 00 00 48 83 ec  
30 48 89 6c 24 28 48 8d 6c 24 28 48 8b 42 08 48 8b 48 70 <48> 89 4c 24 20  
48 8b 10 48 89 54 24 18 48 8b 40 08 48 89 44 24 10
RSP: 002b:00007f1b684c2c78 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000003
RBP: 000000000073c0e0 R08: 0000000000000000 R09: 000000000000050d
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1b684c36d4
R13: 00000000004bfe3c R14: 00000000004d2120 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1042:
  #0: 0000000064f7de01 (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5061
1 lock held by rsyslogd/8002:
  #0: 000000003beb5bd7 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
2 locks held by getty/8093:
  #0: 00000000f8cf0898 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000b6b6ec31 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8094:
  #0: 00000000fe7ef187 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000e78fcfd2 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8095:
  #0: 000000008592152d (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000005540a126 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8096:
  #0: 000000005c2264ca (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000021a80187 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8097:
  #0: 00000000aa58b5ab (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000009d1abcd3 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8098:
  #0: 00000000ab6caab2 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000932e1c20 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8099:
  #0: 00000000d491671f (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000784f6bed (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
1 lock held by syz-executor.3/10489:
  #0: 000000008d411992 (&ctx->uring_lock){+.+.}, at:  
__do_sys_io_uring_register fs/io_uring.c:2974 [inline]
  #0: 000000008d411992 (&ctx->uring_lock){+.+.}, at:  
__se_sys_io_uring_register fs/io_uring.c:2957 [inline]
  #0: 000000008d411992 (&ctx->uring_lock){+.+.}, at:  
__x64_sys_io_uring_register+0x182/0x1f0 fs/io_uring.c:2957
1 lock held by syz-executor.3/10495:
  #0: 000000008d411992 (&ctx->uring_lock){+.+.}, at: __do_sys_io_uring_enter  
fs/io_uring.c:2674 [inline]
  #0: 000000008d411992 (&ctx->uring_lock){+.+.}, at: __se_sys_io_uring_enter  
fs/io_uring.c:2633 [inline]
  #0: 000000008d411992 (&ctx->uring_lock){+.+.}, at:  
__x64_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2633
1 lock held by syz-executor.3/10500:
  #0: 00000000855b16b5 (&ctx->uring_lock){+.+.}, at:  
__do_sys_io_uring_register fs/io_uring.c:2974 [inline]
  #0: 00000000855b16b5 (&ctx->uring_lock){+.+.}, at:  
__se_sys_io_uring_register fs/io_uring.c:2957 [inline]
  #0: 00000000855b16b5 (&ctx->uring_lock){+.+.}, at:  
__x64_sys_io_uring_register+0x182/0x1f0 fs/io_uring.c:2957
1 lock held by syz-executor.3/10721:
  #0: 00000000855b16b5 (&ctx->uring_lock){+.+.}, at: __do_sys_io_uring_enter  
fs/io_uring.c:2674 [inline]
  #0: 00000000855b16b5 (&ctx->uring_lock){+.+.}, at: __se_sys_io_uring_enter  
fs/io_uring.c:2633 [inline]
  #0: 00000000855b16b5 (&ctx->uring_lock){+.+.}, at:  
__x64_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2633

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1042 Comm: khungtaskd Not tainted 5.1.0-rc4+ #65
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
Sending NMI from CPU 1 to CPUs 0:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
