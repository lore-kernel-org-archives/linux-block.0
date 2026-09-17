Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F54DAF85
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654922; cv=none; b=pKldWV1+62TaOayY1jyRkl3kPsgFppeduroR944TPcklgQM5rlVBbkzbxpff/PH8vhTecJKw6fTKgsbdSkia30nClMrEWIgC8/2kRwg5RwDZegpq3sz0dCYATqh5jtZwE8yEWEzVaGqqE9BFYl9tYMf30sw7iuqK3ZArsNr/wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654922; c=relaxed/simple;
	bh=UCQapePIYP1UxPPk8y8L9PYKwD5Jz6DDUMyQcqGwemE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tA6b/hMGEyJ2bMDrfp99YRB1Q5EGJ4rQB55AUuMFZFC2g9z+L9q5BMuTHSH3t7sVXokAW0LzWGO2TOhFJDFdEt+8ZVjBV/R2VLg/xe8fVwVnQPXORdOw785A/EfVLWZTAycFadFYg2AWMLAC1Xep3VWT+QppyPRxBUzr485olHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCYpR4dN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCYpR4dN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A3F1F00893;
	Thu, 17 Sep 2026 14:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654920;
	bh=DwoV0Pv9XYmkyteExkRBQYvYm9WJYY/C3UzeELVeGlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SCYpR4dN+0+D5KapdWTM6HY6dDpGygT0sOhvHKhVwc6YaPETU6yaVFw31e+q1l5Kr
	 PYAeARNsh75IR4XPXb4TuBBlB+4GrtbYZjarXpDZ7A/Oe84x5id4RWt2VQz9Pa/Wgy
	 XZLenyxeyCDnAgso+aeWY7YVsQkF4n/jS2XH1a8Chi0BHFg8ux8g0YMlBhawzR0qyw
	 AOI9ZwaQRKf+Joku4QZS6/ZNCNlrqtBUxPx703mqfpdpNOQZrOde9ZFqI2ZqnN070D
	 yjwTxZqp63XyXtvBQ8uLefUSk/R/+lZb9J6dCwIMTYyrbPuxuHPxot9tZ+xXWDuc0W
	 U1iMlQIVA46Vg==
Date: Thu, 17 Sep 2026 08:21:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: huhai <15815827059@163.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	Henry Hu <huhai@kylinos.cn>
Subject: Re: [PATCH] blk-mq: check passthrough state before reusing cached
 requests
Message-ID: <aqv3hrg_fCZZCojW@kbusch-mbp>
References: <20260916151655.2588-1-15815827059@163.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916151655.2588-1-15815827059@163.com>

On Wed, Sep 16, 2026 at 11:16:55PM +0800, huhai wrote:
> @@ -648,6 +648,8 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
>  			return NULL;
>  		if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
>  			return NULL;
> +		if (blk_rq_is_passthrough(rq) != blk_op_is_passthrough(opf))
> +			return NULL;

I see how this addresses your observation, but I don't think this is the
right way to fix it. The batch of requests allocated to prime the cache
shouldn't be locked into a specific type of command that can use it,
IMO. This is a bit more involved of a change, but it should allow more
flexible use of the cached requests. Here's a quick idea to attempt
that:

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3e..c1fd20807da30 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -447,17 +447,28 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	WRITE_ONCE(rq->deadline, 0);
 	req_ref_set(rq, 1);
 
-	if (rq->rq_flags & RQF_USE_SCHED) {
-		struct elevator_queue *e = data->q->elevator;
+	return rq;
+}
+
+static bool blk_op_bypass_sched(blk_opf_t opf)
+{
+	return (opf & REQ_OP_MASK) == REQ_OP_FLUSH ||
+	       blk_op_is_passthrough(opf);
+}
 
-		INIT_HLIST_NODE(&rq->hash);
-		RB_CLEAR_NODE(&rq->rb_node);
+static void blk_mq_set_rq_sched(struct request *rq, blk_opf_t opf)
+{
+	struct elevator_queue *e = rq->q->elevator;
 
-		if (e->type->ops.prepare_request)
-			e->type->ops.prepare_request(rq);
-	}
+	if (!e || blk_op_bypass_sched(opf))
+		return;
 
-	return rq;
+	rq->rq_flags |= RQF_USE_SCHED;
+	INIT_HLIST_NODE(&rq->hash);
+	RB_CLEAR_NODE(&rq->rb_node);
+
+	if (e->type->ops.prepare_request)
+		e->type->ops.prepare_request(rq);
 }
 
 static inline struct request *
@@ -518,12 +529,10 @@ static void blk_mq_limit_depth(struct blk_mq_alloc_data *data)
 	 * Flush/passthrough requests are special and go directly to the
 	 * dispatch list, they are not subject to the async_depth limit.
 	 */
-	if ((data->cmd_flags & REQ_OP_MASK) == REQ_OP_FLUSH ||
-	    blk_op_is_passthrough(data->cmd_flags))
+	if (blk_op_bypass_sched(data->cmd_flags))
 		return;
 
 	WARN_ON_ONCE(data->flags & BLK_MQ_REQ_RESERVED);
-	data->rq_flags |= RQF_USE_SCHED;
 
 	/*
 	 * By default, sync requests have no limit, and async requests are
@@ -563,6 +572,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		rq = __blk_mq_alloc_requests_batch(data);
 		if (rq) {
 			blk_mq_rq_time_init(rq, alloc_time_ns);
+			blk_mq_set_rq_sched(rq, data->cmd_flags);
 			return rq;
 		}
 		data->nr_tags = 1;
@@ -591,6 +601,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 		blk_mq_inc_active_requests(data->hctx);
 	rq = blk_mq_rq_ctx_init(data, blk_mq_tags_from_data(data), tag);
 	blk_mq_rq_time_init(rq, alloc_time_ns);
+	blk_mq_set_rq_sched(rq, data->cmd_flags);
 	return rq;
 }
 
@@ -637,8 +648,6 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 		if (plug->nr_ios == 1)
 			return NULL;
 		rq = blk_mq_rq_cache_fill(q, plug, opf, flags);
-		if (!rq)
-			return NULL;
 	} else {
 		rq = rq_list_peek(&plug->cached_rqs);
 		if (!rq || rq->q != q)
@@ -646,15 +655,14 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
 
 		if (blk_mq_get_hctx_type(opf) != rq->mq_hctx->type)
 			return NULL;
-		if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
-			return NULL;
 
 		rq_list_pop(&plug->cached_rqs);
 		blk_mq_rq_time_init(rq, blk_time_get_ns());
+		rq->cmd_flags = opf;
+		INIT_LIST_HEAD(&rq->queuelist);
+		blk_mq_set_rq_sched(rq, opf);
 	}
 
-	rq->cmd_flags = opf;
-	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
 }
 
@@ -3060,8 +3068,6 @@ static struct request *blk_mq_get_cached_request(struct blk_plug *plug,
 	if (type != rq->mq_hctx->type &&
 	    (type != HCTX_TYPE_READ || rq->mq_hctx->type != HCTX_TYPE_DEFAULT))
 		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
-		return NULL;
 	rq_list_pop(&plug->cached_rqs);
 	return rq;
 }
@@ -3166,6 +3172,7 @@ void blk_mq_submit_bio(struct bio *bio)
 		blk_mq_rq_time_init(rq, blk_time_get_ns());
 		rq->cmd_flags = bio->bi_opf;
 		INIT_LIST_HEAD(&rq->queuelist);
+		blk_mq_set_rq_sched(rq, bio->bi_opf);
 	} else {
 		rq = blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
--
