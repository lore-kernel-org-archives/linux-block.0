Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 5/5] blk-iolatency: keep track of previous windows stats
Date: Fri, 28 Sep 2018 13:45:43 -0400
Message-Id: <20180928174543.28486-6-josef@toxicpanda.com>
In-Reply-To: <20180928174543.28486-1-josef@toxicpanda.com>
References: <20180928174543.28486-1-josef@toxicpanda.com>
List-ID: <linux-block@vger.kernel.org>

We apply a smoothing to the scale changes in order to keep sawtoothy
behavior from occurring.  However our window for checking if we've
missed our target can sometimes be lower than the smoothing interval
(500ms), especially on faster drives like ssd's.  In order to deal with
this keep track of the running tally of the previous intervals that we
threw away because we had already done a scale event recently.

This is needed for the ssd case as these low latency drives will have
bursts of latency, and if it happens to be ok for the window that
directly follows the opening of the scale window we could unthrottle
when previous windows we were missing our target.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-iolatency.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index fd246805b0be..35c48d7b8f78 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -130,6 +130,7 @@ struct latency_stat {
 struct iolatency_grp {
 	struct blkg_policy_data pd;
 	struct latency_stat __percpu *stats;
+	struct latency_stat cur_stat;
 	struct blk_iolatency *blkiolat;
 	struct rq_depth rq_depth;
 	struct rq_wait rq_wait;
@@ -570,24 +571,27 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 
 	/* Somebody beat us to the punch, just bail. */
 	spin_lock_irqsave(&lat_info->lock, flags);
+
+	latency_stat_sum(iolat, &iolat->cur_stat, &stat);
 	lat_info->nr_samples -= iolat->nr_samples;
-	lat_info->nr_samples += latency_stat_samples(iolat, &stat);
-	iolat->nr_samples = latency_stat_samples(iolat, &stat);
+	lat_info->nr_samples += latency_stat_samples(iolat, &iolat->cur_stat);
+	iolat->nr_samples = latency_stat_samples(iolat, &iolat->cur_stat);
 
 	if ((lat_info->last_scale_event >= now ||
-	    now - lat_info->last_scale_event < BLKIOLATENCY_MIN_ADJUST_TIME) &&
-	    lat_info->scale_lat <= iolat->min_lat_nsec)
+	    now - lat_info->last_scale_event < BLKIOLATENCY_MIN_ADJUST_TIME))
 		goto out;
 
-	if (latency_sum_ok(iolat, &stat)) {
-		if (latency_stat_samples(iolat, &stat) <
+	if (latency_sum_ok(iolat, &iolat->cur_stat) &&
+	    latency_sum_ok(iolat, &stat)) {
+		if (latency_stat_samples(iolat, &iolat->cur_stat) <
 		    BLKIOLATENCY_MIN_GOOD_SAMPLES)
 			goto out;
 		if (lat_info->scale_grp == iolat) {
 			lat_info->last_scale_event = now;
 			scale_cookie_change(iolat->blkiolat, lat_info, true);
 		}
-	} else {
+	} else if (lat_info->scale_lat == 0 ||
+		   lat_info->scale_lat >= iolat->min_lat_nsec) {
 		lat_info->last_scale_event = now;
 		if (!lat_info->scale_grp ||
 		    lat_info->scale_lat > iolat->min_lat_nsec) {
@@ -596,6 +600,7 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 		}
 		scale_cookie_change(iolat->blkiolat, lat_info, false);
 	}
+	latency_stat_init(iolat, &iolat->cur_stat);
 out:
 	spin_unlock_irqrestore(&lat_info->lock, flags);
 }
@@ -966,6 +971,7 @@ static void iolatency_pd_init(struct blkg_policy_data *pd)
 		latency_stat_init(iolat, stat);
 	}
 
+	latency_stat_init(iolat, &iolat->cur_stat);
 	rq_wait_init(&iolat->rq_wait);
 	spin_lock_init(&iolat->child_lat.lock);
 	iolat->rq_depth.queue_depth = blkg->q->nr_requests;
-- 
2.14.3
