Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16282135AC
	for <linux-block@vger.kernel.org>; Tue,  4 Feb 2025 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683204; cv=none; b=u+GwgB2cZTPtGkqALfaGjY1gGGlJNO4NQIbDDn1ZZUDLm3zYuzQAT9z15qLhiak32rN9wFHHV5+z12yezyhH8oVEtwjac6JzEbeC1f9kmUycPhF+SvhFwDWOe3BklgHSaI3RWMxdGCk9c6QaYbcTU5ozeW/gCgrTqjep8XN7PPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683204; c=relaxed/simple;
	bh=8CW9zLu4wYIn1BREHAGadBb4OtY8PtxfVY3BURILpNw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=taHWOSzpG/phkUNP5c8yhCFu1aFVwDL1tpqkYAwXRpvCcqRll9XumCEcXhLPc+JI7cz0TCfyeBEAJMj28WrCmTCux1zcG4h1Bb50IxR2Aj7Lce7itWDKhd2ketP4aYus97tXL+L5Y3GR6kkh7EN9jUguPhAWoXQpdsHxZrmkroQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3cfc08132adso94370515ab.3
        for <linux-block@vger.kernel.org>; Tue, 04 Feb 2025 07:33:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738683202; x=1739288002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/XZPSKN0rTUa69hmcUgaY/KUr5mPXR+6fAwUwwxBZs=;
        b=nx2hklSQxiQS+tnVkNBcLhCdYze2poM9oyWIv04C8+VwmmD4A42pzx4B178j7jrC/Z
         spoOPMeEopeuqTMPxkPbJv3u5GoB8gF0pae8yyycY0coiKC2/fn0dmbGbZ7+nOlQral2
         qPvtNxwkxxvuyrUYGyu8KeQXxGBa91QzCF9pxVS/h869Q5L8vWM+sPlg/JNb72WTRxBP
         7BDVRBhaQGdn/CHj+oLzLYuD3zqJIR9jBsTZUUKwmK05wVXvzEco0HFTVhwHW1s/v6re
         VkL0+775/REap53t1Kwa24oyX3VVJNhm0HsvFeF8/fHdyOGdUeD8oO1S8gyuz6QvUS7w
         w66g==
X-Forwarded-Encrypted: i=1; AJvYcCU/UBhUvvHTz4QQXWaVZ+Oa+Jag9PtRnDvA/0BzwrSTgISH1UNygxtD2xmml9hSakl7SuqewPdQxp3dAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE1xN42TorJbXrJkKIrCV78BEYYXL7uCLtaG/CWwrRvjv+G7Gn
	56MFezbzwjC8nu3PaDSaSo4p0YRgnH3zSf/+hBmChTb4O/tn8kExgTBxtdSSmMg+ytspDctMuaq
	LnpbCAP5loEIR/d9aAzI7hcJwl9jrqtTyL6dHtuqKAmJrLSC+wwNH2bU=
X-Google-Smtp-Source: AGHT+IEfJWYNi4dE0UiJv0XIBC2LWjnlwaV7Ui5tLnVgO9JEwqLtiTFf+vsv8yi1w6hI1xe2WDu5zTxYNAgT8iXErmgNHTaBeM0T
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3613:b0:3d0:24c0:bd41 with SMTP id
 e9e14a558f8ab-3d024c0bf0bmr86301235ab.1.1738683201612; Tue, 04 Feb 2025
 07:33:21 -0800 (PST)
Date: Tue, 04 Feb 2025 07:33:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a23341.050a0220.163cdc.0069.GAE@google.com>
Subject: [syzbot] [block?] BUG: sleeping function called from invalid context
 in unmap_mapping_folio
From: syzbot <syzbot+95f1db35defd8524f1dd@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40b8e93e17bf Add linux-next specific files for 20250204
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11c2a3df980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec880188a87c6aad
dashboard link: https://syzkaller.appspot.com/bug?extid=95f1db35defd8524f1dd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16010df8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f078a4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ccdfef06f59f/disk-40b8e93e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b339eaf8dcfd/vmlinux-40b8e93e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ae1a0f1c3c80/bzImage-40b8e93e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+95f1db35defd8524f1dd@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1523
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 9141, name: syz-executor179
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by syz-executor179/9141:
 #0: ffff8880260a34c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf0/0xc50 block/bdev.c:903
 #1: ffffffff8e938960 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e938960 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e938960 (rcu_read_lock){....}-{1:3}, at: blk_mq_flush_plug_list+0x282/0x1870 block/blk-mq.c:2904
CPU: 1 UID: 0 PID: 9141 Comm: syz-executor179 Not tainted 6.14.0-rc1-next-20250204-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8766
 down_read+0x8e/0xa40 kernel/locking/rwsem.c:1523
 i_mmap_lock_read include/linux/fs.h:565 [inline]
 unmap_mapping_folio+0x284/0x3b0 mm/memory.c:3887
 folio_unmap_invalidate+0x122/0x510 mm/truncate.c:557
 folio_end_reclaim_write mm/filemap.c:1609 [inline]
 folio_end_writeback+0x430/0x560 mm/filemap.c:1642
 end_bio_bh_io_sync+0xbf/0x120 fs/buffer.c:2766
 blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
 nullb_complete_cmd drivers/block/null_blk/main.c:1354 [inline]
 null_handle_cmd drivers/block/null_blk/main.c:1405 [inline]
 null_queue_rq+0xbb1/0xd60 drivers/block/null_blk/main.c:1645
 null_queue_rqs+0x1e7/0x370 drivers/block/null_blk/main.c:1659
 __blk_mq_flush_plug_list block/blk-mq.c:2825 [inline]
 blk_mq_flush_plug_list+0x56a/0x1870 block/blk-mq.c:2904
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1213
 blk_finish_plug+0x5e/0x80 block/blk-core.c:1240
 blkdev_writepages+0xb4/0x100 block/fops.c:460
 do_writepages+0x35f/0x880 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
 __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 filemap_write_and_wait_range+0x283/0x3a0 mm/filemap.c:694
 bdev_disk_changed+0x1f9/0x13f0 block/partitions/core.c:656
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:706
 bdev_open+0x2d4/0xc50 block/bdev.c:915
 bdev_file_open_by_dev+0x1b0/0x220 block/bdev.c:1017
 disk_scan_partitions+0x1be/0x2b0 block/genhd.c:374
 blkdev_common_ioctl+0x13cf/0x2460 block/ioctl.c:617
 blkdev_ioctl+0x4ca/0x6a0 block/ioctl.c:687
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8ff244ba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3d9b7178 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff8ff244ba9
RDX: 0000000000000000 RSI: 000000000000125f RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000029a0b
R13: 00007ffe3d9b719c R14: 00007ffe3d9b71b0 R15: 00007ffe3d9b71a0
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.14.0-rc1-next-20250204-syzkaller #0 Tainted: G        W         
-----------------------------
syz-executor179/9141 is trying to lock:
ffff888023423870 (&mapping->i_mmap_rwsem){++++}-{4:4}, at: i_mmap_lock_read include/linux/fs.h:565 [inline]
ffff888023423870 (&mapping->i_mmap_rwsem){++++}-{4:4}, at: unmap_mapping_folio+0x284/0x3b0 mm/memory.c:3887
other info that might help us debug this:
context-{5:5}
2 locks held by syz-executor179/9141:
 #0: ffff8880260a34c8 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0xf0/0xc50 block/bdev.c:903
 #1: ffffffff8e938960 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e938960 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e938960 (rcu_read_lock){....}-{1:3}, at: blk_mq_flush_plug_list+0x282/0x1870 block/blk-mq.c:2904
stack backtrace:
CPU: 1 UID: 0 PID: 9141 Comm: syz-executor179 Tainted: G        W          6.14.0-rc1-next-20250204-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4828 [inline]
 check_wait_context kernel/locking/lockdep.c:4900 [inline]
 __lock_acquire+0x15a8/0x2100 kernel/locking/lockdep.c:5178
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
 i_mmap_lock_read include/linux/fs.h:565 [inline]
 unmap_mapping_folio+0x284/0x3b0 mm/memory.c:3887
 folio_unmap_invalidate+0x122/0x510 mm/truncate.c:557
 folio_end_reclaim_write mm/filemap.c:1609 [inline]
 folio_end_writeback+0x430/0x560 mm/filemap.c:1642
 end_bio_bh_io_sync+0xbf/0x120 fs/buffer.c:2766
 blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
 nullb_complete_cmd drivers/block/null_blk/main.c:1354 [inline]
 null_handle_cmd drivers/block/null_blk/main.c:1405 [inline]
 null_queue_rq+0xbb1/0xd60 drivers/block/null_blk/main.c:1645
 null_queue_rqs+0x1e7/0x370 drivers/block/null_blk/main.c:1659
 __blk_mq_flush_plug_list block/blk-mq.c:2825 [inline]
 blk_mq_flush_plug_list+0x56a/0x1870 block/blk-mq.c:2904
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1213
 blk_finish_plug+0x5e/0x80 block/blk-core.c:1240
 blkdev_writepages+0xb4/0x100 block/fops.c:460
 do_writepages+0x35f/0x880 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
 __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 filemap_write_and_wait_range+0x283/0x3a0 mm/filemap.c:694
 bdev_disk_changed+0x1f9/0x13f0 block/partitions/core.c:656
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:706
 bdev_open+0x2d4/0xc50 block/bdev.c:915
 bdev_file_open_by_dev+0x1b0/0x220 block/bdev.c:1017
 disk_scan_partitions+0x1be/0x2b0 block/genhd.c:374
 blkdev_common_ioctl+0x13cf/0x2460 block/ioctl.c:617
 blkdev_ioctl+0x4ca/0x6a0 block/ioctl.c:687
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8ff244ba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3d9b7178 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff8ff244ba9
RDX: 0000000000000000 RSI: 000000000000125f RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000029a0b
R13: 00007ffe3d9b719c R14: 00007ffe3d9b71b0 R15: 00007ffe3d9b71a0
 </TASK>
BUG: sleeping function called from invalid context at ./include/linux/mmu_notifier.h:434
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 9141, name: syz-executor179
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 9141 Comm: syz-executor179 Tainted: G        W          6.14.0-rc1-next-20250204-syzkaller #0
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8766
 mmu_notifier_invalidate_range_start include/linux/mmu_notifier.h:434 [inline]
 zap_page_range_single+0x386/0x630 mm/memory.c:2015
 unmap_mapping_range_vma mm/memory.c:3836 [inline]
 unmap_mapping_range_tree+0xd7/0x120 mm/memory.c:3853
 unmap_mapping_folio+0x30e/0x3b0 mm/memory.c:3889
 folio_unmap_invalidate+0x122/0x510 mm/truncate.c:557
 folio_end_reclaim_write mm/filemap.c:1609 [inline]
 folio_end_writeback+0x430/0x560 mm/filemap.c:1642
 end_bio_bh_io_sync+0xbf/0x120 fs/buffer.c:2766
 blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
 nullb_complete_cmd drivers/block/null_blk/main.c:1354 [inline]
 null_handle_cmd drivers/block/null_blk/main.c:1405 [inline]
 null_queue_rq+0xbb1/0xd60 drivers/block/null_blk/main.c:1645
 null_queue_rqs+0x1e7/0x370 drivers/block/null_blk/main.c:1659
 __blk_mq_flush_plug_list block/blk-mq.c:2825 [inline]
 blk_mq_flush_plug_list+0x56a/0x1870 block/blk-mq.c:2904
 __blk_flush_plug+0x420/0x500 block/blk-core.c:1213
 blk_finish_plug+0x5e/0x80 block/blk-core.c:1240
 blkdev_writepages+0xb4/0x100 block/fops.c:460
 do_writepages+0x35f/0x880 mm/page-writeback.c:2687
 filemap_fdatawrite_wbc mm/filemap.c:389 [inline]
 __filemap_fdatawrite_range mm/filemap.c:422 [inline]
 filemap_write_and_wait_range+0x283/0x3a0 mm/filemap.c:694
 bdev_disk_changed+0x1f9/0x13f0 block/partitions/core.c:656
 blkdev_get_whole+0x2d2/0x450 block/bdev.c:706
 bdev_open+0x2d4/0xc50 block/bdev.c:915
 bdev_file_open_by_dev+0x1b0/0x220 block/bdev.c:1017
 disk_scan_partitions+0x1be/0x2b0 block/genhd.c:374
 blkdev_common_ioctl+0x13cf/0x2460 block/ioctl.c:617
 blkdev_ioctl+0x4ca/0x6a0 block/ioctl.c:687
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff8ff244ba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3d9b7178 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff8ff244ba9
RDX: 0000000000000000 RSI: 000000000000125f RDI: 0000000000000004
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000029a0b
R13: 00007ffe3d9b719c R14: 00007ffe3d9b71b0 R15: 00007ffe3d9b71a0
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
