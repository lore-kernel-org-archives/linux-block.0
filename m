Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2EDD520
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h79pfHpB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F786F0
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 00:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699430713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xkZNibRiWOPJAmE6uDT2EOrqce0J8aOZmLgZn+2thO0=;
	b=h79pfHpBaSOq+a41Ka5LJ+NWjqXcRFug2/5IuPFJlOwc5iAsdMC0zMJ+H4hiK6dqCRqUOV
	qv7eR3jm1hQQfAL1SiWJy+7+DYSL2x8tFNnxpL0gkGPJOVzqBBxBFS7iUz59w1JyIG9NYY
	pJtXgq75haw/Z9KNRbtXFXpBn0tQjVE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-k_OgoFs5OYafmSvzvXTcXQ-1; Wed, 08 Nov 2023 03:05:12 -0500
X-MC-Unique: k_OgoFs5OYafmSvzvXTcXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E259C810FC1;
	Wed,  8 Nov 2023 08:05:11 +0000 (UTC)
Received: from localhost (unknown [10.72.120.7])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 91EF01121306;
	Wed,  8 Nov 2023 08:05:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] blk-mq: make sure active queue usage is held for bio_integrity_prep()
Date: Wed,  8 Nov 2023 16:05:04 +0800
Message-ID: <20231108080504.2144952-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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
---
 block/blk-mq.c | 71 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 23 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2d11183f62e..80f36096f16f 100644
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
 
@@ -2878,35 +2875,43 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	rq_qos_cleanup(q, bio);
 	if (bio->bi_opf & REQ_NOWAIT)
 		bio_wouldblock_error(bio);
-queue_exit:
-	blk_queue_exit(q);
 	return NULL;
 }
 
-static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
+/* cached request means we grab active queue usage counter */
+static inline struct request *blk_mq_cached_req(const struct request_queue *q,
+		const struct blk_plug *plug)
+{
+	if (plug) {
+		struct request *rq = rq_list_peek(&plug->cached_rq);
+
+		if (rq && rq->q == q)
+			return rq;
+	}
+	return NULL;
+}
+
+/* return true if this bio needs to handle by allocating new request */
+static inline bool blk_mq_try_cached_rq(struct request *rq,
 		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
 {
-	struct request *rq;
+	struct request_queue *q = rq->q;
 	enum hctx_type type, hctx_type;
 
-	if (!plug)
-		return NULL;
-	rq = rq_list_peek(&plug->cached_rq);
-	if (!rq || rq->q != q)
-		return NULL;
+	WARN_ON_ONCE(rq_list_peek(&plug->cached_rq) != rq);
 
 	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
 		*bio = NULL;
-		return NULL;
+		return false;
 	}
 
 	type = blk_mq_get_hctx_type((*bio)->bi_opf);
 	hctx_type = rq->mq_hctx->type;
 	if (type != hctx_type &&
 	    !(type == HCTX_TYPE_READ && hctx_type == HCTX_TYPE_DEFAULT))
-		return NULL;
+		return true;
 	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
-		return NULL;
+		return true;
 
 	/*
 	 * If any qos ->throttle() end up blocking, we will have flushed the
@@ -2919,7 +2924,8 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 	blk_mq_rq_time_init(rq, 0);
 	rq->cmd_flags = (*bio)->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
-	return rq;
+
+	return false;
 }
 
 static void bio_set_ioprio(struct bio *bio)
@@ -2951,6 +2957,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct blk_mq_hw_ctx *hctx;
 	struct request *rq;
 	unsigned int nr_segs = 1;
+	bool need_alloc = true;
 	blk_status_t ret;
 
 	bio = blk_queue_bounce(bio, q);
@@ -2960,18 +2967,36 @@ void blk_mq_submit_bio(struct bio *bio)
 			return;
 	}
 
-	if (!bio_integrity_prep(bio))
-		return;
-
 	bio_set_ioprio(bio);
 
-	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
-	if (!rq) {
+	rq = blk_mq_cached_req(q, plug);
+	if (rq) {
+		/* cached request held queue usage counter */
+		if (!bio_integrity_prep(bio))
+			return;
+
+		need_alloc = blk_mq_try_cached_rq(rq, plug, &bio, nr_segs);
 		if (!bio)
 			return;
+	}
+
+	if (need_alloc) {
+		if (!rq) {
+			if (unlikely(bio_queue_enter(bio)))
+				return;
+
+			if (!bio_integrity_prep(bio))
+				return;
+		} else {
+			/* cached request held queue usage counter */
+			percpu_ref_get(&q->q_usage_counter);
+		}
+
 		rq = blk_mq_get_new_requests(q, plug, bio, nr_segs);
-		if (unlikely(!rq))
+		if (unlikely(!rq)) {
+			blk_queue_exit(q);
 			return;
+		}
 	}
 
 	trace_block_getrq(bio);
-- 
2.41.0

