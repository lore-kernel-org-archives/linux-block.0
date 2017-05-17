Return-Path: <prvs=631096caf0=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, <Kernel-team@fb.com>
Subject: [PATCH 4/4] blk-throttle: force user to configure all settings for io.low
Date: Wed, 17 May 2017 13:07:27 -0700
Message-ID: <489dd609144faad75a95eeb9dc4de6cb8aa4e088.1495050247.git.shli@fb.com>
In-Reply-To: <cover.1495050247.git.shli@fb.com>
References: <cover.1495050247.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Default value of io.low limit is 0. If user doesn't configure the limit,
last patch makes cgroup be throttled to very tiny bps/iops, which could
stall the system. A cgroup with default settings of io.low limit really
means nothing, so we force user to configure all settings, otherwise
io.low limit doesn't take effect. With this stragety, default setting of
latency/idle isn't important, so just set them to very conservative and
safe value.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 80 ++++++++++++++++++++++++----------------------------
 1 file changed, 37 insertions(+), 43 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f6a9f42a..fc13dd0 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -22,13 +22,11 @@ static int throtl_quantum = 32;
 #define DFL_THROTL_SLICE_HD (HZ / 10)
 #define DFL_THROTL_SLICE_SSD (HZ / 50)
 #define MAX_THROTL_SLICE (HZ)
-#define DFL_IDLE_THRESHOLD_SSD (1000L) /* 1 ms */
-#define DFL_IDLE_THRESHOLD_HD (100L * 1000) /* 100 ms */
 #define MAX_IDLE_TIME (5L * 1000 * 1000) /* 5 s */
-/* default latency target is 0, eg, guarantee IO latency by default */
-#define DFL_LATENCY_TARGET (0)
 #define MIN_THROTL_BPS (320 * 1024)
 #define MIN_THROTL_IOPS (10)
+#define DFL_LATENCY_TARGET (-1L)
+#define DFL_IDLE_THRESHOLD (0)
 
 #define SKIP_LATENCY (((u64)1) << BLK_STAT_RES_SHIFT)
 
@@ -205,8 +203,6 @@ struct throtl_data
 	unsigned int limit_index;
 	bool limit_valid[LIMIT_CNT];
 
-	unsigned long dft_idletime_threshold; /* us */
-
 	unsigned long low_upgrade_time;
 	unsigned long low_downgrade_time;
 
@@ -500,6 +496,8 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 
 	tg->latency_target = DFL_LATENCY_TARGET;
 	tg->latency_target_conf = DFL_LATENCY_TARGET;
+	tg->idletime_threshold = DFL_IDLE_THRESHOLD;
+	tg->idletime_threshold_conf = DFL_IDLE_THRESHOLD;
 
 	return &tg->pd;
 }
@@ -528,9 +526,6 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && blkg->parent)
 		sq->parent_sq = &blkg_to_tg(blkg->parent)->service_queue;
 	tg->td = td;
-
-	tg->idletime_threshold = td->dft_idletime_threshold;
-	tg->idletime_threshold_conf = td->dft_idletime_threshold;
 }
 
 /*
@@ -1534,7 +1529,7 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	    tg->iops_conf[READ][off] == iops_dft &&
 	    tg->iops_conf[WRITE][off] == iops_dft &&
 	    (off != LIMIT_LOW ||
-	     (tg->idletime_threshold_conf == tg->td->dft_idletime_threshold &&
+	     (tg->idletime_threshold_conf == DFL_IDLE_THRESHOLD &&
 	      tg->latency_target_conf == DFL_LATENCY_TARGET)))
 		return 0;
 
@@ -1660,16 +1655,31 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		tg->iops_conf[READ][LIMIT_MAX]);
 	tg->iops[WRITE][LIMIT_LOW] = min(tg->iops_conf[WRITE][LIMIT_LOW],
 		tg->iops_conf[WRITE][LIMIT_MAX]);
-
-	if (index == LIMIT_LOW) {
-		blk_throtl_update_limit_valid(tg->td);
-		if (tg->td->limit_valid[LIMIT_LOW])
-			tg->td->limit_index = LIMIT_LOW;
-		tg->idletime_threshold_conf = idle_time;
+	tg->idletime_threshold_conf = idle_time;
+	tg->latency_target_conf = latency_time;
+
+	/* force user to configure all settings for low limit  */
+	if (!(tg->bps[READ][LIMIT_LOW] || tg->iops[READ][LIMIT_LOW] ||
+	      tg->bps[WRITE][LIMIT_LOW] || tg->iops[WRITE][LIMIT_LOW]) ||
+	    tg->idletime_threshold_conf == DFL_IDLE_THRESHOLD ||
+	    tg->latency_target_conf == DFL_LATENCY_TARGET) {
+		tg->bps[READ][LIMIT_LOW] = 0;
+		tg->bps[WRITE][LIMIT_LOW] = 0;
+		tg->iops[READ][LIMIT_LOW] = 0;
+		tg->iops[WRITE][LIMIT_LOW] = 0;
+		tg->idletime_threshold = DFL_IDLE_THRESHOLD;
+		tg->latency_target = DFL_LATENCY_TARGET;
+	} else if (index == LIMIT_LOW) {
 		tg->idletime_threshold = tg->idletime_threshold_conf;
-		tg->latency_target_conf = latency_time;
 		tg->latency_target = tg->latency_target_conf;
 	}
+
+	blk_throtl_update_limit_valid(tg->td);
+	if (tg->td->limit_valid[LIMIT_LOW]) {
+		if (index == LIMIT_LOW)
+			tg->td->limit_index = LIMIT_LOW;
+	} else
+		tg->td->limit_index = LIMIT_MAX;
 	tg_conf_updated(tg, index == LIMIT_LOW &&
 		tg->td->limit_valid[LIMIT_LOW]);
 	ret = 0;
@@ -1760,17 +1770,19 @@ static bool throtl_tg_is_idle(struct throtl_grp *tg)
 	/*
 	 * cgroup is idle if:
 	 * - single idle is too long, longer than a fixed value (in case user
-	 *   configure a too big threshold) or 4 times of slice
+	 *   configure a too big threshold) or 4 times of idletime threshold
 	 * - average think time is more than threshold
 	 * - IO latency is largely below threshold
 	 */
-	unsigned long time = jiffies_to_usecs(4 * tg->td->throtl_slice);
+	unsigned long time;
 	bool ret;
 
-	time = min_t(unsigned long, MAX_IDLE_TIME, time);
-	ret = (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
-	       tg->avg_idletime > tg->idletime_threshold ||
-	       (tg->latency_target && tg->bio_cnt &&
+	time = min_t(unsigned long, MAX_IDLE_TIME, 4 * tg->idletime_threshold);
+	ret = tg->latency_target == DFL_LATENCY_TARGET ||
+	      tg->idletime_threshold == DFL_IDLE_THRESHOLD ||
+	      (ktime_get_ns() >> 10) - tg->last_finish_time > time ||
+	      tg->avg_idletime > tg->idletime_threshold ||
+	      (tg->latency_target && tg->bio_cnt &&
 		tg->bad_bio_cnt * 5 < tg->bio_cnt);
 	throtl_log(&tg->service_queue,
 		"avg_idle=%ld, idle_threshold=%ld, bad_bio=%d, total_bio=%d, is_idle=%d, scale=%d",
@@ -2405,19 +2417,14 @@ void blk_throtl_exit(struct request_queue *q)
 void blk_throtl_register_queue(struct request_queue *q)
 {
 	struct throtl_data *td;
-	struct cgroup_subsys_state *pos_css;
-	struct blkcg_gq *blkg;
 
 	td = q->td;
 	BUG_ON(!td);
 
-	if (blk_queue_nonrot(q)) {
+	if (blk_queue_nonrot(q))
 		td->throtl_slice = DFL_THROTL_SLICE_SSD;
-		td->dft_idletime_threshold = DFL_IDLE_THRESHOLD_SSD;
-	} else {
+	else
 		td->throtl_slice = DFL_THROTL_SLICE_HD;
-		td->dft_idletime_threshold = DFL_IDLE_THRESHOLD_HD;
-	}
 #ifndef CONFIG_BLK_DEV_THROTTLING_LOW
 	/* if no low limit, use previous default */
 	td->throtl_slice = DFL_THROTL_SLICE_HD;
@@ -2426,19 +2433,6 @@ void blk_throtl_register_queue(struct request_queue *q)
 	td->track_bio_latency = !q->mq_ops && !q->request_fn;
 	if (!td->track_bio_latency)
 		blk_stat_enable_accounting(q);
-
-	/*
-	 * some tg are created before queue is fully initialized, eg, nonrot
-	 * isn't initialized yet
-	 */
-	rcu_read_lock();
-	blkg_for_each_descendant_post(blkg, pos_css, q->root_blkg) {
-		struct throtl_grp *tg = blkg_to_tg(blkg);
-
-		tg->idletime_threshold = td->dft_idletime_threshold;
-		tg->idletime_threshold_conf = td->dft_idletime_threshold;
-	}
-	rcu_read_unlock();
 }
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
-- 
2.9.3
