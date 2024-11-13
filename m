Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520797083B
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513329; cv=none; b=dfiOkb3CiodUuhpQm4v9ABPU48yrG65Fit8siRL5c8lgWyLoHM0j0LXF8XKApEWdBZaphCiTr8HvptGz0BDKqO564ey9BU24nK2To0aI3d/K4VWFgusSrbYz52CVcavhxj1z1XhUCWtF5HH1Jne6Ipmrup75GsZSQ+fvZjSvSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513329; c=relaxed/simple;
	bh=WSp0jYkcG4OGC0vi+eMWm3JC1+n5f6762+Bt2M5sLSs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OD6XEQCfmse5rO9ZoXYnaTgLJn66sirMfTXE94DBI66RonfaEfeztHgfV2gipQkNAcQEi4OI8POaV5We+HOrm14g8qet9H3rlBzOOgvzJPnGFDxGY/bsRl1NRDkPLrgnZVDHUKqrmk5pgRbeMLgPVozvrfaTU0dy6XKYbiaFnrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a715ac91f6so11054695ab.2
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 07:55:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513326; x=1732118126;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPWnRI6t0brlSRtIActra6oc5SwB9eStWnMjyfHfgfM=;
        b=q7i4urF1IKVk9xvVvpqOoVKVFNbo6oJTH/KjQq6SQzCv1J0nqdxRZCQNJqW6c5ss7V
         +RCH1qnRv+EjScBZnuqfw3n1DQW4lxcN2p4cd1Upy74eowmLKF9DpYutgybTLh4JyVmM
         kBiTHpnmOwentB6aluBLuAJ16Mlxzx5KYRSe6y1BHBa9RXA676E1HU4hp32psnsO+TD/
         prrWxRFPAejWq2Bt06tZkEOXGGmISJUSe5ZnwftBB5eHJo93XhODlRahIv8YFswGl3GZ
         MxTRYFGALFwVjImB/XadHx31UtXCPu1KehUDkaF5O+MY4Ab5P9UvHTpft6Y02aw/FFJA
         4FvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEk8qBSDZ5TrJi55zB3hzDGFtz8LNa3XRog1x+PGBdkQKtiLY1UHGD4qRf1O5jpaFTrjPQRG8lJrqIXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQcy5BZLQOOhgbN53Rpm3+KHglt2bi/3o0toRM9CiQ5kWiRUv2
	ZrszIhp65ReKSAN+PemBBkzfbEDzXLWyy4MQKUt/gw2kB9Y+/F2Aq9KZcc3oVH+/O8PQSn4yvf4
	iCjb9fQYaBQTbXg9JnO/FxRadVjmcRgjd1B2vT+ZBG9w9fhISUqfS1+U=
X-Google-Smtp-Source: AGHT+IG2TD8UmlX8Wnk2U8iYJQnxRHY1IEfsTx6BJBZOuvLN5F+GuGJSmX7UlFt4/gEeIW5xQh7OYll2yLQNLE4+7ix0WhVNRqcP
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:680d:0:b0:3a7:18ac:1fd1 with SMTP id
 e9e14a558f8ab-3a718ac209fmr18203455ab.2.1731513326375; Wed, 13 Nov 2024
 07:55:26 -0800 (PST)
Date: Wed, 13 Nov 2024 07:55:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6734cbee.050a0220.1324f8.0062.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_mq_init_sched
From: syzbot <syzbot+707309ac8bd9751f602f@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=110f9e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=707309ac8bd9751f602f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/disk-929beafb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinux-929beafb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/bzImage-929beafb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+707309ac8bd9751f602f@syzkaller.appspotmail.com

sd 1:0:0:0: [sdb] 0 512-byte logical blocks: (0 B/0 B)
sd 1:0:0:0: [sdb] 0-byte physical blocks
sd 1:0:0:0: [sdb] Test WP failed, assume Write Enabled
sd 1:0:0:0: [sdb] Asking for cache data failed
sd 1:0:0:0: [sdb] Assuming drive cache: write through
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc6-next-20241108-syzkaller #0 Not tainted
------------------------------------------------------
kworker/u8:1/12200 is trying to acquire lock:
ffff888028ce3010 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473

but task is already holding lock:
ffff888028ce27e0 (&q->q_usage_counter(queue)#52){++++}-{0:0}, at: add_disk_fwnode+0x10d/0xf80 block/genhd.c:413

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&q->q_usage_counter(queue)#52){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       blk_queue_enter+0xe1/0x600 block/blk-core.c:328
       blk_mq_alloc_request+0x26b/0xab0 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
       read_capacity_10+0x256/0x9c0 drivers/scsi/sd.c:2766
       sd_read_capacity drivers/scsi/sd.c:2834 [inline]
       sd_revalidate_disk+0x106c/0xbcf0 drivers/scsi/sd.c:3734
       sd_probe+0x9fa/0x1100 drivers/scsi/sd.c:4010
       really_probe+0x2b8/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #4 (&q->limits_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:944 [inline]
       __nbd_set_size drivers/block/nbd.c:351 [inline]
       nbd_set_size+0x2cd/0x8a0 drivers/block/nbd.c:388
       nbd_start_device_ioctl drivers/block/nbd.c:1464 [inline]
       __nbd_ioctl drivers/block/nbd.c:1539 [inline]
       nbd_ioctl+0x5dc/0xf40 drivers/block/nbd.c:1579
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&q->q_usage_counter(io)#56){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3095
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2446
       filemap_read_folio+0x14b/0x630 mm/filemap.c:2366
       filemap_update_page mm/filemap.c:2450 [inline]
       filemap_get_pages+0x17af/0x2540 mm/filemap.c:2571
       filemap_read+0x46b/0xf50 mm/filemap.c:2646
       blkdev_read_iter+0x2d8/0x430 block/fops.c:767
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x991/0xb70 fs/read_write.c:565
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (mapping.invalidate_lock#2){.+.+}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:872 [inline]
       filemap_fault+0x6e8/0x1950 mm/filemap.c:3332
       __do_fault+0x135/0x460 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x3c01/0x66b0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       faultin_page mm/gup.c:1187 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1485
       populate_vma_page_range+0x264/0x330 mm/gup.c:1923
       __mm_populate+0x27a/0x460 mm/gup.c:2026
       mm_populate include/linux/mm.h:3386 [inline]
       vm_mmap_pgoff+0x303/0x430 mm/util.c:585
       ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_setup+0xd2/0x1e0 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
       sg_ioctl+0xa46/0x2e80 drivers/scsi/sg.c:1156
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&q->debugfs_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
       elevator_init_mq+0x20e/0x320 block/elevator.c:610
       add_disk_fwnode+0x10d/0xf80 block/genhd.c:413
       sd_probe+0xba6/0x1100 drivers/scsi/sd.c:4024
       really_probe+0x2b8/0xad0 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
       bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &q->debugfs_mutex --> &q->limits_lock --> &q->q_usage_counter(queue)#52

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(queue)#52);
                               lock(&q->limits_lock);
                               lock(&q->q_usage_counter(queue)#52);
  lock(&q->debugfs_mutex);

 *** DEADLOCK ***

4 locks held by kworker/u8:1/12200:
 #0: ffff88801daf1148 ((wq_completion)async){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801daf1148 ((wq_completion)async){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000c26fd00 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000c26fd00 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff888044462378 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:1014 [inline]
 #2: ffff888044462378 (&dev->mutex){....}-{4:4}, at: __device_attach_async_helper+0xfc/0x300 drivers/base/dd.c:973
 #3: ffff888028ce27e0 (&q->q_usage_counter(queue)#52){++++}-{0:0}, at: add_disk_fwnode+0x10d/0xf80 block/genhd.c:413

stack backtrace:
CPU: 1 UID: 0 PID: 12200 Comm: kworker/u8:1 Not tainted 6.12.0-rc6-next-20241108-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
Workqueue: async async_run_entry_fn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
 elevator_init_mq+0x20e/0x320 block/elevator.c:610
 add_disk_fwnode+0x10d/0xf80 block/genhd.c:413
 sd_probe+0xba6/0x1100 drivers/scsi/sd.c:4024
 really_probe+0x2b8/0xad0 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x390 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:459
 __device_attach_async_helper+0x22d/0x300 drivers/base/dd.c:987
 async_run_entry_fn+0xa8/0x420 kernel/async.c:129
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
sd 1:0:0:0: [sdb] Attached SCSI removable disk


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
