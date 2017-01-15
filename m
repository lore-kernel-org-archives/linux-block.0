Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33784 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750922AbdAODmj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Jan 2017 22:42:39 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.20/8.16.0.20) with SMTP id v0F3fwwd022406
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:38 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 27yghf9jmv-4
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Sat, 14 Jan 2017 19:42:38 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.99) with ESMTP  id
 a7d4d8c2dad411e6beb50002c9dfb610-32dfba50 for <linux-block@vger.kernel.org>;
        Sat, 14 Jan 2017 19:42:36 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <tj@kernel.org>, <axboe@fb.com>,
        <vgoyal@redhat.com>
Subject: [PATCH V6 16/18] block: track request size in blk_issue_stat
Date: Sat, 14 Jan 2017 19:42:33 -0800
Message-ID: <e5b0c854d9c5b683537723e57041052d44e0091d.1484451062.git.shli@fb.com>
In-Reply-To: <cover.1484451062.git.shli@fb.com>
References: <cover.1484451062.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently there is no way to know the request size when the request is
finished. Next patch will need this info. We could add extra field to
record the size, but blk_issue_stat has enough space to record it, so
this patch just overloads blk_issue_stat. With this, we will have 49bits
to track time, which still is very long time.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-core.c          |  2 +-
 block/blk-mq.c            |  2 +-
 block/blk-stat.c          |  7 ++++---
 block/blk-stat.h          | 29 +++++++++++++++++++++++------
 block/blk-wbt.h           | 10 +++++-----
 include/linux/blk_types.h |  2 +-
 6 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 61ba08c..485c32d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2459,7 +2459,7 @@ void blk_start_request(struct request *req)
 	blk_dequeue_request(req);
 
 	if (test_bit(QUEUE_FLAG_STATS, &req->q->queue_flags)) {
-		blk_stat_set_issue_time(&req->issue_stat);
+		blk_stat_set_issue(&req->issue_stat, blk_rq_sectors(req));
 		req->rq_flags |= RQF_STATS;
 		wbt_issue(req->q->rq_wb, &req->issue_stat);
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a8e67a1..1ad172c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -474,7 +474,7 @@ void blk_mq_start_request(struct request *rq)
 		rq->next_rq->resid_len = blk_rq_bytes(rq->next_rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		blk_stat_set_issue_time(&rq->issue_stat);
+		blk_stat_set_issue(&rq->issue_stat, blk_rq_sectors(rq));
 		rq->rq_flags |= RQF_STATS;
 		wbt_issue(q->rq_wb, &rq->issue_stat);
 	}
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 9b43efb..7e9df17 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -236,10 +236,11 @@ void blk_stat_clear(struct request_queue *q)
 	}
 }
 
-void blk_stat_set_issue_time(struct blk_issue_stat *stat)
+void blk_stat_set_issue(struct blk_issue_stat *stat, sector_t size)
 {
-	stat->time = (stat->time & BLK_STAT_MASK) |
-			(ktime_to_ns(ktime_get()) & BLK_STAT_TIME_MASK);
+	stat->stat = (stat->stat & BLK_STAT_RES_MASK) |
+		(ktime_to_ns(ktime_get()) & BLK_STAT_TIME_MASK) |
+		(((u64)blk_capped_size(size)) << BLK_STAT_SIZE_SHIFT);
 }
 
 /*
diff --git a/block/blk-stat.h b/block/blk-stat.h
index a2050a0..462197f 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -8,12 +8,19 @@
 #define BLK_STAT_NSEC_MASK	~(BLK_STAT_NSEC - 1)
 
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
 
 enum {
 	BLK_STAT_READ	= 0,
@@ -26,7 +33,7 @@ void blk_queue_stat_get(struct request_queue *, struct blk_rq_stat *);
 void blk_stat_clear(struct request_queue *);
 void blk_stat_init(struct blk_rq_stat *);
 bool blk_stat_is_current(struct blk_rq_stat *);
-void blk_stat_set_issue_time(struct blk_issue_stat *);
+void blk_stat_set_issue(struct blk_issue_stat *stat, sector_t size);
 bool blk_stat_enable(struct request_queue *);
 
 static inline u64 __blk_stat_time(u64 time)
@@ -36,7 +43,17 @@ static inline u64 __blk_stat_time(u64 time)
 
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
 }
 
 #endif
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 65f1de5..7265f1f 100644
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
index 01019a7..8159a6c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -257,7 +257,7 @@ static inline unsigned int blk_qc_t_to_tag(blk_qc_t cookie)
 }
 
 struct blk_issue_stat {
-	u64 time;
+	u64 stat;
 };
 
 #define BLK_RQ_STAT_BATCH	64
-- 
2.9.3

