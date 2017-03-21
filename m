Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34165 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757127AbdCUP5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2017 11:57:09 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so62554798pgg.1
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2017 08:57:08 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2 2/4] blk-stat: use READ and WRITE instead of BLK_STAT_{READ,WRITE}
Date: Tue, 21 Mar 2017 08:56:06 -0700
Message-Id: <2923a6150e86b5949b0dfa8f984c9b2d4a3bde0d.1490110621.git.osandov@fb.com>
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
References: <cover.1490110621.git.osandov@fb.com>
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
References: <cover.1490110621.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The stats buckets will become generic soon, so make the existing users
use the common READ and WRITE definitions instead of one internal to
blk-stat.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 12 ++++----
 block/blk-mq.c         | 12 ++++----
 block/blk-stat.c       | 80 ++++++++++++++++++++++++--------------------------
 block/blk-stat.h       |  5 ----
 block/blk-sysfs.c      |  4 +--
 block/blk-wbt.c        | 12 ++++----
 6 files changed, 59 insertions(+), 66 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f6d917977b33..48c88723944a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -333,17 +333,17 @@ static int hctx_stats_show(struct seq_file *m, void *v)
 	struct blk_mq_hw_ctx *hctx = m->private;
 	struct blk_rq_stat stat[2];
 
-	blk_stat_init(&stat[BLK_STAT_READ]);
-	blk_stat_init(&stat[BLK_STAT_WRITE]);
+	blk_stat_init(&stat[READ]);
+	blk_stat_init(&stat[WRITE]);
 
 	blk_hctx_stat_get(hctx, stat);
 
 	seq_puts(m, "read: ");
-	print_stat(m, &stat[BLK_STAT_READ]);
+	print_stat(m, &stat[READ]);
 	seq_puts(m, "\n");
 
 	seq_puts(m, "write: ");
-	print_stat(m, &stat[BLK_STAT_WRITE]);
+	print_stat(m, &stat[WRITE]);
 	seq_puts(m, "\n");
 	return 0;
 }
@@ -362,8 +362,8 @@ static ssize_t hctx_stats_write(struct file *file, const char __user *buf,
 	int i;
 
 	hctx_for_each_ctx(hctx, ctx, i) {
-		blk_stat_init(&ctx->stat[BLK_STAT_READ]);
-		blk_stat_init(&ctx->stat[BLK_STAT_WRITE]);
+		blk_stat_init(&ctx->stat[READ]);
+		blk_stat_init(&ctx->stat[WRITE]);
 	}
 	return count;
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 534f49a90e3a..559e5363bb2c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2040,8 +2040,8 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		spin_lock_init(&__ctx->lock);
 		INIT_LIST_HEAD(&__ctx->rq_list);
 		__ctx->queue = q;
-		blk_stat_init(&__ctx->stat[BLK_STAT_READ]);
-		blk_stat_init(&__ctx->stat[BLK_STAT_WRITE]);
+		blk_stat_init(&__ctx->stat[READ]);
+		blk_stat_init(&__ctx->stat[WRITE]);
 
 		/* If the cpu isn't online, the cpu is mapped to first hctx */
 		if (!cpu_online(i))
@@ -2769,10 +2769,10 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	 * important on devices where the completion latencies are longer
 	 * than ~10 usec.
 	 */
-	if (req_op(rq) == REQ_OP_READ && stat[BLK_STAT_READ].nr_samples)
-		ret = (stat[BLK_STAT_READ].mean + 1) / 2;
-	else if (req_op(rq) == REQ_OP_WRITE && stat[BLK_STAT_WRITE].nr_samples)
-		ret = (stat[BLK_STAT_WRITE].mean + 1) / 2;
+	if (req_op(rq) == REQ_OP_READ && stat[READ].nr_samples)
+		ret = (stat[READ].mean + 1) / 2;
+	else if (req_op(rq) == REQ_OP_WRITE && stat[WRITE].nr_samples)
+		ret = (stat[WRITE].mean + 1) / 2;
 
 	return ret;
 }
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 186fcb981e9b..f80582be5344 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -55,8 +55,8 @@ static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
 	uint64_t latest = 0;
 	int i, j, nr;
 
-	blk_stat_init(&dst[BLK_STAT_READ]);
-	blk_stat_init(&dst[BLK_STAT_WRITE]);
+	blk_stat_init(&dst[READ]);
+	blk_stat_init(&dst[WRITE]);
 
 	nr = 0;
 	do {
@@ -64,16 +64,16 @@ static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
 
 		queue_for_each_hw_ctx(q, hctx, i) {
 			hctx_for_each_ctx(hctx, ctx, j) {
-				blk_stat_flush_batch(&ctx->stat[BLK_STAT_READ]);
-				blk_stat_flush_batch(&ctx->stat[BLK_STAT_WRITE]);
+				blk_stat_flush_batch(&ctx->stat[READ]);
+				blk_stat_flush_batch(&ctx->stat[WRITE]);
 
-				if (!ctx->stat[BLK_STAT_READ].nr_samples &&
-				    !ctx->stat[BLK_STAT_WRITE].nr_samples)
+				if (!ctx->stat[READ].nr_samples &&
+				    !ctx->stat[WRITE].nr_samples)
 					continue;
-				if (ctx->stat[BLK_STAT_READ].time > newest)
-					newest = ctx->stat[BLK_STAT_READ].time;
-				if (ctx->stat[BLK_STAT_WRITE].time > newest)
-					newest = ctx->stat[BLK_STAT_WRITE].time;
+				if (ctx->stat[READ].time > newest)
+					newest = ctx->stat[READ].time;
+				if (ctx->stat[WRITE].time > newest)
+					newest = ctx->stat[WRITE].time;
 			}
 		}
 
@@ -88,14 +88,14 @@ static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
 
 		queue_for_each_hw_ctx(q, hctx, i) {
 			hctx_for_each_ctx(hctx, ctx, j) {
-				if (ctx->stat[BLK_STAT_READ].time == newest) {
-					blk_stat_sum(&dst[BLK_STAT_READ],
-						     &ctx->stat[BLK_STAT_READ]);
+				if (ctx->stat[READ].time == newest) {
+					blk_stat_sum(&dst[READ],
+						     &ctx->stat[READ]);
 					nr++;
 				}
-				if (ctx->stat[BLK_STAT_WRITE].time == newest) {
-					blk_stat_sum(&dst[BLK_STAT_WRITE],
-						     &ctx->stat[BLK_STAT_WRITE]);
+				if (ctx->stat[WRITE].time == newest) {
+					blk_stat_sum(&dst[WRITE],
+						     &ctx->stat[WRITE]);
 					nr++;
 				}
 			}
@@ -106,7 +106,7 @@ static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
 		 */
 	} while (!nr);
 
-	dst[BLK_STAT_READ].time = dst[BLK_STAT_WRITE].time = latest;
+	dst[READ].time = dst[WRITE].time = latest;
 }
 
 void blk_queue_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
@@ -114,12 +114,12 @@ void blk_queue_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
 	if (q->mq_ops)
 		blk_mq_stat_get(q, dst);
 	else {
-		blk_stat_flush_batch(&q->rq_stats[BLK_STAT_READ]);
-		blk_stat_flush_batch(&q->rq_stats[BLK_STAT_WRITE]);
-		memcpy(&dst[BLK_STAT_READ], &q->rq_stats[BLK_STAT_READ],
-				sizeof(struct blk_rq_stat));
-		memcpy(&dst[BLK_STAT_WRITE], &q->rq_stats[BLK_STAT_WRITE],
-				sizeof(struct blk_rq_stat));
+		blk_stat_flush_batch(&q->rq_stats[READ]);
+		blk_stat_flush_batch(&q->rq_stats[WRITE]);
+		memcpy(&dst[READ], &q->rq_stats[READ],
+		       sizeof(struct blk_rq_stat));
+		memcpy(&dst[WRITE], &q->rq_stats[WRITE],
+		       sizeof(struct blk_rq_stat));
 	}
 }
 
@@ -133,31 +133,29 @@ void blk_hctx_stat_get(struct blk_mq_hw_ctx *hctx, struct blk_rq_stat *dst)
 		uint64_t newest = 0;
 
 		hctx_for_each_ctx(hctx, ctx, i) {
-			blk_stat_flush_batch(&ctx->stat[BLK_STAT_READ]);
-			blk_stat_flush_batch(&ctx->stat[BLK_STAT_WRITE]);
+			blk_stat_flush_batch(&ctx->stat[READ]);
+			blk_stat_flush_batch(&ctx->stat[WRITE]);
 
-			if (!ctx->stat[BLK_STAT_READ].nr_samples &&
-			    !ctx->stat[BLK_STAT_WRITE].nr_samples)
+			if (!ctx->stat[READ].nr_samples &&
+			    !ctx->stat[WRITE].nr_samples)
 				continue;
 
-			if (ctx->stat[BLK_STAT_READ].time > newest)
-				newest = ctx->stat[BLK_STAT_READ].time;
-			if (ctx->stat[BLK_STAT_WRITE].time > newest)
-				newest = ctx->stat[BLK_STAT_WRITE].time;
+			if (ctx->stat[READ].time > newest)
+				newest = ctx->stat[READ].time;
+			if (ctx->stat[WRITE].time > newest)
+				newest = ctx->stat[WRITE].time;
 		}
 
 		if (!newest)
 			break;
 
 		hctx_for_each_ctx(hctx, ctx, i) {
-			if (ctx->stat[BLK_STAT_READ].time == newest) {
-				blk_stat_sum(&dst[BLK_STAT_READ],
-						&ctx->stat[BLK_STAT_READ]);
+			if (ctx->stat[READ].time == newest) {
+				blk_stat_sum(&dst[READ], &ctx->stat[READ]);
 				nr++;
 			}
-			if (ctx->stat[BLK_STAT_WRITE].time == newest) {
-				blk_stat_sum(&dst[BLK_STAT_WRITE],
-						&ctx->stat[BLK_STAT_WRITE]);
+			if (ctx->stat[WRITE].time == newest) {
+				blk_stat_sum(&dst[WRITE], &ctx->stat[WRITE]);
 				nr++;
 			}
 		}
@@ -226,13 +224,13 @@ void blk_stat_clear(struct request_queue *q)
 
 		queue_for_each_hw_ctx(q, hctx, i) {
 			hctx_for_each_ctx(hctx, ctx, j) {
-				blk_stat_init(&ctx->stat[BLK_STAT_READ]);
-				blk_stat_init(&ctx->stat[BLK_STAT_WRITE]);
+				blk_stat_init(&ctx->stat[READ]);
+				blk_stat_init(&ctx->stat[WRITE]);
 			}
 		}
 	} else {
-		blk_stat_init(&q->rq_stats[BLK_STAT_READ]);
-		blk_stat_init(&q->rq_stats[BLK_STAT_WRITE]);
+		blk_stat_init(&q->rq_stats[READ]);
+		blk_stat_init(&q->rq_stats[WRITE]);
 	}
 }
 
diff --git a/block/blk-stat.h b/block/blk-stat.h
index a2050a0a5314..34384328b46b 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -15,11 +15,6 @@
 #define BLK_STAT_TIME_MASK	((1ULL << BLK_STAT_SHIFT) - 1)
 #define BLK_STAT_MASK		~BLK_STAT_TIME_MASK
 
-enum {
-	BLK_STAT_READ	= 0,
-	BLK_STAT_WRITE,
-};
-
 void blk_stat_add(struct blk_rq_stat *, struct request *);
 void blk_hctx_stat_get(struct blk_mq_hw_ctx *, struct blk_rq_stat *);
 void blk_queue_stat_get(struct request_queue *, struct blk_rq_stat *);
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c44b321335f3..fdb45fd0db0b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -518,8 +518,8 @@ static ssize_t queue_stats_show(struct request_queue *q, char *page)
 
 	blk_queue_stat_get(q, stat);
 
-	ret = print_stat(page, &stat[BLK_STAT_READ], "read :");
-	ret += print_stat(page + ret, &stat[BLK_STAT_WRITE], "write:");
+	ret = print_stat(page, &stat[READ], "read :");
+	ret += print_stat(page + ret, &stat[WRITE], "write:");
 	return ret;
 }
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 1aedb1f7ee0c..aafe5b551224 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -255,8 +255,8 @@ static inline bool stat_sample_valid(struct blk_rq_stat *stat)
 	 * that it's writes impacting us, and not just some sole read on
 	 * a device that is in a lower power state.
 	 */
-	return stat[BLK_STAT_READ].nr_samples >= 1 &&
-		stat[BLK_STAT_WRITE].nr_samples >= RWB_MIN_WRITE_SAMPLES;
+	return (stat[READ].nr_samples >= 1 &&
+		stat[WRITE].nr_samples >= RWB_MIN_WRITE_SAMPLES);
 }
 
 static u64 rwb_sync_issue_lat(struct rq_wb *rwb)
@@ -293,7 +293,7 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 	 */
 	thislat = rwb_sync_issue_lat(rwb);
 	if (thislat > rwb->cur_win_nsec ||
-	    (thislat > rwb->min_lat_nsec && !stat[BLK_STAT_READ].nr_samples)) {
+	    (thislat > rwb->min_lat_nsec && !stat[READ].nr_samples)) {
 		trace_wbt_lat(bdi, thislat);
 		return LAT_EXCEEDED;
 	}
@@ -308,7 +308,7 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 		 * waited or still has writes in flights, consider us doing
 		 * just writes as well.
 		 */
-		if ((stat[BLK_STAT_WRITE].nr_samples && blk_stat_is_current(stat)) ||
+		if ((stat[WRITE].nr_samples && blk_stat_is_current(stat)) ||
 		    wb_recent_wait(rwb) || wbt_inflight(rwb))
 			return LAT_UNKNOWN_WRITES;
 		return LAT_UNKNOWN;
@@ -317,8 +317,8 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 	/*
 	 * If the 'min' latency exceeds our target, step down.
 	 */
-	if (stat[BLK_STAT_READ].min > rwb->min_lat_nsec) {
-		trace_wbt_lat(bdi, stat[BLK_STAT_READ].min);
+	if (stat[READ].min > rwb->min_lat_nsec) {
+		trace_wbt_lat(bdi, stat[READ].min);
 		trace_wbt_stat(bdi, stat);
 		return LAT_EXCEEDED;
 	}
-- 
2.12.0
