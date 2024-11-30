Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879D19D884
	for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732994550; cv=none; b=hX+UTpu6YOnSyvUvpGYynNZUuaY3gHgAFY4ekRJQycgHNGEXXS8vH8mcp7QxxLQC7npBW3zOF48zjy3d1hS50BLMql6ewOJ6JgLf9YUB9+841cgc7B9xPgXgn+/hCC0QZHJzpt+u7SoNd4RNgWEzzbkNiMSFkiPjZg83qUcRfRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732994550; c=relaxed/simple;
	bh=31/CFZJlEL6qa7SlVx8LTH8YQhk/9E3WSjuzplrxkgg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MXOsPdMnpE9M4NnFIkC2I/TnSIrA2IiM82YuuiXyWyNzLkwmdWxX1YTIjFOreD9EFaNXX+cKMf+EOZIOk0nbc+C5jf50YcOjg5H+HEj0y3gOc12zQcDpFS/T9PPRu4+RTUyJYW50UZVu8H3EgOy1NM6rW6emWI9QwERcnnO77Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a763f42b35so35135045ab.1
        for <linux-block@vger.kernel.org>; Sat, 30 Nov 2024 11:22:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732994547; x=1733599347;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25b4GeI0ihUnJKqCXa6ULDLb7C7s6hytPp3kKo7gqYA=;
        b=kaAwGJgNZPGnT98sWXLUPO5xq/k8oQPZTFv2GXjTn6HCllzZHrNoQo3mey3YmQ/mz+
         KXP8ZjREr28+acR34Tb5EXB09NOcpWXtWZ0XHEZH5kDZw6Ars3FGq+FMrmxsSX3u1z90
         aV4WEaOBxC+bq5gSBT23csIB2p7VRjBZdv08WCDs4wdqhUZnuJkCQ9fjIqH/HJAP9sU+
         9j9N0oVuW+2pbZhWrZsz8qumkfZrqWtfiluOQKaEFulUUxR9qSTWDyR0iL2t4R4hy4tm
         KitvEVY0k7XG6NPJ7FSXIoHxWz1ad4FcWQvoL+BHWNSjqGMnwLz4jxtUYD8ZAJWMQl20
         cFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoVxVrblrriX67cQ9i7+72Pd0w2XGBXlgemUe+wm3wNhKe8ioD7GoeSv0gzivAMWlF411RXxO0uazyfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrOrFTACIXWfz8prU09VjxjYHEMQbbwrpw1xA+s/VH+Euq1RTI
	K1FE+XlVR5nY6xf7wYyArjZihXfyg7WnB2eYicx9uA7NWdAc57OZnbpjPDo4TSRgNkZfS6bmRDl
	86QMC5o77fs5s/G4PlESZeb4+Vk5gMG6+90d4k08GqjtQTDUybO/E5qo=
X-Google-Smtp-Source: AGHT+IEr2049YLIAJA3B/LRrjfhDvbrO1YvkdyhX6qWhqbv9n0J85JObyoYfM8NTB9Rc4ceSSfV6DyfigqUh+RoMqCYL9L/Pc7MB
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:3a7:d7dd:e70f with SMTP id
 e9e14a558f8ab-3a7d7dde9dcmr63988935ab.12.1732994547648; Sat, 30 Nov 2024
 11:22:27 -0800 (PST)
Date: Sat, 30 Nov 2024 11:22:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674b65f3.050a0220.253251.00e1.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in elevator_disable
From: syzbot <syzbot+dbad16606916438a362a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c2cf5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8df9bf3383f5970
dashboard link: https://syzkaller.appspot.com/bug?extid=dbad16606916438a362a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea7fc4bd274d/disk-7eef7e30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b75212b0174/vmlinux-7eef7e30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1ab50706485/bzImage-7eef7e30.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dbad16606916438a362a@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-09567-g7eef7e306d3c #0 Not tainted
------------------------------------------------------
syz.3.433/7118 is trying to acquire lock:
ffff888025a200b8 (&eq->sysfs_lock){+.+.}-{4:4}, at: elevator_exit block/elevator.c:158 [inline]
ffff888025a200b8 (&eq->sysfs_lock){+.+.}-{4:4}, at: elevator_disable+0xd3/0x3f0 block/elevator.c:674

but task is already holding lock:
ffff8880256fdde0 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
ffff8880256fdde0 (&q->sysfs_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
ffff8880256fdde0 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x3fa/0x1ae0 block/blk-mq.c:4985

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&q->sysfs_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
       blk_mq_update_nr_hw_queues+0x3fa/0x1ae0 block/blk-mq.c:4985
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

-> #4 (&q->q_usage_counter(io)#53){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2446
       filemap_read_folio+0x14b/0x630 mm/filemap.c:2366
       filemap_update_page mm/filemap.c:2450 [inline]
       filemap_get_pages+0x17af/0x2540 mm/filemap.c:2571
       filemap_read+0x45c/0xf50 mm/filemap.c:2646
       blkdev_read_iter+0x2d8/0x430 block/fops.c:767
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x991/0xb70 fs/read_write.c:565
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (mapping.invalidate_lock#2){.+.+}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0x6e8/0x1950 mm/filemap.c:3332
       __do_fault+0x135/0x460 mm/memory.c:4907
       do_shared_fault mm/memory.c:5386 [inline]
       do_fault mm/memory.c:5460 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x1140/0x68a0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1053/0x1ad0 mm/memory.c:6112
       faultin_page mm/gup.c:1187 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1485
       __get_user_pages_locked mm/gup.c:1751 [inline]
       faultin_page_range+0x4e7/0x850 mm/gup.c:1975
       madvise_populate mm/madvise.c:951 [inline]
       do_madvise+0x6e5/0x4d10 mm/madvise.c:1681
       __do_sys_madvise mm/madvise.c:1700 [inline]
       __se_sys_madvise mm/madvise.c:1698 [inline]
       __x64_sys_madvise+0xa6/0xc0 mm/madvise.c:1698
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&mm->mmap_lock
){++++}-{4:4}:
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

-> #1 (
&q->debugfs_mutex){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       blk_mq_exit_sched+0x106/0x4a0 block/blk-mq-sched.c:531
       elevator_exit block/elevator.c:159 [inline]
       elevator_disable+0xde/0x3f0 block/elevator.c:674
       blk_mq_elv_switch_none block/blk-mq.c:4861 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
       blk_mq_update_nr_hw_queues+0x646/0x1ae0 block/blk-mq.c:4985
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

-> #0 (
&eq->sysfs_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       elevator_exit block/elevator.c:158 [inline]
       elevator_disable+0xd3/0x3f0 block/elevator.c:674
       blk_mq_elv_switch_none block/blk-mq.c:4861 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
       blk_mq_update_nr_hw_queues+0x646/0x1ae0 block/blk-mq.c:4985
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
  &eq->sysfs_lock --> &q->q_usage_counter(io)#53 --> &q->sysfs_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->sysfs_lock);
                               lock(&q->q_usage_counter(io)#53);
                               lock(&q->sysfs_lock);
  lock(&eq->sysfs_lock);

 *** DEADLOCK ***

5 locks held by syz.3.433/7118:
 #0: ffff8880258dc198 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_ioctl+0x13c/0xf40 drivers/block/nbd.c:1572
 #1: ffff8880258dc0d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0xc2/0x1ae0 block/blk-mq.c:4984
 #2: ffff8880256fd8b0 (&q->q_usage_counter(io)#52){+.+.}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
 #3: ffff8880256fd8e8 (&q->q_usage_counter(queue)#36){+.+.}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
 #4: ffff8880256fdde0 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
 #4: ffff8880256fdde0 (&q->sysfs_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
 #4: ffff8880256fdde0 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x3fa/0x1ae0 block/blk-mq.c:4985

stack backtrace:
CPU: 0 UID: 0 PID: 7118 Comm: syz.3.433 Not tainted 6.12.0-syzkaller-09567-g7eef7e306d3c #0
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
 elevator_exit block/elevator.c:158 [inline]
 elevator_disable+0xd3/0x3f0 block/elevator.c:674
 blk_mq_elv_switch_none block/blk-mq.c:4861 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
 blk_mq_update_nr_hw_queues+0x646/0x1ae0 block/blk-mq.c:4985
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
RIP: 0033:0x7f5d32580809
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5d333ec058 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5d32745fa0 RCX: 00007f5d32580809
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00007f5d325f393e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f5d32745fa0 R15: 00007ffd8ba200a8
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
