Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E561617BDD
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088435; cv=none; b=NDzk1DcGPOa8W2dDjRRfHTUauNDoFrV5lqn5burimatPj4xda8bvgRIT5503164l1aoPyO23qEuJiSPCQZznNjQt3gK/JFbK88RDzxSJjGRkLF0fDbRwV3lrDPTvHcfuLqsr6COKvsLJbW9cepWcjn+pI+BNxZs8oQ1R1a4isW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088435; c=relaxed/simple;
	bh=iP8imi2P2jlrVl+iZgOZVNBqrnbeSp419t07D7h3lQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ovgyhR/a8XCzznmxUJwGqBBo0n8QqAogXlsaDblXYPK3ZmQa758SwvD7dEByEkhTsCLSO521/QgwBdUl7UdIHpi+E40eRBL0P9ItsddSHznrudkxAuvDunvFrE1fE+ningwWJYild97T9WIgOvqxNWn4ra9fHjnsLqSji/spv/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OdN7ke2T; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OdN7ke2T"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fhxoy1ygzkMQ/f2cRtIxBuIJwhUdBkG86fSKoOdym0U=; b=OdN7ke2T5f9wpa/G2BBI8Z0y6Z
	obRy80PtptfG4+8fb5i+PXzZgf0Rzbv3gRTuYwrLdte74eS5rwEDmiLMPY5xl9vm3DBOzQoZODaYO
	XNJ3FMQQUlquTupTRI+XeebJ6bDFEG5xW/CYIetjCVwHEgZApbTqS10H6eGOGCdLyn+OBztfEOhKL
	+UpNsvQN5/t05p1aT50z1YNnROUV1H9XSOzucm9QNLEaQiL1G8AExg1WmcXIpBfVBZFzuwGRAKOWa
	u95quplv9RBnzX4j4ow2irEBSFFQsaP4a3VyjexkEdbHPse5+r60K2I7Jav+CvBP6YrYo0V4SOk2g
	lB9s8mxw==;
Received: from [2001:4bb8:188:3f09:9c13:25f:1e5b:57f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZXM-002EHm-35;
	Wed, 24 Jan 2024 09:27:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/3] blk-mq: introduce a blk_mq_peek_cached_request helper
Date: Wed, 24 Jan 2024 10:26:57 +0100
Message-Id: <20240124092658.2258309-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124092658.2258309-1-hch@lst.de>
References: <20240124092658.2258309-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a new helper to check if there is suitable cached request in
blk_mq_submit_bio.  This removes open coded logic in blk_mq_submit_bio
and moves some checks that so far are in blk_mq_use_cached_rq to
be performed earlier.  This avoids the case where we first do check
with the cached request but then later end up allocating a new one
anyway and need to grab a queue reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 63 ++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fbd1ec56acea4d..66df323c2b9489 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2910,22 +2910,31 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 }
 
 /*
- * Check if we can use the passed on request for submitting the passed in bio,
- * and remove it from the request list if it can be used.
+ * Check if there is a suitable cached request and return it.
  */
-static bool blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
-		struct bio *bio)
+static struct request *blk_mq_peek_cached_request(struct blk_plug *plug,
+		struct request_queue *q, blk_opf_t opf)
 {
-	enum hctx_type type = blk_mq_get_hctx_type(bio->bi_opf);
-	enum hctx_type hctx_type = rq->mq_hctx->type;
+	enum hctx_type type = blk_mq_get_hctx_type(opf);
+	struct request *rq;
 
-	WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) != rq);
+	if (!plug)
+		return NULL;
+	rq = rq_list_peek(&plug->cached_rq);
+	if (!rq || rq->q != q)
+		return NULL;
+	if (type != rq->mq_hctx->type &&
+	    (type != HCTX_TYPE_READ || rq->mq_hctx->type != HCTX_TYPE_DEFAULT))
+		return NULL;
+	if (op_is_flush(rq->cmd_flags) != op_is_flush(opf))
+		return NULL;
+	return rq;
+}
 
-	if (type != hctx_type &&
-	    !(type == HCTX_TYPE_READ && hctx_type == HCTX_TYPE_DEFAULT))
-		return false;
-	if (op_is_flush(rq->cmd_flags) != op_is_flush(bio->bi_opf))
-		return false;
+static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
+		struct bio *bio)
+{
+	WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) != rq);
 
 	/*
 	 * If any qos ->throttle() end up blocking, we will have flushed the
@@ -2938,7 +2947,6 @@ static bool blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
 	blk_mq_rq_time_init(rq, 0);
 	rq->cmd_flags = bio->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
-	return true;
 }
 
 static void bio_set_ioprio(struct bio *bio)
@@ -2975,11 +2983,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	bio = blk_queue_bounce(bio, q);
 	bio_set_ioprio(bio);
 
-	if (plug) {
-		rq = rq_list_peek(&plug->cached_rq);
-		if (rq && rq->q != q)
-			rq = NULL;
-	}
+	rq = blk_mq_peek_cached_request(plug, q, bio->bi_opf);
 	if (rq) {
 		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
 			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
@@ -2990,20 +2994,19 @@ void blk_mq_submit_bio(struct bio *bio)
 			return;
 		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 			return;
-		if (blk_mq_use_cached_rq(rq, plug, bio))
-			goto done;
-		percpu_ref_get(&q->q_usage_counter);
-	} else {
-		if (unlikely(bio_queue_enter(bio)))
-			return;
-		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
-			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
-			if (!bio)
-				goto queue_exit;
-		}
-		if (!bio_integrity_prep(bio))
+		blk_mq_use_cached_rq(rq, plug, bio);
+		goto done;
+	}
+
+	if (unlikely(bio_queue_enter(bio)))
+		return;
+	if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
+		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
+		if (!bio)
 			goto queue_exit;
 	}
+	if (!bio_integrity_prep(bio))
+		goto queue_exit;
 
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
-- 
2.39.2

