Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792694A0C
	for <linux-block@vger.kernel.org>; Thu, 19 Dec 2024 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734573683; cv=none; b=TwONpZNYHxd40If+KNHJ0+wItsVOCN+w4DC9nsVDd0wt+TaPeoS39ui+FrH43jCTPMDkIvu9Dx+YBBGjGmKS8y3r1OJTS4zxoSBBM7VMz+aicQb//E/tvqCkk0wfC/c3vB5275+VZm76SW/Q/c1OpHlZ4Pf2ZocIjF4GDuUw8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734573683; c=relaxed/simple;
	bh=YXWroaNOOMY1CRE9UNkw6VBOfF6qH26TDjUQUOI9ytQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LMtcBo3CNjWzAkmArX9iVb7phT6oGhrHIiATwR4zQLUgkRiVjvsNzIL3THYL6MQ9n6FxlCCC+OmdmRSTfYxQQeuCKV7DfYkTFNdBfphkoUl/2T2QgLqLy9ED2uhq9INo4IyDGf3yfVL9LvjukcVkF/jAoUatduwQJbkHxNFv3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-844e7f9d37dso57519939f.2
        for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 18:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734573680; x=1735178480;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldfnMW5g0hjpsqP4D6S3f8z0tbFyDPVVK7Ry0qus7ww=;
        b=uOQhZISBt6CX8G++BndzkqanET/NRb6BnUbgFKRtd0BZAvC1bRlyqiJbkC1FleW0nd
         IN0n5jNsHHkCxQYMKuUjhbMrRG5auiwWLpbodcyYgQiwWYXjVZmsMaYXlWu1mlFTEQ3H
         IbQjaav3HaUkXWuxkUbxd2glLEKXZqT9INfFlQXRSolAyFvg6wXIU04AjQfGdomEIc6x
         XuccVlMvNXqGhVLoo7AQR5DkU56PAzfcavNH6UohZj5JnE/2QxNAvHSKGYWKJU48abC0
         n85aluD0DesZ1hoMR9zbipKCpqCR53ljoFrnlE/dn1QUBSet55W42ZAcp5lLyU6Z2EJw
         mPQA==
X-Forwarded-Encrypted: i=1; AJvYcCXtInGjSwKutokPw/k46l1FXUeSKGIPSaz2LHqD2+y1DChCCDJKHD+MtZs1tE5JeYcv8UOwSXXiYeKk2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtSvAz2p6QMw1Cd2VUqeC+lUNcZeb3PVSRDTQVxaV4Vrjwf0c5
	6lYOrZAEtcMcOmRPzI0H0uw0q0Axj23+oeuTeMXyhxG0a7tePvMABhuB/TJkmjc+fgyJAR4UVYu
	ZimRAEJNSWNTG0wOAyCecqEeOqiEeEkUSfzevnp01eI/GpJ9cIdFJPsE=
X-Google-Smtp-Source: AGHT+IHRFopGK6ursT+HdHr6qOtBpUF9BFTEgIyfd/KBnAfKkX5L6GJIlxYi3u5FQQlsw4mZ2b3e534vZqIkEYZa1Btr97WoFv65
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:164b:b0:3a7:3760:7314 with SMTP id
 e9e14a558f8ab-3bdc4f188c9mr48059615ab.20.1734573680705; Wed, 18 Dec 2024
 18:01:20 -0800 (PST)
Date: Wed, 18 Dec 2024 18:01:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67637e70.050a0220.3157ee.000c.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_mq_exit_sched
From: syzbot <syzbot+d8caa4d9cdee21b5e671@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    78d4f34e2115 Linux 6.13-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15f6d4f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fe704d2356374ad
dashboard link: https://syzkaller.appspot.com/bug?extid=d8caa4d9cdee21b5e671
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62c1fdc3621a/disk-78d4f34e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca298b9ea730/vmlinux-78d4f34e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6ef1cf1de34/bzImage-78d4f34e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8caa4d9cdee21b5e671@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc3-syzkaller #0 Not tainted
------------------------------------------------------
syz.7.5821/29531 is trying to acquire lock:
ffff8880254c9ca8 (&q->debugfs_mutex){+.+.}-{4:4}, at: blk_mq_exit_sched+0x106/0x4a0 block/blk-mq-sched.c:531

but task is already holding lock:
ffff8880255fd0b8 (&eq->sysfs_lock){+.+.}-{4:4}, at: elevator_exit block/elevator.c:158 [inline]
ffff8880255fd0b8 (&eq->sysfs_lock){+.+.}-{4:4}, at: elevator_disable+0xd3/0x3f0 block/elevator.c:674

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&eq->sysfs_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       elevator_exit block/elevator.c:158 [inline]
       elevator_disable+0xd3/0x3f0 block/elevator.c:674
       blk_mq_elv_switch_none block/blk-mq.c:4942 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5005 [inline]
       blk_mq_update_nr_hw_queues+0x683/0x1b20 block/blk-mq.c:5068
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

-> #3 (&q->q_usage_counter(io)#53){++++}-{0:0}:
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
       filemap_get_pages+0x605/0x2080 mm/filemap.c:2546
       filemap_read+0x452/0xf50 mm/filemap.c:2646
       blkdev_read_iter+0x2d8/0x430 block/fops.c:770
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x991/0xb70 fs/read_write.c:565
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (mapping.invalidate_lock#2){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x615/0x1490 mm/filemap.c:3332
       __do_fault+0x135/0x390 mm/memory.c:4907
       do_read_fault mm/memory.c:5322 [inline]
       do_fault mm/memory.c:5456 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x39eb/0x5ed0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6112
       faultin_page mm/gup.c:1196 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1494
       populate_vma_page_range+0x264/0x330 mm/gup.c:1932
       __mm_populate+0x27a/0x460 mm/gup.c:2035
       mm_populate include/linux/mm.h:3386 [inline]
       vm_mmap_pgoff+0x2c3/0x3d0 mm/util.c:585
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
       blk_trace_ioctl+0x1ad/0x9a0 kernel/trace/blktrace.c:740
       blkdev_ioctl+0x40c/0x6a0 block/ioctl.c:682
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
       blk_mq_exit_sched+0x106/0x4a0 block/blk-mq-sched.c:531
       elevator_exit block/elevator.c:159 [inline]
       elevator_disable+0xde/0x3f0 block/elevator.c:674
       blk_mq_elv_switch_none block/blk-mq.c:4942 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5005 [inline]
       blk_mq_update_nr_hw_queues+0x683/0x1b20 block/blk-mq.c:5068
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

other info that might help us debug this:

Chain exists of:
  &q->debugfs_mutex --> &q->q_usage_counter(io)#53 --> &eq->sysfs_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&eq->sysfs_lock);
                               lock(&q->q_usage_counter(io)#53);
                               lock(&eq->sysfs_lock);
  lock(&q->debugfs_mutex);

 *** DEADLOCK ***

7 locks held by syz.7.5821/29531:
 #0: ffff8880255a4998 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_ioctl+0x13c/0xf40 drivers/block/nbd.c:1572
 #1: ffff8880255a48d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0xc2/0x1b20 block/blk-mq.c:5067
 #2: ffff8880254c99f8 (&q->sysfs_dir_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4995 [inline]
 #2: ffff8880254c99f8 (&q->sysfs_dir_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x2c1/0x1b20 block/blk-mq.c:5068
 #3: ffff8880254c9968 (&q->sysfs_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4996 [inline]
 #3: ffff8880254c9968 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x2cf/0x1b20 block/blk-mq.c:5068
 #4: ffff8880254c9438 (&q->q_usage_counter(io)#56){+.+.}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
 #5: ffff8880254c9470 (&q->q_usage_counter(queue)#40){+.+.}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
 #6: ffff8880255fd0b8 (&eq->sysfs_lock){+.+.}-{4:4}, at: elevator_exit block/elevator.c:158 [inline]
 #6: ffff8880255fd0b8 (&eq->sysfs_lock){+.+.}-{4:4}, at: elevator_disable+0xd3/0x3f0 block/elevator.c:674

stack backtrace:
CPU: 0 UID: 0 PID: 29531 Comm: syz.7.5821 Not tainted 6.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
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
 blk_mq_exit_sched+0x106/0x4a0 block/blk-mq-sched.c:531
 elevator_exit block/elevator.c:159 [inline]
 elevator_disable+0xde/0x3f0 block/elevator.c:674
 blk_mq_elv_switch_none block/blk-mq.c:4942 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:5005 [inline]
 blk_mq_update_nr_hw_queues+0x683/0x1b20 block/blk-mq.c:5068
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
RIP: 0033:0x7f544bd85d19
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f544cc3a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f544bf75fa0 RCX: 00007f544bd85d19
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 00007f544be01a20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f544bf75fa0 R15: 00007fffc5b8def8
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
