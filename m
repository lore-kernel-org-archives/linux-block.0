Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67661C433F5
	for <linux-block@archiver.kernel.org>; Sun, 21 Nov 2021 04:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhKUFB2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Nov 2021 00:01:28 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:34742 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhKUFB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Nov 2021 00:01:28 -0500
Received: by mail-io1-f69.google.com with SMTP id i20-20020a0566022c9400b005ec5bb1e85eso8865149iow.1
        for <linux-block@vger.kernel.org>; Sat, 20 Nov 2021 20:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dql/mQT21Xn5uTk2H7K7jiSz1stq9yitA0pxzgY7x5Y=;
        b=dKkAYzj8a0s2c4hgo+/KSICaA8hmiKANWLZjL47tHPfmjIlvQW6TtdHp+sXyhpiiVY
         c6KkkPtnCnNhWvMMYNGtZ79+hWk3M82uIgwimnW+TiKSGgAJNmMfQDQcQgPzKBAqBTx/
         Szs7LTjUnTjKLNTz7rmcTvfB6Ao7qZyhsUORFZ0rujld+n1SBzd+KGGWfkdSuOXcgrZz
         bHGDQlfGTs7DWwMsk3OeiEk6RVdRoMjt0h/MkTl3fJWw3K3Zp07f13jGY+ZpwKbsCdkU
         zgYWZm+xWqtogLgUuRcQydlhOdLOfpdAz8C3dUvIBPjRzmvn1S9V3CUTFSNfGUpRLTjv
         HX6Q==
X-Gm-Message-State: AOAM530L+709y4IRX64t9GZgX5Q82V6/o+mPwJZ0uKgsmIVpg7wqDd6C
        a4B5wwMQJWzVGNNWXdDUoyDmKPOjVTKR3UHCQZs2JjUAIXkX
X-Google-Smtp-Source: ABdhPJy/a3XGaUPFR1Dr55TXOAp2/Ov7k9sELlKca3fZoS+E9C5xF2kIz8u65aj3Qa460o9eRoJ6s3JeVrlzaVmL1y7X5oTPKhFu
MIME-Version: 1.0
X-Received: by 2002:a6b:5c02:: with SMTP id z2mr14595232ioh.138.1637470703586;
 Sat, 20 Nov 2021 20:58:23 -0800 (PST)
Date:   Sat, 20 Nov 2021 20:58:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e104205d1455b77@google.com>
Subject: [syzbot] INFO: task hung in del_gendisk (2)
From:   syzbot <syzbot+14aea3976ea68c2c5f01@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a90af8f15bdc Merge tag 'libata-5.16-rc2' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13df9b11b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d3b8fd1977c1e73
dashboard link: https://syzkaller.appspot.com/bug?extid=14aea3976ea68c2c5f01
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14aea3976ea68c2c5f01@syzkaller.appspotmail.com

INFO: task kworker/u4:10:5840 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:10   state:D stack:26616 pid: 5840 ppid:     2 flags:0x00004000
Workqueue: nbd-del nbd_dev_remove_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 del_gendisk+0x598/0x860 block/genhd.c:623
 nbd_dev_remove+0x3c/0xf0 drivers/block/nbd.c:252
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>
INFO: task kworker/u4:15:6546 blocked for more than 143 seconds.
      Not tainted 5.16.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:15   state:D stack:27496 pid: 6546 ppid:     2 flags:0x00004000
Workqueue: nbd-del nbd_dev_remove_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:4972 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6253
 schedule+0xd2/0x260 kernel/sched/core.c:6326
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:178
 del_gendisk+0x598/0x860 block/genhd.c:623
 nbd_dev_remove+0x3c/0xf0 drivers/block/nbd.c:252
 process_one_work+0x9b2/0x1690 kernel/workqueue.c:2298
 worker_thread+0x658/0x11f0 kernel/workqueue.c:2445
 kthread+0x405/0x4f0 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/27:
 #0: ffffffff8bb83b60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6458
1 lock held by in:imklog/6233:
 #0: ffff888022de7270 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xe9/0x100 fs/file.c:990
5 locks held by agetty/6454:
2 locks held by kworker/u4:10/5840:
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc9000ba87db0 ((work_completion)(&nbd->remove_work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
2 locks held by kworker/u4:15/6546:
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff88801a512138 ((wq_completion)nbd-del){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90002fffdb0 ((work_completion)(&nbd->remove_work)){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
4 locks held by kworker/u4:16/6563:
 #0: ffff888011a03138 ((wq_completion)netns){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011a03138 ((wq_completion)netns){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011a03138 ((wq_completion)netns){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1198 [inline]
 #0: ffff888011a03138 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:635 [inline]
 #0: ffff888011a03138 ((wq_completion)netns){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:662 [inline]
 #0: ffff888011a03138 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x896/0x1690 kernel/workqueue.c:2269
 #1: ffffc90003127db0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x8ca/0x1690 kernel/workqueue.c:2273
 #2: ffffffff8d2f9290 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x9b/0xb00 net/core/net_namespace.c:555
 #3: ffffffff8bb8cdf0 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x44/0x440 kernel/rcu/tree.c:3985

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
CPU: 1 PID: 6454 Comm: agetty Not tainted 5.16.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:slow_down_io arch/x86/include/asm/paravirt.h:55 [inline]
RIP: 0010:outb_p arch/x86/include/asm/io.h:334 [inline]
RIP: 0010:vga_io_w include/video/vga.h:209 [inline]
RIP: 0010:setmask drivers/video/fbdev/vga16fb.c:139 [inline]
RIP: 0010:vga_8planes_imageblit drivers/video/fbdev/vga16fb.c:1141 [inline]
RIP: 0010:vga_imageblit_expand drivers/video/fbdev/vga16fb.c:1203 [inline]
RIP: 0010:vga16fb_imageblit+0x1c93/0x2aa0 drivers/video/fbdev/vga16fb.c:1260
Code: 5d 0c 44 89 f6 89 df e8 9b 1f 5d fd 41 39 de 0f 82 0c ff ff ff 48 8b 5c 24 58 e8 88 1c 5d fd ba cf 03 00 00 0f b6 44 24 48 ee <48> b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 80 3c 02 00 0f
RSP: 0018:ffffc90001cff4c0 EFLAGS: 00000293
RAX: 00000000000000ff RBX: ffffffff8b9f7d20 RCX: 0000000000000000
RDX: 00000000000003cf RSI: ffffffff841a7cd8 RDI: 0000000000000003
RBP: ffffc90001cff650 R08: 0000000000000010 R09: 0000000000000001
R10: ffffffff841a7cc5 R11: 0000000000000001 R12: dffffc0000000000
R13: ffff8880000a144a R14: 0000000000000010 R15: ffff888017e3c000
FS:  00007f84bd17a500(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bfa2d56160 CR3: 0000000019976000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 bit_putcs_unaligned drivers/video/fbdev/core/bitblit.c:124 [inline]
 bit_putcs+0x6e1/0xd20 drivers/video/fbdev/core/bitblit.c:173
 fbcon_putcs+0x353/0x440 drivers/video/fbdev/core/fbcon.c:1277
 fbcon_redraw.constprop.0+0x41a/0x4b0 drivers/video/fbdev/core/fbcon.c:1435
 fbcon_scroll+0x45c/0x610 drivers/video/fbdev/core/fbcon.c:1469
 con_scroll+0x5b9/0x6d0 drivers/tty/vt/vt.c:630
 lf+0x26b/0x2c0 drivers/tty/vt/vt.c:1507
 vc_con_write_normal drivers/tty/vt/vt.c:2851 [inline]
 do_con_write+0xf1c/0x1e40 drivers/tty/vt/vt.c:2955
 con_write+0x21/0x40 drivers/tty/vt/vt.c:3295
 n_tty_write+0xa7a/0xfd0 drivers/tty/n_tty.c:2311
 do_tty_write drivers/tty/tty_io.c:1038 [inline]
 file_tty_write.constprop.0+0x526/0x910 drivers/tty/tty_io.c:1110
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write+0x429/0x660 fs/read_write.c:503
 vfs_write+0x7cd/0xae0 fs/read_write.c:590
 ksys_write+0x12d/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f84bcc97970
Code: 73 01 c3 48 8b 0d 28 d5 2b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d 99 2d 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 7e 9b 01 00 48 89 04 24
RSP: 002b:00007ffddedd0448 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007f84bcc97970
RDX: 0000000000000009 RSI: 00007ffddedd0610 RDI: 0000000000000001
RBP: 00007ffddedd0610 R08: 00007f84bd17a500 R09: 0000000000000009
R10: 0000000000000073 R11: 0000000000000246 R12: 0000000000000009
R13: 0000000000000001 R14: 00007f84bcf56600 R15: 0000000000000009
 </TASK>
----------------
Code disassembly (best guess):
   0:	5d                   	pop    %rbp
   1:	0c 44                	or     $0x44,%al
   3:	89 f6                	mov    %esi,%esi
   5:	89 df                	mov    %ebx,%edi
   7:	e8 9b 1f 5d fd       	callq  0xfd5d1fa7
   c:	41 39 de             	cmp    %ebx,%r14d
   f:	0f 82 0c ff ff ff    	jb     0xffffff21
  15:	48 8b 5c 24 58       	mov    0x58(%rsp),%rbx
  1a:	e8 88 1c 5d fd       	callq  0xfd5d1ca7
  1f:	ba cf 03 00 00       	mov    $0x3cf,%edx
  24:	0f b6 44 24 48       	movzbl 0x48(%rsp),%eax
  29:	ee                   	out    %al,(%dx)
* 2a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax <-- trapping instruction
  31:	fc ff df
  34:	48 89 da             	mov    %rbx,%rdx
  37:	48 c1 ea 03          	shr    $0x3,%rdx
  3b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  3f:	0f                   	.byte 0xf


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
