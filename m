Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794683993;
	b=nOMrUvs+iKFAeBDC3cO9Ck7l6bFairIIJYlEz5MX4N657SkvkcT9ZmCCmbR8cOailqU3
	 7K5D6jlB/s9h6hbuNWHL1TK97Pnv6Z+/iV6yVAoM8b6k6Ev3WEOh2zq4YCrtcg6+fzkU8
	 cnmoJdCI+XTsvsQefMYCZ7tVHz0yH7Pidvz4oCMy9XykxDdbgsIJnHoA8qS0w7CIGQK0x
	 oe/egQ+7NkKS2bILTEORV1TD7A9E4UDVEUMZA1e2sbx97JvsNT7PGfiUaX9RRq6LsrT+8
	 ck6/w/xeXvCg1FB5SpAh8E3GwFWHTqTLy7NqnjONXw1VJg52uxH+ditDps4NYbJ9f2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794683993;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aYaqZceDx0d06R6TZyQPXqPoL39TW8YEc9CunNnda84=;
	b=EraGfyf2iLMktNmg/+gsoszhPIXGhhMurK8AUiocbxOGEpIl9j5mtjUJwxYAv0HpPqlr
	 sB1P+m+VE1Y3sbtGuo+xYJbKHHAyI97E3MuhUnUNs/bq3+OMLk8CIVjt3ssZGZ4zujWkD
	 P+ZBz14p3ztG1LdJUk7L2tQeJqoDKEuqffrjlicRe1vRft+nycrlhpJfYH6Gj+ydLvGch
	 InXnTkZHGKI+Kdc6q1SqbKtvu11W1E0FpE9TL249oGTkNmJr8Iu9gQXKy/H7AGHmNw+1X
	 4jF1vHjXeJ4a1erjbL34JVxtzDqfi3hTptSBYXdlX2lWr8vTsYOQMpn6besQJ4Hjsug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ovu38/2i";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE6606A329;
	Sat, 14 Nov 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ovu38/2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBE41F000C4;
	Sat, 14 Nov 2026 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794683992;
	bh=aYaqZceDx0d06R6TZyQPXqPoL39TW8YEc9CunNnda84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ovu38/2irAic1wC8D3hnyJaNPVBih/rjqfMQijEdReK/hl0sijpqTHij64OAkpuxC
	 qUvDg4Rr1o50TzMIZvvYrwKd66qRcM/Qkf8vYiY/SMmeg/fLssxAn77cLcIWZKlHlc
	 JutzY48ShA37FA5MDoFUvqyu/obhyNCm3G3ZuflIu+q1ohZhNhzeuspxgUOOpSEVkr
	 nsGQ7S/qdzp6j4QmgsvlPyaN0rX8IEGlN3uLTbz/cLVs5Zc8/twpFh0dgt+G7jLrjm
	 4uceXBZS6YL6UGaLpHw7j9FIehRZF0r6KS9TlkuITAEHTjGu+FW4vexxDyvuuT/4Ug
	 4UeHudMK7foEg==
Date: Sat, 14 Nov 2026 19:19:46 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: syzbot <syzbot+1cd3a506d57e74040004@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, jannh@google.com, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, pfalcato@suse.de, 
	syzkaller-bugs@googlegroups.com, vbabka@kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, nbd@other.debian.org
Subject: Re: [syzbot] [mm?] possible deadlock in dup_mmap
Message-ID: <avi0GPqrua8JereY@gremlin>
References: <6af85d8c.097d52ff.3d440.0008.GAE@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af85d8c.097d52ff.3d440.0008.GAE@google.com>

+cc block people + lists

On Sat, Nov 14, 2026 at 05:09:32AM -0800, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7e1392a42ea2 Merge tag 'net-7.4-rc3' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10de62c3580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e3d788a0111c0780
> dashboard link: https://syzkaller.appspot.com/bug?extid=1cd3a506d57e74040004
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/cab3108790d1/disk-7e1392a4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d2cfcac3b02d/vmlinux-7e1392a4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/0b6b5a126605/bzImage-7e1392a4.xz
>
> AI-generated root cause summary:
> The circular locking dependency is rooted in drivers/block/nbd.c, where the
> Network Block Device driver handles block I/O under direct memory reclaim
> (fs_reclaim) using a network socket provided by userspace. In
> nbd_reclassify_socket(), NBD silently fails to reclassify the socket's lockdep
> class when sock_allow_reclassification() returns false (e.g., if the socket is
> already in use by userspace), leaving it in the generic sk_lock-AF_INET6 class.
> Furthermore, because userspace retains the socket descriptor, concurrent user
> operations like sendmsg() acquire lock_sock before faulting on user buffers
> (which acquires mm->mmap_lock), while NBD I/O and shutdown paths (e.g.,
> nbd_mark_nsock_dead()) acquire lock_sock via kernel_sock_shutdown() under
> nsock->tx_lock in the fs_reclaim path. Because MM operations (such as
> fork/dup_mmap) take mm->mmap_lock and hugetlbfs_i_mmap_rwsem_key prior to
> GFP_KERNEL allocations (fs_reclaim), this establishes an inverted cycle:
> mm->mmap_lock -> hugetlbfs_i_mmap_rwsem_key -> fs_reclaim -> nsock->tx_lock ->
> sk_lock -> mm->mmap_lock.

Hmm, AI identifies the nbd block driver but then only mm people are cc'd :))

Hey Jens, Josef :P

>
> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=1cd3a506d57e74040004
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1cd3a506d57e74040004@syzkaller.appspotmail.com
>
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Tainted: G             L
> ------------------------------------------------------
> syz.9.7569/29103 is trying to acquire lock:
> ffff888052efb930 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: i_mmap_lock_write include/linux/fs.h:508 [inline]
> ffff888052efb930 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}, at: dup_mmap+0xb09/0x2180 mm/mmap.c:1802
>
> but task is already holding lock:
> ffff88807fe0e540 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:556 [inline]
> ffff88807fe0e540 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x16e/0x2180 mm/mmap.c:1722
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #9 (&mm->mmap_lock/1){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        down_write_nested+0x8f/0x1f0 kernel/locking/rwsem.c:1757
>        mmap_write_lock_nested include/linux/mmap_lock.h:556 [inline]
>        dup_mmap+0x16e/0x2180 mm/mmap.c:1722
>        dup_mm kernel/fork.c:1549 [inline]
>        copy_mm kernel/fork.c:1602 [inline]
>        copy_process+0x7c5c/0x88e0 kernel/fork.c:2328
>        kernel_clone+0x176/0x9d0 kernel/fork.c:2798
>        __do_sys_clone+0xd9/0x120 kernel/fork.c:2940
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #8 (&mm->mmap_lock){++++}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        __might_fault+0xde/0x140 mm/memory.c:7575
>        _inline_copy_from_user include/linux/uaccess.h:169 [inline]
>        _copy_from_user+0x29/0xd0 lib/usercopy.c:18
>        copy_from_user include/linux/uaccess.h:222 [inline]
>        csum_and_copy_from_user include/net/checksum.h:31 [inline]
>        copy_from_user_iter_csum net/core/skbuff.c:7677 [inline]
>        iterate_ubuf include/linux/iov_iter.h:30 [inline]
>        iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
>        csum_and_copy_from_iter_full+0x21a/0x1fe0 net/core/skbuff.c:7689
>        ip_generic_getfrag+0x172/0x270 net/ipv4/ip_output.c:949
>        raw6_getfrag+0x22c/0x290 net/ipv6/raw.c:743
>        __ip6_append_data+0x37f0/0x4b30 net/ipv6/ip6_output.c:1739
>        ip6_append_data net/ipv6/ip6_output.c:1894 [inline]
>        ip6_append_data+0x10b/0x410 net/ipv6/ip6_output.c:1863
>        rawv6_sendmsg+0x169c/0x4630 net/ipv6/raw.c:917
>        inet_sendmsg+0x11c/0x140 net/ipv4/af_inet.c:866
>        sock_sendmsg_nosec net/socket.c:800 [inline]
>        __sock_sendmsg net/socket.c:818 [inline]
>        ____sys_sendmsg+0x9a0/0xb90 net/socket.c:2713
>        ___sys_sendmsg+0x208/0x270 net/socket.c:2770
>        __sys_sendmsg+0x160/0x210 net/socket.c:2802
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #7 (sk_lock-AF_INET6){+.+.}-{0:0}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3906
>        lock_sock include/net/sock.h:1717 [inline]
>        inet_shutdown+0x67/0x410 net/ipv4/af_inet.c:913
>        nbd_mark_nsock_dead+0xae/0x5c0 drivers/block/nbd.c:319
>        sock_shutdown+0x16b/0x200 drivers/block/nbd.c:420
>        nbd_clear_sock drivers/block/nbd.c:1463 [inline]
>        nbd_config_put+0x3d5/0x9b0 drivers/block/nbd.c:1492
>        nbd_genl_connect+0xd72/0x1770 drivers/block/nbd.c:2319
>        genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
>        genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
>        genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
>        netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2585
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>        netlink_unicast_kernel net/netlink/af_netlink.c:1336 [inline]
>        netlink_unicast+0x668/0x950 net/netlink/af_netlink.c:1362
>        netlink_sendmsg+0x9ac/0x10c0 net/netlink/af_netlink.c:1921
>        sock_sendmsg_nosec net/socket.c:800 [inline]
>        __sock_sendmsg net/socket.c:818 [inline]
>        ____sys_sendmsg+0xa13/0xb90 net/socket.c:2713
>        ___sys_sendmsg+0x208/0x270 net/socket.c:2770
>        __sys_sendmsg+0x160/0x210 net/socket.c:2802
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #6 (&nsock->tx_lock){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        __mutex_lock_common kernel/locking/mutex.c:646 [inline]
>        __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
>        nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
>        nbd_queue_rq+0x42d/0xfa0 drivers/block/nbd.c:1207
>        blk_mq_dispatch_rq_list+0x428/0x1e60 block/blk-mq.c:2141
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
>        blk_mq_run_work_fn+0x130/0x380 block/blk-mq.c:2555
>        process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
>        process_scheduled_works kernel/workqueue.c:3578 [inline]
>        worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
>        kthread+0x373/0x450 kernel/kthread.c:436
>        ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> -> #5 (&cmd->lock){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        __mutex_lock_common kernel/locking/mutex.c:646 [inline]
>        __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
>        nbd_queue_rq+0xba/0xfa0 drivers/block/nbd.c:1199
>        blk_mq_dispatch_rq_list+0x428/0x1e60 block/blk-mq.c:2141
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcea/0x1620 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd7/0x1c0 block/blk-mq-sched.c:329
>        blk_mq_run_work_fn+0x130/0x380 block/blk-mq.c:2555
>        process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
>        process_scheduled_works kernel/workqueue.c:3578 [inline]
>        worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
>        kthread+0x373/0x450 kernel/kthread.c:436
>        ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> -> #4 (set->srcu){.+.+}-{0:0}:
>        lock_sync kernel/locking/lockdep.c:5991 [inline]
>        lock_sync+0xb5/0x120 kernel/locking/lockdep.c:5979
>        srcu_lock_sync include/linux/srcu.h:261 [inline]
>        __synchronize_srcu+0xa2/0x310 kernel/rcu/srcutree.c:1662
>        blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
>        blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
>        blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
>        blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
>        elevator_switch+0x17b/0x7e0 block/elevator.c:576
>        elevator_change+0x352/0x530 block/elevator.c:681
>        elevator_set_default+0x29e/0x360 block/elevator.c:754
>        blk_register_queue+0x49e/0x640 block/blk-sysfs.c:992
>        __add_disk+0x7dd/0xf10 block/genhd.c:531
>        add_disk_fwnode+0x118/0x480 block/genhd.c:600
>        add_disk include/linux/blkdev.h:799 [inline]
>        nbd_dev_add+0x779/0xb10 drivers/block/nbd.c:2026
>        nbd_init+0x2c5/0x2e0 drivers/block/nbd.c:2743
>        do_one_initcall+0x11c/0x6f0 init/main.c:1419
>        do_initcall_level init/main.c:1481 [inline]
>        do_initcalls init/main.c:1497 [inline]
>        do_basic_setup init/main.c:1517 [inline]
>        kernel_init_freeable+0x6ea/0x7b0 init/main.c:1732
>        kernel_init+0x21/0x1e0 init/main.c:1622
>        ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> -> #3 (&q->elevator_lock){+.+.}-{4:4}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        __mutex_lock_common kernel/locking/mutex.c:646 [inline]
>        __mutex_lock+0x19f/0x1c10 kernel/locking/mutex.c:821
>        elevator_change+0x1bc/0x530 block/elevator.c:679
>        elevator_set_none+0x92/0xf0 block/elevator.c:769
>        blk_mq_elv_switch_none block/blk-mq.c:5168 [inline]
>        __blk_mq_update_nr_hw_queues block/blk-mq.c:5213 [inline]
>        blk_mq_update_nr_hw_queues+0x4e1/0x1690 block/blk-mq.c:5281
>        nbd_start_device+0x1a6/0xbd0 drivers/block/nbd.c:1530
>        nbd_genl_connect+0xfc2/0x1770 drivers/block/nbd.c:2310
>        genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
>        genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
>        genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
>        netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2585
>        genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
>        netlink_unicast_kernel net/netlink/af_netlink.c:1336 [inline]
>        netlink_unicast+0x668/0x950 net/netlink/af_netlink.c:1362
>        netlink_sendmsg+0x9ac/0x10c0 net/netlink/af_netlink.c:1921
>        sock_sendmsg_nosec net/socket.c:800 [inline]
>        __sock_sendmsg net/socket.c:818 [inline]
>        ____sys_sendmsg+0xa13/0xb90 net/socket.c:2713
>        ___sys_sendmsg+0x208/0x270 net/socket.c:2770
>        __sys_sendmsg+0x160/0x210 net/socket.c:2802
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        blk_alloc_queue+0x610/0x790 block/blk-core.c:505
>        blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4468
>        __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4515
>        nbd_dev_add+0x491/0xb10 drivers/block/nbd.c:1996
>        nbd_init+0x2c5/0x2e0 drivers/block/nbd.c:2743
>        do_one_initcall+0x11c/0x6f0 init/main.c:1419
>        do_initcall_level init/main.c:1481 [inline]
>        do_initcalls init/main.c:1497 [inline]
>        do_basic_setup init/main.c:1517 [inline]
>        kernel_init_freeable+0x6ea/0x7b0 init/main.c:1732
>        kernel_init+0x21/0x1e0 init/main.c:1622
>        ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        __fs_reclaim_acquire mm/page_alloc.c:4375 [inline]
>        fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4389
>        might_alloc include/linux/sched/mm.h:316 [inline]
>        slab_pre_alloc_hook mm/slub.c:4673 [inline]
>        slab_alloc_node mm/slub.c:5011 [inline]
>        __kmalloc_cache_noprof+0x63/0x6d0 mm/slub.c:5676
>        _kmalloc_noprof include/linux/slab.h:991 [inline]
>        allocate_file_region_entries+0x1a0/0x630 mm/hugetlb.c:711
>        region_chg+0x85/0x140 mm/hugetlb.c:831
>        __vma_reservation_common+0x34b/0x6f0 mm/hugetlb.c:2495
>        vma_needs_reservation mm/hugetlb.c:2562 [inline]
>        hugetlb_unmap_range+0x10be/0x1710 mm/hugetlb.c:5415
>        __unmap_hugepage_range+0x186/0x2f0 mm/hugetlb.c:5445
>        __zap_vma_range+0x3870/0x46c0 mm/memory.c:2195
>        unmap_vmas+0x294/0x5f0 mm/memory.c:2275
>        exit_mmap+0x1ef/0xa40 mm/mmap.c:1315
>        __mmput+0x12a/0x410 kernel/fork.c:1192
>        mmput+0x62/0x70 kernel/fork.c:1215
>        exit_mm kernel/exit.c:586 [inline]
>        do_exit+0x80c/0x2a00 kernel/exit.c:967
>        do_group_exit+0xd5/0x2a0 kernel/exit.c:1123
>        get_signal+0x1f58/0x22e0 kernel/signal.c:3113
>        arch_do_signal_or_restart+0x91/0x7e0 arch/x86/kernel/signal.c:337
>        __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
>        exit_to_user_mode_loop+0x139/0x700 kernel/entry/common.c:101
>        __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
>        syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
>        syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
>        do_syscall_64+0x661/0x7b0 arch/x86/entry/syscall_64.c:107
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> -> #0 (&hugetlbfs_i_mmap_rwsem_key){+.+.}-{4:4}:
>        check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
>        check_prevs_add kernel/locking/lockdep.c:3328 [inline]
>        validate_chain kernel/locking/lockdep.c:3952 [inline]
>        __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
>        lock_acquire kernel/locking/lockdep.c:5942 [inline]
>        lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>        down_write+0x86/0x1f0 kernel/locking/rwsem.c:1631
>        i_mmap_lock_write include/linux/fs.h:508 [inline]
>        dup_mmap+0xb09/0x2180 mm/mmap.c:1802
>        dup_mm kernel/fork.c:1549 [inline]
>        copy_mm kernel/fork.c:1602 [inline]
>        copy_process+0x7c5c/0x88e0 kernel/fork.c:2328
>        kernel_clone+0x176/0x9d0 kernel/fork.c:2798
>        __do_sys_clone+0xd9/0x120 kernel/fork.c:2940
>        do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>        do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> other info that might help us debug this:
>
> Chain exists of:
>   &hugetlbfs_i_mmap_rwsem_key --> &mm->mmap_lock --> &mm->mmap_lock/1
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&mm->mmap_lock/1);
>                                lock(&mm->mmap_lock);
>                                lock(&mm->mmap_lock/1);
>   lock(&hugetlbfs_i_mmap_rwsem_key);
>
>  *** DEADLOCK ***
>
> locks held by syz.9.7569/29103: 3, on CPU#1:
>  #0: ffffffff9014abf0 (dup_mmap_sem){++++}-{0:0}, at: dup_mm kernel/fork.c:1536 [inline]
>  #0: ffffffff9014abf0 (dup_mmap_sem){++++}-{0:0}, at: copy_mm kernel/fork.c:1602 [inline]
>  #0: ffffffff9014abf0 (dup_mmap_sem){++++}-{0:0}, at: copy_process+0x7b73/0x88e0 kernel/fork.c:2328
>  #1: ffff88807fe0ccc0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:566 [inline]
>  #1: ffff88807fe0ccc0 (&mm->mmap_lock){++++}-{4:4}, at: dup_mm kernel/fork.c:1537 [inline]
>  #1: ffff88807fe0ccc0 (&mm->mmap_lock){++++}-{4:4}, at: copy_mm kernel/fork.c:1602 [inline]
>  #1: ffff88807fe0ccc0 (&mm->mmap_lock){++++}-{4:4}, at: copy_process+0x7b99/0x88e0 kernel/fork.c:2328
>  #2: ffff88807fe0e540 (&mm->mmap_lock/1){+.+.}-{4:4}, at: mmap_write_lock_nested include/linux/mmap_lock.h:556 [inline]
>  #2: ffff88807fe0e540 (&mm->mmap_lock/1){+.+.}-{4:4}, at: dup_mmap+0x16e/0x2180 mm/mmap.c:1722
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 29103 Comm: syz.9.7569 Tainted: G             L      syzkaller #0 PREEMPT(full)
> Tainted: [L]=SOFTLOCKUP
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
>  check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
>  check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
>  check_prevs_add kernel/locking/lockdep.c:3328 [inline]
>  validate_chain kernel/locking/lockdep.c:3952 [inline]
>  __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
>  lock_acquire kernel/locking/lockdep.c:5942 [inline]
>  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
>  down_write+0x86/0x1f0 kernel/locking/rwsem.c:1631
>  i_mmap_lock_write include/linux/fs.h:508 [inline]
>  dup_mmap+0xb09/0x2180 mm/mmap.c:1802
>  dup_mm kernel/fork.c:1549 [inline]
>  copy_mm kernel/fork.c:1602 [inline]
>  copy_process+0x7c5c/0x88e0 kernel/fork.c:2328
>  kernel_clone+0x176/0x9d0 kernel/fork.c:2798
>  __do_sys_clone+0xd9/0x120 kernel/fork.c:2940
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x123/0x7b0 arch/x86/entry/syscall_64.c:89
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f421cfa94d9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f421de4afd8 EFLAGS: 00000206 ORIG_RAX: 0000000000000038
> RAX: ffffffffffffffda RBX: 00007f421d225fa0 RCX: 00007f421cfa94d9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000002820000
> RBP: 00007f421d03804e R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 00007f421d226038 R14: 00007f421d225fa0 R15: 00007ffe923e2998
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

--
Cheers, Lorenzo
