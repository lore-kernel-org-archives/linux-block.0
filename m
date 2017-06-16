Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 03/10] blk-mq: remove blk_mq_sched_{get,put}_rq_priv
Date: Fri, 16 Jun 2017 18:15:20 +0200
Message-Id: <20170616161527.17649-4-hch@lst.de>
In-Reply-To: <20170616161527.17649-1-hch@lst.de>
References: <20170616161527.17649-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Having these as separate helpers in a header really does not help
readability, or my chances to refactor this code sanely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sched.c | 10 ++++++----
 block/blk-mq-sched.h | 21 ---------------------
 block/blk-mq.c       |  3 ++-
 3 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 62db188595dc..22601e5c6f19 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -36,6 +36,7 @@ static void __blk_mq_sched_assign_ioc(struct request_queue *q,
 				      struct bio *bio,
 				      struct io_context *ioc)
 {
+	struct elevator_queue *e = q->elevator;
 	struct io_cq *icq;
 
 	spin_lock_irq(q->queue_lock);
@@ -49,13 +50,14 @@ static void __blk_mq_sched_assign_ioc(struct request_queue *q,
 	}
 
 	rq->elv.icq = icq;
-	if (!blk_mq_sched_get_rq_priv(q, rq, bio)) {
-		rq->rq_flags |= RQF_ELVPRIV;
-		get_io_context(icq->ioc);
+	if (e && e->type->ops.mq.get_rq_priv &&
+	    e->type->ops.mq.get_rq_priv(q, rq, bio)) {
+		rq->elv.icq = NULL;
 		return;
 	}
 
-	rq->elv.icq = NULL;
+	rq->rq_flags |= RQF_ELVPRIV;
+	get_io_context(icq->ioc);
 }
 
 void blk_mq_sched_assign_ioc(struct request_queue *q, struct request *rq,
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 5d12529538d0..f34e6a522105 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -44,27 +44,6 @@ blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 	return __blk_mq_sched_bio_merge(q, bio);
 }
 
-static inline int blk_mq_sched_get_rq_priv(struct request_queue *q,
-					   struct request *rq,
-					   struct bio *bio)
-{
-	struct elevator_queue *e = q->elevator;
-
-	if (e && e->type->ops.mq.get_rq_priv)
-		return e->type->ops.mq.get_rq_priv(q, rq, bio);
-
-	return 0;
-}
-
-static inline void blk_mq_sched_put_rq_priv(struct request_queue *q,
-					    struct request *rq)
-{
-	struct elevator_queue *e = q->elevator;
-
-	if (e && e->type->ops.mq.put_rq_priv)
-		e->type->ops.mq.put_rq_priv(q, rq);
-}
-
 static inline bool
 blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
 			 struct bio *bio)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 694cbd698507..1a45c287db64 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -438,7 +438,8 @@ void blk_mq_free_request(struct request *rq)
 	struct elevator_queue *e = q->elevator;
 
 	if (rq->rq_flags & RQF_ELVPRIV) {
-		blk_mq_sched_put_rq_priv(rq->q, rq);
+		if (e && e->type->ops.mq.put_rq_priv)
+			e->type->ops.mq.put_rq_priv(q, rq);
 		if (rq->elv.icq) {
 			put_io_context(rq->elv.icq->ioc);
 			rq->elv.icq = NULL;
-- 
2.11.0
