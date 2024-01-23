Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DCF9DE
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977041; cv=none; b=eL9vSGz2EmVpgd6pEunY+saanxWLlzsAdnXON5A+QU4W1oDbYzrogjXqSrxeA15/+Rh03QLEdmYbvxJKQhHotmKPeCGpUbWSh3gJ2TAtVFHbiVHiGdTn7vyFq/tZt3y9XaQy5rDMIDOuuQi6dZh2x0yABigmBI0ZQM+WoF0R6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977041; c=relaxed/simple;
	bh=QE53X/xWXwcKBomQY1jbzB3x3h6ecrLHnmpGX5csJfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmTlUtKo6OU7QvN/AFiCnR5kjgKkLB8ofGFrpKPsPColTmB5FDqCQ9aHfqaAXF0pYTaTVO+mS3tag1mLVu0HOuJqzNguKHXGct8EMJHgkIkfD+KnK+aWCWPFUGv3gui21ABRWmf5+ShKuYf2o4sAtxql34f/us5fHDymwNMBs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvDSHpca; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvDSHpca"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3045C433F1;
	Tue, 23 Jan 2024 02:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705977041;
	bh=QE53X/xWXwcKBomQY1jbzB3x3h6ecrLHnmpGX5csJfc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MvDSHpcaDSh1DF90EHB5v/WczcVUFfWPpFgUQCJxdZL3KwaA5CRnbO0E2RxdeyYVC
	 sTm0bqtK+dk9mLR1dRs8KwMtohhkv5JQC29E39b0CP+w1FNzWVfVyNCXCXZiaK7YeG
	 PdIhAnDGgiluUsliodIHeTkW+R0GY57xEz/I80afCqHTHKmYLJTBe4DV+g/WLAyZYA
	 yfGsKPT7gAbgo+Aw92tBu7SewnHKaah2AuY6wGwKgKLPaJgWH9pNFjfz6bC1cSjiOn
	 m4lroeQVtUK01GSGaer0OFkAwG6PEyrxoYjk7ua0sgjcp4C4xRt+99RRZfJVUZOyZz
	 v1R+lQVvd8dkQ==
Message-ID: <1f140e5c-c7b3-424b-9231-fe51ddb6fbf7@kernel.org>
Date: Tue, 23 Jan 2024 11:30:39 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mq-deadline: Optimize request insertion
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20240122235332.2299150-1-bvanassche@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240122235332.2299150-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/24 08:53, Bart Van Assche wrote:
> Reduce lock contention on dd->lock by calling dd_insert_request() from
> inside the dispatch callback instead of from the insert callback. This
> patch is inspired by a patch from Jens.

I supposed this is a followup of the performance discussion with Jens. If so,
can you add performance numbers here and so justifying the change ?
Otherwise, it is hard to figure out the effect of the patch and so why you are
making this change.

> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 70 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 12 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 83bc21801226..d11b8604f046 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -89,11 +89,15 @@ struct deadline_data {
>  	 */
>  	struct {
>  		spinlock_t lock;
> +		spinlock_t insert_lock;
>  		spinlock_t zone_lock;
>  	} ____cacheline_aligned_in_smp;
>  
>  	unsigned long run_state;
>  
> +	struct list_head at_head;
> +	struct list_head at_tail;
> +
>  	struct dd_per_prio per_prio[DD_PRIO_COUNT];
>  
>  	/* Data direction of latest dispatched request. */
> @@ -120,6 +124,9 @@ static const enum dd_prio ioprio_class_to_prio[] = {
>  	[IOPRIO_CLASS_IDLE]	= DD_IDLE_PRIO,
>  };
>  
> +static void dd_insert_request(struct request_queue *q, struct request *rq,
> +			      blk_insert_t flags, struct list_head *free);
> +
>  static inline struct rb_root *
>  deadline_rb_root(struct dd_per_prio *per_prio, struct request *rq)
>  {
> @@ -592,6 +599,35 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
>  	return NULL;
>  }
>  
> +static void __dd_do_insert(struct request_queue *q, blk_insert_t flags,
> +			   struct list_head *list, struct list_head *free)
> +{
> +	while (!list_empty(list)) {
> +		struct request *rq;
> +
> +		rq = list_first_entry(list, struct request, queuelist);
> +		list_del_init(&rq->queuelist);
> +		dd_insert_request(q, rq, flags, free);
> +	}
> +}
> +
> +static void dd_do_insert(struct request_queue *q, struct list_head *free)
> +{
> +	struct deadline_data *dd = q->elevator->elevator_data;
> +	LIST_HEAD(at_head);
> +	LIST_HEAD(at_tail);
> +
> +	lockdep_assert_held(&dd->lock);
> +
> +	spin_lock(&dd->insert_lock);
> +	list_splice_init(&dd->at_head, &at_head);
> +	list_splice_init(&dd->at_tail, &at_tail);
> +	spin_unlock(&dd->insert_lock);
> +
> +	__dd_do_insert(q, BLK_MQ_INSERT_AT_HEAD, &at_head, free);
> +	__dd_do_insert(q, 0, &at_tail, free);
> +}
> +
>  /*
>   * Called from blk_mq_run_hw_queue() -> __blk_mq_sched_dispatch_requests().
>   *
> @@ -606,6 +642,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	const unsigned long now = jiffies;
>  	struct request *rq;
>  	enum dd_prio prio;
> +	LIST_HEAD(free);
>  
>  	/*
>  	 * If someone else is already dispatching, skip this one. This will
> @@ -620,6 +657,11 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  		return NULL;
>  
>  	spin_lock(&dd->lock);
> +        /*
> +         * Request insertion happens from inside the dispatch callback instead
> +         * of inside the insert callback to minimize contention on dd->lock.
> +         */
> +	dd_do_insert(hctx->queue, &free);
>  	rq = dd_dispatch_prio_aged_requests(dd, now);
>  	if (rq)
>  		goto unlock;
> @@ -638,6 +680,8 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	clear_bit(DD_DISPATCHING, &dd->run_state);
>  	spin_unlock(&dd->lock);
>  
> +	blk_mq_free_requests(&free);
> +
>  	return rq;
>  }
>  
> @@ -727,8 +771,12 @@ static int dd_init_sched(struct request_queue *q, struct elevator_type *e)
>  	eq->elevator_data = dd;
>  
>  	spin_lock_init(&dd->lock);
> +	spin_lock_init(&dd->insert_lock);
>  	spin_lock_init(&dd->zone_lock);
>  
> +	INIT_LIST_HEAD(&dd->at_head);
> +	INIT_LIST_HEAD(&dd->at_tail);
> +
>  	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
>  		struct dd_per_prio *per_prio = &dd->per_prio[prio];
>  
> @@ -899,19 +947,13 @@ static void dd_insert_requests(struct blk_mq_hw_ctx *hctx,
>  {
>  	struct request_queue *q = hctx->queue;
>  	struct deadline_data *dd = q->elevator->elevator_data;
> -	LIST_HEAD(free);
> -
> -	spin_lock(&dd->lock);
> -	while (!list_empty(list)) {
> -		struct request *rq;
>  
> -		rq = list_first_entry(list, struct request, queuelist);
> -		list_del_init(&rq->queuelist);
> -		dd_insert_request(q, rq, flags, &free);
> -	}
> -	spin_unlock(&dd->lock);
> -
> -	blk_mq_free_requests(&free);
> +	spin_lock(&dd->insert_lock);
> +	if (flags & BLK_MQ_INSERT_AT_HEAD)
> +		list_splice_init(list, &dd->at_head);
> +	else
> +		list_splice_init(list, &dd->at_tail);
> +	spin_unlock(&dd->insert_lock);
>  }
>  
>  /* Callback from inside blk_mq_rq_ctx_init(). */
> @@ -990,6 +1032,10 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
>  	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
>  	enum dd_prio prio;
>  
> +	if (!list_empty_careful(&dd->at_head) ||
> +	    !list_empty_careful(&dd->at_tail))
> +		return true;
> +
>  	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
>  		if (dd_has_work_for_prio(&dd->per_prio[prio]))
>  			return true;

-- 
Damien Le Moal
Western Digital Research

