Return-Path: <prvs=425928092f=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <axboe@kernel.dk>, <tj@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        <jmoyer@redhat.com>, <Kernel-team@fb.com>
Subject: [PATCH V7 01/18] blk-throttle: use U64_MAX/UINT_MAX to replace -1
Date: Mon, 27 Mar 2017 10:51:29 -0700
Message-ID: <9f7123ea1ba65e09dc1cb488132bff67ddf8d923.1490634565.git.shli@fb.com>
In-Reply-To: <cover.1490634565.git.shli@fb.com>
References: <cover.1490634565.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

clean up the code to avoid using -1

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-throttle.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 8fab716..0d5d85b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -334,10 +334,10 @@ static struct blkg_policy_data *throtl_pd_alloc(gfp_t gfp, int node)
 	}
 
 	RB_CLEAR_NODE(&tg->rb_node);
-	tg->bps[READ] = -1;
-	tg->bps[WRITE] = -1;
-	tg->iops[READ] = -1;
-	tg->iops[WRITE] = -1;
+	tg->bps[READ] = U64_MAX;
+	tg->bps[WRITE] = U64_MAX;
+	tg->iops[READ] = UINT_MAX;
+	tg->iops[WRITE] = UINT_MAX;
 
 	return &tg->pd;
 }
@@ -380,7 +380,7 @@ static void tg_update_has_rules(struct throtl_grp *tg)
 
 	for (rw = READ; rw <= WRITE; rw++)
 		tg->has_rules[rw] = (parent_tg && parent_tg->has_rules[rw]) ||
-				    (tg->bps[rw] != -1 || tg->iops[rw] != -1);
+			(tg->bps[rw] != U64_MAX || tg->iops[rw] != UINT_MAX);
 }
 
 static void throtl_pd_online(struct blkg_policy_data *pd)
@@ -771,7 +771,7 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
 
 	/* If tg->bps = -1, then BW is unlimited */
-	if (tg->bps[rw] == -1 && tg->iops[rw] == -1) {
+	if (tg->bps[rw] == U64_MAX && tg->iops[rw] == UINT_MAX) {
 		if (wait)
 			*wait = 0;
 		return true;
@@ -1112,7 +1112,7 @@ static u64 tg_prfill_conf_u64(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct throtl_grp *tg = pd_to_tg(pd);
 	u64 v = *(u64 *)((void *)tg + off);
 
-	if (v == -1)
+	if (v == U64_MAX)
 		return 0;
 	return __blkg_prfill_u64(sf, pd, v);
 }
@@ -1123,7 +1123,7 @@ static u64 tg_prfill_conf_uint(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct throtl_grp *tg = pd_to_tg(pd);
 	unsigned int v = *(unsigned int *)((void *)tg + off);
 
-	if (v == -1)
+	if (v == UINT_MAX)
 		return 0;
 	return __blkg_prfill_u64(sf, pd, v);
 }
@@ -1197,7 +1197,7 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
 	if (sscanf(ctx.body, "%llu", &v) != 1)
 		goto out_finish;
 	if (!v)
-		v = -1;
+		v = U64_MAX;
 
 	tg = blkg_to_tg(ctx.blkg);
 
@@ -1272,17 +1272,17 @@ static u64 tg_prfill_max(struct seq_file *sf, struct blkg_policy_data *pd,
 
 	if (!dname)
 		return 0;
-	if (tg->bps[READ] == -1 && tg->bps[WRITE] == -1 &&
-	    tg->iops[READ] == -1 && tg->iops[WRITE] == -1)
+	if (tg->bps[READ] == U64_MAX && tg->bps[WRITE] == U64_MAX &&
+	    tg->iops[READ] == UINT_MAX && tg->iops[WRITE] == UINT_MAX)
 		return 0;
 
-	if (tg->bps[READ] != -1)
+	if (tg->bps[READ] != U64_MAX)
 		snprintf(bufs[0], sizeof(bufs[0]), "%llu", tg->bps[READ]);
-	if (tg->bps[WRITE] != -1)
+	if (tg->bps[WRITE] != U64_MAX)
 		snprintf(bufs[1], sizeof(bufs[1]), "%llu", tg->bps[WRITE]);
-	if (tg->iops[READ] != -1)
+	if (tg->iops[READ] != UINT_MAX)
 		snprintf(bufs[2], sizeof(bufs[2]), "%u", tg->iops[READ]);
-	if (tg->iops[WRITE] != -1)
+	if (tg->iops[WRITE] != UINT_MAX)
 		snprintf(bufs[3], sizeof(bufs[3]), "%u", tg->iops[WRITE]);
 
 	seq_printf(sf, "%s rbps=%s wbps=%s riops=%s wiops=%s\n",
@@ -1320,7 +1320,7 @@ static ssize_t tg_set_max(struct kernfs_open_file *of,
 	while (true) {
 		char tok[27];	/* wiops=18446744073709551616 */
 		char *p;
-		u64 val = -1;
+		u64 val = U64_MAX;
 		int len;
 
 		if (sscanf(ctx.body, "%26s%n", tok, &len) != 1)
-- 
2.9.3
