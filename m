Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405C3AEF2D
	for <linux-block@vger.kernel.org>; Wed, 20 May 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779266955; cv=none; b=U82VBIKnXhgrEvAjjdsK0cSe++Lu3DpXiWShKo6YbsrcaVtqBcGOpJ8HkdRXiDAQn0OQ+gJzEN4Wj5Wjg3djPWlaUs1m1rppPB+8OBatiblHwEet3d2hQUQr4gQMBDIcghKrE6mCTfiCnaaxEzEUS9RJ2bmF3aRNElvm7JX6+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779266955; c=relaxed/simple;
	bh=pj/EJozPL745SHnll9mOA+g5Utfwv5+0NQepHAA3WNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3E8TFYk3FTGKllC0iGaZ9sRWd8I8Nm4XNPkJxfkfHbaj57QDWpCc7/5H1A6783r5AM317v+1tMdlOmehh+GAnuvXLfZRKw/vHJdGkEmInaQ29E1EocKBpppe1L3Rg8Tiuga5GKMGtHepxReC6O8Ft8RuYh+NXg5iMNStQqECRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WYrcPpHl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WYrcPpHl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dCFjzfWQme50XrjyE/ls2JJmF87OLq5pdBrGMEd0vlA=; b=WYrcPpHlRwF3IUzP4qModLkkob
	r2jDuKWK3410/G/LtwG/WtP/yH/hBRjYgaoKzZ62seg5vwBDHkt0U/5l/gVczADVkiJLnQlnRuaSd
	SEPvcaDvEbMV4kb9pylOYZdfAY69ynNE+q6xhYnYumIyV13PQQf1ioQPAo9hZnCSmMf5IllDzB0E0
	+/jNS3WM/CGIOt4Y7etSbm3wYURNLy1C9VucF0K3r4esfN5d8Hv8ABIHRSvKv+IgzfWn5juKPsUxF
	JnSV/8c/xwzzkUPxlIj8KfQvkLQb+7vu9+nE+eHLM+rfRH7fbiaJ6B0agdygWxqsFmYXrXsSumWFH
	N1n2pD1g==;
Received: from [2001:4bb8:2ee:ba61:eae3:c2ec:f16a:563d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPcc3-000000041Ks-0SyQ;
	Wed, 20 May 2026 08:49:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: always take a queue reference in blk_mq_submit_bio
Date: Wed, 20 May 2026 10:49:05 +0200
Message-ID: <20260520084905.1092158-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

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

Large parts of the commit message are stolen from an earlier attempt
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

