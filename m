Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43A92DECC2
	for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 15:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760541213; cv=none; b=jvJ6iJTKgjty+SP4GPi7XEMxBEBfGGY5nt/Je7tQhG1mtA3Ba0NOocztCiyzMynXu+afRlOlEL8GPALAaxotolbpjrSRQfqT03Nw7TW6OIE4JoC3kJeDpyFulexosKk6zRwA0x/7qTzoJeArfM0R+pT2lR0KEZh5gHNpx/9XodA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760541213; c=relaxed/simple;
	bh=1Vpmqh3Oa+f5kmlG2Ji+51bupr6BS4u7E+PffdkX9hQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HL2nsO/1uU9S1emYvPJXI0jpOg8gM7HuTN2oAg084PGboVC8AIamsH/Kw6cOczVXKJx0ym5MXYinMGypRVUjz2vh+2OYuduPXbtlPLrtwtthhgr3iaSMH6H+RD6qwQ9WdzIgBN+jKrL9IDhFGPgEg9k9Rehs0ctUEM84DAYmESI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-42f7adbd951so339853515ab.0
        for <linux-block@vger.kernel.org>; Wed, 15 Oct 2025 08:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760541211; x=1761146011;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvSfQBz5WEZKMNXZMNy2WXBux7x9W6lQAbwHq/yTSpk=;
        b=GEfPVXfAv71cbZLqnyysIK8Nv5XKVDeYnpJ1YVim1NG9RrQvrOqnmWXriZDL6JabyF
         XoWL89h3O3ew7BhdKvHgsG6tD8r3s3e7ukmjM2Ty08AFFGE3zQZOx7afSj3U4jvnPdBq
         gkidZVbtCOxh03xZ3E+NUOhqJDsA6x/q2BrHkdDsVgKCislW5nU+26IgBdcytFNWNmdS
         dKmPuFqNq1FVw166oxqZjUdiHSkdd6Ke9cBY+shC18HgN+XFA6NZWj1iKvj+O8zxxSEy
         YMohHw4w9GSWg633SpC2PyESd+749FiuBY49Ejy8wqImzhtVGkC3UpF2pZqytZ6goYis
         Q0Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVuwpvidPXkID/kWpMtiQd19FfIhgEIOj0jzcvzfYFYfBDeXVOYtbrSUxhfBVl2KyNvC2i9udRL4ktH6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+EQOB1hv5/OkizYzzkwgaMMUHaU7Rbq4WK4cWS3oSUUp5/dB
	zJFgMjiZA5bE65t1FEkvwkm2/B21xFvWsyjBC4u1++d6Wu/zHfuQBCsURZbT6zrFgT3tVOB+Pdj
	C+fLnkc2sdFZXOiYJCTKvsaHu+PMi92YPupyYKsQziZ5rZKNNXM0njCXmC78=
X-Google-Smtp-Source: AGHT+IGgcLmfsoKlPmir8nB250S8F+v8ntzs8lnEMg1B6v0s93zKnEWZN8FtZleZMjBv0Tz1HOYA/DxGUnAu0a6dNwju7EU3mhMr
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250a:b0:430:b1ff:74cd with SMTP id
 e9e14a558f8ab-430b1ff7686mr15835845ab.10.1760541210691; Wed, 15 Oct 2025
 08:13:30 -0700 (PDT)
Date: Wed, 15 Oct 2025 08:13:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68efba1a.a00a0220.361615.000a.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in __synchronize_srcu (3)
From: syzbot <syzbot+13d361cfb0c0d33ff8dd@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0739473694c4 Merge tag 'for-6.18/hpfs-changes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e559e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7dba95d4cdd903c
dashboard link: https://syzkaller.appspot.com/bug?extid=13d361cfb0c0d33ff8dd
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1111826926b0/disk-07394736.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c32acb7e7c81/vmlinux-07394736.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8508d87f1812/bzImage-07394736.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+13d361cfb0c0d33ff8dd@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G     U             
------------------------------------------------------
syz.1.1346/11768 is trying to acquire lock:
ffff8880338b6f10 (set->srcu){.+.+}-{0:0}, at: srcu_lock_sync include/linux/srcu.h:173 [inline]
ffff8880338b6f10 (set->srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x1c/0x290 kernel/rcu/srcutree.c:1439

but task is already holding lock:
ffff888028c7e808 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x17d/0x5d0 block/elevator.c:689

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       elevator_change+0x17d/0x5d0 block/elevator.c:689
       elv_iosched_store+0x315/0x3c0 block/elevator.c:824
       queue_attr_store+0x26b/0x310 block/blk-sysfs.c:869
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
       kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x7d3/0x11d0 fs/read_write.c:686
       ksys_write+0x12a/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&q->q_usage_counter(io)#62){++++}-{0:0}:
       blk_alloc_queue+0x619/0x760 block/blk-core.c:461
       blk_mq_alloc_queue+0x172/0x280 block/blk-mq.c:4399
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4446
       nbd_dev_add+0x492/0xbb0 drivers/block/nbd.c:1951
       nbd_init+0x181/0x320 drivers/block/nbd.c:2688
       do_one_initcall+0x120/0x6e0 init/main.c:1283
       do_initcall_level init/main.c:1345 [inline]
       do_initcalls init/main.c:1361 [inline]
       do_basic_setup init/main.c:1380 [inline]
       kernel_init_freeable+0x5c2/0x910 init/main.c:1593
       kernel_init+0x1c/0x2b0 init/main.c:1483
       ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
       fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4283
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4898 [inline]
       slab_alloc_node mm/slub.c:5222 [inline]
       kmem_cache_alloc_node_noprof+0x5e/0x770 mm/slub.c:5298
       __alloc_skb+0x2b2/0x380 net/core/skbuff.c:660
       alloc_skb_fclone include/linux/skbuff.h:1433 [inline]
       tcp_stream_alloc_skb+0x34/0x560 net/ipv4/tcp.c:912
       tcp_sendmsg_locked+0x12d9/0x42e0 net/ipv4/tcp.c:1218
       tcp_sendmsg+0x2e/0x50 net/ipv4/tcp.c:1413
       inet_sendmsg+0xb9/0x140 net/ipv4/af_inet.c:853
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       sock_write_iter+0x509/0x610 net/socket.c:1195
       new_sync_write fs/read_write.c:593 [inline]
       vfs_write+0x7d3/0x11d0 fs/read_write.c:686
       ksys_write+0x1f8/0x250 fs/read_write.c:738
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
       lock_sock include/net/sock.h:1679 [inline]
       inet_shutdown+0x67/0x440 net/ipv4/af_inet.c:907
       nbd_mark_nsock_dead+0xae/0x5d0 drivers/block/nbd.c:318
       recv_work+0x671/0xa80 drivers/block/nbd.c:1018
       process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
       process_scheduled_works kernel/workqueue.c:3346 [inline]
       worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
       kthread+0x3c2/0x780 kernel/kthread.c:463
       ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       nbd_handle_cmd drivers/block/nbd.c:1140 [inline]
       nbd_queue_rq+0x423/0x12d0 drivers/block/nbd.c:1204
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2367
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2928
       blk_mq_flush_plug_list block/blk-mq.c:2976 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2948
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       blk_finish_plug block/blk-core.c:1249 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x53d/0xc10 block/blk-core.c:755
       submit_bio_noacct+0xbbb/0x1f60 block/blk-core.c:879
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x34e/0x850 fs/buffer.c:2447
       filemap_read_folio+0xc5/0x2a0 mm/filemap.c:2444
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x34e/0x4f0 block/fops.c:701
       do_dentry_open+0x982/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4134
       do_filp_open+0x20b/0x470 fs/namei.c:4161
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:598 [inline]
       __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
       nbd_queue_rq+0xbd/0x12d0 drivers/block/nbd.c:1196
       blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2129
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2367
       blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2928
       blk_mq_flush_plug_list block/blk-mq.c:2976 [inline]
       blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2948
       __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1225
       blk_finish_plug block/blk-core.c:1252 [inline]
       blk_finish_plug block/blk-core.c:1249 [inline]
       __submit_bio+0x545/0x690 block/blk-core.c:651
       __submit_bio_noacct_mq block/blk-core.c:724 [inline]
       submit_bio_noacct_nocheck+0x53d/0xc10 block/blk-core.c:755
       submit_bio_noacct+0xbbb/0x1f60 block/blk-core.c:879
       submit_bh fs/buffer.c:2829 [inline]
       block_read_full_folio+0x34e/0x850 fs/buffer.c:2447
       filemap_read_folio+0xc5/0x2a0 mm/filemap.c:2444
       do_read_cache_folio+0x263/0x5c0 mm/filemap.c:4024
       read_mapping_folio include/linux/pagemap.h:999 [inline]
       read_part_sector+0xd4/0x370 block/partitions/core.c:722
       adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
       check_partition block/partitions/core.c:141 [inline]
       blk_add_partitions block/partitions/core.c:589 [inline]
       bdev_disk_changed+0x720/0x1520 block/partitions/core.c:693
       blkdev_get_whole+0x187/0x290 block/bdev.c:748
       bdev_open+0x2c7/0xe40 block/bdev.c:957
       blkdev_open+0x34e/0x4f0 block/fops.c:701
       do_dentry_open+0x982/0x1530 fs/open.c:965
       vfs_open+0x82/0x3f0 fs/open.c:1097
       do_open fs/namei.c:3975 [inline]
       path_openat+0x1de4/0x2cb0 fs/namei.c:4134
       do_filp_open+0x20b/0x470 fs/namei.c:4161
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
       do_sys_open fs/open.c:1452 [inline]
       __do_sys_openat fs/open.c:1468 [inline]
       __se_sys_openat fs/open.c:1463 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1463
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (set->srcu){.+.+}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
       lock_sync+0xa0/0x110 kernel/locking/lockdep.c:5916
       srcu_lock_sync include/linux/srcu.h:173 [inline]
       __synchronize_srcu+0xa1/0x290 kernel/rcu/srcutree.c:1439
       blk_mq_wait_quiesce_done block/blk-mq.c:283 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:280 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:303 [inline]
       blk_mq_quiesce_queue+0x149/0x1b0 block/blk-mq.c:298
       elevator_switch+0x17d/0x810 block/elevator.c:588
       elevator_change+0x391/0x5d0 block/elevator.c:691
       elevator_set_default+0x2e9/0x380 block/elevator.c:767
       blk_register_queue+0x384/0x4e0 block/blk-sysfs.c:942
       __add_disk+0x74a/0xf00 block/genhd.c:528
       add_disk_fwnode+0x13f/0x5d0 block/genhd.c:597
       add_disk include/linux/blkdev.h:775 [inline]
       nbd_dev_add+0x783/0xbb0 drivers/block/nbd.c:1981
       nbd_genl_connect+0x8b0/0x1c60 drivers/block/nbd.c:2122
       genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
       genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
       genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
       netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
       netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
       netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
       netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
       sock_sendmsg_nosec net/socket.c:727 [inline]
       __sock_sendmsg net/socket.c:742 [inline]
       ____sys_sendmsg+0xa95/0xc70 net/socket.c:2630
       ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
       __sys_sendmsg+0x16d/0x220 net/socket.c:2716
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  set->srcu --> &q->q_usage_counter(io)#62 --> &q->elevator_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&q->elevator_lock);
                               lock(&q->q_usage_counter(io)#62);
                               lock(&q->elevator_lock);
  sync(set->srcu);

 *** DEADLOCK ***

6 locks held by syz.1.1346/11768:
 #0: ffffffff901a2310 (cb_lock){++++}-{4:4}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff901a23c8 (genl_mutex){+.+.}-{4:4}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff901a23c8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff901a23c8 (genl_mutex){+.+.}-{4:4}, at: genl_op_lock net/netlink/genetlink.c:57 [inline]
 #1: ffffffff901a23c8 (genl_mutex){+.+.}-{4:4}, at: genl_rcv_msg+0x577/0x800 net/netlink/genetlink.c:1209
 #2: ffff88807f5329c8 (&set->update_nr_hwq_lock){++++}-{4:4}, at: add_disk_fwnode+0x12e/0x5d0 block/genhd.c:596
 #3: ffff888028c7e898 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_register_queue+0x10c/0x4e0 block/blk-sysfs.c:925
 #4: ffff888028c7e300 (&q->q_usage_counter(queue)#55){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x15/0x20 block/blk-mq.c:205
 #5: ffff888028c7e808 (&q->elevator_lock){+.+.}-{4:4}, at: elevator_change+0x17d/0x5d0 block/elevator.c:689

stack backtrace:
CPU: 0 UID: 0 PID: 11768 Comm: syz.1.1346 Tainted: G     U              syzkaller #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2043
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x12a6/0x1ce0 kernel/locking/lockdep.c:5237
 lock_sync+0xa0/0x110 kernel/locking/lockdep.c:5916
 srcu_lock_sync include/linux/srcu.h:173 [inline]
 __synchronize_srcu+0xa1/0x290 kernel/rcu/srcutree.c:1439
 blk_mq_wait_quiesce_done block/blk-mq.c:283 [inline]
 blk_mq_wait_quiesce_done block/blk-mq.c:280 [inline]
 blk_mq_quiesce_queue block/blk-mq.c:303 [inline]
 blk_mq_quiesce_queue+0x149/0x1b0 block/blk-mq.c:298
 elevator_switch+0x17d/0x810 block/elevator.c:588
 elevator_change+0x391/0x5d0 block/elevator.c:691
 elevator_set_default+0x2e9/0x380 block/elevator.c:767
 blk_register_queue+0x384/0x4e0 block/blk-sysfs.c:942
 __add_disk+0x74a/0xf00 block/genhd.c:528
 add_disk_fwnode+0x13f/0x5d0 block/genhd.c:597
 add_disk include/linux/blkdev.h:775 [inline]
 nbd_dev_add+0x783/0xbb0 drivers/block/nbd.c:1981
 nbd_genl_connect+0x8b0/0x1c60 drivers/block/nbd.c:2122
 genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8c8/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2630
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2684
 __sys_sendmsg+0x16d/0x220 net/socket.c:2716
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4935f8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4936e17038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f49361e5fa0 RCX: 00007f4935f8eec9
RDX: 0000000020040000 RSI: 0000200000000500 RDI: 0000000000000005
RBP: 00007f4936011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f49361e6038 R14: 00007f49361e5fa0 R15: 00007ffe1aba29b8
 </TASK>
nbd: socks must be embedded in a SOCK_ITEM attr


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
