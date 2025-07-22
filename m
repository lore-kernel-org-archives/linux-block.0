Received: from mail3-166.sinamail.sina.com.cn (mail3-166.sinamail.sina.com.cn [202.108.3.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F32F50
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145545; cv=none; b=EKFDs86X/z1vOzSVDmZYDI0FFCeinKeLuhAbA1Hj/K/t6l1p8dzrQ64JHaPdk52w9DOubxJ3pTr1k57k+x2axMOSHlejLdDgIVCN4phVsyRThchFn+N7i9EQ2eyE7NBi3B3orfZnbOGjhI2gXLZoQDvwXgLicdlcKB10x28L2yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145545; c=relaxed/simple;
	bh=zXjGcuJnU9JGF/1tiV1wzBu2sdi6wr9OsfmrncB7wV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LncFupqVjrqAvpTTenlYuwp1B8rZginGeBlyNQB7ns+rhRhlADMfr+MbaJidHnY7Zmra/4GDZT5FG0X89upnCDZxa/6+zkoEVNJ/ud0e6ftU6tEjrUM9PAka9eU12yz80ZaEx46OatQmMh8OE/fJCzyX3Df8nCEW4vKxZ6xhAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=GGxH+UZq; arc=none smtp.client-ip=202.108.3.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="GGxH+UZq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1753145542;
	bh=r2tvnmOa4h6JguBmXfBuOulVau0NIXIhuN61gMlEo/I=;
	h=From:Subject:Date:Message-ID;
	b=GGxH+UZq+BGD7JXNGNlCSL9kaT3aWJEyaGcM5hKC/RBC/lE2w2I92kaezoVd7SYZf
	 wIWcJeF4QzxO9eDgMIc8WvGaSKS1ZVDnLNd3PCRh8S7h322GYonf9OBgID9bbFLxfl
	 Zq7blYv3QWhN3VMxwSJ7zaFmy7g0rGnxyVA1yq5E=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 687EE09700004EB8; Tue, 22 Jul 2025 08:51:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7394516816234
X-SMAIL-UIID: 9068449BC18C4F218C2DB4CA3487B46B-20250722-085137-1
From: Hillf Danton <hdanton@sina.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: thomas.hellstrom@linux.intel.com,
	axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	regressions@lists.linux.dev
Subject: Re: 6.15/regression/bisected - lockdep warning: circular locking dependency detected when plugging USB stick after ffa1e7ada456
Date: Tue, 22 Jul 2025 08:51:24 +0800
Message-ID: <20250722005125.2765-1-hdanton@sina.com>
In-Reply-To: <CABXGCsPgCBahYRtEZUZiAZtkX51gDE_XZQqK=apuhZ_fOK=Dkg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Jul 2025 02:54:46 +0500 Mikhail Gavrilov wrote:
> Hi Thomas,
> 
> After commit
> ffa1e7ada456 ("block: Make request_queue lockdep splats show up earlier"),
> I started seeing lockdep warnings about circular locking dependencies
> in the kernel log every time I plug in a USB flash drive.
> 
> The warning looks like this:
> [  247.453773] sd 6:0:0:0: [sda] Attached SCSI removable disk
> 
> [  247.486193] ======================================================
> [  247.486195] WARNING: possible circular locking dependency detected
> [  247.486197] 6.16.0-rc7 #36 Tainted: G             L
> [  247.486199] ------------------------------------------------------
> [  247.486200] (udev-worker)/4257 is trying to acquire lock:
> [  247.486202] ffff88816b9c0650 (&q->elevator_lock){+.+.}-{4:4}, at:
> elevator_change+0xb6/0x380
> [  247.486213]
>                but task is already holding lock:
> [  247.486214] ffff88816b9c00b0
> (&q->q_usage_counter(io)#6){++++}-{0:0}, at:
> blk_mq_freeze_queue_nomemsave+0x16/0x30
> [  247.486221]
>                which lock already depends on the new lock.
> 
> [  247.486222]
>                the existing dependency chain (in reverse order) is:
> [  247.486224]
>                -> #3 (&q->q_usage_counter(io)#6){++++}-{0:0}:
> [  247.486228]        __lock_acquire+0x56a/0xbe0
> [  247.486233]        lock_acquire.part.0+0xc8/0x270
> [  247.486235]        blk_alloc_queue+0x5cd/0x720
> [  247.486237]        blk_mq_alloc_queue+0x14d/0x260
> [  247.486239]        scsi_alloc_sdev+0x862/0xc90
> [  247.486242]        scsi_probe_and_add_lun+0x4be/0xc10
> [  247.486245]        __scsi_scan_target+0x18b/0x3b0
> [  247.486247]        scsi_scan_channel+0xee/0x180
> [  247.486250]        scsi_scan_host_selected+0x1fd/0x2c0
> [  247.486252]        do_scan_async+0x42/0x450
> [  247.486254]        async_run_entry_fn+0x94/0x540
> [  247.486258]        process_one_work+0x87a/0x14d0
> [  247.486260]        worker_thread+0x5f2/0xfd0
> [  247.486262]        kthread+0x3b0/0x770
> [  247.486266]        ret_from_fork+0x3ef/0x510
> [  247.486269]        ret_from_fork_asm+0x1a/0x30
> [  247.486271]
>                -> #2 (fs_reclaim){+.+.}-{0:0}:
> [  247.486275]        __lock_acquire+0x56a/0xbe0
> [  247.486277]        lock_acquire.part.0+0xc8/0x270
> [  247.486279]        fs_reclaim_acquire+0xd9/0x130
> [  247.486282]        prepare_alloc_pages+0x153/0x5a0
> [  247.486284]        __alloc_frozen_pages_noprof+0x142/0x490
> [  247.486286]        __alloc_pages_noprof+0x12/0x210
> [  247.486288]        pcpu_alloc_pages.isra.0+0xfa/0x4d0
> [  247.486291]        pcpu_populate_chunk+0x39/0x80
> [  247.486293]        pcpu_alloc_noprof+0x759/0xeb0
> [  247.486296]        iommu_dma_init_fq+0x19c/0x7c0
> [  247.486299]        iommu_dma_init_domain+0x53f/0x7f0
> [  247.486301]        iommu_setup_dma_ops+0xd3/0x200
> [  247.486303]        bus_iommu_probe+0x1f0/0x4b0
> [  247.486306]        iommu_device_register+0x186/0x280
> [  247.486308]        iommu_init_pci+0xc8c/0xd00
> [  247.486312]        amd_iommu_init_pci+0x83/0x4e0
> [  247.486314]        state_next+0x28f/0x5c0
> [  247.486317]        iommu_go_to_state+0x2b/0x60
> [  247.486319]        amd_iommu_init+0x21/0x60
> [  247.486321]        pci_iommu_init+0x38/0x60
> [  247.486325]        do_one_initcall+0xd2/0x450
> [  247.486327]        do_initcalls+0x216/0x240
> [  247.486330]        kernel_init_freeable+0x299/0x2d0
> [  247.486332]        kernel_init+0x1c/0x150
> [  247.486335]        ret_from_fork+0x3ef/0x510
> [  247.486337]        ret_from_fork_asm+0x1a/0x30
> [  247.486338]
>                -> #1 (pcpu_alloc_mutex){+.+.}-{4:4}:
> [  247.486342]        __lock_acquire+0x56a/0xbe0
> [  247.486344]        lock_acquire.part.0+0xc8/0x270
> [  247.486346]        __mutex_lock+0x1b2/0x1b70
> [  247.486348]        pcpu_alloc_noprof+0x884/0xeb0
> [  247.486351]        sbitmap_init_node+0x252/0x6a0
> [  247.486354]        sbitmap_queue_init_node+0x2d/0x420
> [  247.486356]        blk_mq_init_tags+0x154/0x2a0
> [  247.486359]        blk_mq_alloc_map_and_rqs+0xa6/0x310
> [  247.486361]        blk_mq_init_sched+0x2a4/0x580
> [  247.486363]        elevator_switch+0x18b/0x630
> [  247.486365]        elevator_change+0x209/0x380
> [  247.486368]        elevator_set_default+0x22d/0x2a0
> [  247.486370]        blk_register_queue+0x33a/0x490
> [  247.486372]        __add_disk+0x5fd/0xd50
> [  247.486374]        add_disk_fwnode+0x113/0x590
> [  247.486377]        sd_probe+0x873/0xe10
> [  247.486380]        really_probe+0x1de/0x890
> [  247.486383]        __driver_probe_device+0x18c/0x390
> [  247.486385]        driver_probe_device+0x4a/0x120
> [  247.486388]        __device_attach_driver+0x156/0x280
> [  247.486389]        bus_for_each_drv+0x111/0x1a0
> [  247.486392]        __device_attach_async_helper+0x19c/0x240
> [  247.486394]        async_run_entry_fn+0x94/0x540
> [  247.486396]        process_one_work+0x87a/0x14d0
> [  247.486398]        worker_thread+0x5f2/0xfd0
> [  247.486400]        kthread+0x3b0/0x770
> [  247.486402]        ret_from_fork+0x3ef/0x510
> [  247.486404]        ret_from_fork_asm+0x1a/0x30
> [  247.486406]
>                -> #0 (&q->elevator_lock){+.+.}-{4:4}:
> [  247.486409]        check_prev_add+0xe1/0xcf0
> [  247.486411]        validate_chain+0x4cf/0x740
> [  247.486413]        __lock_acquire+0x56a/0xbe0
> [  247.486414]        lock_acquire.part.0+0xc8/0x270
> [  247.486416]        __mutex_lock+0x1b2/0x1b70
> [  247.486418]        elevator_change+0xb6/0x380
> [  247.486420]        elv_iosched_store+0x24a/0x2c0
> [  247.486422]        queue_attr_store+0x238/0x340
> [  247.486425]        kernfs_fop_write_iter+0x39b/0x5a0
> [  247.486428]        vfs_write+0x524/0xe70
> [  247.486430]        ksys_write+0xff/0x200
> [  247.486432]        do_syscall_64+0x98/0x3c0
> [  247.486435]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  247.486438]
>                other info that might help us debug this:
> 
> [  247.486439] Chain exists of:
>                  &q->elevator_lock --> fs_reclaim --> &q->q_usage_counter(io)#6
> 
> [  247.486444]  Possible unsafe locking scenario:
> 
> [  247.486446]        CPU0                    CPU1
> [  247.486447]        ----                    ----
> [  247.486448]   lock(&q->q_usage_counter(io)#6);
> [  247.486451]                                lock(fs_reclaim);
> [  247.486453]                                lock(&q->q_usage_counter(io)#6);
> [  247.486456]   lock(&q->elevator_lock);
> [  247.486458]
>                 *** DEADLOCK ***

Try the diff that serializes elevator_change() with q->elevator_lock if
reproducer is available.

--- x/block/elevator.c
+++ y/block/elevator.c
@@ -661,6 +661,7 @@ static int elevator_change(struct reques
 	unsigned int memflags;
 	int ret = 0;
 
+	/* updaters should be serialized */
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
 
 	memflags = blk_mq_freeze_queue(q);
@@ -674,11 +675,11 @@ static int elevator_change(struct reques
 	 * Disk isn't added yet, so verifying queue lock only manually.
 	 */
 	blk_mq_cancel_work_sync(q);
+	blk_mq_unfreeze_queue(q, memflags);
 	mutex_lock(&q->elevator_lock);
 	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
 		ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
 
