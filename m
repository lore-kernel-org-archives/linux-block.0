Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 1/3] block: track request size in blk_issue_stat
Date: Mon, 27 Mar 2017 15:19:41 -0700
Message-ID: <d7e635142006dd93f831d1cef136c6fb6a8e5b22.1490651903.git.shli@fb.com>
In-Reply-To: <cover.1490651903.git.shli@fb.com>
References: <567d5361-7d6b-c53e-8ada-a2966e48dc54@fb.com> <cover.1490651903.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Currently there is no way to know the request size when the request is
finished. Next patch will need this info. We could add extra field to
record the size, but blk_issue_stat has enough space to record it, so
this patch just overloads blk_issue_stat. With this, we will have 49bits
to track time, which still is very long time.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-core.c          |  2 +-
 block/blk-mq.c            |  2 +-
 block/blk-stat.h          | 41 ++++++++++++++++++++++++++++++-----------
 block/blk-wbt.h           | 10 +++++-----
 include/linux/blk_types.h |  2 +-
 5 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ad388d5e..4234332 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2483,7 +2483,7 @@ void blk_start_request(struct request *req)
 	blk_dequeue_request(req);
 
 	if (test_bit(QUEUE_FLAG_STATS, &req->q->queue_flags)) {
-		blk_stat_set_issue_time(&req->issue_stat);
+		blk_stat_set_issue(&req->issue_stat, blk_rq_sectors(req));
 		req->rq_flags |= RQF_STATS;
 		wbt_issue(req->q->rq_wb, &req->issue_stat);
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 45b9beb..caef6ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -488,7 +488,7 @@ void blk_mq_start_request(struct request *rq)
 	trace_block_rq_issue(q, rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		blk_stat_set_issue_time(&rq->issue_stat);
+		blk_stat_set_issue(&rq->issue_stat, blk_rq_sectors(rq));
 		rq->rq_flags |= RQF_STATS;
 		wbt_issue(q->rq_wb, &rq->issue_stat);
 	}
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 6ad5b8c..ee47f81 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -8,12 +8,19 @@
 #include <linux/timer.h>
 
 /*
- * Upper 3 bits can be used elsewhere
+ * from upper:
+ * 3 bits: reserved for other usage
+ * 12 bits: size
+ * 49 bits: time
  */
 #define BLK_STAT_RES_BITS	3
-#define BLK_STAT_SHIFT		(64 - BLK_STAT_RES_BITS)
-#define BLK_STAT_TIME_MASK	((1ULL << BLK_STAT_SHIFT) - 1)
-#define BLK_STAT_MASK		~BLK_STAT_TIME_MASK
+#define BLK_STAT_SIZE_BITS	12
+#define BLK_STAT_RES_SHIFT	(64 - BLK_STAT_RES_BITS)
+#define BLK_STAT_SIZE_SHIFT	(BLK_STAT_RES_SHIFT - BLK_STAT_SIZE_BITS)
+#define BLK_STAT_TIME_MASK	((1ULL << BLK_STAT_SIZE_SHIFT) - 1)
+#define BLK_STAT_SIZE_MASK	\
+	(((1ULL << BLK_STAT_SIZE_BITS) - 1) << BLK_STAT_SIZE_SHIFT)
+#define BLK_STAT_RES_MASK	(~((1ULL << BLK_STAT_RES_SHIFT) - 1))
 
 /**
  * struct blk_stat_callback - Block statistics callback.
@@ -73,12 +80,6 @@ void blk_free_queue_stats(struct blk_queue_stats *);
 
 void blk_stat_add(struct request *);
 
-static inline void blk_stat_set_issue_time(struct blk_issue_stat *stat)
-{
-	stat->time = ((stat->time & BLK_STAT_MASK) |
-		      (ktime_to_ns(ktime_get()) & BLK_STAT_TIME_MASK));
-}
-
 static inline u64 __blk_stat_time(u64 time)
 {
 	return time & BLK_STAT_TIME_MASK;
@@ -86,7 +87,25 @@ static inline u64 __blk_stat_time(u64 time)
 
 static inline u64 blk_stat_time(struct blk_issue_stat *stat)
 {
-	return __blk_stat_time(stat->time);
+	return __blk_stat_time(stat->stat);
+}
+
+static inline sector_t blk_capped_size(sector_t size)
+{
+	return size & ((1ULL << BLK_STAT_SIZE_BITS) - 1);
+}
+
+static inline sector_t blk_stat_size(struct blk_issue_stat *stat)
+{
+	return (stat->stat & BLK_STAT_SIZE_MASK) >> BLK_STAT_SIZE_SHIFT;
+}
+
+static inline void blk_stat_set_issue(struct blk_issue_stat *stat,
+	sector_t size)
+{
+	stat->stat = (stat->stat & BLK_STAT_RES_MASK) |
+		(ktime_to_ns(ktime_get()) & BLK_STAT_TIME_MASK) |
+		(((u64)blk_capped_size(size)) << BLK_STAT_SIZE_SHIFT);
 }
 
 /*
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 591ff2f..ad6c785 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -32,27 +32,27 @@ enum {
 
 static inline void wbt_clear_state(struct blk_issue_stat *stat)
 {
-	stat->time &= BLK_STAT_TIME_MASK;
+	stat->stat &= ~BLK_STAT_RES_MASK;
 }
 
 static inline enum wbt_flags wbt_stat_to_mask(struct blk_issue_stat *stat)
 {
-	return (stat->time & BLK_STAT_MASK) >> BLK_STAT_SHIFT;
+	return (stat->stat & BLK_STAT_RES_MASK) >> BLK_STAT_RES_SHIFT;
 }
 
 static inline void wbt_track(struct blk_issue_stat *stat, enum wbt_flags wb_acct)
 {
-	stat->time |= ((u64) wb_acct) << BLK_STAT_SHIFT;
+	stat->stat |= ((u64) wb_acct) << BLK_STAT_RES_SHIFT;
 }
 
 static inline bool wbt_is_tracked(struct blk_issue_stat *stat)
 {
-	return (stat->time >> BLK_STAT_SHIFT) & WBT_TRACKED;
+	return (stat->stat >> BLK_STAT_RES_SHIFT) & WBT_TRACKED;
 }
 
 static inline bool wbt_is_read(struct blk_issue_stat *stat)
 {
-	return (stat->time >> BLK_STAT_SHIFT) & WBT_READ;
+	return (stat->stat >> BLK_STAT_RES_SHIFT) & WBT_READ;
 }
 
 struct rq_wait {
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 07a9e96..3ad5673 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -287,7 +287,7 @@ static inline bool blk_qc_t_is_internal(blk_qc_t cookie)
 }
 
 struct blk_issue_stat {
-	u64 time;
+	u64 stat;
 };
 
 struct blk_rq_stat {
-- 
2.9.3
