Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40869 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeEBReo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 May 2018 13:34:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id f189so12374772pfa.7
        for <linux-block@vger.kernel.org>; Wed, 02 May 2018 10:34:44 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com
Subject: [PATCH 3/7] block: replace bio->bi_issue_stat with u64
Date: Wed,  2 May 2018 10:34:22 -0700
Message-Id: <e59bef4492498fc1a1678f1161c2363b5551efc4.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
In-Reply-To: <cover.1525282392.git.osandov@fb.com>
References: <cover.1525282392.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

struct blk_issue_stat is going away, and bio->bi_issue_stat doesn't even
use the blk-stats interface, so we can provide a separate implementation
private to blk-throtl.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-throttle.c      | 50 ++++++++++++++++++++++++++++++---------
 include/linux/blk_types.h |  2 +-
 2 files changed, 40 insertions(+), 12 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index c5a131673733..e2957a93ed11 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -36,8 +36,6 @@ static int throtl_quantum = 32;
  */
 #define LATENCY_FILTERED_HD (1000L) /* 1ms */
 
-#define SKIP_LATENCY (((u64)1) << BLK_STAT_RES_SHIFT)
-
 static struct blkcg_policy blkcg_policy_throtl;
 
 /* A workqueue to queue throttle related work */
@@ -2048,6 +2046,37 @@ static void blk_throtl_update_idletime(struct throtl_grp *tg)
 }
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+/*
+ * bio->bi_throtl:
+ * high bit is SKIP_LATENCY flag
+ * next 12 bits are original size, in sectors
+ * rest of the bits (51) are issue time, in nanoseconds
+ */
+#define BI_THROTL_SKIP_LATENCY (1ULL << 63)
+#define BI_THROTL_SIZE_BITS 12
+#define BI_THROTL_SIZE_MASK ((1ULL << BI_THROTL_SIZE_BITS) - 1)
+#define BI_THROTL_SIZE_SHIFT (63 - BI_THROTL_SIZE_BITS)
+#define BI_THROTL_TIME_MASK ((1ULL << BI_THROTL_SIZE_SHIFT) - 1)
+
+static void throtl_set_issue(struct bio *bio)
+{
+	u64 time, size;
+
+	time = ktime_get_ns() & BI_THROTL_TIME_MASK;
+	size = bio_sectors(bio) & BI_THROTL_SIZE_MASK;
+	bio->bi_throtl = time | (size << BI_THROTL_SIZE_SHIFT);
+}
+
+static u64 throtl_issue_time(struct bio *bio)
+{
+	return bio->bi_throtl & BI_THROTL_TIME_MASK;
+}
+
+static sector_t throtl_issue_size(struct bio *bio)
+{
+	return (bio->bi_throtl >> BI_THROTL_SIZE_SHIFT) & BI_THROTL_SIZE_MASK;
+}
+
 static void throtl_update_latency_buckets(struct throtl_data *td)
 {
 	struct avg_latency_bucket avg_latency[2][LATENCY_BUCKET_SIZE];
@@ -2139,7 +2168,7 @@ static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
 		bio->bi_cg_private = tg;
 		blkg_get(tg_to_blkg(tg));
 	}
-	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
+	throtl_set_issue(bio);
 #endif
 }
 
@@ -2251,7 +2280,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (throttled || !td->track_bio_latency)
-		bio->bi_issue_stat.stat |= SKIP_LATENCY;
+		bio->bi_throtl |= BI_THROTL_SKIP_LATENCY;
 #endif
 	return throttled;
 }
@@ -2302,8 +2331,8 @@ void blk_throtl_bio_endio(struct bio *bio)
 	finish_time_ns = ktime_get_ns();
 	tg->last_finish_time = finish_time_ns >> 10;
 
-	start_time = blk_stat_time(&bio->bi_issue_stat) >> 10;
-	finish_time = __blk_stat_time(finish_time_ns) >> 10;
+	start_time = throtl_issue_time(bio) >> 10;
+	finish_time = (finish_time_ns & BI_THROTL_TIME_MASK) >> 10;
 	if (!start_time || finish_time <= start_time) {
 		blkg_put(tg_to_blkg(tg));
 		return;
@@ -2311,16 +2340,15 @@ void blk_throtl_bio_endio(struct bio *bio)
 
 	lat = finish_time - start_time;
 	/* this is only for bio based driver */
-	if (!(bio->bi_issue_stat.stat & SKIP_LATENCY))
-		throtl_track_latency(tg->td, blk_stat_size(&bio->bi_issue_stat),
-			bio_op(bio), lat);
+	if (!(bio->bi_throtl & BI_THROTL_SKIP_LATENCY))
+		throtl_track_latency(tg->td, throtl_issue_size(bio),
+				     bio_op(bio), lat);
 
 	if (tg->latency_target && lat >= tg->td->filtered_latency) {
 		int bucket;
 		unsigned int threshold;
 
-		bucket = request_bucket_index(
-			blk_stat_size(&bio->bi_issue_stat));
+		bucket = request_bucket_index(throtl_issue_size(bio));
 		threshold = tg->td->avg_buckets[rw][bucket].latency +
 			tg->latency_target;
 		if (lat > threshold)
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 17b18b91ebac..3a263538d315 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -138,7 +138,7 @@ struct bio {
 	struct cgroup_subsys_state *bi_css;
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	void			*bi_cg_private;
-	struct blk_issue_stat	bi_issue_stat;
+	u64			bi_throtl;
 #endif
 #endif
 	union {
-- 
2.17.0
