Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 17/18] blk-throttle: add a mechanism to estimate IO latency
Date: Mon, 27 Mar 2017 10:51:45 -0700
Message-ID: <597ac00ccebbe91b6fc636334b164fa8301526ee.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
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
 block/blk-core.c          |   4 +
 block/blk-mq.c            |   4 +
 block/blk-throttle.c      | 181 ++++++++++++++++++++++++++++++++++++++++++++--
 block/blk.h               |   4 +
 include/linux/blk_types.h |   1 +
 include/linux/blkdev.h    |   3 +
 6 files changed, 192 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ad388d5e..d5b5169 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2482,6 +2482,8 @@ void blk_start_request(struct request *req)
 {
 	blk_dequeue_request(req);
 
+	blk_throtl_start_request(req);
+
 	if (test_bit(QUEUE_FLAG_STATS, &req->q->queue_flags)) {
 		blk_stat_set_issue_time(&req->issue_stat);
 		req->rq_flags |= RQF_STATS;
@@ -2703,6 +2705,8 @@ void blk_finish_request(struct request *req, int error)
 {
 	struct request_queue *q = req->q;
 
+	blk_throtl_finish_request(req);
+
 	if (req->rq_flags & RQF_STATS)
 		blk_stat_add(req);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 45b9beb..b04a564 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -434,6 +434,8 @@ static void blk_mq_ipi_complete_request(struct request *rq)
 
 static void blk_mq_stat_add(struct request *rq)
 {
+	blk_throtl_finish_request(rq);
+
 	if (rq->rq_flags & RQF_STATS) {
 		blk_mq_poll_stats_start(rq->q);
 		blk_stat_add(rq);
@@ -487,6 +489,8 @@ void blk_mq_start_request(struct request *rq)
 
 	trace_block_rq_issue(q, rq);
 
+	blk_throtl_start_request(rq);
+
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
 		blk_stat_set_issue_time(&rq->issue_stat);
 		rq->rq_flags |= RQF_STATS;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 6e1c298..4b9c6a1 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -28,6 +28,13 @@ static int throtl_quantum = 32;
 /* default latency target is 0, eg, guarantee IO latency by default */
 #define DFL_LATENCY_TARGET (0)
 
+#define THROTL_STAT(time, size) \
+	(((u64)time & (((u64)1 << 48) - 1)) | \
+	 (((u64)size & (((u64)1 << 12) - 1)) << 48))
+#define THROTL_SKIP_LAT ((u64)1 << 63)
+#define THROTL_STAT_TIME(stat) (stat & (((u64)1 << 48) - 1))
+#define THROTL_STAT_SIZE(stat) ((stat >> 48) & (((u64)1 << 12) - 1))
+
 static struct blkcg_policy blkcg_policy_throtl;
 
 /* A workqueue to queue throttle related work */
@@ -165,6 +172,19 @@ struct throtl_grp {
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
@@ -188,6 +208,13 @@ struct throtl_data
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
@@ -306,6 +333,9 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	return ret;
 }
 
+#define request_bucket_index(sectors) \
+	clamp_t(int, order_base_2(sectors) - 3, 0, LATENCY_BUCKET_SIZE - 1)
+
 /**
  * throtl_log - log debug message via blktrace
  * @sq: the service_queue being reported
@@ -1931,6 +1961,73 @@ static void blk_throtl_update_idletime(struct throtl_grp *tg)
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
@@ -1939,6 +2036,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	struct throtl_service_queue *sq;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
+	struct throtl_data *td = tg->td;
 	int ret;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
@@ -1949,6 +2047,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	spin_lock_irq(q->queue_lock);
 
+	throtl_update_latency_buckets(td);
+
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
@@ -1956,6 +2056,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	if (ret == 0 || ret == -EBUSY)
 		bio->bi_cg_private = tg;
+	bio->bi_throtl_stat = THROTL_STAT(ktime_get_ns(), bio_sectors(bio));
 #endif
 	blk_throtl_update_idletime(tg);
 
@@ -1974,8 +2075,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
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
@@ -2019,7 +2120,7 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	tg->last_low_overflow_time[rw] = jiffies;
 
-	tg->td->nr_queued[rw]++;
+	td->nr_queued[rw]++;
 	throtl_add_bio_tg(bio, qn, tg);
 	throttled = true;
 
@@ -2044,20 +2145,79 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	 */
 	if (!throttled)
 		bio_clear_flag(bio, BIO_THROTTLED);
+
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	if (throttled || !td->track_bio_latency)
+		bio->bi_throtl_stat |= THROTL_SKIP_LAT;
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
+void blk_throtl_start_request(struct request *rq)
+{
+	rq->throtl_stat = THROTL_STAT(ktime_get_ns(),
+		blk_rq_sectors(rq));
+}
+
+void blk_throtl_finish_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct throtl_data *td = q->td;
+	u64 finish_time = THROTL_STAT_TIME(ktime_get_ns());
+	u64 time_ns;
+
+	if (finish_time < THROTL_STAT_TIME(rq->throtl_stat))
+		return;
+	time_ns = finish_time - THROTL_STAT_TIME(rq->throtl_stat);
+
+	throtl_track_latency(td, THROTL_STAT_SIZE(rq->throtl_stat),
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
+	start_time = THROTL_STAT_TIME(bio->bi_throtl_stat) >> 10;
+	finish_time = THROTL_STAT_TIME(finish_time_ns) >> 10;
+	if (start_time && finish_time > start_time &&
+	    !(bio->bi_throtl_stat & THROTL_SKIP_LAT)) {
+		lat = finish_time - start_time;
+		throtl_track_latency(tg->td,
+			THROTL_STAT_SIZE(bio->bi_throtl_stat),
+			bio_op(bio), lat);
+	}
 }
 #endif
 
@@ -2133,6 +2293,12 @@ int blk_throtl_init(struct request_queue *q)
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
@@ -2147,8 +2313,10 @@ int blk_throtl_init(struct request_queue *q)
 
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
-	if (ret)
+	if (ret) {
+		free_percpu(td->latency_buckets);
 		kfree(td);
+	}
 	return ret;
 }
 
@@ -2157,6 +2325,7 @@ void blk_throtl_exit(struct request_queue *q)
 	BUG_ON(!q->td);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
+	free_percpu(q->td->latency_buckets);
 	kfree(q->td);
 }
 
@@ -2181,6 +2350,8 @@ void blk_throtl_register_queue(struct request_queue *q)
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
 #endif
 
+	td->track_bio_latency = !q->mq_ops && !q->request_fn;
+
 	/*
 	 * some tg are created before queue is fully initialized, eg, nonrot
 	 * isn't initialized yet
diff --git a/block/blk.h b/block/blk.h
index 3ac833e..fa5610e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -331,8 +331,12 @@ extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
 	const char *page, size_t count);
 extern void blk_throtl_bio_endio(struct bio *bio);
+extern void blk_throtl_start_request(struct request *rq);
+extern void blk_throtl_finish_request(struct request *rq);
 #else
 static inline void blk_throtl_bio_endio(struct bio *bio) { }
+static inline void blk_throtl_start_request(struct request *rq) { }
+static inline void blk_throtl_finish_request(struct request *rq) { }
 #endif
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 07a9e96..112fd26 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -60,6 +60,7 @@ struct bio {
 	struct cgroup_subsys_state *bi_css;
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	void			*bi_cg_private;
+	u64			bi_throtl_stat;
 #endif
 #endif
 	union {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1a7dc42..b14ae55 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -204,6 +204,9 @@ struct request {
 	struct request_list *rl;		/* rl this rq is alloced from */
 	unsigned long long start_time_ns;
 	unsigned long long io_start_time_ns;    /* when passed to hardware */
+#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
+	u64 throtl_stat;
+#endif
 #endif
 	/* Number of scatter-gather DMA addr+len pairs after
 	 * physical address coalescing is performed.
-- 
2.9.3
