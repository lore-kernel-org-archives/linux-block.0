Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34971 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753197AbdCNVEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2017 17:04:33 -0400
Received: by mail-pg0-f41.google.com with SMTP id b129so95975449pgc.2
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2017 14:04:32 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 3/4] block: change stats from array type to struct type
Date: Tue, 14 Mar 2017 14:03:30 -0700
Message-Id: <2a1c729ecfce9e8fd31802b93375fca925a9195a.1489524591.git.osandov@fb.com>
In-Reply-To: <cover.1489524591.git.osandov@fb.com>
References: <cover.1489524591.git.osandov@fb.com>
In-Reply-To: <cover.1489524591.git.osandov@fb.com>
References: <cover.1489524591.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is cleanup in preparation for callback-based stats with a couple of
(minor) advantages:

1. Allocating a percpu array type is awkward.
2. It makes the callback type signature more clear. With `struct
   blk_rq_stat *`, the only way to know that you're getting an array of
   read and write stats is to look at the implementation or other users.
   With the struct type, it's immediately obvious.

Note that I left q->rq_stats and ctx->stat alone since those are going
away anyways.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c             | 14 +++++++-------
 block/blk-stat.c           | 34 +++++++++++++++++-----------------
 block/blk-stat.h           |  4 ++--
 block/blk-wbt.c            | 28 ++++++++++++++--------------
 include/linux/blk_types.h  |  5 +++++
 include/trace/events/wbt.h | 20 ++++++++++----------
 6 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eb84daf550f4..e16f8d420683 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2743,7 +2743,7 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx,
 				       struct request *rq)
 {
-	struct blk_rq_stat stat[2];
+	struct blk_stats stats;
 	unsigned long ret = 0;
 
 	/*
@@ -2757,8 +2757,8 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	 * We don't have to do this once per IO, should optimize this
 	 * to just use the current window of stats until it changes
 	 */
-	memset(&stat, 0, sizeof(stat));
-	blk_hctx_stat_get(hctx, stat);
+	memset(&stats, 0, sizeof(stats));
+	blk_hctx_stat_get(hctx, &stats);
 
 	/*
 	 * As an optimistic guess, use half of the mean service time
@@ -2768,10 +2768,10 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	 * important on devices where the completion latencies are longer
 	 * than ~10 usec.
 	 */
-	if (req_op(rq) == REQ_OP_READ && stat[BLK_STAT_READ].nr_samples)
-		ret = (stat[BLK_STAT_READ].mean + 1) / 2;
-	else if (req_op(rq) == REQ_OP_WRITE && stat[BLK_STAT_WRITE].nr_samples)
-		ret = (stat[BLK_STAT_WRITE].mean + 1) / 2;
+	if (req_op(rq) == REQ_OP_READ && stats.read.nr_samples)
+		ret = (stats.read.mean + 1) / 2;
+	else if (req_op(rq) == REQ_OP_WRITE && stats.write.nr_samples)
+		ret = (stats.write.mean + 1) / 2;
 
 	return ret;
 }
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 9b43efb8933f..40f6c90e432a 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -48,15 +48,15 @@ static void blk_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->nr_samples += src->nr_samples;
 }
 
-static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
+static void blk_mq_stat_get(struct request_queue *q, struct blk_stats *stats)
 {
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	uint64_t latest = 0;
 	int i, j, nr;
 
-	blk_stat_init(&dst[BLK_STAT_READ]);
-	blk_stat_init(&dst[BLK_STAT_WRITE]);
+	blk_stat_init(&stats->read);
+	blk_stat_init(&stats->write);
 
 	nr = 0;
 	do {
@@ -89,12 +89,12 @@ static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
 		queue_for_each_hw_ctx(q, hctx, i) {
 			hctx_for_each_ctx(hctx, ctx, j) {
 				if (ctx->stat[BLK_STAT_READ].time == newest) {
-					blk_stat_sum(&dst[BLK_STAT_READ],
+					blk_stat_sum(&stats->read,
 						     &ctx->stat[BLK_STAT_READ]);
 					nr++;
 				}
 				if (ctx->stat[BLK_STAT_WRITE].time == newest) {
-					blk_stat_sum(&dst[BLK_STAT_WRITE],
+					blk_stat_sum(&stats->write,
 						     &ctx->stat[BLK_STAT_WRITE]);
 					nr++;
 				}
@@ -106,24 +106,24 @@ static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
 		 */
 	} while (!nr);
 
-	dst[BLK_STAT_READ].time = dst[BLK_STAT_WRITE].time = latest;
+	stats->read.time = stats->write.time = latest;
 }
 
-void blk_queue_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
+void blk_queue_stat_get(struct request_queue *q, struct blk_stats *stats)
 {
 	if (q->mq_ops)
-		blk_mq_stat_get(q, dst);
+		blk_mq_stat_get(q, stats);
 	else {
 		blk_stat_flush_batch(&q->rq_stats[BLK_STAT_READ]);
 		blk_stat_flush_batch(&q->rq_stats[BLK_STAT_WRITE]);
-		memcpy(&dst[BLK_STAT_READ], &q->rq_stats[BLK_STAT_READ],
-				sizeof(struct blk_rq_stat));
-		memcpy(&dst[BLK_STAT_WRITE], &q->rq_stats[BLK_STAT_WRITE],
-				sizeof(struct blk_rq_stat));
+		memcpy(&stats->read, &q->rq_stats[BLK_STAT_READ],
+		       sizeof(struct blk_rq_stat));
+		memcpy(&stats->write, &q->rq_stats[BLK_STAT_WRITE],
+		       sizeof(struct blk_rq_stat));
 	}
 }
 
-void blk_hctx_stat_get(struct blk_mq_hw_ctx *hctx, struct blk_rq_stat *dst)
+void blk_hctx_stat_get(struct blk_mq_hw_ctx *hctx, struct blk_stats *stats)
 {
 	struct blk_mq_ctx *ctx;
 	unsigned int i, nr;
@@ -151,13 +151,13 @@ void blk_hctx_stat_get(struct blk_mq_hw_ctx *hctx, struct blk_rq_stat *dst)
 
 		hctx_for_each_ctx(hctx, ctx, i) {
 			if (ctx->stat[BLK_STAT_READ].time == newest) {
-				blk_stat_sum(&dst[BLK_STAT_READ],
-						&ctx->stat[BLK_STAT_READ]);
+				blk_stat_sum(&stats->read,
+					     &ctx->stat[BLK_STAT_READ]);
 				nr++;
 			}
 			if (ctx->stat[BLK_STAT_WRITE].time == newest) {
-				blk_stat_sum(&dst[BLK_STAT_WRITE],
-						&ctx->stat[BLK_STAT_WRITE]);
+				blk_stat_sum(&stats->write,
+					     &ctx->stat[BLK_STAT_WRITE]);
 				nr++;
 			}
 		}
diff --git a/block/blk-stat.h b/block/blk-stat.h
index a2050a0a5314..a24439aab710 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -21,8 +21,8 @@ enum {
 };
 
 void blk_stat_add(struct blk_rq_stat *, struct request *);
-void blk_hctx_stat_get(struct blk_mq_hw_ctx *, struct blk_rq_stat *);
-void blk_queue_stat_get(struct request_queue *, struct blk_rq_stat *);
+void blk_hctx_stat_get(struct blk_mq_hw_ctx *, struct blk_stats *);
+void blk_queue_stat_get(struct request_queue *, struct blk_stats *);
 void blk_stat_clear(struct request_queue *);
 void blk_stat_init(struct blk_rq_stat *);
 bool blk_stat_is_current(struct blk_rq_stat *);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 1aedb1f7ee0c..5e81068f7c52 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -247,7 +247,7 @@ static bool calc_wb_limits(struct rq_wb *rwb)
 	return ret;
 }
 
-static inline bool stat_sample_valid(struct blk_rq_stat *stat)
+static inline bool stat_sample_valid(struct blk_stats *stats)
 {
 	/*
 	 * We need at least one read sample, and a minimum of
@@ -255,8 +255,8 @@ static inline bool stat_sample_valid(struct blk_rq_stat *stat)
 	 * that it's writes impacting us, and not just some sole read on
 	 * a device that is in a lower power state.
 	 */
-	return stat[BLK_STAT_READ].nr_samples >= 1 &&
-		stat[BLK_STAT_WRITE].nr_samples >= RWB_MIN_WRITE_SAMPLES;
+	return (stats->read.nr_samples >= 1 &&
+		stats->write.nr_samples >= RWB_MIN_WRITE_SAMPLES);
 }
 
 static u64 rwb_sync_issue_lat(struct rq_wb *rwb)
@@ -277,7 +277,7 @@ enum {
 	LAT_EXCEEDED,
 };
 
-static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
+static int __latency_exceeded(struct rq_wb *rwb, struct blk_stats *stats)
 {
 	struct backing_dev_info *bdi = rwb->queue->backing_dev_info;
 	u64 thislat;
@@ -293,7 +293,7 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 	 */
 	thislat = rwb_sync_issue_lat(rwb);
 	if (thislat > rwb->cur_win_nsec ||
-	    (thislat > rwb->min_lat_nsec && !stat[BLK_STAT_READ].nr_samples)) {
+	    (thislat > rwb->min_lat_nsec && !stats->read.nr_samples)) {
 		trace_wbt_lat(bdi, thislat);
 		return LAT_EXCEEDED;
 	}
@@ -301,14 +301,14 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 	/*
 	 * No read/write mix, if stat isn't valid
 	 */
-	if (!stat_sample_valid(stat)) {
+	if (!stat_sample_valid(stats)) {
 		/*
 		 * If we had writes in this stat window and the window is
 		 * current, we're only doing writes. If a task recently
 		 * waited or still has writes in flights, consider us doing
 		 * just writes as well.
 		 */
-		if ((stat[BLK_STAT_WRITE].nr_samples && blk_stat_is_current(stat)) ||
+		if ((stats->write.nr_samples && blk_stat_is_current(&stats->read)) ||
 		    wb_recent_wait(rwb) || wbt_inflight(rwb))
 			return LAT_UNKNOWN_WRITES;
 		return LAT_UNKNOWN;
@@ -317,24 +317,24 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 	/*
 	 * If the 'min' latency exceeds our target, step down.
 	 */
-	if (stat[BLK_STAT_READ].min > rwb->min_lat_nsec) {
-		trace_wbt_lat(bdi, stat[BLK_STAT_READ].min);
-		trace_wbt_stat(bdi, stat);
+	if (stats->read.min > rwb->min_lat_nsec) {
+		trace_wbt_lat(bdi, stats->read.min);
+		trace_wbt_stat(bdi, stats);
 		return LAT_EXCEEDED;
 	}
 
 	if (rwb->scale_step)
-		trace_wbt_stat(bdi, stat);
+		trace_wbt_stat(bdi, stats);
 
 	return LAT_OK;
 }
 
 static int latency_exceeded(struct rq_wb *rwb)
 {
-	struct blk_rq_stat stat[2];
+	struct blk_stats stats;
 
-	blk_queue_stat_get(rwb->queue, stat);
-	return __latency_exceeded(rwb, stat);
+	blk_queue_stat_get(rwb->queue, &stats);
+	return __latency_exceeded(rwb, &stats);
 }
 
 static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index d703acb55d0f..5e4c5380edf0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -299,4 +299,9 @@ struct blk_rq_stat {
 	s64 time;
 };
 
+struct blk_stats {
+	struct blk_rq_stat read;
+	struct blk_rq_stat write;
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/trace/events/wbt.h b/include/trace/events/wbt.h
index 3c518e455680..5b7f8ef73532 100644
--- a/include/trace/events/wbt.h
+++ b/include/trace/events/wbt.h
@@ -13,9 +13,9 @@
  */
 TRACE_EVENT(wbt_stat,
 
-	TP_PROTO(struct backing_dev_info *bdi, struct blk_rq_stat *stat),
+	TP_PROTO(struct backing_dev_info *bdi, struct blk_stats *stats),
 
-	TP_ARGS(bdi, stat),
+	TP_ARGS(bdi, stats),
 
 	TP_STRUCT__entry(
 		__array(char, name, 32)
@@ -33,14 +33,14 @@ TRACE_EVENT(wbt_stat,
 
 	TP_fast_assign(
 		strncpy(__entry->name, dev_name(bdi->dev), 32);
-		__entry->rmean		= stat[0].mean;
-		__entry->rmin		= stat[0].min;
-		__entry->rmax		= stat[0].max;
-		__entry->rnr_samples	= stat[0].nr_samples;
-		__entry->wmean		= stat[1].mean;
-		__entry->wmin		= stat[1].min;
-		__entry->wmax		= stat[1].max;
-		__entry->wnr_samples	= stat[1].nr_samples;
+		__entry->rmean		= stats->read.mean;
+		__entry->rmin		= stats->read.min;
+		__entry->rmax		= stats->read.max;
+		__entry->rnr_samples	= stats->read.nr_samples;
+		__entry->wmean		= stats->write.mean;
+		__entry->wmin		= stats->write.min;
+		__entry->wmax		= stats->write.max;
+		__entry->wnr_samples	= stats->write.nr_samples;
 	),
 
 	TP_printk("%s: rmean=%llu, rmin=%llu, rmax=%llu, rsamples=%llu, "
-- 
2.12.0
