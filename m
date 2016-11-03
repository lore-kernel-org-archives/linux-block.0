Return-Path: <prvs=0115b0b9d1=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <hch@lst.de>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 2/5] block: add scalable completion tracking of requests
Date: Thu, 3 Nov 2016 13:45:04 -0600
Message-ID: <1478202307-1947-3-git-send-email-axboe@fb.com>
In-Reply-To: <1478202307-1947-1-git-send-email-axboe@fb.com>
References: <1478202307-1947-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

For legacy block, we simply track them in the request queue. For
blk-mq, we track them on a per-sw queue basis, which we can then
sum up through the hardware queues and finally to a per device
state.

The stats are tracked in, roughly, 0.1s interval windows.

Add sysfs files to display the stats.

The feature is off by default, to avoid any extra overhead. In-kernel
users of it can turn it on by setting QUEUE_FLAG_STATS in the queue
flags. We currently don't turn it on if someone just reads any of
the stats files, that is something we could add as well.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/Makefile            |   2 +-
 block/blk-core.c          |  14 ++-
 block/blk-mq-sysfs.c      |  47 +++++++++
 block/blk-mq.c            |  19 ++++
 block/blk-mq.h            |   3 +
 block/blk-stat.c          | 245 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-stat.h          |  43 ++++++++
 block/blk-sysfs.c         |  26 +++++
 include/linux/blk_types.h |  16 +++
 include/linux/blkdev.h    |   7 ++
 10 files changed, 419 insertions(+), 3 deletions(-)
 create mode 100644 block/blk-stat.c
 create mode 100644 block/blk-stat.h

diff --git a/block/Makefile b/block/Makefile
index 934dac73fb37..2528c596f7ec 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -5,7 +5,7 @@
 obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-tag.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
-			blk-lib.o blk-mq.o blk-mq-tag.o \
+			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o ioctl.o \
 			genhd.o scsi_ioctl.o partition-generic.o ioprio.o \
 			badblocks.o partitions/
diff --git a/block/blk-core.c b/block/blk-core.c
index 0bfaa54d3e9f..9dc7e9314d4c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2462,6 +2462,11 @@ void blk_start_request(struct request *req)
 {
 	blk_dequeue_request(req);
 
+	if (test_bit(QUEUE_FLAG_STATS, &req->q->queue_flags)) {
+		blk_stat_set_issue_time(&req->issue_stat);
+		req->rq_flags |= RQF_STATS;
+	}
+
 	/*
 	 * We are now handing the request to the hardware, initialize
 	 * resid_len to full count and add the timeout handler.
@@ -2681,8 +2686,13 @@ EXPORT_SYMBOL_GPL(blk_unprep_request);
  */
 void blk_finish_request(struct request *req, int error)
 {
+	struct request_queue *q = req->q;
+
+	if (req->rq_flags & RQF_STATS)
+		blk_stat_add(&q->rq_stats[rq_data_dir(req)], req);
+
 	if (req->rq_flags & RQF_QUEUED)
-		blk_queue_end_tag(req->q, req);
+		blk_queue_end_tag(q, req);
 
 	BUG_ON(blk_queued_rq(req));
 
@@ -2702,7 +2712,7 @@ void blk_finish_request(struct request *req, int error)
 		if (blk_bidi_rq(req))
 			__blk_put_request(req->next_rq->q, req->next_rq);
 
-		__blk_put_request(req->q, req);
+		__blk_put_request(q, req);
 	}
 }
 EXPORT_SYMBOL(blk_finish_request);
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 01fb455d3377..eacd3af72099 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -259,6 +259,47 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return ret;
 }
 
+static void blk_mq_stat_clear(struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_ctx *ctx;
+	unsigned int i;
+
+	hctx_for_each_ctx(hctx, ctx, i) {
+		blk_stat_init(&ctx->stat[BLK_STAT_READ]);
+		blk_stat_init(&ctx->stat[BLK_STAT_WRITE]);
+	}
+}
+
+static ssize_t blk_mq_hw_sysfs_stat_store(struct blk_mq_hw_ctx *hctx,
+					  const char *page, size_t count)
+{
+	blk_mq_stat_clear(hctx);
+	return count;
+}
+
+static ssize_t print_stat(char *page, struct blk_rq_stat *stat, const char *pre)
+{
+	return sprintf(page, "%s samples=%llu, mean=%lld, min=%lld, max=%lld\n",
+			pre, (long long) stat->nr_samples,
+			(long long) stat->mean, (long long) stat->min,
+			(long long) stat->max);
+}
+
+static ssize_t blk_mq_hw_sysfs_stat_show(struct blk_mq_hw_ctx *hctx, char *page)
+{
+	struct blk_rq_stat stat[2];
+	ssize_t ret;
+
+	blk_stat_init(&stat[BLK_STAT_READ]);
+	blk_stat_init(&stat[BLK_STAT_WRITE]);
+
+	blk_hctx_stat_get(hctx, stat);
+
+	ret = print_stat(page, &stat[BLK_STAT_READ], "read :");
+	ret += print_stat(page + ret, &stat[BLK_STAT_WRITE], "write:");
+	return ret;
+}
+
 static struct blk_mq_ctx_sysfs_entry blk_mq_sysfs_dispatched = {
 	.attr = {.name = "dispatched", .mode = S_IRUGO },
 	.show = blk_mq_sysfs_dispatched_show,
@@ -317,6 +358,11 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_poll = {
 	.show = blk_mq_hw_sysfs_poll_show,
 	.store = blk_mq_hw_sysfs_poll_store,
 };
+static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_stat = {
+	.attr = {.name = "stats", .mode = S_IRUGO | S_IWUSR },
+	.show = blk_mq_hw_sysfs_stat_show,
+	.store = blk_mq_hw_sysfs_stat_store,
+};
 
 static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_queued.attr,
@@ -327,6 +373,7 @@ static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_cpus.attr,
 	&blk_mq_hw_sysfs_active.attr,
 	&blk_mq_hw_sysfs_poll.attr,
+	&blk_mq_hw_sysfs_stat.attr,
 	NULL,
 };
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2da1a0ee3318..476b18e1991c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -30,6 +30,7 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
+#include "blk-stat.h"
 
 static DEFINE_MUTEX(all_q_mutex);
 static LIST_HEAD(all_q_list);
@@ -376,10 +377,21 @@ static void blk_mq_ipi_complete_request(struct request *rq)
 	put_cpu();
 }
 
+static void blk_mq_stat_add(struct request *rq)
+{
+	if (rq->rq_flags & RQF_STATS) {
+		struct blk_rq_stat *stat = &rq->mq_ctx->stat[rq_data_dir(rq)];
+
+		blk_stat_add(stat, rq);
+	}
+}
+
 static void __blk_mq_complete_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
+	blk_mq_stat_add(rq);
+
 	if (!q->softirq_done_fn)
 		blk_mq_end_request(rq, rq->errors);
 	else
@@ -423,6 +435,11 @@ void blk_mq_start_request(struct request *rq)
 	if (unlikely(blk_bidi_rq(rq)))
 		rq->next_rq->resid_len = blk_rq_bytes(rq->next_rq);
 
+	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
+		blk_stat_set_issue_time(&rq->issue_stat);
+		rq->rq_flags |= RQF_STATS;
+	}
+
 	blk_add_timer(rq);
 
 	/*
@@ -1708,6 +1725,8 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		spin_lock_init(&__ctx->lock);
 		INIT_LIST_HEAD(&__ctx->rq_list);
 		__ctx->queue = q;
+		blk_stat_init(&__ctx->stat[BLK_STAT_READ]);
+		blk_stat_init(&__ctx->stat[BLK_STAT_WRITE]);
 
 		/* If the cpu isn't online, the cpu is mapped to first hctx */
 		if (!cpu_online(i))
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e5d25249028c..8cf16cb69f64 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -1,6 +1,8 @@
 #ifndef INT_BLK_MQ_H
 #define INT_BLK_MQ_H
 
+#include "blk-stat.h"
+
 struct blk_mq_tag_set;
 
 struct blk_mq_ctx {
@@ -18,6 +20,7 @@ struct blk_mq_ctx {
 
 	/* incremented at completion time */
 	unsigned long		____cacheline_aligned_in_smp rq_completed[2];
+	struct blk_rq_stat	stat[2];
 
 	struct request_queue	*queue;
 	struct kobject		kobj;
diff --git a/block/blk-stat.c b/block/blk-stat.c
new file mode 100644
index 000000000000..1ace5c662f3e
--- /dev/null
+++ b/block/blk-stat.c
@@ -0,0 +1,245 @@
+/*
+ * Block stat tracking code
+ *
+ * Copyright (C) 2016 Jens Axboe
+ */
+#include <linux/kernel.h>
+#include <linux/blk-mq.h>
+
+#include "blk-stat.h"
+#include "blk-mq.h"
+
+static void blk_stat_flush_batch(struct blk_rq_stat *stat)
+{
+	if (!stat->nr_batch)
+		return;
+	if (!stat->nr_samples)
+		stat->mean = div64_s64(stat->batch, stat->nr_batch);
+	else {
+		stat->mean = div64_s64((stat->mean * stat->nr_samples) +
+					stat->batch,
+					stat->nr_samples + stat->nr_batch);
+	}
+
+	stat->nr_samples += stat->nr_batch;
+	stat->nr_batch = stat->batch = 0;
+}
+
+void blk_stat_sum(struct blk_rq_stat *dst, struct blk_rq_stat *src)
+{
+	if (!src->nr_samples)
+		return;
+
+	blk_stat_flush_batch(src);
+
+	dst->min = min(dst->min, src->min);
+	dst->max = max(dst->max, src->max);
+
+	if (!dst->nr_samples)
+		dst->mean = src->mean;
+	else {
+		dst->mean = div64_s64((src->mean * src->nr_samples) +
+					(dst->mean * dst->nr_samples),
+					dst->nr_samples + src->nr_samples);
+	}
+	dst->nr_samples += src->nr_samples;
+}
+
+static void blk_mq_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
+{
+	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_ctx *ctx;
+	uint64_t latest = 0;
+	int i, j, nr;
+
+	blk_stat_init(&dst[BLK_STAT_READ]);
+	blk_stat_init(&dst[BLK_STAT_WRITE]);
+
+	nr = 0;
+	do {
+		uint64_t newest = 0;
+
+		queue_for_each_hw_ctx(q, hctx, i) {
+			hctx_for_each_ctx(hctx, ctx, j) {
+				if (!ctx->stat[BLK_STAT_READ].nr_samples &&
+				    !ctx->stat[BLK_STAT_WRITE].nr_samples)
+					continue;
+				if (ctx->stat[BLK_STAT_READ].time > newest)
+					newest = ctx->stat[BLK_STAT_READ].time;
+				if (ctx->stat[BLK_STAT_WRITE].time > newest)
+					newest = ctx->stat[BLK_STAT_WRITE].time;
+			}
+		}
+
+		/*
+		 * No samples
+		 */
+		if (!newest)
+			break;
+
+		if (newest > latest)
+			latest = newest;
+
+		queue_for_each_hw_ctx(q, hctx, i) {
+			hctx_for_each_ctx(hctx, ctx, j) {
+				if (ctx->stat[BLK_STAT_READ].time == newest) {
+					blk_stat_sum(&dst[BLK_STAT_READ],
+						     &ctx->stat[BLK_STAT_READ]);
+					nr++;
+				}
+				if (ctx->stat[BLK_STAT_WRITE].time == newest) {
+					blk_stat_sum(&dst[BLK_STAT_WRITE],
+						     &ctx->stat[BLK_STAT_WRITE]);
+					nr++;
+				}
+			}
+		}
+		/*
+		 * If we race on finding an entry, just loop back again.
+		 * Should be very rare.
+		 */
+	} while (!nr);
+
+	dst[BLK_STAT_READ].time = dst[BLK_STAT_WRITE].time = latest;
+}
+
+void blk_queue_stat_get(struct request_queue *q, struct blk_rq_stat *dst)
+{
+	if (q->mq_ops)
+		blk_mq_stat_get(q, dst);
+	else {
+		memcpy(&dst[BLK_STAT_READ], &q->rq_stats[BLK_STAT_READ],
+				sizeof(struct blk_rq_stat));
+		memcpy(&dst[BLK_STAT_WRITE], &q->rq_stats[BLK_STAT_WRITE],
+				sizeof(struct blk_rq_stat));
+	}
+}
+
+void blk_hctx_stat_get(struct blk_mq_hw_ctx *hctx, struct blk_rq_stat *dst)
+{
+	struct blk_mq_ctx *ctx;
+	unsigned int i, nr;
+
+	nr = 0;
+	do {
+		uint64_t newest = 0;
+
+		hctx_for_each_ctx(hctx, ctx, i) {
+			if (!ctx->stat[BLK_STAT_READ].nr_samples &&
+			    !ctx->stat[BLK_STAT_WRITE].nr_samples)
+				continue;
+
+			if (ctx->stat[BLK_STAT_READ].time > newest)
+				newest = ctx->stat[BLK_STAT_READ].time;
+			if (ctx->stat[BLK_STAT_WRITE].time > newest)
+				newest = ctx->stat[BLK_STAT_WRITE].time;
+		}
+
+		if (!newest)
+			break;
+
+		hctx_for_each_ctx(hctx, ctx, i) {
+			if (ctx->stat[BLK_STAT_READ].time == newest) {
+				blk_stat_sum(&dst[BLK_STAT_READ],
+						&ctx->stat[BLK_STAT_READ]);
+				nr++;
+			}
+			if (ctx->stat[BLK_STAT_WRITE].time == newest) {
+				blk_stat_sum(&dst[BLK_STAT_WRITE],
+						&ctx->stat[BLK_STAT_WRITE]);
+				nr++;
+			}
+		}
+		/*
+		 * If we race on finding an entry, just loop back again.
+		 * Should be very rare, as the window is only updated
+		 * occasionally
+		 */
+	} while (!nr);
+}
+
+static void __blk_stat_init(struct blk_rq_stat *stat, s64 time_now)
+{
+	stat->min = -1ULL;
+	stat->max = stat->nr_samples = stat->mean = 0;
+	stat->batch = stat->nr_batch = 0;
+	stat->time = time_now & BLK_STAT_NSEC_MASK;
+}
+
+void blk_stat_init(struct blk_rq_stat *stat)
+{
+	__blk_stat_init(stat, ktime_to_ns(ktime_get()));
+}
+
+static bool __blk_stat_is_current(struct blk_rq_stat *stat, s64 now)
+{
+	return (now & BLK_STAT_NSEC_MASK) == (stat->time & BLK_STAT_NSEC_MASK);
+}
+
+bool blk_stat_is_current(struct blk_rq_stat *stat)
+{
+	return __blk_stat_is_current(stat, ktime_to_ns(ktime_get()));
+}
+
+void blk_stat_add(struct blk_rq_stat *stat, struct request *rq)
+{
+	s64 now, value;
+
+	now = __blk_stat_time(ktime_to_ns(ktime_get()));
+	if (now < blk_stat_time(&rq->issue_stat))
+		return;
+
+	if (!__blk_stat_is_current(stat, now))
+		__blk_stat_init(stat, now);
+
+	value = now - blk_stat_time(&rq->issue_stat);
+	if (value > stat->max)
+		stat->max = value;
+	if (value < stat->min)
+		stat->min = value;
+
+	if (stat->batch + value < stat->batch ||
+	    stat->nr_batch + 1 == BLK_RQ_STAT_BATCH)
+		blk_stat_flush_batch(stat);
+
+	stat->batch += value;
+	stat->nr_batch++;
+}
+
+void blk_stat_clear(struct request_queue *q)
+{
+	if (q->mq_ops) {
+		struct blk_mq_hw_ctx *hctx;
+		struct blk_mq_ctx *ctx;
+		int i, j;
+
+		queue_for_each_hw_ctx(q, hctx, i) {
+			hctx_for_each_ctx(hctx, ctx, j) {
+				blk_stat_init(&ctx->stat[BLK_STAT_READ]);
+				blk_stat_init(&ctx->stat[BLK_STAT_WRITE]);
+			}
+		}
+	} else {
+		blk_stat_init(&q->rq_stats[BLK_STAT_READ]);
+		blk_stat_init(&q->rq_stats[BLK_STAT_WRITE]);
+	}
+}
+
+void blk_stat_set_issue_time(struct blk_issue_stat *stat)
+{
+	stat->time = (stat->time & BLK_STAT_MASK) |
+			(ktime_to_ns(ktime_get()) & BLK_STAT_TIME_MASK);
+}
+
+/*
+ * Enable stat tracking, return whether it was enabled
+ */
+bool blk_stat_enable(struct request_queue *q)
+{
+	if (!test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
+		set_bit(QUEUE_FLAG_STATS, &q->queue_flags);
+		return false;
+	}
+
+	return true;
+}
diff --git a/block/blk-stat.h b/block/blk-stat.h
new file mode 100644
index 000000000000..5a9c85a39e02
--- /dev/null
+++ b/block/blk-stat.h
@@ -0,0 +1,43 @@
+#ifndef BLK_STAT_H
+#define BLK_STAT_H
+
+/*
+ * ~0.13s window as a power-of-2 (2^27 nsecs)
+ */
+#define BLK_STAT_NSEC		134217728ULL
+#define BLK_STAT_NSEC_MASK	~(BLK_STAT_NSEC - 1)
+
+/*
+ * Upper 3 bits can be used elsewhere
+ */
+#define BLK_STAT_RES_BITS	3
+#define BLK_STAT_SHIFT		(64 - BLK_STAT_RES_BITS)
+#define BLK_STAT_TIME_MASK	((1ULL << BLK_STAT_SHIFT) - 1)
+#define BLK_STAT_MASK		~BLK_STAT_TIME_MASK
+
+enum {
+	BLK_STAT_READ	= 0,
+	BLK_STAT_WRITE,
+};
+
+void blk_stat_add(struct blk_rq_stat *, struct request *);
+void blk_hctx_stat_get(struct blk_mq_hw_ctx *, struct blk_rq_stat *);
+void blk_queue_stat_get(struct request_queue *, struct blk_rq_stat *);
+void blk_stat_clear(struct request_queue *);
+void blk_stat_init(struct blk_rq_stat *);
+void blk_stat_sum(struct blk_rq_stat *, struct blk_rq_stat *);
+bool blk_stat_is_current(struct blk_rq_stat *);
+void blk_stat_set_issue_time(struct blk_issue_stat *);
+bool blk_stat_enable(struct request_queue *);
+
+static inline u64 __blk_stat_time(u64 time)
+{
+	return time & BLK_STAT_TIME_MASK;
+}
+
+static inline u64 blk_stat_time(struct blk_issue_stat *stat)
+{
+	return __blk_stat_time(stat->time);
+}
+
+#endif
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 488c2e28feb8..9cdb7247727a 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -401,6 +401,26 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
+static ssize_t print_stat(char *page, struct blk_rq_stat *stat, const char *pre)
+{
+	return sprintf(page, "%s samples=%llu, mean=%lld, min=%lld, max=%lld\n",
+			pre, (long long) stat->nr_samples,
+			(long long) stat->mean, (long long) stat->min,
+			(long long) stat->max);
+}
+
+static ssize_t queue_stats_show(struct request_queue *q, char *page)
+{
+	struct blk_rq_stat stat[2];
+	ssize_t ret;
+
+	blk_queue_stat_get(q, stat);
+
+	ret = print_stat(page, &stat[BLK_STAT_READ], "read :");
+	ret += print_stat(page + ret, &stat[BLK_STAT_WRITE], "write:");
+	return ret;
+}
+
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_requests_show,
@@ -553,6 +573,11 @@ static struct queue_sysfs_entry queue_dax_entry = {
 	.show = queue_dax_show,
 };
 
+static struct queue_sysfs_entry queue_stats_entry = {
+	.attr = {.name = "stats", .mode = S_IRUGO },
+	.show = queue_stats_show,
+};
+
 static struct attribute *default_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
@@ -582,6 +607,7 @@ static struct attribute *default_attrs[] = {
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
 	&queue_dax_entry.attr,
+	&queue_stats_entry.attr,
 	NULL,
 };
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 562ac46cb790..4d0044d09984 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -250,4 +250,20 @@ static inline unsigned int blk_qc_t_to_tag(blk_qc_t cookie)
 	return cookie & ((1u << BLK_QC_T_SHIFT) - 1);
 }
 
+struct blk_issue_stat {
+	u64 time;
+};
+
+#define BLK_RQ_STAT_BATCH	64
+
+struct blk_rq_stat {
+	s64 mean;
+	u64 min;
+	u64 max;
+	s32 nr_samples;
+	s32 nr_batch;
+	u64 batch;
+	s64 time;
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8396da2bb698..b400c31b4a10 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -117,6 +117,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_PM			((__force req_flags_t)(1 << 15))
 /* on IO scheduler merge hash */
 #define RQF_HASHED		((__force req_flags_t)(1 << 16))
+/* IO stats tracking on */
+#define RQF_STATS		((__force req_flags_t)(1 << 17))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
@@ -197,6 +199,7 @@ struct request {
 	struct gendisk *rq_disk;
 	struct hd_struct *part;
 	unsigned long start_time;
+	struct blk_issue_stat issue_stat;
 #ifdef CONFIG_BLK_CGROUP
 	struct request_list *rl;		/* rl this rq is alloced from */
 	unsigned long long start_time_ns;
@@ -490,6 +493,9 @@ struct request_queue {
 
 	unsigned int		nr_sorted;
 	unsigned int		in_flight[2];
+
+	struct blk_rq_stat	rq_stats[2];
+
 	/*
 	 * Number of active block driver functions for which blk_drain_queue()
 	 * must wait. Must be incremented around functions that unlock the
@@ -583,6 +589,7 @@ struct request_queue {
 #define QUEUE_FLAG_FUA	       24	/* device supports FUA writes */
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
+#define QUEUE_FLAG_STATS       27	/* track rq completion times */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
-- 
2.7.4
