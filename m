Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D03FE7
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 14:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763567; cv=none; b=auiKuGSqIUsj5YL1YHC6dHriOL44CXGQbHCanBMS3Az8YJ3NqmIG9hfkEL/sZL6g7LJXOVgiDT1X475YyFbWbRe/oMwxherJWFqzcqWv77kuVxsGRm8Kx5jZYnu2LhI74EdX2xQTGwMq+HLPHldI7g8ipD4PPvmY5mx6eLKXvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763567; c=relaxed/simple;
	bh=MnuaxBHOH9Zs8xJBcTdBuXRcNFStWRKDXN3wd/PligE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNR2bBDU7XvruFzm7aMmM1acgkPEyFOcmLBtSVeaUahGpaElOKpx9b/dSCtI24tmRFMDQN8uuHHsOHF/11pt9HG5ZceyuJM8xIE3ocqmtW3O9FkHX0hoPRTWsbZcKeJsL7SQ7HMFI3QaZLi+r8X52fSICn7hS9/5zV53YgZ+viY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KX8KcDkm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KX8KcDkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752763560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IL4wuHEwR/yhOtiGJ7JBvXrn5iczMhD54QzUBZ8f28=;
	b=KX8KcDkmPGH+NA9jf0TkVvFOCudf3xso5P9Mq5youLq11ZRxH3GJuLRzln8EIKZHspADmp
	BfZA5jEc20gUGdWBICbJDfjliU3foOi7yZ7tvI5xUxdG2HN+grbDj2Qi9pGuNyDwmsYc2a
	4Qx+2t775I/XKP6DZY6FRO42z1uyp2E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-oGD5970lNpCfvS57UyyWhw-1; Thu,
 17 Jul 2025 10:45:54 -0400
X-MC-Unique: oGD5970lNpCfvS57UyyWhw-1
X-Mimecast-MFC-AGG-ID: oGD5970lNpCfvS57UyyWhw_1752763552
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95F6818B6513;
	Thu, 17 Jul 2025 14:45:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9FD6E18003FC;
	Thu, 17 Jul 2025 14:45:02 +0000 (UTC)
Date: Thu, 17 Jul 2025 22:44:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, yi.zhang@redhat.com, hch@lst.de,
	yukuai1@huaweicloud.com, axboe@kernel.dk,
	shinichiro.kawasaki@wdc.com, yukuai3@huawei.com, gjoyce@ibm.com
Subject: Re: [PATCH] block: restore two stage elevator switch while running
 nr_hw_queue update
Message-ID: <aHkMaZnEVEEQc5TL@fedora>
References: <20250717141155.473362-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717141155.473362-1-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Jul 17, 2025 at 07:41:20PM +0530, Nilay Shroff wrote:
> The kmemleak reports memory leaks related to elevator resources that
> were originally allocated in the ->init_hctx() method. The following
> leak traces are observed after running blktests:
> 
> unreferenced object 0xffff8882e7fb9000 (size 2048):
>   comm "check", pid 10460, jiffies 4324980514
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc c47e6a37):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x416/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     find_fallback+0x510/0x540 [nbd]
>     nbd_send_cmd+0x24b/0x1480 [nbd]
>     configfs_write_iter+0x2ae/0x470
>     vfs_write+0x524/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff8882e7fbb000 (size 2048):
>   comm "check", pid 10460, jiffies 4324980514
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc c47e6a37):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x416/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     find_fallback+0x510/0x540 [nbd]
>     nbd_send_cmd+0x24b/0x1480 [nbd]
>     configfs_write_iter+0x2ae/0x470
>     vfs_write+0x524/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> unreferenced object 0xffff88819e855000 (size 2048):
>   comm "check", pid 10460, jiffies 4324980514
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc c47e6a37):
>     __kvmalloc_node_noprof+0x55d/0x7a0
>     sbitmap_init_node+0x15a/0x6a0
>     kyber_init_hctx+0x316/0xb90
>     blk_mq_init_sched+0x416/0x580
>     elevator_switch+0x18b/0x630
>     elv_update_nr_hw_queues+0x219/0x2c0
>     __blk_mq_update_nr_hw_queues+0x36a/0x6f0
>     blk_mq_update_nr_hw_queues+0x3a/0x60
>     find_fallback+0x510/0x540 [nbd]
>     nbd_send_cmd+0x24b/0x1480 [nbd]
>     configfs_write_iter+0x2ae/0x470
>     vfs_write+0x524/0xe70
>     ksys_write+0xff/0x200
>     do_syscall_64+0x98/0x3c0
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The issue arises while we run nr_hw_queue update,  Specifically, we first
> reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), and
> then later invoke elevator_switch() (assuming q->elevator is not NULL).
> The elevator switch code would first exit old elevator (elevator_exit)
> and then switches to the new elevator. The elevator_exit loops through
> each hctx and invokes the elevator’s per-hctx exit method ->exit_hctx(),
> which releases resources allocated during ->init_hctx().
> 
> This memleak manifests when we reduce the num of h/w queues - for example,
> when the initial update sets the number of queues to X, and a later update
> reduces it to Y, where Y < X. In this case, we'd loose the access to old
> hctxs while we get to elevator exit code because __blk_mq_realloc_hw_ctxs
> would have already released the old hctxs. As we don't now have any
> reference left to the old hctxs, we don't have any way to free the
> scheduler resources (which are allocate in ->init_hctx()) and kmemleak
> complains about it.
> 
> This issue was caused due to the commit 596dce110b7d ("block: simplify
> elevator reattachment for updating nr_hw_queues"). That change unified
> the two-stage elevator teardown and reattachment into a single call that
> occurs after __blk_mq_realloc_hw_ctxs() has already freed the hctxs.
> 
> This patch restores the previous two-stage elevator switch logic during
> nr_hw_queues updates. First, the elevator is switched to 'none', which
> ensures all scheduler resources are properly freed. Then, the hardware
> contexts (hctxs) are reallocated, and the software-to-hardware queue
> mappings are updated. Finally, the original elevator is reattached. This
> sequence prevents loss of references to old hctxs and avoids the scheduler
> resource leaks reported by kmemleak.
> 
> Reported-by : Yi Zhang <yi.zhang@redhat.com>
> Fixes: 596dce110b7d ("block: simplify elevator reattachment for updating nr_hw_queues")
> Closes: https://lore.kernel.org/all/CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq.c   | 87 +++++++++++++++++++++++++++++++++++++++++++-----
>  block/blk.h      |  4 ++-
>  block/elevator.c | 40 ++--------------------
>  block/elevator.h | 11 ++++++
>  4 files changed, 94 insertions(+), 48 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..b26cbf2a86dd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4966,6 +4966,63 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
>  	return ret;
>  }
>  
> +/*
> + * Switch back to the elevator name stored in the xarray.
> + */
> +static void blk_mq_elv_switch_back(struct request_queue *q,
> +		struct xarray *elv_tbl)
> +{
> +	struct elv_change_ctx ctx = {};
> +	int ret = -ENODEV;
> +	char *elevator_name = xa_load(elv_tbl, q->id);
> +
> +	WARN_ON_ONCE(q->mq_freeze_depth == 0);
> +
> +	mutex_lock(&q->elevator_lock);
> +	if (elevator_name && !blk_queue_dying(q) && blk_queue_registered(q)) {
> +		ctx.name = elevator_name;
> +
> +		/* force to reattach elevator after nr_hw_queue is updated */
> +		ret = elevator_switch(q, &ctx);
> +	}
> +	mutex_unlock(&q->elevator_lock);
> +	blk_mq_unfreeze_queue_nomemrestore(q);
> +	if (!ret)
> +		WARN_ON_ONCE(elevator_change_done(q, &ctx));
> +}
> +
> +/*
> + * Stores elevator name in xarray and set current elevator to none. It uses
> + * q->id as an index to store the elevator name into the xarray.
> + */
> +static int blk_mq_elv_switch_none(struct request_queue *q,
> +		struct xarray *elv_tbl)
> +{
> +	int ret = 0;
> +
> +	lockdep_assert_held_write(&q->tag_set->update_nr_hwq_lock);
> +
> +	/*
> +	 * Accessing q->elevator without holding q->elevator_lock is safe here
> +	 * because we're called from nr_hw_queue update which is protected by
> +	 * set->update_nr_hwq_lock in the writer context. So, scheduler update/
> +	 * switch code (which acquires the same lock in the reader context)
> +	 * can't run concurrently.
> +	 */
> +	if (q->elevator) {
> +		char *elevator_name = (char *)q->elevator->type->elevator_name;
> +
> +		ret = xa_insert(elv_tbl, q->id, elevator_name, GFP_KERNEL);

This way isn't memory safe, because elevator module can be reloaded
during updating nr_hw_queues. One solution is to build a string<->int mapping
table, and store the (int) index of elevator type to xarray.

> +		if (ret) {
> +			WARN_ON_ONCE(1);
> +			goto out;
> +		}
> +		elevator_set_none(q);
> +	}
> +out:
> +	return ret;
> +}
> +
>  static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  							int nr_hw_queues)
>  {
> @@ -4973,6 +5030,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	int prev_nr_hw_queues = set->nr_hw_queues;
>  	unsigned int memflags;
>  	int i;
> +	struct xarray elv_tbl;
>  
>  	lockdep_assert_held(&set->tag_list_lock);
>  
> @@ -4984,6 +5042,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		return;
>  
>  	memflags = memalloc_noio_save();
> +
> +	xa_init(&elv_tbl);
> +
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_debugfs_unregister_hctxs(q);
>  		blk_mq_sysfs_unregister_hctxs(q);
> @@ -4992,11 +5053,17 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		blk_mq_freeze_queue_nomemsave(q);
>  
> -	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
> -		list_for_each_entry(q, &set->tag_list, tag_set_list)
> -			blk_mq_unfreeze_queue_nomemrestore(q);
> -		goto reregister;
> -	}
> +	/*
> +	 * Switch IO scheduler to 'none', cleaning up the data associated
> +	 * with the previous scheduler. We will switch back once we are done
> +	 * updating the new sw to hw queue mappings.
> +	 */
> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +		if (blk_mq_elv_switch_none(q, &elv_tbl))
> +			goto switch_back;
> +
> +	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0)
> +		goto switch_back;
>  
>  fallback:
>  	blk_mq_update_queue_map(set);
> @@ -5016,12 +5083,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		}
>  		blk_mq_map_swqueue(q);
>  	}
> -
> -	/* elv_update_nr_hw_queues() unfreeze queue for us */
> +switch_back:
> +	/* blk_mq_elv_switch_back() unfreezes queue for us */
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -		elv_update_nr_hw_queues(q);
> +		blk_mq_elv_switch_back(q, &elv_tbl);
>  
> -reregister:
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_sysfs_register_hctxs(q);
>  		blk_mq_debugfs_register_hctxs(q);
> @@ -5029,6 +5095,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		blk_mq_remove_hw_queues_cpuhp(q);
>  		blk_mq_add_hw_queues_cpuhp(q);
>  	}
> +
> +	xa_destroy(&elv_tbl);
> +
>  	memalloc_noio_restore(memflags);
>  
>  	/* Free the excess tags when nr_hw_queues shrink. */
> diff --git a/block/blk.h b/block/blk.h
> index 37ec459fe656..35ec19a085fd 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -12,6 +12,7 @@
>  #include "blk-crypto-internal.h"
>  
>  struct elevator_type;
> +struct elv_change_ctx;
>  
>  #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
>  #define	BLK_MIN_SEGMENT_SIZE	4096
> @@ -321,9 +322,10 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
>  
>  bool blk_insert_flush(struct request *rq);
>  
> -void elv_update_nr_hw_queues(struct request_queue *q);
>  void elevator_set_default(struct request_queue *q);
>  void elevator_set_none(struct request_queue *q);
> +int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx);
> +int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx);
>  
>  ssize_t part_size_show(struct device *dev, struct device_attribute *attr,
>  		char *buf);
> diff --git a/block/elevator.c b/block/elevator.c
> index ab22542e6cf0..016fe9c08c8c 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -45,17 +45,6 @@
>  #include "blk-wbt.h"
>  #include "blk-cgroup.h"
>  
> -/* Holding context data for changing elevator */
> -struct elv_change_ctx {
> -	const char *name;
> -	bool no_uevent;
> -
> -	/* for unregistering old elevator */
> -	struct elevator_queue *old;
> -	/* for registering new elevator */
> -	struct elevator_queue *new;
> -};
> -
>  static DEFINE_SPINLOCK(elv_list_lock);
>  static LIST_HEAD(elv_list);
>  
> @@ -570,7 +559,7 @@ EXPORT_SYMBOL_GPL(elv_unregister);
>   * If switching fails, we are most likely running out of memory and not able
>   * to restore the old io scheduler, so leaving the io scheduler being none.
>   */
> -static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
> +int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>  {
>  	struct elevator_type *new_e = NULL;
>  	int ret = 0;
> @@ -631,8 +620,7 @@ static void elv_exit_and_release(struct request_queue *q)
>  		kobject_put(&e->kobj);
>  }
>  
> -static int elevator_change_done(struct request_queue *q,
> -				struct elv_change_ctx *ctx)
> +int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
>  {
>  	int ret = 0;
>  
> @@ -685,30 +673,6 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>  	return ret;
>  }
>  
> -/*
> - * The I/O scheduler depends on the number of hardware queues, this forces a
> - * reattachment when nr_hw_queues changes.
> - */
> -void elv_update_nr_hw_queues(struct request_queue *q)
> -{
> -	struct elv_change_ctx ctx = {};
> -	int ret = -ENODEV;
> -
> -	WARN_ON_ONCE(q->mq_freeze_depth == 0);
> -
> -	mutex_lock(&q->elevator_lock);
> -	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
> -		ctx.name = q->elevator->type->elevator_name;
> -
> -		/* force to reattach elevator after nr_hw_queue is updated */
> -		ret = elevator_switch(q, &ctx);
> -	}
> -	mutex_unlock(&q->elevator_lock);
> -	blk_mq_unfreeze_queue_nomemrestore(q);
> -	if (!ret)
> -		WARN_ON_ONCE(elevator_change_done(q, &ctx));
> -}
> -
>  /*
>   * Use the default elevator settings. If the chosen elevator initialization
>   * fails, fall back to the "none" elevator (no elevator).
> diff --git a/block/elevator.h b/block/elevator.h
> index a07ce773a38f..440b6e766848 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -85,6 +85,17 @@ struct elevator_type
>  	struct list_head list;
>  };
>  
> +/* Holding context data for changing elevator */
> +struct elv_change_ctx {
> +	const char *name;
> +	bool no_uevent;
> +
> +	/* for unregistering old elevator */
> +	struct elevator_queue *old;
> +	/* for registering new elevator */
> +	struct elevator_queue *new;
> +};
> +

You may avoid the big chunk of code move for both `elv_change_ctx` and 
`elv_update_nr_hw_queues()`, not sure why you did that in a bug fix patch.

Thanks,
Ming

