Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbdFFTkr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 15:40:47 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: tj@kernel.org, axboe@fb.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: [PATCH] blk-throttle: set default latency baseline for harddisk
Date: Tue,  6 Jun 2017 12:40:43 -0700
Message-Id: <af8d351c4d0639b4df0dae777cc96944f52751c1.1496777767.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

hard disk IO latency varies a lot depending on spindle move. The latency
range could be from several microseconds to several milliseconds. It's
pretty hard to get the baseline latency used by io.low.

We will use a different stragety here. The idea is only using IO with
spindle move to determine if cgroup IO is in good state. For HD, if io
latency is small (< 1ms), we ignore the IO. Such IO is likely from
sequential IO, and is helpless to help determine if a cgroup's IO is
impacted by other cgroups. With this, we only account IO with big
latency. Then we can choose a hardcoded baseline latency for HD (4ms,
which is typical IO latency with seek).  With all these settings, the
io.low latency works for both HD and SSD.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index fc13dd0..fb6a0bf 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -27,6 +27,13 @@ static int throtl_quantum = 32;
 #define MIN_THROTL_IOPS (10)
 #define DFL_LATENCY_TARGET (-1L)
 #define DFL_IDLE_THRESHOLD (0)
+#define DFL_HD_BASELINE_LATENCY (4000L) /* 4ms */
+#define LATENCY_FILTERED_SSD (0)
+/*
+ * For HD, very small latency comes from sequential IO. Such IO is helpless to
+ * help determine if its IO is impacted by others, hence we ignore the IO
+ */
+#define LATENCY_FILTERED_HD (1000L) /* 1ms */
 
 #define SKIP_LATENCY (((u64)1) << BLK_STAT_RES_SHIFT)
 
@@ -212,6 +219,7 @@ struct throtl_data
 	struct avg_latency_bucket avg_buckets[LATENCY_BUCKET_SIZE];
 	struct latency_bucket __percpu *latency_buckets;
 	unsigned long last_calculate_time;
+	unsigned long filtered_latency;
 
 	bool track_bio_latency;
 };
@@ -2281,7 +2289,7 @@ void blk_throtl_bio_endio(struct bio *bio)
 		throtl_track_latency(tg->td, blk_stat_size(&bio->bi_issue_stat),
 			bio_op(bio), lat);
 
-	if (tg->latency_target) {
+	if (tg->latency_target && lat >= tg->td->filtered_latency) {
 		int bucket;
 		unsigned int threshold;
 
@@ -2417,14 +2425,20 @@ void blk_throtl_exit(struct request_queue *q)
 void blk_throtl_register_queue(struct request_queue *q)
 {
 	struct throtl_data *td;
+	int i;
 
 	td = q->td;
 	BUG_ON(!td);
 
-	if (blk_queue_nonrot(q))
+	if (blk_queue_nonrot(q)) {
 		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-	else
+		td->filtered_latency = LATENCY_FILTERED_SSD;
+	} else {
 		td->throtl_slice = DFL_THROTL_SLICE_HD;
+		td->filtered_latency = LATENCY_FILTERED_HD;
+		for (i = 0; i < LATENCY_BUCKET_SIZE; i++)
+			td->avg_buckets[i].latency = DFL_HD_BASELINE_LATENCY;
+	}
 #ifndef CONFIG_BLK_DEV_THROTTLING_LOW
 	/* if no low limit, use previous default */
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
-- 
2.9.3
