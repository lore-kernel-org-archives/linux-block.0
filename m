Return-Path: <prvs=631096caf0=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, <Kernel-team@fb.com>
Subject: [PATCH 1/4] blk-throttle: add hierarchy support for latency target and idle time
Date: Wed, 17 May 2017 13:07:24 -0700
Message-ID: <47549a2aa54bd505ef9c4fb651374baff55a453a.1495050247.git.shli@fb.com>
In-Reply-To: <cover.1495050247.git.shli@fb.com>
References: <cover.1495050247.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

For idle time, children's setting should not be bigger than parent's.
For latency target, children's setting should not be smaller than
parent's. The leaf nodes will adjust their settings according to the
hierarchy and compare their IO with the settings and do
upgrade/downgrade. parents nodes don't need to track their IO
latency/idle time.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index b78db2e..16174f8 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -157,6 +157,7 @@ struct throtl_grp {
 	unsigned long last_check_time;
 
 	unsigned long latency_target; /* us */
+	unsigned long latency_target_conf; /* us */
 	/* When did we start a new slice */
 	unsigned long slice_start[2];
 	unsigned long slice_end[2];
@@ -165,6 +166,7 @@ struct throtl_grp {
 	unsigned long checked_last_finish_time; /* ns / 1024 */
 	unsigned long avg_idletime; /* ns / 1024 */
 	unsigned long idletime_threshold; /* us */
+	unsigned long idletime_threshold_conf; /* us */
 
 	unsigned int bio_cnt; /* total bios */
 	unsigned int bad_bio_cnt; /* bios exceeding latency threshold */
@@ -482,6 +484,7 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 	/* LIMIT_LOW will have default value 0 */
 
 	tg->latency_target = DFL_LATENCY_TARGET;
+	tg->latency_target_conf = DFL_LATENCY_TARGET;
 
 	return &tg->pd;
 }
@@ -512,6 +515,7 @@ static void throtl_pd_init(struct blkg_policy_data *pd)
 	tg->td = td;
 
 	tg->idletime_threshold = td->dft_idletime_threshold;
+	tg->idletime_threshold_conf = td->dft_idletime_threshold;
 }
 
 /*
@@ -1367,8 +1371,25 @@ static void tg_conf_updated(struct throtl_grp *tg)
 	 * restrictions in the whole hierarchy and allows them to bypass
 	 * blk-throttle.
 	 */
-	blkg_for_each_descendant_pre(blkg, pos_css, tg_to_blkg(tg))
-		tg_update_has_rules(blkg_to_tg(blkg));
+	blkg_for_each_descendant_pre(blkg, pos_css, tg_to_blkg(tg)) {
+		struct throtl_grp *this_tg = blkg_to_tg(blkg);
+		struct throtl_grp *parent_tg;
+
+		tg_update_has_rules(this_tg);
+		/* ignore root/second level */
+		if (!cgroup_subsys_on_dfl(io_cgrp_subsys) || !blkg->parent ||
+		    !blkg->parent->parent)
+			continue;
+		parent_tg = blkg_to_tg(blkg->parent);
+		/*
+		 * make sure all children has lower idle time threshold and
+		 * higher latency target
+		 */
+		this_tg->idletime_threshold = min(this_tg->idletime_threshold,
+				parent_tg->idletime_threshold);
+		this_tg->latency_target = max(this_tg->latency_target,
+				parent_tg->latency_target);
+	}
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
@@ -1497,8 +1518,8 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	    tg->iops_conf[READ][off] == iops_dft &&
 	    tg->iops_conf[WRITE][off] == iops_dft &&
 	    (off != LIMIT_LOW ||
-	     (tg->idletime_threshold == tg->td->dft_idletime_threshold &&
-	      tg->latency_target == DFL_LATENCY_TARGET)))
+	     (tg->idletime_threshold_conf == tg->td->dft_idletime_threshold &&
+	      tg->latency_target_conf == DFL_LATENCY_TARGET)))
 		return 0;
 
 	if (tg->bps_conf[READ][off] != bps_dft)
@@ -1514,17 +1535,17 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 		snprintf(bufs[3], sizeof(bufs[3]), "%u",
 			tg->iops_conf[WRITE][off]);
 	if (off == LIMIT_LOW) {
-		if (tg->idletime_threshold == ULONG_MAX)
+		if (tg->idletime_threshold_conf == ULONG_MAX)
 			strcpy(idle_time, " idle=max");
 		else
 			snprintf(idle_time, sizeof(idle_time), " idle=%lu",
-				tg->idletime_threshold);
+				tg->idletime_threshold_conf);
 
-		if (tg->latency_target == ULONG_MAX)
+		if (tg->latency_target_conf == ULONG_MAX)
 			strcpy(latency_time, " latency=max");
 		else
 			snprintf(latency_time, sizeof(latency_time),
-				" latency=%lu", tg->latency_target);
+				" latency=%lu", tg->latency_target_conf);
 	}
 
 	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s%s%s\n",
@@ -1563,8 +1584,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 	v[2] = tg->iops_conf[READ][index];
 	v[3] = tg->iops_conf[WRITE][index];
 
-	idle_time = tg->idletime_threshold;
-	latency_time = tg->latency_target;
+	idle_time = tg->idletime_threshold_conf;
+	latency_time = tg->latency_target_conf;
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
 		char *p;
@@ -1628,10 +1649,10 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		blk_throtl_update_limit_valid(tg->td);
 		if (tg->td->limit_valid[LIMIT_LOW])
 			tg->td->limit_index = LIMIT_LOW;
-		tg->idletime_threshold = (idle_time == ULONG_MAX) ?
-			ULONG_MAX : idle_time;
-		tg->latency_target = (latency_time == ULONG_MAX) ?
-			ULONG_MAX : latency_time;
+		tg->idletime_threshold_conf = idle_time;
+		tg->idletime_threshold = tg->idletime_threshold_conf;
+		tg->latency_target_conf = latency_time;
+		tg->latency_target = tg->latency_target_conf;
 	}
 	tg_conf_updated(tg);
 	ret = 0;
@@ -2385,6 +2406,7 @@ void blk_throtl_register_queue(struct request_queue *q)
 		struct throtl_grp *tg = blkg_to_tg(blkg);
 
 		tg->idletime_threshold = td->dft_idletime_threshold;
+		tg->idletime_threshold_conf = td->dft_idletime_threshold;
 	}
 	rcu_read_unlock();
 }
-- 
2.9.3
