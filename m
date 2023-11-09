Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02E9DF6A
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pC+MYQ0q"
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B42271F
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 23:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3TbkP6dPgG5rg1ywx3LROqX2NH5sWqW+beHjo4sUY+8=; b=pC+MYQ0q8CtnIJnrToXKam9cwQ
	R9vFpPVWTQQFk9swJiA+B8rzHL+QXMA7JSq1zprZUeSSEg8/CarNDW73Co3Avg8qVI31U3KgBBQSv
	QvsPCyKqId5woXXyYf57TsTkbhlKk5JNdpI8tWzu7MyS/tI5ZTEhJZcmp01mblizOzB/rJ7zYVG0I
	SVfslDuV9YPTtOUhQ+S6tXrPDFbaB2K8DZKMXM6Icgdo1kCWIId4QRibmHvmKEEjzeDzj1hgk0P2W
	AsH7w8qQ7zqC4piEEjJkvOJl0TbCLS077fC7CRwRM0Gfv/Mi5CasmSLquLqQHdRDYLj0kHLiJ3fEG
	E/rLt6bA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r0zUQ-005VSI-0I;
	Thu, 09 Nov 2023 07:30:10 +0000
Date: Wed, 8 Nov 2023 23:30:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] blk-mq: make sure active queue usage is held for
 bio_integrity_prep()
Message-ID: <ZUyKggKLWnaZMRr7@infradead.org>
References: <20231108080504.2144952-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108080504.2144952-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

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

For clarity splitting this out might be a bit more readable.

> +static inline struct request *blk_mq_cached_req(const struct request_queue *q,
> +		const struct blk_plug *plug)
> +{
> +	if (plug) {
> +		struct request *rq = rq_list_peek(&plug->cached_rq);
> +
> +		if (rq && rq->q == q)
> +			return rq;
> +	}
> +	return NULL;
> +}

Not sure this helper adds much value over just open coding it.

> +/* return true if this bio needs to handle by allocating new request */
> +static inline bool blk_mq_try_cached_rq(struct request *rq,
>  		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)

The polarity here is a bit weird, I'd expect a true return if the
request can be used and a naming implying that.

> +	rq = blk_mq_cached_req(q, plug);
> +	if (rq) {
> +		/* cached request held queue usage counter */
> +		if (!bio_integrity_prep(bio))
> +			return;
> +
> +		need_alloc = blk_mq_try_cached_rq(rq, plug, &bio, nr_segs);
>  		if (!bio)
>  			return;

If you take the blk_mq_attempt_bio_merge merge out of the helper,
the calling convention becomes much saner.

> +			/* cached request held queue usage counter */
> +			percpu_ref_get(&q->q_usage_counter);

I don't think we can just do the percpu_ref_get here.  While getting
the counter obviosuly can't fail, we still need to do the queue
pm only check.

Below is the untested version of how I'd do this that I hacked while
reviewing it:

---
commit 1134ce39504c30a9804ed8147027e66bf7d3157e
Author: Ming Lei <ming.lei@redhat.com>
Date:   Wed Nov 8 16:05:04 2023 +0800

    blk-mq: make sure active queue usage is held for bio_integrity_prep()
    
    blk_integrity_unregister() can come if queue usage counter isn't held
    for one bio with integrity prepared, so this request may be completed with
    calling profile->complete_fn, then kernel panic.
    
    Another constraint is that bio_integrity_prep() needs to be called
    before bio merge.
    
    Fix the issue by:
    
    - call bio_integrity_prep() with one queue usage counter grabbed reliably
    
    - call bio_integrity_prep() before bio merge
    
    Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
    Reported-by: Yi Zhang <yi.zhang@redhat.com>
    Signed-off-by: Ming Lei <ming.lei@redhat.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e37..b758dc8ed10957 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2858,11 +2858,8 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	};
 	struct request *rq;
 
-	if (unlikely(bio_queue_enter(bio)))
-		return NULL;
-
 	if (blk_mq_attempt_bio_merge(q, bio, nsegs))
-		goto queue_exit;
+		return NULL;
 
 	rq_qos_throttle(q, bio);
 
@@ -2878,35 +2875,24 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-queue_exit:
-	blk_queue_exit(q);
 	return NULL;
 }
 
-static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
-		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
+/* return true if this @rq can be used for @bio */
+static bool blk_mq_can_use_cached_rq(struct request *rq, struct blk_plug *plug,
+		struct bio *bio)
 {
-	struct request *rq;
-	enum hctx_type type, hctx_type;
+	struct request_queue *q = rq->q;
+	enum hctx_type type = blk_mq_get_hctx_type(bio->bi_opf);
+	enum hctx_type hctx_type = rq->mq_hctx->type;
 
-	if (!plug)
-		return NULL;
-	rq = rq_list_peek(&plug->cached_rq);
-	if (!rq || rq->q != q)
-		return NULL;
+	WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) != rq);
 
-	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
-		*bio = NULL;
-		return NULL;
-	}
-
-	type = blk_mq_get_hctx_type((*bio)->bi_opf);
-	hctx_type = rq->mq_hctx->type;
 	if (type != hctx_type &&
 	    !(type == HCTX_TYPE_READ && hctx_type == HCTX_TYPE_DEFAULT))
-		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
-		return NULL;
+		return false;
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
+		return false;
 
 	/*
 	 * If any qos ->throttle() end up blocking, we will have flushed the
@@ -2914,12 +2900,12 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	 * before we throttle.
 	 */
 	plug->cached_rq = rq_list_next(rq);
-	rq_qos_throttle(q, *bio);
+	rq_qos_throttle(q, bio);
 
 	blk_mq_rq_time_init(rq, 0);
-	rq->cmd_flags = (*bio)->bi_opf;
+	rq->cmd_flags = bio->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
-	return rq;
+	return true;
 }
 
 static void bio_set_ioprio(struct bio *bio)
@@ -2949,7 +2935,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug = blk_mq_plug(bio);
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
+	struct request *rq = NULL;
 	unsigned int nr_segs = 1;
 	blk_status_t ret;
 
@@ -2960,20 +2946,39 @@ void blk_mq_submit_bio(struct bio *bio)
 			return;
 	}
 
-	if (!bio_integrity_prep(bio))
-		return;
-
 	bio_set_ioprio(bio);
 
-	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
-	if (!rq) {
-		if (!bio)
+	if (plug) {
+		rq = rq_list_peek(&plug->cached_rq);
+		if (rq && rq->q != q)
+			rq = NULL;
+	}
+	if (rq) {
+		/* rq already holds a q_usage_counter reference */
+		if (!bio_integrity_prep(bio))
 			return;
-		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
-		if (unlikely(!rq))
+		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
+			return;
+
+		if (blk_mq_can_use_cached_rq(rq, plug, bio))
+			goto done;
+
+		percpu_ref_get(&q->q_usage_counter);
+	} else {
+		if (unlikely(bio_queue_enter(bio)))
+			return;
+
+		if (!bio_integrity_prep(bio))
 			return;
 	}
 
+	rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+	if (unlikely(!rq)) {
+		blk_queue_exit(q);
+		return;
+	}
+
+done:
 	trace_block_getrq(bio);
 
 	rq_qos_track(q, rq, bio);
