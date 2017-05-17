Return-Path: <prvs=631096caf0=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, <Kernel-team@fb.com>
Subject: [PATCH 3/4] blk-throttle: respect 0 bps/iops settings for io.low
Date: Wed, 17 May 2017 13:07:26 -0700
Message-ID: <ad5fc16b239b9cbe45fbaddaf52489b63bcea446.1495050247.git.shli@fb.com>
In-Reply-To: <cover.1495050247.git.shli@fb.com>
References: <cover.1495050247.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

If a cgroup with low limit 0 for both bps/iops, the cgroup's low limit
is ignored and we throttle the cgroup with its max limit. In this way,
other cgroups with a low limit will not get protected. To fix this, we
don't do the exception any more. cgroup will be throttled to a limit 0
if it uese default setting. To avoid completed stall, we give such
cgroup tiny IO resources.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 41 +++++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1f8d62f..f6a9f42a 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -27,6 +27,8 @@ static int throtl_quantum = 32;
 #define MAX_IDLE_TIME (5L * 1000 * 1000) /* 5 s */
 /* default latency target is 0, eg, guarantee IO latency by default */
 #define DFL_LATENCY_TARGET (0)
+#define MIN_THROTL_BPS (320 * 1024)
+#define MIN_THROTL_IOPS (10)
 
 #define SKIP_LATENCY (((u64)1) << BLK_STAT_RES_SHIFT)
 
@@ -296,8 +298,14 @@ static uint64_t tg_bps_limit(struct throtl_grp *tg, int rw)
 
 	td = tg->td;
 	ret = tg->bps[rw][td->limit_index];
-	if (ret == 0 && td->limit_index == LIMIT_LOW)
-		return tg->bps[rw][LIMIT_MAX];
+	if (ret == 0 && td->limit_index == LIMIT_LOW) {
+		/* intermediate node or iops isn't 0 */
+		if (!list_empty(&blkg->blkcg->css.children) ||
+		    tg->iops[rw][td->limit_index])
+			return U64_MAX;
+		else
+			return MIN_THROTL_BPS;
+	}
 
 	if (td->limit_index == LIMIT_MAX && tg->bps[rw][LIMIT_LOW] &&
 	    tg->bps[rw][LIMIT_LOW] != tg->bps[rw][LIMIT_MAX]) {
@@ -317,10 +325,17 @@ static unsigned int tg_iops_limit(struct throtl_grp *tg, int rw)
 
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys) && !blkg->parent)
 		return UINT_MAX;
+
 	td = tg->td;
 	ret = tg->iops[rw][td->limit_index];
-	if (ret == 0 && tg->td->limit_index == LIMIT_LOW)
-		return tg->iops[rw][LIMIT_MAX];
+	if (ret == 0 && tg->td->limit_index == LIMIT_LOW) {
+		/* intermediate node or bps isn't 0 */
+		if (!list_empty(&blkg->blkcg->css.children) ||
+		    tg->bps[rw][td->limit_index])
+			return UINT_MAX;
+		else
+			return MIN_THROTL_IOPS;
+	}
 
 	if (td->limit_index == LIMIT_MAX && tg->iops[rw][LIMIT_LOW] &&
 	    tg->iops[rw][LIMIT_LOW] != tg->iops[rw][LIMIT_MAX]) {
@@ -1353,7 +1368,7 @@ static int tg_print_conf_uint(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static void tg_conf_updated(struct throtl_grp *tg)
+static void tg_conf_updated(struct throtl_grp *tg, bool global)
 {
 	struct throtl_service_queue *sq = &tg->service_queue;
 	struct cgroup_subsys_state *pos_css;
@@ -1371,7 +1386,8 @@ static void tg_conf_updated(struct throtl_grp *tg)
 	 * restrictions in the whole hierarchy and allows them to bypass
 	 * blk-throttle.
 	 */
-	blkg_for_each_descendant_pre(blkg, pos_css, tg_to_blkg(tg)) {
+	blkg_for_each_descendant_pre(blkg, pos_css,
+			global ? tg->td->queue->root_blkg : tg_to_blkg(tg)) {
 		struct throtl_grp *this_tg = blkg_to_tg(blkg);
 		struct throtl_grp *parent_tg;
 
@@ -1434,7 +1450,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	else
 		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
 
-	tg_conf_updated(tg);
+	tg_conf_updated(tg, false);
 	ret = 0;
 out_finish:
 	blkg_conf_finish(&ctx);
@@ -1522,16 +1538,16 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	      tg->latency_target_conf == DFL_LATENCY_TARGET)))
 		return 0;
 
-	if (tg->bps_conf[READ][off] != bps_dft)
+	if (tg->bps_conf[READ][off] != U64_MAX)
 		snprintf(bufs[0], sizeof(bufs[0]), "%llu",
 			tg->bps_conf[READ][off]);
-	if (tg->bps_conf[WRITE][off] != bps_dft)
+	if (tg->bps_conf[WRITE][off] != U64_MAX)
 		snprintf(bufs[1], sizeof(bufs[1]), "%llu",
 			tg->bps_conf[WRITE][off]);
-	if (tg->iops_conf[READ][off] != iops_dft)
+	if (tg->iops_conf[READ][off] != UINT_MAX)
 		snprintf(bufs[2], sizeof(bufs[2]), "%u",
 			tg->iops_conf[READ][off]);
-	if (tg->iops_conf[WRITE][off] != iops_dft)
+	if (tg->iops_conf[WRITE][off] != UINT_MAX)
 		snprintf(bufs[3], sizeof(bufs[3]), "%u",
 			tg->iops_conf[WRITE][off]);
 	if (off == LIMIT_LOW) {
@@ -1654,7 +1670,8 @@ static ssize_t tg_set_limit(struct kernfs_open_file *of,
 		tg->latency_target_conf = latency_time;
 		tg->latency_target = tg->latency_target_conf;
 	}
-	tg_conf_updated(tg);
+	tg_conf_updated(tg, index == LIMIT_LOW &&
+		tg->td->limit_valid[LIMIT_LOW]);
 	ret = 0;
 out_finish:
 	blkg_conf_finish(&ctx);
-- 
2.9.3
