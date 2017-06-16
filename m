Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 10/10] blk-mq: remove __blk_mq_alloc_request
Date: Fri, 16 Jun 2017 18:15:27 +0200
Message-Id: <20170616161527.17649-11-hch@lst.de>
In-Reply-To: <20170616161527.17649-1-hch@lst.de>
References: <20170616161527.17649-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Move most code into blk_mq_rq_ctx_init, and the rest into
blk_mq_get_request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 68 +++++++++++++++++++++++-----------------------------------
 block/blk-mq.h |  6 ------
 2 files changed, 27 insertions(+), 47 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 81d05c19d4b3..be40c1d6e3a4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -204,15 +204,31 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 }
 EXPORT_SYMBOL(blk_mq_can_queue);
 
-static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
-		struct request *rq, unsigned int op)
+static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
+		unsigned int tag, unsigned int op)
 {
+	struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
+	struct request *rq = tags->static_rqs[tag];
+
+	if (data->flags & BLK_MQ_REQ_INTERNAL) {
+		rq->tag = -1;
+		rq->internal_tag = tag;
+	} else {
+		if (blk_mq_tag_busy(data->hctx)) {
+			rq->rq_flags = RQF_MQ_INFLIGHT;
+			atomic_inc(&data->hctx->nr_active);
+		}
+		rq->tag = tag;
+		rq->internal_tag = -1;
+		data->hctx->tags->rqs[rq->tag] = rq;
+	}
+
 	INIT_LIST_HEAD(&rq->queuelist);
 	/* csd/requeue_work/fifo_time is initialized before use */
-	rq->q = q;
-	rq->mq_ctx = ctx;
+	rq->q = data->q;
+	rq->mq_ctx = data->ctx;
 	rq->cmd_flags = op;
-	if (blk_queue_io_stat(q))
+	if (blk_queue_io_stat(data->q))
 		rq->rq_flags |= RQF_IO_STAT;
 	/* do not touch atomic flags, it needs atomic ops against the timer */
 	rq->cpu = -1;
@@ -241,41 +257,9 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	rq->end_io_data = NULL;
 	rq->next_rq = NULL;
 
-	ctx->rq_dispatched[op_is_sync(op)]++;
-}
-
-struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
-				       unsigned int op)
-{
-	struct request *rq;
-	unsigned int tag;
-
-	tag = blk_mq_get_tag(data);
-	if (tag != BLK_MQ_TAG_FAIL) {
-		struct blk_mq_tags *tags = blk_mq_tags_from_data(data);
-
-		rq = tags->static_rqs[tag];
-
-		if (data->flags & BLK_MQ_REQ_INTERNAL) {
-			rq->tag = -1;
-			rq->internal_tag = tag;
-		} else {
-			if (blk_mq_tag_busy(data->hctx)) {
-				rq->rq_flags = RQF_MQ_INFLIGHT;
-				atomic_inc(&data->hctx->nr_active);
-			}
-			rq->tag = tag;
-			rq->internal_tag = -1;
-			data->hctx->tags->rqs[rq->tag] = rq;
-		}
-
-		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
-		return rq;
-	}
-
-	return NULL;
+	data->ctx->rq_dispatched[op_is_sync(op)]++;
+	return rq;
 }
-EXPORT_SYMBOL_GPL(__blk_mq_alloc_request);
 
 static struct request *blk_mq_get_request(struct request_queue *q,
 		struct bio *bio, unsigned int op,
@@ -283,6 +267,7 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 {
 	struct elevator_queue *e = q->elevator;
 	struct request *rq;
+	unsigned int tag;
 
 	blk_queue_enter_live(q);
 	data->q = q;
@@ -302,12 +287,13 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 			e->type->ops.mq.limit_depth(op, data);
 	}
 
-	rq = __blk_mq_alloc_request(data, op);
-	if (!rq) {
+	tag = blk_mq_get_tag(data);
+	if (tag == BLK_MQ_TAG_FAIL) {
 		blk_queue_exit(q);
 		return NULL;
 	}
 
+	rq = blk_mq_rq_ctx_init(data, tag, op);
 	if (!op_is_flush(op)) {
 		rq->elv.icq = NULL;
 		if (e && e->type->ops.mq.prepare_request) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 6a509a8eb3fb..1a06fdf9fd4d 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -128,12 +128,6 @@ static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data
 	return data->hctx->tags;
 }
 
-/*
- * Internal helpers for request allocation/init/free
- */
-struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
-					unsigned int op);
-
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
 	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
-- 
2.11.0
