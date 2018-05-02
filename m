Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46634 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeEBRep (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 May 2018 13:34:45 -0400
Received: by mail-pf0-f194.google.com with SMTP id p12so12359574pff.13
        for <linux-block@vger.kernel.org>; Wed, 02 May 2018 10:34:45 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 4/7] block: get rid of struct blk_issue_stat
Date: Wed,  2 May 2018 10:34:23 -0700
Message-Id: <068fdcc508f873d3000de469c2dcdd847590f4a3.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

struct blk_issue_stat squashes three things into one u64:

- The time the driver started working on a request
- The original size of the request (for the io.low controller)
- Flags for writeback throttling

It turns out that on x86_64, we have a 4 byte hole in struct request
which we can fill with the non-timestamp fields from blk_issue_stat,
simplifying things quite a bit.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c          |  5 ++++-
 block/blk-mq.c            |  8 ++++++--
 block/blk-stat.c          |  7 ++-----
 block/blk-stat.h          | 43 ---------------------------------------
 block/blk-throttle.c      |  3 +--
 block/blk-wbt.c           | 12 +++++------
 block/blk-wbt.h           |  4 ++--
 block/kyber-iosched.c     |  6 +++---
 include/linux/blk_types.h |  4 ----
 include/linux/blkdev.h    | 26 +++++++++++++++--------
 10 files changed, 41 insertions(+), 77 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 851ea3c0c0b4..02b0cc23fd1b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2992,7 +2992,10 @@ void blk_start_request(struct request *req)
 	blk_dequeue_request(req);
 
 	if (test_bit(QUEUE_FLAG_STATS, &req->q->queue_flags)) {
-		blk_stat_set_issue(&req->issue_stat, blk_rq_sectors(req));
+		req->io_start_time_ns = ktime_get_ns();
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+		req->throtl_size = blk_rq_sectors(req);
+#endif
 		req->rq_flags |= RQF_STATS;
 		wbt_issue(req->q->rq_wb, req);
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5c9e3ea6cc4e..9fa8069af032 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -294,6 +294,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->rq_disk = NULL;
 	rq->part = NULL;
 	rq->start_time = jiffies;
+	rq->io_start_time_ns = 0;
 	rq->nr_phys_segments = 0;
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
 	rq->nr_integrity_segments = 0;
@@ -313,7 +314,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 #ifdef CONFIG_BLK_CGROUP
 	rq->rl = NULL;
 	set_start_time_ns(rq);
-	rq->io_start_time_ns = 0;
+	rq->cgroup_io_start_time_ns = 0;
 #endif
 
 	data->ctx->rq_dispatched[op_is_sync(op)]++;
@@ -653,7 +654,10 @@ void blk_mq_start_request(struct request *rq)
 	trace_block_rq_issue(q, rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		blk_stat_set_issue(&rq->issue_stat, blk_rq_sectors(rq));
+		rq->io_start_time_ns = ktime_get_ns();
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+		rq->throtl_size = blk_rq_sectors(rq);
+#endif
 		rq->rq_flags |= RQF_STATS;
 		wbt_issue(q->rq_wb, rq);
 	}
diff --git a/block/blk-stat.c b/block/blk-stat.c
index bd365a95fcf8..725a881723b0 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -55,11 +55,8 @@ void blk_stat_add(struct request *rq)
 	int bucket;
 	u64 now, value;
 
-	now = __blk_stat_time(ktime_to_ns(ktime_get()));
-	if (now < blk_stat_time(&rq->issue_stat))
-		return;
-
-	value = now - blk_stat_time(&rq->issue_stat);
+	now = ktime_get_ns();
+	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
 
 	blk_throtl_stat_add(rq, value);
 
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 2dd36347252a..17c812db0aca 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -8,21 +8,6 @@
 #include <linux/rcupdate.h>
 #include <linux/timer.h>
 
-/*
- * from upper:
- * 3 bits: reserved for other usage
- * 12 bits: size
- * 49 bits: time
- */
-#define BLK_STAT_RES_BITS	3
-#define BLK_STAT_SIZE_BITS	12
-#define BLK_STAT_RES_SHIFT	(64 - BLK_STAT_RES_BITS)
-#define BLK_STAT_SIZE_SHIFT	(BLK_STAT_RES_SHIFT - BLK_STAT_SIZE_BITS)
-#define BLK_STAT_TIME_MASK	((1ULL << BLK_STAT_SIZE_SHIFT) - 1)
-#define BLK_STAT_SIZE_MASK	\
-	(((1ULL << BLK_STAT_SIZE_BITS) - 1) << BLK_STAT_SIZE_SHIFT)
-#define BLK_STAT_RES_MASK	(~((1ULL << BLK_STAT_RES_SHIFT) - 1))
-
 /**
  * struct blk_stat_callback - Block statistics callback.
  *
@@ -82,34 +67,6 @@ void blk_free_queue_stats(struct blk_queue_stats *);
 
 void blk_stat_add(struct request *);
 
-static inline u64 __blk_stat_time(u64 time)
-{
-	return time & BLK_STAT_TIME_MASK;
-}
-
-static inline u64 blk_stat_time(struct blk_issue_stat *stat)
-{
-	return __blk_stat_time(stat->stat);
-}
-
-static inline sector_t blk_capped_size(sector_t size)
-{
-	return size & ((1ULL << BLK_STAT_SIZE_BITS) - 1);
-}
-
-static inline sector_t blk_stat_size(struct blk_issue_stat *stat)
-{
-	return (stat->stat & BLK_STAT_SIZE_MASK) >> BLK_STAT_SIZE_SHIFT;
-}
-
-static inline void blk_stat_set_issue(struct blk_issue_stat *stat,
-	sector_t size)
-{
-	stat->stat = (stat->stat & BLK_STAT_RES_MASK) |
-		(ktime_to_ns(ktime_get()) & BLK_STAT_TIME_MASK) |
-		(((u64)blk_capped_size(size)) << BLK_STAT_SIZE_SHIFT);
-}
-
 /* record time/size info in request but not add a callback */
 void blk_stat_enable_accounting(struct request_queue *q);
 
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index e2957a93ed11..0b75eaa7acb9 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2310,8 +2310,7 @@ void blk_throtl_stat_add(struct request *rq, u64 time_ns)
 	struct request_queue *q = rq->q;
 	struct throtl_data *td = q->td;
 
-	throtl_track_latency(td, blk_stat_size(&rq->issue_stat),
-		req_op(rq), time_ns >> 10);
+	throtl_track_latency(td, rq->throtl_size, req_op(rq), time_ns >> 10);
 }
 
 void blk_throtl_bio_endio(struct bio *bio)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 10aecfadc57d..903283d15ee4 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -31,22 +31,22 @@
 
 static inline void wbt_clear_state(struct request *rq)
 {
-	rq->issue_stat.stat &= ~BLK_STAT_RES_MASK;
+	rq->wbt_flags = 0;
 }
 
 static inline enum wbt_flags wbt_flags(struct request *rq)
 {
-	return (rq->issue_stat.stat & BLK_STAT_RES_MASK) >> BLK_STAT_RES_SHIFT;
+	return rq->wbt_flags;
 }
 
 static inline bool wbt_is_tracked(struct request *rq)
 {
-	return (rq->issue_stat.stat >> BLK_STAT_RES_SHIFT) & WBT_TRACKED;
+	return rq->wbt_flags & WBT_TRACKED;
 }
 
 static inline bool wbt_is_read(struct request *rq)
 {
-	return (rq->issue_stat.stat >> BLK_STAT_RES_SHIFT) & WBT_READ;
+	return rq->wbt_flags & WBT_READ;
 }
 
 enum {
@@ -643,7 +643,7 @@ void wbt_issue(struct rq_wb *rwb, struct request *rq)
 	 */
 	if (wbt_is_read(rq) && !rwb->sync_issue) {
 		rwb->sync_cookie = rq;
-		rwb->sync_issue = blk_stat_time(&rq->issue_stat);
+		rwb->sync_issue = rq->io_start_time_ns;
 	}
 }
 
@@ -732,8 +732,6 @@ int wbt_init(struct request_queue *q)
 	struct rq_wb *rwb;
 	int i;
 
-	BUILD_BUG_ON(WBT_NR_BITS > BLK_STAT_RES_BITS);
-
 	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
 	if (!rwb)
 		return -ENOMEM;
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index dd9211fa853f..9e09de29a28e 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -59,7 +59,7 @@ struct rq_wb {
 
 	struct blk_stat_callback *cb;
 
-	s64 sync_issue;
+	u64 sync_issue;
 	void *sync_cookie;
 
 	unsigned int wc;
@@ -86,7 +86,7 @@ static inline unsigned int wbt_inflight(struct rq_wb *rwb)
 
 static inline void wbt_track(struct request *rq, enum wbt_flags flags)
 {
-	rq->issue_stat.stat |= ((u64)flags) << BLK_STAT_RES_SHIFT;
+	rq->wbt_flags |= flags;
 }
 
 void __wbt_done(struct rq_wb *, enum wbt_flags);
diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index 0d6d25e32e1f..564967fafe5f 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -485,11 +485,11 @@ static void kyber_completed_request(struct request *rq)
 	if (blk_stat_is_active(kqd->cb))
 		return;
 
-	now = __blk_stat_time(ktime_to_ns(ktime_get()));
-	if (now < blk_stat_time(&rq->issue_stat))
+	now = ktime_get_ns();
+	if (now < rq->io_start_time_ns)
 		return;
 
-	latency = now - blk_stat_time(&rq->issue_stat);
+	latency = now - rq->io_start_time_ns;
 
 	if (latency > target)
 		blk_stat_activate_msecs(kqd->cb, 10);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3a263538d315..7b55513407ee 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -90,10 +90,6 @@ static inline bool blk_path_error(blk_status_t error)
 	return true;
 }
 
-struct blk_issue_stat {
-	u64 stat;
-};
-
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5c4eee043191..f2c2fc011e6b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -206,8 +206,18 @@ struct request {
 	struct gendisk *rq_disk;
 	struct hd_struct *part;
 	unsigned long start_time;
-	struct blk_issue_stat issue_stat;
-	/* Number of scatter-gather DMA addr+len pairs after
+	/* Time that I/O was submitted to the device. */
+	u64 io_start_time_ns;
+
+#ifdef CONFIG_BLK_WBT
+	unsigned short wbt_flags;
+#endif
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	unsigned short throtl_size;
+#endif
+
+	/*
+	 * Number of scatter-gather DMA addr+len pairs after
 	 * physical address coalescing is performed.
 	 */
 	unsigned short nr_phys_segments;
@@ -267,8 +277,8 @@ struct request {
 
 #ifdef CONFIG_BLK_CGROUP
 	struct request_list *rl;		/* rl this rq is alloced from */
-	unsigned long long start_time_ns;
-	unsigned long long io_start_time_ns;    /* when passed to hardware */
+	unsigned long long cgroup_start_time_ns;
+	unsigned long long cgroup_io_start_time_ns;    /* when passed to hardware */
 #endif
 };
 
@@ -1797,25 +1807,25 @@ int kblockd_mod_delayed_work_on(int cpu, struct delayed_work *dwork, unsigned lo
 static inline void set_start_time_ns(struct request *req)
 {
 	preempt_disable();
-	req->start_time_ns = sched_clock();
+	req->cgroup_start_time_ns = sched_clock();
 	preempt_enable();
 }
 
 static inline void set_io_start_time_ns(struct request *req)
 {
 	preempt_disable();
-	req->io_start_time_ns = sched_clock();
+	req->cgroup_io_start_time_ns = sched_clock();
 	preempt_enable();
 }
 
 static inline uint64_t rq_start_time_ns(struct request *req)
 {
-        return req->start_time_ns;
+	return req->cgroup_start_time_ns;
 }
 
 static inline uint64_t rq_io_start_time_ns(struct request *req)
 {
-        return req->io_start_time_ns;
+	return req->cgroup_io_start_time_ns;
 }
 #else
 static inline void set_start_time_ns(struct request *req) {}
-- 
2.17.0
