Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9275B8614E
	for <linux-block@vger.kernel.org>; Sun,  3 Nov 2024 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730630130; cv=none; b=hPxwk7lKZIldcgJ/8l0oxyUnVF9AY1tGe0FEf1B2sO68xxNXOkXA6nx0xhixDFqQbPySFA3+PnIvgvc0vV1FEGSZFL6ik2Xs15vwXoSGGlLysAX305q7PMtKGkpt9qcqnh78pBCzapHndcDJr8zAfcLwWMsLFHdYuVXOB6vc6So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730630130; c=relaxed/simple;
	bh=aCCoNhKU58JwKcOYBV6xVXvp1zSJZVCSveJPMBPBXNs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GeSdP52L6TB1FR80hTEqHMy4v2WXzgwSOi5v8ZuGMGVmYSc/5N1KmCs2SQvjW/Iza45r/Xee3GkyLdEJI6tWnhAZFPi9JOcEHd2hkKAVDj7tEPUASVaTpccbNkcYCIJfZIfw6zUmyVUpdpoFu7SuTQBaqMAqM5KwBvsCI/GLvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8353599024bso333987139f.1
        for <linux-block@vger.kernel.org>; Sun, 03 Nov 2024 02:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730630128; x=1731234928;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6P+HvF1NOjI3Wf6qFp3bw1oixgUXXodDOs7TLeYnxU=;
        b=fdkzxlE0UFCT7DN8pYV+fKAaY7FwOh+RxinBLDVD6oEFP6Cbre0tlVEbmM9fJC076K
         R1v8VoxKwUSMU85Z+2K1NvUxvNihWPpIHEv4DSItct1HFkSm5urKWjPyoDo9uPzEORmY
         km6WWxQrRjMr7OKuyH0LwcuGBCdbP4DqDVcFCw+1J4xPAIiwmHftJdoyjEy4lN1RLYPQ
         S3bf/YyX5ChTA9Typ7jD5JDKZiKVVHpYuw9JcSbzX9xITKtfMKfkrT2zlsDcOqEnCxUt
         JwbQT1bc3kFr7sgUri17v009IYKgFWxmP44h7bsvebrIGcuTzQdfmDddtxKcVAwxGShO
         SjVg==
X-Forwarded-Encrypted: i=1; AJvYcCUTmnNe8STp2v3q/+pt8/LumMSveV2TkPF61APncOTBcuFlXp1a/GzVRg9lvX5UUoXFAnDifNWX228vlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVvILMg3ZMBhmkkOqqsFPJ3gCeVZf2cBEHlpziXKkl8EKz88A+
	fJV5Dejp4OLUjI4ueNCve1PcaS1UPUmLz2EPvnS8f/LZVrjZMb7QRJ/qGKBOzCRU58UOs4tUvvA
	Cx7QlSV2ucpWq+7kFe7C2bF8YTLQ0oWDUSb2+Ir8gW5jHhlZW4xzdj8s=
X-Google-Smtp-Source: AGHT+IG39XZw81WaV3RNs1yWRAds/6zO+2icPhpvkpvGE4fawqzSr7ZzzI/Ahz640tALqNf0Z7FmEs/i0IV5bxEet237xcWh4Ti/
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c8:b0:3a1:f549:7272 with SMTP id
 e9e14a558f8ab-3a4ed305e5cmr235595385ab.23.1730630127746; Sun, 03 Nov 2024
 02:35:27 -0800 (PST)
Date: Sun, 03 Nov 2024 02:35:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672751ef.050a0220.35b515.0199.GAE@google.com>
Subject: [syzbot] [block?] [trace?] possible deadlock in blk_trace_setup
From: syzbot <syzbot+0d8542c90a512dc95185@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c88416ba074a Add linux-next specific files for 20241101
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=117db55f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
dashboard link: https://syzkaller.appspot.com/bug?extid=0d8542c90a512dc95185
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13302987980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/760a8c88d0c3/disk-c88416ba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46e4b0a851a2/vmlinux-c88416ba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/428e2c784b75/bzImage-c88416ba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0d8542c90a512dc95185@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-rc5-next-20241101-syzkaller #0 Not tainted
------------------------------------------------------
syz.0.15/5976 is trying to acquire lock:
ffff88807c8e8be0 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0xaa/0x120 mm/memory.c:6751

but task is already holding lock:
ffff888143fd1c60 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0xb0/0x1e0 kernel/trace/blktrace.c:647

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_init_sched+0x3fa/0x830 block/blk-mq-sched.c:473
       elevator_init_mq+0x1d8/0x2d0 block/elevator.c:605
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

-> #3 (&q->q_usage_counter(io)#66){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1510/0x2490 block/blk-mq.c:3069
       __submit_bio+0x2c2/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bio_wait+0x106/0x200 block/bio.c:1391
       blkdev_issue_write_zeroes block/blk-lib.c:166 [inline]
       blkdev_issue_zeroout+0x4c4/0x7e0 block/blk-lib.c:319
       sb_issue_zeroout include/linux/blkdev.h:1133 [inline]
       ext4_init_inode_table+0x4f0/0x930 fs/ext4/ialloc.c:1595
       ext4_run_li_request fs/ext4/super.c:3716 [inline]
       ext4_lazyinit_thread+0x756/0x1930 fs/ext4/super.c:3807
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&meta_group_info[i]->alloc_sem){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       __ext4_new_inode+0x2032/0x4380 fs/ext4/ialloc.c:1188
       ext4_create+0x279/0x550 fs/ext4/namei.c:2841
       lookup_open fs/namei.c:3595 [inline]
       open_last_lookups fs/namei.c:3694 [inline]
       path_openat+0x1c03/0x3590 fs/namei.c:3930
       do_filp_open+0x235/0x490 fs/namei.c:3960
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1419
       do_sys_open fs/open.c:1434 [inline]
       __do_sys_openat fs/open.c:1450 [inline]
       __se_sys_openat fs/open.c:1445 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1445
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (jbd2_handle){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       start_this_handle+0x1eb4/0x2110 fs/jbd2/transaction.c:448
       jbd2__journal_start+0x2da/0x5d0 fs/jbd2/transaction.c:505
       __ext4_journal_start_sb+0x239/0x600 fs/ext4/ext4_jbd2.c:112
       __ext4_journal_start fs/ext4/ext4_jbd2.h:326 [inline]
       ext4_dirty_inode+0x92/0x110 fs/ext4/inode.c:5981
       __mark_inode_dirty+0x2ee/0xe90 fs/fs-writeback.c:2491
       generic_update_time fs/inode.c:2110 [inline]
       inode_update_time fs/inode.c:2123 [inline]
       touch_atime+0x413/0x690 fs/inode.c:2195
       file_accessed include/linux/fs.h:2538 [inline]
       ext4_file_mmap+0x18c/0x540 fs/ext4/file.c:794
       call_mmap include/linux/fs.h:2182 [inline]
       mmap_file mm/internal.h:124 [inline]
       __mmap_new_file_vma mm/vma.c:2287 [inline]
       __mmap_new_vma mm/vma.c:2351 [inline]
       __mmap_region+0x2204/0x2cd0 mm/vma.c:2452
       mmap_region+0x226/0x2c0 mm/mmap.c:1373
       do_mmap+0x8f0/0x1000 mm/mmap.c:496
       vm_mmap_pgoff+0x214/0x430 mm/util.c:580
       ksys_mmap_pgoff+0x4eb/0x720 mm/mmap.c:542
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&mm->mmap_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6751
       _inline_copy_from_user include/linux/uaccess.h:162 [inline]
       _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:212 [inline]
       __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
       blk_trace_setup+0xd2/0x1e0 kernel/trace/blktrace.c:648
       sg_ioctl_common drivers/scsi/sg.c:1121 [inline]
       sg_ioctl+0xa46/0x2e80 drivers/scsi/sg.c:1163
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:907 [inline]
       __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &mm->mmap_lock --> &q->q_usage_counter(io)#66 --> &q->debugfs_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->debugfs_mutex);
                               lock(&q->q_usage_counter(io)#66);
                               lock(&q->debugfs_mutex);
  rlock(&mm->mmap_lock);

 *** DEADLOCK ***

1 lock held by syz.0.15/5976:
 #0: ffff888143fd1c60 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_trace_setup+0xb0/0x1e0 kernel/trace/blktrace.c:647

stack backtrace:
CPU: 0 UID: 0 PID: 5976 Comm: syz.0.15 Not tainted 6.12.0-rc5-next-20241101-syzkaller #0
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
 __might_fault+0xc6/0x120 mm/memory.c:6751
 _inline_copy_from_user include/linux/uaccess.h:162 [inline]
 _copy_from_user+0x2a/0xc0 lib/usercopy.c:18
 copy_from_user include/linux/uaccess.h:212 [inline]
 __blk_trace_setup kernel/trace/blktrace.c:626 [inline]
 blk_trace_setup+0xd2/0x1e0 kernel/trace/blktrace.c:648
 sg_ioctl_common drivers/scsi/sg.c:1121 [inline]
 sg_ioctl+0xa46/0x2e80 drivers/scsi/sg.c:1163
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcb37b7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc1f57c1c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcb37d35f80 RCX: 00007fcb37b7e719
RDX: 0000000000000000 RSI: 00000000c0481273 RDI: 0000000000000003
RBP: 00007fcb37bf132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcb37d35f80 R14: 00007fcb37d35f80 R15: 0000000000000304
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
