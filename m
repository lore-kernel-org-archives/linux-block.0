Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7661F4E59
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769260; cv=none; b=g1QwB23duYI/vaGmpW2HXiNDIZymlfXcd6YrYRoiRsR5+h4E5U+v17wjeC8MSf0pYM/S7TcKVjG6zQaN8a95Xa4nLQEkbpFy5stDgvm+4vwjEA01JvsLyWWWVzuiAJMODXHP6O/9u/NXfDgNUoJRqnFRvwkcegwsU9Gz2dsHjU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769260; c=relaxed/simple;
	bh=EZgzR+8G0XT/O4W7+4XeYxbkjXMJ0M/NFS/5Z3EQi5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dDCcWLoCrUAjs5ixcksLVYl83mTjSwShpx2fLDLDiekL9RjaqA5UdaQS/o714sXRWKwaUWjh8aJ1zQ+wABhOiICyxHAsCClsZCMNt/hm617Ya3EHGviDNilrLiPe3uTj5v859+fL+D+x5bkETBQxDjYYLH14+oXjlBTl8c53cvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=sAGciZEN; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="sAGciZEN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741769248; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=heoyu4P+GpEXt6ocFUk2FvLzUEnckO/G8oDHilAOJds=;
	b=sAGciZENfadgE96ueLwSQ7lTSPVW5fpWXcr1clbJ26R5WaKmWt75+0SaIRc8UsXrn34GSUw+j6M27xzfWs22cDvIsPg0q9HfkWsKRSfLqt09tPJf03OJqWp3Urqh3Ft88qKX+lq/rWiKK83hPbLjs0RNlauqBjEo+6lJveui960=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WRC4IUN_1741769242 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 16:47:26 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: remove unused parameter
Date: Wed, 12 Mar 2025 16:47:22 +0800
Message-ID: <20250312084722.129680-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blk_mq_map_queue()'s request_queue param is not used anymore,
remove it, same with blk_get_flush_queue().

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-flush.c     | 10 +++++-----
 block/blk-mq-sched.c  |  2 +-
 block/blk-mq-tag.c    |  3 +--
 block/blk-mq.c        |  2 +-
 block/blk-mq.h        |  4 +---
 block/kyber-iosched.c |  2 +-
 6 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index a72e2a83d075..43d6152897a4 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -95,9 +95,9 @@ static void blk_kick_flush(struct request_queue *q,
 			   struct blk_flush_queue *fq, blk_opf_t flags);
 
 static inline struct blk_flush_queue *
-blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
+blk_get_flush_queue(struct blk_mq_ctx *ctx)
 {
-	return blk_mq_map_queue(q, REQ_OP_FLUSH, ctx)->fq;
+	return blk_mq_map_queue(REQ_OP_FLUSH, ctx)->fq;
 }
 
 static unsigned int blk_flush_cur_seq(struct request *rq)
@@ -205,7 +205,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 	struct list_head *running;
 	struct request *rq, *n;
 	unsigned long flags = 0;
-	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
+	struct blk_flush_queue *fq = blk_get_flush_queue(flush_rq->mq_ctx);
 
 	/* release the tag's ownership to the req cloned from */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
@@ -341,7 +341,7 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	unsigned long flags;
-	struct blk_flush_queue *fq = blk_get_flush_queue(q, ctx);
+	struct blk_flush_queue *fq = blk_get_flush_queue(ctx);
 
 	if (q->elevator) {
 		WARN_ON(rq->tag < 0);
@@ -382,7 +382,7 @@ static void blk_rq_init_flush(struct request *rq)
 bool blk_insert_flush(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);
+	struct blk_flush_queue *fq = blk_get_flush_queue(rq->mq_ctx);
 	bool supports_fua = q->limits.features & BLK_FEAT_FUA;
 	unsigned int policy = 0;
 
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 7442ca27c2bf..109611445d40 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -349,7 +349,7 @@ bool blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,
 	}
 
 	ctx = blk_mq_get_ctx(q);
-	hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
+	hctx = blk_mq_map_queue(bio->bi_opf, ctx);
 	type = hctx->type;
 	if (list_empty_careful(&ctx->rq_lists[type]))
 		goto out_put;
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index b9f417d980b4..d880c50629d6 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -190,8 +190,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		sbitmap_finish_wait(bt, ws, &wait);
 
 		data->ctx = blk_mq_get_ctx(data->q);
-		data->hctx = blk_mq_map_queue(data->q, data->cmd_flags,
-						data->ctx);
+		data->hctx = blk_mq_map_queue(data->cmd_flags, data->ctx);
 		tags = blk_mq_tags_from_data(data);
 		if (data->flags & BLK_MQ_REQ_RESERVED)
 			bt = &tags->breserved_tags;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 40490ac88045..26a3b6b13c4c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -508,7 +508,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 
 retry:
 	data->ctx = blk_mq_get_ctx(q);
-	data->hctx = blk_mq_map_queue(q, data->cmd_flags, data->ctx);
+	data->hctx = blk_mq_map_queue(data->cmd_flags, data->ctx);
 
 	if (q->elevator) {
 		/*
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 44979e92b79f..3011a78cf16a 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -100,12 +100,10 @@ static inline enum hctx_type blk_mq_get_hctx_type(blk_opf_t opf)
 
 /*
  * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
- * @q: request queue
  * @opf: operation type (REQ_OP_*) and flags (e.g. REQ_POLLED).
  * @ctx: software queue cpu ctx
  */
-static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
-						     blk_opf_t opf,
+static inline struct blk_mq_hw_ctx *blk_mq_map_queue(blk_opf_t opf,
 						     struct blk_mq_ctx *ctx)
 {
 	return ctx->hctxs[blk_mq_get_hctx_type(opf)];
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index dc31f2dfa414..0f0f8452609a 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -568,7 +568,7 @@ static bool kyber_bio_merge(struct request_queue *q, struct bio *bio,
 		unsigned int nr_segs)
 {
 	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, bio->bi_opf, ctx);
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(bio->bi_opf, ctx);
 	struct kyber_hctx_data *khd = hctx->sched_data;
 	struct kyber_ctx_queue *kcq = &khd->kcqs[ctx->index_hw[hctx->type]];
 	unsigned int sched_domain = kyber_sched_domain(bio->bi_opf);
-- 
2.43.0

