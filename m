Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EE5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 01:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB9F761B64
	for <linux-block@archiver.kernel.org>; Thu, 18 Nov 2021 01:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhKRBQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:16:28 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:33345 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhKRBQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Nov 2021 20:16:27 -0500
Received: by mail-il1-f197.google.com with SMTP id c17-20020a92b751000000b0027392cd873aso3101507ilm.0
        for <linux-block@vger.kernel.org>; Wed, 17 Nov 2021 17:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=1p/zvlkwUF4+3C9sFWeL4/DIFk0DbI9ehxkA1GczZDQ=;
        b=cwVXrxaDrlkpM7MijdYuMqLtzrFfg5KL6qeX0tPGXUvJ4sosiwp5Vbo1Re8B2nBECk
         7EXBXoizQ3NaepKypjv8okZ6CM55ykUUzkwW6B6vuIxWrA/BRroIewfpteLtrpRyWOF3
         r9DVYq/TZMueMcV5ovhLSS/kBgVLOnqWLB3Z6dUvFyly5jI/OcCiDaqjoGU6xmJXpw8B
         Rl9am5THnWC4SP3eyAkM7xw5ZdKitSTasJDspMYZlw4IN1h8m4scc/F8zXUwRdH+NmSS
         gfEjtV5/4MnRrVX1yVHuJ53Ku1OQhaBq3EeUzBKx3EHwjj5w0n5mixMG8jWFtsGSf+lC
         Vx5A==
X-Gm-Message-State: AOAM532i36TnZPcgaSxdcQaDUaaUnloaGdQd+sHK50gF/JRfgteCDtHt
        ENEoyQJ383DDymiHoemD7V+JNDidQvorZjuxpJrbe3xXKoKc
X-Google-Smtp-Source: ABdhPJxSHosbxl8lFFPtndhyNiEbV7KCfMn4Gn6cS45+QefzAr4fkeNxVzK1i8+aTM8qz2+cvx4bAGIn4hV6TDKVzqHk0d7dagrl
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ea:: with SMTP id q10mr4605625ilv.283.1637198007934;
 Wed, 17 Nov 2021 17:13:27 -0800 (PST)
Date:   Wed, 17 Nov 2021 17:13:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0a37405d105ddd5@google.com>
Subject: [syzbot] INFO: task hung in __loop_clr_fd
From:   syzbot <syzbot+cf73574f3ec41f2513ee@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ee1703cda8dc Merge tag 'hyperv-fixes-signed-20211117' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135e3236b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c3ab72998e7f1a4
dashboard link: https://syzkaller.appspot.com/bug?extid=cf73574f3ec41f2513ee
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf73574f3ec41f2513ee@syzkaller.appspotmail.com

INFO: task syz-executor.5:17065 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:25296 pid:17065 ppid:  8521 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0x105/0x190 block/blk-mq.c:178
 __loop_clr_fd+0x1c6/0x9b0 drivers/block/loop.c:1122
 loop_clr_fd drivers/block/loop.c:1237 [inline]
 lo_ioctl+0x107b/0x1f40 drivers/block/loop.c:1562
 blkdev_ioctl+0x3ac/0x790 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f018af738a7
RSP: 002b:00007f01884e8fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000200042c0 RCX: 00007f018af738a7
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000005
RBP: 00007f01884e96bc R08: 00007f01884e9040 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000005 R14: 00007f01884e9000 R15: 0000000020004340
 </TASK>
INFO: task syz-executor.5:17077 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:26960 pid:17077 ppid:  8521 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xb72/0x1460 kernel/sched/core.c:6253
 schedule+0x12b/0x1f0 kernel/sched/core.c:6326
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
 __mutex_lock_common+0xd1f/0x2590 kernel/locking/mutex.c:680
 __mutex_lock kernel/locking/mutex.c:740 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:792
 blkdev_get_by_dev+0xfc/0xb80 block/bdev.c:819
 blkdev_open+0x137/0x2f0 block/fops.c:501
 do_dentry_open+0x78b/0x1020 fs/open.c:822
 do_open fs/namei.c:3426 [inline]
 path_openat+0x2896/0x3660 fs/namei.c:3559
 do_filp_open+0x277/0x4f0 fs/namei.c:3586
 do_sys_openat2+0x13b/0x500 fs/open.c:1212
 do_sys_open fs/open.c:1228 [inline]
 __do_sys_openat fs/open.c:1244 [inline]
 __se_sys_openat fs/open.c:1239 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1239
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f018af26a04
RSP: 002b:00007f01884a6ed0 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f018afbd970 RCX: 00007f018af26a04
RDX: 0000000000000002 RSI: 00007f01884a7000 RDI: 00000000ffffff9c
RBP: 00007f01884a7000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000002
R13: 0000000000000004 R14: 0000000020004320 R15: 0000000000000004
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8cd1db00 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by kworker/u4:5/1085:
 #0: ffff8880b9a395d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x25/0x110 kernel/sched/core.c:478
 #1: ffffc90004dc7d20 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at: process_one_work+0x808/0x1140 kernel/workqueue.c:2273
2 locks held by agetty/6240:
 #0: ffff88801ce1e098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002f832e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6c5/0x1c60 drivers/tty/n_tty.c:2113
2 locks held by agetty/6241:
 #0: ffff88801ce1c098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002f732e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6c5/0x1c60 drivers/tty/n_tty.c:2113
2 locks held by agetty/6242:
 #0: ffff88801b31f098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffffc90002f632e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6c5/0x1c60 drivers/tty/n_tty.c:2113
2 locks held by agetty/26834:
 #0: ffff8880711c8098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:252
 #1: ffffc9000474b2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6c5/0x1c60 drivers/tty/n_tty.c:2113
2 locks held by systemd-udevd/1504:
 #0: ffff88801b76d918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0xb80 block/bdev.c:819
 #1: ffff88801b769360 (&lo->lo_mutex){+.+.}-{3:3}, at: lo_open+0x68/0x100 drivers/block/loop.c:1733
1 lock held by syz-executor.5/17065:
 #0: ffff88801b769360 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x6d/0x9b0 drivers/block/loop.c:1106
1 lock held by syz-executor.5/17077:
 #0: ffff88801b76d918 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0xb80 block/bdev.c:819

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1dc/0x2d8 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x45f/0x490 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x16a/0x280 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:210 [inline]
 watchdog+0xc82/0xcd0 kernel/hung_task.c:295
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 1085 Comm: kworker/u4:5 Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:lookup_chain_cache kernel/locking/lockdep.c:3695 [inline]
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:3714 [inline]
RIP: 0010:validate_chain+0x1c3/0x8240 kernel/locking/lockdep.c:3769
Code: 83 c3 f8 75 15 eb 5a 48 8b 03 48 8d 58 f8 48 85 c0 48 0f 44 d8 48 85 db 74 47 4c 8d 7b 18 4c 89 f8 48 c1 e8 03 42 80 3c 20 00 <74> 08 4c 89 ff e8 33 86 69 00 49 8b 07 4c 39 f0 74 1c 48 83 c3 08
RSP: 0018:ffffc90004dc7180 EFLAGS: 00000046
RAX: 1ffffffff1faac6b RBX: ffffffff8fd56340 RCX: ffffffff8166bbb8
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff901a6ef0
RBP: ffffc90004dc7490 R08: dffffc0000000000 R09: fffffbfff2034ddf
R10: fffffbfff2034ddf R11: 0000000000000000 R12: dffffc0000000000
R13: 1ffff920009b8e50 R14: c60639a784b57c10 R15: ffffffff8fd56358
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3842131000 CR3: 000000000ca8e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __lock_acquire+0x1382/0x2b00 kernel/locking/lockdep.c:5027
 lock_acquire+0x19f/0x4d0 kernel/locking/lockdep.c:5637
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 __get_locked_pte+0x2ad/0x390 mm/memory.c:1722
 get_locked_pte include/linux/mm.h:2160 [inline]
 __text_poke+0x280/0x9f0 arch/x86/kernel/alternative.c:1000
 text_poke arch/x86/kernel/alternative.c:1083 [inline]
 text_poke_bp_batch+0x4b0/0x940 arch/x86/kernel/alternative.c:1310
 text_poke_flush arch/x86/kernel/alternative.c:1451 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1458
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 static_key_disable_cpuslocked+0xcc/0x1b0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate+0x3c8/0x460 mm/kfence/core.c:746
 process_one_work+0x853/0x1140 kernel/workqueue.c:2298
 worker_thread+0xac1/0x1320 kernel/workqueue.c:2445
 kthread+0x468/0x490 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30
 </TASK>
----------------
Code disassembly (best guess):
   0:	83 c3 f8             	add    $0xfffffff8,%ebx
   3:	75 15                	jne    0x1a
   5:	eb 5a                	jmp    0x61
   7:	48 8b 03             	mov    (%rbx),%rax
   a:	48 8d 58 f8          	lea    -0x8(%rax),%rbx
   e:	48 85 c0             	test   %rax,%rax
  11:	48 0f 44 d8          	cmove  %rax,%rbx
  15:	48 85 db             	test   %rbx,%rbx
  18:	74 47                	je     0x61
  1a:	4c 8d 7b 18          	lea    0x18(%rbx),%r15
  1e:	4c 89 f8             	mov    %r15,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
* 2a:	74 08                	je     0x34 <-- trapping instruction
  2c:	4c 89 ff             	mov    %r15,%rdi
  2f:	e8 33 86 69 00       	callq  0x698667
  34:	49 8b 07             	mov    (%r15),%rax
  37:	4c 39 f0             	cmp    %r14,%rax
  3a:	74 1c                	je     0x58
  3c:	48 83 c3 08          	add    $0x8,%rbx


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
