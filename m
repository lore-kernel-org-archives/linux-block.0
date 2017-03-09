Return-Path: <tahsin@google.com>
Return-Path: <tahsin@google.com>
From: Tahsin Erdogan <tahsin@google.com>
To: Tejun Heo <tj@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	David Rientjes <rientjes@google.com>,
	linux-kernel@vger.kernel.org,
	Tahsin Erdogan <tahsin@google.com>
Subject: [PATCH v5] blkcg: allocate struct blkcg_gq outside request queue spinlock
Date: Thu,  9 Mar 2017 00:05:31 -0800
Message-Id: <20170309080531.9048-1-tahsin@google.com>
In-Reply-To: <20170306200319.GF19696@htj.duckdns.org>
References: <20170306200319.GF19696@htj.duckdns.org>
List-ID: <linux-block@vger.kernel.org>

blkg_conf_prep() currently calls blkg_lookup_create() while holding
request queue spinlock. This means allocating memory for struct
blkcg_gq has to be made non-blocking. This causes occasional -ENOMEM
failures in call paths like below:

  pcpu_alloc+0x68f/0x710
  __alloc_percpu_gfp+0xd/0x10
  __percpu_counter_init+0x55/0xc0
  cfq_pd_alloc+0x3b2/0x4e0
  blkg_alloc+0x187/0x230
  blkg_create+0x489/0x670
  blkg_lookup_create+0x9a/0x230
  blkg_conf_prep+0x1fb/0x240
  __cfqg_set_weight_device.isra.105+0x5c/0x180
  cfq_set_weight_on_dfl+0x69/0xc0
  cgroup_file_write+0x39/0x1c0
  kernfs_fop_write+0x13f/0x1d0
  __vfs_write+0x23/0x120
  vfs_write+0xc2/0x1f0
  SyS_write+0x44/0xb0
  entry_SYSCALL_64_fastpath+0x18/0xad

In the code path above, percpu allocator cannot call vmalloc() due to
queue spinlock.

A failure in this call path gives grief to tools which are trying to
configure io weights. We see occasional failures happen shortly after
reboots even when system is not under any memory pressure. Machines
with a lot of cpus are more vulnerable to this condition.

Update blkg_create() function to temporarily drop the rcu and queue
locks when it is allowed by gfp mask.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tahsin Erdogan <tahsin@google.com>
---
v5:
  Removed stale blkg_alloc() in blkcg_init_queue()

  Pushed down radix_tree_preload() into blkg_create() because it
  disables preemption on return and makes it unsafe to call blocking
  memory allocations.

v4:
  Simplified error checking in blkg_create()
  Factored out __blkg_lookup_create()

v3:
  Pushed down all blkg allocations into blkg_create()

v2:
  Moved blkg creation into blkg_lookup_create() to avoid duplicating
  blkg_lookup_create() logic.

 block/blk-cgroup.c         | 138 ++++++++++++++++++++++++++++-----------------
 include/linux/blk-cgroup.h |   6 +-
 2 files changed, 91 insertions(+), 53 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bbe7ee00bd3d..bdf87f0c1b1b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -165,16 +165,18 @@ struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 EXPORT_SYMBOL_GPL(blkg_lookup_slowpath);
 
 /*
- * If @new_blkg is %NULL, this function tries to allocate a new one as
- * necessary using %GFP_NOWAIT.  @new_blkg is always consumed on return.
+ * If gfp mask allows blocking, this function temporarily drops rcu and queue
+ * locks to allocate memory.
  */
 static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
-				    struct request_queue *q,
-				    struct blkcg_gq *new_blkg)
+				    struct request_queue *q, gfp_t gfp,
+				    const struct blkcg_policy *pol)
 {
-	struct blkcg_gq *blkg;
+	struct blkcg_gq *blkg = NULL;
 	struct bdi_writeback_congested *wb_congested;
 	int i, ret;
+	const bool drop_locks = gfpflags_allow_blocking(gfp);
+	bool preloaded = false;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	lockdep_assert_held(q->queue_lock);
@@ -185,31 +187,53 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 		goto err_free_blkg;
 	}
 
+	if (drop_locks) {
+		spin_unlock_irq(q->queue_lock);
+		rcu_read_unlock();
+	}
+
 	wb_congested = wb_congested_get_create(q->backing_dev_info,
-					       blkcg->css.id,
-					       GFP_NOWAIT | __GFP_NOWARN);
-	if (!wb_congested) {
+					       blkcg->css.id, gfp);
+	blkg = blkg_alloc(blkcg, q, gfp);
+
+	if (drop_locks) {
+		preloaded = !radix_tree_preload(gfp);
+		rcu_read_lock();
+		spin_lock_irq(q->queue_lock);
+	}
+
+	if (unlikely(!wb_congested || !blkg)) {
 		ret = -ENOMEM;
-		goto err_put_css;
+		goto err_put;
 	}
 
-	/* allocate */
-	if (!new_blkg) {
-		new_blkg = blkg_alloc(blkcg, q, GFP_NOWAIT | __GFP_NOWARN);
-		if (unlikely(!new_blkg)) {
-			ret = -ENOMEM;
-			goto err_put_congested;
+	blkg->wb_congested = wb_congested;
+
+	if (pol) {
+		WARN_ON(!drop_locks);
+
+		if (!blkcg_policy_enabled(q, pol)) {
+			ret = -EOPNOTSUPP;
+			goto err_put;
+		}
+
+		/*
+		 * This could be the first entry point of blkcg implementation
+		 * and we shouldn't allow anything to go through for a bypassing
+		 * queue.
+		 */
+		if (unlikely(blk_queue_bypass(q))) {
+			ret = blk_queue_dying(q) ? -ENODEV : -EBUSY;
+			goto err_put;
 		}
 	}
-	blkg = new_blkg;
-	blkg->wb_congested = wb_congested;
 
 	/* link parent */
 	if (blkcg_parent(blkcg)) {
 		blkg->parent = __blkg_lookup(blkcg_parent(blkcg), q, false);
 		if (WARN_ON_ONCE(!blkg->parent)) {
 			ret = -ENODEV;
-			goto err_put_congested;
+			goto err_put;
 		}
 		blkg_get(blkg->parent);
 	}
@@ -236,6 +260,9 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 				pol->pd_online_fn(blkg->pd[i]);
 		}
 	}
+
+	if (preloaded)
+		radix_tree_preload_end();
 	blkg->online = true;
 	spin_unlock(&blkcg->lock);
 
@@ -246,44 +273,45 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 	blkg_put(blkg);
 	return ERR_PTR(ret);
 
-err_put_congested:
-	wb_congested_put(wb_congested);
-err_put_css:
+err_put:
+	if (preloaded)
+		radix_tree_preload_end();
+	if (wb_congested)
+		wb_congested_put(wb_congested);
 	css_put(&blkcg->css);
 err_free_blkg:
-	blkg_free(new_blkg);
+	blkg_free(blkg);
 	return ERR_PTR(ret);
 }
 
 /**
- * blkg_lookup_create - lookup blkg, try to create one if not there
+ * __blkg_lookup_create - lookup blkg, try to create one if not there
  * @blkcg: blkcg of interest
  * @q: request_queue of interest
+ * @gfp: gfp mask
+ * @pol: blkcg policy (optional)
  *
  * Lookup blkg for the @blkcg - @q pair.  If it doesn't exist, try to
  * create one.  blkg creation is performed recursively from blkcg_root such
  * that all non-root blkg's have access to the parent blkg.  This function
  * should be called under RCU read lock and @q->queue_lock.
  *
+ * When gfp mask allows blocking, rcu and queue locks may be dropped for
+ * allocating memory. In this case, the locks will be reacquired on return.
+ *
  * Returns pointer to the looked up or created blkg on success, ERR_PTR()
  * value on error.  If @q is dead, returns ERR_PTR(-EINVAL).  If @q is not
  * dead and bypassing, returns ERR_PTR(-EBUSY).
  */
-struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-				    struct request_queue *q)
+struct blkcg_gq *__blkg_lookup_create(struct blkcg *blkcg,
+				      struct request_queue *q, gfp_t gfp,
+				      const struct blkcg_policy *pol)
 {
 	struct blkcg_gq *blkg;
 
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	lockdep_assert_held(q->queue_lock);
 
-	/*
-	 * This could be the first entry point of blkcg implementation and
-	 * we shouldn't allow anything to go through for a bypassing queue.
-	 */
-	if (unlikely(blk_queue_bypass(q)))
-		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
-
 	blkg = __blkg_lookup(blkcg, q, true);
 	if (blkg)
 		return blkg;
@@ -301,12 +329,35 @@ struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
 			parent = blkcg_parent(parent);
 		}
 
-		blkg = blkg_create(pos, q, NULL);
+		blkg = blkg_create(pos, q, gfp, pol);
 		if (pos == blkcg || IS_ERR(blkg))
 			return blkg;
 	}
 }
 
+/**
+ * blkg_lookup_create - lookup blkg, try to create one if not there
+ *
+ * Performs an initial queue bypass check and then passes control to
+ * __blkg_lookup_create().
+ */
+struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
+				    struct request_queue *q, gfp_t gfp,
+				    const struct blkcg_policy *pol)
+{
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	lockdep_assert_held(q->queue_lock);
+
+	/*
+	 * This could be the first entry point of blkcg implementation and
+	 * we shouldn't allow anything to go through for a bypassing queue.
+	 */
+	if (unlikely(blk_queue_bypass(q)))
+		return ERR_PTR(blk_queue_dying(q) ? -ENODEV : -EBUSY);
+
+	return __blkg_lookup_create(blkcg, q, gfp, pol);
+}
+
 static void blkg_destroy(struct blkcg_gq *blkg)
 {
 	struct blkcg *blkcg = blkg->blkcg;
@@ -817,7 +868,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	spin_lock_irq(disk->queue->queue_lock);
 
 	if (blkcg_policy_enabled(disk->queue, pol))
-		blkg = blkg_lookup_create(blkcg, disk->queue);
+		blkg = blkg_lookup_create(blkcg, disk->queue, GFP_KERNEL, pol);
 	else
 		blkg = ERR_PTR(-EOPNOTSUPP);
 
@@ -1056,30 +1107,15 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
  */
 int blkcg_init_queue(struct request_queue *q)
 {
-	struct blkcg_gq *new_blkg, *blkg;
-	bool preloaded;
+	struct blkcg_gq *blkg;
 	int ret;
 
-	new_blkg = blkg_alloc(&blkcg_root, q, GFP_KERNEL);
-	if (!new_blkg)
-		return -ENOMEM;
-
-	preloaded = !radix_tree_preload(GFP_KERNEL);
-
-	/*
-	 * Make sure the root blkg exists and count the existing blkgs.  As
-	 * @q is bypassing at this point, blkg_lookup_create() can't be
-	 * used.  Open code insertion.
-	 */
 	rcu_read_lock();
 	spin_lock_irq(q->queue_lock);
-	blkg = blkg_create(&blkcg_root, q, new_blkg);
+	blkg = __blkg_lookup_create(&blkcg_root, q, GFP_KERNEL, NULL);
 	spin_unlock_irq(q->queue_lock);
 	rcu_read_unlock();
 
-	if (preloaded)
-		radix_tree_preload_end();
-
 	if (IS_ERR(blkg))
 		return PTR_ERR(blkg);
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 01b62e7bac74..955903a8f6cb 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -172,7 +172,8 @@ extern struct cgroup_subsys_state * const blkcg_root_css;
 struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 				      struct request_queue *q, bool update_hint);
 struct blkcg_gq *blkg_lookup_create(struct blkcg *blkcg,
-				    struct request_queue *q);
+				    struct request_queue *q, gfp_t gfp,
+				    const struct blkcg_policy *pol);
 int blkcg_init_queue(struct request_queue *q);
 void blkcg_drain_queue(struct request_queue *q);
 void blkcg_exit_queue(struct request_queue *q);
@@ -694,7 +695,8 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 	blkg = blkg_lookup(blkcg, q);
 	if (unlikely(!blkg)) {
 		spin_lock_irq(q->queue_lock);
-		blkg = blkg_lookup_create(blkcg, q);
+		blkg = blkg_lookup_create(blkcg, q, GFP_NOWAIT | __GFP_NOWARN,
+					  NULL);
 		if (IS_ERR(blkg))
 			blkg = NULL;
 		spin_unlock_irq(q->queue_lock);
-- 
2.12.0.246.ga2ecc84866-goog
