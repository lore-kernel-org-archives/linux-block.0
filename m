Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5ADF9E4
	for <linux-block@vger.kernel.org>; Sat, 23 Nov 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732374263; cv=none; b=QTYTH00RhLlvyg/K+fRhQ152DNqrmohm2rPQ2YI7ZEibKfp8pcxeK/RH552E3PC2T9frkMi+PmAMQeR65Od0SmnVQdhX0ufXQHCylkwAzh9Fuqd2Mogt5aL+p4lq4CU7l4sIR1WqwnQaebLeAp875wB+MRLhY144/wXroYiNzZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732374263; c=relaxed/simple;
	bh=M6QKNAQJ/okAv7NDKdkj1N8xOqjCYBH8H0wlmrLvylE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dejzgqbKq5kZ63WjAxj7iIcPVOIipk0txWrXG57kltRH5F43Q9ejsFyxkB16ex6hGzh8Chm6+iFWg6J6efLHLEZxM/Q2OkuscHWYRpnaHi3thWzLJIHOjnpSQz4cXk2/5u5Bfb0v+g/Zo90DQ1KKoh4qGAtHXXjE/mOT70Uk4NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so348581139f.0
        for <linux-block@vger.kernel.org>; Sat, 23 Nov 2024 07:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732374260; x=1732979060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKxiUQg9r1rJfXnKq6HokcTWDt1vBDUjWBS7OEWCofU=;
        b=i0A+Z1zx5I5eK+lXbU6FQ5ELzacfPN82yE3PjqKBXHhF/zz6e19FF3iUNd9HZdOSFX
         AwYj9o+P5fZGROIqjDGSWLDYFVzl4hXrx5pee3VnHtz5bRQRuBvqOCmmHIGViaFbeoA0
         OxcohXdRiYviVdXJt5wpYrcPf2upaV5hKOlBVoprd48TFk48ejEWrNdryMkS0InYg+M2
         aJqeldOVZdcIPAoOEVxCuCRB/o3rQP3WLxeqcu9kLAE6KkOsJjBN5kVR8ed5cv9DmJUk
         op/gO/C6bchSYBtwmwrjWYNyrPM17BEtwgzU1rpWZEpiBsyl9XEtZaO4eK5wpujhPIp4
         CXVw==
X-Forwarded-Encrypted: i=1; AJvYcCX+pZ5ISn3CIed6bzJtVusXTA8KL8aXg5q2J6XmYZImN7DV+iV9NHxw5k3i7ckzPwa3NDYbCShj5v34rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIExfYEIXHV7hNcj5bLqdMKD04gpQ41+s+HkVAWErMSxTKep/a
	vh4EAEDmwzhXiqydf35EFuV4AqECRdIS/6zWAc47gSQXs7jqPHK52wZwoDOUKHQvI2O7o/DtJ14
	FXccCu5iBVwDnC1yM41KvWVELrfuv7AXx3CWgs5qe06OK0QmLWXfyCQ0=
X-Google-Smtp-Source: AGHT+IF7jl9DMVajF1g+fZiRz2S9YkzbhJ9gooMrS3pZLzTbConLM7iMw8Z8RMuxT4uZG58y5quUD6cpb6cFAoYdmYFQbvomQdNf
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:3a7:44d9:c7dd with SMTP id
 e9e14a558f8ab-3a79ad27697mr73325665ab.6.1732374260630; Sat, 23 Nov 2024
 07:04:20 -0800 (PST)
Date: Sat, 23 Nov 2024 07:04:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6741eef4.050a0220.1cc393.0015.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_register_queue
From: syzbot <syzbot+f562f0286b285b26b0c2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b1d930580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78c767e2e984329
dashboard link: https://syzkaller.appspot.com/bug?extid=f562f0286b285b26b0c2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/53fb758f6bdd/disk-fcc79e17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b19fc1447a6b/vmlinux-fcc79e17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b2c341b38155/bzImage-fcc79e17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f562f0286b285b26b0c2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-05480-gfcc79e1714e8 #0 Not tainted
------------------------------------------------------
syz.5.2508/16156 is trying to acquire lock:
ffff888027a72cf8 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_register_queue+0x145/0x460 block/blk-sysfs.c:772

but task is already holding lock:
ffff888027a72d88 (&q->sysfs_dir_lock){+.+.}-{4:4}, at: blk_register_queue+0x67/0x460 block/blk-sysfs.c:761

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&q->sysfs_dir_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_sysfs_unregister_hctxs+0xaa/0x300 block/blk-mq-sysfs.c:278
       __blk_mq_update_nr_hw_queues block/blk-mq.c:4930 [inline]
       blk_mq_update_nr_hw_queues+0x6cc/0x1ae0 block/blk-mq.c:4985
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

-> #5 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2825 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2452
       filemap_read_folio+0x14b/0x630 mm/filemap.c:2367
       filemap_update_page mm/filemap.c:2451 [inline]
       filemap_get_pages+0x17af/0x2540 mm/filemap.c:2572
       filemap_read+0x45c/0xf50 mm/filemap.c:2647
       blkdev_read_iter+0x2d8/0x430 block/fops.c:767
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x991/0xb70 fs/read_write.c:565
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (mapping.invalidate_lock#2){.+.+}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x6e8/0x1950 mm/filemap.c:3333
       __do_fault+0x135/0x460 mm/memory.c:4882
       do_read_fault mm/memory.c:5297 [inline]
       do_fault mm/memory.c:5431 [inline]
       do_pte_missing mm/memory.c:3965 [inline]
       handle_pte_fault+0x2d1c/0x6820 mm/memory.c:5766
       __handle_mm_fault mm/memory.c:5909 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6077
       do_user_addr_fault arch/x86/mm/fault.c:1338 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x459/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

-> #3 (&vma->vm_lock->lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write+0x99/0x220 kernel/locking/rwsem.c:1577
       vma_start_write include/linux/mm.h:769 [inline]
       vma_link+0x28c/0x500 mm/vma.c:1600
       insert_vm_struct+0x2f7/0x410 mm/mmap.c:1995
       __bprm_mm_init fs/exec.c:289 [inline]
       bprm_mm_init fs/exec.c:393 [inline]
       alloc_bprm+0x8f5/0xe20 fs/exec.c:1548
       kernel_execve+0x99/0xa50 fs/exec.c:1977
       try_to_run_init_process init/main.c:1394 [inline]
       kernel_init+0xed/0x2b0 init/main.c:1522
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #2 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6716
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
       blk_register_queue+0x156/0x460 block/blk-sysfs.c:774
       add_disk_fwnode+0x648/0xf80 block/genhd.c:493
       add_disk include/linux/blkdev.h:751 [inline]
       brd_alloc+0x547/0x790 drivers/block/brd.c:399
       brd_init+0x126/0x1b0 drivers/block/brd.c:479
       do_one_initcall+0x248/0x880 init/main.c:1266
       do_initcall_level+0x157/0x210 init/main.c:1328
       do_initcalls+0x3f/0x80 init/main.c:1344
       kernel_init_freeable+0x435/0x5d0 init/main.c:1577
       kernel_init+0x1d/0x2b0 init/main.c:1466
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->sysfs_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_register_queue+0x145/0x460 block/blk-sysfs.c:772
       add_disk_fwnode+0x648/0xf80 block/genhd.c:493
       add_disk include/linux/blkdev.h:751 [inline]
       md_alloc+0x78c/0xde0 drivers/md/md.c:5909
       md_alloc_and_put+0x18/0x1c0 drivers/md/md.c:5944
       blk_request_module+0x18d/0x1b0 block/genhd.c:812
       blkdev_get_no_open+0x36/0xc0 block/bdev.c:784
       bdev_file_open_by_dev+0x99/0x220 block/bdev.c:1005
       swsusp_check+0x5b/0x3f0 kernel/power/swap.c:1569
       software_resume+0x4f/0x3d0 kernel/power/hibernate.c:990
       resume_store+0x3fe/0x710 kernel/power/hibernate.c:1268
       kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xaeb/0xd30 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

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

8 locks held by syz.5.2508/16156:
 #0: ffff88806cc8e478 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x254/0x320 fs/file.c:1191
 #1: ffff8880353fc420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2964 [inline]
 #1: ffff8880353fc420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x225/0xd30 fs/read_write.c:675
 #2: ffff88807af3b088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #3: ffff88801d6ad3c8 (kn->active#75){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #4: ffffffff8e7ef648 (system_transition_mutex){+.+.}-{4:4}, at: software_resume+0x45/0x3d0 kernel/power/hibernate.c:989
 #5: ffffffff8f064aa8 (major_names_lock){+.+.}-{4:4}, at: blk_request_module+0x33/0x1b0 block/genhd.c:809
 #6: ffffffff8f995228 (disks_mutex){+.+.}-{4:4}, at: md_alloc+0x36/0xde0 drivers/md/md.c:5857
 #7: ffff888027a72d88 (&q->sysfs_dir_lock){+.+.}-{4:4}, at: blk_register_queue+0x67/0x460 block/blk-sysfs.c:761

stack backtrace:
CPU: 1 UID: 0 PID: 16156 Comm: syz.5.2508 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
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
 blk_register_queue+0x145/0x460 block/blk-sysfs.c:772
 add_disk_fwnode+0x648/0xf80 block/genhd.c:493
 add_disk include/linux/blkdev.h:751 [inline]
 md_alloc+0x78c/0xde0 drivers/md/md.c:5909
 md_alloc_and_put+0x18/0x1c0 drivers/md/md.c:5944
 blk_request_module+0x18d/0x1b0 block/genhd.c:812
 blkdev_get_no_open+0x36/0xc0 block/bdev.c:784
 bdev_file_open_by_dev+0x99/0x220 block/bdev.c:1005
 swsusp_check+0x5b/0x3f0 kernel/power/swap.c:1569
 software_resume+0x4f/0x3d0 kernel/power/hibernate.c:990
 resume_store+0x3fe/0x710 kernel/power/hibernate.c:1268
 kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:586 [inline]
 vfs_write+0xaeb/0xd30 fs/read_write.c:679
 ksys_write+0x18f/0x2b0 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe74157e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe7423fb038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fe741736160 RCX: 00007fe74157e819
RDX: 0000000000000012 RSI: 0000000020000040 RDI: 0000000000000009
RBP: 00007fe7415f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe741736160 R15: 00007ffd646be318
 </TASK>
block device autoloading is deprecated and will be removed.
syz.5.2508: attempt to access beyond end of device
md0: rw=2048, sector=0, nr_sectors = 8 limit=0
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
