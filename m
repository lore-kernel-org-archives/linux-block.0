Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34915 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757491AbdCUP5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Mar 2017 11:57:12 -0400
Received: by mail-pg0-f54.google.com with SMTP id t143so29936395pgb.2
        for <linux-block@vger.kernel.org>; Tue, 21 Mar 2017 08:57:12 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Omar Sandoval <osandov@fb.com>
Subject: [PATCH v2 4/4] blk-stat: convert to callback-based statistics reporting
Date: Tue, 21 Mar 2017 08:56:08 -0700
Message-Id: <3242ab8c712cf67bd3ac15e0853c35915cacf9f5.1490110621.git.osandov@fb.com>
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
References: <cover.1490110621.git.osandov@fb.com>
In-Reply-To: <cover.1490110621.git.osandov@fb.com>
References: <cover.1490110621.git.osandov@fb.com>
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
the statistics from the window during which the callback was active.
Users can dynamically bucketize the statistics. wbt and polling both
currently use read vs. write, but polling can be extended to further
subdivide based on request size.

The callbacks are kept on an RCU list, and each callback has percpu
stats buffers. There will only be a few users, so the overhead on the
I/O completion side is low. The stats flushing is also simplified
considerably: since the timer function is responsible for clearing the
statistics, we don't have to worry about stale statistics.

wbt is a trivial conversion. After the conversion, the windowing problem
mentioned above is fixed.

For polling, we register an extra callback that caches the previous
window's statistics in the struct request_queue for the hybrid polling
heuristic to use.

Since we no longer have a single stats buffer for the request queue,
this also removes the sysfs and debugfs stats entries. To replace those,
we add a debugfs entry for the poll statistics.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c          |   6 +-
 block/blk-mq-debugfs.c    |  99 +++++++--------
 block/blk-mq.c            |  76 +++++++----
 block/blk-mq.h            |   1 -
 block/blk-stat.c          | 311 ++++++++++++++++++++++------------------------
 block/blk-stat.h          | 181 +++++++++++++++++++++++++--
 block/blk-sysfs.c         |  31 +----
 block/blk-wbt.c           |  51 +++-----
 block/blk-wbt.h           |   2 +-
 include/linux/blk_types.h |   1 -
 include/linux/blkdev.h    |  10 +-
 11 files changed, 449 insertions(+), 320 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index e8a9bc0d4bbb..78d04ddededc 100644
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
@@ -2698,7 +2702,7 @@ void blk_finish_request(struct request *req, int error)
 	struct request_queue *q = req->q;
 
 	if (req->rq_flags & RQF_STATS)
-		blk_stat_add(&q->rq_stats[rq_data_dir(req)], req);
+		blk_stat_add(req);
 
 	if (req->rq_flags & RQF_QUEUED)
 		blk_queue_end_tag(q, req);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 48c88723944a..4b3f962a9c7a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -43,6 +43,42 @@ static int blk_mq_debugfs_seq_open(struct inode *inode, struct file *file,
 	return ret;
 }
 
+static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
+{
+	if (stat->nr_samples) {
+		seq_printf(m, "samples=%d, mean=%lld, min=%llu, max=%llu",
+			   stat->nr_samples, stat->mean, stat->min, stat->max);
+	} else {
+		seq_puts(m, "samples=0");
+	}
+}
+
+static int queue_poll_stat_show(struct seq_file *m, void *v)
+{
+	struct request_queue *q = m->private;
+
+	seq_puts(m, "read: ");
+	print_stat(m, &q->poll_stat[READ]);
+	seq_puts(m, "\n");
+
+	seq_puts(m, "write: ");
+	print_stat(m, &q->poll_stat[WRITE]);
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static int queue_poll_stat_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, queue_poll_stat_show, inode->i_private);
+}
+
+static const struct file_operations queue_poll_stat_fops = {
+	.open		= queue_poll_stat_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int hctx_state_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
@@ -322,60 +358,6 @@ static const struct file_operations hctx_io_poll_fops = {
 	.release	= single_release,
 };
 
-static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
-{
-	seq_printf(m, "samples=%d, mean=%lld, min=%llu, max=%llu",
-		   stat->nr_samples, stat->mean, stat->min, stat->max);
-}
-
-static int hctx_stats_show(struct seq_file *m, void *v)
-{
-	struct blk_mq_hw_ctx *hctx = m->private;
-	struct blk_rq_stat stat[2];
-
-	blk_stat_init(&stat[READ]);
-	blk_stat_init(&stat[WRITE]);
-
-	blk_hctx_stat_get(hctx, stat);
-
-	seq_puts(m, "read: ");
-	print_stat(m, &stat[READ]);
-	seq_puts(m, "\n");
-
-	seq_puts(m, "write: ");
-	print_stat(m, &stat[WRITE]);
-	seq_puts(m, "\n");
-	return 0;
-}
-
-static int hctx_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_stats_show, inode->i_private);
-}
-
-static ssize_t hctx_stats_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	struct seq_file *m = file->private_data;
-	struct blk_mq_hw_ctx *hctx = m->private;
-	struct blk_mq_ctx *ctx;
-	int i;
-
-	hctx_for_each_ctx(hctx, ctx, i) {
-		blk_stat_init(&ctx->stat[READ]);
-		blk_stat_init(&ctx->stat[WRITE]);
-	}
-	return count;
-}
-
-static const struct file_operations hctx_stats_fops = {
-	.open		= hctx_stats_open,
-	.read		= seq_read,
-	.write		= hctx_stats_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int hctx_dispatched_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
@@ -636,6 +618,11 @@ static const struct file_operations ctx_completed_fops = {
 	.release	= single_release,
 };
 
+static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
+	{"poll_stat", 0400, &queue_poll_stat_fops},
+	{},
+};
+
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, &hctx_state_fops},
 	{"flags", 0400, &hctx_flags_fops},
@@ -646,7 +633,6 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"sched_tags", 0400, &hctx_sched_tags_fops},
 	{"sched_tags_bitmap", 0400, &hctx_sched_tags_bitmap_fops},
 	{"io_poll", 0600, &hctx_io_poll_fops},
-	{"stats", 0600, &hctx_stats_fops},
 	{"dispatched", 0600, &hctx_dispatched_fops},
 	{"queued", 0600, &hctx_queued_fops},
 	{"run", 0600, &hctx_run_fops},
@@ -753,6 +739,9 @@ int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 	if (!q->mq_debugfs_dir)
 		goto err;
 
+	if (!debugfs_create_files(q->mq_debugfs_dir, q, blk_mq_debugfs_queue_attrs))
+		goto err;
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_debugfs_register_hctx(q, hctx))
 			goto err;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 559e5363bb2c..5ff66f203cd0 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -39,6 +39,9 @@
 static DEFINE_MUTEX(all_q_mutex);
 static LIST_HEAD(all_q_list);
 
+static void blk_mq_poll_stats_start(struct request_queue *q);
+static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
+
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
@@ -432,15 +435,8 @@ static void blk_mq_ipi_complete_request(struct request *rq)
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
 
@@ -2040,8 +2036,6 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		spin_lock_init(&__ctx->lock);
 		INIT_LIST_HEAD(&__ctx->rq_list);
 		__ctx->queue = q;
-		blk_stat_init(&__ctx->stat[READ]);
-		blk_stat_init(&__ctx->stat[WRITE]);
 
 		/* If the cpu isn't online, the cpu is mapped to first hctx */
 		if (!cpu_online(i))
@@ -2339,6 +2333,15 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
+	q->stats = blk_alloc_queue_stats();
+	if (!q->stats)
+		goto err_exit;
+
+	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
+					     blk_stat_rq_ddir, 2, q);
+	if (!q->poll_cb)
+		goto err_exit;
+
 	q->queue_ctx = alloc_percpu(struct blk_mq_ctx);
 	if (!q->queue_ctx)
 		goto err_exit;
@@ -2740,28 +2743,53 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
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
+	 * callback is already active.
+	 */
+	if (!test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags) ||
+	    blk_stat_is_active(q->poll_cb))
+		return;
+
+	blk_stat_activate_msecs(q->poll_cb, 100);
+}
+
+static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb)
+{
+	struct request_queue *q = cb->data;
+
+	if (cb->stat[READ].nr_samples)
+		q->poll_stat[READ] = cb->stat[READ];
+	if (cb->stat[WRITE].nr_samples)
+		q->poll_stat[WRITE] = cb->stat[WRITE];
+}
+
 static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 				       struct blk_mq_hw_ctx *hctx,
 				       struct request *rq)
 {
-	struct blk_rq_stat stat[2];
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
-	memset(&stat, 0, sizeof(stat));
-	blk_hctx_stat_get(hctx, stat);
-
-	/*
 	 * As an optimistic guess, use half of the mean service time
 	 * for this type of request. We can (and should) make this smarter.
 	 * For instance, if the completion latencies are tight, we can
@@ -2769,10 +2797,10 @@ static unsigned long blk_mq_poll_nsecs(struct request_queue *q,
 	 * important on devices where the completion latencies are longer
 	 * than ~10 usec.
 	 */
-	if (req_op(rq) == REQ_OP_READ && stat[READ].nr_samples)
-		ret = (stat[READ].mean + 1) / 2;
-	else if (req_op(rq) == REQ_OP_WRITE && stat[WRITE].nr_samples)
-		ret = (stat[WRITE].mean + 1) / 2;
+	if (req_op(rq) == REQ_OP_READ && q->poll_stat[READ].nr_samples)
+		ret = (q->poll_stat[READ].mean + 1) / 2;
+	else if (req_op(rq) == REQ_OP_WRITE && q->poll_stat[WRITE].nr_samples)
+		ret = (q->poll_stat[WRITE].mean + 1) / 2;
 
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
index 4681c488c262..0d8721a60db9 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2016 Jens Axboe
  */
 #include <linux/kernel.h>
+#include <linux/rculist.h>
 #include <linux/blk-mq.h>
 
 #include "blk-stat.h"
@@ -11,6 +12,24 @@
 
 #define BLK_RQ_STAT_BATCH	64
 
+struct blk_queue_stats {
+	struct list_head callbacks;
+	spinlock_t lock;
+};
+
+unsigned int blk_stat_rq_ddir(const struct request *rq)
+{
+	return rq_data_dir(rq);
+}
+EXPORT_SYMBOL_GPL(blk_stat_rq_ddir);
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
@@ -50,207 +69,171 @@ static void blk_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
 	dst->nr_samples += src->nr_samples;
 }
 
-static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
+static void __blk_stat_add(struct blk_rq_stat *stat, u64 value)
 {
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
-	uint64_t latest = 0;
-	int i, j, nr;
-
-	blk_stat_init(&dst[READ]);
-	blk_stat_init(&dst[WRITE]);
-
-	nr = 0;
-	do {
-		uint64_t newest = 0;
-
-		queue_for_each_hw_ctx(q, hctx, i) {
-			hctx_for_each_ctx(hctx, ctx, j) {
-				blk_stat_flush_batch(&ctx->stat[READ]);
-				blk_stat_flush_batch(&ctx->stat[WRITE]);
-
-				if (!ctx->stat[READ].nr_samples &&
-				    !ctx->stat[WRITE].nr_samples)
-					continue;
-				if (ctx->stat[READ].time > newest)
-					newest = ctx->stat[READ].time;
-				if (ctx->stat[WRITE].time > newest)
-					newest = ctx->stat[WRITE].time;
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
-				if (ctx->stat[READ].time == newest) {
-					blk_stat_sum(&dst[READ],
-						     &ctx->stat[READ]);
-					nr++;
-				}
-				if (ctx->stat[WRITE].time == newest) {
-					blk_stat_sum(&dst[WRITE],
-						     &ctx->stat[WRITE]);
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
 
-	dst[READ].time = dst[WRITE].time = latest;
+	stat->batch += value;
+	stat->nr_batch++;
 }
 
-void blk_queue_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
+void blk_stat_add(struct request *rq)
 {
-	if (q->mq_ops)
-		blk_mq_stat_get(q, dst);
-	else {
-		blk_stat_flush_batch(&q->rq_stats[READ]);
-		blk_stat_flush_batch(&q->rq_stats[WRITE]);
-		memcpy(&dst[READ], &q->rq_stats[READ],
-		       sizeof(struct blk_rq_stat));
-		memcpy(&dst[WRITE], &q->rq_stats[WRITE],
-		       sizeof(struct blk_rq_stat));
+	struct request_queue *q = rq->q;
+	struct blk_stat_callback *cb;
+	struct blk_rq_stat *stat;
+	int bucket;
+	s64 now, value;
+
+	now = __blk_stat_time(ktime_to_ns(ktime_get()));
+	if (now < blk_stat_time(&rq->issue_stat))
+		return;
+
+	value = now - blk_stat_time(&rq->issue_stat);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
+		if (blk_stat_is_active(cb)) {
+			bucket = cb->bucket_fn(rq);
+			stat = &this_cpu_ptr(cb->cpu_stat)[bucket];
+			__blk_stat_add(stat, value);
+		}
 	}
+	rcu_read_unlock();
 }
 
-void blk_hctx_stat_get(struct blk_mq_hw_ctx *hctx, struct blk_rq_stat *dst)
+static void blk_stat_timer_fn(unsigned long data)
 {
-	struct blk_mq_ctx *ctx;
-	unsigned int i, nr;
+	struct blk_stat_callback *cb = (void *)data;
+	unsigned int bucket;
+	int cpu;
 
-	nr = 0;
-	do {
-		uint64_t newest = 0;
+	for (bucket = 0; bucket < cb->buckets; bucket++)
+		blk_stat_init(&cb->stat[bucket]);
 
-		hctx_for_each_ctx(hctx, ctx, i) {
-			blk_stat_flush_batch(&ctx->stat[READ]);
-			blk_stat_flush_batch(&ctx->stat[WRITE]);
+	for_each_online_cpu(cpu) {
+		struct blk_rq_stat *cpu_stat;
 
-			if (!ctx->stat[READ].nr_samples &&
-			    !ctx->stat[WRITE].nr_samples)
-				continue;
-
-			if (ctx->stat[READ].time > newest)
-				newest = ctx->stat[READ].time;
-			if (ctx->stat[WRITE].time > newest)
-				newest = ctx->stat[WRITE].time;
+		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
+		for (bucket = 0; bucket < cb->buckets; bucket++) {
+			blk_stat_sum(&cb->stat[bucket], &cpu_stat[bucket]);
+			blk_stat_init(&cpu_stat[bucket]);
 		}
+	}
 
-		if (!newest)
-			break;
-
-		hctx_for_each_ctx(hctx, ctx, i) {
-			if (ctx->stat[READ].time == newest) {
-				blk_stat_sum(&dst[READ], &ctx->stat[READ]);
-				nr++;
-			}
-			if (ctx->stat[WRITE].time == newest) {
-				blk_stat_sum(&dst[WRITE], &ctx->stat[WRITE]);
-				nr++;
-			}
-		}
-		/*
-		 * If we race on finding an entry, just loop back again.
-		 * Should be very rare, as the window is only updated
-		 * occasionally
-		 */
-	} while (!nr);
+	cb->timer_fn(cb);
 }
 
-static void __blk_stat_init(struct blk_rq_stat *stat, s64 time_now)
+struct blk_stat_callback *
+blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
+			unsigned int (*bucket_fn)(const struct request *),
+			unsigned int buckets, void *data)
 {
-	stat->min = -1ULL;
-	stat->max = stat->nr_samples = stat->mean = 0;
-	stat->batch = stat->nr_batch = 0;
-	stat->time = time_now & BLK_STAT_NSEC_MASK;
-}
+	struct blk_stat_callback *cb;
 
-void blk_stat_init(struct blk_rq_stat *stat)
-{
-	__blk_stat_init(stat, ktime_to_ns(ktime_get()));
-}
+	cb = kmalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb)
+		return NULL;
 
-static bool __blk_stat_is_current(struct blk_rq_stat *stat, s64 now)
-{
-	return (now & BLK_STAT_NSEC_MASK) == (stat->time & BLK_STAT_NSEC_MASK);
-}
+	cb->stat = kmalloc_array(buckets, sizeof(struct blk_rq_stat),
+				 GFP_KERNEL);
+	if (!cb->stat) {
+		kfree(cb);
+		return NULL;
+	}
+	cb->cpu_stat = __alloc_percpu(buckets * sizeof(struct blk_rq_stat),
+				      __alignof__(struct blk_rq_stat));
+	if (!cb->cpu_stat) {
+		kfree(cb->stat);
+		kfree(cb);
+		return NULL;
+	}
 
-bool blk_stat_is_current(struct blk_rq_stat *stat)
-{
-	return __blk_stat_is_current(stat, ktime_to_ns(ktime_get()));
+	cb->timer_fn = timer_fn;
+	cb->bucket_fn = bucket_fn;
+	cb->data = data;
+	cb->buckets = buckets;
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
+	unsigned int bucket;
+	int cpu;
 
-	now = __blk_stat_time(ktime_to_ns(ktime_get()));
-	if (now < blk_stat_time(&rq->issue_stat))
-		return;
+	for_each_possible_cpu(cpu) {
+		struct blk_rq_stat *cpu_stat;
 
-	if (!__blk_stat_is_current(stat, now))
-		__blk_stat_init(stat, now);
+		cpu_stat = per_cpu_ptr(cb->cpu_stat, cpu);
+		for (bucket = 0; bucket < cb->buckets; bucket++)
+			blk_stat_init(&cpu_stat[bucket]);
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
-				blk_stat_init(&ctx->stat[READ]);
-				blk_stat_init(&ctx->stat[WRITE]);
-			}
-		}
-	} else {
-		blk_stat_init(&q->rq_stats[READ]);
-		blk_stat_init(&q->rq_stats[WRITE]);
-	}
+	struct blk_stat_callback *cb;
+
+	cb = container_of(head, struct blk_stat_callback, rcu);
+	free_percpu(cb->cpu_stat);
+	kfree(cb->stat);
+	kfree(cb);
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
index 34384328b46b..6ad5b8c59a79 100644
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
@@ -15,14 +15,69 @@
 #define BLK_STAT_TIME_MASK	((1ULL << BLK_STAT_SHIFT) - 1)
 #define BLK_STAT_MASK		~BLK_STAT_TIME_MASK
 
-void blk_stat_add(struct blk_rq_stat *, struct request *);
-void blk_hctx_stat_get(struct blk_mq_hw_ctx *, struct blk_rq_stat *);
-void blk_queue_stat_get(struct request_queue *, struct blk_rq_stat *);
-void blk_stat_clear(struct request_queue *);
-void blk_stat_init(struct blk_rq_stat *);
-bool blk_stat_is_current(struct blk_rq_stat *);
-void blk_stat_set_issue_time(struct blk_issue_stat *);
-bool blk_stat_enable(struct request_queue *);
+/**
+ * struct blk_stat_callback - Block statistics callback.
+ *
+ * A &struct blk_stat_callback is associated with a &struct request_queue. While
+ * @timer is active, that queue's request completion latencies are sorted into
+ * buckets by @bucket_fn and added to a per-cpu buffer, @cpu_stat. When the
+ * timer fires, @cpu_stat is flushed to @stat and @timer_fn is invoked.
+ */
+struct blk_stat_callback {
+	/*
+	 * @list: RCU list of callbacks for a &struct request_queue.
+	 */
+	struct list_head list;
+
+	/**
+	 * @timer: Timer for the next callback invocation.
+	 */
+	struct timer_list timer;
+
+	/**
+	 * @cpu_stat: Per-cpu statistics buckets.
+	 */
+	struct blk_rq_stat __percpu *cpu_stat;
+
+	/**
+	 * @bucket_fn: Given a request, returns which statistics bucket it
+	 * should be accounted under.
+	 */
+	unsigned int (*bucket_fn)(const struct request *);
+
+	/**
+	 * @buckets: Number of statistics buckets.
+	 */
+	unsigned int buckets;
+
+	/**
+	 * @stat: Array of statistics buckets.
+	 */
+	struct blk_rq_stat *stat;
+
+	/**
+	 * @fn: Callback function.
+	 */
+	void (*timer_fn)(struct blk_stat_callback *);
+
+	/**
+	 * @data: Private pointer for the user.
+	 */
+	void *data;
+
+	struct rcu_head rcu;
+};
+
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
@@ -34,4 +89,104 @@ static inline u64 blk_stat_time(struct blk_issue_stat *stat)
 	return __blk_stat_time(stat->time);
 }
 
+/*
+ * blk_stat_rq_ddir() - Bucket callback function for the request data direction.
+ * @rq: Request.
+ *
+ * This is the same as rq_data_dir() but as a function so it can be used as
+ * @bucket_fn for blk_stat_alloc_callback().
+ *
+ * Return: Data direction of the request, either READ or WRITE.
+ */
+unsigned int blk_stat_rq_ddir(const struct request *rq);
+
+/**
+ * blk_stat_alloc_callback() - Allocate a block statistics callback.
+ * @timer_fn: Timer callback function.
+ * @bucket_fn: Bucket callback function.
+ * @buckets: Number of statistics buckets.
+ * @data: Value for the @data field of the &struct blk_stat_callback.
+ *
+ * See &struct blk_stat_callback for details on the callback functions.
+ *
+ * Return: &struct blk_stat_callback on success or NULL on ENOMEM.
+ */
+struct blk_stat_callback *
+blk_stat_alloc_callback(void (*timer_fn)(struct blk_stat_callback *),
+			unsigned int (*bucket_fn)(const struct request *),
+			unsigned int buckets, void *data);
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
+ * blk_stat_is_active() - Check if a block statistics callback is currently
+ * gathering statistics.
+ * @cb: The callback.
+ */
+static inline bool blk_stat_is_active(struct blk_stat_callback *cb)
+{
+	return timer_pending(&cb->timer);
+}
+
+/**
+ * blk_stat_activate_nsecs() - Gather block statistics during a time window in
+ * nanoseconds.
+ * @cb: The callback.
+ * @nsecs: Number of nanoseconds to gather statistics for.
+ *
+ * The timer callback will be called when the window expires.
+ */
+static inline void blk_stat_activate_nsecs(struct blk_stat_callback *cb,
+					   u64 nsecs)
+{
+	mod_timer(&cb->timer, jiffies + nsecs_to_jiffies(nsecs));
+}
+
+/**
+ * blk_stat_activate_msecs() - Gather block statistics during a time window in
+ * milliseconds.
+ * @cb: The callback.
+ * @msecs: Number of milliseconds to gather statistics for.
+ *
+ * The timer callback will be called when the window expires.
+ */
+static inline void blk_stat_activate_msecs(struct blk_stat_callback *cb,
+					   unsigned int msecs)
+{
+	mod_timer(&cb->timer, jiffies + msecs_to_jiffies(msecs));
+}
+
 #endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fdb45fd0db0b..fa831cb2fc30 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -503,26 +503,6 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
-static ssize_t print_stat(char *page, struct blk_rq_stat *stat, const char *pre)
-{
-	return sprintf(page, "%s samples=%llu, mean=%lld, min=%lld, max=%lld\n",
-			pre, (long long) stat->nr_samples,
-			(long long) stat->mean, (long long) stat->min,
-			(long long) stat->max);
-}
-
-static ssize_t queue_stats_show(struct request_queue *q, char *page)
-{
-	struct blk_rq_stat stat[2];
-	ssize_t ret;
-
-	blk_queue_stat_get(q, stat);
-
-	ret = print_stat(page, &stat[READ], "read :");
-	ret += print_stat(page + ret, &stat[WRITE], "write:");
-	return ret;
-}
-
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_requests_show,
@@ -691,11 +671,6 @@ static struct queue_sysfs_entry queue_dax_entry = {
 	.show = queue_dax_show,
 };
 
-static struct queue_sysfs_entry queue_stats_entry = {
-	.attr = {.name = "stats", .mode = S_IRUGO },
-	.show = queue_stats_show,
-};
-
 static struct queue_sysfs_entry queue_wb_lat_entry = {
 	.attr = {.name = "wbt_lat_usec", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_wb_lat_show,
@@ -733,7 +708,6 @@ static struct attribute *default_attrs[] = {
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
 	&queue_dax_entry.attr,
-	&queue_stats_entry.attr,
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
 	NULL,
@@ -811,6 +785,9 @@ static void blk_release_queue(struct kobject *kobj)
 		container_of(kobj, struct request_queue, kobj);
 
 	wbt_exit(q);
+	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
+		blk_stat_remove_callback(q, q->poll_cb);
+	blk_stat_free_callback(q->poll_cb);
 	bdi_put(q->backing_dev_info);
 	blkcg_exit_queue(q);
 
@@ -819,6 +796,8 @@ static void blk_release_queue(struct kobject *kobj)
 		elevator_exit(q->elevator);
 	}
 
+	blk_free_queue_stats(q->stats);
+
 	blk_exit_rl(&q->root_rl);
 
 	if (q->queue_tags)
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index aafe5b551224..ffa80e11cf14 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -277,7 +277,7 @@ enum {
 	LAT_EXCEEDED,
 };
 
-static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
+static int latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 {
 	struct backing_dev_info *bdi = rwb->queue->backing_dev_info;
 	u64 thislat;
@@ -308,8 +308,8 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 		 * waited or still has writes in flights, consider us doing
 		 * just writes as well.
 		 */
-		if ((stat[WRITE].nr_samples && blk_stat_is_current(stat)) ||
-		    wb_recent_wait(rwb) || wbt_inflight(rwb))
+		if (stat[WRITE].nr_samples || wb_recent_wait(rwb) ||
+		    wbt_inflight(rwb))
 			return LAT_UNKNOWN_WRITES;
 		return LAT_UNKNOWN;
 	}
@@ -329,14 +329,6 @@ static int __latency_exceeded(struct rq_wb *rwb, struct blk_rq_stat *stat)
 	return LAT_OK;
 }
 
-static int latency_exceeded(struct rq_wb *rwb)
-{
-	struct blk_rq_stat stat[2];
-
-	blk_queue_stat_get(rwb->queue, stat);
-	return __latency_exceeded(rwb, stat);
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
 
@@ -385,15 +376,12 @@ static void scale_down(struct rq_wb *rwb, bool hard_throttle)
 
 	rwb->scaled_max = false;
 	rwb->unknown_cnt = 0;
-	blk_stat_clear(rwb->queue);
 	calc_wb_limits(rwb);
 	rwb_trace_step(rwb, "step down");
 }
 
 static void rwb_arm_timer(struct rq_wb *rwb)
 {
-	unsigned long expires;
-
 	if (rwb->scale_step > 0) {
 		/*
 		 * We should speed this up, using some variant of a fast
@@ -411,17 +399,16 @@ static void rwb_arm_timer(struct rq_wb *rwb)
 		rwb->cur_win_nsec = rwb->win_nsec;
 	}
 
-	expires = jiffies + nsecs_to_jiffies(rwb->cur_win_nsec);
-	mod_timer(&rwb->window_timer, expires);
+	blk_stat_activate_nsecs(rwb->cb, rwb->cur_win_nsec);
 }
 
-static void wb_timer_fn(unsigned long data)
+static void wb_timer_fn(struct blk_stat_callback *cb)
 {
-	struct rq_wb *rwb = (struct rq_wb *) data;
+	struct rq_wb *rwb = cb->data;
 	unsigned int inflight = wbt_inflight(rwb);
 	int status;
 
-	status = latency_exceeded(rwb);
+	status = latency_exceeded(rwb, cb->stat);
 
 	trace_wbt_timer(rwb->queue->backing_dev_info, status, rwb->scale_step,
 			inflight);
@@ -614,7 +601,7 @@ enum wbt_flags wbt_wait(struct rq_wb *rwb, struct bio *bio, spinlock_t *lock)
 
 	__wbt_wait(rwb, bio->bi_opf, lock);
 
-	if (!timer_pending(&rwb->window_timer))
+	if (!blk_stat_is_active(rwb->cb))
 		rwb_arm_timer(rwb);
 
 	if (current_is_kswapd())
@@ -675,7 +662,7 @@ void wbt_disable_default(struct request_queue *q)
 	struct rq_wb *rwb = q->rq_wb;
 
 	if (rwb && rwb->enable_state == WBT_STATE_ON_DEFAULT) {
-		del_timer_sync(&rwb->window_timer);
+		blk_stat_remove_callback(q, rwb->cb);
 		rwb->win_nsec = rwb->min_lat_nsec = 0;
 		wbt_update_limits(rwb);
 	}
@@ -699,24 +686,23 @@ int wbt_init(struct request_queue *q)
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
 
+	rwb->cb = blk_stat_alloc_callback(wb_timer_fn, blk_stat_rq_ddir, 2, rwb);
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
@@ -726,10 +712,10 @@ int wbt_init(struct request_queue *q)
 	wbt_update_limits(rwb);
 
 	/*
-	 * Assign rwb, and turn on stats tracking for this queue
+	 * Assign rwb and add the stats callback.
 	 */
 	q->rq_wb = rwb;
-	blk_stat_enable(q);
+	blk_stat_add_callback(q, rwb->cb);
 
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
 
@@ -744,7 +730,8 @@ void wbt_exit(struct request_queue *q)
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
index e213c5e7500b..270119a501fb 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -294,7 +294,6 @@ struct blk_rq_stat {
 	s32 nr_samples;
 	s32 nr_batch;
 	u64 batch;
-	s64 time;
 };
 
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5a7da607ca04..1a7dc42a8918 100644
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
+	struct blk_rq_stat	poll_stat[2];
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
