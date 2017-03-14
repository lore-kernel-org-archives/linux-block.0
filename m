Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36033 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbdCNVEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2017 17:04:35 -0400
Received: by mail-pf0-f173.google.com with SMTP id o126so75585013pfb.3
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2017 14:04:34 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 4/4] blk-stats: convert to callback-based statistics reporting
Date: Tue, 14 Mar 2017 14:03:31 -0700
Message-Id: <850852d26e26c803498c688b29da67beabe1651b.1489524591.git.osandov@fb.com>
In-Reply-To: <cover.1489524591.git.osandov@fb.com>
References: <cover.1489524591.git.osandov@fb.com>
In-Reply-To: <cover.1489524591.git.osandov@fb.com>
References: <cover.1489524591.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Currently, statistics are gathered in ~0.13s windows, and users grab the
statistics whenever they need them. This is not ideal for both in-tree
users:

1. Writeback throttling wants its own dynamically sized window of
   statistics. Since the blk-stats statistics are reset after every
   window and the wbt windows don't line up with the blk-stats windows,
   wbt doesn't see every I/O.
2. Polling currently grabs the statistics on every I/O. Again, depending
   on how the window lines up, we may miss some I/Os. It's also
   unnecessary overhead to get the statistics on every I/O; the hybrid
   polling heuristic would be just as happy with the statistics from the
   previous full window.

This reworks the blk-stats infrastructure to be callback-based: users
register a callback that they want called at a given time with all of
the statistics from the window during which the callback was active. The
callbacks are kept on an RCU list, and each callback has percpu stats
buffers. There will only be a few users, so the overhead on the I/O
completion side is low. The stats flushing is also simplified
considerably: since the timer function is responsible for clearing the
statistics, we don't have to worry about stale statistics.

wbt is a trivial conversion. After the conversion, the windowing problem
mentioned above is fixed.

For polling, we register an extra callback that caches the previous
window's statistics in the struct request_queue for the hybrid polling
heuristic to use.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c          |   6 +-
 block/blk-mq.c            |  77 ++++++++----
 block/blk-mq.h            |   1 -
 block/blk-stat.c          | 300 +++++++++++++++++++++-------------------------
 block/blk-stat.h          |  98 ++++++++++++---
 block/blk-sysfs.c         |   5 +
 block/blk-wbt.c           |  48 +++-----
 block/blk-wbt.h           |   2 +-
 include/linux/blk_types.h |   3 -
 include/linux/blkdev.h    |  10 +-
 10 files changed, 307 insertions(+), 243 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 82425017c9b8..0f4ae118e220 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -852,6 +852,10 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio);
 
 int blk_init_allocated_queue(struct request_queue *q)
 {
+	q->stats = blk_alloc_queue_stats();
+	if (!q->stats)
+		return -ENOMEM;
+
 	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size);
 	if (!q->fq)
 		return -ENOMEM;
@@ -2692,7 +2696,7 @@ void blk_finish_request(struct request *req, int error)
 	struct request_queue *q = req->q;
 
 	if (req->rq_flags & RQF_STATS)
-		blk_stat_add(&q->rq_stats[rq_data_dir(req)], req);
+		blk_stat_add(req);
 
 	if (req->rq_flags & RQF_QUEUED)
 		blk_queue_end_tag(q, req);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e16f8d420683..559f9b0f24a1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -39,6 +39,10 @@
 static DEFINE_MUTEX(all_q_mutex);
 static LIST_HEAD(all_q_list);
 
+static void blk_mq_poll_stats_start(struct request_queue *q);
+static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb,
+				 struct blk_stats *stats);
+
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
@@ -432,15 +436,8 @@ static void blk_mq_ipi_complete_request(struct request *rq)
 static void blk_mq_stat_add(struct request *rq)
 {
 	if (rq->rq_flags & RQF_STATS) {
-		/*
-		 * We could rq->mq_ctx here, but there's less of a risk
-		 * of races if we have the completion event add the stats
-		 * to the local software queue.
-		 */
-		struct blk_mq_ctx *ctx;
-
-		ctx = __blk_mq_get_ctx(rq->q, raw_smp_processor_id());
-		blk_stat_add(&ctx->stat[rq_data_dir(rq)], rq);
+		blk_mq_poll_stats_start(rq->q);
+		blk_stat_add(rq);
 	}
 }
 
@@ -2039,8 +2036,6 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		spin_lock_init(&__ctx->lock);
 		INIT_LIST_HEAD(&__ctx->rq_list);
 		__ctx->queue = q;
-		blk_stat_init(&__ctx->stat[BLK_STAT_READ]);
-		blk_stat_init(&__ctx->stat[BLK_STAT_WRITE]);
 
 		/* If the cpu isn't online, the cpu is mapped to first hctx */
 		if (!cpu_online(i))
@@ -2338,6 +2333,14 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
+	q->stats = blk_alloc_queue_stats();
+	if (!q->stats)
+		goto err_exit;
+
+	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn, q);
+	if (!q->poll_cb)
+		goto err_exit;
+
 	q->queue_ctx = alloc_percpu(struct blk_mq_ctx);
 	if (!q->queue_ctx)
 		goto err_exit;
@@ -2739,28 +2742,54 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
+/* Enable polling stats and return whether they were already enabled. */
+static bool blk_poll_stats_enable(struct request_queue *q)
+{
+	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
+	    test_and_set_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
+		return true;
+	blk_stat_add_callback(q, q->poll_cb);
+	return false;
+}
+
+static void blk_mq_poll_stats_start(struct request_queue *q)
+{
+	/*
+	 * We don't arm the callback if polling stats are not enabled or the
+	 * callback has already been armed.
+	 */
+	if (!test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
+	    timer_pending(&q->poll_cb->timer))
+		return;
+
+	blk_stat_arm_callback(q->poll_cb, jiffies + msecs_to_jiffies(100));
+}
+
+static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb,
+				 struct blk_stats *stats)
+{
+	struct request_queue *q = cb->data;
+
+	if (stats->read.nr_samples)
+		q->poll_stats.read = stats->read;
+	if (stats->write.nr_samples)
+		q->poll_stats.write = stats->write;
+}
+
 static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx,
 				       struct request *rq)
 {
-	struct blk_stats stats;
 	unsigned long ret = 0;
 
 	/*
 	 * If stats collection isn't on, don't sleep but turn it on for
 	 * future users
 	 */
-	if (!blk_stat_enable(q))
+	if (!blk_poll_stats_enable(q))
 		return 0;
 
 	/*
-	 * We don't have to do this once per IO, should optimize this
-	 * to just use the current window of stats until it changes
-	 */
-	memset(&stats, 0, sizeof(stats));
-	blk_hctx_stat_get(hctx, &stats);
-
-	/*
 	 * As an optimistic guess, use half of the mean service time
 	 * for this type of request. We can (and should) make this smarter.
 	 * For instance, if the completion latencies are tight, we can
@@ -2768,10 +2797,10 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	 * important on devices where the completion latencies are longer
 	 * than ~10 usec.
 	 */
-	if (req_op(rq) == REQ_OP_READ && stats.read.nr_samples)
-		ret = (stats.read.mean + 1) / 2;
-	else if (req_op(rq) == REQ_OP_WRITE && stats.write.nr_samples)
-		ret = (stats.write.mean + 1) / 2;
+	if (req_op(rq) == REQ_OP_READ && q->poll_stats.read.nr_samples)
+		ret = (q->poll_stats.read.mean + 1) / 2;
+	else if (req_op(rq) == REQ_OP_WRITE && q->poll_stats.write.nr_samples)
+		ret = (q->poll_stats.write.mean + 1) / 2;
 
 	return ret;
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index b79f9a7d8cf6..8d49c06fc520 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -20,7 +20,6 @@ struct blk_mq_ctx {
 
 	/* incremented at completion time */
 	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
-	struct blk_rq_stat	stat[2];
 
 	struct request_queue	*queue;
 	struct kobject		kobj;
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 40f6c90e432a..a71cfb35712d 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -4,11 +4,24 @@
  * Copyright (C) 2016 Jens Axboe
  */
 #include <linux/kernel.h>
+#include <linux/rculist.h>
 #include <linux/blk-mq.h>
 
 #include "blk-stat.h"
 #include "blk-mq.h"
 
+struct blk_queue_stats {
+	struct list_head callbacks;
+	spinlock_t lock;
+};
+
+static void blk_stat_init(struct blk_rq_stat *stat)
+{
+	stat->min = -1ULL;
+	stat->max = stat->nr_samples = stat->mean = 0;
+	stat->batch = stat->nr_batch = 0;
+}
+
 static void blk_stat_flush_batch(struct blk_rq_stat *stat)
 {
 	const s32 nr_batch = READ_ONCE(stat->nr_batch);
@@ -48,209 +61,164 @@ static void blk_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->nr_samples += src->nr_samples;
 }
 
-static void blk_mq_stat_get(struct request_queue *q, struct blk_stats *stats)
+static void __blk_stat_add(struct blk_rq_stat *stat, u64 value)
 {
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
-	uint64_t latest = 0;
-	int i, j, nr;
-
-	blk_stat_init(&stats->read);
-	blk_stat_init(&stats->write);
-
-	nr = 0;
-	do {
-		uint64_t newest = 0;
-
-		queue_for_each_hw_ctx(q, hctx, i) {
-			hctx_for_each_ctx(hctx, ctx, j) {
-				blk_stat_flush_batch(&ctx->stat[BLK_STAT_READ]);
-				blk_stat_flush_batch(&ctx->stat[BLK_STAT_WRITE]);
-
-				if (!ctx->stat[BLK_STAT_READ].nr_samples &&
-				    !ctx->stat[BLK_STAT_WRITE].nr_samples)
-					continue;
-				if (ctx->stat[BLK_STAT_READ].time > newest)
-					newest = ctx->stat[BLK_STAT_READ].time;
-				if (ctx->stat[BLK_STAT_WRITE].time > newest)
-					newest = ctx->stat[BLK_STAT_WRITE].time;
-			}
-		}
+	stat->min = min(stat->min, value);
+	stat->max = max(stat->max, value);
 
-		/*
-		 * No samples
-		 */
-		if (!newest)
-			break;
-
-		if (newest > latest)
-			latest = newest;
-
-		queue_for_each_hw_ctx(q, hctx, i) {
-			hctx_for_each_ctx(hctx, ctx, j) {
-				if (ctx->stat[BLK_STAT_READ].time == newest) {
-					blk_stat_sum(&stats->read,
-						     &ctx->stat[BLK_STAT_READ]);
-					nr++;
-				}
-				if (ctx->stat[BLK_STAT_WRITE].time == newest) {
-					blk_stat_sum(&stats->write,
-						     &ctx->stat[BLK_STAT_WRITE]);
-					nr++;
-				}
-			}
-		}
-		/*
-		 * If we race on finding an entry, just loop back again.
-		 * Should be very rare.
-		 */
-	} while (!nr);
+	if (stat->batch + value < stat->batch ||
+	    stat->nr_batch + 1 == BLK_RQ_STAT_BATCH)
+		blk_stat_flush_batch(stat);
 
-	stats->read.time = stats->write.time = latest;
+	stat->batch += value;
+	stat->nr_batch++;
 }
 
-void blk_queue_stat_get(struct request_queue *q, struct blk_stats *stats)
+static struct blk_rq_stat *blk_stat_ddir(struct blk_stats __percpu *stats,
+					 int ddir)
 {
-	if (q->mq_ops)
-		blk_mq_stat_get(q, stats);
-	else {
-		blk_stat_flush_batch(&q->rq_stats[BLK_STAT_READ]);
-		blk_stat_flush_batch(&q->rq_stats[BLK_STAT_WRITE]);
-		memcpy(&stats->read, &q->rq_stats[BLK_STAT_READ],
-		       sizeof(struct blk_rq_stat));
-		memcpy(&stats->write, &q->rq_stats[BLK_STAT_WRITE],
-		       sizeof(struct blk_rq_stat));
-	}
+	if (ddir == READ)
+		return &this_cpu_ptr(stats)->read;
+	else
+		return &this_cpu_ptr(stats)->write;
 }
 
-void blk_hctx_stat_get(struct blk_mq_hw_ctx *hctx, struct blk_stats *stats)
+void blk_stat_add(struct request *rq)
 {
-	struct blk_mq_ctx *ctx;
-	unsigned int i, nr;
-
-	nr = 0;
-	do {
-		uint64_t newest = 0;
-
-		hctx_for_each_ctx(hctx, ctx, i) {
-			blk_stat_flush_batch(&ctx->stat[BLK_STAT_READ]);
-			blk_stat_flush_batch(&ctx->stat[BLK_STAT_WRITE]);
+	struct request_queue *q = rq->q;
+	struct blk_stat_callback *cb;
+	struct blk_rq_stat *stat;
+	int ddir = rq_data_dir(rq);
+	s64 now, value;
 
-			if (!ctx->stat[BLK_STAT_READ].nr_samples &&
-			    !ctx->stat[BLK_STAT_WRITE].nr_samples)
-				continue;
+	now = __blk_stat_time(ktime_to_ns(ktime_get()));
+	if (now < blk_stat_time(&rq->issue_stat))
+		return;
 
-			if (ctx->stat[BLK_STAT_READ].time > newest)
-				newest = ctx->stat[BLK_STAT_READ].time;
-			if (ctx->stat[BLK_STAT_WRITE].time > newest)
-				newest = ctx->stat[BLK_STAT_WRITE].time;
-		}
+	value = now - blk_stat_time(&rq->issue_stat);
 
-		if (!newest)
-			break;
-
-		hctx_for_each_ctx(hctx, ctx, i) {
-			if (ctx->stat[BLK_STAT_READ].time == newest) {
-				blk_stat_sum(&stats->read,
-					     &ctx->stat[BLK_STAT_READ]);
-				nr++;
-			}
-			if (ctx->stat[BLK_STAT_WRITE].time == newest) {
-				blk_stat_sum(&stats->write,
-					     &ctx->stat[BLK_STAT_WRITE]);
-				nr++;
-			}
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
+		if (timer_pending(&cb->timer)) {
+			stat = blk_stat_ddir(cb->stats, ddir);
+			__blk_stat_add(stat, value);
 		}
-		/*
-		 * If we race on finding an entry, just loop back again.
-		 * Should be very rare, as the window is only updated
-		 * occasionally
-		 */
-	} while (!nr);
+	}
+	rcu_read_unlock();
 }
 
-static void __blk_stat_init(struct blk_rq_stat *stat, s64 time_now)
+static void blk_stat_timer_fn(unsigned long data)
 {
-	stat->min = -1ULL;
-	stat->max = stat->nr_samples = stat->mean = 0;
-	stat->batch = stat->nr_batch = 0;
-	stat->time = time_now & BLK_STAT_NSEC_MASK;
-}
+	struct blk_stat_callback *cb = (void *)data;
+	struct blk_stats stats;
+	int i;
 
-void blk_stat_init(struct blk_rq_stat *stat)
-{
-	__blk_stat_init(stat, ktime_to_ns(ktime_get()));
-}
+	blk_stat_init(&stats.read);
+	blk_stat_init(&stats.write);
 
-static bool __blk_stat_is_current(struct blk_rq_stat *stat, s64 now)
-{
-	return (now & BLK_STAT_NSEC_MASK) == (stat->time & BLK_STAT_NSEC_MASK);
+	for_each_online_cpu(i) {
+		struct blk_stats *cpu_stats;
+
+		cpu_stats = per_cpu_ptr(cb->stats, i);
+		blk_stat_sum(&stats.read, &cpu_stats->read);
+		blk_stat_sum(&stats.write, &cpu_stats->write);
+		blk_stat_init(&cpu_stats->read);
+		blk_stat_init(&cpu_stats->write);
+	}
+
+	cb->fn(cb, &stats);
 }
 
-bool blk_stat_is_current(struct blk_rq_stat *stat)
+struct blk_stat_callback *
+blk_stat_alloc_callback(void (*fn)(struct blk_stat_callback *, struct blk_stats *),
+			void *data)
 {
-	return __blk_stat_is_current(stat, ktime_to_ns(ktime_get()));
+	struct blk_stat_callback *cb;
+
+	cb = kmalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb)
+		return NULL;
+
+	cb->stats = alloc_percpu(struct blk_stats);
+	if (!cb->stats) {
+		kfree(cb);
+		return NULL;
+	}
+
+	cb->fn = fn;
+	cb->data = data;
+	setup_timer(&cb->timer, blk_stat_timer_fn, (unsigned long)cb);
+
+	return cb;
 }
+EXPORT_SYMBOL_GPL(blk_stat_alloc_callback);
 
-void blk_stat_add(struct blk_rq_stat *stat, struct request *rq)
+void blk_stat_add_callback(struct request_queue *q,
+			   struct blk_stat_callback *cb)
 {
-	s64 now, value;
+	int i;
 
-	now = __blk_stat_time(ktime_to_ns(ktime_get()));
-	if (now < blk_stat_time(&rq->issue_stat))
-		return;
+	for_each_possible_cpu(i) {
+		struct blk_stats *stats = per_cpu_ptr(cb->stats, i);
 
-	if (!__blk_stat_is_current(stat, now))
-		__blk_stat_init(stat, now);
+		blk_stat_init(&stats->read);
+		blk_stat_init(&stats->write);
+	}
 
-	value = now - blk_stat_time(&rq->issue_stat);
-	if (value > stat->max)
-		stat->max = value;
-	if (value < stat->min)
-		stat->min = value;
+	spin_lock(&q->stats->lock);
+	list_add_tail_rcu(&cb->list, &q->stats->callbacks);
+	set_bit(QUEUE_FLAG_STATS, &q->queue_flags);
+	spin_unlock(&q->stats->lock);
+}
+EXPORT_SYMBOL_GPL(blk_stat_add_callback);
 
-	if (stat->batch + value < stat->batch ||
-	    stat->nr_batch + 1 == BLK_RQ_STAT_BATCH)
-		blk_stat_flush_batch(stat);
+void blk_stat_remove_callback(struct request_queue *q,
+			      struct blk_stat_callback *cb)
+{
+	spin_lock(&q->stats->lock);
+	list_del_rcu(&cb->list);
+	if (list_empty(&q->stats->callbacks))
+		clear_bit(QUEUE_FLAG_STATS, &q->queue_flags);
+	spin_unlock(&q->stats->lock);
 
-	stat->batch += value;
-	stat->nr_batch++;
+	del_timer_sync(&cb->timer);
 }
+EXPORT_SYMBOL_GPL(blk_stat_remove_callback);
 
-void blk_stat_clear(struct request_queue *q)
+static void blk_stat_free_callback_rcu(struct rcu_head *head)
 {
-	if (q->mq_ops) {
-		struct blk_mq_hw_ctx *hctx;
-		struct blk_mq_ctx *ctx;
-		int i, j;
-
-		queue_for_each_hw_ctx(q, hctx, i) {
-			hctx_for_each_ctx(hctx, ctx, j) {
-				blk_stat_init(&ctx->stat[BLK_STAT_READ]);
-				blk_stat_init(&ctx->stat[BLK_STAT_WRITE]);
-			}
-		}
-	} else {
-		blk_stat_init(&q->rq_stats[BLK_STAT_READ]);
-		blk_stat_init(&q->rq_stats[BLK_STAT_WRITE]);
-	}
+	struct blk_stat_callback *cb;
+
+	cb = container_of(head, struct blk_stat_callback, rcu);
+	free_percpu(cb->stats);
 }
 
-void blk_stat_set_issue_time(struct blk_issue_stat *stat)
+void blk_stat_free_callback(struct blk_stat_callback *cb)
 {
-	stat->time = (stat->time & BLK_STAT_MASK) |
-			(ktime_to_ns(ktime_get()) & BLK_STAT_TIME_MASK);
+	call_rcu(&cb->rcu, blk_stat_free_callback_rcu);
 }
+EXPORT_SYMBOL_GPL(blk_stat_free_callback);
 
-/*
- * Enable stat tracking, return whether it was enabled
- */
-bool blk_stat_enable(struct request_queue *q)
+struct blk_queue_stats *blk_alloc_queue_stats(void)
 {
-	if (!test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		set_bit(QUEUE_FLAG_STATS, &q->queue_flags);
-		return false;
-	}
+	struct blk_queue_stats *stats;
+
+	stats = kmalloc(sizeof(*stats), GFP_KERNEL);
+	if (!stats)
+		return NULL;
+
+	INIT_LIST_HEAD(&stats->callbacks);
+	spin_lock_init(&stats->lock);
+
+	return stats;
+}
+
+void blk_free_queue_stats(struct blk_queue_stats *stats)
+{
+	if (!stats)
+		return;
+
+	WARN_ON(!list_empty(&stats->callbacks));
 
-	return true;
+	kfree(stats);
 }
diff --git a/block/blk-stat.h b/block/blk-stat.h
index a24439aab710..fd6ba9183b17 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -1,11 +1,11 @@
 #ifndef BLK_STAT_H
 #define BLK_STAT_H
 
-/*
- * ~0.13s window as a power-of-2 (2^27 nsecs)
- */
-#define BLK_STAT_NSEC		134217728ULL
-#define BLK_STAT_NSEC_MASK	~(BLK_STAT_NSEC - 1)
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/ktime.h>
+#include <linux/rcupdate.h>
+#include <linux/timer.h>
 
 /*
  * Upper 3 bits can be used elsewhere
@@ -15,19 +15,27 @@
 #define BLK_STAT_TIME_MASK	((1ULL << BLK_STAT_SHIFT) - 1)
 #define BLK_STAT_MASK		~BLK_STAT_TIME_MASK
 
-enum {
-	BLK_STAT_READ	= 0,
-	BLK_STAT_WRITE,
+#define BLK_RQ_STAT_BATCH	64
+
+struct blk_stat_callback {
+	struct list_head list;
+	struct timer_list timer;
+	struct blk_stats __percpu *stats;
+	void (*fn)(struct blk_stat_callback *, struct blk_stats *);
+	void *data;
+	struct rcu_head rcu;
 };
 
-void blk_stat_add(struct blk_rq_stat *, struct request *);
-void blk_hctx_stat_get(struct blk_mq_hw_ctx *, struct blk_stats *);
-void blk_queue_stat_get(struct request_queue *, struct blk_stats *);
-void blk_stat_clear(struct request_queue *);
-void blk_stat_init(struct blk_rq_stat *);
-bool blk_stat_is_current(struct blk_rq_stat *);
-void blk_stat_set_issue_time(struct blk_issue_stat *);
-bool blk_stat_enable(struct request_queue *);
+struct blk_queue_stats *blk_alloc_queue_stats(void);
+void blk_free_queue_stats(struct blk_queue_stats *);
+
+void blk_stat_add(struct request *);
+
+static inline void blk_stat_set_issue_time(struct blk_issue_stat *stat)
+{
+	stat->time = ((stat->time & BLK_STAT_MASK) |
+		      (ktime_to_ns(ktime_get()) & BLK_STAT_TIME_MASK));
+}
 
 static inline u64 __blk_stat_time(u64 time)
 {
@@ -39,4 +47,62 @@ static inline u64 blk_stat_time(struct blk_issue_stat *stat)
 	return __blk_stat_time(stat->time);
 }
 
+/**
+ * blk_stat_alloc_callback() - Allocate a block statistics callback.
+ * @fn: Callback function.
+ * @data: Value for the @data field of the &struct blk_stat_callback.
+ *
+ * Return: &struct blk_stat_callback on success or NULL on ENOMEM.
+ */
+struct blk_stat_callback *
+blk_stat_alloc_callback(void (*fn)(struct blk_stat_callback *, struct blk_stats *),
+			void *data);
+
+/**
+ * blk_stat_add_callback() - Add a block statistics callback to be run on a
+ * request queue.
+ * @q: The request queue.
+ * @cb: The callback.
+ *
+ * Note that a single &struct blk_stat_callback can only be added to a single
+ * &struct request_queue.
+ */
+void blk_stat_add_callback(struct request_queue *q,
+			   struct blk_stat_callback *cb);
+
+/**
+ * blk_stat_remove_callback() - Remove a block statistics callback from a
+ * request queue.
+ * @q: The request queue.
+ * @cb: The callback.
+ *
+ * When this returns, the callback is not running on any CPUs and will not be
+ * called again unless readded.
+ */
+void blk_stat_remove_callback(struct request_queue *q,
+			      struct blk_stat_callback *cb);
+
+/**
+ * blk_stat_free_callback() - Free a block statistics callback.
+ * @cb: The callback.
+ *
+ * @cb may be NULL, in which case this does nothing. If it is not NULL, @cb must
+ * not be associated with a request queue. I.e., if it was previously added with
+ * blk_stat_add_callback(), it must also have been removed since then with
+ * blk_stat_remove_callback().
+ */
+void blk_stat_free_callback(struct blk_stat_callback *cb);
+
+/**
+ * blk_stat_arm_callback() - Set a block statistics callback to fire at a given
+ * time.
+ * @cb: The callback.
+ * @expires: The time (in jiffies) at which to run.
+ */
+static inline void blk_stat_arm_callback(struct blk_stat_callback *cb,
+					 unsigned long expires)
+{
+	mod_timer(&cb->timer, expires);
+}
+
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 6e1cf622af21..fa831cb2fc30 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -785,6 +785,9 @@ static void blk_release_queue(struct kobject *kobj)
 		container_of(kobj, struct request_queue, kobj);
 
 	wbt_exit(q);
+	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
+		blk_stat_remove_callback(q, q->poll_cb);
+	blk_stat_free_callback(q->poll_cb);
 	bdi_put(q->backing_dev_info);
 	blkcg_exit_queue(q);
 
@@ -793,6 +796,8 @@ static void blk_release_queue(struct kobject *kobj)
 		elevator_exit(q->elevator);
 	}
 
+	blk_free_queue_stats(q->stats);
+
 	blk_exit_rl(&q->root_rl);
 
 	if (q->queue_tags)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 5e81068f7c52..695bb92be82b 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -277,7 +277,7 @@ enum {
 	LAT_EXCEEDED,
 };
 
-static int __latency_exceeded(struct rq_wb *rwb, struct blk_stats *stats)
+static int latency_exceeded(struct rq_wb *rwb, struct blk_stats *stats)
 {
 	struct backing_dev_info *bdi = rwb->queue->backing_dev_info;
 	u64 thislat;
@@ -308,8 +308,8 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_stats *stats)
 		 * waited or still has writes in flights, consider us doing
 		 * just writes as well.
 		 */
-		if ((stats->write.nr_samples && blk_stat_is_current(&stats->read)) ||
-		    wb_recent_wait(rwb) || wbt_inflight(rwb))
+		if (stats->write.nr_samples || wb_recent_wait(rwb) ||
+		    wbt_inflight(rwb))
 			return LAT_UNKNOWN_WRITES;
 		return LAT_UNKNOWN;
 	}
@@ -329,14 +329,6 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_stats *stats)
 	return LAT_OK;
 }
 
-static int latency_exceeded(struct rq_wb *rwb)
-{
-	struct blk_stats stats;
-
-	blk_queue_stat_get(rwb->queue, &stats);
-	return __latency_exceeded(rwb, &stats);
-}
-
 static void rwb_trace_step(struct rq_wb *rwb, const char *msg)
 {
 	struct backing_dev_info *bdi = rwb->queue->backing_dev_info;
@@ -355,7 +347,6 @@ static void scale_up(struct rq_wb *rwb)
 
 	rwb->scale_step--;
 	rwb->unknown_cnt = 0;
-	blk_stat_clear(rwb->queue);
 
 	rwb->scaled_max = calc_wb_limits(rwb);
 
@@ -385,7 +376,6 @@ static void scale_down(struct rq_wb *rwb, bool hard_throttle)
 
 	rwb->scaled_max = false;
 	rwb->unknown_cnt = 0;
-	blk_stat_clear(rwb->queue);
 	calc_wb_limits(rwb);
 	rwb_trace_step(rwb, "step down");
 }
@@ -412,16 +402,16 @@ static void rwb_arm_timer(struct rq_wb *rwb)
 	}
 
 	expires = jiffies + nsecs_to_jiffies(rwb->cur_win_nsec);
-	mod_timer(&rwb->window_timer, expires);
+	blk_stat_arm_callback(rwb->cb, expires);
 }
 
-static void wb_timer_fn(unsigned long data)
+static void wb_timer_fn(struct blk_stat_callback *cb, struct blk_stats *stats)
 {
-	struct rq_wb *rwb = (struct rq_wb *) data;
+	struct rq_wb *rwb = cb->data;
 	unsigned int inflight = wbt_inflight(rwb);
 	int status;
 
-	status = latency_exceeded(rwb);
+	status = latency_exceeded(rwb, stats);
 
 	trace_wbt_timer(rwb->queue->backing_dev_info, status, rwb->scale_step,
 			inflight);
@@ -614,7 +604,7 @@ enum wbt_flags wbt_wait(struct rq_wb *rwb, struct bio *bio, spinlock_t *lock)
 
 	__wbt_wait(rwb, bio->bi_opf, lock);
 
-	if (!timer_pending(&rwb->window_timer))
+	if (!timer_pending(&rwb->cb->timer))
 		rwb_arm_timer(rwb);
 
 	if (current_is_kswapd())
@@ -675,7 +665,7 @@ void wbt_disable_default(struct request_queue *q)
 	struct rq_wb *rwb = q->rq_wb;
 
 	if (rwb && rwb->enable_state == WBT_STATE_ON_DEFAULT) {
-		del_timer_sync(&rwb->window_timer);
+		blk_stat_remove_callback(q, rwb->cb);
 		rwb->win_nsec = rwb->min_lat_nsec = 0;
 		wbt_update_limits(rwb);
 	}
@@ -699,24 +689,23 @@ int wbt_init(struct request_queue *q)
 	struct rq_wb *rwb;
 	int i;
 
-	/*
-	 * For now, we depend on the stats window being larger than
-	 * our monitoring window. Ensure that this isn't inadvertently
-	 * violated.
-	 */
-	BUILD_BUG_ON(RWB_WINDOW_NSEC > BLK_STAT_NSEC);
 	BUILD_BUG_ON(WBT_NR_BITS > BLK_STAT_RES_BITS);
 
 	rwb = kzalloc(sizeof(*rwb), GFP_KERNEL);
 	if (!rwb)
 		return -ENOMEM;
 
+	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, rwb);
+	if (!rwb->cb) {
+		kfree(rwb);
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < WBT_NUM_RWQ; i++) {
 		atomic_set(&rwb->rq_wait[i].inflight, 0);
 		init_waitqueue_head(&rwb->rq_wait[i].wait);
 	}
 
-	setup_timer(&rwb->window_timer, wb_timer_fn, (unsigned long) rwb);
 	rwb->wc = 1;
 	rwb->queue_depth = RWB_DEF_DEPTH;
 	rwb->last_comp = rwb->last_issue = jiffies;
@@ -726,10 +715,10 @@ int wbt_init(struct request_queue *q)
 	wbt_update_limits(rwb);
 
 	/*
-	 * Assign rwb, and turn on stats tracking for this queue
+	 * Assign rwb and add the stats callback.
 	 */
 	q->rq_wb = rwb;
-	blk_stat_enable(q);
+	blk_stat_add_callback(q, rwb->cb);
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 
@@ -744,7 +733,8 @@ void wbt_exit(struct request_queue *q)
 	struct rq_wb *rwb = q->rq_wb;
 
 	if (rwb) {
-		del_timer_sync(&rwb->window_timer);
+		blk_stat_remove_callback(q, rwb->cb);
+		blk_stat_free_callback(rwb->cb);
 		q->rq_wb = NULL;
 		kfree(rwb);
 	}
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index 65f1de519f67..591ff2f4b2ee 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -81,7 +81,7 @@ struct rq_wb {
 	u64 win_nsec;				/* default window size */
 	u64 cur_win_nsec;			/* current window size */
 
-	struct timer_list window_timer;
+	struct blk_stat_callback *cb;
 
 	s64 sync_issue;
 	void *sync_cookie;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 5e4c5380edf0..14789bdb3338 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -287,8 +287,6 @@ struct blk_issue_stat {
 	u64 time;
 };
 
-#define BLK_RQ_STAT_BATCH	64
-
 struct blk_rq_stat {
 	s64 mean;
 	u64 min;
@@ -296,7 +294,6 @@ struct blk_rq_stat {
 	s32 nr_samples;
 	s32 nr_batch;
 	u64 batch;
-	s64 time;
 };
 
 struct blk_stats {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5a7da607ca04..a093449adbb8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -40,6 +40,8 @@ struct blkcg_gq;
 struct blk_flush_queue;
 struct pr_ops;
 struct rq_wb;
+struct blk_queue_stats;
+struct blk_stat_callback;
 
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
@@ -388,6 +390,7 @@ struct request_queue {
 	int			nr_rqs[2];	/* # allocated [a]sync rqs */
 	int			nr_rqs_elvpriv;	/* # allocated rqs w/ elvpriv */
 
+	struct blk_queue_stats	*stats;
 	struct rq_wb		*rq_wb;
 
 	/*
@@ -505,8 +508,6 @@ struct request_queue {
 	unsigned int		nr_sorted;
 	unsigned int		in_flight[2];
 
-	struct blk_rq_stat	rq_stats[2];
-
 	/*
 	 * Number of active block driver functions for which blk_drain_queue()
 	 * must wait. Must be incremented around functions that unlock the
@@ -516,6 +517,10 @@ struct request_queue {
 
 	unsigned int		rq_timeout;
 	int			poll_nsec;
+
+	struct blk_stat_callback	*poll_cb;
+	struct blk_stats	poll_stats;
+
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
 	struct list_head	timeout_list;
@@ -611,6 +616,7 @@ struct request_queue {
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
 #define QUEUE_FLAG_STATS       27	/* track rq completion times */
 #define QUEUE_FLAG_RESTART     28	/* queue needs restart at completion */
+#define QUEUE_FLAG_POLL_STATS  29	/* collecting stats for hybrid polling */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
-- 
2.12.0
