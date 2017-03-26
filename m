Return-Path: <sbates130272@gmail.com>
Return-Path: <sbates130272@gmail.com>
From: sbates@raithlin.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Damien.LeMoal@wdc.com,
	osandov@osandov.com,
	sbates@raithlin.com
Subject: [PATCH 1/2] blk-stat: convert blk-stat bucket callback to signed
Date: Sat, 25 Mar 2017 20:18:11 -0600
Message-Id: <1490494692-2416-2-git-send-email-sbates@raithlin.com>
In-Reply-To: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
References: <1490494692-2416-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

In order to allow for filtering of IO based on some other properties
of the request than direction we allow the bucket function to return
an int.

If the bucket callback returns a negative do no count it in the stats
accumulation.

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 block/blk-stat.c | 8 +++++---
 block/blk-stat.h | 9 +++++----
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 188b535..936adfb 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -17,9 +17,9 @@ struct blk_queue_stats {
 	spinlock_t lock;
 };
 
-unsigned int blk_stat_rq_ddir(const struct request *rq)
+int blk_stat_rq_ddir(const struct request *rq)
 {
-	return rq_data_dir(rq);
+	return (int)rq_data_dir(rq);
 }
 EXPORT_SYMBOL_GPL(blk_stat_rq_ddir);
 
@@ -100,6 +100,8 @@ void blk_stat_add(struct request *rq)
 	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
 		if (blk_stat_is_active(cb)) {
 			bucket = cb->bucket_fn(rq);
+			if (bucket < 0)
+				continue;
 			stat = &this_cpu_ptr(cb->cpu_stat)[bucket];
 			__blk_stat_add(stat, value);
 		}
@@ -131,7 +133,7 @@ static void blk_stat_timer_fn(unsigned long data)
 
 struct blk_stat_callback *
 blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
-			unsigned int (*bucket_fn)(const struct request *),
+			int (*bucket_fn)(const struct request *),
 			unsigned int buckets, void *data)
 {
 	struct blk_stat_callback *cb;
diff --git a/block/blk-stat.h b/block/blk-stat.h
index 6ad5b8c..7417805 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -41,9 +41,10 @@ struct blk_stat_callback {
 
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
@@ -98,7 +99,7 @@ static inline u64 blk_stat_time(struct blk_issue_stat *stat)
  *
  * Return: Data direction of the request, either READ or WRITE.
  */
-unsigned int blk_stat_rq_ddir(const struct request *rq);
+int blk_stat_rq_ddir(const struct request *rq);
 
 /**
  * blk_stat_alloc_callback() - Allocate a block statistics callback.
@@ -113,7 +114,7 @@ unsigned int blk_stat_rq_ddir(const struct request *rq);
  */
 struct blk_stat_callback *
 blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
-			unsigned int (*bucket_fn)(const struct request *),
+			int (*bucket_fn)(const struct request *),
 			unsigned int buckets, void *data);
 
 /**
-- 
2.7.4
