Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-stat: kill blk_stat_rq_ddir()
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <f593d3e1-92b2-4581-87af-e86c9829fcf1@kernel.dk>
Cc: Stephen Bates <sbates@raithlin.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <422d7605-6ef5-bfa1-a699-f8c23e2efe1f@kernel.dk>
Date: Thu, 20 Apr 2017 19:49:43 -0600
MIME-Version: 1.0
In-Reply-To: <f593d3e1-92b2-4581-87af-e86c9829fcf1@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/20/2017 07:46 PM, Jens Axboe wrote:
> No point in providing and exporting this helper. There's just
> one (real) user of it, just use rq_data_dir().

Not sure what happened there, it doubled up the patch. I probably
fat fingered the :r in vim. We just need one of them...

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 766ae052f98a..f07156018bc9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -46,7 +46,7 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 {
 	int ddir, bytes, bucket;
 
-	ddir = blk_stat_rq_ddir(rq);
+	ddir = rq_data_dir(rq);
 	bytes = blk_rq_bytes(rq);
 
 	bucket = ddir + 2*(ilog2(bytes) - 9);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index dde9d399f707..6c2f40940439 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -19,12 +19,6 @@ struct blk_queue_stats {
 	bool enable_accounting;
 };
 
-int blk_stat_rq_ddir(const struct request *rq)
-{
-	return rq_data_dir(rq);
-}
-EXPORT_SYMBOL_GPL(blk_stat_rq_ddir);
-
 static void blk_stat_init(struct blk_rq_stat *stat)
 {
 	stat->min = -1ULL;
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 622a62ce6213..2fb20d1a341a 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -112,17 +112,6 @@ static inline void blk_stat_set_issue(struct blk_issue_stat *stat,
 /* record time/size info in request but not add a callback */
 void blk_stat_enable_accounting(struct request_queue *q);
 
-/*
- * blk_stat_rq_ddir() - Bucket callback function for the request data direction.
- * @rq: Request.
- *
- * This is the same as rq_data_dir() but as a function so it can be used as
- * @bucket_fn for blk_stat_alloc_callback().
- *
- * Return: Data direction of the request, either READ or WRITE.
- */
-int blk_stat_rq_ddir(const struct request *rq);
-
 /**
  * blk_stat_alloc_callback() - Allocate a block statistics callback.
  * @timer_fn: Timer callback function.
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 26e1bb617877..17676f4d7fd1 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -696,6 +696,11 @@ u64 wbt_default_latency_nsec(struct request_queue *q)
 		return 75000000ULL;
 }
 
+static int wbt_data_dir(const struct request *rq)
+{
+	return rq_data_dir(rq);
+}
+
 int wbt_init(struct request_queue *q)
 {
 	struct rq_wb *rwb;
@@ -707,7 +712,7 @@ int wbt_init(struct request_queue *q)
 	if (!rwb)
 		return -ENOMEM;
 
-	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, blk_stat_rq_ddir, 2, rwb);
+	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, wbt_data_dir, 2, rwb);
 	if (!rwb->cb) {
 		kfree(rwb);
 		return -ENOMEM;

-- 
Jens Axboe
