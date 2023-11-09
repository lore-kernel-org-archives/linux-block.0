Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C910780
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDsTWPqn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E907F2D4D
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 00:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699517533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j6QylvBKLX8Nox/07sPwm031i3TxtpfBWAFKMpq4CjU=;
	b=CDsTWPqnpsgFwJ3RYfyofdr6ErzbiCxD1/QnrwBnHkK7eocbNDuJ5kSkW6RtGSL3Vg+bgK
	WOUijV9VZ48zg5gQm3MNX751UUKJVy6zfop7CWuPWXmBtzsVD93HdN2YZ/HP9vfHgSAl92
	jhaIC272W8ZyAHL6tuspsDc8o0DUvrs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-xny7o6JYMTq7lVYk2-a0Fw-1; Thu, 09 Nov 2023 03:12:09 -0500
X-MC-Unique: xny7o6JYMTq7lVYk2-a0Fw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94FAC811E7E;
	Thu,  9 Nov 2023 08:12:09 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 37F46492BFC;
	Thu,  9 Nov 2023 08:12:02 +0000 (UTC)
Date: Thu, 9 Nov 2023 16:11:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: make sure active queue usage is held for
 bio_integrity_prep()
Message-ID: <ZUyUSBrp+K5pPLPy@fedora>
References: <20231108080504.2144952-1-ming.lei@redhat.com>
 <ZUyKggKLWnaZMRr7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUyKggKLWnaZMRr7@infradead.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Wed, Nov 08, 2023 at 11:30:10PM -0800, Christoph Hellwig wrote:
> > +++ b/block/blk-mq.c
> > @@ -2858,11 +2858,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
> >  	};
> >  	struct request *rq;
> >  
> > -	if (unlikely(bio_queue_enter(bio)))
> > -		return NULL;
> > -
> >  	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
> > -		goto queue_exit;
> > +		return NULL;
> >  
> >  	rq_qos_throttle(q, bio);
> 
> For clarity splitting this out might be a bit more readable.

I'd rather not do too many things in single fix, which need backport,
but I am fine to do it in following cleanup.

> 
> > +static inline struct request *blk_mq_cached_req(const struct request_queue *q,
> > +		const struct blk_plug *plug)
> > +{
> > +	if (plug) {
> > +		struct request *rq = rq_list_peek(&plug->cached_rq);
> > +
> > +		if (rq && rq->q == q)
> > +			return rq;
> > +	}
> > +	return NULL;
> > +}
> 
> Not sure this helper adds much value over just open coding it.

I am fine with either way, but the function name actually
has document benefit.

> 
> > +/* return true if this bio needs to handle by allocating new request */
> > +static inline bool blk_mq_try_cached_rq(struct request *rq,
> >  		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
> 
> The polarity here is a bit weird, I'd expect a true return if the
> request can be used and a naming implying that.

Fine, my original local version actually returns false if cached req can
be used, and it is changed just for not checking
!blk_mq_try_cached_rq().

> 
> > +	rq = blk_mq_cached_req(q, plug);
> > +	if (rq) {
> > +		/* cached request held queue usage counter */
> > +		if (!bio_integrity_prep(bio))
> > +			return;
> > +
> > +		need_alloc = blk_mq_try_cached_rq(rq, plug, &bio, nr_segs);
> >  		if (!bio)
> >  			return;
> 
> If you take the blk_mq_attempt_bio_merge merge out of the helper,
> the calling convention becomes much saner.

IMO we shouldn't mix cleanup with fix and it is friendly to take
stable backport into account.

> 
> > +			/* cached request held queue usage counter */
> > +			percpu_ref_get(&q->q_usage_counter);
> 
> I don't think we can just do the percpu_ref_get here.  While getting
> the counter obviosuly can't fail, we still need to do the queue
> pm only check.

blk_pre_runtime_suspend() can't succeed if any active queue usage
counter is held, so it is fine to call percpu_ref_get() here.

> 
> Below is the untested version of how I'd do this that I hacked while
> reviewing it:
> 
> ---
> commit 1134ce39504c30a9804ed8147027e66bf7d3157e
> Author: Ming Lei <ming.lei@redhat.com>
> Date:   Wed Nov 8 16:05:04 2023 +0800
> 
>     blk-mq: make sure active queue usage is held for bio_integrity_prep()
>     
>     blk_integrity_unregister() can come if queue usage counter isn't held
>     for one bio with integrity prepared, so this request may be completed with
>     calling profile->complete_fn, then kernel panic.
>     
>     Another constraint is that bio_integrity_prep() needs to be called
>     before bio merge.
>     
>     Fix the issue by:
>     
>     - call bio_integrity_prep() with one queue usage counter grabbed reliably
>     
>     - call bio_integrity_prep() before bio merge
>     
>     Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
>     Reported-by: Yi Zhang <yi.zhang@redhat.com>
>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e2d11183f62e37..b758dc8ed10957 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2858,11 +2858,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	};
>  	struct request *rq;
>  
> -	if (unlikely(bio_queue_enter(bio)))
> -		return NULL;
> -
>  	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
> -		goto queue_exit;
> +		return NULL;
>  
>  	rq_qos_throttle(q, bio);
>  
> @@ -2878,35 +2875,24 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>  	rq_qos_cleanup(q, bio);
>  	if (bio->bi_opf & REQ_NOWAIT)
>  		bio_wouldblock_error(bio);
> -queue_exit:
> -	blk_queue_exit(q);
>  	return NULL;
>  }
>  
> -static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
> -		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
> +/* return true if this @rq can be used for @bio */
> +static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
> +		struct bio *bio)

Switching to "*bio" is in my todo cleanup list too, and I will make it
standalone patch.

>  {
> -	struct request *rq;
> -	enum hctx_type type, hctx_type;
> +	struct request_queue *q = rq->q;
> +	enum hctx_type type = blk_mq_get_hctx_type(bio->bi_opf);
> +	enum hctx_type hctx_type = rq->mq_hctx->type;
>  
> -	if (!plug)
> -		return NULL;
> -	rq = rq_list_peek(&plug->cached_rq);
> -	if (!rq || rq->q != q)
> -		return NULL;
> +	WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) != rq);
>  
> -	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
> -		*bio = NULL;
> -		return NULL;
> -	}
> -
> -	type = blk_mq_get_hctx_type((*bio)->bi_opf);
> -	hctx_type = rq->mq_hctx->type;
>  	if (type != hctx_type &&
>  	    !(type == HCTX_TYPE_READ && hctx_type == HCTX_TYPE_DEFAULT))
> -		return NULL;
> -	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
> -		return NULL;
> +		return false;
> +	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
> +		return false;
>  
>  	/*
>  	 * If any qos ->throttle() end up blocking, we will have flushed the
> @@ -2914,12 +2900,12 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>  	 * before we throttle.
>  	 */
>  	plug->cached_rq = rq_list_next(rq);
> -	rq_qos_throttle(q, *bio);
> +	rq_qos_throttle(q, bio);
>  
>  	blk_mq_rq_time_init(rq, 0);
> -	rq->cmd_flags = (*bio)->bi_opf;
> +	rq->cmd_flags = bio->bi_opf;
>  	INIT_LIST_HEAD(&rq->queuelist);
> -	return rq;
> +	return true;
>  }
>  
>  static void bio_set_ioprio(struct bio *bio)
> @@ -2949,7 +2935,7 @@ void blk_mq_submit_bio(struct bio *bio)
>  	struct blk_plug *plug = blk_mq_plug(bio);
>  	const int is_sync = op_is_sync(bio->bi_opf);
>  	struct blk_mq_hw_ctx *hctx;
> -	struct request *rq;
> +	struct request *rq = NULL;
>  	unsigned int nr_segs = 1;
>  	blk_status_t ret;
>  
> @@ -2960,20 +2946,39 @@ void blk_mq_submit_bio(struct bio *bio)
>  			return;
>  	}
>  
> -	if (!bio_integrity_prep(bio))
> -		return;
> -
>  	bio_set_ioprio(bio);
>  
> -	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
> -	if (!rq) {
> -		if (!bio)
> +	if (plug) {
> +		rq = rq_list_peek(&plug->cached_rq);
> +		if (rq && rq->q != q)
> +			rq = NULL;
> +	}
> +	if (rq) {
> +		/* rq already holds a q_usage_counter reference */
> +		if (!bio_integrity_prep(bio))
>  			return;
> -		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
> -		if (unlikely(!rq))
> +		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
> +			return;
> +
> +		if (blk_mq_can_use_cached_rq(rq, plug, bio))
> +			goto done;
> +
> +		percpu_ref_get(&q->q_usage_counter);
> +	} else {
> +		if (unlikely(bio_queue_enter(bio)))
> +			return;
> +
> +		if (!bio_integrity_prep(bio))
>  			return;

blk_queue_exit() is needed if bio_integrity_prep() fails.

I will try to make one easy fix first, then follows cleanup.

Thanks, 
Ming

