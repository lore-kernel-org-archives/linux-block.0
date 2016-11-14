Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51779 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965139AbcKNWW2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2016 17:22:28 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.17/8.16.0.17) with SMTP id uAEMJJWW001213
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:28 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0089730.ppops.net with ESMTP id 26qesjapgv-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2016 14:22:27 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.212.232.59) with ESMTP id
 d1e3243aaab811e6b7a10002c991e86a-da1fda50 for <linux-block@vger.kernel.org>;
        Mon, 14 Nov 2016 14:22:25 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@fb.com>, <tj@kernel.org>,
        <vgoyal@redhat.com>
Subject: [PATCH V4 13/15] blk-throttle: add a mechanism to estimate IO latency
Date: Mon, 14 Nov 2016 14:22:20 -0800
Message-ID: <9c75c9852b08404b90fbbdb143e81a8ef3b36abf.1479161136.git.shli@fb.com>
In-Reply-To: <cover.1479161136.git.shli@fb.com>
References: <cover.1479161136.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We try to set a latency target for each cgroup. The problem is latency
highly depends on request size, users can't configure the target for
every request size. The idea is users configure latency target for 4k
IO, we estimate the target latency for other request size IO.

To do this, we sample some data, eg, average latency for request size
4k, 8k, 16k, 32k, 64k. We then use an equation f(x) = a * x + b to fit
the data (x is request size in KB, f(x) is the latency). Then we can use
the equation to estimate IO target latency for any request.

To increase the chance of sampling, we actually collect data for any IO
size less than 64k, then calcualte an average latency/size. This is ok
for line fit because the equation should work for average request
size/latency too.

But we shouldn't sample data at any time. If disk is congested, the
calculated data will not represent the disk's capability. Hence we only
do the sampling when block throttling is in the HIGH limit, with
assumption disk isn't congested in such state. If the assumption isn't
true, eg, high limit is too high, calculated latency target will be
higher.

How does the equation fit to actual data? I collected data from 4
different SSDs (one SATA, 3 NVMe). The error range is quite small. The
big difference between measured latency and calculated latency generally
comes from 4k IO. The biggest one has around 30% difference, which isn't
terrible as we don't need accurate latency target. We don't know if line
fit works for other SSDs though. For big request size latency, the error
range seems big. But this mechanism is to determine if we should
throttle IO (eg, if cgroup is idle). If cgroups average request size is
big, we can simply treat it as busy, hence we don't need the mechanism.

Hard disk is completely different. Latency depends on spindle seek
instead of request size. So this latency target feature is for SSD only.

The patch uses below algorithm to calculate the equation:
https://en.wikipedia.org/wiki/Simple_linear_regression

TODO: the latency sampling is better moving to request layer

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c      | 191 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/blk_types.h |   2 +
 2 files changed, 190 insertions(+), 3 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 01b494d..a05d351 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -156,6 +156,20 @@ struct throtl_grp {
 	u64 avg_ttime;
 };
 
+/* We measure latency for request size from 4k to 4k * ( 1 << 4) */
+#define LATENCY_BUCKET_SIZE 5
+
+struct latency_bucket {
+	u64 total_latency;
+	u64 total_size;
+	int samples;
+};
+
+struct avg_latency_bucket {
+	u64 latency;
+	u64 size;
+};
+
 struct throtl_data
 {
 	/* service tree for active throtl groups */
@@ -179,6 +193,12 @@ struct throtl_data
 	unsigned int scale;
 
 	u64 idle_ttime_threshold;
+
+	struct latency_bucket tmp_buckets[LATENCY_BUCKET_SIZE];
+	struct avg_latency_bucket avg_buckets[LATENCY_BUCKET_SIZE];
+	struct latency_bucket __percpu *latency_buckets;
+	s64 line_slope;
+	unsigned long last_calculate_time;
 };
 
 static void throtl_pending_timer_fn(unsigned long arg);
@@ -288,6 +308,19 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 	return ret;
 }
 
+static int request_bucket_index(sector_t sectors)
+{
+	int i;
+
+	for (i = LATENCY_BUCKET_SIZE - 1; i >= 0; i--) {
+		if (sectors > (1 << (i + 3)))
+			break;
+	}
+	if (i == LATENCY_BUCKET_SIZE - 1)
+		return -1;
+	return i + 1;
+}
+
 /**
  * throtl_log - log debug message via blktrace
  * @sq: the service_queue being reported
@@ -1877,6 +1910,120 @@ static void blk_throtl_update_ttime(struct throtl_grp *tg)
 	tg->checked_last_finish_time = last_finish_time;
 }
 
+static void throtl_calculate_line_slope(struct throtl_data *td)
+{
+	struct avg_latency_bucket avg_latency[LATENCY_BUCKET_SIZE];
+	s64 sumX;
+	s64 sumY;
+	s64 sumXY;
+	s64 sumX2;
+	s64 xMean;
+	s64 yMean;
+	s64 denominator;
+	s64 slope;
+	int i, cpu;
+	int valid_lat;
+	u64 last_latency = 0;
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
+			bucket = per_cpu_ptr(td->latency_buckets, cpu);
+			tmp->total_latency += bucket[i].total_latency;
+			tmp->total_size += bucket[i].total_size;
+			tmp->samples += bucket[i].samples;
+			bucket[i].total_latency = 0;
+			bucket[i].total_size = 0;
+			bucket[i].samples = 0;
+		}
+
+		if (tmp->samples >= 32) {
+			u64 latency = tmp->total_latency;
+			u64 size = tmp->total_size;
+			int samples = tmp->samples;
+
+			tmp->total_latency = 0;
+			tmp->total_size = 0;
+			tmp->samples = 0;
+			do_div(size, samples);
+			if (size == 0 || size > (1 << (i + 12)))
+				continue;
+			avg_latency[i].size = size;
+			do_div(latency, samples);
+			if (latency == 0)
+				continue;
+			avg_latency[i].latency = latency;
+		}
+	}
+
+	valid_lat = 0;
+	for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
+		if (!td->avg_buckets[i].latency && !avg_latency[i].latency)
+			continue;
+		valid_lat++;
+		if (!td->avg_buckets[i].latency) {
+			td->avg_buckets[i].latency = avg_latency[i].latency;
+			td->avg_buckets[i].size = avg_latency[i].size;
+			continue;
+		}
+		if (!avg_latency[i].latency)
+			continue;
+		/* make it smooth */
+		td->avg_buckets[i].latency = (td->avg_buckets[i].latency * 7 +
+			avg_latency[i].latency) >> 3;
+		td->avg_buckets[i].size = (td->avg_buckets[i].size * 7 +
+			avg_latency[i].size) >> 3;
+		/* filter out abnormal latency */
+		if (td->avg_buckets[i].latency <= last_latency) {
+			td->avg_buckets[i].latency = 0;
+			valid_lat--;
+		} else
+			last_latency = td->avg_buckets[i].latency;
+	}
+
+	if (valid_lat < 2)
+		return;
+
+	sumX = 0;
+	sumY = 0;
+	sumXY = 0;
+	sumX2 = 0;
+	for (i = 0; i < LATENCY_BUCKET_SIZE; i++) {
+		u64 x, y;
+
+		if (td->avg_buckets[i].latency == 0)
+			continue;
+
+		x = td->avg_buckets[i].size >> 10;
+		y = td->avg_buckets[i].latency;
+		sumX += x;
+		sumY += y;
+
+		sumXY += x * y;
+		sumX2 += x * x;
+	}
+
+	xMean = sumX;
+	do_div(xMean, valid_lat);
+	yMean = sumY;
+	do_div(yMean, valid_lat);
+	denominator = sumX2 - sumX * xMean;
+
+	slope = sumXY - sumX * yMean;
+	do_div(slope, denominator);
+	td->line_slope = slope;
+}
+
 bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 		    struct bio *bio)
 {
@@ -1901,11 +2048,14 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 
 	spin_lock_irq(q->queue_lock);
 
+	throtl_calculate_line_slope(tg->td);
+
 	if (unlikely(blk_queue_bypass(q)))
 		goto out_unlock;
 
 	bio_associate_current(bio);
 	bio->bi_cg_private = q;
+	bio->bi_cg_size = bio_sectors(bio);
 
 	blk_throtl_update_ttime(tg);
 
@@ -1992,8 +2142,11 @@ bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
 	 * don't want bios to leave with the flag set.  Clear the flag if
 	 * being issued.
 	 */
-	if (!throttled)
+	if (!throttled) {
+		if (blk_queue_nonrot(q))
+			bio->bi_cg_issue_time = ktime_get_ns();
 		bio->bi_opf &= ~REQ_THROTTLED;
+	}
 	return throttled;
 }
 
@@ -2003,6 +2156,9 @@ void blk_throtl_bio_endio(struct bio *bio)
 	struct blkcg_gq *blkg;
 	struct throtl_grp *tg;
 	struct request_queue *q;
+	struct throtl_data *td;
+	u64 finish_time;
+	u64 lat;
 
 	q = bio->bi_cg_private;
 	if (!q)
@@ -2019,7 +2175,27 @@ void blk_throtl_bio_endio(struct bio *bio)
 
 	tg = blkg_to_tg(blkg ?: q->root_blkg);
 
-	tg->last_finish_time = ktime_get_ns();
+	finish_time = ktime_get_ns();
+	tg->last_finish_time = finish_time;
+
+	td = tg->td;
+
+	if (bio->bi_cg_issue_time && finish_time > bio->bi_cg_issue_time) {
+		int index;
+
+		lat = finish_time - bio->bi_cg_issue_time;
+		index = request_bucket_index(bio->bi_cg_size);
+		if (index >= 0 && bio_op(bio) == REQ_OP_READ &&
+				td->limit_index == LIMIT_HIGH) {
+			struct latency_bucket *latency;
+
+			latency = get_cpu_ptr(td->latency_buckets);
+			latency[index].total_latency += lat;
+			latency[index].total_size += bio->bi_cg_size << 9;
+			latency[index].samples++;
+			put_cpu_ptr(td->latency_buckets);
+		}
+	}
 
 end:
 	rcu_read_unlock();
@@ -2097,6 +2273,12 @@ int blk_throtl_init(struct request_queue *q)
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
@@ -2113,8 +2295,10 @@ int blk_throtl_init(struct request_queue *q)
 	td->idle_ttime_threshold = -1;
 	/* activate policy */
 	ret = blkcg_activate_policy(q, &blkcg_policy_throtl);
-	if (ret)
+	if (ret) {
+		free_percpu(td->latency_buckets);
 		kfree(td);
+	}
 	return ret;
 }
 
@@ -2123,6 +2307,7 @@ void blk_throtl_exit(struct request_queue *q)
 	BUG_ON(!q->td);
 	throtl_shutdown_wq(q);
 	blkcg_deactivate_policy(q, &blkcg_policy_throtl);
+	free_percpu(q->td->latency_buckets);
 	kfree(q->td);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ff8dd24..45bb437 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -60,6 +60,8 @@ struct bio {
 	struct io_context	*bi_ioc;
 	struct cgroup_subsys_state *bi_css;
 	void *bi_cg_private;
+	u64 bi_cg_issue_time;
+	sector_t bi_cg_size;
 #endif
 	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-- 
2.9.3

