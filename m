Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A463B21ADA4
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484505; cv=none; b=upBtU8qEIIYqCJw/TFRP1guXAkiMFaGMp7I+3xab6F4B3JixqWaeekXqajmtCP3UpWPePnEAr1IyxEG9NYi/QDcgwmBvUJgaL7FSqF1F5Y6pa7a8kKkmfY3jX54qujDLqmcBev4hZXPJnqBrx36g0bEJjzKPayuBQN+b3F31n/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484505; c=relaxed/simple;
	bh=axU38HGcygJpPdGVJqAzc7AYVvHER6LDMpVza9C4rqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3+lX6B5/94G0ZEVzXBqqNEkntaOA9Ue+tPmrYb6vkTafWQVzhltRIjwh+RDPLCyDeBSNslrrprvZb4LsPvivGjvujXF0QufTtnIKdGb01Ma9Wp7uNVpc14u3GgsDCAQOWkIg5K4XMn0jSrJduyXby27Z66+2pHGms3xEuy0o2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=lO/B/sAu; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="lO/B/sAu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774484499;
	bh=y/pTefj4YleDEi8mQ8p4mixhTa+/Y+QH8KK4kfQ2KD4=;
	h=From:Subject:Date:Message-ID;
	b=lO/B/sAum7gKGBjl0DxRQ/RKgGVpGW2JxZzLq4iuOW+hWGFoVpG0i0yjCl2xzhSi0
	 BXGSaeJ/vQUGorCSUP4z+SkpJ41sdmJG2KGtkzLQnxEe8M1hk+cL+r0zZSRTT2RV3U
	 QbDNkpyXfJ4GSzfpC/gZZgNiDrXD5FWokQTL25u8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 69C47B7A00003B79; Thu, 26 Mar 2026 08:19:09 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7275206685013
X-SMAIL-UIID: 9830BE2384D24577A808FA867CED5405-20260326-081909-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+576095eed5658cbd9b63@syzkaller.appspotmail.com>
Cc: edumazet@google.com,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in inet_shutdown (3)
Date: Thu, 26 Mar 2026 08:18:59 +0800
Message-ID: <20260326001900.1546-1-hdanton@sina.com>
In-Reply-To: <69c37e6a.a70a0220.234938.0045.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Tue, 24 Mar 2026 23:19:22 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8a30aeb0d1b4 Merge tag 'nfsd-7.0-2' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11308cba580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
> dashboard link: https://syzkaller.appspot.com/bug?extid=576095eed5658cbd9b63
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a5cada580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11db72da580000
> 
Given ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier"),
this is a known issue, so loop in some blk guys.

> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2814077e7714/disk-8a30aeb0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5d83711b3a6b/vmlinux-8a30aeb0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e4091d6862e5/bzImage-8a30aeb0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+576095eed5658cbd9b63@syzkaller.appspotmail.com
> 
> block nbd0: Receive control failed (result -107)
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> kworker/u9:3/5993 is trying to acquire lock:
> ffff88801c36d1e0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
> ffff88801c36d1e0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:919
> 
> but task is already holding lock:
> ffff888078118c70 (&nsock->tx_lock){+.+.}-{4:4}, at: recv_work+0x5e7/0x8c0 drivers/block/nbd.c:1020
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #6 (&nsock->tx_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
>        nbd_queue_rq+0x428/0x1080 drivers/block/nbd.c:1207
>        blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
>        blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
>        blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
>        blk_finish_plug block/blk-core.c:1257 [inline]
>        __submit_bio+0x584/0x6c0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
>        submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
>        blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
>        submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
>        submit_bh fs/buffer.c:2826 [inline]
>        block_read_full_folio+0x264/0x8e0 fs/buffer.c:2444
>        filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
>        do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
>        read_mapping_folio include/linux/pagemap.h:1028 [inline]
>        read_part_sector+0xd1/0x370 block/partitions/core.c:723
>        adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:142 [inline]
>        blk_add_partitions block/partitions/core.c:590 [inline]
>        bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
>        blkdev_get_whole+0x187/0x290 block/bdev.c:764
>        bdev_open+0x2c7/0xe40 block/bdev.c:973
>        blkdev_open+0x34e/0x4f0 block/fops.c:697
>        do_dentry_open+0x6d8/0x1660 fs/open.c:949
>        vfs_open+0x82/0x3f0 fs/open.c:1081
>        do_open fs/namei.c:4671 [inline]
>        path_openat+0x208c/0x31a0 fs/namei.c:4830
>        do_file_open+0x20e/0x430 fs/namei.c:4859
>        do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
>        do_sys_open fs/open.c:1372 [inline]
>        __do_sys_openat fs/open.c:1388 [inline]
>        __se_sys_openat fs/open.c:1383 [inline]
>        __x64_sys_openat+0x12d/0x210 fs/open.c:1383
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #5 (&cmd->lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        nbd_queue_rq+0xba/0x1080 drivers/block/nbd.c:1199
>        blk_mq_dispatch_rq_list+0x422/0x1e70 block/blk-mq.c:2148
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x23c/0x670 block/blk-mq.c:2386
>        blk_mq_dispatch_list+0x51d/0x1360 block/blk-mq.c:2949
>        blk_mq_flush_plug_list block/blk-mq.c:2997 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2969
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1230
>        blk_finish_plug block/blk-core.c:1257 [inline]
>        __submit_bio+0x584/0x6c0 block/blk-core.c:649
>        __submit_bio_noacct_mq block/blk-core.c:722 [inline]
>        submit_bio_noacct_nocheck+0x562/0xc10 block/blk-core.c:753
>        submit_bio_noacct+0xd17/0x2010 block/blk-core.c:884
>        blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
>        submit_bh_wbc+0x59c/0x770 fs/buffer.c:2821
>        submit_bh fs/buffer.c:2826 [inline]
>        block_read_full_folio+0x264/0x8e0 fs/buffer.c:2444
>        filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2501
>        do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4101
>        read_mapping_folio include/linux/pagemap.h:1028 [inline]
>        read_part_sector+0xd1/0x370 block/partitions/core.c:723
>        adfspart_check_ICS+0x93/0x910 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:142 [inline]
>        blk_add_partitions block/partitions/core.c:590 [inline]
>        bdev_disk_changed+0x7f8/0xc80 block/partitions/core.c:694
>        blkdev_get_whole+0x187/0x290 block/bdev.c:764
>        bdev_open+0x2c7/0xe40 block/bdev.c:973
>        blkdev_open+0x34e/0x4f0 block/fops.c:697
>        do_dentry_open+0x6d8/0x1660 fs/open.c:949
>        vfs_open+0x82/0x3f0 fs/open.c:1081
>        do_open fs/namei.c:4671 [inline]
>        path_openat+0x208c/0x31a0 fs/namei.c:4830
>        do_file_open+0x20e/0x430 fs/namei.c:4859
>        do_sys_openat2+0x10d/0x1e0 fs/open.c:1366
>        do_sys_open fs/open.c:1372 [inline]
>        __do_sys_openat fs/open.c:1388 [inline]
>        __se_sys_openat fs/open.c:1383 [inline]
>        __x64_sys_openat+0x12d/0x210 fs/open.c:1383
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #4 (set->srcu){.+.+}-{0:0}:
>        srcu_lock_sync include/linux/srcu.h:199 [inline]
>        __synchronize_srcu+0xa1/0x2a0 kernel/rcu/srcutree.c:1505
>        blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
>        blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
>        blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
>        blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
>        elevator_switch+0x17b/0x7e0 block/elevator.c:576
>        elevator_change+0x352/0x530 block/elevator.c:681
>        elevator_set_default+0x29e/0x360 block/elevator.c:754
>        blk_register_queue+0x412/0x590 block/blk-sysfs.c:946
>        __add_disk+0x73f/0xe40 block/genhd.c:528
>        add_disk_fwnode+0x118/0x5c0 block/genhd.c:597
>        add_disk include/linux/blkdev.h:785 [inline]
>        nbd_dev_add+0x77a/0xb10 drivers/block/nbd.c:1984
>        nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
>        do_one_initcall+0x11d/0x760 init/main.c:1382
>        do_initcall_level init/main.c:1444 [inline]
>        do_initcalls init/main.c:1460 [inline]
>        do_basic_setup init/main.c:1479 [inline]
>        kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
>        kernel_init+0x1f/0x1e0 init/main.c:1582
>        ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #3 (&q->elevator_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:614 [inline]
>        __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
>        elevator_change+0x1bc/0x530 block/elevator.c:679
>        elevator_set_none+0x92/0xf0 block/elevator.c:769
>        blk_mq_elv_switch_none block/blk-mq.c:5110 [inline]
>        __blk_mq_update_nr_hw_queues block/blk-mq.c:5155 [inline]
>        blk_mq_update_nr_hw_queues+0x4c1/0x15f0 block/blk-mq.c:5220
>        nbd_start_device+0x1a6/0xbd0 drivers/block/nbd.c:1489
>        nbd_genl_connect+0xff2/0x1a40 drivers/block/nbd.c:2239
>        genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
>        genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
>        genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
>        netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>        netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>        netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1344
>        netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
>        sock_sendmsg_nosec net/socket.c:727 [inline]
>        __sock_sendmsg net/socket.c:742 [inline]
>        ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2592
>        ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
>        __sys_sendmsg+0x170/0x220 net/socket.c:2678
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
>        blk_alloc_queue+0x610/0x790 block/blk-core.c:461
>        blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4429
>        __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4476
>        nbd_dev_add+0x492/0xb10 drivers/block/nbd.c:1954
>        nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
>        do_one_initcall+0x11d/0x760 init/main.c:1382
>        do_initcall_level init/main.c:1444 [inline]
>        do_initcalls init/main.c:1460 [inline]
>        do_basic_setup init/main.c:1479 [inline]
>        kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
>        kernel_init+0x1f/0x1e0 init/main.c:1582
>        ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        __fs_reclaim_acquire mm/page_alloc.c:4348 [inline]
>        fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4362
>        might_alloc include/linux/sched/mm.h:317 [inline]
>        slab_pre_alloc_hook mm/slub.c:4489 [inline]
>        slab_alloc_node mm/slub.c:4843 [inline]
>        kmem_cache_alloc_node_noprof+0x53/0x6f0 mm/slub.c:4918
>        __alloc_skb+0x140/0x710 net/core/skbuff.c:702
>        alloc_skb include/linux/skbuff.h:1383 [inline]
>        __ip6_append_data+0x36c0/0x4dc0 net/ipv6/ip6_output.c:1669
>        ip6_append_data net/ipv6/ip6_output.c:1857 [inline]
>        ip6_append_data+0x10b/0x410 net/ipv6/ip6_output.c:1826
>        rawv6_sendmsg+0x169c/0x4420 net/ipv6/raw.c:912
>        inet_sendmsg+0x11c/0x140 net/ipv4/af_inet.c:865
>        sock_sendmsg_nosec net/socket.c:727 [inline]
>        __sock_sendmsg net/socket.c:742 [inline]
>        ____sys_sendmsg+0x98d/0xb70 net/socket.c:2592
>        ___sys_sendmsg+0x190/0x1e0 net/socket.c:2646
>        __sys_sendmsg+0x170/0x220 net/socket.c:2678
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (sk_lock-AF_INET6){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>        __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
>        lock_acquire kernel/locking/lockdep.c:5868 [inline]
>        lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3780
>        lock_sock include/net/sock.h:1709 [inline]
>        inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:919
>        nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:318
>        recv_work+0x5fb/0x8c0 drivers/block/nbd.c:1021
>        process_one_work+0xa23/0x19a0 kernel/workqueue.c:3276
>        process_scheduled_works kernel/workqueue.c:3359 [inline]
>        worker_thread+0x5ef/0xe50 kernel/workqueue.c:3440
>        kthread+0x370/0x450 kernel/kthread.c:436
>        ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   sk_lock-AF_INET6 --> &cmd->lock --> &nsock->tx_lock
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&nsock->tx_lock);
>                                lock(&cmd->lock);
>                                lock(&nsock->tx_lock);
>   lock(sk_lock-AF_INET6);
> 
>  *** DEADLOCK ***
