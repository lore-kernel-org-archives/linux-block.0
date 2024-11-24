Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88614F9F7
	for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732490000; cv=none; b=ddfYSUr5TiVSyim2uThAMUNwa0nh7b2kTeAnpOnvRg8yg60l5/mULJgTw9kdTfCA5TS2N9QoI+XBzM99/OJLOIJigGU0PPd7Zmt2B8NHODhtZv0TSEBcyRpbwLm9MyOtAF9SeNPTF7eS0LrvyDqR/mpKqMVuf3n7qQpJsF5eFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732490000; c=relaxed/simple;
	bh=9531LjBZV1Xv0wsbzbNx6HGuw1jKS8W0+M26/EFREIg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Zi5qmk1tJf1rrQVE7tDEUJZvZuBxi8XPah1a54jt1vzkgFs6aRQ/z2VE46Rsc/ePX29rNx4GREaMxE+1mShpL5VySwbtrJYIVEUWU/UVgBDya/XuF5qEOBP6oWVWgshWFYMtDCgtJ19QHJjjzQmuQqyQC6MBP8cbUwaUkmOhZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a77a0ca771so27430315ab.0
        for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 15:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732489998; x=1733094798;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aIp1r+MfuM69bclMjMD0bqrhiNUlLBDaI+hfxS56xEg=;
        b=Ad1csSIkpIScv1Kg+AHecVfJ1E0ElbCdmZQjzz231zBjq/mUSw77Zdd+VYLujGKehw
         e2hk7BMyQO/8xL8vc4DtRZ/7uFsvKrnqnH397oZvWAEvwAiKY7c2NeyDTTdWlT7p3pVY
         1mgSw9f2OthZUuJFmbTvjpcRz1+1NAo5YeINdcSeTrZrFOZ2SfkpoKRDn92/Rkb+sUAv
         eEXQf0+OD8MLn9QBTnb4Wmy3IUUYTx4eIDvmwXmfHPyWeq5UsRQylcReI67SBK5m8GAK
         gpU+mI5E7w51LDiUTzyRcDYJEcMEVK0zY1RavtDZI+DaRDwZCaOXA0ZnCcSLNRPhNa8r
         UMrw==
X-Forwarded-Encrypted: i=1; AJvYcCUO3sMIbVc4OqmoIVYYR4ops+4JycToGQm3pQzMIUD9Fh5fUolCCTEv3xtT/XwTybcejGZ5NOrg7SEOPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YytGNtstMhQna462bR+7ex17PZv/MQ6E0I0lei1bQ5V6pyl6CvB
	o97chtA3DL4EG/ZPIQf4ARrJmzvPa9Md9dq4R6ijE/WIJlyNKlL0/J5ROjx3wU6B3NzejNe6kSD
	168rU33eil/chz/0D0YQJ+YF2Q+VmzFDg5JX7adztIWv+esyhcS5VQL0=
X-Google-Smtp-Source: AGHT+IGyC0PK5gs0d5ShK/KKN68y1WnlJ8S3Qm4QaVjqam5JOR6NlReBhTWXCtWOaYIZbVZuOc9KBjdXgzc5JhhYTGQFdHL179cc
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a03:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3a79afd9ab5mr110281855ab.24.1732489997917; Sun, 24 Nov 2024
 15:13:17 -0800 (PST)
Date: Sun, 24 Nov 2024 15:13:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743b30d.050a0220.1cc393.004e.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in blk_mq_update_nr_hw_queues
From: syzbot <syzbot+6279b273d888c2017726@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168001c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95b76860fd16c857
dashboard link: https://syzkaller.appspot.com/bug?extid=6279b273d888c2017726
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/112cedff0255/disk-06afb0f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f65020d28328/vmlinux-06afb0f3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fb4cb7df5b1/bzImage-06afb0f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6279b273d888c2017726@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-07834-g06afb0f36106 #0 Not tainted
------------------------------------------------------
syz.2.2220/13838 is trying to acquire lock:
ffff8880257485d8 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
ffff8880257485d8 (&q->sysfs_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
ffff8880257485d8 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x3fa/0x1ae0 block/blk-mq.c:4985

but task is already holding lock:
ffff8880257480a8 (&q->q_usage_counter(io)#51){++++}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (&q->q_usage_counter(io)#51){++++}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x23a0 block/blk-mq.c:3092
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2824 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2451
       filemap_read_folio+0x14d/0x630 mm/filemap.c:2367
       filemap_update_page mm/filemap.c:2451 [inline]
       filemap_get_pages+0x17af/0x2540 mm/filemap.c:2572
       filemap_read+0x45c/0xf50 mm/filemap.c:2647
       blkdev_read_iter+0x2d8/0x430 block/fops.c:767
       new_sync_read fs/read_write.c:484 [inline]
       vfs_read+0x993/0xb70 fs/read_write.c:565
       ksys_read+0x18f/0x2b0 fs/read_write.c:708
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (mapping.invalidate_lock#2){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       filemap_fault+0xd54/0x1950 mm/filemap.c:3352
       __do_fault+0x137/0x460 mm/memory.c:4882
       do_read_fault mm/memory.c:5297 [inline]
       do_fault mm/memory.c:5431 [inline]
       do_pte_missing mm/memory.c:3965 [inline]
       handle_pte_fault+0x2d1c/0x6820 mm/memory.c:5766
       __handle_mm_fault mm/memory.c:5909 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6077
       faultin_page mm/gup.c:1187 [inline]
       __get_user_pages+0x1c82/0x49e0 mm/gup.c:1485
       populate_vma_page_range+0x264/0x330 mm/gup.c:1923
       __mm_populate+0x27a/0x460 mm/gup.c:2026
       do_mlock+0x61f/0x7e0 mm/mlock.c:653
       __do_sys_mlock mm/mlock.c:661 [inline]
       __se_sys_mlock mm/mlock.c:659 [inline]
       __x64_sys_mlock+0x60/0x70 mm/mlock.c:659
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&mm->mmap_lock){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __might_fault+0xc6/0x120 mm/memory.c:6716
       _copy_from_iter+0x114/0x1e70 lib/iov_iter.c:259
       copy_from_iter include/linux/uio.h:219 [inline]
       copy_from_iter_full include/linux/uio.h:236 [inline]
       skb_do_copy_data_nocache include/net/sock.h:2187 [inline]
       skb_copy_to_page_nocache include/net/sock.h:2213 [inline]
       tcp_sendmsg_locked+0x18a5/0x4f30 net/ipv4/tcp.c:1222
       tcp_sendmsg+0x30/0x50 net/ipv4/tcp.c:1358
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg+0x1a6/0x270 net/socket.c:726
       sock_write_iter+0x2d7/0x3f0 net/socket.c:1147
       new_sync_write fs/read_write.c:586 [inline]
       vfs_write+0xaed/0xd30 fs/read_write.c:679
       ksys_write+0x18f/0x2b0 fs/read_write.c:731
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       lock_sock_nested+0x48/0x100 net/core/sock.c:3622
       lock_sock include/net/sock.h:1617 [inline]
       inet_autobind net/ipv4/af_inet.c:178 [inline]
       inet_send_prepare net/ipv4/af_inet.c:837 [inline]
       inet_sendmsg+0x120/0x390 net/ipv4/af_inet.c:848
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg+0x1a6/0x270 net/socket.c:726
       sock_sendmsg+0x134/0x200 net/socket.c:749
       __sock_xmit+0x219/0x4e0 drivers/block/nbd.c:577
       sock_xmit drivers/block/nbd.c:605 [inline]
       nbd_send_cmd drivers/block/nbd.c:691 [inline]
       nbd_handle_cmd drivers/block/nbd.c:1113 [inline]
       nbd_queue_rq+0x163c/0x2f30 drivers/block/nbd.c:1143
       blk_mq_dispatch_rq_list+0xad5/0x19d0 block/blk-mq.c:2120
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
       __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
       blk_mq_sched_dispatch_requests+0xd6/0x190 block/blk-mq-sched.c:331
       blk_mq_run_hw_queue+0x354/0x500 block/blk-mq.c:2354
       blk_mq_flush_plug_list+0x118e/0x1870 block/blk-mq.c:2915
       __blk_flush_plug+0x420/0x500 block/blk-core.c:1213
       blk_finish_plug block/blk-core.c:1240 [inline]
       __submit_bio+0x46a/0x560 block/blk-core.c:637
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2824 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2451
       filemap_read_folio+0x14d/0x630 mm/filemap.c:2367
       do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3827
       read_mapping_folio include/linux/pagemap.h:1011 [inline]
       read_part_sector+0xb3/0x330 block/partitions/core.c:722
       adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x72e/0x13f0 block/partitions/core.c:693
       blkdev_get_whole+0x2d2/0x450 block/bdev.c:707
       bdev_open+0x2d4/0xc50 block/bdev.c:916
       blkdev_open+0x389/0x4f0 block/fops.c:627
       do_dentry_open+0xbe3/0x1b70 fs/open.c:945
       vfs_open+0x3e/0x330 fs/open.c:1075
       do_open fs/namei.c:3828 [inline]
       path_openat+0x2c84/0x3590 fs/namei.c:3987
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_openat fs/open.c:1433 [inline]
       __se_sys_openat fs/open.c:1428 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       nbd_handle_cmd drivers/block/nbd.c:1079 [inline]
       nbd_queue_rq+0x29c/0x2f30 drivers/block/nbd.c:1143
       blk_mq_dispatch_rq_list+0xad5/0x19d0 block/blk-mq.c:2120
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
       __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
       blk_mq_sched_dispatch_requests+0xd6/0x190 block/blk-mq-sched.c:331
       blk_mq_run_hw_queue+0x354/0x500 block/blk-mq.c:2354
       blk_mq_flush_plug_list+0x118e/0x1870 block/blk-mq.c:2915
       __blk_flush_plug+0x420/0x500 block/blk-core.c:1213
       blk_finish_plug block/blk-core.c:1240 [inline]
       __submit_bio+0x46a/0x560 block/blk-core.c:637
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2824 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2451
       filemap_read_folio+0x14d/0x630 mm/filemap.c:2367
       do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3827
       read_mapping_folio include/linux/pagemap.h:1011 [inline]
       read_part_sector+0xb3/0x330 block/partitions/core.c:722
       adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x72e/0x13f0 block/partitions/core.c:693
       blkdev_get_whole+0x2d2/0x450 block/bdev.c:707
       bdev_open+0x2d4/0xc50 block/bdev.c:916
       blkdev_open+0x389/0x4f0 block/fops.c:627
       do_dentry_open+0xbe3/0x1b70 fs/open.c:945
       vfs_open+0x3e/0x330 fs/open.c:1075
       do_open fs/namei.c:3828 [inline]
       path_openat+0x2c84/0x3590 fs/namei.c:3987
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_openat fs/open.c:1433 [inline]
       __se_sys_openat fs/open.c:1428 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       nbd_queue_rq+0xfe/0x2f30 drivers/block/nbd.c:1135
       blk_mq_dispatch_rq_list+0xad5/0x19d0 block/blk-mq.c:2120
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
       __blk_mq_sched_dispatch_requests+0xb8a/0x1840 block/blk-mq-sched.c:309
       blk_mq_sched_dispatch_requests+0xd6/0x190 block/blk-mq-sched.c:331
       blk_mq_run_hw_queue+0x354/0x500 block/blk-mq.c:2354
       blk_mq_flush_plug_list+0x118e/0x1870 block/blk-mq.c:2915
       __blk_flush_plug+0x420/0x500 block/blk-core.c:1213
       blk_finish_plug block/blk-core.c:1240 [inline]
       __submit_bio+0x46a/0x560 block/blk-core.c:637
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       submit_bh fs/buffer.c:2824 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2451
       filemap_read_folio+0x14d/0x630 mm/filemap.c:2367
       do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3827
       read_mapping_folio include/linux/pagemap.h:1011 [inline]
       read_part_sector+0xb3/0x330 block/partitions/core.c:722
       adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x72e/0x13f0 block/partitions/core.c:693
       blkdev_get_whole+0x2d2/0x450 block/bdev.c:707
       bdev_open+0x2d4/0xc50 block/bdev.c:916
       blkdev_open+0x389/0x4f0 block/fops.c:627
       do_dentry_open+0xbe3/0x1b70 fs/open.c:945
       vfs_open+0x3e/0x330 fs/open.c:1075
       do_open fs/namei.c:3828 [inline]
       path_openat+0x2c84/0x3590 fs/namei.c:3987
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_openat fs/open.c:1433 [inline]
       __se_sys_openat fs/open.c:1428 [inline]
       __x64_sys_openat+0x247/0x2a0 fs/open.c:1428
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (set->srcu){.+.+}-{0:0}:
       lock_sync+0x18b/0x310 kernel/locking/lockdep.c:5897
       srcu_lock_sync include/linux/srcu.h:170 [inline]
       __synchronize_srcu+0xb1/0x400 kernel/rcu/srcutree.c:1418
       elevator_disable+0x8c/0x3f0 block/elevator.c:671
       blk_mq_elv_switch_none block/blk-mq.c:4861 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
       blk_mq_update_nr_hw_queues+0x646/0x1ae0 block/blk-mq.c:4985
       nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
       nbd_start_device_ioctl drivers/block/nbd.c:1464 [inline]
       __nbd_ioctl drivers/block/nbd.c:1539 [inline]
       nbd_ioctl+0x5dc/0xf40 drivers/block/nbd.c:1579
       blkdev_ioctl+0x57f/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&q->sysfs_lock){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
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
       blkdev_ioctl+0x57f/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &q->sysfs_lock --> mapping.invalidate_lock#2 --> &q->q_usage_counter(io)#51

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->q_usage_counter(io)#51);
                               lock(mapping.invalidate_lock#2);
                               lock(&q->q_usage_counter(io)#51);
  lock(&q->sysfs_lock);

 *** DEADLOCK ***

4 locks held by syz.2.2220/13838:
 #0: ffff8880256d9198 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_ioctl+0x13c/0xf40 drivers/block/nbd.c:1572
 #1: ffff8880256d90d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0xc2/0x1ae0 block/blk-mq.c:4984
 #2: ffff8880257480a8 (&q->q_usage_counter(io)#51){++++}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
 #3: ffff8880257480e0 (&q->q_usage_counter(queue)#35){+.+.}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413

stack backtrace:
CPU: 0 UID: 0 PID: 13838 Comm: syz.2.2220 Not tainted 6.12.0-syzkaller-07834-g06afb0f36106 #0
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
 blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
 __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
 blk_mq_update_nr_hw_queues+0x3fa/0x1ae0 block/blk-mq.c:4985
 nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
 nbd_start_device_ioctl drivers/block/nbd.c:1464 [inline]
 __nbd_ioctl drivers/block/nbd.c:1539 [inline]
 nbd_ioctl+0x5dc/0xf40 drivers/block/nbd.c:1579
 blkdev_ioctl+0x57f/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf7/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1bdd97e819
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1bde6e7038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1bddb35fa0 RCX: 00007f1bdd97e819
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00007f1bdd9f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f1bddb35fa0 R15: 00007ffeb92d6118
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
