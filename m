Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5A97261A
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 06:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750659022; cv=none; b=J/i5RaCyeY31kUcZzc/nP8hZELtqf3IzTtbfrmQFhLAVhcO6UAVoDhcU6UkMfCkyGsc3L0UWoZC/xbKrVL5fDZZA/kdz+R/F80+PqJiUZ4VYNPO9cDv7QGkNdOYZwNIsKHGvVnyeLOAOnI8mH17nfyEIh0yVwHjxaViiLU7Bpxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750659022; c=relaxed/simple;
	bh=ZLIOX+FOkQSmH5CkFuGG+QZwBy4IrSkzLrHQLLTHMRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL90iathxmpuZ268TENYdp9s5JItBO6LjBjGqEGSzOOeuiN63rw3n/UOXO8sjeidB+tgyHoNNFfvKV6035evslj6E4ldMw4u6evJzTyKgfoYA9bXwffu8Cn/WTQgo1jimnChFw8gilP06v9mn4vMeF1oPkuvfIeAjM8SwDAbYsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E896168AFE; Mon, 23 Jun 2025 08:10:15 +0200 (CEST)
Date: Mon, 23 Jun 2025 08:10:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, hch@lst.de,
	axboe@kernel.dk, sth@linux.ibm.com, gjoyce@ibm.com
Subject: Re: [PATCHv3 2/2] block: fix lock dependency between percpu alloc
 lock and elevator lock
Message-ID: <20250623061015.GA30266@lst.de>
References: <20250616173233.3803824-1-nilay@linux.ibm.com> <20250616173233.3803824-3-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616173233.3803824-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 16, 2025 at 11:02:26PM +0530, Nilay Shroff wrote:
> +static void blk_mq_init_sched_tags(struct request_queue *q,
> +				   struct blk_mq_hw_ctx *hctx,
> +				   unsigned int hctx_idx,
> +				   struct elevator_queue *eq)
>  {
>  	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
>  		hctx->sched_tags = q->sched_shared_tags;
> +		return;
>  	}
>  
> +	hctx->sched_tags = eq->tags->u.tags[hctx_idx];
>  }

Given how trivial this function now is, please inline it in the only
caller.  That should also allow moving the blk_mq_is_shared_tags
shared out of the loop over all hw contexts, and merge it with the
check right next to it.

> +static void blk_mq_init_sched_shared_tags(struct request_queue *queue,
> +		struct elevator_queue *eq)
>  {
> +	queue->sched_shared_tags = eq->tags->u.shared_tags;
>  	blk_mq_tag_update_sched_shared_tags(queue);
>  }

This helper can also just be open coded in the caller now.

> +	if (blk_mq_is_shared_tags(set->flags)) {
> +		if (tags->u.shared_tags) {
> +			blk_mq_free_rqs(set, tags->u.shared_tags,
> +					BLK_MQ_NO_HCTX_IDX);
> +			blk_mq_free_rq_map(tags->u.shared_tags);
> +		}
> +		goto out;
> +	}
> +
> +	if (!tags->u.tags)
> +		goto out;
> +
> +	for (i = 0; i < tags->nr_hw_queues; i++) {
> +		if (tags->u.tags[i]) {
> +			blk_mq_free_rqs(set, tags->u.tags[i], i);
> +			blk_mq_free_rq_map(tags->u.tags[i]);
> +		}
> +	}

Maybe restructucture this a bit:

	if (blk_mq_is_shared_tags(set->flags)) {
		..
	} else if (tags->u.tags) {
	}

	kfree(tags);

to have a simpler flow and remove the need for the "goto out"?

> +	tags = kcalloc(1, sizeof(struct elevator_tags), gfp);

This can use plain kzalloc.

> +	if (blk_mq_is_shared_tags(set->flags)) {
> +
> +		tags->u.shared_tags = blk_mq_alloc_map_and_rqs(set,

The empty line above is a bit odd.

> +					BLK_MQ_NO_HCTX_IDX,
> +					MAX_SCHED_RQ);
> +		if (!tags->u.shared_tags)
> +			goto out;
> +
> +		return tags;
> +	}
> +
> +	tags->u.tags = kcalloc(nr_hw_queues, sizeof(struct blk_mq_tags *), gfp);
> +	if (!tags->u.tags)
> +		goto out;
> +
> +	tags->nr_hw_queues = nr_hw_queues;
> +	for (i = 0; i < nr_hw_queues; i++) {
> +		tags->u.tags[i] = blk_mq_alloc_map_and_rqs(set, i,
> +				tags->nr_requests);
> +		if (!tags->u.tags[i])
> +			goto out;
> +	}
> +
> +	return tags;
> +
> +out:
> +	__blk_mq_free_sched_tags(set, tags);

Is __blk_mq_free_sched_tags really the right thing here vs just unwinding
what this function did?

> +	/*
> +	 * Accessing q->elevator without holding q->elevator_lock is safe
> +	 * because we're holding here set->update_nr_hwq_lock in the writer
> +	 * context. So, scheduler update/switch code (which acquires the same
> +	 * lock but in the reader context) can't run concurrently.
> +	 */
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (q->elevator)
> +			count++;
> +	}

Maybe add a helper for this code and the comment?

> -	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
> +	lockdep_assert_held(&set->update_nr_hwq_lock);
> +
> +	if (strncmp(ctx->name, "none", 4)) {

This is a check for not having an elevator so far, right?  Wouldn't
!q->elevator be the more obvious check for that?  Or am I missing
something why that's not safe here?

> diff --git a/block/elevator.h b/block/elevator.h
> index a4de5f9ad790..0b92121005cf 100644
> --- a/block/elevator.h
> +++ b/block/elevator.h
> @@ -23,6 +23,17 @@ enum elv_merge {
>  struct blk_mq_alloc_data;
>  struct blk_mq_hw_ctx;
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

No need to move this, it is still only used in elevator.c.

>  extern struct elevator_queue *elevator_alloc(struct request_queue *,
> -					struct elevator_type *);
> +		struct elevator_type *, struct elevator_tags *);

Drop the extern while you're at it.

