Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554DA8479
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915432; cv=none; b=TQ0eTTfD0coH9ahkO/C9z7kpNRlH6YTJ7mGsEGbUGqIxk4BnolFcmrOF+Uu4bhO1Mc2jUVkqcpZR1B4XXTOWz4y2J+PqCjbTi0EVnKYIjMakkpJLJMoT8/QDLGA37y68QjkxMtkiqlqZH9gCVoe1jaHkvuOR2KLbynZkjdT/Nz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915432; c=relaxed/simple;
	bh=q+GI99sVfXkWh12ou7SjOUmJenya9+w08fGdTOAG6MA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GIxEurdfuHeSuMBY9Q2mSuITbuDegYlFE2QYF34yaFQXZhRw/3w/DG0H2Hcb9VoD2d2AeEiZbDBd/znZrhbOQBI8wRPBFVM6EYsQ9RMIxLfVY2gkvwsoIizy+0P4EftjXdSkWvRxBm52AVGg++hi4KKrfu+rkPK+jJVFiyFneqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-948cc59142aso286881739f.1
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 08:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763915429; x=1764520229;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPPqIXZ07I7rCZ7L1X6ydT420FraMumX1wC40G/6S9Y=;
        b=lO151lBXGnR2geQmy/UQaJXIg+zjWafrCe+QbmOhO/5P39y8RIPm7uV0KDfs/Uk3s5
         GvG9vsmxm25shhJFKsTx3XWSOgScH81lW7rdWmbWiAxnFKSdVEUNAEJPfrmKEwCcTcEg
         U4GTK16xcuPemSDhfdyZB8qTX3pY3m3iHgeYmflS0w823FovAvq38LqO34qIkPxahY3Z
         xpTOE4J3eevIGH/sekqY+T8HSFnP9r4BANrf/Um27I5BSEBZxCYfUopjODT3K+JI8vJ5
         tuyR1q4Q0iDs9U/gRsFZNdRow20c+/EQ/G9uiRLLjBQ2SFlqUcjHRk7bjrj0HyxMdgI9
         s4xw==
X-Forwarded-Encrypted: i=1; AJvYcCU2ixHYMTpTQ4Xtoz2bz3MgHOxCSuNp0pOHKR8EqdMZM+Q6Hgyy1LlFMczI7fbjcBiXA+2rkzNvO/aXDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfb52C6SXn1RETO9nhYqz4fxhdMTKK6supnFPRm42pLXxbvewP
	NEHNMJNNDJ1LccuaJUfk2jvp4lquCNIc+lJKr2t8yXQFG42fd0HKWgdLHifoFrpR7Gk1j80E7Zz
	wWuq+lkO8efEamzuLAA43SW5do3xq0Qz9p4li0PVR7U2QKADRocvY4OMZpgM=
X-Google-Smtp-Source: AGHT+IH5uVKzkM1fWjMva9eiCrBBQR+pmmjd5fJ6OlTiaFtT7UZ11fR+HlZwe2nv43wsK6/daJvKrsOLF0J+YiO1+GDdokZwVmsu
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178f:b0:433:720b:2b80 with SMTP id
 e9e14a558f8ab-435b8c038bamr68519335ab.5.1763915429544; Sun, 23 Nov 2025
 08:30:29 -0800 (PST)
Date: Sun, 23 Nov 2025 08:30:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692336a5.a70a0220.d98e3.006a.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in mempool_alloc_noprof (2)
From: syzbot <syzbot+d64f92e22216675e2b0e@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d724c6f85e80 Add linux-next specific files for 20251121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10bd3a12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=763fb984aa266726
dashboard link: https://syzkaller.appspot.com/bug?extid=d64f92e22216675e2b0e
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2f349c65e3c/disk-d724c6f8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aba40ae987ce/vmlinux-d724c6f8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0b98fbfe576f/bzImage-d724c6f8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d64f92e22216675e2b0e@syzkaller.appspotmail.com

loop6: detected capacity change from 0 to 524288000
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.2.3575/18878 is trying to acquire lock:
ffffffff8e448540 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8e448540 (fs_reclaim){+.+.}-{0:0}, at: mempool_alloc_noprof+0xa7/0x380 mm/mempool.c:559

but task is already holding lock:
ffff888025a40618 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:185 [inline]
ffff888025a40618 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:277 [inline]
ffff888025a40618 (set->srcu){.+.+}-{0:0}, at: blk_mq_dispatch_queue_requests+0x5f9/0x800 block/blk-mq.c:2897

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (set->srcu){.+.+}-{0:0}:
       lock_sync+0xba/0x160 kernel/locking/lockdep.c:5916
       srcu_lock_sync include/linux/srcu.h:197 [inline]
       __synchronize_srcu+0x96/0x3a0 kernel/rcu/srcutree.c:1503
       blk_throtl_init+0x298/0x410 block/blk-throttle.c:1324
       tg_set_conf+0x1c6/0x4b0 block/blk-throttle.c:1359
       cgroup_file_write+0x3a1/0x740 kernel/cgroup/cgroup.c:4312
       kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x5c9/0xb30 fs/read_write.c:686
       ksys_write+0x145/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
       blk_alloc_queue+0x538/0x620 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4410 [inline]
       __blk_mq_alloc_disk+0x15c/0x340 block/blk-mq.c:4457
       loop_add+0x411/0xad0 drivers/block/loop.c:2206
       loop_init+0xd9/0x170 drivers/block/loop.c:2441
       do_one_initcall+0x1fb/0x870 init/main.c:1378
       do_initcall_level+0x104/0x190 init/main.c:1440
       do_initcalls+0x59/0xa0 init/main.c:1456
       kernel_init_freeable+0x334/0x4b0 init/main.c:1688
       kernel_init+0x1d/0x1d0 init/main.c:1578
       ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain+0xb9b/0x2130 kernel/locking/lockdep.c:3908
       __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
       lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
       __fs_reclaim_acquire mm/page_alloc.c:4301 [inline]
       fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4315
       might_alloc include/linux/sched/mm.h:317 [inline]
       mempool_alloc_noprof+0xa7/0x380 mm/mempool.c:559
       bio_alloc_bioset+0x241/0x12a0 block/bio.c:559
       __blkdev_direct_IO_async block/fops.c:338 [inline]
       blkdev_direct_IO+0x9c0/0x17e0 block/fops.c:437
       blkdev_read_iter+0x23d/0x440 block/fops.c:845
       lo_submit_rw_aio+0x488/0x620 drivers/block/loop.c:-1
       lo_rw_aio_nowait drivers/block/loop.c:513 [inline]
       loop_queue_rq+0x6c5/0x8d0 drivers/block/loop.c:2036
       __blk_mq_issue_directly block/blk-mq.c:2714 [inline]
       blk_mq_request_issue_directly+0x3c1/0x710 block/blk-mq.c:2801
       blk_mq_issue_direct+0x2a0/0x660 block/blk-mq.c:2822
       blk_mq_dispatch_queue_requests+0x621/0x800 block/blk-mq.c:2897
       blk_mq_flush_plug_list+0x432/0x550 block/blk-mq.c:2980
       __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x2eb/0xa50 block/blk-core.c:755
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x7b7/0x830 fs/buffer.c:2461
       filemap_read_folio+0x117/0x380 mm/filemap.c:2496
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4096
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
       adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
       loop_reread_partitions+0x5f/0xf0 drivers/block/loop.c:554
       loop_configure+0xbd6/0xe50 drivers/block/loop.c:1248
       lo_ioctl+0x806/0x1c50 drivers/block/loop.c:-1
       blkdev_ioctl+0x60e/0x710 block/ioctl.c:707
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &q->q_usage_counter(io)#17 --> set->srcu

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(set->srcu);
                               lock(&q->q_usage_counter(io)#17);
                               lock(set->srcu);
  lock(fs_reclaim);

 *** DEADLOCK ***

2 locks held by syz.2.3575/18878:
 #0: ffff888025acb358 (&disk->open_mutex){+.+.}-{4:4}, at: loop_reread_partitions+0x46/0xf0 drivers/block/loop.c:553
 #1: ffff888025a40618 (set->srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:185 [inline]
 #1: ffff888025a40618 (set->srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:277 [inline]
 #1: ffff888025a40618 (set->srcu){.+.+}-{0:0}, at: blk_mq_dispatch_queue_requests+0x5f9/0x800 block/blk-mq.c:2897

stack backtrace:
CPU: 0 UID: 0 PID: 18878 Comm: syz.2.3575 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2043
 check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain+0xb9b/0x2130 kernel/locking/lockdep.c:3908
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
 __fs_reclaim_acquire mm/page_alloc.c:4301 [inline]
 fs_reclaim_acquire+0x72/0x100 mm/page_alloc.c:4315
 might_alloc include/linux/sched/mm.h:317 [inline]
 mempool_alloc_noprof+0xa7/0x380 mm/mempool.c:559
 bio_alloc_bioset+0x241/0x12a0 block/bio.c:559
 __blkdev_direct_IO_async block/fops.c:338 [inline]
 blkdev_direct_IO+0x9c0/0x17e0 block/fops.c:437
 blkdev_read_iter+0x23d/0x440 block/fops.c:845
 lo_submit_rw_aio+0x488/0x620 drivers/block/loop.c:-1
 lo_rw_aio_nowait drivers/block/loop.c:513 [inline]
 loop_queue_rq+0x6c5/0x8d0 drivers/block/loop.c:2036
 __blk_mq_issue_directly block/blk-mq.c:2714 [inline]
 blk_mq_request_issue_directly+0x3c1/0x710 block/blk-mq.c:2801
 blk_mq_issue_direct+0x2a0/0x660 block/blk-mq.c:2822
 blk_mq_dispatch_queue_requests+0x621/0x800 block/blk-mq.c:2897
 blk_mq_flush_plug_list+0x432/0x550 block/blk-mq.c:2980
 __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1225
 blk_finish_plug block/blk-core.c:1252 [inline]
 __submit_bio+0x2d3/0x5a0 block/blk-core.c:651
 __submit_bio_noacct_mq block/blk-core.c:724 [inline]
 submit_bio_noacct_nocheck+0x2eb/0xa50 block/blk-core.c:755
 submit_bh fs/buffer.c:2829 [inline]
 block_read_full_folio+0x7b7/0x830 fs/buffer.c:2461
 filemap_read_folio+0x117/0x380 mm/filemap.c:2496
 do_read_cache_folio+0x358/0x590 mm/filemap.c:4096
 read_mapping_folio include/linux/pagemap.h:1017 [inline]
 read_part_sector+0xb6/0x2b0 block/partitions/core.c:722
 adfspart_check_ICS+0xa4/0xa50 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:141 [inline]
 blk_add_partitions block/partitions/core.c:589 [inline]
 bdev_disk_changed+0x75f/0x14b0 block/partitions/core.c:693
 loop_reread_partitions+0x5f/0xf0 drivers/block/loop.c:554
 loop_configure+0xbd6/0xe50 drivers/block/loop.c:1248
 lo_ioctl+0x806/0x1c50 drivers/block/loop.c:-1
 blkdev_ioctl+0x60e/0x710 block/ioctl.c:707
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad4518f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fad45f66038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fad453e5fa0 RCX: 00007fad4518f749
RDX: 0000200000001ac0 RSI: 0000000000004c0a RDI: 0000000000000007
RBP: 00007fad45213f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fad453e6038 R14: 00007fad453e5fa0 R15: 00007fffcf7f94b8
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
