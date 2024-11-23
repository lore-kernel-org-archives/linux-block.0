Received: from smtp134-33.sina.com.cn (smtp134-33.sina.com.cn [180.149.134.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367D1AB52D
	for <linux-block@vger.kernel.org>; Sun, 24 Nov 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732406430; cv=none; b=cVw6oKBduyw3A3qR7PEfcFeUbWupZHv6MN5ZxzRl2yk2gkkqcF8ZMyqXni+F1moLMe2o1pveT9efFQysVe2N5qX2YU4CdJla9I4x1LVNylldE7n9XyXRjH9Y23FlwqmhZmwd7n2XIN14rfTrml14wMEc4SDer58Vuivi4n5zhVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732406430; c=relaxed/simple;
	bh=VrhYO+11xxcyw/RpgOGX0ADgYrecW3+uIwfMgBm8FIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAWiHOr2hfDSjskSt5KMi5tFV8OMAT4hj7QRF9cSbIpI6hop7LLsWz17Ud4nDeqQYAteNP4DGKI31K3gLjKGCU4ijw2yhFkKRX5tBT8Q+McPvfbDSjq/VmAUsRtR0Ki0zCUPzqwp70NeXLvbt3LgEDpvVS3mVAl/xyH4ZoIc/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.183])
	by sina.com (10.185.250.21) with ESMTP
	id 67426C8800004506; Sun, 24 Nov 2024 08:00:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4120793408439
X-SMAIL-UIID: 9B7DC2014CAE44C4AFDB5D715206D302-20241124-080013-1
From: Hillf Danton <hdanton@sina.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: syzbot <syzbot+5218c85078236fc46227@syzkaller.appspotmail.com>,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] possible deadlock in blk_mq_submit_bio
Date: Sun, 24 Nov 2024 07:59:58 +0800
Message-Id: <20241123235958.1489-1-hdanton@sina.com>
In-Reply-To: <6741f6b2.050a0220.1cc393.0017.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 23 Nov 2024 07:37:22 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    06afb0f36106 Merge tag 'trace-v6.13' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=148bfec0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b011a14ee4cb9480
> dashboard link: https://syzkaller.appspot.com/bug?extid=5218c85078236fc46227
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-06afb0f3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/aae0561fd279/vmlinux-06afb0f3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/faa3af3fa7ce/bzImage-06afb0f3.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+5218c85078236fc46227@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.12.0-syzkaller-07834-g06afb0f36106 #0 Not tainted
> ------------------------------------------------------
> kswapd0/112 is trying to acquire lock:
> ffff88801f3f1438 (&q->q_usage_counter(io)#68){++++}-{0:0}, at: bio_queue_enter block/blk.h:79 [inline]
> ffff88801f3f1438 (&q->q_usage_counter(io)#68){++++}-{0:0}, at: blk_mq_submit_bio+0x7ca/0x24c0 block/blk-mq.c:3092
> 
> but task is already holding lock:
> ffffffff8df4de60 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0xcd9/0x18f0 mm/vmscan.c:6976
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
>        fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:3865
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4036 [inline]
>        slab_alloc_node mm/slub.c:4114 [inline]
>        __do_kmalloc_node mm/slub.c:4263 [inline]
>        __kmalloc_node_noprof+0xb7/0x440 mm/slub.c:4270
>        __kvmalloc_node_noprof+0xad/0x1a0 mm/util.c:658
>        sbitmap_init_node+0x1ca/0x770 lib/sbitmap.c:132
>        scsi_realloc_sdev_budget_map+0x2c7/0x610 drivers/scsi/scsi_scan.c:246
>        scsi_add_lun+0x11b4/0x1fd0 drivers/scsi/scsi_scan.c:1106
>        scsi_probe_and_add_lun+0x4fa/0xda0 drivers/scsi/scsi_scan.c:1287
>        __scsi_add_device+0x24b/0x290 drivers/scsi/scsi_scan.c:1622
>        ata_scsi_scan_host+0x215/0x780 drivers/ata/libata-scsi.c:4575
>        async_run_entry_fn+0x9c/0x530 kernel/async.c:129
>        process_one_work+0x958/0x1b30 kernel/workqueue.c:3229
>        process_scheduled_works kernel/workqueue.c:3310 [inline]
>        worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
>        kthread+0x2c1/0x3a0 kernel/kthread.c:389
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> -> #0 (&q->q_usage_counter(io)#68){++++}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain kernel/locking/lockdep.c:3904 [inline]
>        __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5226
>        lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
>        __bio_queue_enter+0x4c6/0x740 block/blk-core.c:361
>        bio_queue_enter block/blk.h:79 [inline]

Another splat in bio_queue_enter() [1]

[1] https://lore.kernel.org/lkml/20241104112732.3144-1-hdanton@sina.com/

>        blk_mq_submit_bio+0x7ca/0x24c0 block/blk-mq.c:3092
>        __submit_bio+0x384/0x540 block/blk-core.c:629
>        __submit_bio_noacct_mq block/blk-core.c:710 [inline]
>        submit_bio_noacct_nocheck+0x698/0xd70 block/blk-core.c:739
>        submit_bio_noacct+0x93a/0x1e20 block/blk-core.c:868
>        swap_writepage_bdev_async mm/page_io.c:449 [inline]
>        __swap_writepage+0x3a3/0xf50 mm/page_io.c:472
>        swap_writepage+0x403/0x1040 mm/page_io.c:288
>        pageout+0x3b2/0xaa0 mm/vmscan.c:689
>        shrink_folio_list+0x3025/0x42d0 mm/vmscan.c:1367
>        evict_folios+0x6d6/0x1970 mm/vmscan.c:4589
>        try_to_shrink_lruvec+0x612/0x9b0 mm/vmscan.c:4784
>        shrink_one+0x3e3/0x7b0 mm/vmscan.c:4822
>        shrink_many mm/vmscan.c:4885 [inline]
>        lru_gen_shrink_node mm/vmscan.c:4963 [inline]
>        shrink_node+0xbbc/0x3ed0 mm/vmscan.c:5943
>        kswapd_shrink_node mm/vmscan.c:6771 [inline]
>        balance_pgdat+0xc1f/0x18f0 mm/vmscan.c:6963
>        kswapd+0x5f8/0xc30 mm/vmscan.c:7232
>        kthread+0x2c1/0x3a0 kernel/kthread.c:389
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(&q->q_usage_counter(io)#68);
>                                lock(fs_reclaim);
>   rlock(&q->q_usage_counter(io)#68);
> 
>  *** DEADLOCK ***
