Return-Path: <joseph.qi@linux.alibaba.com>
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: xuejiufei <jiufei.xue@linux.alibaba.com>,
 Caspar Zhang <caspar@linux.alibaba.com>,
 linux-block <linux-block@vger.kernel.org>, cgroups@vger.kernel.org
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v4] blk-throttle: fix race between blkcg_bio_issue_check() and
 cgroup_rmdir()
Message-ID: <634e5db5-1479-b317-1435-c4cb169298b9@linux.alibaba.com>
Date: Tue, 6 Mar 2018 11:53:32 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

We've triggered a WARNING in blk_throtl_bio() when throttling writeback
io, which complains blkg->refcnt is already 0 when calling blkg_get(),
and then kernel crashes with invalid page request.
After investigating this issue, we've found it is caused by a race
between blkcg_bio_issue_check() and cgroup_rmdir(), which is described
below:

writeback kworker                   cgroup_rmdir
                                      cgroup_destroy_locked
                                        kill_css
                                          css_killed_ref_fn
                                            css_killed_work_fn
                                              offline_css
                                                blkcg_css_offline
  blkcg_bio_issue_check
    rcu_read_lock
    blkg_lookup
                                                  spin_trylock(q->queue_lock)
                                                  blkg_destroy
                                                  spin_unlock(q->queue_lock)
    blk_throtl_bio
    spin_lock_irq(q->queue_lock)
    ...
    spin_unlock_irq(q->queue_lock)
  rcu_read_unlock

Since rcu can only prevent blkg from releasing when it is being used,
the blkg->refcnt can be decreased to 0 during blkg_destroy() and schedule
blkg release.
Then trying to blkg_get() in blk_throtl_bio() will complains the WARNING.
And then the corresponding blkg_put() will schedule blkg release again,
which result in double free.
This race is introduced by commit ae1188963611 ("blkcg: consolidate blkg
creation in blkcg_bio_issue_check()"). Before this commit, it will
lookup first and then try to lookup/create again with queue_lock. Since
revive this logic is a bit drastic, so fix it by only offlining pd during
blkcg_css_offline(), and move the rest destruction (especially
blkg_put()) into blkcg_css_free(), which should be the right way as
discussed.

Fixes: ae1188963611 ("blkcg: consolidate blkg creation in blkcg_bio_issue_check()")
Reported-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc: stable@vger.kernel.org #4.3+
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 block/blk-cgroup.c         | 57 +++++++++++++++++++++++++++++++++++-----------
 include/linux/blk-cgroup.h |  2 ++
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c2033a2..450cefd 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -307,11 +307,27 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 	}
 }
 
+static void blkg_pd_offline(struct blkcg_gq *blkg)
+{
+	int i;
+
+	lockdep_assert_held(blkg->q->queue_lock);
+	lockdep_assert_held(&blkg->blkcg->lock);
+
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (blkg->pd[i] && !blkg->pd_offline[i] && pol->pd_offline_fn) {
+			pol->pd_offline_fn(blkg->pd[i]);
+			blkg->pd_offline[i] = true;
+		}
+	}
+}
+
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
 	struct blkcg_gq *parent = blkg->parent;
-	int i;
 
 	lockdep_assert_held(blkg->q->queue_lock);
 	lockdep_assert_held(&blkcg->lock);
@@ -320,13 +336,6 @@ static void blkg_destroy(struct blkcg_gq *blkg)
 	WARN_ON_ONCE(list_empty(&blkg->q_node));
 	WARN_ON_ONCE(hlist_unhashed(&blkg->blkcg_node));
 
-	for (i = 0; i < BLKCG_MAX_POLS; i++) {
-		struct blkcg_policy *pol = blkcg_policy[i];
-
-		if (blkg->pd[i] && pol->pd_offline_fn)
-			pol->pd_offline_fn(blkg->pd[i]);
-	}
-
 	if (parent) {
 		blkg_rwstat_add_aux(&parent->stat_bytes, &blkg->stat_bytes);
 		blkg_rwstat_add_aux(&parent->stat_ios, &blkg->stat_ios);
@@ -369,6 +378,7 @@ static void blkg_destroy_all(struct request_queue *q)
 		struct blkcg *blkcg = blkg->blkcg;
 
 		spin_lock(&blkcg->lock);
+		blkg_pd_offline(blkg);
 		blkg_destroy(blkg);
 		spin_unlock(&blkcg->lock);
 	}
@@ -1004,16 +1014,15 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 static void blkcg_css_offline(struct cgroup_subsys_state *css)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
+	struct blkcg_gq *blkg;
 
 	spin_lock_irq(&blkcg->lock);
 
-	while (!hlist_empty(&blkcg->blkg_list)) {
-		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
-						struct blkcg_gq, blkcg_node);
+	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
 		struct request_queue *q = blkg->q;
 
 		if (spin_trylock(q->queue_lock)) {
-			blkg_destroy(blkg);
+			blkg_pd_offline(blkg);
 			spin_unlock(q->queue_lock);
 		} else {
 			spin_unlock_irq(&blkcg->lock);
@@ -1032,6 +1041,26 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
 	struct blkcg *blkcg = css_to_blkcg(css);
 	int i;
 
+	spin_lock_irq(&blkcg->lock);
+
+	while (!hlist_empty(&blkcg->blkg_list)) {
+		struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
+						    struct blkcg_gq,
+						    blkcg_node);
+		struct request_queue *q = blkg->q;
+
+		if (spin_trylock(q->queue_lock)) {
+			blkg_destroy(blkg);
+			spin_unlock(q->queue_lock);
+		} else {
+			spin_unlock_irq(&blkcg->lock);
+			cpu_relax();
+			spin_lock_irq(&blkcg->lock);
+		}
+	}
+
+	spin_unlock_irq(&blkcg->lock);
+
 	mutex_lock(&blkcg_pol_mutex);
 
 	list_del(&blkcg->all_blkcgs_node);
@@ -1371,8 +1400,10 @@ void blkcg_deactivate_policy(struct request_queue *q,
 		spin_lock(&blkg->blkcg->lock);
 
 		if (blkg->pd[pol->plid]) {
-			if (pol->pd_offline_fn)
+			if (!blkg->pd_offline[pol->plid] && pol->pd_offline_fn) {
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
+				blkg->pd_offline[pol->plid] = true;
+			}
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
 		}
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 69bea82..ad5e2cb 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -133,6 +133,8 @@ struct blkcg_gq {
 	struct blkg_rwstat		stat_ios;
 
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
+	/* is the corresponding policy data offline? */
+	bool				pd_offline[BLKCG_MAX_POLS];
 
 	struct rcu_head			rcu_head;
 };
-- 
1.8.3.1
