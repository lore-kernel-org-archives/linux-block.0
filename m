Return-Path: <sbates130272@gmail.com>
Return-Path: <sbates130272@gmail.com>
From: sbates@raithlin.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Damien.LeMoal@wdc.com,
	osandov@osandov.com,
	sbates@raithlin.com,
	sagi@grimberg.me
Subject: [PATCH v3 2/2] blk-mq: Add a polling specific stats function
Date: Fri,  7 Apr 2017 06:24:03 -0600
Message-Id: <1491567843-26190-3-git-send-email-sbates@raithlin.com>
In-Reply-To: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
References: <1491567843-26190-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

Rather than bucketing IO statisics based on direction only we also
bucket based on the IO size. This leads to improved polling
performance. Update the bucket callback function and use it in the
polling latency estimation.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 block/blk-mq.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 061fc2c..5fd376b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -42,6 +42,25 @@ static LIST_HEAD(all_q_list);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
+/* Must be consisitent with function below */
+#define BLK_MQ_POLL_STATS_BKTS 16
+static int blk_mq_poll_stats_bkt(const struct request *rq)
+{
+	int ddir, bytes, bucket;
+
+	ddir = blk_stat_rq_ddir(rq);
+	bytes = blk_rq_bytes(rq);
+
+	bucket = ddir + 2*(ilog2(bytes) - 9);
+
+	if (bucket < 0)
+		return -1;
+	else if (bucket >= BLK_MQ_POLL_STATS_BKTS)
+		return ddir + BLK_MQ_POLL_STATS_BKTS - 2;
+
+	return bucket;
+}
+
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
@@ -2245,7 +2264,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->mq_ops = set->ops;
 
 	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
-					     blk_stat_rq_ddir, 2, q);
+					     blk_mq_poll_stats_bkt,
+					     BLK_MQ_POLL_STATS_BKTS, q);
 	if (!q->poll_cb)
 		goto err_exit;
 
@@ -2663,11 +2683,12 @@ static void blk_mq_poll_stats_start(struct request_queue *q)
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
 {
 	struct request_queue *q = cb->data;
+	int bucket;
 
-	if (cb->stat[READ].nr_samples)
-		q->poll_stat[READ] = cb->stat[READ];
-	if (cb->stat[WRITE].nr_samples)
-		q->poll_stat[WRITE] = cb->stat[WRITE];
+	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS; bucket++) {
+		if (cb->stat[bucket].nr_samples)
+			q->poll_stat[bucket] = cb->stat[bucket];
+	}
 }
 
 static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
@@ -2675,6 +2696,7 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 				       struct request *rq)
 {
 	unsigned long ret = 0;
+	int bucket;
 
 	/*
 	 * If stats collection isn't on, don't sleep but turn it on for
@@ -2689,12 +2711,15 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	 * For instance, if the completion latencies are tight, we can
 	 * get closer than just half the mean. This is especially
 	 * important on devices where the completion latencies are longer
-	 * than ~10 usec.
+	 * than ~10 usec. We do use the stats for the relevant IO size
+	 * if available which does lead to better estimates.
 	 */
-	if (req_op(rq) == REQ_OP_READ && q->poll_stat[READ].nr_samples)
-		ret = (q->poll_stat[READ].mean + 1) / 2;
-	else if (req_op(rq) == REQ_OP_WRITE && q->poll_stat[WRITE].nr_samples)
-		ret = (q->poll_stat[WRITE].mean + 1) / 2;
+	bucket = blk_mq_poll_stats_bkt(rq);
+	if (bucket < 0)
+		return ret;
+
+	if (q->poll_stat[bucket].nr_samples)
+		ret = (q->poll_stat[bucket].mean + 1) / 2;
 
 	return ret;
 }
-- 
2.7.4
