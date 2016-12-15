Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756493AbcLOUd1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Dec 2016 15:33:27 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFKUYSF024749
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:21 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 27bxsyagmy-13
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 15 Dec 2016 12:33:21 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.103.99.99) with ESMTP  id
 b12eb4bac30511e6b9200002c9dfb610-2e9f7a50 for <linux-block@vger.kernel.org>;
        Thu, 15 Dec 2016 12:33:09 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V5 16/17] blk-throttle: add a mechanism to estimate IO latency
Date: Thu, 15 Dec 2016 12:33:07 -0800
Message-ID: <53ba1d9ed13cf6d3fd5a51ad84ae3219571d6c2f.1481833017.git.shli@fb.com>
In-Reply-To: <cover.1481833017.git.shli@fb.com>
References: <cover.1481833017.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
 block/blk-stat.c          |   4 ++
 block/blk-throttle.c      | 159 +++++++++++++++++++++++++++++++++++++++++++++-
 block/blk.h               |   2 +
 include/linux/blk_types.h |   9 +--
 4 files changed, 168 insertions(+), 6 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index 0469855..15c1621 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -7,6 +7,7 @@
 #include <linux/blk-mq.h>
 
 #include "blk-stat.h"
+#include "blk.h"
 #include "blk-mq.h"
 
 static void blk_stat_flush_batch(struct blk_rq_stat *stat)
@@ -204,6 +205,9 @@ void blk_stat_add(struct blk_rq_stat *stat, struct request *rq)
 		__blk_stat_init(stat, now);
 
 	value = now - blk_stat_time(&rq->issue_stat);
+
+	blk_throtl_stat_add(rq, value);
+
 	if (value > stat->max)
 		stat->max = value;
 	if (value < stat->min)
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 3431b1d..1dc707a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -25,6 +25,8 @@ static int throtl_quantum = 32;
 #define DFL_IDLE_THRESHOLD_HD (1000 * 1000) /* 1 ms */
 #define MAX_IDLE_TIME (500L * 1000 * 1000) /* 500 ms */
 
+#define SKIP_TRACK (((u64)1) << BLK_STAT_RES_SHIFT)
+
 static struct blkcg_policy blkcg_policy_throtl;
 
 /* A workqueue to queue throttle related work */
@@ -162,6 +164,19 @@ struct throtl_grp {
 	u64 idle_ttime_threshold;
 };
 
+/* We measure latency for request size from <= 4k to >= 1M */
+#define LATENCY_BUCKET_SIZE 9
+
+struct latency_bucket {
+	u64 total_latency;
+	int samples;
+};
+
+struct avg_latency_bucket {
+	u64 latency;
+	bool valid;
+};
+
 struct throtl_data
 {
 	/* service tree for active throtl groups */
@@ -185,6 +200,13 @@ struct throtl_data
 	unsigned long low_downgrade_time;
 
 	unsigned int scale;
+
+	struct latency_bucket tmp_buckets[LATENCY_BUCKET_SIZE];
+	struct avg_latency_bucket avg_buckets[LATENCY_BUCKET_SIZE];
+	struct latency_bucket __percpu *latency_buckets;
+	unsigned long last_calculate_time;
+
+	unsigned int track_bio_latency;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -293,6 +315,13 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	return ret;
 }
 
+static int request_bucket_index(sector_t sectors)
+{
+	int order = order_base_2(sectors);
+
+	return clamp_t(int, order - 3, 0, LATENCY_BUCKET_SIZE - 1);
+}
+
 /**
  * throtl_log - log debug message via blktrace
  * @sq: the service_queue being reported
@@ -1896,12 +1925,74 @@ static void blk_throtl_update_ttime(struct throtl_grp *tg)
 	tg->checked_last_finish_time = last_finish_time;
 }
 
+static void throtl_update_latency_buckets(struct throtl_data *td)
+{
+	struct avg_latency_bucket avg_latency[LATENCY_BUCKET_SIZE];
+	int i, cpu;
+	u64 last_latency = 0;
+	u64 latency;
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
+			do_div(latency, samples);
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
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
 	struct throtl_qnode *qn = NULL;
 	struct throtl_grp *tg = blkg_to_tg(blkg ?: q->root_blkg);
 	struct throtl_service_queue *sq;
+	struct throtl_data *td;
 	bool rw = bio_data_dir(bio);
 	bool throttled = false;
 	int ret;
@@ -1919,12 +2010,21 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 				tg->idle_ttime_threshold;
 	}
 
+	td = tg->td;
+	if (td->track_bio_latency == UINT_MAX) {
+		td->track_bio_latency = !q->mq_ops && !q->request_fn;
+		if (!td->track_bio_latency)
+			blk_stat_enable(q);
+	}
+
 	/* see throtl_charge_bio() */
 	if (bio_flagged(bio, BIO_THROTTLED) || !tg->has_rules[rw])
 		goto out;
 
 	spin_lock_irq(q->queue_lock);
 
+	throtl_update_latency_buckets(tg->td);
+
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
@@ -1932,6 +2032,8 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	if (ret == 0 || ret == -EBUSY)
 		bio->bi_cg_private = tg;
 
+	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
+
 	blk_throtl_update_ttime(tg);
 
 	sq = &tg->service_queue;
@@ -2019,19 +2121,62 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	 */
 	if (!throttled)
 		bio_clear_flag(bio, BIO_THROTTLED);
+	else
+		bio->bi_issue_stat.stat |= SKIP_TRACK;
 	return throttled;
 }
 
+static void throtl_track_latency(struct throtl_data *td, sector_t size,
+	int op, u64 time)
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
+void blk_throtl_stat_add(struct request *rq, u64 time)
+{
+	struct request_queue *q = rq->q;
+	struct throtl_data *td = q->td;
+
+	throtl_track_latency(td, blk_stat_size(&rq->issue_stat),
+		req_op(rq), time);
+}
+
 void blk_throtl_bio_endio(struct bio *bio)
 {
 	struct throtl_grp *tg;
+	u64 finish_time;
+	u64 start_time;
+	u64 lat;
 
 	tg = bio->bi_cg_private;
 	if (!tg)
 		return;
 	bio->bi_cg_private = NULL;
 
-	tg->last_finish_time = ktime_get_ns();
+	finish_time = ktime_get_ns();
+	tg->last_finish_time = finish_time;
+
+	start_time = blk_stat_time(&bio->bi_issue_stat);
+	finish_time = __blk_stat_time(finish_time);
+	if (start_time && finish_time > start_time &&
+	    tg->td->track_bio_latency == 1 &&
+	    !(bio->bi_issue_stat.stat & SKIP_TRACK)) {
+		lat = finish_time - start_time;
+		throtl_track_latency(tg->td, blk_stat_size(&bio->bi_issue_stat),
+			bio_op(bio), lat);
+	}
 }
 
 /*
@@ -2106,6 +2251,12 @@ int blk_throtl_init(struct request_queue *q)
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
@@ -2119,10 +2270,13 @@ int blk_throtl_init(struct request_queue *q)
 	td->low_upgrade_time = jiffies;
 	td->low_downgrade_time = jiffies;
 
+	td->track_bio_latency = UINT_MAX;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
-	if (ret)
+	if (ret) {
+		free_percpu(td->latency_buckets);
 		kfree(td);
+	}
 	return ret;
 }
 
@@ -2131,6 +2285,7 @@ void blk_throtl_exit(struct request_queue *q)
 	BUG_ON(!q->td);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
+	free_percpu(q->td->latency_buckets);
 	kfree(q->td);
 }
 
diff --git a/block/blk.h b/block/blk.h
index 921d04f..dfb44e6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -294,11 +294,13 @@ extern ssize_t blk_throtl_sample_time_show(struct request_queue *q, char *page);
 extern ssize_t blk_throtl_sample_time_store(struct request_queue *q,
 	const char *page, size_t count);
 extern void blk_throtl_bio_endio(struct bio *bio);
+extern void blk_throtl_stat_add(struct request *rq, u64 time);
 #else /* CONFIG_BLK_DEV_THROTTLING */
 static inline void blk_throtl_drain(struct request_queue *q) { }
 static inline int blk_throtl_init(struct request_queue *q) { return 0; }
 static inline void blk_throtl_exit(struct request_queue *q) { }
 static inline void blk_throtl_bio_endio(struct bio *bio) { }
+static inline void blk_throtl_stat_add(struct request *rq, u64 time) { }
 #endif /* CONFIG_BLK_DEV_THROTTLING */
 
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8159a6c..d88a3c0 100644
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
@@ -59,6 +63,7 @@ struct bio {
 	struct io_context	*bi_ioc;
 	struct cgroup_subsys_state *bi_css;
 	void			*bi_cg_private;
+	struct blk_issue_stat	bi_issue_stat;
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
@@ -256,10 +261,6 @@ static inline unsigned int blk_qc_t_to_tag(blk_qc_t cookie)
 	return cookie & ((1u << BLK_QC_T_SHIFT) - 1);
 }
 
-struct blk_issue_stat {
-	u64 stat;
-};
-
 #define BLK_RQ_STAT_BATCH	64
 
 struct blk_rq_stat {
-- 
2.9.3

