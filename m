Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 08/10] blk-mq: refactor blk_mq_sched_assign_ioc
Date: Fri, 16 Jun 2017 18:15:25 +0200
Message-Id: <20170616161527.17649-9-hch@lst.de>
In-Reply-To: <20170616161527.17649-1-hch@lst.de>
References: <20170616161527.17649-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

blk_mq_sched_assign_ioc now only handles the assigned of the ioc if
the schedule needs it (bfq only at the moment).  The caller to the
per-request initializer is moved out so that it can be merged with
a similar call for the kyber I/O scheduler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 28 ++++------------------------
 block/blk-mq-sched.h |  3 +--
 block/blk-mq.c       | 14 ++++++++++++--
 3 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 22601e5c6f19..254d1c164567 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -31,12 +31,10 @@ void blk_mq_sched_free_hctx_data(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
 
-static void __blk_mq_sched_assign_ioc(struct request_queue *q,
-				      struct request *rq,
-				      struct bio *bio,
-				      struct io_context *ioc)
+void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio)
 {
-	struct elevator_queue *e = q->elevator;
+	struct request_queue *q = rq->q;
+	struct io_context *ioc = rq_ioc(bio);
 	struct io_cq *icq;
 
 	spin_lock_irq(q->queue_lock);
@@ -48,26 +46,8 @@ static void __blk_mq_sched_assign_ioc(struct request_queue *q,
 		if (!icq)
 			return;
 	}
-
-	rq->elv.icq = icq;
-	if (e && e->type->ops.mq.get_rq_priv &&
-	    e->type->ops.mq.get_rq_priv(q, rq, bio)) {
-		rq->elv.icq = NULL;
-		return;
-	}
-
-	rq->rq_flags |= RQF_ELVPRIV;
 	get_io_context(icq->ioc);
-}
-
-void blk_mq_sched_assign_ioc(struct request_queue *q, struct request *rq,
-			     struct bio *bio)
-{
-	struct io_context *ioc;
-
-	ioc = rq_ioc(bio);
-	if (ioc)
-		__blk_mq_sched_assign_ioc(q, rq, bio, ioc);
+	rq->elv.icq = icq;
 }
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index f34e6a522105..e117edd039b1 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -7,8 +7,7 @@
 void blk_mq_sched_free_hctx_data(struct request_queue *q,
 				 void (*exit)(struct blk_mq_hw_ctx *));
 
-void blk_mq_sched_assign_ioc(struct request_queue *q, struct request *rq,
-			     struct bio *bio);
+void blk_mq_sched_assign_ioc(struct request *rq, struct bio *bio);
 
 void blk_mq_sched_request_inserted(struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e056725679a8..2f380ab7a603 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -315,8 +315,18 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 
 	if (!op_is_flush(op)) {
 		rq->elv.icq = NULL;
-		if (e && e->type->icq_cache)
-			blk_mq_sched_assign_ioc(q, rq, bio);
+		if (e && e->type->ops.mq.get_rq_priv) {
+			if (e->type->icq_cache && rq_ioc(bio))
+				blk_mq_sched_assign_ioc(rq, bio);
+
+			if (e->type->ops.mq.get_rq_priv(q, rq, bio)) {
+				if (rq->elv.icq)
+					put_io_context(rq->elv.icq->ioc);
+				rq->elv.icq = NULL;
+			} else {
+				rq->rq_flags |= RQF_ELVPRIV;
+			}
+		}
 	}
 	data->hctx->queued++;
 	return rq;
-- 
2.11.0
