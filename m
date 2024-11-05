Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA1418132A
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791165; cv=none; b=GA/r0OxyKWwwzVgWsI3QscLG6w/+aVcvECTPAowDBaMcpt+wFaRuQAA0AMn+/hsDt2a0u9hraKaTdMiHxApfUMUYnQJxl0K6OIZki70BePIvSezRwgK3LQytKWzEN+iktMxQkL60zoKzsmTfBwyGfKRBrEd0J1Svgpt1q//kmy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791165; c=relaxed/simple;
	bh=bhn8OTomeBsmL0L26tpV/x/su4y8blqg0hQmaBVC6ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta9CQ2DeP9faOEQF/DT/fkP45cfCcB09ldSM+v+m+z5pFussZkyN188+LH2T91VYCHnZOQoZ/+Jjc3lNBq18AoMyEqYja3fxHbChC05r03Ys8ax9Jx0J2kRqWXKh5b/o8sObqi/KqCRjNyQl/HlCUt/4Hm74iRStFvRccxbxKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaMW485Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaMW485Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6Roq3cOWZ+UaHWIVrLDBoW9cLCBCv3Kx4GzqB1c1O1g=;
	b=UaMW485YFWBcisNfNWTRnv5cL6Dr5ope7lfxxuCNNQmBwslgeLw4yw0ObJrIenDzcZChli
	u8IZwcRSpdH0WL+fBY+CgVX7J2JmPx8pPDz/UQlbIvS+HTHXeqn5sIeqPW6GQdHkQdaCx1
	qy5MXSRYQmv5WvT1oCV5qTV3M28aJYk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-kPLQj2PePw2b4viNBoIVvA-1; Tue,
 05 Nov 2024 02:19:09 -0500
X-MC-Unique: kPLQj2PePw2b4viNBoIVvA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4717A1955DCF;
	Tue,  5 Nov 2024 07:19:06 +0000 (UTC)
Received: from fedora (unknown [10.72.116.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30B7019560A2;
	Tue,  5 Nov 2024 07:18:59 +0000 (UTC)
Date: Tue, 5 Nov 2024 15:18:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
Message-ID: <ZynG3g8o_iLOjwai@fedora>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
> atomic mode after del_gendisk"), hence for disk like scsi, following
> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
> cause following uaf that is found by our syzkaller for v6.6:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in blk_mq_find_and_get_req+0x16e/0x1a0 block/blk-mq-tag.c:261
> Read of size 4 at addr ffff88811c969c20 by task kworker/1:2H/224909
> 
> CPU: 1 PID: 224909 Comm: kworker/1:2H Not tainted 6.6.0-ga836a5060850 #32
> Workqueue: kblockd blk_mq_timeout_work
> Call Trace:
> 
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x91/0xf0 lib/dump_stack.c:106
> print_address_description.constprop.0+0x66/0x300 mm/kasan/report.c:364
> print_report+0x3e/0x70 mm/kasan/report.c:475
> kasan_report+0xb8/0xf0 mm/kasan/report.c:588
> blk_mq_find_and_get_req+0x16e/0x1a0 block/blk-mq-tag.c:261
> bt_iter block/blk-mq-tag.c:288 [inline]
> __sbitmap_for_each_set include/linux/sbitmap.h:295 [inline]
> sbitmap_for_each_set include/linux/sbitmap.h:316 [inline]
> bt_for_each+0x455/0x790 block/blk-mq-tag.c:325
> blk_mq_queue_tag_busy_iter+0x320/0x740 block/blk-mq-tag.c:534
> blk_mq_timeout_work+0x1a3/0x7b0 block/blk-mq.c:1673
> process_one_work+0x7c4/0x1450 kernel/workqueue.c:2631
> process_scheduled_works kernel/workqueue.c:2704 [inline]
> worker_thread+0x804/0xe40 kernel/workqueue.c:2785
> kthread+0x346/0x450 kernel/kthread.c:388
> ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:293
> 
> Allocated by task 942:
> kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> ____kasan_kmalloc mm/kasan/common.c:374 [inline]
> __kasan_kmalloc mm/kasan/common.c:383 [inline]
> __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:380
> kasan_kmalloc include/linux/kasan.h:198 [inline]
> __do_kmalloc_node mm/slab_common.c:1007 [inline]
> __kmalloc_node+0x69/0x170 mm/slab_common.c:1014
> kmalloc_node include/linux/slab.h:620 [inline]
> kzalloc_node include/linux/slab.h:732 [inline]
> blk_alloc_flush_queue+0x144/0x2f0 block/blk-flush.c:499
> blk_mq_alloc_hctx+0x601/0x940 block/blk-mq.c:3788
> blk_mq_alloc_and_init_hctx+0x27f/0x330 block/blk-mq.c:4261
> blk_mq_realloc_hw_ctxs+0x488/0x5e0 block/blk-mq.c:4294
> blk_mq_init_allocated_queue+0x188/0x860 block/blk-mq.c:4350
> blk_mq_init_queue_data block/blk-mq.c:4166 [inline]
> blk_mq_init_queue+0x8d/0x100 block/blk-mq.c:4176
> scsi_alloc_sdev+0x843/0xd50 drivers/scsi/scsi_scan.c:335
> scsi_probe_and_add_lun+0x77c/0xde0 drivers/scsi/scsi_scan.c:1189
> __scsi_scan_target+0x1fc/0x5a0 drivers/scsi/scsi_scan.c:1727
> scsi_scan_channel drivers/scsi/scsi_scan.c:1815 [inline]
> scsi_scan_channel+0x14b/0x1e0 drivers/scsi/scsi_scan.c:1791
> scsi_scan_host_selected+0x2fe/0x400 drivers/scsi/scsi_scan.c:1844
> scsi_scan+0x3a0/0x3f0 drivers/scsi/scsi_sysfs.c:151
> store_scan+0x2a/0x60 drivers/scsi/scsi_sysfs.c:191
> dev_attr_store+0x5c/0x90 drivers/base/core.c:2388
> sysfs_kf_write+0x11c/0x170 fs/sysfs/file.c:136
> kernfs_fop_write_iter+0x3fc/0x610 fs/kernfs/file.c:338
> call_write_iter include/linux/fs.h:2083 [inline]
> new_sync_write+0x1b4/0x2d0 fs/read_write.c:493
> vfs_write+0x76c/0xb00 fs/read_write.c:586
> ksys_write+0x127/0x250 fs/read_write.c:639
> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
> entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> Freed by task 244687:
> kasan_save_stack+0x22/0x50 mm/kasan/common.c:45
> kasan_set_track+0x25/0x30 mm/kasan/common.c:52
> kasan_save_free_info+0x2b/0x50 mm/kasan/generic.c:522
> ____kasan_slab_free mm/kasan/common.c:236 [inline]
> __kasan_slab_free+0x12a/0x1b0 mm/kasan/common.c:244
> kasan_slab_free include/linux/kasan.h:164 [inline]
> slab_free_hook mm/slub.c:1815 [inline]
> slab_free_freelist_hook mm/slub.c:1841 [inline]
> slab_free mm/slub.c:3807 [inline]
> __kmem_cache_free+0xe4/0x520 mm/slub.c:3820
> blk_free_flush_queue+0x40/0x60 block/blk-flush.c:520
> blk_mq_hw_sysfs_release+0x4a/0x170 block/blk-mq-sysfs.c:37
> kobject_cleanup+0x136/0x410 lib/kobject.c:689
> kobject_release lib/kobject.c:720 [inline]
> kref_put include/linux/kref.h:65 [inline]
> kobject_put+0x119/0x140 lib/kobject.c:737
> blk_mq_release+0x24f/0x3f0 block/blk-mq.c:4144
> blk_free_queue block/blk-core.c:298 [inline]
> blk_put_queue+0xe2/0x180 block/blk-core.c:314
> blkg_free_workfn+0x376/0x6e0 block/blk-cgroup.c:144
> process_one_work+0x7c4/0x1450 kernel/workqueue.c:2631
> process_scheduled_works kernel/workqueue.c:2704 [inline]
> worker_thread+0x804/0xe40 kernel/workqueue.c:2785
> kthread+0x346/0x450 kernel/kthread.c:388
> ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
> ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:293
> 
> Other than blk_mq_clear_flush_rq_mapping(), the flag is only used in
> blk_register_queue() from initialization path, hence it's safe not to
> clear the flag in del_gendisk. And since QUEUE_FLAG_REGISTERED already
> make sure that queue should only be registered once, there is no need
> to test the flag as well.

But disk can be added again in case of sd rebind, so the check should be
kept.

> 
> Fixes: 6cfeadbff3f8 ("blk-mq: don't clear flush_rq from tags->rqs[]")
> Depends-on: commit aec89dc5d421 ("block: keep q_usage_counter in atomic mode after del_gendisk")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-sysfs.c | 6 ++----
>  block/genhd.c     | 9 +++------
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 741b95dfdbf6..a7c540728f3f 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -821,10 +821,8 @@ int blk_register_queue(struct gendisk *disk)
>  	 * faster to shut down and is made fully functional here as
>  	 * request_queues for non-existent devices never get registered.
>  	 */
> -	if (!blk_queue_init_done(q)) {
> -		blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
> -		percpu_ref_switch_to_percpu(&q->q_usage_counter);
> -	}
> +	blk_queue_flag_set(QUEUE_FLAG_INIT_DONE, q);
> +	percpu_ref_switch_to_percpu(&q->q_usage_counter);
>  
>  	return ret;
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index dfee66146bd1..87f9c2457ca6 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -742,13 +742,10 @@ void del_gendisk(struct gendisk *disk)
>  	 * If the disk does not own the queue, allow using passthrough requests
>  	 * again.  Else leave the queue frozen to fail all I/O.
>  	 */
> -	if (!test_bit(GD_OWNS_QUEUE, &disk->state)) {
> -		blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
> +	if (!test_bit(GD_OWNS_QUEUE, &disk->state))
>  		__blk_mq_unfreeze_queue(q, true);
> -	} else {
> -		if (queue_is_mq(q))
> -			blk_mq_exit_queue(q);
> -	}
> +	else if (queue_is_mq(q))
> +		blk_mq_exit_queue(q);

Clearing INIT_DONE only may regress sd rebind, and I'd suggest to move
the clearing into blk_mq_destroy_queue() for fixing this issue.


Thanks,
Ming

