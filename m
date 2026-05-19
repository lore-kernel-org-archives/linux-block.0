Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8CB39DBF8
	for <linux-block@vger.kernel.org>; Tue, 19 May 2026 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779173290; cv=none; b=ZqpwjleKx9uz+mYMH781zTKDnUjD1nkOz2ez5vT88gbxwlg4q9uUJbTg5LUCYePtHbyjQD/XYnYVtBUfy6Sjs6Ga6+BeT/UJ+znASVvozunVE6dm57MFBZiNABv8q2GM7Cnf8US7ib/Q53fYsBZUQQ/n15I2kGv6yGcA90fY500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779173290; c=relaxed/simple;
	bh=mSBeU/sNiw+FalXyiPjZmehZuPU4VMlhG8JnEOoTYMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EYgdjrRr6BVdTzJkW9XQi2iY3WAg+flqL5tgU8jN8mNEvK45jBcVrj709b1sGDLibI6S49KJGW5qkVX9oiLkk9jHxNs4//75DC3h5Q6AxfRvUJImCVBOa/ca44ecpWzqc9FFl60Or5t20uRuG3PsqcWfVzoMNHbumlK8qr7EhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B84B68D05; Tue, 19 May 2026 08:47:56 +0200 (CEST)
Date: Tue, 19 May 2026 08:47:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org
Subject: Re: [PATCHv2] blk-mq: check for stale cached request in
 blk_mq_submit_bio
Message-ID: <20260519064755.GA6682@lst.de>
References: <20260501174120.403960-1-kbusch@meta.com> <agslvk4DLD0OOVLR@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agslvk4DLD0OOVLR@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, May 18, 2026 at 08:44:14AM -0600, Keith Busch wrote:
> On Fri, May 01, 2026 at 10:41:19AM -0700, Keith Busch wrote:
> > When submitting a bio to blk-mq, if the task should sleep after peeking
> > a cached request, but before it pops it, the plug flushes and calls
> > blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
> > use-after-free bug. Fix this by ensuring the cached_rqs still contains
> > our peeked request, and retry the bio submission without it if the
> > request had been freed.
> 
> Any thoughts on this one? I know it's an old bug, but I've only recently
> started seeing it happen for some reason.

I still think the only proper fix is to always hold a queue ref over
the checks.  Correctness first and then look into optimizing that
with hazard pointers or whatever.  Below is the patch I did during
LSF/MM, refeshed using a commit log mostly stolen from you:

---
From e1bff09d6b594f777624240cefd70861137c45b4 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 19 May 2026 06:49:12 +0200
Subject: blk-mq: always take a queue reference in blk_mq_submit_bio

When submitting a bio to blk-mq, if the task should sleep after peeking
a cached request, but before it pops it, the plug flushes and calls
blk_mq_free_plug_rqs, freeing the cached_rqs. This creates a
use-after-free bug.

Fix this by alway grabbing a queue usage reference in blk_mq_submit_bio.
While past commit claims that this is slow, we're better safe than
fast as a first priority.

The code had already warned of this possibility, and specifically popped
the request before other known blocking calls, but it didn't handle a
blocking GFP_NOIO alloc. Under memory pressure, allocating the split bio
or the integrity payload are two such cases that can block. The blk-mq
submit_bio function continues using the peeked request that was already
freed and re-initialized, so the driver receives that request with a
NULL'ed mq_hctx, and inevitably panics.

Large parts of the commit message are stolen from an an earlier attempt
to fix this issue by Keith Busch <kbusch@kernel.org>.

Fixes: b0077e269f6c1 ("blk-mq: make sure active queue usage is held for bio_integrity_prep()")
Fixes: 7b4f36cd22a65 ("block: ensure we hold a queue reference when using queue limits")
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 65 +++++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d0c37daf568f..a9af1a9faedc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3075,43 +3075,42 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 }
 
 /*
- * Check if there is a suitable cached request and return it.
+ * Check if there is a suitable cached request and use it if possible.
  */
-static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
-		struct request_queue *q, blk_opf_t opf)
+static struct request *blk_mq_pop_cached_request(struct blk_plug *plug,
+		struct request_queue *q, struct bio *bio)
 {
-	enum hctx_type type = blk_mq_get_hctx_type(opf);
+	enum hctx_type type = blk_mq_get_hctx_type(bio->bi_opf);
 	struct request *rq;
 
 	if (!plug)
 		return NULL;
+
+	/*
+	 * Note: we must not sleep between the peek of the cached_rqs list here
+	 * and the pop below.
+	 */
 	rq = rq_list_peek(&plug->cached_rqs);
 	if (!rq || rq->q != q)
 		return NULL;
 	if (type != rq->mq_hctx->type &&
 	    (type != HCTX_TYPE_READ || rq->mq_hctx->type != HCTX_TYPE_DEFAULT))
 		return NULL;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
 		return NULL;
-	return rq;
-}
-
-static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
-		struct bio *bio)
-{
 	if (rq_list_pop(&plug->cached_rqs) != rq)
 		WARN_ON_ONCE(1);
 
-	/*
-	 * If any qos ->throttle() end up blocking, we will have flushed the
-	 * plug and hence killed the cached_rq list as well. Pop this entry
-	 * before we throttle.
-	 */
 	rq_qos_throttle(rq->q, bio);
-
 	blk_mq_rq_time_init(rq, blk_time_get_ns());
 	rq->cmd_flags = bio->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
+
+	/*
+	 * Drop the extra queue reference from the cached request.
+	 */
+	blk_queue_exit(q);
+	return rq;
 }
 
 static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
@@ -3149,11 +3148,6 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct request *rq;
 	blk_status_t ret;
 
-	/*
-	 * If the plug has a cached request for this queue, try to use it.
-	 */
-	rq = blk_mq_peek_cached_request(plug, q, bio->bi_opf);
-
 	/*
 	 * A BIO that was released from a zone write plug has already been
 	 * through the preparation in this function, already holds a reference
@@ -3162,19 +3156,11 @@ void blk_mq_submit_bio(struct bio *bio)
 	 */
 	if (bio_zone_write_plugging(bio)) {
 		nr_segs = bio->__bi_nr_segments;
-		if (rq)
-			blk_queue_exit(q);
 		goto new_request;
 	}
 
-	/*
-	 * The cached request already holds a q_usage_counter reference and we
-	 * don't have to acquire a new one if we use it.
-	 */
-	if (!rq) {
-		if (unlikely(bio_queue_enter(bio)))
-			return;
-	}
+	if (unlikely(bio_queue_enter(bio)))
+		return;
 
 	/*
 	 * Device reconfiguration may change logical block size or reduce the
@@ -3210,9 +3196,11 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 new_request:
-	if (rq) {
-		blk_mq_use_cached_rq(rq, plug, bio);
-	} else {
+	/*
+	 * If the plug has a cached request for this queue, try to use it.
+	 */
+	rq = blk_mq_pop_cached_request(plug, q, bio);
+	if (!rq) {
 		rq = blk_mq_get_new_requests(q, plug, bio);
 		if (unlikely(!rq)) {
 			if (bio->bi_opf & REQ_NOWAIT)
@@ -3257,12 +3245,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	return;
 
 queue_exit:
-	/*
-	 * Don't drop the queue reference if we were trying to use a cached
-	 * request and thus didn't acquire one.
-	 */
-	if (!rq)
-		blk_queue_exit(q);
+	blk_queue_exit(q);
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
-- 
2.53.0

