Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BF4405
	for <linux-block@vger.kernel.org>; Sun,  4 Aug 2024 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722799344; cv=none; b=aL9uLl4OfSXZKwlYPyvrrsDAMibBGqeZuQo018wrlAlreS5p8ddmHSOlA6wLJCfP3N0lR3pJpwIlV4WIUGbroAdoYUdYxs01Hmw8rxQGiKsTrEQC9BDJeXxu59OFL1GiOk9ZuzaC5wRV9DB0g0DJCS3s2T3glA5KDZ3dNnu5CfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722799344; c=relaxed/simple;
	bh=eqO9O/U+ezaWHKsSVVQ5Rtl1/3E3Bq/K9jE6yinQxTw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CTFvmcPG0XRjRL/l7O1iCnA3F3EftHqRAa9tOZgkB0xiYzkPP8u/uyRZeq3hkDEtDB7EPMV0hloj5mF3DiTKyJoYMjSaGYcOt1TQm95dt+4vFbn5E7AOoudI5EmrQPr53zls9aF3TG2BV59zSNAulpAIugbc/1sgbtBsbke9VcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39a1ba36524so170525315ab.2
        for <linux-block@vger.kernel.org>; Sun, 04 Aug 2024 12:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722799342; x=1723404142;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/A+J7xlD8/4BM/PeMI1gThsqTCGBmQFhMnlnOukhRXQ=;
        b=MynuNYFFNmrEGnoCX/tDW15wX7rAp6nNzClPN8fu/h4bnra3ih+seb2X9pTZAQh+e9
         rTrtIz7ENlv6mTVVy7jr0DJjHKr51UlAjinyG6YpRWyyPqVGSbqKH/HZPX11prZBxoB9
         tbeC46RHYXRgvdqZsSpnfbCLA0NVSkUfuTzjdI92U9b4W9km513W7+/ZYfxx54zb/ojL
         K8umB+3TXTxHtIdKKkkHyGHkwR0Cm2nuef8mS1sQd+ymrbCzC0my/u7+ecC2L4Lmcbsf
         dHeny2EpQ/PLssQmetUgEE1fRQC0OLPtwuZUa0JNp3trrIG5s7wwDOfyO9CIlYw2b1M9
         /EXA==
X-Forwarded-Encrypted: i=1; AJvYcCWJMxDy1XftSByNlnrLCl46LZ1MtfMOuGiIycYLQhwVtbbE+8r3/yfsX+dJelptBiG5ALdfbkv4vJqU6qu0sUXtUCxr6AivPk1d2K4=
X-Gm-Message-State: AOJu0YxBIkUoNxZseAJqjJgHafxBgdjDHPr8gDthBPBa5KJR1AQ10gvj
	cfYOkg0dIR4iK4f3upJ0Rgm3mKA2SaOyzNqwMgj8k3zMhlHLXwtdINWPP3Y9IJ2xJ3DioOn8iVL
	21a2Av+Gi0dpT3giLB3APuXcXcoKOU7jq4x4hM0AAGc/+SdEIF5X6E8Q=
X-Google-Smtp-Source: AGHT+IG0V41pEe3LZ6JYEKtWPES055JcOIXiCNataT8OBLNTURDaXaCGtx3aKXiDGQUu1TadlPPN4n7w1Up23So1uW+HKDeZWiHt
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-39b1fc4cdf8mr8924395ab.4.1722799342162; Sun, 04 Aug 2024
 12:22:22 -0700 (PDT)
Date: Sun, 04 Aug 2024 12:22:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cf2c4c061ee07a3d@google.com>
Subject: [syzbot] [block?] INFO: task hung in read_part_sector (2)
From: syzbot <syzbot+82de77d3f217960f087d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e4fc196f5ba3 Merge tag 'for-6.11-rc1-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1684c2f9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=82de77d3f217960f087d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f74a212a2f92/disk-e4fc196f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa2d7ba62273/vmlinux-e4fc196f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e576f631aeff/bzImage-e4fc196f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+82de77d3f217960f087d@syzkaller.appspotmail.com

INFO: task syz.2.1619:12073 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00062-ge4fc196f5ba3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.1619      state:D stack:21344 pid:12073 tgid:12067 ppid:9918   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 io_schedule+0x8d/0x110 kernel/sched/core.c:7401
 folio_wait_bit_common+0x882/0x12b0 mm/filemap.c:1307
 folio_put_wait_locked mm/filemap.c:1471 [inline]
 do_read_cache_folio+0xb9/0x820 mm/filemap.c:3771
 read_mapping_folio include/linux/pagemap.h:913 [inline]
 read_part_sector+0xb3/0x330 block/partitions/core.c:712
 adfspart_check_POWERTEC+0xc8/0x8f0 block/partitions/acorn.c:454
 check_partition block/partitions/core.c:138 [inline]
 blk_add_partitions block/partitions/core.c:579 [inline]
 bdev_disk_changed+0x72c/0x13d0 block/partitions/core.c:683
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:700
 bdev_open+0x2d4/0xc60 block/bdev.c:909
 blkdev_open+0x3e8/0x570 block/fops.c:630
 do_dentry_open+0x970/0x1440 fs/open.c:959
 vfs_open+0x3e/0x330 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2b3e/0x3470 fs/namei.c:3886
 do_filp_open+0x235/0x490 fs/namei.c:3913
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f67a3975d50
RSP: 002b:00007f67a46b5b80 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f67a3975d50
RDX: 0000000000000000 RSI: 00007f67a46b5c20 RDI: 00000000ffffff9c
RBP: 00007f67a46b5c20 R08: 0000000000000000 R09: 002364626e2f7665
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 000000000000000b R14: 00007f67a3b05f80 R15: 00007ffded82e9c8
 </TASK>
INFO: task syz.2.1619:12091 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc1-syzkaller-00062-ge4fc196f5ba3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.1619      state:D stack:26648 pid:12091 tgid:12067 ppid:9918   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x17ae/0x4a10 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 bdev_release+0x184/0x700 block/bdev.c:1080
 blkdev_release+0x15/0x20 block/fops.c:638
 __fput+0x24a/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f67a39773b9
RSP: 002b:00007f67a4695048 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f67a3b06058 RCX: 00007f67a39773b9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00007f67a39e48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f67a3b06058 R15: 00007ffded82e9c8
 </TASK>

Showing all locks held in the system:
10 locks held by kworker/0:1/9:
1 lock held by khungtaskd/30:
 #0: ffffffff8e7377a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e7377a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e7377a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
3 locks held by kworker/0:2/1170:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000434fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000434fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa6d988 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
7 locks held by kworker/u8:14/3025:
 #0: ffff8880162e3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff8880162e3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009fbfd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009fbfd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa60e10 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffff8880202ea0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff8880202ea0e8 (&dev->mutex){....}-{3:3}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
 #3: ffff8880202ea0e8 (&dev->mutex){....}-{3:3}, at: devlink_pernet_pre_exit+0x13b/0x440 net/devlink/core.c:506
 #4: ffff888060074250 (&devlink->lock_key#42){+.+.}-{3:3}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff888060074250 (&devlink->lock_key#42){+.+.}-{3:3}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff888060074250 (&devlink->lock_key#42){+.+.}-{3:3}, at: devlink_pernet_pre_exit+0x14d/0x440 net/devlink/core.c:506
 #5: ffffffff8fa6d988 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
 #6: ffffffff8e73cb78 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:296 [inline]
 #6: ffffffff8e73cb78 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:958
2 locks held by getty/4971:
 #0: ffff88802ffd80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000311b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:5/5270:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003fdfd00 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003fdfd00 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff88801beb9240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x2d1/0x4130 drivers/net/netdevsim/fib.c:1489
3 locks held by kworker/1:12/8651:
 #0: ffff88801bac7148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88801bac7148 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900093f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900093f7d00 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff888023f43190 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888023f43190 (&dev->mutex){....}-{3:3}, at: hub_event+0x1fe/0x5150 drivers/usb/core/hub.c:5849
1 lock held by syz.2.1619/12073:
 #0: ffff888020b024c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_open+0xf0/0xc60 block/bdev.c:897
1 lock held by syz.2.1619/12091:
 #0: ffff888020b024c8 (&disk->open_mutex){+.+.}-{3:3}, at: bdev_release+0x184/0x700 block/bdev.c:1080
3 locks held by kworker/u8:5/15417:
 #0: ffff88802a980148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802a980148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90004557d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90004557d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fa6d988 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4194
1 lock held by syz-executor/19022:
 #0: ffffffff8e73ca40 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x530 kernel/rcu/tree.c:4486

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc1-syzkaller-00062-ge4fc196f5ba3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
