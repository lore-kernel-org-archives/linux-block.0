Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3061AC10F13
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 16:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0120D20693
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 16:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfDNQmH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:42:07 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:56394 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNQmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 12:42:07 -0400
Received: by mail-it1-f197.google.com with SMTP id s21so14304785ite.6
        for <linux-block@vger.kernel.org>; Sun, 14 Apr 2019 09:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=r+Qr4jZyW79WGL/BfJtQpxRO1LNuAzql4OucEtTkgLc=;
        b=ngGPNO9OXk8mwsYJHBVkZPtmuIuQGjmwqHrmBHYU8ECZw+oqA4LxbmLBtHvxR7+1RP
         MxN9x7mEHK19Pn8fXo1Aqcp3hz2qkBdqxommdr282C23EEbXo8IkAfa5yhww0HYsCira
         dja47B13uEPiTiBJG1+ATrEZGjKQYGDl9JcnYMjZUI98wWlOX3Z5MTyBzXhil77rXgPP
         45IRy+XbX/rD6EUMHh9UNn3IpCzfrLnXp+utqUnCo2nU3wuNONxBdH+NaX6VLPSYlGF3
         GAnOooBNztkiLDDApwsOIXQyIzxRoSrwmrMW3wxCEDAheL2oGC0U++jBj8rYjKeHioX4
         jT3A==
X-Gm-Message-State: APjAAAWsjdBkgDEWTKWzc8s3RIDrUJ9aXz1KoDVoGQ7S0PxXPaTQDkw3
        4nAm3P8HgFZMDqRNtzvh6bk6o8wTgnhy7fZcv0gVsODa8XZ3
X-Google-Smtp-Source: APXvYqwsh4hl6evIqF7z9nmn6xPb8mzJSDvEL/lT9ufy51+yf3t/PAhjSeFSaFNmeI/YUHtYXmGdCBze4UUudZIpNUzXD9LUJaag
MIME-Version: 1.0
X-Received: by 2002:a24:3d8e:: with SMTP id n136mr5838434itn.3.1555260125982;
 Sun, 14 Apr 2019 09:42:05 -0700 (PDT)
Date:   Sun, 14 Apr 2019 09:42:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057bb08058680371f@google.com>
Subject: INFO: task hung in __x64_sys_io_uring_enter
From:   syzbot <syzbot+91ba19608804b5c53ca7@syzkaller.appspotmail.com>
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

HEAD commit:    bcb67f0f Add linux-next specific files for 20190412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15c15fc3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c479ecf64ba753
dashboard link: https://syzkaller.appspot.com/bug?extid=91ba19608804b5c53ca7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+91ba19608804b5c53ca7@syzkaller.appspotmail.com

INFO: task syz-executor.3:27713 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-next-20190412 #24
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D29480 27713   7953 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  __do_sys_io_uring_enter fs/io_uring.c:2697 [inline]
  __se_sys_io_uring_enter fs/io_uring.c:2634 [inline]
  __x64_sys_io_uring_enter+0x7de/0xac0 fs/io_uring.c:2634
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 df 00 00 00 48 83 ec  
30 48 89 6c 24 28 48 8d 6c 24 28 48 8b 42 08 48 8b 48 70 <48> 89 4c 24 20  
48 8b 10 48 89 54 24 18 48 8b 40 08 48 89 44 24 10
RSP: 002b:00007f6f44f0ec78 EFLAGS: 00000246 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000006 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007f6f44f0f6d4
R13: 00000000004bfe3c R14: 00000000004d2120 R15: 00000000ffffffff
INFO: task syz-executor.3:27724 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc4-next-20190412 #24
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor.3  D30320 27724   7953 0x00000004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x817/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_timeout+0x717/0xc50 kernel/time/timer.c:1783
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
  __io_uring_register+0xb6/0x1fd0 fs/io_uring.c:2926
  __do_sys_io_uring_register fs/io_uring.c:2976 [inline]
  __se_sys_io_uring_register fs/io_uring.c:2958 [inline]
  __x64_sys_io_uring_register+0x193/0x1f0 fs/io_uring.c:2958
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x458c29
Code: cc 64 48 8b 0c 25 f8 ff ff ff 48 3b 61 10 0f 86 df 00 00 00 48 83 ec  
30 48 89 6c 24 28 48 8d 6c 24 28 48 8b 42 08 48 8b 48 70 <48> 89 4c 24 20  
48 8b 10 48 89 54 24 18 48 8b 40 08 48 89 44 24 10
RSP: 002b:00007f6f44eccc78 EFLAGS: 00000246 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 0000000000458c29
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 000000000073c040 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6f44ecd6d4
R13: 00000000004cb6f0 R14: 00000000004d2168 R15: 00000000ffffffff

Showing all locks held in the system:
1 lock held by khungtaskd/1041:
  #0: 00000000646c174a (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5061
2 locks held by getty/7909:
  #0: 000000004ed5ef6e (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000015f069f9 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7910:
  #0: 0000000028dc5235 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000003e5c2584 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7911:
  #0: 0000000009c1d545 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000097341bd0 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7912:
  #0: 00000000e304bd09 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000fbaacf70 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7913:
  #0: 00000000aac8c1e7 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000eb37cc5c (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7914:
  #0: 00000000dd76f9bc (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000003dfcb9c8 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/7915:
  #0: 00000000859ecc38 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000086483d71 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
1 lock held by syz-executor.3/27713:
  #0: 0000000060ca5ec1 (&ctx->uring_lock){+.+.}, at: __do_sys_io_uring_enter  
fs/io_uring.c:2697 [inline]
  #0: 0000000060ca5ec1 (&ctx->uring_lock){+.+.}, at: __se_sys_io_uring_enter  
fs/io_uring.c:2634 [inline]
  #0: 0000000060ca5ec1 (&ctx->uring_lock){+.+.}, at:  
__x64_sys_io_uring_enter+0x7de/0xac0 fs/io_uring.c:2634
1 lock held by syz-executor.3/27724:
  #0: 0000000060ca5ec1 (&ctx->uring_lock){+.+.}, at:  
__do_sys_io_uring_register fs/io_uring.c:2975 [inline]
  #0: 0000000060ca5ec1 (&ctx->uring_lock){+.+.}, at:  
__se_sys_io_uring_register fs/io_uring.c:2958 [inline]
  #0: 0000000060ca5ec1 (&ctx->uring_lock){+.+.}, at:  
__x64_sys_io_uring_register+0x182/0x1f0 fs/io_uring.c:2958

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1041 Comm: khungtaskd Not tainted 5.1.0-rc4-next-20190412 #24
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
  kthread+0x357/0x430 kernel/kthread.c:254
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 1 to CPUs 0:


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
