Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 4/5] blk-iolatency: use a percentile approache for ssd's
Date: Fri, 28 Sep 2018 13:45:42 -0400
Message-Id: <20180928174543.28486-5-josef@toxicpanda.com>
In-Reply-To: <20180928174543.28486-1-josef@toxicpanda.com>
References: <20180928174543.28486-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

We use an average latency approach for determining if we're missing our
latency target.  This works well for rotational storage where we have
generally consistent latencies, but for ssd's and other low latency
devices you have more of a spikey behavior, which means we often won't
throttle misbehaving groups because a lot of IO completes at drastically
faster times than our latency target.  Instead keep track of how many
IO's miss our target and how many IO's are done in our time window.  If
the p(90) latency is above our target then we know we need to throttle.
With this change in place we are seeing the same throttling behavior
with our testcase on ssd's as we see with rotational drives.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 179 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 145 insertions(+), 34 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index e7be77b0ce8b..fd246805b0be 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -115,9 +115,21 @@ struct child_latency_info {
 	atomic_t scale_cookie;
 };
 
+struct percentile_stats {
+	u64 total;
+	u64 missed;
+};
+
+struct latency_stat {
+	union {
+		struct percentile_stats ps;
+		struct blk_rq_stat rqs;
+	};
+};
+
 struct iolatency_grp {
 	struct blkg_policy_data pd;
-	struct blk_rq_stat __percpu *stats;
+	struct latency_stat __percpu *stats;
 	struct blk_iolatency *blkiolat;
 	struct rq_depth rq_depth;
 	struct rq_wait rq_wait;
@@ -132,6 +144,7 @@ struct iolatency_grp {
 	/* Our current number of IO's for the last summation. */
 	u64 nr_samples;
 
+	bool ssd;
 	struct child_latency_info child_lat;
 };
 
@@ -172,6 +185,80 @@ static inline struct blkcg_gq *lat_to_blkg(struct iolatency_grp *iolat)
 	return pd_to_blkg(&iolat->pd);
 }
 
+static inline void latency_stat_init(struct iolatency_grp *iolat,
+				     struct latency_stat *stat)
+{
+	if (iolat->ssd) {
+		stat->ps.total = 0;
+		stat->ps.missed = 0;
+	} else
+		blk_rq_stat_init(&stat->rqs);
+}
+
+static inline void latency_stat_sum(struct iolatency_grp *iolat,
+				    struct latency_stat *sum,
+				    struct latency_stat *stat)
+{
+	if (iolat->ssd) {
+		sum->ps.total += stat->ps.total;
+		sum->ps.missed += stat->ps.missed;
+	} else
+		blk_rq_stat_sum(&sum->rqs, &stat->rqs);
+}
+
+static inline void latency_stat_record_time(struct iolatency_grp *iolat,
+					    u64 req_time)
+{
+	struct latency_stat *stat = get_cpu_ptr(iolat->stats);
+	if (iolat->ssd) {
+		if (req_time >= iolat->min_lat_nsec)
+			stat->ps.missed++;
+		stat->ps.total++;
+	} else
+		blk_rq_stat_add(&stat->rqs, req_time);
+	put_cpu_ptr(stat);
+}
+
+static inline bool latency_sum_ok(struct iolatency_grp *iolat,
+				  struct latency_stat *stat)
+{
+	if (iolat->ssd) {
+		u64 thresh = div64_u64(stat->ps.total, 10);
+		thresh = max(thresh, 1ULL);
+		return stat->ps.missed < thresh;
+	}
+	return stat->rqs.mean <= iolat->min_lat_nsec;
+}
+
+static inline u64 latency_stat_samples(struct iolatency_grp *iolat,
+				       struct latency_stat *stat)
+{
+	if (iolat->ssd)
+		return stat->ps.total;
+	return stat->rqs.nr_samples;
+}
+
+static inline void iolat_update_total_lat_avg(struct iolatency_grp *iolat,
+					      struct latency_stat *stat)
+{
+	int exp_idx;
+
+	if (iolat->ssd)
+		return;
+
+	/*
+	 * CALC_LOAD takes in a number stored in fixed point representation.
+	 * Because we are using this for IO time in ns, the values stored
+	 * are significantly larger than the FIXED_1 denominator (2048).
+	 * Therefore, rounding errors in the calculation are negligible and
+	 * can be ignored.
+	 */
+	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
+			div64_u64(iolat->cur_win_nsec,
+				  BLKIOLATENCY_EXP_BUCKET_SIZE));
+	CALC_LOAD(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat->rqs.mean);
+}
+
 static inline bool iolatency_may_queue(struct iolatency_grp *iolat,
 				       wait_queue_entry_t *wait,
 				       bool first_block)
@@ -418,7 +505,6 @@ static void iolatency_record_time(struct iolatency_grp *iolat,
 				  struct bio_issue *issue, u64 now,
 				  bool issue_as_root)
 {
-	struct blk_rq_stat *rq_stat;
 	u64 start = bio_issue_time(issue);
 	u64 req_time;
 
@@ -444,9 +530,7 @@ static void iolatency_record_time(struct iolatency_grp *iolat,
 		return;
 	}
 
-	rq_stat = get_cpu_ptr(iolat->stats);
-	blk_rq_stat_add(rq_stat, req_time);
-	put_cpu_ptr(rq_stat);
+	latency_stat_record_time(iolat, req_time);
 }
 
 #define BLKIOLATENCY_MIN_ADJUST_TIME (500 * NSEC_PER_MSEC)
@@ -457,17 +541,17 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	struct blkcg_gq *blkg = lat_to_blkg(iolat);
 	struct iolatency_grp *parent;
 	struct child_latency_info *lat_info;
-	struct blk_rq_stat stat;
+	struct latency_stat stat;
 	unsigned long flags;
-	int cpu, exp_idx;
+	int cpu;
 
-	blk_rq_stat_init(&stat);
+	latency_stat_init(iolat, &stat);
 	preempt_disable();
 	for_each_online_cpu(cpu) {
-		struct blk_rq_stat *s;
+		struct latency_stat *s;
 		s = per_cpu_ptr(iolat->stats, cpu);
-		blk_rq_stat_sum(&stat, s);
-		blk_rq_stat_init(s);
+		latency_stat_sum(iolat, &stat, s);
+		latency_stat_init(iolat, s);
 	}
 	preempt_enable();
 
@@ -477,41 +561,33 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 
 	lat_info = &parent->child_lat;
 
-	/*
-	 * CALC_LOAD takes in a number stored in fixed point representation.
-	 * Because we are using this for IO time in ns, the values stored
-	 * are significantly larger than the FIXED_1 denominator (2048).
-	 * Therefore, rounding errors in the calculation are negligible and
-	 * can be ignored.
-	 */
-	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
-			div64_u64(iolat->cur_win_nsec,
-				  BLKIOLATENCY_EXP_BUCKET_SIZE));
-	CALC_LOAD(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat.mean);
+	iolat_update_total_lat_avg(iolat, &stat);
 
 	/* Everything is ok and we don't need to adjust the scale. */
-	if (stat.mean <= iolat->min_lat_nsec &&
+	if (latency_sum_ok(iolat, &stat) &&
 	    atomic_read(&lat_info->scale_cookie) == DEFAULT_SCALE_COOKIE)
 		return;
 
 	/* Somebody beat us to the punch, just bail. */
 	spin_lock_irqsave(&lat_info->lock, flags);
 	lat_info->nr_samples -= iolat->nr_samples;
-	lat_info->nr_samples += stat.nr_samples;
-	iolat->nr_samples = stat.nr_samples;
+	lat_info->nr_samples += latency_stat_samples(iolat, &stat);
+	iolat->nr_samples = latency_stat_samples(iolat, &stat);
 
 	if ((lat_info->last_scale_event >= now ||
 	    now - lat_info->last_scale_event < BLKIOLATENCY_MIN_ADJUST_TIME) &&
 	    lat_info->scale_lat <= iolat->min_lat_nsec)
 		goto out;
 
-	if (stat.mean <= iolat->min_lat_nsec &&
-	    stat.nr_samples >= BLKIOLATENCY_MIN_GOOD_SAMPLES) {
+	if (latency_sum_ok(iolat, &stat)) {
+		if (latency_stat_samples(iolat, &stat) <
+		    BLKIOLATENCY_MIN_GOOD_SAMPLES)
+			goto out;
 		if (lat_info->scale_grp == iolat) {
 			lat_info->last_scale_event = now;
 			scale_cookie_change(iolat->blkiolat, lat_info, true);
 		}
-	} else if (stat.mean > iolat->min_lat_nsec) {
+	} else {
 		lat_info->last_scale_event = now;
 		if (!lat_info->scale_grp ||
 		    lat_info->scale_lat > iolat->min_lat_nsec) {
@@ -808,13 +884,43 @@ static int iolatency_print_limit(struct seq_file *sf, void *v)
 	return 0;
 }
 
+static size_t iolatency_ssd_stat(struct iolatency_grp *iolat, char *buf,
+				 size_t size)
+{
+	struct latency_stat stat;
+	int cpu;
+
+	latency_stat_init(iolat, &stat);
+	preempt_disable();
+	for_each_online_cpu(cpu) {
+		struct latency_stat *s;
+		s = per_cpu_ptr(iolat->stats, cpu);
+		latency_stat_sum(iolat, &stat, s);
+	}
+	preempt_enable();
+
+	if (iolat->rq_depth.max_depth == UINT_MAX)
+		return scnprintf(buf, size, " missed=%llu total=%llu depth=max",
+				 (unsigned long long)stat.ps.missed,
+				 (unsigned long long)stat.ps.total);
+	return scnprintf(buf, size, " missed=%llu total=%llu depth=%u",
+			 (unsigned long long)stat.ps.missed,
+			 (unsigned long long)stat.ps.total,
+			 iolat->rq_depth.max_depth);
+}
+
 static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 				size_t size)
 {
 	struct iolatency_grp *iolat = pd_to_lat(pd);
-	unsigned long long avg_lat = div64_u64(iolat->lat_avg, NSEC_PER_USEC);
-	unsigned long long cur_win = div64_u64(iolat->cur_win_nsec, NSEC_PER_MSEC);
+	unsigned long long avg_lat;
+	unsigned long long cur_win;
+
+	if (iolat->ssd)
+		return iolatency_ssd_stat(iolat, buf, size);
 
+	avg_lat = div64_u64(iolat->lat_avg, NSEC_PER_USEC);
+	cur_win = div64_u64(iolat->cur_win_nsec, NSEC_PER_MSEC);
 	if (iolat->rq_depth.max_depth == UINT_MAX)
 		return scnprintf(buf, size, " depth=max avg_lat=%llu win=%llu",
 				 avg_lat, cur_win);
@@ -831,8 +937,8 @@ static struct blkg_policy_data *iolatency_pd_alloc(gfp_t gfp, int node)
 	iolat = kzalloc_node(sizeof(*iolat), gfp, node);
 	if (!iolat)
 		return NULL;
-	iolat->stats = __alloc_percpu_gfp(sizeof(struct blk_rq_stat),
-				       __alignof__(struct blk_rq_stat), gfp);
+	iolat->stats = __alloc_percpu_gfp(sizeof(struct latency_stat),
+				       __alignof__(struct latency_stat), gfp);
 	if (!iolat->stats) {
 		kfree(iolat);
 		return NULL;
@@ -849,10 +955,15 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 	u64 now = ktime_to_ns(ktime_get());
 	int cpu;
 
+	if (blk_queue_nonrot(blkg->q))
+		iolat->ssd = true;
+	else
+		iolat->ssd = false;
+
 	for_each_possible_cpu(cpu) {
-		struct blk_rq_stat *stat;
+		struct latency_stat *stat;
 		stat = per_cpu_ptr(iolat->stats, cpu);
-		blk_rq_stat_init(stat);
+		latency_stat_init(iolat, stat);
 	}
 
 	rq_wait_init(&iolat->rq_wait);
-- 
2.14.3
