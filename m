Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC935126C05
	for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732960232; cv=none; b=CsLQLHnd474yEn2WRVqeLDothKTbnce50enm41O5Wayv53V0ABt01WU+AgisSKms2ef+SPLlCYeEr0LaWO5qicMfI47grRZs6INZt3+FQWmJRvF/mzkJf8JjnbUKAtBPwTlH82Dq/4AyTLc7g7fBKWF2uYhhX019Qwh2QzTPhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732960232; c=relaxed/simple;
	bh=Hg1BNE2iABhTVLUsOpJCRYiRmHcPcrnz7rPjBm15PoU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=K9M36d2frE94p9qKRek1WkoDkPMMvAlyMAZhCpRD+bTzi/N9lhpkpSggKYMx5/+3jChY1TyIYtdWrEsCjQxJsDYhiEpTBFm2lPX16JJQK1+vWuLhu+KPVrRoY0AlN/3uaK02tEx/SYhtlQB0sXlQ0smnWNxgF8iqYOa/zGj6e38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7932544c4so23250955ab.1
        for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 01:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732960230; x=1733565030;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGyfwm0WG9rKDOVFNTPEGU4TLfZ7NEwP9shCIjXZ81Y=;
        b=IxcDAOUCzZtSuur9c01C6ZJAf3Bx3ha89GjYqODeNheA3xb/E3dPzu2ibNgBvNofgo
         6FpsvTCCsP3w0LQ8zAEAVgN4Wd/SmtvsCAIuQyp1KRmRr+xUxOTPOsLcNpk5yAdztxKr
         cRPle40xVSZwfwEjvZ3YdiMR+8Z/ZMwmr5DaXJVAhXxKGQ6N42bEJ0WMvuiUjwlk/vic
         L3i5W3BkajZfpqXXj8VTxrZVctKrM9gUxPqCo7ueYZ/e2bZLR86RUQt65nU5QzIUL4Oz
         LxynUlzCCk3DK8jJZCxMYNUIU7S+cMDWkzIFIwUczfUW7DnHNidlfMuq14zFuUxPXOIa
         WEcw==
X-Forwarded-Encrypted: i=1; AJvYcCWX+FXjup+baCl8vmYapZWhT5/iSzlty7CwoO4Y/sSvFozqXNXL6O8nNJDEdi2T8JAvVhN/xWKqSW1oKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8pmlAzClG520hGaUocgbThbkXXwSRtQusPXej4nzLK8GnjzSf
	A7faB1IR/iQ37M6dnSb9EnngZzkgMcsJHVNgwYqeUIqqdL+5jfbaEhP4yz66JuB7TyjyfmPwtZC
	PRi9sHiTUPi2xCMnC214xoffWidZq++cgIcGHbbVjOirX6GSTOJXGz8o=
X-Google-Smtp-Source: AGHT+IEBVsNTgsT2iGvpLskh6z14/S0VmZoNNuTG8TuERiz6H2yo6vV7c7HPpcczSaqXPXY++WqrelnUIgwEMhTgR0qnxvyyFoCb
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2686:b0:3a7:c5ca:5f58 with SMTP id
 e9e14a558f8ab-3a7c5ca6175mr133532355ab.7.1732960229967; Sat, 30 Nov 2024
 01:50:29 -0800 (PST)
Date: Sat, 30 Nov 2024 01:50:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674adfe5.050a0220.253251.00da.GAE@google.com>
Subject: [syzbot] [block?] [trace?] possible deadlock in do_page_mkwrite (2)
From: syzbot <syzbot+1682a0f52e34640bb386@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11da21e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7de3ed028e6710
dashboard link: https://syzkaller.appspot.com/bug?extid=1682a0f52e34640bb386
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/450015008b3e/disk-7eef7e30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9bea6e0ac594/vmlinux-7eef7e30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e1b46c65494c/bzImage-7eef7e30.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1682a0f52e34640bb386@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-09567-g7eef7e306d3c #0 Not tainted
------------------------------------------------------
syz.5.3623/19452 is trying to acquire lock:
ffff88805e392518 (sb_pagefaults){++++}-{0:0}, at: do_page_mkwrite+0x17a/0x380 mm/memory.c:3176

but task is already holding lock:
ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/memory.c:6149 [inline]
ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x35/0x6a0 mm/memory.c:6209

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault mm/memory.c:6751 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6744
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x29/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
       blk_trace_setup+0x47/0x70 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1114 [inline]
       sg_ioctl+0x65e/0x2750 drivers/scsi/sg.c:1156
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&q->debugfs_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x42b/0x640 block/blk-mq-sched.c:473
       elevator_init_mq+0x2cd/0x420 block/elevator.c:610
       add_disk_fwnode+0x113/0x1300 block/genhd.c:413
       sd_probe+0xa86/0x1000 drivers/scsi/sd.c:4024
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x241/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
       bus_for_each_drv+0x15a/0x1e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:987
       async_run_entry_fn+0x9f/0x530 kernel/async.c:129
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #4 (&q->q_usage_counter(queue)#50){++++}-{0:0}:
       blk_queue_enter+0x50f/0x640 block/blk-core.c:328
       blk_mq_alloc_request+0x59b/0x950 block/blk-mq.c:652
       scsi_alloc_request drivers/scsi/scsi_lib.c:1222 [inline]
       scsi_execute_cmd+0x1eb/0xf40 drivers/scsi/scsi_lib.c:304
       read_capacity_16+0x213/0xe10 drivers/scsi/sd.c:2655
       sd_read_capacity drivers/scsi/sd.c:2824 [inline]
       sd_revalidate_disk.isra.0+0x1a06/0xa8d0 drivers/scsi/sd.c:3734
       sd_probe+0x904/0x1000 drivers/scsi/sd.c:4010
       call_driver_probe drivers/base/dd.c:579 [inline]
       really_probe+0x241/0xa90 drivers/base/dd.c:658
       __driver_probe_device+0x1de/0x440 drivers/base/dd.c:800
       driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:830
       __device_attach_driver+0x1df/0x310 drivers/base/dd.c:958
       bus_for_each_drv+0x15a/0x1e0 drivers/base/bus.c:459
       __device_attach_async_helper+0x1d3/0x290 drivers/base/dd.c:987
       async_run_entry_fn+0x9f/0x530 kernel/async.c:129
       process_one_work+0x9c8/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c4/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #3 (&q->limits_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       queue_limits_start_update include/linux/blkdev.h:945 [inline]
       loop_reconfigure_limits+0x2da/0x8d0 drivers/block/loop.c:1003
       loop_set_block_size drivers/block/loop.c:1473 [inline]
       lo_simple_ioctl drivers/block/loop.c:1496 [inline]
       lo_ioctl+0x901/0x18b0 drivers/block/loop.c:1559
       blkdev_ioctl+0x279/0x6d0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#24){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1fb6/0x24c0 block/blk-mq.c:3092
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       ext4_mpage_readpages+0x1408/0x1880 fs/ext4/readpage.c:371
       ext4_readahead+0x102/0x140 fs/ext4/inode.c:3201
       read_pages+0x1ab/0xdc0 mm/readahead.c:160
       page_cache_ra_unbounded+0x3dc/0x750 mm/readahead.c:295
       do_page_cache_ra mm/readahead.c:325 [inline]
       page_cache_ra_order+0x7d9/0xc90 mm/readahead.c:525
       page_cache_sync_ra+0x4b4/0x9c0 mm/readahead.c:613
       page_cache_sync_readahead include/linux/pagemap.h:1397 [inline]
       filemap_get_pages+0xd7b/0x1be0 mm/filemap.c:2546
       filemap_read+0x3ca/0xd70 mm/filemap.c:2646
       generic_file_read_iter+0x344/0x450 mm/filemap.c:2834
       ext4_file_read_iter+0x1d6/0x6a0 fs/ext4/file.c:147
       __kernel_read+0x3f4/0xb50 fs/read_write.c:523
       integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x2c9/0x3e0 security/integrity/ima/ima_crypto.c:480
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:511 [inline]
       ima_calc_file_hash+0x1ba/0x490 security/integrity/ima/ima_crypto.c:568
       ima_collect_measurement+0x89f/0xa40 security/integrity/ima/ima_api.c:293
       process_measurement+0x1271/0x2370 security/integrity/ima/ima_main.c:372
       ima_file_check+0xc6/0x110 security/integrity/ima/ima_main.c:572
       security_file_post_open+0x8e/0x210 security/security.c:3121
       do_open fs/namei.c:3830 [inline]
       path_openat+0x1419/0x2d60 fs/namei.c:3987
       do_filp_open+0x20c/0x470 fs/namei.c:4014
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_open fs/open.c:1425 [inline]
       __se_sys_open fs/open.c:1421 [inline]
       __x64_sys_open+0x154/0x1e0 fs/open.c:1421
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (mapping.invalidate_lock){++++}-{4:4}:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       ext4_page_mkwrite+0x37e/0x1760 fs/ext4/inode.c:6161
       do_page_mkwrite+0x17a/0x380 mm/memory.c:3176
       wp_page_shared mm/memory.c:3577 [inline]
       do_wp_page+0xc4b/0x47c0 mm/memory.c:3727
       handle_pte_fault mm/memory.c:5817 [inline]
       __handle_mm_fault+0x1ade/0x2a40 mm/memory.c:5944
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
       do_user_addr_fault+0x60d/0x13f0 arch/x86/mm/fault.c:1338
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #0 (sb_pagefaults){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1725 [inline]
       sb_start_pagefault include/linux/fs.h:1890 [inline]
       ext4_page_mkwrite+0x261/0x1760 fs/ext4/inode.c:6158
       do_page_mkwrite+0x17a/0x380 mm/memory.c:3176
       wp_page_shared mm/memory.c:3577 [inline]
       do_wp_page+0xc4b/0x47c0 mm/memory.c:3727
       handle_pte_fault mm/memory.c:5817 [inline]
       __handle_mm_fault+0x1ade/0x2a40 mm/memory.c:5944
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
       do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       __put_user_4+0x11/0x20 arch/x86/lib/putuser.S:86
       mISDN_ioctl+0x79e/0xa20 drivers/isdn/mISDN/timerdev.c:252
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_pagefaults --> &q->debugfs_mutex --> &mm->mmap_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&mm->mmap_lock);
                               lock(&q->debugfs_mutex);
                               lock(&mm->mmap_lock);
  rlock(sb_pagefaults);

 *** DEADLOCK ***

2 locks held by syz.5.3623/19452:
 #0: ffffffff8faccaa8 (mISDN_mutex){+.+.}-{4:4}, at: mISDN_ioctl+0xa5/0xa20 drivers/isdn/mISDN/timerdev.c:226
 #1: ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_read_trylock include/linux/mmap_lock.h:163 [inline]
 #1: ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: get_mmap_lock_carefully mm/memory.c:6149 [inline]
 #1: ffff888035510ba0 (&mm->mmap_lock){++++}-{4:4}, at: lock_mm_and_find_vma+0x35/0x6a0 mm/memory.c:6209

stack backtrace:
CPU: 0 UID: 0 PID: 19452 Comm: syz.5.3623 Not tainted 6.12.0-syzkaller-09567-g7eef7e306d3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x419/0x5d0 kernel/locking/lockdep.c:2074
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain kernel/locking/lockdep.c:3904 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1725 [inline]
 sb_start_pagefault include/linux/fs.h:1890 [inline]
 ext4_page_mkwrite+0x261/0x1760 fs/ext4/inode.c:6158
 do_page_mkwrite+0x17a/0x380 mm/memory.c:3176
 wp_page_shared mm/memory.c:3577 [inline]
 do_wp_page+0xc4b/0x47c0 mm/memory.c:3727
 handle_pte_fault mm/memory.c:5817 [inline]
 __handle_mm_fault+0x1ade/0x2a40 mm/memory.c:5944
 handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
 do_user_addr_fault+0x7a3/0x13f0 arch/x86/mm/fault.c:1389
 handle_page_fault arch/x86/mm/fault.c:1481 [inline]
 exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1539
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:__put_user_4+0x11/0x20 arch/x86/lib/putuser.S:88
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 89 cb 48 c1 fb 3f 48 09 d9 0f 01 cb <89> 01 31 c9 0f 01 ca e9 fe 24 2f 00 0f 1f 00 90 90 90 90 90 90 90
RSP: 0018:ffffc9000407fe88 EFLAGS: 00050202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000020008380
RDX: 0000000000080000 RSI: ffffffff881f94b2 RDI: ffffffff8bd1c7c0
RBP: ffff888033c71501 R08: 0000000000000000 R09: fffffbfff20c1692
R10: ffffffff9060b497 R11: 0000000000000001 R12: 0000000000000000
R13: ffff888033c71500 R14: 0000000000000000 R15: 0000000020008380
 mISDN_ioctl+0x79e/0xa20 drivers/isdn/mISDN/timerdev.c:252
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb3d517e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb3d5f0f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb3d5335fa0 RCX: 00007fb3d517e819
RDX: 0000000020008380 RSI: 0000000080044940 RDI: 0000000000000005
RBP: 00007fb3d51f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb3d5335fa0 R15: 00007ffe029943c8
 </TASK>
EXT4-fs (loop5): unmounting filesystem 00000000-0000-0000-0000-000000000000.
----------------
Code disassembly (best guess):
   0:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
   7:	00
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	f3 0f 1e fa          	endbr64
  1d:	48 89 cb             	mov    %rcx,%rbx
  20:	48 c1 fb 3f          	sar    $0x3f,%rbx
  24:	48 09 d9             	or     %rbx,%rcx
  27:	0f 01 cb             	stac
* 2a:	89 01                	mov    %eax,(%rcx) <-- trapping instruction
  2c:	31 c9                	xor    %ecx,%ecx
  2e:	0f 01 ca             	clac
  31:	e9 fe 24 2f 00       	jmp    0x2f2534
  36:	0f 1f 00             	nopl   (%rax)
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


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
