Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44415C433EF
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 03:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE5B61439
	for <linux-block@archiver.kernel.org>; Mon, 15 Nov 2021 03:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhKODGe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Nov 2021 22:06:34 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:36737 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhKODGU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Nov 2021 22:06:20 -0500
Received: by mail-il1-f199.google.com with SMTP id i9-20020a056e0212c900b0026ee2c287baso9653706ilm.3
        for <linux-block@vger.kernel.org>; Sun, 14 Nov 2021 19:03:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/1Cjsv4phlmjuFfl+XY8QJKwm4YTDC1FDffT5jszj1E=;
        b=UNSS/iryWzbIJwATi7mY7xVbq6VV00MJ0xSOK4vQdML3TaprGDfELPALKv6hxjwzR0
         Lff3gGixj+pzOpGmjikkD7k83E6z+U3CNY9IzZj3TgeZpG4Uwhiaw4bRGOsmnn1lBmpS
         HJQ+359FO9p3DhYh53NfzOpa8i9FD6rd9xHFrqJHTsWNlDA5hxfTj4cCDoK7AZQBENIk
         s/pPyjQPF2TuvVEh/D1oX01wL9AODz8TML60cJCqfe1WpF9k7Q7MCqiXKXCqKLqckLfO
         pKI6dcSJUQRVPVkaYviuwocz0lx4GNwMCUS9Y9SQwzgHBDwObc98Gvf6lXjCJnkK8Vj9
         qpbw==
X-Gm-Message-State: AOAM531ONS04rKuqoM1jsX2odLmtMrN/g1ZLTIWrCzaCX95x6KcyUPQy
        Jal8WWkRiPOlJbYGXOk5W6yF7/+EPitPcY7MkDVy6luTyMpM
X-Google-Smtp-Source: ABdhPJxMkp7hqqv3I2dwI0hXzDpC14N+S42aKLcvjqz/gNbtD8W4H+kcA3eSlev3KRyQ5d9if11EkQtt1ZeDyW+6UZe+HBcMUsAu
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2f01:: with SMTP id q1mr23200140iow.157.1636945405507;
 Sun, 14 Nov 2021 19:03:25 -0800 (PST)
Date:   Sun, 14 Nov 2021 19:03:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006982d305d0cb0d60@google.com>
Subject: [syzbot] INFO: task can't die in blk_mq_freeze_queue_wait
From:   syzbot <syzbot+81f844673361aa0541a0@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    09bd48c4acfa Add linux-next specific files for 20211115
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f0ace6b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17d226c7c2fec892
dashboard link: https://syzkaller.appspot.com/bug?extid=81f844673361aa0541a0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+81f844673361aa0541a0@syzkaller.appspotmail.com

INFO: task syz-executor.0:27209 can't die for more than 143 seconds.
task:syz-executor.0  state:D stack:29072 pid:27209 ppid: 21913 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4987 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6268
 schedule+0xd2/0x260 kernel/sched/core.c:6341
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 __loop_clr_fd+0x1ae/0x1070 drivers/block/loop.c:1122
 loop_clr_fd drivers/block/loop.c:1237 [inline]
 lo_ioctl+0x398/0x17c0 drivers/block/loop.c:1562
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6865788ae9
RSP: 002b:00007f6862cbc188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f686589c0e0 RCX: 00007f6865788ae9
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000004
RBP: 00007f68657e2f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffb0b4b25f R14: 00007f6862cbc300 R15: 0000000000022000
 </TASK>
INFO: task syz-executor.0:27209 blocked for more than 143 seconds.
      Not tainted 5.15.0-next-20211115-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:29072 pid:27209 ppid: 21913 flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4987 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6268
 schedule+0xd2/0x260 kernel/sched/core.c:6341
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 __loop_clr_fd+0x1ae/0x1070 drivers/block/loop.c:1122
 loop_clr_fd drivers/block/loop.c:1237 [inline]
 lo_ioctl+0x398/0x17c0 drivers/block/loop.c:1562
 blkdev_ioctl+0x37a/0x800 block/ioctl.c:609
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:874 [inline]
 __se_sys_ioctl fs/ioctl.c:860 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:860
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f6865788ae9
RSP: 002b:00007f6862cbc188 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f686589c0e0 RCX: 00007f6865788ae9
RDX: 0000000000000000 RSI: 0000000000004c01 RDI: 0000000000000004
RBP: 00007f68657e2f6d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffb0b4b25f R14: 00007f6862cbc300 R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/26:
 #0: ffffffff8bb83aa0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6387:
 #0: ffff8880733020f0 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
3 locks held by kworker/u4:7/14256:
2 locks held by agetty/24581:
 #0: ffff888073bbc098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:252
 #1: ffffc900050eb2e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcf0/0x1230 drivers/tty/n_tty.c:2113
2 locks held by systemd-udevd/26988:
 #0: ffff88801a814118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb50 block/bdev.c:819
 #1: ffff888147228360 (&lo->lo_mutex){+.+.}-{3:3}, at: lo_open+0x75/0x120 drivers/block/loop.c:1733
1 lock held by syz-executor.0/27209:
 #0: ffff888147228360 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x7a/0x1070 drivers/block/loop.c:1106

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 26 Comm: khungtaskd Not tainted 5.15.0-next-20211115-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:254 [inline]
 watchdog+0xcb7/0xed0 kernel/hung_task.c:339
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 2959 Comm: systemd-journal Not tainted 5.15.0-next-20211115-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:hash_name fs/namei.c:2154 [inline]
RIP: 0010:link_path_walk.part.0+0x387/0xd00 fs/namei.c:2243
Code: e8 7e a1 aa ff 4d 85 e4 74 83 4c 89 6c 24 18 4d 89 f5 4c 8b 74 24 20 e8 d7 9e aa ff 49 8d 4c 24 ff 4c 89 e2 4c 89 e8 48 f7 d2 <4c> 8b 6c 24 18 48 be 00 00 00 00 00 fc ff df 48 21 ca 48 b9 08 06
RSP: 0018:ffffc9000205fb58 EFLAGS: 00000293
RAX: 2f6c616e72756f6a RBX: ffff888011241490 RCX: 7fffffffffffffff
RDX: 7fffffffffffffff RSI: ffffffff81cd5049 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff81cd5032 R11: 0000000000000000 R12: 8000000000000000
R13: 2f6c616e72756f6a R14: ffffc9000205fce0 R15: ffff88804791c42d
FS:  00007f8032a248c0(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f80300b1000 CR3: 000000001c195000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 link_path_walk fs/namei.c:2221 [inline]
 path_lookupat+0xc8/0x860 fs/namei.c:2448
 filename_lookup+0x1c6/0x590 fs/namei.c:2478
 user_path_at_empty+0x42/0x60 fs/namei.c:2801
 user_path_at include/linux/namei.h:57 [inline]
 do_faccessat+0x127/0x850 fs/open.c:421
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f8031cdf9c7
Code: 83 c4 08 48 3d 01 f0 ff ff 73 01 c3 48 8b 0d c8 d4 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 b8 15 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a1 d4 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fff604c5b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00007fff604c8b50 RCX: 00007f8031cdf9c7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005634d00549a3
RBP: 00007fff604c5c70 R08: 00005634d004a3e5 R09: 0000000000000018
R10: 0000000000000069 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00005634d1f4d8a0 R15: 00007fff604c6160
 </TASK>
----------------
Code disassembly (best guess):
   0:	e8 7e a1 aa ff       	callq  0xffaaa183
   5:	4d 85 e4             	test   %r12,%r12
   8:	74 83                	je     0xffffff8d
   a:	4c 89 6c 24 18       	mov    %r13,0x18(%rsp)
   f:	4d 89 f5             	mov    %r14,%r13
  12:	4c 8b 74 24 20       	mov    0x20(%rsp),%r14
  17:	e8 d7 9e aa ff       	callq  0xffaa9ef3
  1c:	49 8d 4c 24 ff       	lea    -0x1(%r12),%rcx
  21:	4c 89 e2             	mov    %r12,%rdx
  24:	4c 89 e8             	mov    %r13,%rax
  27:	48 f7 d2             	not    %rdx
* 2a:	4c 8b 6c 24 18       	mov    0x18(%rsp),%r13 <-- trapping instruction
  2f:	48 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%rsi
  36:	fc ff df
  39:	48 21 ca             	and    %rcx,%rdx
  3c:	48                   	rex.W
  3d:	b9                   	.byte 0xb9
  3e:	08 06                	or     %al,(%rsi)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
