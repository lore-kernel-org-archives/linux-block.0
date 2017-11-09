Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 9 Nov 2017 21:41:48 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blkcg: add wrappers for struct blkcg_policy operations
Message-ID: <20171109134140.GA27896@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

Some blkcg policies may not implement all operations in struct blkcg_policy,
there are lots of "if (pol->xxx)", add wrappers for these pol->xxx_fn.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-cgroup.c         | 55 +++++++++++++++++------------------
 include/linux/blk-cgroup.h | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 29 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index e7ec676..e34ecb2 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -71,7 +71,7 @@ static void blkg_free(struct blkcg_gq *blkg)
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
-			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
+			blkg_pol_free_pd(blkcg_policy[i], blkg->pd[i]);
 
 	if (blkg->blkcg != &blkcg_root)
 		blk_exit_rl(blkg->q, &blkg->rl);
@@ -124,7 +124,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 			continue;
 
 		/* alloc per-policy data and attach it to blkg */
-		pd = pol->pd_alloc_fn(gfp_mask, q->node);
+		pd = blkg_pol_alloc_pd(pol, gfp_mask, q->node);
 		if (!pd)
 			goto err_free;
 
@@ -218,8 +218,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 
-		if (blkg->pd[i] && pol->pd_init_fn)
-			pol->pd_init_fn(blkg->pd[i]);
+		if (blkg->pd[i])
+			blkg_pol_init_pd(pol, blkg->pd[i]);
 	}
 
 	/* insert */
@@ -232,8 +232,8 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-			if (blkg->pd[i] && pol->pd_online_fn)
-				pol->pd_online_fn(blkg->pd[i]);
+			if (blkg->pd[i])
+				blkg_pol_online_pd(pol, blkg->pd[i]);
 		}
 	}
 	blkg->online = true;
@@ -323,8 +323,8 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 
-		if (blkg->pd[i] && pol->pd_offline_fn)
-			pol->pd_offline_fn(blkg->pd[i]);
+		if (blkg->pd[i])
+			blkg_pol_offline_pd(pol, blkg->pd[i]);
 	}
 
 	if (parent) {
@@ -457,8 +457,8 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
-			if (blkg->pd[i] && pol->pd_reset_stats_fn)
-				pol->pd_reset_stats_fn(blkg->pd[i]);
+			if (blkg->pd[i])
+				blkg_pol_reset_pd_stats(pol, blkg->pd[i]);
 		}
 	}
 
@@ -1045,7 +1045,7 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkcg->cpd[i])
-			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
+			blkcg_pol_free_cpd(blkcg_policy[i], blkcg->cpd[i]);
 
 	mutex_unlock(&blkcg_pol_mutex);
 
@@ -1084,7 +1084,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		if (!pol || !pol->cpd_alloc_fn)
 			continue;
 
-		cpd = pol->cpd_alloc_fn(GFP_KERNEL);
+		cpd = blkcg_pol_alloc_cpd(pol, GFP_KERNEL);
 		if (!cpd) {
 			ret = ERR_PTR(-ENOMEM);
 			goto free_pd_blkcg;
@@ -1092,8 +1092,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		blkcg->cpd[i] = cpd;
 		cpd->blkcg = blkcg;
 		cpd->plid = i;
-		if (pol->cpd_init_fn)
-			pol->cpd_init_fn(cpd);
+		blkcg_pol_init_cpd(pol, cpd);
 	}
 
 	spin_lock_init(&blkcg->lock);
@@ -1108,9 +1107,9 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	return &blkcg->css;
 
 free_pd_blkcg:
-	for (i--; i >= 0; i--)
+	while (i--)
 		if (blkcg->cpd[i])
-			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
+			blkcg_pol_free_cpd(blkcg_policy[i], blkcg->cpd[pol->plid]);
 
 	if (blkcg != &blkcg_root)
 		kfree(blkcg);
@@ -1246,7 +1245,7 @@ static void blkcg_bind(struct cgroup_subsys_state *root_css)
 
 		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node)
 			if (blkcg->cpd[pol->plid])
-				pol->cpd_bind_fn(blkcg->cpd[pol->plid]);
+				blkcg_pol_bind_cpd(pol, blkcg->cpd[pol->plid]);
 	}
 	mutex_unlock(&blkcg_pol_mutex);
 }
@@ -1303,7 +1302,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blk_queue_bypass_start(q);
 pd_prealloc:
 	if (!pd_prealloc) {
-		pd_prealloc = pol->pd_alloc_fn(GFP_KERNEL, q->node);
+		pd_prealloc = blkg_pol_alloc_pd(pol, GFP_KERNEL, q->node);
 		if (!pd_prealloc) {
 			ret = -ENOMEM;
 			goto out_bypass_end;
@@ -1318,7 +1317,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		if (blkg->pd[pol->plid])
 			continue;
 
-		pd = pol->pd_alloc_fn(GFP_NOWAIT | __GFP_NOWARN, q->node);
+		pd = blkg_pol_alloc_pd(pol, GFP_NOWAIT | __GFP_NOWARN, q->node);
 		if (!pd)
 			swap(pd, pd_prealloc);
 		if (!pd) {
@@ -1329,8 +1328,7 @@ int blkcg_activate_policy(struct request_queue *q,
 		blkg->pd[pol->plid] = pd;
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
-		if (pol->pd_init_fn)
-			pol->pd_init_fn(pd);
+		blkg_pol_init_pd(pol, pd);
 	}
 
 	__set_bit(pol->plid, q->blkcg_pols);
@@ -1343,7 +1341,7 @@ int blkcg_activate_policy(struct request_queue *q,
 	else
 		blk_queue_bypass_end(q);
 	if (pd_prealloc)
-		pol->pd_free_fn(pd_prealloc);
+		blkg_pol_free_pd(pol, pd_prealloc);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blkcg_activate_policy);
@@ -1378,9 +1376,8 @@ void blkcg_deactivate_policy(struct request_queue *q,
 		spin_lock(&blkg->blkcg->lock);
 
 		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
-				pol->pd_offline_fn(blkg->pd[pol->plid]);
-			pol->pd_free_fn(blkg->pd[pol->plid]);
+			blkg_pol_offline_pd(pol, blkg->pd[pol->plid]);
+			blkg_pol_free_pd(pol, blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
 		}
 
@@ -1428,14 +1425,14 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
 			struct blkcg_policy_data *cpd;
 
-			cpd = pol->cpd_alloc_fn(GFP_KERNEL);
+			cpd = blkcg_pol_alloc_cpd(pol, GFP_KERNEL);
 			if (!cpd)
 				goto err_free_cpds;
 
 			blkcg->cpd[pol->plid] = cpd;
 			cpd->blkcg = blkcg;
 			cpd->plid = pol->plid;
-			pol->cpd_init_fn(cpd);
+			blkcg_pol_init_cpd(pol, cpd);
 		}
 	}
 
@@ -1455,7 +1452,7 @@ int blkcg_policy_register(struct blkcg_policy *pol)
 	if (pol->cpd_free_fn) {
 		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
 			if (blkcg->cpd[pol->plid]) {
-				pol->cpd_free_fn(blkcg->cpd[pol->plid]);
+				blkcg_pol_free_cpd(pol, blkcg->cpd[pol->plid]);
 				blkcg->cpd[pol->plid] = NULL;
 			}
 		}
@@ -1495,7 +1492,7 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 	if (pol->cpd_free_fn) {
 		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node) {
 			if (blkcg->cpd[pol->plid]) {
-				pol->cpd_free_fn(blkcg->cpd[pol->plid]);
+				blkcg_pol_free_cpd(pol, blkcg->cpd[pol->plid]);
 				blkcg->cpd[pol->plid] = NULL;
 			}
 		}
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index f57e54d..d9d336b 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -167,6 +167,78 @@ struct blkcg_policy {
 	blkcg_pol_reset_pd_stats_fn	*pd_reset_stats_fn;
 };
 
+static inline struct blkcg_policy_data *
+blkcg_pol_alloc_cpd(struct blkcg_policy *pol, gfp_t gfp)
+{
+	if(pol->cpd_alloc_fn)
+		return pol->cpd_alloc_fn(gfp);
+	return NULL;
+}
+
+static inline void
+blkcg_pol_init_cpd(struct blkcg_policy *pol, struct blkcg_policy_data * cpd)
+{
+	if (pol->cpd_init_fn)
+		pol->cpd_init_fn(cpd);
+}
+
+static inline void
+blkcg_pol_free_cpd(struct blkcg_policy *pol, struct blkcg_policy_data * cpd)
+{
+	if (pol->cpd_free_fn)
+		pol->cpd_free_fn(cpd);
+}
+
+static inline void
+blkcg_pol_bind_cpd(struct blkcg_policy *pol, struct blkcg_policy_data * cpd)
+{
+	if (pol->cpd_bind_fn)
+		pol->cpd_bind_fn(cpd);
+}
+
+static inline struct blkg_policy_data *
+blkg_pol_alloc_pd(const struct blkcg_policy *pol, gfp_t gfp, int node)
+{
+	if (pol->pd_alloc_fn)
+		return pol->pd_alloc_fn(gfp, node);
+	return NULL;
+}
+
+static inline void
+blkg_pol_init_pd(const struct blkcg_policy *pol, struct blkg_policy_data *pd)
+{
+	if (pol->pd_init_fn)
+		pol->pd_init_fn(pd);
+}
+
+static inline void
+blkg_pol_online_pd(struct blkcg_policy *pol, struct blkg_policy_data *pd)
+{
+	if (pol->pd_online_fn)
+		pol->pd_online_fn(pd);
+}
+
+static inline void
+blkg_pol_offline_pd(const struct blkcg_policy *pol, struct blkg_policy_data *pd)
+{
+	if (pol->pd_offline_fn)
+		pol->pd_offline_fn(pd);
+}
+
+static inline void
+blkg_pol_free_pd(const struct blkcg_policy *pol, struct blkg_policy_data *pd)
+{
+	if (pol->pd_free_fn)
+		pol->pd_free_fn(pd);
+}
+
+static inline void
+blkg_pol_reset_pd_stats(struct blkcg_policy *pol, struct blkg_policy_data *pd)
+{
+	if (pol->pd_reset_stats_fn)
+		pol->pd_reset_stats_fn(pd);
+}
+
 extern struct blkcg blkcg_root;
 extern struct cgroup_subsys_state * const blkcg_root_css;
 
-- 
2.9.4
