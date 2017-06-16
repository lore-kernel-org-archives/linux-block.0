Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 02/10] blk-mq: move blk_mq_sched_{get,put}_request to blk-mq.c
Date: Fri, 16 Jun 2017 18:15:19 +0200
Message-Id: <20170616161527.17649-3-hch@lst.de>
In-Reply-To: <20170616161527.17649-1-hch@lst.de>
References: <20170616161527.17649-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Having them out of line in blk-mq-sched.c just makes the code flow
unnecessarily complicated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 69 ++--------------------------------------------------
 block/blk-mq-sched.h |  4 +--
 block/blk-mq.c       | 67 +++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 67 insertions(+), 73 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c4e2afb9d12d..62db188595dc 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -58,8 +58,8 @@ static void __blk_mq_sched_assign_ioc(struct request_queue *q,
 	rq->elv.icq = NULL;
 }
 
-static void blk_mq_sched_assign_ioc(struct request_queue *q,
-				    struct request *rq, struct bio *bio)
+void blk_mq_sched_assign_ioc(struct request_queue *q, struct request *rq,
+			     struct bio *bio)
 {
 	struct io_context *ioc;
 
@@ -68,71 +68,6 @@ static void blk_mq_sched_assign_ioc(struct request_queue *q,
 		__blk_mq_sched_assign_ioc(q, rq, bio, ioc);
 }
 
-struct request *blk_mq_sched_get_request(struct request_queue *q,
-					 struct bio *bio,
-					 unsigned int op,
-					 struct blk_mq_alloc_data *data)
-{
-	struct elevator_queue *e = q->elevator;
-	struct request *rq;
-
-	blk_queue_enter_live(q);
-	data->q = q;
-	if (likely(!data->ctx))
-		data->ctx = blk_mq_get_ctx(q);
-	if (likely(!data->hctx))
-		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
-
-	if (e) {
-		data->flags |= BLK_MQ_REQ_INTERNAL;
-
-		/*
-		 * Flush requests are special and go directly to the
-		 * dispatch list.
-		 */
-		if (!op_is_flush(op) && e->type->ops.mq.get_request) {
-			rq = e->type->ops.mq.get_request(q, op, data);
-			if (rq)
-				rq->rq_flags |= RQF_QUEUED;
-		} else
-			rq = __blk_mq_alloc_request(data, op);
-	} else {
-		rq = __blk_mq_alloc_request(data, op);
-	}
-
-	if (rq) {
-		if (!op_is_flush(op)) {
-			rq->elv.icq = NULL;
-			if (e && e->type->icq_cache)
-				blk_mq_sched_assign_ioc(q, rq, bio);
-		}
-		data->hctx->queued++;
-		return rq;
-	}
-
-	blk_queue_exit(q);
-	return NULL;
-}
-
-void blk_mq_sched_put_request(struct request *rq)
-{
-	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
-
-	if (rq->rq_flags & RQF_ELVPRIV) {
-		blk_mq_sched_put_rq_priv(rq->q, rq);
-		if (rq->elv.icq) {
-			put_io_context(rq->elv.icq->ioc);
-			rq->elv.icq = NULL;
-		}
-	}
-
-	if ((rq->rq_flags & RQF_QUEUED) && e && e->type->ops.mq.put_request)
-		e->type->ops.mq.put_request(rq);
-	else
-		blk_mq_finish_request(rq);
-}
-
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index b87e5be5db8c..5d12529538d0 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,8 +7,8 @@
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *));
 
-struct request *blk_mq_sched_get_request(struct request_queue *q, struct bio *bio, unsigned int op, struct blk_mq_alloc_data *data);
-void blk_mq_sched_put_request(struct request *rq);
+void blk_mq_sched_assign_ioc(struct request_queue *q, struct request *rq,
+			     struct bio *bio);
 
 void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1d650804c8e..694cbd698507 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -277,6 +277,51 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 }
 EXPORT_SYMBOL_GPL(__blk_mq_alloc_request);
 
+static struct request *blk_mq_get_request(struct request_queue *q,
+		struct bio *bio, unsigned int op,
+		struct blk_mq_alloc_data *data)
+{
+	struct elevator_queue *e = q->elevator;
+	struct request *rq;
+
+	blk_queue_enter_live(q);
+	data->q = q;
+	if (likely(!data->ctx))
+		data->ctx = blk_mq_get_ctx(q);
+	if (likely(!data->hctx))
+		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
+
+	if (e) {
+		data->flags |= BLK_MQ_REQ_INTERNAL;
+
+		/*
+		 * Flush requests are special and go directly to the
+		 * dispatch list.
+		 */
+		if (!op_is_flush(op) && e->type->ops.mq.get_request) {
+			rq = e->type->ops.mq.get_request(q, op, data);
+			if (rq)
+				rq->rq_flags |= RQF_QUEUED;
+		} else
+			rq = __blk_mq_alloc_request(data, op);
+	} else {
+		rq = __blk_mq_alloc_request(data, op);
+	}
+
+	if (rq) {
+		if (!op_is_flush(op)) {
+			rq->elv.icq = NULL;
+			if (e && e->type->icq_cache)
+				blk_mq_sched_assign_ioc(q, rq, bio);
+		}
+		data->hctx->queued++;
+		return rq;
+	}
+
+	blk_queue_exit(q);
+	return NULL;
+}
+
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		unsigned int flags)
 {
@@ -288,7 +333,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 	if (ret)
 		return ERR_PTR(ret);
 
-	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
+	rq = blk_mq_get_request(q, NULL, rw, &alloc_data);
 
 	blk_mq_put_ctx(alloc_data.ctx);
 	blk_queue_exit(q);
@@ -339,7 +384,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 	cpu = cpumask_first(alloc_data.hctx->cpumask);
 	alloc_data.ctx = __blk_mq_get_ctx(q, cpu);
 
-	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
+	rq = blk_mq_get_request(q, NULL, rw, &alloc_data);
 
 	blk_queue_exit(q);
 
@@ -389,7 +434,21 @@ EXPORT_SYMBOL_GPL(blk_mq_finish_request);
 
 void blk_mq_free_request(struct request *rq)
 {
-	blk_mq_sched_put_request(rq);
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+
+	if (rq->rq_flags & RQF_ELVPRIV) {
+		blk_mq_sched_put_rq_priv(rq->q, rq);
+		if (rq->elv.icq) {
+			put_io_context(rq->elv.icq->ioc);
+			rq->elv.icq = NULL;
+		}
+	}
+
+	if ((rq->rq_flags & RQF_QUEUED) && e && e->type->ops.mq.put_request)
+		e->type->ops.mq.put_request(rq);
+	else
+		blk_mq_finish_request(rq);
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
@@ -1494,7 +1553,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	trace_block_getrq(q, bio, bio->bi_opf);
 
-	rq = blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
+	rq = blk_mq_get_request(q, bio, bio->bi_opf, &data);
 	if (unlikely(!rq)) {
 		__wbt_done(q->rq_wb, wb_acct);
 		return BLK_QC_T_NONE;
-- 
2.11.0
