Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC01284A52
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847443; cv=none; b=XCV9GnmDbuoyK3mA+B9ZAMLohcCYy5zHs/dgDKOJl57brOpVXNTjIKJmuSpzCnwd+r1RWBUsi6u7FHdYDaTCmAD7B5SFCiy+b23ttiF5z1UvSi1uPjX42SpaC+ctfefkHoBrV3lXBFg0JeF9/JhxobMSCSA0J52IfuzR372Btn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847443; c=relaxed/simple;
	bh=x/GLE6KYLPsMj50zrPO3Utcs27e4Z8rfH+3ks2ELG2U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b2DE2RKn3s2uxDXWSw57oKjaMb7HX0z/fn7n6pTAVrTFsozFRBR2Mi4NA3Ybfi/CKGchOwIX/N4t2cXknNeaorBJ+GmwxHv7kNJYGKozK95n9mGE66y+coTaTZ2k+6//26NPnXSKf1q6zEhfL2HSoKc5MmJWmtBNzucuGjB2Uvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cca581135dso90817445ab.3
        for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 01:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736847440; x=1737452240;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+ULk83gzkSsyxT9vncevqe/0hqpylAR2HLBrNIYXmg=;
        b=RQccN7xZpQ8lTsJP3IYAHvwulxAe2BoGCTW9XVUuFuAW3GnkcVw9cWJ87B6+BEyG+4
         6JP5AY7KcAxQhnpeGaUFhYWymraALKD1Vsy+u78bJFc/YKLrBCnC5/Qlv4lDvWSZy3zS
         rDlFNhZxWpg/Y8V1Ds3fufWuE2obOj8a+5R2AV0ZKQ6U0bVd2eSj7vnf8DOzZTcOtK7n
         3f5ExgKfp2uNrODkKIycwfQH4GabLrQRTJqW2dSIU+KOnKUvA20JNQAtEiJxzS3u+m3O
         QRFElJTiRjDcwudopFP2yiYhOC1LX4DbEN4diRnt7fVwRqW/jmEGz9YBn0OfLxcB2SMI
         T/vw==
X-Forwarded-Encrypted: i=1; AJvYcCW8D3CjtbFP5s64A7A75WNjuSwig0UULrzoBgl6VDiZEccIPJWDvK0StLLGQ4bu1HKn9V0Pjo46xCmcuw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyoraKTV0s5nlmjrBJns6Nf1+d57TsVUQ95mRsaRZapCmS3q1S
	ddPZLKQkuAPy0gjsCibQM46j1+ERI45hh3Rb1WUoZ9A7k44UoW5E2n1uqeQ2vi9IrLO2fk3x93b
	x49yRD9z+1tsNaI83rFpwklaCAhvNYIlLIIvbnMfUSc4UtaZNnY1d0yw=
X-Google-Smtp-Source: AGHT+IGa3qQlzsAJq8xvxOriXJATPuKvKidRObzG2PMffDutOWrblcHoWAwI6tWt0yoitjBb7CQHy7lDhdoUeDigSiBJ5fmXlFjR
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3ce3a8882famr183078835ab.13.1736847440261; Tue, 14 Jan 2025
 01:37:20 -0800 (PST)
Date: Tue, 14 Jan 2025 01:37:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67863050.050a0220.216c54.006f.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in wbt_init
From: syzbot <syzbot+2b30484722ffdf99a969@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2144da25584e Merge tag '6.13-rc6-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1457b4b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ac4cd61d548c1ef
dashboard link: https://syzkaller.appspot.com/bug?extid=2b30484722ffdf99a969
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5a70c84e2a87/disk-2144da25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/21d41f80a658/vmlinux-2144da25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa4e5651e223/bzImage-2144da25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b30484722ffdf99a969@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc6-syzkaller-00130-g2144da25584e #0 Not tainted
------------------------------------------------------
syz.4.4235/23577 is trying to acquire lock:
ffff88802878daa8 (&q->rq_qos_mutex){+.+.}-{4:4}, at: wbt_init+0x3a0/0x510 block/blk-wbt.c:921

but task is already holding lock:
ffff88802878dde0 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_register_queue+0x149/0x400 block/blk-sysfs.c:772

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&q->sysfs_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_elv_switch_none block/blk-mq.c:4932 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5010 [inline]
       blk_mq_update_nr_hw_queues+0x3fa/0x1ae0 block/blk-mq.c:5070
       nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
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

-> #4 (&q->q_usage_counter(io)#56){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3090
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       mpage_bio_submit_read fs/mpage.c:75 [inline]
       mpage_readahead+0x630/0x780 fs/mpage.c:377
       read_pages+0x176/0x750 mm/readahead.c:160
       page_cache_ra_unbounded+0x606/0x720 mm/readahead.c:295
       do_page_cache_ra mm/readahead.c:325 [inline]
       force_page_cache_ra mm/readahead.c:354 [inline]
       page_cache_sync_ra+0x3c5/0xad0 mm/readahead.c:566
       page_cache_sync_readahead include/linux/pagemap.h:1397 [inline]
       filemap_get_pages+0x605/0x2080 mm/filemap.c:2537
       filemap_read+0x452/0xf50 mm/filemap.c:2637
       blkdev_read_iter+0x2d8/0x430 block/fops.c:770
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x991/0xb70 fs/read_write.c:565
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (mapping.invalidate_lock#2){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x615/0x1490 mm/filemap.c:3323
       __do_fault+0x135/0x390 mm/memory.c:4907
       do_cow_fault mm/memory.c:5352 [inline]
       do_fault mm/memory.c:5458 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0xcab/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6112
       faultin_page mm/gup.c:1196 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1494
       populate_vma_page_range+0x264/0x330 mm/gup.c:1932
       __mm_populate+0x27a/0x460 mm/gup.c:2035
       do_mlock+0x61f/0x7e0 mm/mlock.c:653
       __do_sys_mlock mm/mlock.c:661 [inline]
       __se_sys_mlock mm/mlock.c:659 [inline]
       __x64_sys_mlock+0x60/0x70 mm/mlock.c:659
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       rq_qos_add+0x279/0x320 block/blk-rq-qos.c:323
       wbt_init+0x3ba/0x510 block/blk-wbt.c:922
       blk_register_queue+0x37a/0x400 block/blk-sysfs.c:795
       add_disk_fwnode+0x648/0xf80 block/genhd.c:493
       add_disk include/linux/blkdev.h:753 [inline]
       loop_add+0x81d/0xaf0 drivers/block/loop.c:2077
       loop_init+0x168/0x220 drivers/block/loop.c:2269
       do_one_initcall+0x248/0x870 init/main.c:1266
       do_initcall_level+0x157/0x210 init/main.c:1328
       do_initcalls+0x3f/0x80 init/main.c:1344
       kernel_init_freeable+0x435/0x5d0 init/main.c:1577
       kernel_init+0x1d/0x2b0 init/main.c:1466
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       wbt_init+0x3a0/0x510 block/blk-wbt.c:921
       blk_register_queue+0x37a/0x400 block/blk-sysfs.c:795
       add_disk_fwnode+0x648/0xf80 block/genhd.c:493
       add_disk include/linux/blkdev.h:753 [inline]
       loop_add+0x81d/0xaf0 drivers/block/loop.c:2077
       blk_request_module+0x18d/0x1b0 block/genhd.c:809
       blkdev_get_no_open+0x36/0xc0 block/bdev.c:783
       bdev_file_open_by_dev+0x99/0x220 block/bdev.c:1004
       swsusp_check+0x5b/0x3f0 kernel/power/swap.c:1569
       software_resume+0x4f/0x3d0 kernel/power/hibernate.c:993
       resume_store+0x3fe/0x710 kernel/power/hibernate.c:1271
       kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xaeb/0xd30 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->rq_qos_mutex --> &q->q_usage_counter(io)#56 --> &q->sysfs_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->sysfs_lock);
                               lock(&q->q_usage_counter(io)#56);
                               lock(&q->sysfs_lock);
  lock(&q->rq_qos_mutex);

 *** DEADLOCK ***

8 locks held by syz.4.4235/23577:
 #0: ffff8880688e5cf8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x254/0x320 fs/file.c:1192
 #1: ffff88807c888420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #1: ffff88807c888420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #2: ffff88801cae2488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #3: ffff88801dec0d28 (kn->active#57){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #4: ffffffff8e7eba48 (system_transition_mutex){+.+.}-{4:4}, at: software_resume+0x45/0x3d0 kernel/power/hibernate.c:992
 #5: ffffffff8f04f4e8 (major_names_lock){+.+.}-{4:4}, at: blk_request_module+0x33/0x1b0 block/genhd.c:806
 #6: ffff88802878de70 (&q->sysfs_dir_lock){+.+.}-{4:4}, at: blk_register_queue+0x67/0x400 block/blk-sysfs.c:761
 #7: ffff88802878dde0 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_register_queue+0x149/0x400 block/blk-sysfs.c:772

stack backtrace:
CPU: 0 UID: 0 PID: 23577 Comm: syz.4.4235 Not tainted 6.13.0-rc6-syzkaller-00130-g2144da25584e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
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
 wbt_init+0x3a0/0x510 block/blk-wbt.c:921
 blk_register_queue+0x37a/0x400 block/blk-sysfs.c:795
 add_disk_fwnode+0x648/0xf80 block/genhd.c:493
 add_disk include/linux/blkdev.h:753 [inline]
 loop_add+0x81d/0xaf0 drivers/block/loop.c:2077
 blk_request_module+0x18d/0x1b0 block/genhd.c:809
 blkdev_get_no_open+0x36/0xc0 block/bdev.c:783
 bdev_file_open_by_dev+0x99/0x220 block/bdev.c:1004
 swsusp_check+0x5b/0x3f0 kernel/power/swap.c:1569
 software_resume+0x4f/0x3d0 kernel/power/hibernate.c:993
 resume_store+0x3fe/0x710 kernel/power/hibernate.c:1271
 kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9534385d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f95351a4038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9534576080 RCX: 00007f9534385d29
RDX: 0000000000000012 RSI: 00000000200001c0 RDI: 0000000000000005
RBP: 00007f9534401b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f9534576080 R15: 00007ffd6ae7ab68
 </TASK>
block device autoloading is deprecated and will be removed.
syz.4.4235: attempt to access beyond end of device
loop0: rw=2048, sector=0, nr_sectors = 8 limit=0
PM: Image not found (code -5)


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
