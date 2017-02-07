Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [WIP PATCHSET 1/4] blk-mq: pass bio to blk_mq_sched_get_rq_priv
Date: Tue,  7 Feb 2017 18:24:43 +0100
Message-Id: <20170207172446.4528-2-paolo.valente@linaro.org>
In-Reply-To: <20170207172446.4528-1-paolo.valente@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

bio is used in bfq-mq's get_rq_priv, to get the request group. We could
pass directly the group here, but I thought that passing the bio was
more general, giving the possibility to get other pieces of information
if needed.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/blk-mq-sched.c     | 8 +++++---
 block/blk-mq-sched.h     | 5 +++--
 include/linux/elevator.h | 2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ee455e7..314a8ed 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -68,7 +68,9 @@ int blk_mq_sched_init_hctx_data(struct request_queue *q, size_t size,
 EXPORT_SYMBOL_GPL(blk_mq_sched_init_hctx_data);
 
 static void __blk_mq_sched_assign_ioc(struct request_queue *q,
-				      struct request *rq, struct io_context *ioc)
+				      struct request *rq,
+				      struct bio *bio,
+				      struct io_context *ioc)
 {
 	struct io_cq *icq;
 
@@ -83,7 +85,7 @@ static void __blk_mq_sched_assign_ioc(struct request_queue *q,
 	}
 
 	rq->elv.icq = icq;
-	if (!blk_mq_sched_get_rq_priv(q, rq)) {
+	if (!blk_mq_sched_get_rq_priv(q, rq, bio)) {
 		rq->rq_flags |= RQF_ELVPRIV;
 		get_io_context(icq->ioc);
 		return;
@@ -99,7 +101,7 @@ static void blk_mq_sched_assign_ioc(struct request_queue *q,
 
 	ioc = rq_ioc(bio);
 	if (ioc)
-		__blk_mq_sched_assign_ioc(q, rq, ioc);
+		__blk_mq_sched_assign_ioc(q, rq, bio, ioc);
 }
 
 struct request *blk_mq_sched_get_request(struct request_queue *q,
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 5954859..7b5f3b9 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -49,12 +49,13 @@ blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 }
 
 static inline int blk_mq_sched_get_rq_priv(struct request_queue *q,
-					   struct request *rq)
+					   struct request *rq,
+					   struct bio *bio)
 {
 	struct elevator_queue *e = q->elevator;
 
 	if (e && e->type->ops.mq.get_rq_priv)
-		return e->type->ops.mq.get_rq_priv(q, rq);
+		return e->type->ops.mq.get_rq_priv(q, rq, bio);
 
 	return 0;
 }
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index b5825c4..ce14ede 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -99,7 +99,7 @@ struct elevator_mq_ops {
 	void (*requeue_request)(struct request *);
 	struct request *(*former_request)(struct request_queue *, struct request *);
 	struct request *(*next_request)(struct request_queue *, struct request *);
-	int (*get_rq_priv)(struct request_queue *, struct request *);
+	int (*get_rq_priv)(struct request_queue *, struct request *, struct bio *);
 	void (*put_rq_priv)(struct request_queue *, struct request *);
 	void (*init_icq)(struct io_cq *);
 	void (*exit_icq)(struct io_cq *);
-- 
2.10.0
