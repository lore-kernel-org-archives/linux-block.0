Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2221CAB3
	for <linux-block@vger.kernel.org>; Tue,  1 Jul 2025 03:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751340274; cv=none; b=FXe1oaZEphlKVCbKqsd81tXwatocyYnPPIrMPJbodaaWL0mhutj5X5wGM8KbYanrchSBGXwxV0ma7d/u1fhL69eHlITZHaD1ZYSq/HVntqxjCh8su1H2BepYiG6dycTMdu4Vl9IUGYqfpqtkVi1+NATcUHLKs3KJGz91UPM/oIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751340274; c=relaxed/simple;
	bh=J55E3qHCzIJyOV187Z7dEumoPh9PbxBvvwNKqOcnVkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYa4DeXwnktUhndQb8puzjDTx+omFBQ8qE5r70UkU4a9wNVDUYs2uyzwkNxRW092zSljG/QcKZNIsyq68Icib/mI+q2kKF1sNp2dGSfs3p/S/YL7XxKYEEy17kxhMQ8paFb7mPiJS24vZvGRi5NiCC/XJVr0+JeWBGdPwyehKBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvowBMqC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvowBMqC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751340271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IkGFd1iDN6CZs42CezrRFYwP8w5mCi/jqbMMxt1IXjo=;
	b=RvowBMqCN5TL9iVsvMzax1ycZh9YTQ2JDj1f8CVEqsgdElULmphyCVijKBle+pDC2Ncz+G
	xky4Ub6TnPdHyfDrumfFxgSyArQ58WSxQvtnlYv5KEmvV9Wh/0WLptQWRlKcXENzvmJ7ql
	yC4NbeUXSnHIaFBx3GO32eprVBlE2P4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-QKVNClUtPASiJTKvMBVSGw-1; Mon,
 30 Jun 2025 23:24:25 -0400
X-MC-Unique: QKVNClUtPASiJTKvMBVSGw-1
X-Mimecast-MFC-AGG-ID: QKVNClUtPASiJTKvMBVSGw_1751340263
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E4CC1944A8C;
	Tue,  1 Jul 2025 03:24:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3DB4195608F;
	Tue,  1 Jul 2025 03:24:17 +0000 (UTC)
Date: Tue, 1 Jul 2025 11:24:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	sth@linux.ibm.com, lkp@intel.com, gjoyce@ibm.com
Subject: Re: [PATCHv6 3/3] block: fix potential deadlock while running
 nr_hw_queue update
Message-ID: <aGNU3PPJ1wU--x-O@fedora>
References: <20250630054756.54532-1-nilay@linux.ibm.com>
 <20250630054756.54532-4-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630054756.54532-4-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jun 30, 2025 at 10:51:56AM +0530, Nilay Shroff wrote:
> Move scheduler tags (sched_tags) allocation and deallocation outside
> both the ->elevator_lock and ->freeze_lock when updating nr_hw_queues.
> This change breaks the dependency chain from the percpu allocator lock
> to the elevator lock, helping to prevent potential deadlocks, as
> observed in the reported lockdep splat[1].
> 
> This commit introduces batch allocation and deallocation helpers for
> sched_tags, which are now used from within __blk_mq_update_nr_hw_queues
> routine while iterating through the tagset.
> 
> With this change, all sched_tags memory management is handled entirely
> outside the ->elevator_lock and the ->freeze_lock context, thereby
> eliminating the lock dependency that could otherwise manifest during
> nr_hw_queues updates.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  block/blk-mq-sched.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
>  block/blk-mq-sched.h |  4 +++
>  block/blk-mq.c       | 11 +++++++-
>  block/blk.h          |  2 +-
>  block/elevator.c     |  4 +--
>  5 files changed, 80 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 2d6d1ebdd8fb..da802df34a8c 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -427,6 +427,30 @@ void blk_mq_free_sched_tags(struct elevator_tags *et,
>  	kfree(et);
>  }
>  
> +void blk_mq_free_sched_tags_batch(struct xarray *et_table,
> +		struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +	struct elevator_tags *et;
> +
> +	lockdep_assert_held_write(&set->update_nr_hwq_lock);
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		/*
> +		 * Accessing q->elevator without holding q->elevator_lock is
> +		 * safe because we're holding here set->update_nr_hwq_lock in
> +		 * the writer context. So, scheduler update/switch code (which
> +		 * acquires the same lock but in the reader context) can't run
> +		 * concurrently.
> +		 */
> +		if (q->elevator) {
> +			et = xa_load(et_table, q->id);
> +			if (et)
> +				blk_mq_free_sched_tags(et, set);
> +		}
> +	}
> +}
> +
>  struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  		unsigned int nr_hw_queues)
>  {
> @@ -477,6 +501,45 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  	return NULL;
>  }
>  
> +int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
> +		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
> +{
> +	struct request_queue *q;
> +	struct elevator_tags *et;
> +	gfp_t gfp = GFP_NOIO | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
> +
> +	lockdep_assert_held_write(&set->update_nr_hwq_lock);
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		/*
> +		 * Accessing q->elevator without holding q->elevator_lock is
> +		 * safe because we're holding here set->update_nr_hwq_lock in
> +		 * the writer context. So, scheduler update/switch code (which
> +		 * acquires the same lock but in the reader context) can't run
> +		 * concurrently.
> +		 */
> +		if (q->elevator) {
> +			et = blk_mq_alloc_sched_tags(set, nr_hw_queues);
> +			if (!et)
> +				goto out_unwind;
> +			if (xa_insert(et_table, q->id, et, gfp))
> +				goto out_free_tags;
> +		}
> +	}
> +	return 0;
> +out_free_tags:
> +	blk_mq_free_sched_tags(et, set);
> +out_unwind:
> +	list_for_each_entry_continue_reverse(q, &set->tag_list, tag_set_list) {
> +		if (q->elevator) {
> +			et = xa_load(et_table, q->id);
> +			if (et)
> +				blk_mq_free_sched_tags(et, set);
> +		}
> +	}
> +	return -ENOMEM;
> +}
> +
>  /* caller must have a reference to @e, will grab another one if successful */
>  int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
>  		struct elevator_tags *et)
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 0cde00cd1c47..b554e1d55950 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -25,8 +25,12 @@ void blk_mq_sched_free_rqs(struct request_queue *q);
>  
>  struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>  		unsigned int nr_hw_queues);
> +int blk_mq_alloc_sched_tags_batch(struct xarray *et_table,
> +		struct blk_mq_tag_set *set, unsigned int nr_hw_queues);
>  void blk_mq_free_sched_tags(struct elevator_tags *et,
>  		struct blk_mq_tag_set *set);
> +void blk_mq_free_sched_tags_batch(struct xarray *et_table,
> +		struct blk_mq_tag_set *set);
>  
>  static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>  {
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 4806b867e37d..a68b658ce07b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4972,6 +4972,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	struct request_queue *q;
>  	int prev_nr_hw_queues = set->nr_hw_queues;
>  	unsigned int memflags;
> +	struct xarray et_table;
>  	int i;
>  
>  	lockdep_assert_held(&set->tag_list_lock);
> @@ -4984,6 +4985,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		return;
>  
>  	memflags = memalloc_noio_save();
> +
> +	xa_init(&et_table);
> +	if (blk_mq_alloc_sched_tags_batch(&et_table, set, nr_hw_queues) < 0)
> +		goto out_memalloc_restore;
> +
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
>  		blk_mq_debugfs_unregister_hctxs(q);
>  		blk_mq_sysfs_unregister_hctxs(q);
> @@ -4995,6 +5001,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  	if (blk_mq_realloc_tag_set_tags(set, nr_hw_queues) < 0) {
>  		list_for_each_entry(q, &set->tag_list, tag_set_list)
>  			blk_mq_unfreeze_queue_nomemrestore(q);
> +		blk_mq_free_sched_tags_batch(&et_table, set);
>  		goto reregister;
>  	}
>  
> @@ -5019,7 +5026,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  
>  	/* elv_update_nr_hw_queues() unfreeze queue for us */
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -		elv_update_nr_hw_queues(q);
> +		elv_update_nr_hw_queues(q, &et_table);
>  
>  reregister:
>  	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> @@ -5029,7 +5036,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		blk_mq_remove_hw_queues_cpuhp(q);
>  		blk_mq_add_hw_queues_cpuhp(q);
>  	}
> +out_memalloc_restore:
>  	memalloc_noio_restore(memflags);
> +	xa_destroy(&et_table);
>  
>  	/* Free the excess tags when nr_hw_queues shrink. */
>  	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
> diff --git a/block/blk.h b/block/blk.h
> index 37ec459fe656..c6d1d1458388 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -321,7 +321,7 @@ bool blk_bio_list_merge(struct request_queue *q, struct list_head *list,
>  
>  bool blk_insert_flush(struct request *rq);
>  
> -void elv_update_nr_hw_queues(struct request_queue *q);
> +void elv_update_nr_hw_queues(struct request_queue *q, struct xarray *et_table);
>  void elevator_set_default(struct request_queue *q);
>  void elevator_set_none(struct request_queue *q);
>  
> diff --git a/block/elevator.c b/block/elevator.c
> index 50f4b78efe66..8ba8b869d5a4 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -705,7 +705,7 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>   * The I/O scheduler depends on the number of hardware queues, this forces a
>   * reattachment when nr_hw_queues changes.
>   */
> -void elv_update_nr_hw_queues(struct request_queue *q)
> +void elv_update_nr_hw_queues(struct request_queue *q, struct xarray *et_table)

et_table isn't necessary to expose to elv_update_nr_hw_queues(), and it is
less readable than passing 'struct elevator_tags *' directly, but it can be
one followup improvement.

Anyway:

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks, 
Ming

