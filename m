Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828C2C3271
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748939866; cv=none; b=sivGnM47zKj2LgPXjEvcBnB0voZlC9sYnCkZboCye2oX6aCILeN+Ds/B/MGFLAct5ZlIm6FM3cX9b8br9HNbAHFAU1dPeOvmMW+R+8dlz4dwZFnuaTE0RnUtU3pBbPSDJ3HfEgccKrwC5YdZbN3RIqMVH+Lj3hcdipGyyrSYZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748939866; c=relaxed/simple;
	bh=mNAs9jhpXUZS3r90KTReN7u+mTDfU/X5KX3/budFUE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5qATKPWeGTzQ1vrS+wmciiQ0fpOrjcUvxlOzxt5EY6eEBrOWPAOwoeRaqyclOnw7ZE1f8C0cxcsRqjNlJcpj3GnUric83tgYs9XZH3wSHne+zuTnswKRJ/XgWO3q/+PcnFrlStNCbdysOQdDOxqVlWPsmiGdkeX09J9CwiQEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKmPEZFu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKmPEZFu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748939862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2BBj5y9FuzaLrm65gq26LLdeq0d5Ab5MPB9rIUVA3Q=;
	b=dKmPEZFunlwsNiQdvDEaLP9roE5+aCe6jKAcwF5kGtnmydHUTdWlrAAWjZG50SftRHU/Mi
	wBxEHfIW9Et3FeYECaTs514yXk92Ba+/Mp+QupXswKd5mrl6e/zxTZWcsalVDj1eYcT6pC
	YiyyzAUXgz967ABCl6+ObbUT0QYaCtA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-m3L5eB4bMFmZ8yQQZZWu0A-1; Tue,
 03 Jun 2025 04:37:39 -0400
X-MC-Unique: m3L5eB4bMFmZ8yQQZZWu0A-1
X-Mimecast-MFC-AGG-ID: m3L5eB4bMFmZ8yQQZZWu0A_1748939858
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECF601956095;
	Tue,  3 Jun 2025 08:37:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77B3F195608D;
	Tue,  3 Jun 2025 08:37:33 +0000 (UTC)
Date: Tue, 3 Jun 2025 16:37:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv2] block: fix lock dependency between percpu alloc lock
 and elevator lock
Message-ID: <aD60SF6QGMSPykq-@fedora>
References: <20250528123638.1029700-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528123638.1029700-1-nilay@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, May 28, 2025 at 06:03:58PM +0530, Nilay Shroff wrote:
> Recent lockdep reports [1] have revealed a potential deadlock caused
> by a lock dependency between the percpu allocator lock and the elevator
> lock. This issue can be avoided by ensuring that the allocation and
> release of scheduler tags (sched_tags) are performed outside the
> elevator lock. Furthermore, the queue does not need to remain frozen
> during these operations.
> 
> Since the lifetime of the elevator queue and its associated sched_tags
> is closely tied, we now pre-allocate both elevator queue and sched_tags
> before initiating the elevator switch—outside the protection of ->freeze_
> lock and ->elevator_lock. The newly allocated sched_tags are stored in
> the elevator queue structure.
> 
> Then, during the actual elevator switch (which runs under ->freeze_lock
> and ->elevator_lock), the pre-allocated sched_tags are assigned to the
> appropriate q->hctx. Once the switch is complete and the locks are
> released, the old elevator queue and its associated sched_tags are
> freed. This change also requires updating the ->init_sched elevator ops
> API as now elevator queue allocation happens very early before we
> actually start switching the elevator. So, accordingly, this patch also
> updates the ->init_sched implementation for each supported elevator.
> 
> With this change, all sched_tags allocations and deallocations occur
> outside of both ->freeze_lock and ->elevator_lock, and that helps
> prevent the lock ordering issue observed when elv_iosched_store() is
> triggered via sysfs.
> 
> [1] https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> 
> Reported-by: Stefan Haberland <sth@linux.ibm.com>
> Closes: https://lore.kernel.org/all/0659ea8d-a463-47c8-9180-43c719e106eb@linux.ibm.com/
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
> Changes from v1:
>     - As the lifetime of elevator queue and sched tags are same, allocate 
>       and move sched tags under struct elevator_queue (Ming Lei)
> ---
>  block/bfq-iosched.c   |   7 +-
>  block/blk-mq-sched.c  | 214 ++++++++++++++++++++++++++----------------
>  block/blk-mq-sched.h  |  28 +++++-
>  block/elevator.c      | 123 +++++++++++++-----------
>  block/elevator.h      |   5 +-
>  block/kyber-iosched.c |   7 +-
>  block/mq-deadline.c   |   7 +-
>  7 files changed, 233 insertions(+), 158 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 0cb1e9873aab..51d406da4abf 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -7232,17 +7232,12 @@ static void bfq_init_root_group(struct bfq_group *root_group,
>  	root_group->sched_data.bfq_class_idle_last_service = jiffies;
>  }
>  
> -static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
> +static int bfq_init_queue(struct request_queue *q, struct elevator_queue *eq)
>  {
>  	struct bfq_data *bfqd;
> -	struct elevator_queue *eq;
>  	unsigned int i;
>  	struct blk_independent_access_ranges *ia_ranges = q->disk->ia_ranges;
>  
> -	eq = elevator_alloc(q, e);
> -	if (!eq)
> -		return -ENOMEM;
> -

Please make the above elevator interface change be one standalone patch if possible,
which may help review much.

>  	bfqd = kzalloc_node(sizeof(*bfqd), GFP_KERNEL, q->node);
>  	if (!bfqd) {
>  		kobject_put(&eq->kobj);
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> index 55a0fd105147..41bc864440eb 100644
> --- a/block/blk-mq-sched.c
> +++ b/block/blk-mq-sched.c
> @@ -374,61 +374,51 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
>  
> -static int blk_mq_sched_alloc_map_and_rqs(struct request_queue *q,
> -					  struct blk_mq_hw_ctx *hctx,
> -					  unsigned int hctx_idx)
> +static int blk_mq_init_sched_tags(struct request_queue *q,
> +				  struct blk_mq_hw_ctx *hctx,
> +				  unsigned int hctx_idx,
> +				  struct elevator_queue *elevator)
>  {
>  	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
>  		hctx->sched_tags = q->sched_shared_tags;
>  		return 0;
>  	}
> +	/*
> +	 * We allocated the elevator queue and sched tags before initiating the
> +	 * elevator switch, prior to acquiring ->elevator_lock. The sched tags
> +	 * are stored under the elevator queue. So assign those pre-allocated
> +	 * sched tags now.
> +	 */
> +	hctx->sched_tags = elevator->tags[hctx_idx];
>  
> -	hctx->sched_tags = blk_mq_alloc_map_and_rqs(q->tag_set, hctx_idx,
> -						    q->nr_requests);
> -
> -	if (!hctx->sched_tags)
> -		return -ENOMEM;
>  	return 0;
>  }
>  
> -static void blk_mq_exit_sched_shared_tags(struct request_queue *queue)
> -{
> -	blk_mq_free_rq_map(queue->sched_shared_tags);
> -	queue->sched_shared_tags = NULL;
> -}
> -
> -/* called in queue's release handler, tagset has gone away */
> +/*
> + * Called while exiting elevator. Sched tags are freed later when we finish
> + * switching the elevator and releases the ->elevator_lock and ->frezze_lock.
> + */
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
> +		q->sched_shared_tags = NULL;
>  }
> -
> -static int blk_mq_init_sched_shared_tags(struct request_queue *queue)
> +static int blk_mq_init_sched_shared_tags(struct request_queue *queue,
> +		struct elevator_queue *elevator)
>  {
> -	struct blk_mq_tag_set *set = queue->tag_set;
> -
>  	/*
> -	 * Set initial depth at max so that we don't need to reallocate for
> -	 * updating nr_requests.
> +	 * We allocated the elevator queue and sched tags before initiating the
> +	 * elevator switch, prior to acquiring ->elevator_lock. The sched tags
> +	 * are stored under the elevator queue. So assign the pre-allocated
> +	 * sched tags now.
>  	 */
> -	queue->sched_shared_tags = blk_mq_alloc_map_and_rqs(set,
> -						BLK_MQ_NO_HCTX_IDX,
> -						MAX_SCHED_RQ);
> -	if (!queue->sched_shared_tags)
> -		return -ENOMEM;
> -
> +	queue->sched_shared_tags = elevator->shared_tags;
>  	blk_mq_tag_update_sched_shared_tags(queue);
>  
>  	return 0;
> @@ -458,8 +448,97 @@ void blk_mq_sched_unreg_debugfs(struct request_queue *q)
>  	mutex_unlock(&q->debugfs_mutex);
>  }
>  
> +int blk_mq_alloc_elevator_and_sched_tags(struct request_queue *q,
> +		struct elv_change_ctx *ctx)
> +{
> +	unsigned long i;
> +	struct elevator_queue *elevator;
> +	struct elevator_type *e;
> +	struct blk_mq_tag_set *set = q->tag_set;
> +	gfp_t gfp = GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY;
> +
> +	if (strncmp(ctx->new.name, "none", 4)) {

You can return early if new name is "none", then all indent in the code
block can be avoided.

> +
> +		e = elevator_find_get(ctx->new.name);
> +		if (!e)
> +			return -EINVAL;
> +
> +		elevator = ctx->new.elevator = elevator_alloc(q, e);

You needn't to allocate elevator queue here, then the big elv_change_ctx change
may be avoided by passing sched tags directly.

Also it may be fragile to allocate elevator queue here without holding elevator
lock. You may have to document this way is safe by allocating elevator
queue with specified elevator type lockless.

> +		if (!elevator) {
> +			elevator_put(e);
> +			return -ENOMEM;
> +		}
> +
> +		/*
> +		 * Default to double of smaller one between hw queue_depth and
> +		 * 128, since we don't split into sync/async like the old code
> +		 * did. Additionally, this is a per-hw queue depth.
> +		 */
> +		ctx->new.nr_requests = 2 * min_t(unsigned int,
> +						set->queue_depth,
> +						BLKDEV_DEFAULT_RQ);
> +
> +		if (blk_mq_is_shared_tags(set->flags)) {
> +
> +			elevator->shared_tags = blk_mq_alloc_map_and_rqs(set,
> +							BLK_MQ_NO_HCTX_IDX,
> +							MAX_SCHED_RQ);
> +			if (!elevator->shared_tags)
> +				goto out_elevator_release;
> +
> +			return 0;
> +		}
> +
> +		elevator->tags = kcalloc(set->nr_hw_queues,
> +					sizeof(struct blk_mq_tags *),
> +					gfp);
> +		if (!elevator->tags)
> +			goto out_elevator_release;
> +
> +		for (i = 0; i < set->nr_hw_queues; i++) {
> +			elevator->tags[i] = blk_mq_alloc_map_and_rqs(set, i,
> +						ctx->new.nr_requests);
> +			if (!elevator->tags[i])
> +				goto out_free_tags;
> +		}
> +	}
> +
> +	return 0;
> +
> +out_free_tags:
> +	blk_mq_free_sched_tags(q->tag_set, elevator);
> +out_elevator_release:
> +	kobject_put(&elevator->kobj);
> +	return -ENOMEM;
> +}
> +
> +void blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
> +		struct elevator_queue *elevator)
> +{
> +	unsigned long i;
> +
> +	if (elevator->shared_tags) {
> +		blk_mq_free_rqs(set, elevator->shared_tags, BLK_MQ_NO_HCTX_IDX);
> +		blk_mq_free_rq_map(elevator->shared_tags);
> +		return;
> +	}
> +
> +	if (!elevator->tags)
> +		return;
> +
> +	for (i = 0; i < set->nr_hw_queues; i++) {
> +		if (elevator->tags[i]) {
> +			blk_mq_free_rqs(set, elevator->tags[i], i);
> +			blk_mq_free_rq_map(elevator->tags[i]);
> +		}
> +	}
> +
> +	kfree(elevator->tags);
> +}
> +
>  /* caller must have a reference to @e, will grab another one if successful */
> -int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
> +int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
> +		struct elv_change_ctx *ctx)
>  {
>  	unsigned int flags = q->tag_set->flags;
>  	struct blk_mq_hw_ctx *hctx;
> @@ -467,73 +546,44 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
>  	unsigned long i;
>  	int ret;
>  
> -	/*
> -	 * Default to double of smaller one between hw queue_depth and 128,
> -	 * since we don't split into sync/async like the old code did.
> -	 * Additionally, this is a per-hw queue depth.
> -	 */
> -	q->nr_requests = 2 * min_t(unsigned int, q->tag_set->queue_depth,
> -				   BLKDEV_DEFAULT_RQ);
> +	q->nr_requests = ctx->new.nr_requests;
>  
> -	if (blk_mq_is_shared_tags(flags)) {
> -		ret = blk_mq_init_sched_shared_tags(q);
> -		if (ret)
> -			return ret;
> -	}
> +	if (blk_mq_is_shared_tags(flags))
> +		blk_mq_init_sched_shared_tags(q, ctx->new.elevator);
>  
> -	queue_for_each_hw_ctx(q, hctx, i) {
> -		ret = blk_mq_sched_alloc_map_and_rqs(q, hctx, i);
> -		if (ret)
> -			goto err_free_map_and_rqs;
> -	}
> +	queue_for_each_hw_ctx(q, hctx, i)
> +		blk_mq_init_sched_tags(q, hctx, i, ctx->new.elevator);
>  
> -	ret = e->ops.init_sched(q, e);
> +	ret = e->ops.init_sched(q, ctx->new.elevator);
>  	if (ret)
> -		goto err_free_map_and_rqs;
> +		goto out;
>  
>  	queue_for_each_hw_ctx(q, hctx, i) {
>  		if (e->ops.init_hctx) {
>  			ret = e->ops.init_hctx(hctx, i);
>  			if (ret) {
> +				/*
> +				 * For failed case, sched tags are released
> +				 * later when we finish switching elevator and
> +				 * release ->elevator_lock and ->freeze_lock.
> +				 */
>  				eq = q->elevator;
> -				blk_mq_sched_free_rqs(q);
>  				blk_mq_exit_sched(q, eq);
> -				kobject_put(&eq->kobj);
>  				return ret;
>  			}
>  		}
>  	}
>  	return 0;
>  
> -err_free_map_and_rqs:
> -	blk_mq_sched_free_rqs(q);
> -	blk_mq_sched_tags_teardown(q, flags);
> -
> +out:
> +	/*
> +	 * Sched tags are released later when we finish switching elevator
> +	 * and release ->elevator_lock and ->freeze_lock.
> +	 */
>  	q->elevator = NULL;
>  	return ret;
>  }
>  
> -/*
> - * called in either blk_queue_cleanup or elevator_switch, tagset
> - * is required for freeing requests
> - */
> -void blk_mq_sched_free_rqs(struct request_queue *q)
> -{
> -	struct blk_mq_hw_ctx *hctx;
> -	unsigned long i;
> -
> -	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
> -		blk_mq_free_rqs(q->tag_set, q->sched_shared_tags,
> -				BLK_MQ_NO_HCTX_IDX);
> -	} else {
> -		queue_for_each_hw_ctx(q, hctx, i) {
> -			if (hctx->sched_tags)
> -				blk_mq_free_rqs(q->tag_set,
> -						hctx->sched_tags, i);
> -		}
> -	}
> -}
> -
>  void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
>  {
>  	struct blk_mq_hw_ctx *hctx;
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
> index 1326526bb733..6c0f1936b81c 100644
> --- a/block/blk-mq-sched.h
> +++ b/block/blk-mq-sched.h
> @@ -7,6 +7,26 @@
>  
>  #define MAX_SCHED_RQ (16 * BLKDEV_DEFAULT_RQ)
>  
> +/* Holding context data for changing elevator */
> +struct elv_change_ctx {
> +	/* for unregistering/freeing old elevator */
> +	struct {
> +		struct elevator_queue *elevator;
> +	} old;
> +
> +	/* for registering/allocating new elevator */
> +	struct {
> +		const char *name;
> +		bool no_uevent;
> +		unsigned long nr_requests;
> +		struct elevator_queue *elevator;
> +		int inited;
> +	} new;
> +
> +	/* elevator switch status */
> +	int status;
> +};
> +

As I mentioned, 'elv_change_ctx' becomes more complicated, which may be
avoided.

>  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
>  		unsigned int nr_segs, struct request **merged_request);
>  bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
> @@ -18,9 +38,13 @@ void __blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
>  
>  void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
>  
> -int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
> +int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e,
> +		struct elv_change_ctx *ctx);
> +int blk_mq_alloc_elevator_and_sched_tags(struct request_queue *q,
> +		struct elv_change_ctx *ctx);
> +void blk_mq_free_sched_tags(struct blk_mq_tag_set *set,
> +		struct elevator_queue *elevator);
>  void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
> -void blk_mq_sched_free_rqs(struct request_queue *q);
>  
>  static inline void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx)
>  {
> diff --git a/block/elevator.c b/block/elevator.c
> index ab22542e6cf0..da740cff8dbc 100644
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
> @@ -117,7 +106,7 @@ static struct elevator_type *__elevator_find(const char *name)
>  	return NULL;
>  }
>  
> -static struct elevator_type *elevator_find_get(const char *name)
> +struct elevator_type *elevator_find_get(const char *name)
>  {
>  	struct elevator_type *e;
>  
> @@ -128,6 +117,7 @@ static struct elevator_type *elevator_find_get(const char *name)
>  	spin_unlock(&elv_list_lock);
>  	return e;
>  }
> +EXPORT_SYMBOL(elevator_find_get);

`elevator_find_get()` is block core internal helper, why do you export it?

>  
>  static const struct kobj_type elv_ktype;
>  
> @@ -166,7 +156,6 @@ static void elevator_exit(struct request_queue *q)
>  	lockdep_assert_held(&q->elevator_lock);
>  
>  	ioc_clear_queue(q);
> -	blk_mq_sched_free_rqs(q);
>  
>  	mutex_lock(&e->sysfs_lock);
>  	blk_mq_exit_sched(q, e);
> @@ -570,38 +559,34 @@ EXPORT_SYMBOL_GPL(elv_unregister);
>   * If switching fails, we are most likely running out of memory and not able
>   * to restore the old io scheduler, so leaving the io scheduler being none.
>   */
> -static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
> +static void elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>  {
> -	struct elevator_type *new_e = NULL;
> +	struct elevator_type *new_e;
>  	int ret = 0;
>  
>  	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>  	lockdep_assert_held(&q->elevator_lock);
>  
> -	if (strncmp(ctx->name, "none", 4)) {
> -		new_e = elevator_find_get(ctx->name);
> -		if (!new_e)
> -			return -EINVAL;
> -	}
> +	new_e = ctx->new.elevator ? ctx->new.elevator->type : NULL;
>  
>  	blk_mq_quiesce_queue(q);
>  
>  	if (q->elevator) {
> -		ctx->old = q->elevator;
> +		ctx->old.elevator = q->elevator;
>  		elevator_exit(q);
>  	}
>  
>  	if (new_e) {
> -		ret = blk_mq_init_sched(q, new_e);
> +		ret = blk_mq_init_sched(q, new_e, ctx);
>  		if (ret)
>  			goto out_unfreeze;
> -		ctx->new = q->elevator;
> +		ctx->new.inited = 1;
>  	} else {
>  		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
>  		q->elevator = NULL;
>  		q->nr_requests = q->tag_set->queue_depth;
>  	}
> -	blk_add_trace_msg(q, "elv switch: %s", ctx->name);
> +	blk_add_trace_msg(q, "elv switch: %s", ctx->new.name);
>  
>  out_unfreeze:
>  	blk_mq_unquiesce_queue(q);
> @@ -610,10 +595,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>  		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
>  			new_e->elevator_name);
>  	}
> -
> -	if (new_e)
> -		elevator_put(new_e);
> -	return ret;
> +	ctx->status = ret;
>  }
>  
>  static void elv_exit_and_release(struct request_queue *q)
> @@ -627,28 +609,43 @@ static void elv_exit_and_release(struct request_queue *q)
>  	elevator_exit(q);
>  	mutex_unlock(&q->elevator_lock);
>  	blk_mq_unfreeze_queue(q, memflags);
> -	if (e)
> +	if (e) {
> +		blk_mq_free_sched_tags(q->tag_set, e);
>  		kobject_put(&e->kobj);
> +	}
>  }
>  
>  static int elevator_change_done(struct request_queue *q,
>  				struct elv_change_ctx *ctx)
>  {
> -	int ret = 0;
> +	int ret = ctx->status;
> +	struct elevator_queue *old_e = ctx->old.elevator;
> +	struct elevator_queue *new_e = ctx->new.elevator;
> +	int inited = ctx->new.inited;
>  
> -	if (ctx->old) {
> +	if (old_e) {
>  		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
> -				&ctx->old->flags);
> +				&old_e->flags);
>  
> -		elv_unregister_queue(q, ctx->old);
> -		kobject_put(&ctx->old->kobj);
> +		elv_unregister_queue(q, old_e);
> +		blk_mq_free_sched_tags(q->tag_set, old_e);
> +		kobject_put(&old_e->kobj);
>  		if (enable_wbt)
>  			wbt_enable_default(q->disk);
>  	}
> -	if (ctx->new) {
> -		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
> -		if (ret)
> -			elv_exit_and_release(q);
> +	if (new_e) {
> +		if (inited) {
> +			ret = elv_register_queue(q, new_e, !ctx->new.no_uevent);
> +			if (ret)
> +				elv_exit_and_release(q);
> +		} else {
> +			/*
> +			 * Switching to the new elevator failed, so free sched
> +			 * tags allocated earlier and release the elevator.
> +			 */
> +			blk_mq_free_sched_tags(q->tag_set, new_e);
> +			kobject_put(&new_e->kobj);
> +		}
>  	}
>  	return ret;
>  }
> @@ -663,6 +660,11 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>  
>  	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
>  
> +	ret = blk_mq_alloc_elevator_and_sched_tags(q, ctx);
> +	if (ret)
> +		return ret;
> +
> +	ctx->status = 0;
>  	memflags = blk_mq_freeze_queue(q);
>  	/*
>  	 * May be called before adding disk, when there isn't any FS I/O,
> @@ -675,12 +677,12 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>  	 */
>  	blk_mq_cancel_work_sync(q);
>  	mutex_lock(&q->elevator_lock);
> -	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
> -		ret = elevator_switch(q, ctx);
> +	if (!(q->elevator && elevator_match(q->elevator->type, ctx->new.name)))
> +		elevator_switch(q, ctx);
>  	mutex_unlock(&q->elevator_lock);
>  	blk_mq_unfreeze_queue(q, memflags);
> -	if (!ret)
> -		ret = elevator_change_done(q, ctx);
> +
> +	ret = elevator_change_done(q, ctx);
>  
>  	return ret;
>  }
> @@ -696,17 +698,29 @@ void elv_update_nr_hw_queues(struct request_queue *q)
>  
>  	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>  
> -	mutex_lock(&q->elevator_lock);
> +	/*
> +	 * Accessing q->elevator without holding q->elevator_lock is safe
> +	 * because nr_hw_queue update is protected by set->update_nr_hwq_lock
> +	 * in the writer context. So, scheduler update/switch code (which
> +	 * acquires same lock in the reader context) cannot run concurrently.
> +	 */
>  	if (q->elevator && !blk_queue_dying(q) && blk_queue_registered(q)) {
> -		ctx.name = q->elevator->type->elevator_name;
> +		ctx.new.name = q->elevator->type->elevator_name;
> +		ret = blk_mq_alloc_elevator_and_sched_tags(q, &ctx);

Queue is still frozen, so the dependency between freeze lock and
the global percpu allocation lock isn't cut completely.


Thanks, 
Ming

