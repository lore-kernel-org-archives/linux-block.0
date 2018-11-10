Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 5/6] blk-rq-qos: inline check for q->rq_qos functions
Date: Sat, 10 Nov 2018 08:13:16 -0700
Message-Id: <20181110151317.3813-6-axboe@kernel.dk>
In-Reply-To: <20181110151317.3813-1-axboe@kernel.dk>
References: <20181110151317.3813-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Put the short code in the fast path, where we don't have any
functions attached to the queue. This minimizes the impact on
the hot path in the core code.

Cleanup duplicated code by having a macro setup both the inline
check and the actual functions.

Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-rq-qos.c | 90 +++++++++++++---------------------------------
 block/blk-rq-qos.h | 35 ++++++++++++++----
 2 files changed, 52 insertions(+), 73 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 0005dfd568dd..266c9e111475 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -27,76 +27,34 @@ bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
 	return atomic_inc_below(&rq_wait->inflight, limit);
 }
 
-void rq_qos_cleanup(struct request_queue *q, struct bio *bio)
-{
-	struct rq_qos *rqos;
-
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->cleanup)
-			rqos->ops->cleanup(rqos, bio);
-	}
-}
-
-void rq_qos_done(struct request_queue *q, struct request *rq)
-{
-	struct rq_qos *rqos;
-
-	for (rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->done)
-			rqos->ops->done(rqos, rq);
-	}
-}
-
-void rq_qos_issue(struct request_queue *q, struct request *rq)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->issue)
-			rqos->ops->issue(rqos, rq);
-	}
-}
-
-void rq_qos_requeue(struct request_queue *q, struct request *rq)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->requeue)
-			rqos->ops->requeue(rqos, rq);
-	}
+#define __RQ_QOS_FUNC_ONE(__OP, type)					\
+void __rq_qos_##__OP(struct rq_qos *rqos, type arg)			\
+{									\
+	do {								\
+		if ((rqos)->ops->__OP)					\
+			(rqos)->ops->__OP((rqos), arg);			\
+		(rqos) = (rqos)->next;					\
+	} while (rqos);							\
 }
 
-void rq_qos_throttle(struct request_queue *q, struct bio *bio,
-		     spinlock_t *lock)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->throttle)
-			rqos->ops->throttle(rqos, bio, lock);
-	}
+__RQ_QOS_FUNC_ONE(cleanup, struct bio *);
+__RQ_QOS_FUNC_ONE(done, struct request *);
+__RQ_QOS_FUNC_ONE(issue, struct request *);
+__RQ_QOS_FUNC_ONE(requeue, struct request *);
+__RQ_QOS_FUNC_ONE(done_bio, struct bio *);
+
+#define __RQ_QOS_FUNC_TWO(__OP, type1, type2)				\
+void __rq_qos_##__OP(struct rq_qos *rqos, type1 arg1, type2 arg2)	\
+{									\
+	do {								\
+		if ((rqos)->ops->__OP)					\
+			(rqos)->ops->__OP((rqos), arg1, arg2);		\
+		(rqos) = (rqos)->next;					\
+	} while (rqos);							\
 }
 
-void rq_qos_track(struct request_queue *q, struct request *rq, struct bio *bio)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->track)
-			rqos->ops->track(rqos, rq, bio);
-	}
-}
-
-void rq_qos_done_bio(struct request_queue *q, struct bio *bio)
-{
-	struct rq_qos *rqos;
-
-	for(rqos = q->rq_qos; rqos; rqos = rqos->next) {
-		if (rqos->ops->done_bio)
-			rqos->ops->done_bio(rqos, bio);
-	}
-}
+__RQ_QOS_FUNC_TWO(throttle, struct bio *, spinlock_t *);
+__RQ_QOS_FUNC_TWO(track, struct request *, struct bio *);
 
 /*
  * Return true, if we can't increase the depth further by scaling
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 32b02efbfa66..50558a6ea248 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -98,12 +98,33 @@ void rq_depth_scale_up(struct rq_depth *rqd);
 void rq_depth_scale_down(struct rq_depth *rqd, bool hard_throttle);
 bool rq_depth_calc_max_depth(struct rq_depth *rqd);
 
-void rq_qos_cleanup(struct request_queue *, struct bio *);
-void rq_qos_done(struct request_queue *, struct request *);
-void rq_qos_issue(struct request_queue *, struct request *);
-void rq_qos_requeue(struct request_queue *, struct request *);
-void rq_qos_done_bio(struct request_queue *q, struct bio *bio);
-void rq_qos_throttle(struct request_queue *, struct bio *, spinlock_t *);
-void rq_qos_track(struct request_queue *q, struct request *, struct bio *);
+#define RQ_QOS_FUNC_ONE(__OP, type)					\
+void __rq_qos_##__OP(struct rq_qos *rqos, type arg);			\
+static inline void rq_qos_##__OP(struct request_queue *q, type arg)	\
+{									\
+	if ((q)->rq_qos)						\
+		__rq_qos_##__OP((q)->rq_qos, arg);			\
+}
+
+#define RQ_QOS_FUNC_TWO(__OP, type1, type2)				\
+void __rq_qos_##__OP(struct rq_qos *rqos, type1 arg1, type2 arg2);	\
+static inline void rq_qos_##__OP(struct request_queue *q, type1 arg1,	\
+				 type2 arg2)				\
+{									\
+	if ((q)->rq_qos)						\
+		__rq_qos_##__OP((q)->rq_qos, arg1, arg2);		\
+}
+
+RQ_QOS_FUNC_ONE(cleanup, struct bio *);
+RQ_QOS_FUNC_ONE(done, struct request *);
+RQ_QOS_FUNC_ONE(issue, struct request *);
+RQ_QOS_FUNC_ONE(requeue, struct request *);
+RQ_QOS_FUNC_ONE(done_bio, struct bio *);
+RQ_QOS_FUNC_TWO(throttle, struct bio *, spinlock_t *);
+RQ_QOS_FUNC_TWO(track, struct request *, struct bio *);
+#undef RQ_QOS_FUNC_ONE
+#undef RQ_QOS_FUNC_TWO
+
 void rq_qos_exit(struct request_queue *);
+
 #endif
-- 
2.17.1
