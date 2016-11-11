Return-Path: <prvs=0123dbb5f9=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <jack@suse.cz>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/2] blk-wbt: remove stat ops
Date: Fri, 11 Nov 2016 08:21:57 -0700
Message-ID: <1478877717-19624-3-git-send-email-axboe@fb.com>
In-Reply-To: <1478877717-19624-1-git-send-email-axboe@fb.com>
References: <1478877717-19624-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Again a leftover from when the throttling code was generic. Now that we
just have the block user, get rid of the stat ops and indirections.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-sysfs.c | 23 +----------------------
 block/blk-wbt.c   | 15 +++++----------
 block/blk-wbt.h   | 13 ++-----------
 3 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9262d2d60a09..415e764807d0 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -770,27 +770,6 @@ struct kobj_type blk_queue_ktype = {
 	.release	= blk_release_queue,
 };
 
-static void blk_wb_stat_get(void *data, struct blk_rq_stat *stat)
-{
-	blk_queue_stat_get(data, stat);
-}
-
-static void blk_wb_stat_clear(void *data)
-{
-	blk_stat_clear(data);
-}
-
-static bool blk_wb_stat_is_current(struct blk_rq_stat *stat)
-{
-	return blk_stat_is_current(stat);
-}
-
-static struct wb_stat_ops wb_stat_ops = {
-	.get		= blk_wb_stat_get,
-	.is_current	= blk_wb_stat_is_current,
-	.clear		= blk_wb_stat_clear,
-};
-
 static void blk_wb_init(struct request_queue *q)
 {
 #ifndef CONFIG_BLK_WBT_MQ
@@ -805,7 +784,7 @@ static void blk_wb_init(struct request_queue *q)
 	/*
 	 * If this fails, we don't get throttling
 	 */
-	wbt_init(q, &wb_stat_ops);
+	wbt_init(q);
 }
 
 int blk_register_queue(struct gendisk *disk)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 4ab9cebc8003..f6ec7e587fa6 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -308,7 +308,7 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 		 * waited or still has writes in flights, consider us doing
 		 * just writes as well.
 		 */
-		if ((stat[1].nr_samples && rwb->stat_ops->is_current(stat)) ||
+		if ((stat[1].nr_samples && blk_stat_is_current(stat)) ||
 		    wb_recent_wait(rwb) || wbt_inflight(rwb))
 			return LAT_UNKNOWN_WRITES;
 		return LAT_UNKNOWN;
@@ -333,7 +333,7 @@ static int latency_exceeded(struct rq_wb *rwb)
 {
 	struct blk_rq_stat stat[2];
 
-	rwb->stat_ops->get(rwb->ops_data, stat);
+	blk_queue_stat_get(rwb->queue, stat);
 	return __latency_exceeded(rwb, stat);
 }
 
@@ -355,7 +355,7 @@ static void scale_up(struct rq_wb *rwb)
 
 	rwb->scale_step--;
 	rwb->unknown_cnt = 0;
-	rwb->stat_ops->clear(rwb->ops_data);
+	blk_stat_clear(rwb->queue);
 
 	rwb->scaled_max = calc_wb_limits(rwb);
 
@@ -385,7 +385,7 @@ static void scale_down(struct rq_wb *rwb, bool hard_throttle)
 
 	rwb->scaled_max = false;
 	rwb->unknown_cnt = 0;
-	rwb->stat_ops->clear(rwb->ops_data);
+	blk_stat_clear(rwb->queue);
 	calc_wb_limits(rwb);
 	rwb_trace_step(rwb, "step down");
 }
@@ -675,7 +675,7 @@ void wbt_disable(struct rq_wb *rwb)
 }
 EXPORT_SYMBOL_GPL(wbt_disable);
 
-int wbt_init(struct request_queue *q, struct wb_stat_ops *ops)
+int wbt_init(struct request_queue *q)
 {
 	struct rq_wb *rwb;
 	int i;
@@ -688,9 +688,6 @@ int wbt_init(struct request_queue *q, struct wb_stat_ops *ops)
 	BUILD_BUG_ON(RWB_WINDOW_NSEC > BLK_STAT_NSEC);
 	BUILD_BUG_ON(WBT_NR_BITS > BLK_STAT_RES_BITS);
 
-	if (!ops->get || !ops->is_current || !ops->clear)
-		return -EINVAL;
-
 	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
 	if (!rwb)
 		return -ENOMEM;
@@ -706,8 +703,6 @@ int wbt_init(struct request_queue *q, struct wb_stat_ops *ops)
 	rwb->last_comp = rwb->last_issue = jiffies;
 	rwb->queue = q;
 	rwb->win_nsec = RWB_WINDOW_NSEC;
-	rwb->stat_ops = ops;
-	rwb->ops_data = q;
 	wbt_update_limits(rwb);
 
 	/*
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 09c61a3f8295..44dc2173dc1f 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -46,12 +46,6 @@ static inline bool wbt_is_read(struct blk_issue_stat *stat)
 	return (stat->time >> BLK_STAT_SHIFT) & WBT_READ;
 }
 
-struct wb_stat_ops {
-	void (*get)(void *, struct blk_rq_stat *);
-	bool (*is_current)(struct blk_rq_stat *);
-	void (*clear)(void *);
-};
-
 struct rq_wait {
 	wait_queue_head_t wait;
 	atomic_t inflight;
@@ -89,9 +83,6 @@ struct rq_wb {
 	unsigned long min_lat_nsec;
 	struct request_queue *queue;
 	struct rq_wait rq_wait[WBT_NUM_RWQ];
-
-	struct wb_stat_ops *stat_ops;
-	void *ops_data;
 };
 
 static inline unsigned int wbt_inflight(struct rq_wb *rwb)
@@ -109,7 +100,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 void __wbt_done(struct rq_wb *, enum wbt_flags);
 void wbt_done(struct rq_wb *, struct blk_issue_stat *);
 enum wbt_flags wbt_wait(struct rq_wb *, struct bio *, spinlock_t *);
-int wbt_init(struct request_queue *, struct wb_stat_ops *);
+int wbt_init(struct request_queue *);
 void wbt_exit(struct request_queue *);
 void wbt_update_limits(struct rq_wb *);
 void wbt_requeue(struct rq_wb *, struct blk_issue_stat *);
@@ -132,7 +123,7 @@ static inline enum wbt_flags wbt_wait(struct rq_wb *rwb, struct bio *bio,
 {
 	return 0;
 }
-static inline int wbt_init(struct request_queue *q, struct wb_stat_ops *ops)
+static inline int wbt_init(struct request_queue *q)
 {
 	return -EINVAL;
 }
-- 
2.7.4
