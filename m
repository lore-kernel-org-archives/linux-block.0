Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 05/10] blk-mq: simplify blk_mq_free_request
Date: Fri, 16 Jun 2017 18:15:22 +0200
Message-Id: <20170616161527.17649-6-hch@lst.de>
In-Reply-To: <20170616161527.17649-1-hch@lst.de>
References: <20170616161527.17649-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Merge three functions only tail-called by blk_mq_free_request into
blk_mq_free_request.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 50 +++++++++++++++-----------------------------------
 block/blk-mq.h |  3 ---
 2 files changed, 15 insertions(+), 38 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9df7e0394a48..0b17351fccfc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -395,12 +395,24 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-			     struct request *rq)
+void blk_mq_free_request(struct request *rq)
 {
-	const int sched_tag = rq->internal_tag;
 	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+	struct blk_mq_ctx *ctx = rq->mq_ctx;
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
+	const int sched_tag = rq->internal_tag;
 
+	if (rq->rq_flags & (RQF_ELVPRIV | RQF_QUEUED)) {
+		if (e && e->type->ops.mq.finish_request)
+			e->type->ops.mq.finish_request(rq);
+		if (rq->elv.icq) {
+			put_io_context(rq->elv.icq->ioc);
+			rq->elv.icq = NULL;
+		}
+	}
+
+	ctx->rq_completed[rq_is_sync(rq)]++;
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		atomic_dec(&hctx->nr_active);
 
@@ -416,38 +428,6 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
 }
-
-static void blk_mq_finish_hctx_request(struct blk_mq_hw_ctx *hctx,
-				     struct request *rq)
-{
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-
-	ctx->rq_completed[rq_is_sync(rq)]++;
-	__blk_mq_finish_request(hctx, ctx, rq);
-}
-
-void blk_mq_finish_request(struct request *rq)
-{
-	blk_mq_finish_hctx_request(blk_mq_map_queue(rq->q, rq->mq_ctx->cpu), rq);
-}
-EXPORT_SYMBOL_GPL(blk_mq_finish_request);
-
-void blk_mq_free_request(struct request *rq)
-{
-	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
-
-	if (rq->rq_flags & (RQF_ELVPRIV | RQF_QUEUED)) {
-		if (e && e->type->ops.mq.finish_request)
-			e->type->ops.mq.finish_request(rq);
-		if (rq->elv.icq) {
-			put_io_context(rq->elv.icq->ioc);
-			rq->elv.icq = NULL;
-		}
-	}
-
-	blk_mq_finish_request(rq);
-}
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
 inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 806fed53f607..6a509a8eb3fb 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -131,9 +131,6 @@ static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data
 /*
  * Internal helpers for request allocation/init/free
  */
-void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
-				struct request *rq);
-void blk_mq_finish_request(struct request *rq);
 struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 					unsigned int op);
 
-- 
2.11.0
