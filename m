Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH 2/3] blk-throttle: add a mechanism to estimate IO latency
Date: Mon, 27 Mar 2017 15:19:42 -0700
Message-ID: <4a0c7bb001f72cd787235cad32fdf14c84e00394.1490651903.git.shli@fb.com>
In-Reply-To: <cover.1490651903.git.shli@fb.com>
References: <567d5361-7d6b-c53e-8ada-a2966e48dc54@fb.com> <cover.1490651903.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

User configures latency target, but the latency threshold for each
request size isn't fixed. For a SSD, the IO latency highly depends on
request size. To calculate latency threshold, we sample some data, eg,
average latency for request size 4k, 8k, 16k, 32k .. 1M. The latency
threshold of each request size will be the sample latency (I'll call it
base latency) plus latency target. For example, the base latency for
request size 4k is 80us and user configures latency target 60us. The 4k
latency threshold will be 80 + 60 = 140us.

To sample data, we calculate the order base 2 of rounded up IO sectors.
If the IO size is bigger than 1M, it will be accounted as 1M. Since the
calculation does round up, the base latency will be slightly smaller
than actual value. Also if there isn't any IO dispatched for a specific
IO size, we will use the base latency of smaller IO size for this IO
size.

But we shouldn't sample data at any time. The base latency is supposed
to be latency where disk isn't congested, because we use latency
threshold to schedule IOs between cgroups. If disk is congested, the
latency is higher, using it for scheduling is meaningless. Hence we only
do the sampling when block throttling is in the LOW limit, with
assumption disk isn't congested in such state. If the assumption isn't
true, eg, low limit is too high, calculated latency threshold will be
higher.

Hard disk is completely different. Latency depends on spindle seek
instead of request size. Currently this feature is SSD only, we probably
can use a fixed threshold like 4ms for hard disk though.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-stat.c          |  15 ++++-
 block/blk-stat.h          |   3 +
 block/blk-throttle.c      | 166 ++++++++++++++++++++++++++++++++++++++++++++--
 block/blk.h               |   2 +
 include/linux/blk_types.h |   9 +--
 5 files changed, 185 insertions(+), 10 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 188b535..e77ec52 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -9,12 +9,14 @@
 
 #include "blk-stat.h"
 #include "blk-mq.h"
+#include "blk.h"
 
 #define BLK_RQ_STAT_BATCH	64
 
 struct blk_queue_stats {
 	struct list_head callbacks;
 	spinlock_t lock;
+	bool enable_accounting;
 };
 
 unsigned int blk_stat_rq_ddir(const struct request *rq)
@@ -96,6 +98,8 @@ void blk_stat_add(struct request *rq)
 
 	value = now - blk_stat_time(&rq->issue_stat);
 
+	blk_throtl_stat_add(rq, value);
+
 	rcu_read_lock();
 	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
 		if (blk_stat_is_active(cb)) {
@@ -190,7 +194,7 @@ void blk_stat_remove_callback(struct request_queue *q,
 {
 	spin_lock(&q->stats->lock);
 	list_del_rcu(&cb->list);
-	if (list_empty(&q->stats->callbacks))
+	if (list_empty(&q->stats->callbacks) && !q->stats->enable_accounting)
 		clear_bit(QUEUE_FLAG_STATS, &q->queue_flags);
 	spin_unlock(&q->stats->lock);
 
@@ -215,6 +219,14 @@ void blk_stat_free_callback(struct blk_stat_callback *cb)
 }
 EXPORT_SYMBOL_GPL(blk_stat_free_callback);
 
+void blk_stat_enable_accounting(struct request_queue *q)
+{
+	spin_lock(&q->stats->lock);
+	q->stats->enable_accounting = true;
+	set_bit(QUEUE_FLAG_STATS, &q->queue_flags);
+	spin_unlock(&q->stats->lock);
+}
+
 struct blk_queue_stats *blk_alloc_queue_stats(void)
 {
 	struct blk_queue_stats *stats;
@@ -225,6 +237,7 @@ struct blk_queue_stats *blk_alloc_queue_stats(void)
 
 	INIT_LIST_HEAD(&stats->callbacks);
 	spin_lock_init(&stats->lock);
+	stats->enable_accounting = false;
 
 	return stats;
 }
diff --git a/block/blk-stat.h b/block/blk-stat.h
index ee47f81..53f08a6 100644
--- a/block/blk-stat.h
+++ b/block/blk-stat.h
@@ -108,6 +108,9 @@ static inline void blk_stat_set_issue(struct blk_issue_stat *stat,
 		(((u64)blk_capped_size(size)) << BLK_STAT_SIZE_SHIFT);
 }
 
+/* record time/size info in request but not add a callback */
+void blk_stat_enable_accounting(struct request_queue *q);
+
 /*
  * blk_stat_rq_ddir() - Bucket callback function for the request data direction.
  * @rq: Request.
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6e1c298..140da29 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -28,6 +28,8 @@ static int throtl_quantum = 32;
 /* default latency target is 0, eg, guarantee IO latency by default */
 #define DFL_LATENCY_TARGET (0)
 
+#define SKIP_LATENCY (((u64)1) << BLK_STAT_RES_SHIFT)
+
 static struct blkcg_policy blkcg_policy_throtl;
 
 /* A workqueue to queue throttle related work */
@@ -165,6 +167,19 @@ struct throtl_grp {
 	unsigned long idletime_threshold; /* us */
 };
 
+/* We measure latency for request size from <= 4k to >= 1M */
+#define LATENCY_BUCKET_SIZE 9
+
+struct latency_bucket {
+	unsigned long total_latency; /* ns / 1024 */
+	int samples;
+};
+
+struct avg_latency_bucket {
+	unsigned long latency; /* ns / 1024 */
+	bool valid;
+};
+
 struct throtl_data
 {
 	/* service tree for active throtl groups */
@@ -188,6 +203,13 @@ struct throtl_data
 	unsigned long low_downgrade_time;
 
 	unsigned int scale;
+
+	struct latency_bucket tmp_buckets[LATENCY_BUCKET_SIZE];
+	struct avg_latency_bucket avg_buckets[LATENCY_BUCKET_SIZE];
+	struct latency_bucket __percpu *latency_buckets;
+	unsigned long last_calculate_time;
+
+	bool track_bio_latency;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -306,6 +328,9 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	return ret;
 }
 
+#define request_bucket_index(sectors) \
+	clamp_t(int, order_base_2(sectors) - 3, 0, LATENCY_BUCKET_SIZE - 1)
+
 /**
  * throtl_log - log debug message via blktrace
  * @sq: the service_queue being reported
@@ -1931,6 +1956,73 @@ static void blk_throtl_update_idletime(struct throtl_grp *tg)
 	tg->checked_last_finish_time = last_finish_time;
 }
 
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+static void throtl_update_latency_buckets(struct throtl_data *td)
+{
+	struct avg_latency_bucket avg_latency[LATENCY_BUCKET_SIZE];
+	int i, cpu;
+	unsigned long last_latency = 0;
+	unsigned long latency;
+
+	if (!blk_queue_nonrot(td->queue))
+		return;
+	if (time_before(jiffies, td->last_calculate_time + HZ))
+		return;
+	td->last_calculate_time = jiffies;
+
+	memset(avg_latency, 0, sizeof(avg_latency));
+	for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
+		struct latency_bucket *tmp = &td->tmp_buckets[i];
+
+		for_each_possible_cpu(cpu) {
+			struct latency_bucket *bucket;
+
+			/* this isn't race free, but ok in practice */
+			bucket = per_cpu_ptr(td->latency_buckets, cpu);
+			tmp->total_latency += bucket[i].total_latency;
+			tmp->samples += bucket[i].samples;
+			bucket[i].total_latency = 0;
+			bucket[i].samples = 0;
+		}
+
+		if (tmp->samples >= 32) {
+			int samples = tmp->samples;
+
+			latency = tmp->total_latency;
+
+			tmp->total_latency = 0;
+			tmp->samples = 0;
+			latency /= samples;
+			if (latency == 0)
+				continue;
+			avg_latency[i].latency = latency;
+		}
+	}
+
+	for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
+		if (!avg_latency[i].latency) {
+			if (td->avg_buckets[i].latency < last_latency)
+				td->avg_buckets[i].latency = last_latency;
+			continue;
+		}
+
+		if (!td->avg_buckets[i].valid)
+			latency = avg_latency[i].latency;
+		else
+			latency = (td->avg_buckets[i].latency * 7 +
+				avg_latency[i].latency) >> 3;
+
+		td->avg_buckets[i].latency = max(latency, last_latency);
+		td->avg_buckets[i].valid = true;
+		last_latency = td->avg_buckets[i].latency;
+	}
+}
+#else
+static inline void throtl_update_latency_buckets(struct throtl_data *td)
+{
+}
+#endif
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -1939,6 +2031,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
+	struct throtl_data *td = tg->td;
 	int ret;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
@@ -1949,6 +2042,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	spin_lock_irq(q->queue_lock);
 
+	throtl_update_latency_buckets(td);
+
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
@@ -1956,6 +2051,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (ret == 0 || ret == -EBUSY)
 		bio->bi_cg_private = tg;
+	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
 #endif
 	blk_throtl_update_idletime(tg);
 
@@ -1974,8 +2070,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		/* if above limits, break to queue */
 		if (!tg_may_dispatch(tg, bio, NULL)) {
 			tg->last_low_overflow_time[rw] = jiffies;
-			if (throtl_can_upgrade(tg->td, tg)) {
-				throtl_upgrade_state(tg->td);
+			if (throtl_can_upgrade(td, tg)) {
+				throtl_upgrade_state(td);
 				goto again;
 			}
 			break;
@@ -2019,7 +2115,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	tg->last_low_overflow_time[rw] = jiffies;
 
-	tg->td->nr_queued[rw]++;
+	td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
 	throttled = true;
 
@@ -2044,20 +2140,67 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	 */
 	if (!throttled)
 		bio_clear_flag(bio, BIO_THROTTLED);
+
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	if (throttled || !td->track_bio_latency)
+		bio->bi_issue_stat.stat |= SKIP_LATENCY;
+#endif
 	return throttled;
 }
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+static void throtl_track_latency(struct throtl_data *td, sector_t size,
+	int op, unsigned long time)
+{
+	struct latency_bucket *latency;
+	int index;
+
+	if (!td || td->limit_index != LIMIT_LOW || op != REQ_OP_READ ||
+	    !blk_queue_nonrot(td->queue))
+		return;
+
+	index = request_bucket_index(size);
+
+	latency = get_cpu_ptr(td->latency_buckets);
+	latency[index].total_latency += time;
+	latency[index].samples++;
+	put_cpu_ptr(td->latency_buckets);
+}
+
+void blk_throtl_stat_add(struct request *rq, u64 time_ns)
+{
+	struct request_queue *q = rq->q;
+	struct throtl_data *td = q->td;
+
+	throtl_track_latency(td, blk_stat_size(&rq->issue_stat),
+		req_op(rq), time_ns >> 10);
+}
+
 void blk_throtl_bio_endio(struct bio *bio)
 {
 	struct throtl_grp *tg;
+	u64 finish_time_ns;
+	unsigned long finish_time;
+	unsigned long start_time;
+	unsigned long lat;
 
 	tg = bio->bi_cg_private;
 	if (!tg)
 		return;
 	bio->bi_cg_private = NULL;
 
-	tg->last_finish_time = ktime_get_ns() >> 10;
+	finish_time_ns = ktime_get_ns();
+	tg->last_finish_time = finish_time_ns >> 10;
+
+	start_time = blk_stat_time(&bio->bi_issue_stat) >> 10;
+	finish_time = __blk_stat_time(finish_time_ns) >> 10;
+	/* this is only for bio based driver */
+	if (start_time && finish_time > start_time &&
+	    !(bio->bi_issue_stat.stat & SKIP_LATENCY)) {
+		lat = finish_time - start_time;
+		throtl_track_latency(tg->td, blk_stat_size(&bio->bi_issue_stat),
+			bio_op(bio), lat);
+	}
 }
 #endif
 
@@ -2133,6 +2276,12 @@ int blk_throtl_init(struct request_queue *q)
 	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
 	if (!td)
 		return -ENOMEM;
+	td->latency_buckets = __alloc_percpu(sizeof(struct latency_bucket) *
+		LATENCY_BUCKET_SIZE, __alignof__(u64));
+	if (!td->latency_buckets) {
+		kfree(td);
+		return -ENOMEM;
+	}
 
 	INIT_WORK(&td->dispatch_work, blk_throtl_dispatch_work_fn);
 	throtl_service_queue_init(&td->service_queue);
@@ -2147,8 +2296,10 @@ int blk_throtl_init(struct request_queue *q)
 
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
-	if (ret)
+	if (ret) {
+		free_percpu(td->latency_buckets);
 		kfree(td);
+	}
 	return ret;
 }
 
@@ -2157,6 +2308,7 @@ void blk_throtl_exit(struct request_queue *q)
 	BUG_ON(!q->td);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
+	free_percpu(q->td->latency_buckets);
 	kfree(q->td);
 }
 
@@ -2181,6 +2333,10 @@ void blk_throtl_register_queue(struct request_queue *q)
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
 #endif
 
+	td->track_bio_latency = !q->mq_ops && !q->request_fn;
+	if (!td->track_bio_latency)
+		blk_stat_enable_accounting(q);
+
 	/*
 	 * some tg are created before queue is fully initialized, eg, nonrot
 	 * isn't initialized yet
diff --git a/block/blk.h b/block/blk.h
index 3ac833e..07d3751 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -331,8 +331,10 @@ extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
 	const char *page, size_t count);
 extern void blk_throtl_bio_endio(struct bio *bio);
+extern void blk_throtl_stat_add(struct request *rq, u64 time);
 #else
 static inline void blk_throtl_bio_endio(struct bio *bio) { }
+static inline void blk_throtl_stat_add(struct request *rq, u64 time) { }
 #endif
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 3ad5673..67bcf8a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -17,6 +17,10 @@ struct io_context;
 struct cgroup_subsys_state;
 typedef void (bio_end_io_t) (struct bio *);
 
+struct blk_issue_stat {
+	u64 stat;
+};
+
 /*
  * main unit of I/O for the block layer and lower layers (ie drivers and
  * stacking drivers)
@@ -60,6 +64,7 @@ struct bio {
 	struct cgroup_subsys_state *bi_css;
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	void			*bi_cg_private;
+	struct blk_issue_stat	bi_issue_stat;
 #endif
 #endif
 	union {
@@ -286,10 +291,6 @@ static inline bool blk_qc_t_is_internal(blk_qc_t cookie)
 	return (cookie & BLK_QC_T_INTERNAL) != 0;
 }
 
-struct blk_issue_stat {
-	u64 stat;
-};
-
 struct blk_rq_stat {
 	s64 mean;
 	u64 min;
-- 
2.9.3
