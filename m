Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659219DFB4
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949002; cv=none; b=MGcH4hMPZuAmSYiXFCP9TssCm69/rStJzvy6u+53dqubPg4rDO9L+gia/culPmWNUMoGq2ly80MHi6bIF97EnCvbTnBiX3y+z1YosSG2iVIOXD1Z2kk/DBUSvLVfCIMJRTeNpIPZdgbcH58KQmYX/LV7HHOERKKCiozSQlSyDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949002; c=relaxed/simple;
	bh=I+4df5jc03tR9hMqQ+tiHEkVNhJYJi0TIN4XZvPFFgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3IkaDHsxi+6jqa0htkfVtHq4B/5SnRQm7Q6Uo/EadFigSM1UL1eBwyvBsemkU+SrDnwebONpRsVTEGhZbcqGA2FhqRkyP37pz13G/S6tIXsg8hCfURq1gJ+D5KOwfBGWWD7o7kMPfN7ZcoYaSxepf/b/xZ7whVJTslRRpkjpGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R905aX/6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R905aX/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750948999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BxkadiPWCttDuD+/2vqySOneu++FdmxeLIo/PFCcOlM=;
	b=R905aX/64XPvDJ0rtc9Vj609jCuEiwImDL7UqRRxGKsiLC8Lm9wAShzYBkxeWzdkdAB3q+
	s4Su64gXj4QSMPdfyENP421Ts+wGt+ohXM3kzxV2CTgRHVnfyuJVp/ckHI+ShCgkaFC+q+
	10ERVB8kkyKbRlgG98glTjZahti6J54=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-inmG9OSsMvOjo2nEEwXtSw-1; Thu,
 26 Jun 2025 10:43:14 -0400
X-MC-Unique: inmG9OSsMvOjo2nEEwXtSw-1
X-Mimecast-MFC-AGG-ID: inmG9OSsMvOjo2nEEwXtSw_1750948992
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17BAD1944AAF;
	Thu, 26 Jun 2025 14:43:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.69])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3046B30002C0;
	Thu, 26 Jun 2025 14:43:06 +0000 (UTC)
Date: Thu, 26 Jun 2025 22:43:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv4 2/3] block: fix lockdep warning caused by lock
 dependency in elv_iosched_store
Message-ID: <aF1cdHXunW5aqaci@fedora>
References: <20250624131716.630465-1-nilay@linux.ibm.com>
 <20250624131716.630465-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624131716.630465-3-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jun 24, 2025 at 06:47:04PM +0530, Nilay Shroff wrote:
> Recent lockdep reports [1] have revealed a potential deadlock caused by a
> lock dependency between the percpu allocator lock and the elevator lock.
> This issue can be avoided by ensuring that the allocation and release of
> scheduler tags (sched_tags) are performed outside the elevator lock.
> Furthermore, the queue does not need to be remain frozen during these
> operations.
> 
> To address this, move all sched_tags allocations and deallocations outside
> of both the ->elevator_lock and the ->freeze_lock. Since the lifetime of
> the elevator queue and its associated sched_tags is closely tied, the
> allocated sched_tags are now stored in the elevator queue structure. Then,
> during the actual elevator switch (which runs under ->freeze_lock and
> ->elevator_lock), the pre-allocated sched_tags are assigned to the
> appropriate q->hctx. Once the elevator switch is complete and the locks
> are released, the old elevator queue and its associated sched_tags are
> freed.
> 
> This commit specifically addresses the allocation/deallocation of sched_
> tags during elevator switching. Note that sched_tags may also be allocated
> in other contexts, such as during nr_hw_queues updates. Supporting that
> use case will require batch allocation/deallocation, which will be handled
> in a follow-up patch.
> 
> This restructuring ensures that sched_tags memory management occurs
> entirely outside of the ->elevator_lock and ->freeze_lock context,
> eliminating the lock dependency problem seen during scheduler updates.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq-sched.c | 186 ++++++++++++++++++++++++++-----------------
>  block/blk-mq-sched.h |  14 +++-
>  block/elevator.c     |  66 +++++++++++++--
>  block/elevator.h     |  19 ++++-
>  4 files changed, 204 insertions(+), 81 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 359e0704e09b..5d3132ac7777 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -374,64 +374,17 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>  
> -static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
> -					  struct blk_mq_hw_ctx *hctx,
> -					  unsigned int hctx_idx)
> -{
> -	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
> -		hctx->sched_tags = q->sched_shared_tags;
> -		return 0;
> -	}
> -
> -	hctx->sched_tags = blk_mq_alloc_map_and_rqs(q->tag_set, hctx_idx,
> -						    q->nr_requests);
> -
> -	if (!hctx->sched_tags)
> -		return -ENOMEM;
> -	return 0;
> -}
> -
> -static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
> -{
> -	blk_mq_free_rq_map(queue->sched_shared_tags);
> -	queue->sched_shared_tags = NULL;
> -}
> -
>  /* called in queue's release handler, tagset has gone away */
>  static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int flags)
>  {
>  	struct blk_mq_hw_ctx *hctx;
>  	unsigned long i;
>  
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		if (hctx->sched_tags) {
> -			if (!blk_mq_is_shared_tags(flags))
> -				blk_mq_free_rq_map(hctx->sched_tags);
> -			hctx->sched_tags = NULL;
> -		}
> -	}
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		hctx->sched_tags = NULL;
>  
>  	if (blk_mq_is_shared_tags(flags))
> -		blk_mq_exit_sched_shared_tags(q);
> -}
> -
> -static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
> -{
> -	struct blk_mq_tag_set *set = queue->tag_set;
> -
> -	/*
> -	 * Set initial depth at max so that we don't need to reallocate for
> -	 * updating nr_requests.
> -	 */
> -	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
> -						BLK_MQ_NO_HCTX_IDX,
> -						MAX_SCHED_RQ);
> -	if (!queue->sched_shared_tags)
> -		return -ENOMEM;
> -
> -	blk_mq_tag_update_sched_shared_tags(queue);
> -
> -	return 0;
> +		q->sched_shared_tags = NULL;
>  }
>  
>  void blk_mq_sched_reg_debugfs(struct request_queue *q)
> @@ -458,8 +411,106 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
>  	mutex_unlock(&q->debugfs_mutex);
>  }
>  
> +void __blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
> +		struct blk_mq_tags **tags, unsigned int nr_hw_queues)
> +{
> +	unsigned long i;
> +
> +	if (!tags)
> +		return;
> +
> +	/* Shared tags are stored at index 0 in @tags. */
> +	if (blk_mq_is_shared_tags(set->flags))
> +		blk_mq_free_map_and_rqs(set, tags[0], BLK_MQ_NO_HCTX_IDX);
> +	else {
> +		for (i = 0; i < nr_hw_queues; i++)
> +			blk_mq_free_map_and_rqs(set, tags[i], i);
> +	}
> +
> +	kfree(tags);
> +}
> +
> +void blk_mq_free_sched_tags(struct elevator_tags *et,
> +		struct blk_mq_tag_set *set, int id)
> +{
> +	struct blk_mq_tags **tags;
> +
> +	tags = xa_load(&et->tags_table, id);
> +	__blk_mq_free_sched_tags(set, tags, et->nr_hw_queues);
> +}
> +
> +struct blk_mq_tags **__blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
> +				unsigned int nr_hw_queues,
> +				unsigned int nr_requests,
> +				gfp_t gfp)
> +{
> +	int i, nr_tags;
> +	struct blk_mq_tags **tags;
> +
> +	if (blk_mq_is_shared_tags(set->flags))
> +		nr_tags = 1;
> +	else
> +		nr_tags = nr_hw_queues;
> +
> +	tags = kcalloc(nr_tags, sizeof(struct blk_mq_tags *), gfp);
> +	if (!tags)
> +		return NULL;
> +
> +	if (blk_mq_is_shared_tags(set->flags)) {
> +		/* Shared tags are stored at index 0 in @tags. */
> +		tags[0] = blk_mq_alloc_map_and_rqs(set, BLK_MQ_NO_HCTX_IDX,
> +					MAX_SCHED_RQ);
> +		if (!tags[0])
> +			goto out;
> +	} else {
> +		for (i = 0; i < nr_hw_queues; i++) {
> +			tags[i] = blk_mq_alloc_map_and_rqs(set, i, nr_requests);
> +			if (!tags[i])
> +				goto out_unwind;
> +		}
> +	}
> +
> +	return tags;
> +out_unwind:
> +	while (--i >= 0)
> +		blk_mq_free_map_and_rqs(set, tags[i], i);
> +out:
> +	kfree(tags);
> +	return NULL;
> +}
> +
> +int blk_mq_alloc_sched_tags(struct elevator_tags *et,
> +		struct blk_mq_tag_set *set, int id)
> +{
> +	struct blk_mq_tags **tags;
> +	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
> +
> +	/*
> +	 * Default to double of smaller one between hw queue_depth and
> +	 * 128, since we don't split into sync/async like the old code
> +	 * did. Additionally, this is a per-hw queue depth.
> +	 */
> +	et->nr_requests = 2 * min_t(unsigned int, set->queue_depth,
> +			BLKDEV_DEFAULT_RQ);
> +
> +	tags = __blk_mq_alloc_sched_tags(set, et->nr_hw_queues,
> +			et->nr_requests, gfp);
> +	if (!tags)
> +		return -ENOMEM;
> +
> +	if (xa_insert(&et->tags_table, id, tags, gfp))
> +		goto out_free_tags;

Not sure why you add `tags_table` into `elevator_tags`, it looks very
confusing just from naming, not mention only single element is stored to
the table in elevator switch code path since queue id is the key.

Wrt. xarray suggestion, I meant to add on xarray local variable in
__blk_mq_update_nr_hw_queues(), then you can store allocated `elevator_tags`
to the xarray via ->id of request_queue.



Thanks,
Ming

