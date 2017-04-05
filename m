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
Subject: [PATCH v2 1/2] blk-stat: convert blk-stat bucket callback to signed
Date: Wed,  5 Apr 2017 11:39:16 -0600
Message-Id: <1491413957-30885-2-git-send-email-sbates@raithlin.com>
In-Reply-To: <1491413957-30885-1-git-send-email-sbates@raithlin.com>
References: <1491413957-30885-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

In order to allow for filtering of IO based on some other properties
of the request than direction we allow the bucket function to return
an int.

If the bucket callback returns a negative do no count it in the stats
accumulation.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 block/blk-stat.c | 6 ++++--
 block/blk-stat.h | 9 +++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index e77ec52..dde9d39 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -19,7 +19,7 @@ struct blk_queue_stats {
 	bool enable_accounting;
 };
 
-unsigned int blk_stat_rq_ddir(const struct request *rq)
+int blk_stat_rq_ddir(const struct request *rq)
 {
 	return rq_data_dir(rq);
 }
@@ -104,6 +104,8 @@ void blk_stat_add(struct request *rq)
 	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
 		if (blk_stat_is_active(cb)) {
 			bucket = cb->bucket_fn(rq);
+			if (bucket < 0)
+				continue;
 			stat = &this_cpu_ptr(cb->cpu_stat)[bucket];
 			__blk_stat_add(stat, value);
 		}
@@ -135,7 +137,7 @@ static void blk_stat_timer_fn(unsigned long data)
 
 struct blk_stat_callback *
 blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
-			unsigned int (*bucket_fn)(const struct request *),
+			int (*bucket_fn)(const struct request *),
 			unsigned int buckets, void *data)
 {
 	struct blk_stat_callback *cb;
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 53f08a6..622a62c 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -48,9 +48,10 @@ struct blk_stat_callback {
 
 	/**
 	 * @bucket_fn: Given a request, returns which statistics bucket it
-	 * should be accounted under.
+	 * should be accounted under. Return -1 for no bucket for this
+	 * request.
 	 */
-	unsigned int (*bucket_fn)(const struct request *);
+	int (*bucket_fn)(const struct request *);
 
 	/**
 	 * @buckets: Number of statistics buckets.
@@ -120,7 +121,7 @@ void blk_stat_enable_accounting(struct request_queue *q);
  *
  * Return: Data direction of the request, either READ or WRITE.
  */
-unsigned int blk_stat_rq_ddir(const struct request *rq);
+int blk_stat_rq_ddir(const struct request *rq);
 
 /**
  * blk_stat_alloc_callback() - Allocate a block statistics callback.
@@ -135,7 +136,7 @@ unsigned int blk_stat_rq_ddir(const struct request *rq);
  */
 struct blk_stat_callback *
 blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
-			unsigned int (*bucket_fn)(const struct request *),
+			int (*bucket_fn)(const struct request *),
 			unsigned int buckets, void *data);
 
 /**
-- 
2.7.4
