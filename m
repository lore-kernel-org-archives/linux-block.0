Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F43FC433F5
	for <linux-block@archiver.kernel.org>; Sat, 20 Nov 2021 08:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbhKTJAW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Nov 2021 04:00:22 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:46978 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236597AbhKTJAW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Nov 2021 04:00:22 -0500
Received: by mail-il1-f198.google.com with SMTP id f15-20020a056e020b4f00b0029dbe422b4dso1590679ilu.13
        for <linux-block@vger.kernel.org>; Sat, 20 Nov 2021 00:57:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sn2pxcqlErnkd+rsT7LVUmBuw/qbeGAAfB1wD9hJ4e4=;
        b=sPVyx/SGUcF2StWI0vvpkWssz8jacPBx5rzjNWzdToxVqawJeGN8wSvhlccEgDMzvj
         3vWeBJsrzN7kXj4CvPUWxWcCT4ibOLooYj60D4d+rrXQPahBouWBSF/YCoLlSevRLh2S
         pCIMqEzNNx00fVShlx3hU9p2yxp34cNKZJWVZ1fwcgVFWd3vghq9P/fhsajmIhKChkui
         B053KHG/FC5jbsLvcb0aWC3x6CX5DuV8JZt1DAn3Uoc3goxTjMx/MNOgcAaiphrg7uAi
         wib17Gp1YIDOFWJby6c+UFkZJQ41yLEivjGfx6MfrLEVO2KyoSnNJ3rjy7xjKN+OgQkv
         RPZA==
X-Gm-Message-State: AOAM530aQzuikVP9HgDIIEOCIUGfG9/bNeOSJDubHYMJFWw+e3DSOExc
        sr9ugNmj+qbA2ekwAlOcMB6aSAcAuVS9MDMRfQqPDwBZWRZE
X-Google-Smtp-Source: ABdhPJyMw3jT4AOMwMsmohGvFAcyBrN3AUdDgI7fNSudBT6phvfmrtLe2gt6oIdUMNE3sVaejnz8HxZaSL2dPR26ZNnystUN1tYu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1382:: with SMTP id w2mr33490914jad.50.1637398639350;
 Sat, 20 Nov 2021 00:57:19 -0800 (PST)
Date:   Sat, 20 Nov 2021 00:57:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041182005d13494ca@google.com>
Subject: [syzbot] INFO: task hung in nbd_add_socket
From:   syzbot <syzbot+77c541b705f80d3415bd@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9539ba4308ad Merge tag 'riscv-for-linus-5.16-rc2' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149fb14eb00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d3b8fd1977c1e73
dashboard link: https://syzkaller.appspot.com/bug?extid=77c541b705f80d3415bd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77c541b705f80d3415bd@syzkaller.appspotmail.com

INFO: task syz-executor.3:11092 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28496 pid:11092 ppid:  7700 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 nbd_add_socket+0x166/0x810 drivers/block/nbd.c:1109
 __nbd_ioctl drivers/block/nbd.c:1454 [inline]
 nbd_ioctl+0x38c/0xb10 drivers/block/nbd.c:1511
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f545e268ae9
RSP: 002b:00007f545b7bd188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f545e37c020 RCX: 00007f545e268ae9
RDX: 0000000000000007 RSI: 000000000000ab00 RDI: 0000000000000006
RBP: 00007f545e2c2f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd4a1ff22f R14: 00007f545b7bd300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.3:11106 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:29592 pid:11106 ppid:  7700 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common kernel/locking/mutex.c:680 [inline]
 __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
 nbd_ioctl+0x151/0xb10 drivers/block/nbd.c:1504
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f545e268ae9
RSP: 002b:00007f545b79c188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f545e37c0e0 RCX: 00007f545e268ae9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000006
RBP: 00007f545e2c2f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd4a1ff22f R14: 00007f545b79c300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bb83b60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6206:
 #0: ffff88801b1d2d70 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
1 lock held by syz-executor.3/11092:
 #0: ffff88801aeaa198 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x151/0xb10 drivers/block/nbd.c:1504
1 lock held by syz-executor.3/11106:
 #0: ffff88801aeaa198 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x151/0xb10 drivers/block/nbd.c:1504

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:295
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 6505 Comm: syz-fuzzer Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:check_kcov_mode kernel/kcov.c:166 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x7/0x60 kernel/kcov.c:200
Code: 46 00 5d be 03 00 00 00 e9 56 13 63 02 66 0f 1f 44 00 00 48 8b be b0 01 00 00 e8 b4 ff ff ff 31 c0 c3 90 65 8b 05 99 d6 8a 7e <89> c1 48 8b 34 24 81 e1 00 01 00 00 65 48 8b 14 25 40 70 02 00 a9
RSP: 0018:ffffc90001a3fb48 EFLAGS: 00000202
RAX: 0000000080000001 RBX: ffffc90001a3fcc0 RCX: ffff888017a33a00
RDX: 0000000000000000 RSI: ffff888017a33a00 RDI: 0000000000000003
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff83fecac8 R11: 0000000000000000 R12: ffffc90001a3fcd8
R13: ffffc90000df2f48 R14: ffffc90001a3fce0 R15: 0000000000000000
FS:  000000c00002e090(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f861ab6a028 CR3: 000000001903c000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __list_del_entry include/linux/list.h:137 [inline]
 list_del_init include/linux/list.h:206 [inline]
 plist_del+0x1c6/0x480 lib/plist.c:130
 __futex_unqueue+0xc9/0x1b0 kernel/futex/core.c:513
 futex_unqueue+0x79/0x120 kernel/futex/core.c:610
 futex_wait+0x2d1/0x670 kernel/futex/waitwake.c:660
 do_futex+0x205/0x390 kernel/futex/syscalls.c:122
 __do_sys_futex kernel/futex/syscalls.c:199 [inline]
 __se_sys_futex kernel/futex/syscalls.c:180 [inline]
 __x64_sys_futex+0x1b0/0x4a0 kernel/futex/syscalls.c:180
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46e203
Code: 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14 4c 8b 54 24 18 4c 8b 44 24 20 44 8b 4c 24 28 b8 ca 00 00 00 0f 05 <89> 44 24 30 c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
RSP: 002b:000000c00003de80 EFLAGS: 00000202 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 000000c00002e000 RCX: 000000000046e203
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000001864c98
RBP: 000000c00003dec8 R08: 0000000000000000 R09: 0000000000000000
R10: 000000c00003deb8 R11: 0000000000000202 R12: 000000000043b6e0
R13: 0000000000000000 R14: 00000000008db92c R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	46 00 5d be          	rex.RX add %r11b,-0x42(%rbp)
   4:	03 00                	add    (%rax),%eax
   6:	00 00                	add    %al,(%rax)
   8:	e9 56 13 63 02       	jmpq   0x2631363
   d:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  13:	48 8b be b0 01 00 00 	mov    0x1b0(%rsi),%rdi
  1a:	e8 b4 ff ff ff       	callq  0xffffffd3
  1f:	31 c0                	xor    %eax,%eax
  21:	c3                   	retq
  22:	90                   	nop
  23:	65 8b 05 99 d6 8a 7e 	mov    %gs:0x7e8ad699(%rip),%eax        # 0x7e8ad6c3
* 2a:	89 c1                	mov    %eax,%ecx <-- trapping instruction
  2c:	48 8b 34 24          	mov    (%rsp),%rsi
  30:	81 e1 00 01 00 00    	and    $0x100,%ecx
  36:	65 48 8b 14 25 40 70 	mov    %gs:0x27040,%rdx
  3d:	02 00
  3f:	a9                   	.byte 0xa9


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
