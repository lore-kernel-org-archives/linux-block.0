Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C079FC433F5
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 01:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44A861050
	for <linux-block@archiver.kernel.org>; Sat, 18 Sep 2021 01:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhIRBem (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Sep 2021 21:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhIRBel (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Sep 2021 21:34:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F9C061757;
        Fri, 17 Sep 2021 18:33:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so10551642pjb.2;
        Fri, 17 Sep 2021 18:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=yRnSXiARv0igDAD1aqjD+L/H4qwGc5e4mC/KfZtbO48=;
        b=GrC440QMtNEs46riTcfeTr06jq8H3dzL/SuI6w8FHk/ExJxphY7tgQDEf7+8nnFEtU
         Zg9q2m9q+pKyM8GFBNbq5wmHwTxdl+wnJNKXhEoHtuvooS+kJyFQZJaPs4h0xVbIJETf
         zRSGHYUlYuqWgt3UVWqUOyxFHoJSiHDAGyzQPKVdq+umbz7LTewpLe+jo/wdoACrKOBY
         /NbJaxmYwJukJYA5gAeOTrB3iF8O8+VPVlRF5XPO/5M3za3792BiuiSJlyhtAAwmZSCU
         fbdW5Y608595KEvoobh0lRXHXaKkbL99GGgLN87WBRwzwF13TclposVOBY4JYw3pIZ1+
         f3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yRnSXiARv0igDAD1aqjD+L/H4qwGc5e4mC/KfZtbO48=;
        b=IPWsbcqoB/Iy8qOkPZgnkH4i63DiqN7hYdTS8Jy+myNSf2976FsIz315JULeXMkD9S
         iRGntQPU136m4F/72mIjldHjfKaDvdqvUrQUjWkkkGsV6mfW3qORONSD9rkz2GhWkK9K
         3RiEYvSFafbe0Dur9btCrThtUlSF5emgbbPYGC5q539UfkOZKTBaR9n36ywPcykhNYwg
         fgIrurncB9zKGpwBzsBU3HdhqNt/phbLVDz8KBHkt1iuMJRSOJJG6dQ67wXkHtrndSEq
         bw6l1h1lPX4OEMCeWkGi7+ecN+cdQVCeH778OsnK/chxiRVSR9uRmNfsKOWEIUp0h1q5
         cSbQ==
X-Gm-Message-State: AOAM532NNrCOwKR+zn1w+Y4fbQoomUKTblCj5ud3IMgDVcsxfzEl8loZ
        f2MQQkIK3xbU2ZK25bAnboD148ndj+b1MDCFPys+5tw34fcI
X-Google-Smtp-Source: ABdhPJzoYjvdPnlVHBlSB2NVPL4CBJwc2xYq3YHDZNZPreCGKdBKss1+GdNaAKwzOHjqY3sM7kVZS30dOXYgW6IuMec=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr16084837pjr.178.1631928798531;
 Fri, 17 Sep 2021 18:33:18 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Sat, 18 Sep 2021 09:33:07 +0800
Message-ID: <CACkBjsbZKNC+eF0+K+ueXrkMzgSC5h3YXs8WWSJ-voLN1oGDKQ@mail.gmail.com>
Subject: INFO: task hung in nbd_add_socket
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915
git tree: upstream
console output:
https://drive.google.com/file/d/1uDfJnwful_fOzqNVRIHEf7PqIsqZDcvG/view?usp=sharing
kernel config: https://drive.google.com/file/d/1zXpDhs-IdE7tX17B7MhaYP0VGUfP6m9B/view?usp=sharing

Sorry, I don't have a reproducer for this crash, hope the symbolized
report can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

INFO: task syz-executor:15349 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:28400 pid:15349 ppid: 14720 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 blk_mq_freeze_queue_wait+0x114/0x160 block/blk-mq.c:151
 nbd_add_socket+0x102/0x7c0 drivers/block/nbd.c:1050
 __nbd_ioctl drivers/block/nbd.c:1405 [inline]
 nbd_ioctl+0x391/0x9c0 drivers/block/nbd.c:1462
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fb9db27fc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c0a0 RCX: 00000000004739cd
RDX: 0000000000000006 RSI: 000000000000ab00 RDI: 0000000000000008
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c0a0
R13: 00007ffd4c2267df R14: 00007ffd4c226980 R15: 00007fb9db27fdc0
INFO: task syz-executor:15350 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:28400 pid:15350 ppid: 14720 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fb9db25ec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c158 RCX: 00000000004739cd
RDX: 0000000000000006 RSI: 000000000000ab00 RDI: 0000000000000004
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c158
R13: 00007ffd4c2267df R14: 00007ffd4c226980 R15: 00007fb9db25edc0
INFO: task syz-executor:15351 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:29552 pid:15351 ppid: 14720 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fb9db23dc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c210 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000009
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c210
R13: 00007ffd4c2267df R14: 00007ffd4c226980 R15: 00007fb9db23ddc0
INFO: task syz-executor:15352 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:28400 pid:15352 ppid: 14720 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fb9db21cc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c2c8 RCX: 00000000004739cd
RDX: 00000000000003ff RSI: 000000000000ab0a RDI: 0000000000000003
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c2c8
R13: 00007ffd4c2267df R14: 00007ffd4c226980 R15: 00007fb9db21cdc0
INFO: task syz-executor:15353 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:28400 pid:15353 ppid: 14720 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fb9db1fbc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c380 RCX: 00000000004739cd
RDX: 0000000000000005 RSI: 000000000000ab00 RDI: 0000000000000007
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c380
R13: 00007ffd4c2267df R14: 00007ffd4c226980 R15: 00007fb9db1fbdc0
INFO: task syz-executor:15354 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:28400 pid:15354 ppid: 14720 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fb9db1dac58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c438 RCX: 00000000004739cd
RDX: 0000000000000005 RSI: 000000000000ab00 RDI: 0000000000000004
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c438
R13: 00007ffd4c2267df R14: 00007ffd4c226980 R15: 00007fb9db1dadc0
INFO: task syz-executor:15355 blocked for more than 143 seconds.
      Not tainted 5.15.0-rc1+ #6
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:29336 pid:15355 ppid: 14720 flags:0x00000004
Call Trace:
 context_switch kernel/sched/core.c:4940 [inline]
 __schedule+0xcd9/0x2530 kernel/sched/core.c:6287
 schedule+0xd3/0x270 kernel/sched/core.c:6366
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6425
 __mutex_lock_common kernel/locking/mutex.c:669 [inline]
 __mutex_lock+0xc96/0x1680 kernel/locking/mutex.c:729
 nbd_ioctl+0x14f/0x9c0 drivers/block/nbd.c:1455
 blkdev_ioctl+0x2a4/0x720 block/ioctl.c:589
 block_ioctl+0xfa/0x140 block/fops.c:477
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4739cd
RSP: 002b:00007fb9db1b9c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000059c4f0 RCX: 00000000004739cd
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000008
RBP: 00000000004ebd80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000059c4f0
R13: 00007ffd4c2267df R14: 00007ffd4c226980 R15: 00007fb9db1b9dc0
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 39 Comm: khungtaskd Not tainted 5.15.0-rc1+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1e1/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xcc8/0x1010 kernel/hung_task.c:295
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 3
CPU: 3 PID: 3026 Comm: systemd-journal Not tainted 5.15.0-rc1+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0033:0x5654ffc2727b
Code: e4 48 83 bb 98 00 00 00 00 74 24 48 8b 55 d8 64 48 33 14 25 28
00 00 00 44 89 e0 0f 85 ec 03 00 00 48 8d 65 e0 5b 41 5c 41 5d <41> 5e
5d c3 90 83 bb 24 02 00 00 03 74 d3 4c 8b ab f0 00 00 00 4d
RSP: 002b:00007ffd23734c48 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 00007ffd23737b30 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007ffd23737bd0
RBP: 00007ffd23734c50 R08: 00005654ffc273e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000009 R14: 00005655006498a0 R15: 00007ffd23735140
FS:  00007fdcd6b8d8c0 GS:  0000000000000000
NMI backtrace for cpu 0 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 0 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 0 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
NMI backtrace for cpu 2 skipped: idling at native_safe_halt
arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 2 skipped: idling at arch_safe_halt
arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 2 skipped: idling at default_idle+0xb/0x10
arch/x86/kernel/process.c:716
