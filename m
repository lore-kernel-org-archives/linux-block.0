Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4049E1FF029
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421530; cv=none; b=uxZHpxmn5doG4DflK3yVo1pfh9qZiz+XWMxNB/e+tacLhhp87rqlew0cFUijwwVfe+5sxGqjmZcq1JcaIVbGxzcU8CpRGPI2ZRlV06B+xiCy+svk9XV2tP59Dmlum3AkI2CcrpmDlE9AxCARN5fOs5czXXrADqniuWRnzGq7blw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421530; c=relaxed/simple;
	bh=opc63+1a387c6eJzaCZK4CudI7RCmicRWjdBK7+z5y0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rcbhueW3B65+oZ+ogVRuQujl59mF+rWYJLa3Rc9/f5ocQ97ISmkQ6CtmshbnRaiHdLsYwEkN1jAXd2VH8DnyNug64fwx75WOP2J5u5FG772GNtwPuhwi2/dJqAPnZdgOKPJzHBWbVCER6K30KyNPKUJUpl9GKjdY2HJEk7K3NFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so65659905ab.1
        for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 06:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421527; x=1732026327;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQBnVaNuIwdjF2ELzeFCAF+PueKA88s1tSeqeNjkx5s=;
        b=R1Sj3oKpYiezLQppxqrOXPRFATdLDyg2sdSeETRh4nalc+DP8T2QII1bDGO61sM9Zj
         JNt3gdMLm2B0YgTUTWQYGvSZ9+/8LC1kL8FFj3HWkDbMclRSUHw6jkpx1NbGZl7LqILp
         bKAOJ6qblWa9YJ48lfpyIG6YHEVhnGLPdiMoYEXz+bUXrOdh1Uf09+JHpSvxODtDVcOU
         jBGnBzABHvOgXW10Pb2+IXly5307Dj1UHls2CuQix5QQMaslHyebcoCbMMnUDM/BU5o2
         SdLaF4jhKDuCMEZw1aBSeOBG18Ks/EJXIjAuX/9Q64vde830SvF2tnnj4NW7O7nr5eRC
         2r+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJx4Y9vaI8n4Vn4KksmffSc1j9N7Qrr0PbUZY8w1gI10WN+OufCaKHSQX7/ApQ5OjFenpAxwRoCJ9agQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNn+N+UUqruquJKFQoRKssfMyW/MI6+2fqc+SEUVII+ADxNY5
	kdt00o4ZlWropB6r5+QyKMtz4s+3MWTvPxOKsvzu9+XTGmO94Oda6mnQabJGhFYxBdNtz2TFjxE
	54nSaxRmow1k9x9QXsuO2u6eN8KKoPCsUk4z6+/D2LB7MYmrmecR1njE=
X-Google-Smtp-Source: AGHT+IEbSt3xE9QAuN1C9UARlmORouhpt3EKR3UpTYJmCr7poX2F1cThp+Af8u5dd+Y1fyw6Qz3R40b+tqufaX+L7NZI0Z72laKw
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d19:b0:3a6:ac4e:2659 with SMTP id
 e9e14a558f8ab-3a6f19c2ac8mr170066375ab.6.1731421527354; Tue, 12 Nov 2024
 06:25:27 -0800 (PST)
Date: Tue, 12 Nov 2024 06:25:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67336557.050a0220.a0661.041e.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in loop_reconfigure_limits
From: syzbot <syzbot+867b0179d31db9955876@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    929beafbe7ac Add linux-next specific files for 20241108
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16b520c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=75175323f2078363
dashboard link: https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b520c0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9705ecb6a595/disk-929beafb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dbdd1f64b9b8/vmlinux-929beafb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f70d07a929b/bzImage-929beafb.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7589a4f7020b/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+867b0179d31db9955876@syzkaller.appspotmail.com

EXT4-fs error (device loop5): ext4_free_branches:1023: inode #11: comm syz.5.30: invalid indirect mapped block 256 (level 2)
EXT4-fs (loop5): 2 truncates cleaned up
EXT4-fs (loop5): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc6-next-20241108-syzkaller #0 Not tainted
------------------------------------------------------
syz.5.30/6638 is trying to acquire lock:
ffff888142bbd4f0 (&q->limits_lock){+.+.}-{4:4}, at: queue_limits_start_update include/linux/blkdev.h:944 [inline]
ffff888142bbd4f0 (&q->limits_lock){+.+.}-{4:4}, at: loop_reconfigure_limits+0x287/0x9f0 drivers/block/loop.c:1003

but task is already holding lock:
ffff888142bbcea8 (&q->q_usage_counter(io)#22){++++}-{0:0}, at: loop_set_block_size drivers/block/loop.c:1472 [inline]
ffff888142bbcea8 (&q->q_usage_counter(io)#22){++++}-{0:0}, at: lo_simple_ioctl drivers/block/loop.c:1496 [inline]
ffff888142bbcea8 (&q->q_usage_counter(io)#22){++++}-{0:0}, at: lo_ioctl+0x1344/0x1f50 drivers/block/loop.c:1559

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&q->q_usage_counter(io)#22){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3095
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       ext4_commit_super+0x2e0/0x450 fs/ext4/super.c:6230
       ext4_handle_error+0x71a/0x8e0 fs/ext4/super.c:727
       __ext4_error_inode+0x322/0x4f0 fs/ext4/super.c:869
       ext4_free_branches+0x686/0x6e0 fs/ext4/indirect.c:1020
       ext4_ind_truncate+0x7c7/0xd60 fs/ext4/indirect.c:1164
       ext4_truncate+0x9f0/0x11c0 fs/ext4/inode.c:4219
       ext4_process_orphan+0x1aa/0x2d0 fs/ext4/orphan.c:339
       ext4_orphan_cleanup+0xb77/0x13d0 fs/ext4/orphan.c:474
       __ext4_fill_super fs/ext4/super.c:5604 [inline]
       ext4_fill_super+0x64dc/0x6e60 fs/ext4/super.c:5727
       get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
       vfs_get_tree+0x90/0x2b0 fs/super.c:1814
       do_new_mount+0x2be/0xb40 fs/namespace.c:3507
       do_mount fs/namespace.c:3847 [inline]
       __do_sys_mount fs/namespace.c:4057 [inline]
       __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4034
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&ei->i_data_sem){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       ext4_map_blocks+0x7a6/0x1990 fs/ext4/inode.c:701
       mpage_map_one_extent fs/ext4/inode.c:2219 [inline]
       mpage_map_and_submit_extent fs/ext4/inode.c:2272 [inline]
       ext4_do_writepages+0x20f7/0x3d20 fs/ext4/inode.c:2735
       ext4_writepages+0x213/0x3c0 fs/ext4/inode.c:2824
       do_writepages+0x35d/0x870 mm/page-writeback.c:2702
       __writeback_single_inode+0x14f/0x10d0 fs/fs-writeback.c:1656
       writeback_sb_inodes+0x80c/0x1370 fs/fs-writeback.c:1952
       __writeback_inodes_wb+0x11b/0x260 fs/fs-writeback.c:2023
       wb_writeback+0x42f/0xbd0 fs/fs-writeback.c:2134
       wb_check_old_data_flush fs/fs-writeback.c:2238 [inline]
       wb_do_writeback fs/fs-writeback.c:2291 [inline]
       wb_workfn+0xba1/0x1090 fs/fs-writeback.c:2319
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #4 (jbd2_handle){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       start_this_handle+0x1eb4/0x2110 fs/jbd2/transaction.c:448
       jbd2__journal_start+0x2da/0x5d0 fs/jbd2/transaction.c:505
       __ext4_journal_start_sb+0x239/0x600 fs/ext4/ext4_jbd2.c:112
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0x92/0x110 fs/ext4/inode.c:6038
       __mark_inode_dirty+0x2ee/0xe90 fs/fs-writeback.c:2491
       generic_update_time fs/inode.c:2110 [inline]
       inode_update_time fs/inode.c:2123 [inline]
       touch_atime+0x413/0x690 fs/inode.c:2195
       file_accessed include/linux/fs.h:2538 [inline]
       ext4_file_mmap+0x18c/0x540 fs/ext4/file.c:816
       call_mmap include/linux/fs.h:2182 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2291 [inline]
       __mmap_new_vma mm/vma.c:2355 [inline]
       __mmap_region+0x2204/0x2cd0 mm/vma.c:2456
       mmap_region+0x226/0x2c0 mm/mmap.c:1347
       do_mmap+0x8f0/0x1000 mm/mmap.c:496
       vm_mmap_pgoff+0x214/0x430 mm/util.c:580
       ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&mm->mmap_lock){++++}-{4:4}:
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

-> #2 (&q->debugfs_mutex){+.+.}-{4:4}:
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

-> #1 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       blk_queue_enter+0xe1/0x600 block/blk-core.c:328
       blk_mq_alloc_request+0x26b/0xab0 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x177/0x1090 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x2b4/0x1450 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk+0x1019/0xbcf0 drivers/scsi/sd.c:3734
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

-> #0 (&q->limits_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:944 [inline]
       loop_reconfigure_limits+0x287/0x9f0 drivers/block/loop.c:1003
       loop_set_block_size drivers/block/loop.c:1473 [inline]
       lo_simple_ioctl drivers/block/loop.c:1496 [inline]
       lo_ioctl+0x1351/0x1f50 drivers/block/loop.c:1559
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->limits_lock --> &ei->i_data_sem --> &q->q_usage_counter(io)#22

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#22);
                               lock(&ei->i_data_sem);
                               lock(&q->q_usage_counter(io)#22);
  lock(&q->limits_lock);

 *** DEADLOCK ***

3 locks held by syz.5.30/6638:
 #0: ffff888025239360 (&lo->lo_mutex){+.+.}-{4:4}, at: lo_simple_ioctl drivers/block/loop.c:1485 [inline]
 #0: ffff888025239360 (&lo->lo_mutex){+.+.}-{4:4}, at: lo_ioctl+0x606/0x1f50 drivers/block/loop.c:1559
 #1: ffff888142bbcea8 (&q->q_usage_counter(io)#22){++++}-{0:0}, at: loop_set_block_size drivers/block/loop.c:1472 [inline]
 #1: ffff888142bbcea8 (&q->q_usage_counter(io)#22){++++}-{0:0}, at: lo_simple_ioctl drivers/block/loop.c:1496 [inline]
 #1: ffff888142bbcea8 (&q->q_usage_counter(io)#22){++++}-{0:0}, at: lo_ioctl+0x1344/0x1f50 drivers/block/loop.c:1559
 #2: ffff888142bbcee0 (&q->q_usage_counter(queue)#6){+.+.}-{0:0}, at: loop_set_block_size drivers/block/loop.c:1472 [inline]
 #2: ffff888142bbcee0 (&q->q_usage_counter(queue)#6){+.+.}-{0:0}, at: lo_simple_ioctl drivers/block/loop.c:1496 [inline]
 #2: ffff888142bbcee0 (&q->q_usage_counter(queue)#6){+.+.}-{0:0}, at: lo_ioctl+0x1344/0x1f50 drivers/block/loop.c:1559

stack backtrace:
CPU: 0 UID: 0 PID: 6638 Comm: syz.5.30 Not tainted 6.12.0-rc6-next-20241108-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
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
 queue_limits_start_update include/linux/blkdev.h:944 [inline]
 loop_reconfigure_limits+0x287/0x9f0 drivers/block/loop.c:1003
 loop_set_block_size drivers/block/loop.c:1473 [inline]
 lo_simple_ioctl drivers/block/loop.c:1496 [inline]
 lo_ioctl+0x1351/0x1f50 drivers/block/loop.c:1559
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed9c97e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe65076c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fed9cb35f80 RCX: 00007fed9c97e719
RDX: 0000000000000000 RSI: 0000000000004c09 RDI: 0000000000000005
RBP: 00007fed9c9f139e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fed9cb35f80 R14: 00007fed9cb35f80 R15: 00000000000006cf
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
