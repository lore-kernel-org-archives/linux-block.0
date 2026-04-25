Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8631FFC48
	for <linux-block@vger.kernel.org>; Sat, 25 Apr 2026 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777083166; cv=none; b=mhcHJg/VgnKt81ulHmq3Ae4x4oY6iTC6PukDZ/ULTD6jlIBd6GfImfjV8STroxQNhJggkxQFJiTa+b80QvIwYPuaWZXgGVFt2+ir4ea8JfBgoanq3i6Cfy8ajxLMgtYKPfJj5hKQQaJW4UUD1J72OAbHYGPye7GDJf9XBSmir7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777083166; c=relaxed/simple;
	bh=cSVFK32125zLIa9+xZ5XFWbB/gFy2DTY3wG/K2eIuQg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FpTqPNxt16cenjwq10w3SXKgLp+3uDxQpmtrGFoSukfDeuSKKSqij8b2bzBXRPHecfC4R9NnKvPELs0ip9SkSiX5QRoWlBJVr9tfZL0SjLUiPoRqhoMKCfmeHHU2BqK9CLhz4vEBU0RstUmdNhc+t8RWtO2F1JDOZnDhsBtcYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6948df7c598so13596953eaf.1
        for <linux-block@vger.kernel.org>; Fri, 24 Apr 2026 19:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777083163; x=1777687963;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZB4BZOU7furfeT2KE85DNOaOObbgNs0fZjr2ghrS+qQ=;
        b=ByxPCcblpL2BS62S6FJ0hZ2TcUldKmM8y7/6pGy914Jnv3neenpr6dNqrE30+afWjA
         DRiLgLPMdwYcsxV7ZgTbWSR4i0yXOtyqD9ppgI5MjI9ycedvXoxF8JKl0Ti2HUQxwyhG
         2qiqYXkc4MpIkGtpR6GElyv1OxTl6dXNwdS6v+Hw2mlYUOUO4BK/LQIyGbH6QBT52r8F
         3mFZBeF19egfilF8xclUlkhPyNsqRxnPoisfV5U1NR9rcBxKvIG1cV99Dqj3GD/t1ujd
         P+zhjQAW/d4DsPBsh4mVX8ho3S1KQwGwq7v5p/+pMK/dkGwmJzdGeeXpWNGRok3UWKwK
         DWBw==
X-Forwarded-Encrypted: i=1; AFNElJ8lnY8OmWm2g9iZZH2A/BqdQ/yUHMDVjmPK2OEPK2s4sxsynx07YPELlTNLuo4X47kJkTmgUz4sRGivPA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jNbBt/qwdKiNaeubF8wnTAsbd//5GFq0hjQ2kMqusWwVNQom
	1mQwYT0xJzBI1HZOVwRu0aNjP0RuxAkGKT2om/C6l4gt6TfLI0IxAT45rXoF4MU9RwFhI7QYrik
	iZ1UD7bPUJ+he4FtsRnOJ+jY0tSNOtLoW3EFbaIagmsj/VgucH0a3BI1QJk4=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:288a:b0:694:8bbf:e51b with SMTP id
 006d021491bc7-6948bbfee00mr8787706eaf.36.1777083163073; Fri, 24 Apr 2026
 19:12:43 -0700 (PDT)
Date: Fri, 24 Apr 2026 19:12:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ec231b.a00a0220.7773.000d.GAE@google.com>
Subject: [syzbot] [block?] possible deadlock in bioset_exit
From: syzbot <syzbot+02b4e6eb8b1460d955a5@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dd6c438c3e64 Merge tag 'vfs-7.1-rc1.fixes' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14efc2ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d74203cd0463a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=02b4e6eb8b1460d955a5
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8bebdd77187b/disk-dd6c438c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2527d5942bbb/vmlinux-dd6c438c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d446b541e2e0/bzImage-dd6c438c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02b4e6eb8b1460d955a5@syzkaller.appspotmail.com

ubi31: attaching mtd0
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.7.5359/28440 is trying to acquire lock:
ffffffff8e9b1780 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:317 [inline]
ffffffff8e9b1780 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slub.c:4520 [inline]
ffffffff8e9b1780 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:4875 [inline]
ffffffff8e9b1780 (fs_reclaim){+.+.}-{0:0}, at: kmem_cache_alloc_noprof+0x4c/0x6e0 mm/slub.c:4905

but task is already holding lock:
ffffffff8e97f100 (slab_mutex){+.+.}-{4:4}, at: __kmem_cache_create_args+0x44/0x420 mm/slab_common.c:350

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #7 (slab_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:632 [inline]
       __mutex_lock+0x1a4/0x1b10 kernel/locking/mutex.c:806
       kmem_cache_destroy mm/slab_common.c:557 [inline]
       kmem_cache_destroy+0x59/0x180 mm/slab_common.c:527
       bio_put_slab block/bio.c:163 [inline]
       bioset_exit+0x3b1/0x520 block/bio.c:1907
       mddev_destroy drivers/md/md.c:819 [inline]
       mddev_free drivers/md/md.c:911 [inline]
       md_free_disk+0x18e/0x210 drivers/md/md.c:8578
       disk_release+0x2b2/0x430 block/genhd.c:1311
       device_release+0xd2/0x270 drivers/base/core.c:2566
       kobject_cleanup lib/kobject.c:689 [inline]
       kobject_release lib/kobject.c:720 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x1f7/0x640 lib/kobject.c:737
       process_one_work+0xa0e/0x1980 kernel/workqueue.c:3302
       process_scheduled_works kernel/workqueue.c:3385 [inline]
       worker_thread+0x5ef/0xe50 kernel/workqueue.c:3466
       kthread+0x370/0x450 kernel/kthread.c:436
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #6 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read include/linux/percpu-rwsem.h:77 [inline]
       cpus_read_lock+0x42/0x170 kernel/cpu.c:490
       static_key_slow_inc+0x12/0x30 kernel/jump_label.c:190
       nbd_reconnect_socket drivers/block/nbd.c:1342 [inline]
       nbd_genl_reconfigure+0xd82/0x1a00 drivers/block/nbd.c:2431
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
       __sys_sendmsg+0x170/0x220 net/socket.c:2784
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:632 [inline]
       __mutex_lock+0x1a4/0x1b10 kernel/locking/mutex.c:806
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
       submit_bio_noacct_nocheck+0x543/0xbf0 block/blk-core.c:753
       submit_bio_noacct+0xd18/0x2000 block/blk-core.c:884
       blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
       submit_bh_wbc+0x681/0x890 fs/buffer.c:2737
       submit_bh fs/buffer.c:2742 [inline]
       block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2358
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xd1/0x370 block/partitions/core.c:724
       adfspart_check_ICS+0x91/0x7d0 block/partitions/acorn.c:356
       check_partition block/partitions/core.c:143 [inline]
       blk_add_partitions block/partitions/core.c:591 [inline]
       bdev_disk_changed+0x7a3/0x1250 block/partitions/core.c:695
       blkdev_get_whole+0x187/0x290 block/bdev.c:756
       bdev_open+0x2c7/0xe40 block/bdev.c:965
       blkdev_open+0x34e/0x4f0 block/fops.c:697
       do_dentry_open+0x6d8/0x1660 fs/open.c:947
       vfs_open+0x82/0x3f0 fs/open.c:1079
       do_open fs/namei.c:4699 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4858
       do_file_open+0x20e/0x430 fs/namei.c:4887
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1364
       do_sys_open fs/open.c:1370 [inline]
       __do_sys_openat fs/open.c:1386 [inline]
       __se_sys_openat fs/open.c:1381 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1381
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:632 [inline]
       __mutex_lock+0x1a4/0x1b10 kernel/locking/mutex.c:806
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
       submit_bio_noacct_nocheck+0x543/0xbf0 block/blk-core.c:753
       submit_bio_noacct+0xd18/0x2000 block/blk-core.c:884
       blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
       submit_bh_wbc+0x681/0x890 fs/buffer.c:2737
       submit_bh fs/buffer.c:2742 [inline]
       block_read_full_folio+0x4c8/0x8e0 fs/buffer.c:2358
       filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xd1/0x370 block/partitions/core.c:724
       adfspart_check_ICS+0x91/0x7d0 block/partitions/acorn.c:356
       check_partition block/partitions/core.c:143 [inline]
       blk_add_partitions block/partitions/core.c:591 [inline]
       bdev_disk_changed+0x7a3/0x1250 block/partitions/core.c:695
       blkdev_get_whole+0x187/0x290 block/bdev.c:756
       bdev_open+0x2c7/0xe40 block/bdev.c:965
       blkdev_open+0x34e/0x4f0 block/fops.c:697
       do_dentry_open+0x6d8/0x1660 fs/open.c:947
       vfs_open+0x82/0x3f0 fs/open.c:1079
       do_open fs/namei.c:4699 [inline]
       path_openat+0x208c/0x31a0 fs/namei.c:4858
       do_file_open+0x20e/0x430 fs/namei.c:4887
       do_sys_openat2+0x10d/0x1e0 fs/open.c:1364
       do_sys_open fs/open.c:1370 [inline]
       __do_sys_openat fs/open.c:1386 [inline]
       __se_sys_openat fs/open.c:1381 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1381
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xa2/0x300 kernel/rcu/srcutree.c:1481
       blk_mq_wait_quiesce_done block/blk-mq.c:284 [inline]
       blk_mq_wait_quiesce_done block/blk-mq.c:281 [inline]
       blk_mq_quiesce_queue block/blk-mq.c:304 [inline]
       blk_mq_quiesce_queue+0x149/0x1c0 block/blk-mq.c:299
       elevator_switch+0x17b/0x7e0 block/elevator.c:576
       elevator_change+0x352/0x530 block/elevator.c:681
       elevator_set_default+0x29e/0x360 block/elevator.c:754
       blk_register_queue+0x48e/0x630 block/blk-sysfs.c:987
       __add_disk+0x73f/0xe40 block/genhd.c:528
       add_disk_fwnode+0x118/0x5c0 block/genhd.c:597
       add_disk include/linux/blkdev.h:794 [inline]
       nbd_dev_add+0x77a/0xb10 drivers/block/nbd.c:1984
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
       do_one_initcall+0x121/0x750 init/main.c:1392
       do_initcall_level init/main.c:1454 [inline]
       do_initcalls init/main.c:1470 [inline]
       do_basic_setup init/main.c:1490 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1703
       kernel_init+0x1f/0x1e0 init/main.c:1593
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:632 [inline]
       __mutex_lock+0x1a4/0x1b10 kernel/locking/mutex.c:806
       elevator_change+0x1bc/0x530 block/elevator.c:679
       elevator_set_none+0x92/0xf0 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5131 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5176 [inline]
       blk_mq_update_nr_hw_queues+0x4c1/0x15f0 block/blk-mq.c:5241
       nbd_start_device+0x1a6/0xbd0 drivers/block/nbd.c:1489
       nbd_genl_connect+0xff2/0x1a40 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
       __sys_sendmsg+0x170/0x220 net/socket.c:2784
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#50){++++}-{0:0}:
       blk_alloc_queue+0x610/0x790 block/blk-core.c:461
       blk_mq_alloc_queue+0x174/0x290 block/blk-mq.c:4450
       __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4497
       nbd_dev_add+0x492/0xb10 drivers/block/nbd.c:1954
       nbd_init+0x291/0x2b0 drivers/block/nbd.c:2692
       do_one_initcall+0x121/0x750 init/main.c:1392
       do_initcall_level init/main.c:1454 [inline]
       do_initcalls init/main.c:1470 [inline]
       do_basic_setup init/main.c:1490 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1703
       kernel_init+0x1f/0x1e0 init/main.c:1593
       ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #0 (fs_reclaim){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b1/0x370 kernel/locking/lockdep.c:5825
       __fs_reclaim_acquire mm/page_alloc.c:4325 [inline]
       fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4339
       might_alloc include/linux/sched/mm.h:317 [inline]
       slab_pre_alloc_hook mm/slub.c:4520 [inline]
       slab_alloc_node mm/slub.c:4875 [inline]
       kmem_cache_alloc_noprof+0x4c/0x6e0 mm/slub.c:4905
       create_cache mm/slab_common.c:249 [inline]
       __kmem_cache_create_args+0x366/0x420 mm/slab_common.c:380
       __kmem_cache_create include/linux/slab.h:390 [inline]
       alloc_ai drivers/mtd/ubi/attach.c:1464 [inline]
       ubi_attach+0x32a/0x4d30 drivers/mtd/ubi/attach.c:1560
       ubi_attach_mtd_dev+0x139f/0x32a0 drivers/mtd/ubi/build.c:1004
       ctrl_cdev_ioctl+0x36a/0x400 drivers/mtd/ubi/cdev.c:1113
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  fs_reclaim --> cpu_hotplug_lock --> slab_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(slab_mutex);
                               lock(cpu_hotplug_lock);
                               lock(slab_mutex);
  lock(fs_reclaim);

 *** DEADLOCK ***

2 locks held by syz.7.5359/28440:
 #0: ffffffff8f930b20 (ubi_devices_mutex){+.+.}-{4:4}, at: ctrl_cdev_ioctl+0x323/0x400 drivers/mtd/ubi/cdev.c:1112
 #1: ffffffff8e97f100 (slab_mutex){+.+.}-{4:4}, at: __kmem_cache_create_args+0x44/0x420 mm/slab_common.c:350

stack backtrace:
CPU: 1 UID: 0 PID: 28440 Comm: syz.7.5359 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b1/0x370 kernel/locking/lockdep.c:5825
 __fs_reclaim_acquire mm/page_alloc.c:4325 [inline]
 fs_reclaim_acquire+0xc4/0x100 mm/page_alloc.c:4339
 might_alloc include/linux/sched/mm.h:317 [inline]
 slab_pre_alloc_hook mm/slub.c:4520 [inline]
 slab_alloc_node mm/slub.c:4875 [inline]
 kmem_cache_alloc_noprof+0x4c/0x6e0 mm/slub.c:4905
 create_cache mm/slab_common.c:249 [inline]
 __kmem_cache_create_args+0x366/0x420 mm/slab_common.c:380
 __kmem_cache_create include/linux/slab.h:390 [inline]
 alloc_ai drivers/mtd/ubi/attach.c:1464 [inline]
 ubi_attach+0x32a/0x4d30 drivers/mtd/ubi/attach.c:1560
 ubi_attach_mtd_dev+0x139f/0x32a0 drivers/mtd/ubi/build.c:1004
 ctrl_cdev_ioctl+0x36a/0x400 drivers/mtd/ubi/cdev.c:1113
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5ceb79cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5cec650028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5ceba16270 RCX: 00007f5ceb79cdd9
RDX: 0000200000000440 RSI: 0000000040186f40 RDI: 0000000000000008
RBP: 00007f5ceb832d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5ceba16308 R14: 00007f5ceba16270 R15: 00007ffca1349ce8
 </TASK>
ubi31: scanning is finished
ubi31: empty MTD device detected
ubi31 error: ubi_attach_mtd_dev: cannot spawn "ubi_bgt31d", error -4


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
