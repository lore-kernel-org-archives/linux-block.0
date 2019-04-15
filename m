Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D2C10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 13:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03CC2073F
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 13:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfDONwH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:52:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36678 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfDONwG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 09:52:06 -0400
Received: by mail-io1-f70.google.com with SMTP id a7so14281452ioq.3
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2019 06:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yC4zLRl/MeEuJ6j66K19B2CaSKv1TPcBGPtpoT8DQaY=;
        b=PpIOj8zWE9AW7PISkBc6xJ7iLtHGeiMPiPTJmLhryxm9wH1E2MlHP4L387MI6YQRUr
         lanJBxD2tZsNNjxpnb9tF6um6MW24Oww1tdjyhTTvUxcVSJ0BoKQ9Jk5Y0alfP50f1/f
         yqHIJ9KufaSUrZva06sng+DC70pZhHKXbgjxybMrEq6u2XtFMlfR0u6M8C+6vZublfL5
         uOGJXTgJYzI6QxQBCJop7f6/+FKtq7fl2uxpDht/Z5YJ3i0tSMrJc4o0NCyLAArJrVtr
         jO1viSXDL5DXi0I7XjzBXz/39Rvy1BeL6J3lKVjTp6ZYLvlfl1ii5eUYpNV5MqyAQhaG
         4J0w==
X-Gm-Message-State: APjAAAX6jYpxMYqDKVoWJhCgIjE83K3HMGfMqoXHIG1Us4o0YviSxqz4
        m+NADx+akSzrZhxw44PwQHTJyWy2AnWc/G0eC9k4Mu6VJYwi
X-Google-Smtp-Source: APXvYqyvHd4jxDm+oeASLWWHTEnw49a3sItAJtcG3rKuuiXF7vXtxDME+9+A9+yqoiWRQOOnrjtSoa8gaCumsHQPuwBMr/KcMlB/
MIME-Version: 1.0
X-Received: by 2002:a02:a507:: with SMTP id e7mr2266753jam.19.1555336325727;
 Mon, 15 Apr 2019 06:52:05 -0700 (PDT)
Date:   Mon, 15 Apr 2019 06:52:05 -0700
In-Reply-To: <0000000000009c60fe058665c584@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003393e6058691f589@google.com>
Subject: Re: INFO: task hung in __io_uring_register
From:   syzbot <syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    dc4060a5 Linux 5.1-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17eacddd200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=16dc03452dee970a0c3e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14eb47ed200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112175dd200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+16dc03452dee970a0c3e@syzkaller.appspotmail.com

INFO: task syz-executor043:8083 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc5 #68
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor043 D29912  8083   8063 0x20020004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_timeout+0x8ca/0xfd0 kernel/time/timer.c:1779
  do_wait_for_common kernel/sched/completion.c:83 [inline]
  __wait_for_common kernel/sched/completion.c:104 [inline]
  wait_for_common kernel/sched/completion.c:115 [inline]
  wait_for_completion+0x29c/0x440 kernel/sched/completion.c:136
  __io_uring_register+0xb6/0x1fd0 fs/io_uring.c:2929
  __do_sys_io_uring_register fs/io_uring.c:2979 [inline]
  __se_sys_io_uring_register fs/io_uring.c:2961 [inline]
  __ia32_sys_io_uring_register+0x193/0x1f0 fs/io_uring.c:2961
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f06869
Code: Bad RIP value.
RSP: 002b:00000000f7f021ec EFLAGS: 00000296 ORIG_RAX: 00000000000001ab
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000014a
RBP: 00000000200000c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
INFO: task syz-executor043:8084 blocked for more than 143 seconds.
       Not tainted 5.1.0-rc5 #68
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
syz-executor043 D30320  8084   8063 0x20020004
Call Trace:
  context_switch kernel/sched/core.c:2877 [inline]
  __schedule+0x813/0x1cc0 kernel/sched/core.c:3518
  schedule+0x92/0x180 kernel/sched/core.c:3562
  schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:3620
  __mutex_lock_common kernel/locking/mutex.c:1002 [inline]
  __mutex_lock+0x726/0x1310 kernel/locking/mutex.c:1072
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  __do_sys_io_uring_enter fs/io_uring.c:2678 [inline]
  __se_sys_io_uring_enter fs/io_uring.c:2637 [inline]
  __ia32_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2637
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f06869
Code: Bad RIP value.
RSP: 002b:00000000f7ee11ec EFLAGS: 00000292 ORIG_RAX: 00000000000001aa
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000010005
RDX: 0000000000000002 RSI: 0000000000000003 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Showing all locks held in the system:
1 lock held by khungtaskd/1042:
  #0: 00000000fbdbf33e (rcu_read_lock){....}, at:  
debug_show_all_locks+0x5f/0x27e kernel/locking/lockdep.c:5056
2 locks held by rsyslogd/7952:
  #0: 000000001bb2c5a7 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xee/0x110  
fs/file.c:801
  #1: 000000007392ce44 (fs_reclaim){+.+.}, at: is_bpf_text_address+0x0/0x170  
kernel/bpf/core.c:697
2 locks held by getty/8041:
  #0: 00000000e7d67802 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000026520570 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8042:
  #0: 000000004426012c (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000004c02a9e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8043:
  #0: 00000000e0209856 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000009f921bda (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8044:
  #0: 0000000000de2ea5 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 000000002674bf52 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8045:
  #0: 00000000abbba1ef (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000ef32475e (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8046:
  #0: 000000008d742c83 (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 00000000fa255b8a (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
2 locks held by getty/8047:
  #0: 00000000d3d56b2b (&tty->ldisc_sem){++++}, at:  
ldsem_down_read+0x33/0x40 drivers/tty/tty_ldsem.c:341
  #1: 0000000015242045 (&ldata->atomic_read_lock){+.+.}, at:  
n_tty_read+0x232/0x1b70 drivers/tty/n_tty.c:2156
1 lock held by syz-executor043/8083:
  #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at:  
__do_sys_io_uring_register fs/io_uring.c:2978 [inline]
  #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at:  
__se_sys_io_uring_register fs/io_uring.c:2961 [inline]
  #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at:  
__ia32_sys_io_uring_register+0x182/0x1f0 fs/io_uring.c:2961
1 lock held by syz-executor043/8084:
  #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at: __do_sys_io_uring_enter  
fs/io_uring.c:2678 [inline]
  #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at: __se_sys_io_uring_enter  
fs/io_uring.c:2637 [inline]
  #0: 000000005524ed18 (&ctx->uring_lock){+.+.}, at:  
__ia32_sys_io_uring_enter+0x67f/0xac0 fs/io_uring.c:2637

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 1042 Comm: khungtaskd Not tainted 5.1.0-rc5 #68
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

