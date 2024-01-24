Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FA17C6E
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088438; cv=none; b=FjMAx0/NJmLmzyvJJes4vlFGaA+ta5mkiFbm5QQ9goBcy7BbNI0sCFWwk6HQ+E2RF0desU0UYSABYsQ062FDZDqWLrtTxXT615InnGpsl7XMcGbicW/Ma/wJZiFlBrBzVFB6l0Uu9SrdJhFUC9bETMjr51W2deQ7yNFd0i7ALvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088438; c=relaxed/simple;
	bh=dTqNy4N7fSlCLF+Fed8WvgFCe6S6nuWL5sg5m1WnioQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqAMcXzpE3HNLIo5d4zTSOb4Svj7yxRxiU95b2G5L9nSKnViCwr0qrmnnH3NTLV//Vk4aB9adLaFeyUrY9fw06vUhh2t9uvFMkPgax6/tU+fhO3PdTUP7PxhxDUhAnJhE5VuvYf6nnexIeWgUS5h4Za/Wbd29RGpDrZs6zM6gwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rXoUf1i0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXoUf1i0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=s6jkE73g2Zl3dRmzCTh2lgR5SxLnuL42vsXiH8Eh59U=; b=rXoUf1i03bq0QlBEgbkjIDKjNX
	df3LJdh1QihEc93mKa1fa1ApMRa+x6rMOFQTvZxhdkpPWJEiW0c3Um6WjpqRRyS+PZMYoR9VQyZMi
	TGuorVQUgto2DdauIrWRA25+rZLVr84r6JcGmJSakqzYhQaiBbDEX/qAt3TS4zxbAjNYKnv3S51IX
	AT0T706QGZCL6Drcs9cdo0T1SdbXQ31h+/ykVIWD41iSf1HX7/uMYoRkEJgnFZIOMzBoL+zUn+r5t
	kLJWeVxAO7Y4xTIu531kzoFPCaTybJkPjX6rCyIt5mcP7b7S1AbQ936ZppxnIDJxz2OieHB1svzHs
	lGyyrvvw==;
Received: from [2001:4bb8:188:3f09:9c13:25f:1e5b:57f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rSZXQ-002EKA-1N;
	Wed, 24 Jan 2024 09:27:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/3] blk-mq: special case cached requests less
Date: Wed, 24 Jan 2024 10:26:58 +0100
Message-Id: <20240124092658.2258309-4-hch@lst.de>
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

Share the main merge / split / integrity preparation code between the
cached request vs newly allocated request cases, and add comments
explaining the cached request handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 66df323c2b9489..edb9ee463bd0f0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2976,30 +2976,25 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct blk_plug *plug = blk_mq_plug(bio);
 	const int is_sync = op_is_sync(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq = NULL;
 	unsigned int nr_segs = 1;
+	struct request *rq;
 	blk_status_t ret;
 
 	bio = blk_queue_bounce(bio, q);
 	bio_set_ioprio(bio);
 
+	/*
+	 * If the plug has a cached request for this queue, try use it.
+	 *
+	 * The cached request already holds a q_usage_counter reference and we
+	 * don't have to acquire a new one if we use it.
+	 */
 	rq = blk_mq_peek_cached_request(plug, q, bio->bi_opf);
-	if (rq) {
-		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
-			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
-			if (!bio)
-				return;
-		}
-		if (!bio_integrity_prep(bio))
-			return;
-		if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
+	if (!rq) {
+		if (unlikely(bio_queue_enter(bio)))
 			return;
-		blk_mq_use_cached_rq(rq, plug, bio);
-		goto done;
 	}
 
-	if (unlikely(bio_queue_enter(bio)))
-		return;
 	if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
 		bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 		if (!bio)
@@ -3011,11 +3006,14 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (blk_mq_attempt_bio_merge(q, bio, nr_segs))
 		goto queue_exit;
 
-	rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
-	if (unlikely(!rq))
-		goto queue_exit;
+	if (!rq) {
+		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
+		if (unlikely(!rq))
+			goto queue_exit;
+	} else {
+		blk_mq_use_cached_rq(rq, plug, bio);
+	}
 
-done:
 	trace_block_getrq(bio);
 
 	rq_qos_track(q, rq, bio);
@@ -3049,7 +3047,12 @@ void blk_mq_submit_bio(struct bio *bio)
 	return;
 
 queue_exit:
-	blk_queue_exit(q);
+	/*
+	 * Don't drop the queue reference if we were trying to use a cached
+	 * request and thus didn't acquire one.
+	 */
+	if (!rq)
+		blk_queue_exit(q);
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
-- 
2.39.2

