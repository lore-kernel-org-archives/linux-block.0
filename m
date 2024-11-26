Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0048F40
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579288; cv=none; b=YueCy6gyRQRXUht2C0hnOe6qYatAsamMQO2l+86Dfenu7MS5xQ9gNvL/aFx/D0+G9q0CvPAWHtmjQh1gRZm960ybB5akvh8pucqohsRuzdLIkYT8fGTZXMMEPXMP4Je1O9X8GXPphHnKlEytQtReyj5v5fqpex963IyRzBTNYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579288; c=relaxed/simple;
	bh=zxM6zYZhc4zVuFVg7hX5SOalPZ8wa3jgGbf9xz0kQEA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ljxDQLJWViRl8zRh+i+32R+kzfIjncU4q0rYJdoL2tEYuGFqqj5BbixNGM/bkKhoualDfzH8pZtQheHfwSkkDXXSuNa5iBoBG7y7j8ozIlCWTniTTAvK7aoLlm10Yt39bSYO0jukO3ugX7D6ZswxThDo1a2SU/D30taX9Dwwhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a76690f813so59957375ab.2
        for <linux-block@vger.kernel.org>; Mon, 25 Nov 2024 16:01:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732579285; x=1733184085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92USXR7bbQYiLfixUHSYEdokYc7CucAYCL5IOWlbYNA=;
        b=GBSKrWs8bqt2cCILKJjMQOrupznhv6vzmIawjVP6JQWWhbNXY23plVS9favCLrM0fq
         aq58kONisiIBvX9rVPLlbl+Cfr9KkTEy6BCw6YrZiegV7MD9bsLKQIm8FOjqZ/nKVsWJ
         CdSB8bUMPNudVYB1sJdGFLl0odXGp4N1aYS8pHqbr8bZib1eYyAN/4vp9jHXV3GTGWTP
         c2Z2Gg+ms9JRIP3opGBZdK4/YIRHBW8uUQt44LSZSOv6pw+g94pHiMFkXUX2Agz11hvC
         T0ONcNtlHRinvYSvX6M3+Idjv7NwU8MRemLUof3N9rY1Gmc90mwBQfxI1Ls+ctKWlSBg
         WJVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAQYc57H8f37ZuSHmZia+IQyKtlHfbzstja8G7zZtgjQ46rbry+gspkR+azaahM6XqaRNfAvp5rr2UmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNd9uI9/TolZJpbotFob00gTaJMMBNsnV2NmFJBWv5K3wnVPcS
	D6h0FWmg7jUzb9pBdiT88Id0b1Egr9MykIT+/jWWme1T+zkk3az8g1Z1zKC4ymk0fuFQSYj+DBv
	6FFAneeT7450nPCGjOY0yjhpwxcQcLiZZRuFAjDqIo/GqUZSt+hRXIO0=
X-Google-Smtp-Source: AGHT+IFqcsdHv6IjMuU/R1rl0DNH9CgIV9rsgV7+axQwgKp5az8bgT2RDKtTz2YvTiaFlbCjgXNAy7KN5hYv4tyjiuPxlz5Rc8Qq
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a7:2204:c83e with SMTP id
 e9e14a558f8ab-3a79ae044b4mr160710885ab.10.1732579285007; Mon, 25 Nov 2024
 16:01:25 -0800 (PST)
Date: Mon, 25 Nov 2024 16:01:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67450fd4.050a0220.1286eb.0007.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_unregister_queue
From: syzbot <syzbot+91585b36b538053343e4@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f16d5e6f220 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15542778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7393f07275e8e571
dashboard link: https://syzkaller.appspot.com/bug?extid=91585b36b538053343e4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9f16d5e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8a4ab7536099/vmlinux-9f16d5e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a94d1bc43eff/bzImage-9f16d5e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91585b36b538053343e4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-09073-g9f16d5e6f220 #0 Not tainted
------------------------------------------------------
kworker/0:0/8 is trying to acquire lock:
ffff88802671fb38 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_unregister_queue+0x125/0x2e0 block/blk-sysfs.c:869

but task is already holding lock:
ffff88802671fbc8 (&q->sysfs_dir_lock){+.+.}-{4:4}, at: blk_unregister_queue+0xdb/0x2e0 block/blk-sysfs.c:860

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&q->sysfs_dir_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_mq_sysfs_unregister_hctxs+0x92/0x2d0 block/blk-mq-sysfs.c:278
       __blk_mq_update_nr_hw_queues+0x93f/0x14e0 block/blk-mq.c:4930
       blk_mq_update_nr_hw_queues+0x2a/0x40 block/blk-mq.c:4985
       nbd_start_device+0x15b/0xd70 drivers/block/nbd.c:1413
       nbd_start_device_ioctl drivers/block/nbd.c:1464 [inline]
       __nbd_ioctl drivers/block/nbd.c:1539 [inline]
       nbd_ioctl+0x21a/0xfd0 drivers/block/nbd.c:1579
       blkdev_ioctl+0x276/0x6d0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1fb6/0x24c0 block/blk-mq.c:3092
       __submit_bio+0x384/0x540 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
       submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x812/0xa50 fs/buffer.c:2446
       filemap_read_folio+0xc6/0x2a0 mm/filemap.c:2366
       filemap_update_page mm/filemap.c:2450 [inline]
       filemap_get_pages+0x155f/0x1be0 mm/filemap.c:2571
       filemap_read+0x3ca/0xd70 mm/filemap.c:2646
       blkdev_read_iter+0x187/0x480 block/fops.c:767
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x87f/0xbe0 fs/read_write.c:565
       ksys_read+0x12b/0x250 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (mapping.invalidate_lock#2){++++}-{4:4}
:
       down_read+0x9a/0x330 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x2e0/0x2820 mm/filemap.c:3332
       __do_fault+0x10a/0x490 mm/memory.c:4907
       do_shared_fault mm/memory.c:5386 [inline]
       do_fault mm/memory.c:5460 [inline]
       do_pte_missing+0x1a8/0x3e70 mm/memory.c:3979
       handle_pte_fault mm/memory.c:5801 [inline]
       __handle_mm_fault+0x103c/0x2a40 mm/memory.c:5944
       handle_mm_fault+0x3fa/0xaa0 mm/memory.c:6112
       faultin_page mm/gup.c:1187 [inline]
       __get_user_pages+0x8d9/0x3b50 mm/gup.c:1485
       __get_user_pages_locked mm/gup.c:1751 [inline]
       faultin_page_range+0x24a/0x980 mm/gup.c:1975
       madvise_populate mm/madvise.c:951 [inline]
       do_madvise+0x504/0x770 mm/madvise.c:1681
       __do_sys_madvise mm/madvise.c:1700 [inline]
       __se_sys_madvise mm/madvise.c:1698 [inline]
       __x64_sys_madvise+0xa9/0x110 mm/madvise.c:1698
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault mm/memory.c:6751 [inline]
       __might_fault+0x11b/0x190 mm/memory.c:6744
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x29/0xd0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup+0xa8/0x180 kernel/trace/blktrace.c:626
       blk_trace_setup+0x47/0x70 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1121 [inline]
       sg_ioctl+0x65e/0x2750 drivers/scsi/sg.c:1163
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl fs/ioctl.c:892 [inline]
       __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_register_queue+0x13c/0x550 block/blk-sysfs.c:774
       add_disk_fwnode+0x785/0x1300 block/genhd.c:493
       add_disk include/linux/blkdev.h:751 [inline]
       brd_alloc.isra.0+0x5a2/0x840 drivers/block/brd.c:399
       brd_init+0x12b/0x1d0 drivers/block/brd.c:479
       do_one_initcall+0x128/0x700 init/main.c:1266
       do_initcall_level init/main.c:1328 [inline]
       do_initcalls init/main.c:1344 [inline]
       do_basic_setup init/main.c:1363 [inline]
       kernel_init_freeable+0x5c7/0x900 init/main.c:1577
       kernel_init+0x1c/0x2b0 init/main.c:1466
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->sysfs_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain kernel/locking/lockdep.c:3904 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
       blk_unregister_queue+0x125/0x2e0 block/blk-sysfs.c:869
       del_gendisk+0x2de/0xb20 block/genhd.c:710
       md_kobj_release+0xb2/0x100 drivers/md/md.c:5742
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x1e4/0x5a0 lib/kobject.c:737
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
       process_scheduled_works kernel/workqueue.c:3310 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
       kthread+0x2c1/0x3a0 kernel/kthread.c:389
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

Chain exists of:
  &q->sysfs_lock --> &q->q_usage_counter(io)#49 --> &q->sysfs_dir_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->sysfs_dir_lock);
                               lock(&q->q_usage_counter(io)#49);
                               lock(&q->sysfs_dir_lock);
  lock(&q->sysfs_lock);

 *** DEADLOCK ***

3 locks held by kworker/0:0/8:
 #0: ffff88801c79fd48 ((wq_completion)md_misc){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc900000b7d80 ((work_completion)(&mddev->del_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffff88802671fbc8 (&q->sysfs_dir_lock){+.+.}-{4:4}, at: blk_unregister_queue+0xdb/0x2e0 block/blk-sysfs.c:860

stack backtrace:
CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.12.0-syzkaller-09073-g9f16d5e6f220 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: md_misc mddev_delayed_delete
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
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xa60 kernel/locking/mutex.c:735
 blk_unregister_queue+0x125/0x2e0 block/blk-sysfs.c:869
 del_gendisk+0x2de/0xb20 block/genhd.c:710
 md_kobj_release+0xb2/0x100 drivers/md/md.c:5742
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1e4/0x5a0 lib/kobject.c:737
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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
