Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B0EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  7 Apr 2022 05:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiDGF02 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Apr 2022 01:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbiDGF01 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Apr 2022 01:26:27 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C48140DFD
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 22:24:27 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id b15-20020a05660214cf00b00648a910b964so2985336iow.19
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 22:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6h3kK7OMWXJ7ZGo7D+i1tV6qkth0/9+dQ+HOA5hS66Q=;
        b=VjEDva6Emk+a8jVup80Q4gerLgjPRG2CDB+NIqIXG1RNhuWvpkh9Rz1RwIn0oM9AF7
         chr7bRrE49nS0x3i2GWJ57YxZtn1WzujI8fbgsquTyfvHllai7GORx40XYglS2Kxr+L7
         PAIn5gfO7T/WAC4uFsdHTzLcGZLXEZzyZjCQXuT63TLm4rag8vvC5smgZ2Zpx6cZ5kbo
         5Tq/fUcyP6sagdhiofLcljOGM30uF8l329qAng5KxDRXTEyrMFlplX9J/RaNWTKiky5k
         KdcD0cNVbae4upZy1akeurN7AvwJ/8MvbNhe/EbEFdYVmUPUvYnzx2GDVd5y5fIMZ/QR
         H55A==
X-Gm-Message-State: AOAM532t9b0LlQF/VtDIW7rnqMc+gStq4WAPGqUUrbLy5oo5sklaqQZt
        dpdOrAFlH5zmzTeOpTjQ5ZqL7hyzUdfK4E+lW5clNb6OB9Rb
X-Google-Smtp-Source: ABdhPJwVDspb2CvuvqEZycs6xJ+GcEwBTxBPXr6bbMXMqQcq6QalIV5E0egEnRp+aDnnmZBDHkvQvKJXK+W8WA5aX94xjNbYEQ2R
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1382:b0:323:6602:6ec7 with SMTP id
 w2-20020a056638138200b0032366026ec7mr6587522jad.288.1649309066403; Wed, 06
 Apr 2022 22:24:26 -0700 (PDT)
Date:   Wed, 06 Apr 2022 22:24:26 -0700
In-Reply-To: <0000000000008af91005dabcad4f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000072a9f05dc09b177@google.com>
Subject: Re: [syzbot] INFO: task hung in nbd_add_socket (2)
From:   syzbot <syzbot+cbb4b1ebc70d0c5a8c29@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    3e732ebf7316 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171d476b700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa19d4c2766111a7
dashboard link: https://syzkaller.appspot.com/bug?extid=cbb4b1ebc70d0c5a8c29
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b3020f700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125d90a7700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cbb4b1ebc70d0c5a8c29@syzkaller.appspotmail.com

INFO: task syz-executor145:3630 blocked for more than 143 seconds.
      Not tainted 5.18.0-rc1-syzkaller-00016-g3e732ebf7316 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor145 state:D stack:28224 pid: 3630 ppid:  3624 flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5073 [inline]
 __schedule+0xa9a/0x4940 kernel/sched/core.c:6382
 schedule+0xd2/0x1f0 kernel/sched/core.c:6454
 blk_mq_freeze_queue_wait+0x112/0x160 block/blk-mq.c:179
 nbd_add_socket+0x166/0x810 drivers/block/nbd.c:1109
 __nbd_ioctl drivers/block/nbd.c:1454 [inline]
 nbd_ioctl+0x38c/0xb10 drivers/block/nbd.c:1511
 blkdev_ioctl+0x36e/0x800 block/ioctl.c:588
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f5f0d0f33e9
RSP: 002b:00007ffd5f102da8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000000764b6 RCX: 00007f5f0d0f33e9
RDX: 0000000000000005 RSI: 000000000000ab00 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffd5f102f48 R09: 00007ffd5f102f48
R10: 00007ffd5f102f48 R11: 0000000000000246 R12: 00007ffd5f102dbc
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/28:
 #0: ffffffff8bd7f360 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x53/0x260 kernel/locking/lockdep.c:6467
2 locks held by kworker/u4:2/50:
 #0: ffff8880b9c3a058 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2b/0x120 kernel/sched/core.c:554
 #1: ffff8880b9c278c8 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x3e7/0x4e0 kernel/sched/psi.c:889
2 locks held by getty/3275:
 #0: ffff888025c8d098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc90001bf92e8 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xcea/0x1230 drivers/tty/n_tty.c:2075
1 lock held by udevd/3626:
 #0: ffff88801c57c118 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0x99/0x950 block/bdev.c:905
1 lock held by syz-executor145/3630:
 #0: ffff88801c4f5198 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x151/0xb10 drivers/block/nbd.c:1504

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 5.18.0-rc1-syzkaller-00016-g3e732ebf7316 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x1e6/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:212 [inline]
 watchdog+0xc1d/0xf50 kernel/hung_task.c:369
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 50 Comm: kworker/u4:2 Not tainted 5.18.0-rc1-syzkaller-00016-g3e732ebf7316 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:lookup_chain_cache kernel/locking/lockdep.c:3696 [inline]
RIP: 0010:lookup_chain_cache_add kernel/locking/lockdep.c:3716 [inline]
RIP: 0010:validate_chain kernel/locking/lockdep.c:3771 [inline]
RIP: 0010:__lock_acquire+0x168a/0x56c0 kernel/locking/lockdep.c:5029
Code: ed 60 58 fa 8f 48 89 5c 24 10 0f 84 a6 03 00 00 48 8d 14 ed 60 58 fa 8f 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 <0f> 85 e4 2c 00 00 48 8b 1c ed 60 58 fa 8f 48 85 db 74 58 48 83 eb
RSP: 0018:ffffc90000dbf7b8 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: ffffffff8ffec728 RCX: ffffffff815c883e
RDX: 1ffffffff1ffd8e5 RSI: 0000000000000008 RDI: ffffffff90035900
RBP: 0000000000008dd9 R08: 0000000000000000 R09: ffffffff90035907
R10: fffffbfff2006b20 R11: 0000000000000001 R12: ffff888011c6abc0
R13: ffff888011c6a0c0 R14: 0000000000000000 R15: 623d1377ab3a24ec
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557e13d9c600 CR3: 000000000ba8e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5641 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5606
 __mutex_lock_common kernel/locking/mutex.c:600 [inline]
 __mutex_lock+0x12f/0x12f0 kernel/locking/mutex.c:733
 arch_jump_label_transform_queue+0x58/0x100 arch/x86/kernel/jump_label.c:136
 __jump_label_update+0x12e/0x400 kernel/jump_label.c:451
 jump_label_update+0x32f/0x410 kernel/jump_label.c:830
 static_key_disable_cpuslocked+0x152/0x1b0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate mm/kfence/core.c:799 [inline]
 toggle_allocation_gate+0x183/0x390 mm/kfence/core.c:777
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.077 msecs
----------------
Code disassembly (best guess), 5 bytes skipped:
   0:	48 89 5c 24 10       	mov    %rbx,0x10(%rsp)
   5:	0f 84 a6 03 00 00    	je     0x3b1
   b:	48 8d 14 ed 60 58 fa 	lea    -0x7005a7a0(,%rbp,8),%rdx
  12:	8f
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 c1 ea 03          	shr    $0x3,%rdx
  21:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
* 25:	0f 85 e4 2c 00 00    	jne    0x2d0f <-- trapping instruction
  2b:	48 8b 1c ed 60 58 fa 	mov    -0x7005a7a0(,%rbp,8),%rbx
  32:	8f
  33:	48 85 db             	test   %rbx,%rbx
  36:	74 58                	je     0x90
  38:	48                   	rex.W
  39:	83                   	.byte 0x83
  3a:	eb                   	.byte 0xeb

