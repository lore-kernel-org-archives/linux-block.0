Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A1359A65
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420742; cv=none; b=KYatS5A1XXSkxQtHu2pHKiTTR5pGYiqPClpt6chbfPCeKQWRa87HfHldrXhnhwNCXrlRQTMQZKytX5OLN9Y2YJifTWHvwMx5+TGeXkAn6zjV+5sCnEczqh4VcQfy3MTlLKQQEh9+ab0Rt7xRJUMVyHvwSb1nilNdgS38B9uKaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420742; c=relaxed/simple;
	bh=SrpKzkmoRGx7aazaCTA107jF2QwXhaZk67Ma+gjHqFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=alhFbNANz2VLdD3PEs4bTnkXFvt0sdi5ovyt0U+/bFDuB2vE31qZ4pZ+ewSRLKDVMKJMHHcjg6Qjj5Z8yu92VHXwPIggq7M67HsnkEsXn1ZikN0YRaWzZXT50fl+ooVXr4YofvtWaXU0g/2ZPKGP31at4NGBZfb0vv78yHOxldc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAT2AotZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAT2AotZ"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7414516609so1353868a12.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2026 23:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774420740; x=1775025540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=td6V/HkD0jTQ2Ddg/5MFuwcSeqzl2MK0WzcLyWTHSrw=;
        b=iAT2AotZBK3FS0g33BAAhhY7cK/sarBzTbsFJ3qSUS3UdiR/i1iysdzudGaxtEq1Xl
         LprSgLIHJR4M6wyLo5qoJ+3zuvRF/re31WDVzTNK4KGlEMwITuAQEtx7+Qz+/rcqkJqj
         kYvAr2rfvhnswi7rODCpfG69A/ViHtGJm2+02UrZktw8OiI497T+gA2yljIFcBG0T2Ct
         5wLsEwz1AT+It3GD4Pn8CZ8mDc6WllbnFF1isvQZq2lAm6GAe59SqFjxuXFwhcaRTBoy
         e7PbVP+y80yItNhwlOqT4uUT7MO2mJ6NacOHWCc6nWmg3O5opk4kxXPxMKZJxeugZJUQ
         uUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774420740; x=1775025540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=td6V/HkD0jTQ2Ddg/5MFuwcSeqzl2MK0WzcLyWTHSrw=;
        b=DkIyrKbAmkBp+19Rdg451RXYkvAE2pP78xpDuJBenduNb+k3agNZeHP5QOXabCDlb9
         WkenCVammEjf71busnxZEmyPQI/OfMcF32jtwPAYxhoP+5M3fV6eri0DPWeuyRRQJCT3
         dneKiDG2huO0/rGOSKJCBGwlaZAMNlfLwZgqGAeapLZc/s05Onu4rn9xp30DkJXGvjOX
         34qZaKOpH6sm0J6dH1Sx58a8jUwzqz/PtLNDNDKVVF8S90dkqVavFyNKpZMn3zOLDK+N
         0zwbF3mQX//ohK/2TLRf6C0m2S5/G5gl2eLe8XV+xwweNT/KNwzSo2m0NaJxLnrNMeKu
         aoqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU96gonnL805zrSM80jfDAvZhSErQ2NcjYvyDirGJX4oben2RGriEKPdF00Y+cEQYH0oNEZ3zu/6HWaTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1mIlER1q3lDLJE5PdjQM7AfNkWyIlI6hhbPVaFhHZAuAFfpP
	5sFoI/2pfN2aetb8OS1oAN08gI2jlP8dJteFPfktVbrfRacDCoWyPIqzkrqP1PFXylYJ+vx6qgd
	iMpHDEg==
X-Received: from pgmp22.prod.google.com ([2002:a63:1e56:0:b0:c74:497:507e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918b:b0:39b:e9e1:699f
 with SMTP id adf61e73a8af0-39c4aa688bbmr2702365637.12.1774420740019; Tue, 24
 Mar 2026 23:39:00 -0700 (PDT)
Date: Wed, 25 Mar 2026 06:38:26 +0000
In-Reply-To: <20260325063843.1790782-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325063843.1790782-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260325063843.1790782-6-kuniyu@google.com>
Subject: [PATCH 5/5] nbd: Use lock_sock_try() for TCP sendmsg() and shutdown().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-block@vger.kernel.org, nbd@other.debian.org, 
	netdev@vger.kernel.org, syzbot+7b4f368d3955d2c9950e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

As reported by syzbot [0], NBD can trigger a deadlock during
memory reclaim.

This occurs when a process holds lock_sock() on a backend TCP
socket and triggers a memory allocation that leads to fs reclaim.
If it eventually calls into NBD to send data or shut down the
socket, NBD will attempt to acquire the same lock_sock(),
resulting in the deadlock.

While NBD sets sk->sk_allocation to GFP_NOIO before calling
sendmsg(), this does not prevent the issue in some paths where
GFP_KERNEL is used directly under lock_sock().

To resolve this, let's use lock_sock_try() for TCP sendmsg() and
shutdown().

For sock_sendmsg(), if lock_sock_try() fails, -ERESTARTSYS is
returned, allowing the request to be retried later (e.g., via
was_interrupted() logic).

For sock_sendmsg() for NBD_CMD_DISC and kernel_sock_shutdown(),
the operation might be skipped if the lock cannot be acquired.
However, this is not expected to occur in practice because the
backend TCP socket should not be touched by userspace once it is
handed over to NBD.

Note that sock_recvmsg() does not require this special handling
because it is only called from the workqueue context.

Also note that AF_UNIX sockets continue to use sock_sendmsg()
and kernel_sock_shutdown() because unix_stream_sendmsg() and
unix_shutdown() do not acquire lock_sock().

[0]:
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L
syz.7.2282/12353 is trying to acquire lock:
ffffffff8e9aa700 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8e9aa700 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4489 [inline]
ffffffff8e9aa700 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4843 [inline]
ffffffff8e9aa700 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_node_noprof+0x53/0x6f0 mm/slub.c:4918

but task is already holding lock:
ffff88806f972a20 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
ffff88806f972a20 (sk_lock-AF_INET6){+.+.}-{0:0}, at: tcp_close+0x1d/0x110 net/ipv4/tcp.c:3349

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #6 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3780
       lock_sock include/net/sock.h:1709 [inline]
       inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:919
       nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:318
       sock_shutdown+0x16b/0x200 drivers/block/nbd.c:411
       nbd_clear_sock drivers/block/nbd.c:1427 [inline]
       nbd_config_put+0x1eb/0x750 drivers/block/nbd.c:1451
       nbd_genl_connect+0xaf8/0x1a40 drivers/block/nbd.c:2248
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2592
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
       __sys_sendmsg+0x170/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x428/0x1080 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
       blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
       blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x584/0x6c0 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
       submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
       blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
       submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x264/0x8e0 fs/buffer.c:2444
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xd1/0x370 block/partitions/core.c:723
       adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
       blkdev_get_whole+0x187/0x290 block/bdev.c:764
       bdev_open+0x2c7/0xe40 block/bdev.c:973
       blkdev_open+0x34e/0x4f0 block/fops.c:697
       do_dentry_open+0x6d8/0x1660 fs/open.c:949
       vfs_open+0x82/0x3f0 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4830
       do_file_open+0x20e/0x430 fs/namei.c:4859
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       nbd_queue_rq+0xba/0x1080 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
       blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
       blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x584/0x6c0 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
       submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
       blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
       submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
       submit_bh fs/buffer.c:2826 [inline]
       block_read_full_folio+0x264/0x8e0 fs/buffer.c:2444
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
       read_mapping_folio include/linux/pagemap.h:1028 [inline]
       read_part_sector+0xd1/0x370 block/partitions/core.c:723
       adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:142 [inline]
       blk_add_partitions block/partitions/core.c:590 [inline]
       bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
       blkdev_get_whole+0x187/0x290 block/bdev.c:764
       bdev_open+0x2c7/0xe40 block/bdev.c:973
       blkdev_open+0x34e/0x4f0 block/fops.c:697
       do_dentry_open+0x6d8/0x1660 fs/open.c:949
       vfs_open+0x82/0x3f0 fs/open.c:1081
       do_open fs/namei.c:4671 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4830
       do_file_open+0x20e/0x430 fs/namei.c:4859
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_openat fs/open.c:1388 [inline]
       __se_sys_openat fs/open.c:1383 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1383
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xa1/0x2a0 kernel/rcu/srcutree.c:1505
       blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
       blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
       elevator_switch+0x17b/0x7e0 block/elevator.c:576
       elevator_change+0x352/0x530 block/elevator.c:681
       elevator_set_default+0x29e/0x360 block/elevator.c:754
       blk_register_queue+0x412/0x590 block/blk-sysfs.c:946
       __add_disk+0x73f/0xe40 block/genhd.c:528
       add_disk_fwnode+0x118/0x5c0 block/genhd.c:597
       add_disk include/linux/blkdev.h:785 [inline]
       nbd_dev_add+0x77a/0xb10 drivers/block/nbd.c:1984
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
       do_one_initcall+0x11d/0x760 init/main.c:1382
       do_initcall_level init/main.c:1444 [inline]
       do_initcalls init/main.c:1460 [inline]
       do_basic_setup init/main.c:1479 [inline]
       kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
       kernel_init+0x1f/0x1e0 init/main.c:1582
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       elevator_change+0x1bc/0x530 block/elevator.c:679
       elevator_set_none+0x92/0xf0 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5110 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5155 [inline]
       blk_mq_update_nr_hw_queues+0x4c1/0x15f0 block/blk-mq.c:5220
       nbd_start_device+0x1a6/0xbd0 drivers/block/nbd.c:1489
       nbd_genl_connect+0xff2/0x1a40 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2592
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
       __sys_sendmsg+0x170/0x220 net/socket.c:2678
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       blk_alloc_queue+0x610/0x790 block/blk-core.c:461
       blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4429
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4476
       nbd_dev_add+0x492/0xb10 drivers/block/nbd.c:1954
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
       do_one_initcall+0x11d/0x760 init/main.c:1382
       do_initcall_level init/main.c:1444 [inline]
       do_initcalls init/main.c:1460 [inline]
       do_basic_setup init/main.c:1479 [inline]
       kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
       kernel_init+0x1f/0x1e0 init/main.c:1582
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
       fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4362
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4489 [inline]
       slab_alloc_node mm/slub.c:4843 [inline]
       kmem_cache_alloc_node_noprof+0x53/0x6f0 mm/slub.c:4918
       __alloc_skb+0x140/0x710 net/core/skbuff.c:702
       alloc_skb include/linux/skbuff.h:1383 [inline]
       tcp_send_active_reset+0x8b/0xa60 net/ipv4/tcp_output.c:3862
       __tcp_close+0x41e/0x1110 net/ipv4/tcp.c:3223
       tcp_close+0x28/0x110 net/ipv4/tcp.c:3350
       inet_release+0xed/0x200 net/ipv4/af_inet.c:443
       inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:479
       __sock_release+0xb3/0x260 net/socket.c:662
       sock_close+0x1c/0x30 net/socket.c:1455
       __fput+0x3ff/0xb40 fs/file_table.c:469
       task_work_run+0x150/0x240 kernel/task_work.c:233
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
       exit_to_user_mode_loop+0x100/0x4a0 kernel/entry/common.c:98
       __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
       syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
       do_syscall_64+0x67c/0xf80 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> &nsock->tx_lock --> sk_lock-AF_INET6

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sk_lock-AF_INET6);
                               lock(&nsock->tx_lock);
                               lock(sk_lock-AF_INET6);
  lock(fs_reclaim);

 *** DEADLOCK ***

Fixes: fd8383fd88a2 ("nbd: convert to blkmq")
Reported-by: syzbot+7b4f368d3955d2c9950e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/69c37e6a.a70a0220.234938.0046.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 drivers/block/nbd.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 1877554d362e..d0d57f8816db 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -45,6 +45,8 @@
 #include <linux/nbd.h>
 #include <linux/nbd-netlink.h>
 #include <net/genetlink.h>
+#include <net/tcp.h>
+#include <net/inet_common.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nbd.h>
@@ -302,6 +304,21 @@ static int nbd_disconnected(struct nbd_config *config)
 		test_bit(NBD_RT_DISCONNECT_REQUESTED, &config->runtime_flags);
 }
 
+static void nbd_sock_shutdown(struct socket *sock)
+{
+	struct sock *sk = sock->sk;
+
+	if (sk_is_stream_unix(sk)) {
+		kernel_sock_shutdown(sock, SHUT_RDWR);
+		return;
+	}
+
+	if (lock_sock_try(sk)) {
+		inet_shutdown_locked(sock, SHUT_RDWR);
+		release_sock(sk);
+	}
+}
+
 static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 				int notify)
 {
@@ -315,7 +332,8 @@ static void nbd_mark_nsock_dead(struct nbd_device *nbd, struct nbd_sock *nsock,
 		}
 	}
 	if (!nsock->dead) {
-		kernel_sock_shutdown(nsock->sock, SHUT_RDWR);
+		nbd_sock_shutdown(nsock->sock);
+
 		if (atomic_dec_return(&nbd->config->live_connections) == 0) {
 			if (test_and_clear_bit(NBD_RT_DISCONNECT_REQUESTED,
 					       &nbd->config->runtime_flags)) {
@@ -548,6 +566,22 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req)
 	return BLK_EH_DONE;
 }
 
+static int nbd_sock_sendmsg(struct socket *sock, struct msghdr *msg)
+{
+	struct sock *sk = sock->sk;
+	int err = -ERESTARTSYS;
+
+	if (sk_is_stream_unix(sk))
+		return sock_sendmsg(sock, msg);
+
+	if (lock_sock_try(sk)) {
+		err = tcp_sendmsg_locked(sk, msg, msg_data_left(msg));
+		release_sock(sk);
+	}
+
+	return err;
+}
+
 static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		       struct iov_iter *iter, int msg_flags, int *sent)
 {
@@ -573,7 +607,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 			msg.msg_flags = msg_flags | MSG_NOSIGNAL;
 
 			if (send)
-				result = sock_sendmsg(sock, &msg);
+				result = nbd_sock_sendmsg(sock, &msg);
 			else
 				result = sock_recvmsg(sock, &msg, msg.msg_flags);
 
-- 
2.53.0.1018.g2bb0e51243-goog

