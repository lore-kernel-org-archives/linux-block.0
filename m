Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40261624E1
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784215; cv=none; b=b7OdeFQWAM2ReMlSbrXkZcWYmANevy8pEPO+xBYw2okXyB+MLKl5+LSHt/tUhHBltquCYuUhtk0hvoitAL35aOD8a8gFBMlDswuCEK3YRcE+wkyCu8ivInxj3jWJtUI3m5zfD4VPyMQWj2bjY8gD04YpyWz++NkGZmx0qKrpw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784215; c=relaxed/simple;
	bh=xElxQ5puQJFTTINIjRXYJq3D+WGt+7tbh1FN4iFIX6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuxIXDgVdPN0006CH4IFziIMHdx1L+Bl3/OXF0j1ys03pz3cuA8GyM6BmL3LQmvmMwb8JgjEysfJ5wXcjqvyL5BeCyITinxA8Y6NC83KDc/zQwFpeMmje/b/FusRTdg5tBjKGsup8qNAJIiqixnbcHKhEfCXXhQbOhrzQPH5FTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VJtr3Kxs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HaNrvSDI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZB0oNNi9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MzF+ilWB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VJtr3Kxs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HaNrvSDI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZB0oNNi9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MzF+ilWB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D04091F80D;
	Tue, 29 Jul 2025 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753784211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugx6lDwYiDI3+wBxQFwOQtjjnepeEoUkCI5Yq12M4MM=;
	b=VJtr3KxslqXb/fKNsAweLjkwE7yMykWjtKO6vSqpRufqxf9naG2hmH39caVDI9Nnd8TbTi
	OZwzke+ttCW+wWdZBePfG+SiXp4E++zdbW4cakWRsdE7fDjEtGgjsLsmLh5d3Og2R6EsGk
	PF/LgkVhroNEiS/2FKZQx/ZeyWueMao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753784211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugx6lDwYiDI3+wBxQFwOQtjjnepeEoUkCI5Yq12M4MM=;
	b=HaNrvSDIO9ic5qD16JtlYTfq60JnqQqQlGWe2EQysIOK5wk80j05Qck8z275udtXcFjVqy
	jMoqLNlNhn8qXTCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753784210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugx6lDwYiDI3+wBxQFwOQtjjnepeEoUkCI5Yq12M4MM=;
	b=ZB0oNNi9FJhZLOBuBLLQi18J3CmxcxRCP8kcuIaoei4/RNdQSbg+ARBJZ6ntkR0zXy6ncN
	xTU/yL4yZK4e4MIuJFohh1afQoADT+JrMTKfY3R6/uLZe4GXY5damMeQ3HciHmWQmuw+lj
	msn3QtOmJk+bMwG+LrfSBLAXC1O9Ir4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753784210;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ugx6lDwYiDI3+wBxQFwOQtjjnepeEoUkCI5Yq12M4MM=;
	b=MzF+ilWBZPvrt2GYZuUsVYPmwZbgQ4l8aC7m4Dwy0eJzLGCy5LnvH+1u8klwWyCbyAYlZU
	AMI8Vj8FGFABkCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A95B813A73;
	Tue, 29 Jul 2025 10:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mbIHKZKfiGiwXwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Jul 2025 10:16:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4401FA09DE; Tue, 29 Jul 2025 12:16:50 +0200 (CEST)
Date: Tue, 29 Jul 2025 12:16:50 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, axboe@kernel.dk, akpm@linux-foundation.org, 
	yang.yang@vivo.com, dlemoal@kernel.org, ming.lei@redhat.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai3@huawei.com, 
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com, 
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
Message-ID: <ozjsdoiqa2uem65qqj4fjbrwm6toxlj5bzv7f5dg5xfiljv3zi@wcaamboo2r6h>
References: <20250729031906.3615228-1-yukuai1@huaweicloud.com>
 <20250729031906.3615228-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729031906.3615228-2-yukuai1@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 29-07-25 11:19:05, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently elevators will record internal 'async_depth' to throttle
> asynchronous requests, and they both calculate shallow_dpeth based on
> sb->shift, with the respect that sb->shift is the available tags in one
> word.
> 
> However, sb->shift is not the availbale tags in the last word, see
> __map_depth:
> 
> if (index == sb->map_nr - 1)
>   return sb->depth - (index << sb->shift);
> 
> For consequence, if the last word is used, more tags can be get than
> expected, for example, assume nr_requests=256 and there are four words,
> in the worst case if user set nr_requests=32, then the first word is
> the last word, and still use bits per word, which is 64, to calculate
> async_depth is wrong.
> 
> One the other hand, due to cgroup qos, bfq can allow only one request
> to be allocated, and set shallow_dpeth=1 will still allow the number
> of words request to be allocated.
> 
> Fix this problems by using shallow_depth to the whole sbitmap instead
> of per word, also change kyber, mq-deadline and bfq to follow this.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I agree with these problems but AFAIU this implementation of shallow depth
has been done for a reason. Omar can chime in here as the original author
or perhaps Jens but the idea of current shallow depth implementation is
that each sbitmap user regardless of used shallow depth has a chance to
allocate from each sbitmap word which evenly distributes pressure among
available sbitmap words. With the implementation you've chosen there will
be higher pressure (and thus contention) on words with low indices.

So I think we would be good to fix issues with shallow depth for small
number of sbitmap words (because that's where these buggy cornercases may
matter in practice) but I believe the logic which constrains number of used
bits from each *word* when shallow_depth is specified should be kept.  It
might make sense to change the API so that shallow_depth is indeed
specified compared to the total size of the bitmap, not to the size of the
word (because that's confusing practically everybody I've met and is a
constant source of bugs) if it can be made to perform well.

								Honza

> ---
>  block/bfq-iosched.c     | 35 ++++++++++++--------------
>  block/bfq-iosched.h     |  3 +--
>  block/kyber-iosched.c   |  9 ++-----
>  block/mq-deadline.c     | 16 +-----------
>  include/linux/sbitmap.h |  6 ++---
>  lib/sbitmap.c           | 55 +++++++++++++++++++++--------------------
>  6 files changed, 51 insertions(+), 73 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index f71ec0887733..a6a574a8eac9 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -694,17 +694,13 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>  {
>  	struct bfq_data *bfqd = data->q->elevator->elevator_data;
>  	struct bfq_io_cq *bic = bfq_bic_lookup(data->q);
> -	int depth;
> -	unsigned limit = data->q->nr_requests;
> -	unsigned int act_idx;
> +	unsigned int limit, act_idx;
>  
>  	/* Sync reads have full depth available */
> -	if (op_is_sync(opf) && !op_is_write(opf)) {
> -		depth = 0;
> -	} else {
> -		depth = bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
> -		limit = (limit * depth) >> bfqd->full_depth_shift;
> -	}
> +	if (op_is_sync(opf) && !op_is_write(opf))
> +		limit = data->q->nr_requests;
> +	else
> +		limit = bfqd->async_depths[!!bfqd->wr_busy_queues][op_is_sync(opf)];
>  
>  	for (act_idx = 0; bic && act_idx < bfqd->num_actuators; act_idx++) {
>  		/* Fast path to check if bfqq is already allocated. */
> @@ -718,14 +714,16 @@ static void bfq_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>  		 * available requests and thus starve other entities.
>  		 */
>  		if (bfqq_request_over_limit(bfqd, bic, opf, act_idx, limit)) {
> -			depth = 1;
> +			limit = 1;
>  			break;
>  		}
>  	}
> +
>  	bfq_log(bfqd, "[%s] wr_busy %d sync %d depth %u",
> -		__func__, bfqd->wr_busy_queues, op_is_sync(opf), depth);
> -	if (depth)
> -		data->shallow_depth = depth;
> +		__func__, bfqd->wr_busy_queues, op_is_sync(opf), limit);
> +
> +	if (limit < data->q->nr_requests)
> +		data->shallow_depth = limit;
>  }
>  
>  static struct bfq_queue *
> @@ -7114,9 +7112,8 @@ void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
>   */
>  static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>  {
> -	unsigned int depth = 1U << bt->sb.shift;
> +	unsigned int nr_requests = bfqd->queue->nr_requests;
>  
> -	bfqd->full_depth_shift = bt->sb.shift;
>  	/*
>  	 * In-word depths if no bfq_queue is being weight-raised:
>  	 * leaving 25% of tags only for sync reads.
> @@ -7128,13 +7125,13 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>  	 * limit 'something'.
>  	 */
>  	/* no more than 50% of tags for async I/O */
> -	bfqd->word_depths[0][0] = max(depth >> 1, 1U);
> +	bfqd->async_depths[0][0] = max(nr_requests >> 1, 1U);
>  	/*
>  	 * no more than 75% of tags for sync writes (25% extra tags
>  	 * w.r.t. async I/O, to prevent async I/O from starving sync
>  	 * writes)
>  	 */
> -	bfqd->word_depths[0][1] = max((depth * 3) >> 2, 1U);
> +	bfqd->async_depths[0][1] = max((nr_requests * 3) >> 2, 1U);
>  
>  	/*
>  	 * In-word depths in case some bfq_queue is being weight-
> @@ -7144,9 +7141,9 @@ static void bfq_update_depths(struct bfq_data *bfqd, struct sbitmap_queue *bt)
>  	 * shortage.
>  	 */
>  	/* no more than ~18% of tags for async I/O */
> -	bfqd->word_depths[1][0] = max((depth * 3) >> 4, 1U);
> +	bfqd->async_depths[1][0] = max((nr_requests * 3) >> 4, 1U);
>  	/* no more than ~37% of tags for sync writes (~20% extra tags) */
> -	bfqd->word_depths[1][1] = max((depth * 6) >> 4, 1U);
> +	bfqd->async_depths[1][1] = max((nr_requests * 6) >> 4, 1U);
>  }
>  
>  static void bfq_depth_updated(struct blk_mq_hw_ctx *hctx)
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 687a3a7ba784..31217f196f4f 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -813,8 +813,7 @@ struct bfq_data {
>  	 * Depth limits used in bfq_limit_depth (see comments on the
>  	 * function)
>  	 */
> -	unsigned int word_depths[2][2];
> -	unsigned int full_depth_shift;
> +	unsigned int async_depths[2][2];
>  
>  	/*
>  	 * Number of independent actuators. This is equal to 1 in
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> index 4dba8405bd01..bfd9a40bb33d 100644
> --- a/block/kyber-iosched.c
> +++ b/block/kyber-iosched.c
> @@ -157,10 +157,7 @@ struct kyber_queue_data {
>  	 */
>  	struct sbitmap_queue domain_tokens[KYBER_NUM_DOMAINS];
>  
> -	/*
> -	 * Async request percentage, converted to per-word depth for
> -	 * sbitmap_get_shallow().
> -	 */
> +	/* Number of allowed async requests. */
>  	unsigned int async_depth;
>  
>  	struct kyber_cpu_latency __percpu *cpu_latency;
> @@ -454,10 +451,8 @@ static void kyber_depth_updated(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct kyber_queue_data *kqd = hctx->queue->elevator->elevator_data;
>  	struct blk_mq_tags *tags = hctx->sched_tags;
> -	unsigned int shift = tags->bitmap_tags.sb.shift;
> -
> -	kqd->async_depth = (1U << shift) * KYBER_ASYNC_PERCENT / 100U;
>  
> +	kqd->async_depth = hctx->queue->nr_requests * KYBER_ASYNC_PERCENT / 100U;
>  	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, kqd->async_depth);
>  }
>  
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 2edf1cac06d5..9ab6c6256695 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -487,20 +487,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>  	return rq;
>  }
>  
> -/*
> - * 'depth' is a number in the range 1..INT_MAX representing a number of
> - * requests. Scale it with a factor (1 << bt->sb.shift) / q->nr_requests since
> - * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow().
> - * Values larger than q->nr_requests have the same effect as q->nr_requests.
> - */
> -static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int qdepth)
> -{
> -	struct sbitmap_queue *bt = &hctx->sched_tags->bitmap_tags;
> -	const unsigned int nrr = hctx->queue->nr_requests;
> -
> -	return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
> -}
> -
>  /*
>   * Called by __blk_mq_alloc_request(). The shallow_depth value set by this
>   * function is used by __blk_mq_get_tag().
> @@ -517,7 +503,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_mq_alloc_data *data)
>  	 * Throttle asynchronous requests and writes such that these requests
>  	 * do not block the allocation of synchronous requests.
>  	 */
> -	data->shallow_depth = dd_to_word_depth(data->hctx, dd->async_depth);
> +	data->shallow_depth = dd->async_depth;
>  }
>  
>  /* Called by blk_mq_update_nr_requests(). */
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 189140bf11fc..4adf4b364fcd 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -213,12 +213,12 @@ int sbitmap_get(struct sbitmap *sb);
>   * sbitmap_get_shallow() - Try to allocate a free bit from a &struct sbitmap,
>   * limiting the depth used from each word.
>   * @sb: Bitmap to allocate from.
> - * @shallow_depth: The maximum number of bits to allocate from a single word.
> + * @shallow_depth: The maximum number of bits to allocate from the bitmap.
>   *
>   * This rather specific operation allows for having multiple users with
>   * different allocation limits. E.g., there can be a high-priority class that
>   * uses sbitmap_get() and a low-priority class that uses sbitmap_get_shallow()
> - * with a @shallow_depth of (1 << (@sb->shift - 1)). Then, the low-priority
> + * with a @shallow_depth of (sb->depth >> 1). Then, the low-priority
>   * class can only allocate half of the total bits in the bitmap, preventing it
>   * from starving out the high-priority class.
>   *
> @@ -478,7 +478,7 @@ unsigned long __sbitmap_queue_get_batch(struct sbitmap_queue *sbq, int nr_tags,
>   * sbitmap_queue, limiting the depth used from each word, with preemption
>   * already disabled.
>   * @sbq: Bitmap queue to allocate from.
> - * @shallow_depth: The maximum number of bits to allocate from a single word.
> + * @shallow_depth: The maximum number of bits to allocate from the queue.
>   * See sbitmap_get_shallow().
>   *
>   * If you call this, make sure to call sbitmap_queue_min_shallow_depth() after
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d3412984170c..f2e90ac6b56e 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -208,8 +208,27 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
>  	return nr;
>  }
>  
> +static unsigned int __map_depth_with_shallow(const struct sbitmap *sb,
> +					     int index,
> +					     unsigned int shallow_depth)
> +{
> +	unsigned int lower_bound = 0;
> +
> +	if (shallow_depth >= sb->depth)
> +		return __map_depth(sb, index);
> +
> +	if (index > 0)
> +		lower_bound += (index - 1) << sb->shift;
> +
> +	if (shallow_depth <= lower_bound)
> +		return 0;
> +
> +	return min_t(unsigned int, __map_depth(sb, index),
> +				   shallow_depth - lower_bound);
> +}
> +
>  static int sbitmap_find_bit(struct sbitmap *sb,
> -			    unsigned int depth,
> +			    unsigned int shallow_depth,
>  			    unsigned int index,
>  			    unsigned int alloc_hint,
>  			    bool wrap)
> @@ -218,12 +237,12 @@ static int sbitmap_find_bit(struct sbitmap *sb,
>  	int nr = -1;
>  
>  	for (i = 0; i < sb->map_nr; i++) {
> -		nr = sbitmap_find_bit_in_word(&sb->map[index],
> -					      min_t(unsigned int,
> -						    __map_depth(sb, index),
> -						    depth),
> -					      alloc_hint, wrap);
> +		unsigned int depth = __map_depth_with_shallow(sb, index,
> +							      shallow_depth);
>  
> +		if (depth)
> +			nr = sbitmap_find_bit_in_word(&sb->map[index], depth,
> +						      alloc_hint, wrap);
>  		if (nr != -1) {
>  			nr += index << sb->shift;
>  			break;
> @@ -406,27 +425,9 @@ EXPORT_SYMBOL_GPL(sbitmap_bitmap_show);
>  static unsigned int sbq_calc_wake_batch(struct sbitmap_queue *sbq,
>  					unsigned int depth)
>  {
> -	unsigned int wake_batch;
> -	unsigned int shallow_depth;
> -
> -	/*
> -	 * Each full word of the bitmap has bits_per_word bits, and there might
> -	 * be a partial word. There are depth / bits_per_word full words and
> -	 * depth % bits_per_word bits left over. In bitwise arithmetic:
> -	 *
> -	 * bits_per_word = 1 << shift
> -	 * depth / bits_per_word = depth >> shift
> -	 * depth % bits_per_word = depth & ((1 << shift) - 1)
> -	 *
> -	 * Each word can be limited to sbq->min_shallow_depth bits.
> -	 */
> -	shallow_depth = min(1U << sbq->sb.shift, sbq->min_shallow_depth);
> -	depth = ((depth >> sbq->sb.shift) * shallow_depth +
> -		 min(depth & ((1U << sbq->sb.shift) - 1), shallow_depth));
> -	wake_batch = clamp_t(unsigned int, depth / SBQ_WAIT_QUEUES, 1,
> -			     SBQ_WAKE_BATCH);
> -
> -	return wake_batch;
> +	return clamp_t(unsigned int,
> +		       min(depth, sbq->min_shallow_depth) / SBQ_WAIT_QUEUES,
> +		       1, SBQ_WAKE_BATCH);
>  }
>  
>  int sbitmap_queue_init_node(struct sbitmap_queue *sbq, unsigned int depth,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
