Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6B2594
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283246; cv=none; b=i20iZa5RCsh0zyfLIcgF9sENTpDgecDG5J43+b74kyLZPRgOyrPEcQwTNZKRoj4g0JiOZPLgrIpcvEC/Robf06aNJhEPAuFnIKjniLIwzIKoRBxZ5fB27QWyyl/RZ4aeGHjF2jvzLhQReqhi4KOnRaHJuB53BFqA00IVi8aDys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283246; c=relaxed/simple;
	bh=iXi17UoD3vFqFXCbND2VP0QrBQmbugA2a7r2NHufFrU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RdLI63nS8mGLNYZtz8r9ecwBSbr3tguLMPZFnR/7zZmeBKy8wzG/LHmRP37jqF7Vys46a9N4xn49aOTqX5qu5Bj//AE1s5uj32iUZ7LNMn6hwab/K0U+yXKC6A8xC0rDdZhfZtsUT04f0p9HQ0+1g7F6acK/d03j9sqX86rDMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a76690f813so23605485ab.2
        for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 05:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283244; x=1732888044;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXbFjWdYxjTdMMGT612c2qGl5MOP3gKLM3RDhwPgOJs=;
        b=ZIQtuhYiccpNEkIvzeUc+aILBbH0tQQm6EgwLghHOBKEcYVWJBlas2F3XnkW5X7RfB
         yTVSW++WHCGLeApHQE2kOGzUInriG86Nn1RjZuJcMt9WWfgeuRFYGZvzzCZMmv7+Us2h
         vQWhpW9Uuc15nqMvJfDtZv9ea6MP57nDmyMaXAh99yKgR9Sb89UnfnIvrHNAD0OPn5fW
         lbE+T7u2N6d0si735COV7bu65WyBN9Xurm1jnwkKOB0vAIK0EVILYZyACMyQnxhKJjBJ
         Qp7thwB8+4t1INQ97X262J7pIoZiDqGZ3BNEsIOpXHRanQ6X3xI7KtINSfDbZACrBpon
         /OfA==
X-Forwarded-Encrypted: i=1; AJvYcCU591Va69GHxU89qKdPk+uMdOopiZt82cUn/2TlX3+vT5EsvWX8uuz3q/9bogTnrJBzCKbwe+L3/zmDoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx947NOGpKS4HZs1kl7l7PQBDfIBc2usBbjOzc9Nyxs161ovqsU
	PF350iNlTEC09aj9MqWFwYIaLyccqJZmNqOr+wvRwXvGi5hpii+cIAoLczLrTShTwxMnc3nyqAa
	joJXqf+oLDwgFMYJPKUV83xJZ4YA7apVhoLX/iq+SxHGC08fgDqtsUP8=
X-Google-Smtp-Source: AGHT+IEboAAjWKMzt5Dmt+7G8lO7gLCYeDkCvmOEV6pIE4YAlNmvr7+4/Nb7nkreyCKPo40ExLTHTsn43qWIkxiX40+Uzgr/lrND
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:3a7:87f2:b013 with SMTP id
 e9e14a558f8ab-3a79acfc43cmr35938645ab.4.1732283244112; Fri, 22 Nov 2024
 05:47:24 -0800 (PST)
Date: Fri, 22 Nov 2024 05:47:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67408b6c.050a0220.363a1b.013c.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in __synchronize_srcu (2)
From: syzbot <syzbot+c89fbbd2838560d51069@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ae58226b89ac Add linux-next specific files for 20241118
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10986ac0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45719eec4c74e6ba
dashboard link: https://syzkaller.appspot.com/bug?extid=c89fbbd2838560d51069
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd3d650cd6b6/disk-ae58226b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/89a0fb674130/vmlinux-ae58226b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92120e1c6775/bzImage-ae58226b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c89fbbd2838560d51069@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.12.0-next-20241118-syzkaller #0 Not tainted
------------------------------------------------------
syz.5.1853/15515 is trying to acquire lock:
ffff8880250d2610 (set->srcu){.+.+}-{0:0}, at: srcu_lock_sync include/linux/srcu.h:170 [inline]
ffff8880250d2610 (set->srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x9d/0x400 kernel/rcu/srcutree.c:1418

but task is already holding lock:
ffff888025a5fb38 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
ffff888025a5fb38 (&q->sysfs_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
ffff888025a5fb38 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x3fa/0x1ae0 block/blk-mq.c:4985

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&q->sysfs_lock){+.+.}-{4:4}:
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

-> #5 (&q->q_usage_counter(io)#54){++++}-{0:0}:
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

-> #4 (mapping.invalidate_lock#2){.+.+}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       filemap_invalidate_lock_shared include/linux/fs.h:873 [inline]
       page_cache_ra_unbounded+0x143/0x8c0 mm/readahead.c:226
       do_sync_mmap_readahead+0x499/0x970
       filemap_fault+0x8c5/0x1950 mm/filemap.c:3344
       __do_fault+0x135/0x460 mm/memory.c:4907
       do_shared_fault mm/memory.c:5386 [inline]
       do_fault mm/memory.c:5460 [inline]
       do_pte_missing mm/memory.c:3979 [inline]
       handle_pte_fault+0x1139/0x66b0 mm/memory.c:5801
       __handle_mm_fault mm/memory.c:5944 [inline]
       handle_mm_fault+0x1106/0x1bb0 mm/memory.c:6112
       do_user_addr_fault arch/x86/mm/fault.c:1389 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x2b9/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       __put_user_4+0x11/0x20 arch/x86/lib/putuser.S:86
       dccp_getsockopt_service net/dccp/proto.c:607 [inline]
       do_dccp_getsockopt net/dccp/proto.c:634 [inline]
       dccp_getsockopt+0x16d0/0x1910 net/dccp/proto.c:690
       do_sock_getsockopt+0x3c4/0x7e0 net/socket.c:2374
       __sys_getsockopt net/socket.c:2403 [inline]
       __do_sys_getsockopt net/socket.c:2410 [inline]
       __se_sys_getsockopt net/socket.c:2407 [inline]
       __x64_sys_getsockopt+0x2a1/0x370 net/socket.c:2407
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (sk_lock-AF_INET){+.+.}-{0:0}:
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
       blk_mq_dispatch_rq_list+0xad3/0x19d0 block/blk-mq.c:2120
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
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2446
       filemap_read_folio+0x14b/0x630 mm/filemap.c:2366
       do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3826
       read_mapping_folio include/linux/pagemap.h:1011 [inline]
       read_part_sector+0xb3/0x330 block/partitions/core.c:722
       adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x72c/0x13f0 block/partitions/core.c:693
       blkdev_get_whole+0x2d2/0x450 block/bdev.c:707
       bdev_open+0x2d4/0xc50 block/bdev.c:916
       blkdev_open+0x389/0x4f0 block/fops.c:627
       do_dentry_open+0xbe1/0x1b70 fs/open.c:945
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

-> #2 (&nsock->tx_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       nbd_handle_cmd drivers/block/nbd.c:1079 [inline]
       nbd_queue_rq+0x29c/0x2f30 drivers/block/nbd.c:1143
       blk_mq_dispatch_rq_list+0xad3/0x19d0 block/blk-mq.c:2120
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
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2446
       filemap_read_folio+0x14b/0x630 mm/filemap.c:2366
       do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3826
       read_mapping_folio include/linux/pagemap.h:1011 [inline]
       read_part_sector+0xb3/0x330 block/partitions/core.c:722
       adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x72c/0x13f0 block/partitions/core.c:693
       blkdev_get_whole+0x2d2/0x450 block/bdev.c:707
       bdev_open+0x2d4/0xc50 block/bdev.c:916
       blkdev_open+0x389/0x4f0 block/fops.c:627
       do_dentry_open+0xbe1/0x1b70 fs/open.c:945
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

-> #1 (&cmd->lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       nbd_queue_rq+0xfe/0x2f30 drivers/block/nbd.c:1135
       blk_mq_dispatch_rq_list+0xad3/0x19d0 block/blk-mq.c:2120
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
       submit_bh fs/buffer.c:2819 [inline]
       block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2446
       filemap_read_folio+0x14b/0x630 mm/filemap.c:2366
       do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3826
       read_mapping_folio include/linux/pagemap.h:1011 [inline]
       read_part_sector+0xb3/0x330 block/partitions/core.c:722
       adfspart_check_ICS+0xd9/0x9a0 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x72c/0x13f0 block/partitions/core.c:693
       blkdev_get_whole+0x2d2/0x450 block/bdev.c:707
       bdev_open+0x2d4/0xc50 block/bdev.c:916
       blkdev_open+0x389/0x4f0 block/fops.c:627
       do_dentry_open+0xbe1/0x1b70 fs/open.c:945
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

-> #0 (set->srcu){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
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
       blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:906 [inline]
       __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  set->srcu --> &q->q_usage_counter(io)#54 --> &q->sysfs_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->sysfs_lock);
                               lock(&q->q_usage_counter(io)#54);
                               lock(&q->sysfs_lock);
  sync(set->srcu);

 *** DEADLOCK ***

5 locks held by syz.5.1853/15515:
 #0: ffff888026043998 (&nbd->config_lock){+.+.}-{4:4}, at: nbd_ioctl+0x13c/0xf40 drivers/block/nbd.c:1572
 #1: ffff8880260438d8 (&set->tag_list_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0xc2/0x1ae0 block/blk-mq.c:4984
 #2: ffff888025a5f608 (&q->q_usage_counter(io)#54){++++}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
 #3: ffff888025a5f640 (&q->q_usage_counter(queue)#38){+.+.}-{0:0}, at: nbd_start_device+0x16c/0xaa0 drivers/block/nbd.c:1413
 #4: ffff888025a5fb38 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_elv_switch_none block/blk-mq.c:4847 [inline]
 #4: ffff888025a5fb38 (&q->sysfs_lock){+.+.}-{4:4}, at: __blk_mq_update_nr_hw_queues block/blk-mq.c:4925 [inline]
 #4: ffff888025a5fb38 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_mq_update_nr_hw_queues+0x3fa/0x1ae0 block/blk-mq.c:4985

stack backtrace:
CPU: 0 UID: 0 PID: 15515 Comm: syz.5.1853 Not tainted 6.12.0-next-20241118-syzkaller #0
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
 blkdev_ioctl+0x57d/0x6a0 block/ioctl.c:693
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f835e17e759
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f835c5f6038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f835e335f80 RCX: 00007f835e17e759
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000003
RBP: 00007f835e1f175e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f835e335f80 R15: 00007ffe5d2d0dd8
 </TASK>
block nbd5: shutting down sockets


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
