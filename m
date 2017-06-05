Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block, bfq: access and cache blkg data only when safe
Date: Mon,  5 Jun 2017 10:11:15 +0200
Message-Id: <20170605081115.3402-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

In blk-cgroup, operations on blkg objects are protected with the
request_queue lock. This is no more the lock that protects
I/O-scheduler operations in blk-mq. In fact, the latter are now
protected with a finer-grained per-scheduler-instance lock. As a
consequence, although blkg lookups are also rcu-protected, blk-mq I/O
schedulers may see inconsistent data when they access blkg and
blkg-related objects. BFQ does access these objects, and does incur
this problem, in the following case.

The blkg_lookup performed in bfq_get_queue, being protected (only)
through rcu, may happen to return the address of a copy of the
original blkg. If this is the case, then the blkg_get performed in
bfq_get_queue, to pin down the blkg, is useless: it does not prevent
blk-cgroup code from destroying both the original blkg and all objects
directly or indirectly referred by the copy of the blkg. BFQ accesses
these objects, which typically causes a crash for NULL-pointer
dereference of memory-protection violation.

Some additional protection mechanism should be added to blk-cgroup to
address this issue. In the meantime, this commit provides a quick
temporary fix for BFQ: cache (when safe) blkg data that might
disappear right after a blkg_lookup.

In particular, this commit exploits the following facts to achieve its
goal without introducing further locks.  Destroy operations on a blkg
invoke, as a first step, hooks of the scheduler associated with the
blkg. And these hooks are executed with bfqd->lock held for BFQ. As a
consequence, for any blkg associated with the request queue an
instance of BFQ is attached to, we are guaranteed that such a blkg is
not destroyed, and that all the pointers it contains are consistent,
while that instance is holding its bfqd->lock. A blkg_lookup performed
with bfqd->lock held then returns a fully consistent blkg, which
remains consistent until this lock is held. In more detail, this holds
even if the returned blkg is a copy of the original one.

Finally, also the object describing a group inside BFQ needs to be
protected from destruction on the blkg_free of the original blkg
(which invokes bfq_pd_free). This commit adds private refcounting for
this object, to let it disappear only after no bfq_queue refers to it
any longer.

This commit also removes or updates some stale comments on locking
issues related to blk-cgroup operations.

Reported-by: Tomas Konir <tomas.konir@gmail.com>
Reported-by: Lee Tibbert <lee.tibbert@gmail.com>
Reported-by: Marco Piazza <mpiazza@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Tested-by: Tomas Konir <tomas.konir@gmail.com>
Tested-by: Lee Tibbert <lee.tibbert@gmail.com>
Tested-by: Marco Piazza <mpiazza@gmail.com>
---
 block/bfq-cgroup.c  | 116 +++++++++++++++++++++++++++++++++++++++++-----------
 block/bfq-iosched.c |   2 +-
 block/bfq-iosched.h |  23 +++++------
 3 files changed, 105 insertions(+), 36 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c8a32fb..78b2e0d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -52,7 +52,7 @@ BFQG_FLAG_FNS(idling)
 BFQG_FLAG_FNS(empty)
 #undef BFQG_FLAG_FNS
 
-/* This should be called with the queue_lock held. */
+/* This should be called with the scheduler lock held. */
 static void bfqg_stats_update_group_wait_time(struct bfqg_stats *stats)
 {
 	unsigned long long now;
@@ -67,7 +67,7 @@ static void bfqg_stats_update_group_wait_time(struct bfqg_stats *stats)
 	bfqg_stats_clear_waiting(stats);
 }
 
-/* This should be called with the queue_lock held. */
+/* This should be called with the scheduler lock held. */
 static void bfqg_stats_set_start_group_wait_time(struct bfq_group *bfqg,
 						 struct bfq_group *curr_bfqg)
 {
@@ -81,7 +81,7 @@ static void bfqg_stats_set_start_group_wait_time(struct bfq_group *bfqg,
 	bfqg_stats_mark_waiting(stats);
 }
 
-/* This should be called with the queue_lock held. */
+/* This should be called with the scheduler lock held. */
 static void bfqg_stats_end_empty_time(struct bfqg_stats *stats)
 {
 	unsigned long long now;
@@ -203,12 +203,30 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 
 static void bfqg_get(struct bfq_group *bfqg)
 {
-	return blkg_get(bfqg_to_blkg(bfqg));
+	bfqg->ref++;
 }
 
 void bfqg_put(struct bfq_group *bfqg)
 {
-	return blkg_put(bfqg_to_blkg(bfqg));
+	bfqg->ref--;
+
+	if (bfqg->ref == 0)
+		kfree(bfqg);
+}
+
+static void bfqg_and_blkg_get(struct bfq_group *bfqg)
+{
+	/* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
+	bfqg_get(bfqg);
+
+	blkg_get(bfqg_to_blkg(bfqg));
+}
+
+void bfqg_and_blkg_put(struct bfq_group *bfqg)
+{
+	bfqg_put(bfqg);
+
+	blkg_put(bfqg_to_blkg(bfqg));
 }
 
 void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
@@ -312,7 +330,11 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
 	if (bfqq) {
 		bfqq->ioprio = bfqq->new_ioprio;
 		bfqq->ioprio_class = bfqq->new_ioprio_class;
-		bfqg_get(bfqg);
+		/*
+		 * Make sure that bfqg and its associated blkg do not
+		 * disappear before entity.
+		 */
+		bfqg_and_blkg_get(bfqg);
 	}
 	entity->parent = bfqg->my_entity; /* NULL for root group */
 	entity->sched_data = &bfqg->sched_data;
@@ -399,6 +421,8 @@ struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, int node)
 		return NULL;
 	}
 
+	/* see comments in bfq_bic_update_cgroup for why refcounting */
+	bfqg_get(bfqg);
 	return &bfqg->pd;
 }
 
@@ -426,7 +450,7 @@ void bfq_pd_free(struct blkg_policy_data *pd)
 	struct bfq_group *bfqg = pd_to_bfqg(pd);
 
 	bfqg_stats_exit(&bfqg->stats);
-	return kfree(bfqg);
+	bfqg_put(bfqg);
 }
 
 void bfq_pd_reset_stats(struct blkg_policy_data *pd)
@@ -496,9 +520,10 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
  * Move @bfqq to @bfqg, deactivating it from its old group and reactivating
  * it on the new one.  Avoid putting the entity on the old group idle tree.
  *
- * Must be called under the queue lock; the cgroup owning @bfqg must
- * not disappear (by now this just means that we are called under
- * rcu_read_lock()).
+ * Must be called under the scheduler lock, to make sure that the blkg
+ * owning @bfqg does not disappear (see comments in
+ * bfq_bic_update_cgroup on guaranteeing the consistency of blkg
+ * objects).
  */
 void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		   struct bfq_group *bfqg)
@@ -519,16 +544,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st)
 		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
-	bfqg_put(bfqq_group(bfqq));
+	bfqg_and_blkg_put(bfqq_group(bfqq));
 
-	/*
-	 * Here we use a reference to bfqg.  We don't need a refcounter
-	 * as the cgroup reference will not be dropped, so that its
-	 * destroy() callback will not be invoked.
-	 */
 	entity->parent = bfqg->my_entity;
 	entity->sched_data = &bfqg->sched_data;
-	bfqg_get(bfqg);
+	/* pin down bfqg and its associated blkg  */
+	bfqg_and_blkg_get(bfqg);
 
 	if (bfq_bfqq_busy(bfqq)) {
 		bfq_pos_tree_add_move(bfqd, bfqq);
@@ -545,8 +566,9 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
  * @bic: the bic to move.
  * @blkcg: the blk-cgroup to move to.
  *
- * Move bic to blkcg, assuming that bfqd->queue is locked; the caller
- * has to make sure that the reference to cgroup is valid across the call.
+ * Move bic to blkcg, assuming that bfqd->lock is held; which makes
+ * sure that the reference to cgroup is valid across the call (see
+ * comments in bfq_bic_update_cgroup on this issue)
  *
  * NOTE: an alternative approach might have been to store the current
  * cgroup in bfqq and getting a reference to it, reducing the lookup
@@ -604,6 +626,57 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 		goto out;
 
 	bfqg = __bfq_bic_change_cgroup(bfqd, bic, bio_blkcg(bio));
+	/*
+	 * Update blkg_path for bfq_log_* functions. We cache this
+	 * path, and update it here, for the following
+	 * reasons. Operations on blkg objects in blk-cgroup are
+	 * protected with the request_queue lock, and not with the
+	 * lock that protects the instances of this scheduler
+	 * (bfqd->lock). This exposes BFQ to the following sort of
+	 * race.
+	 *
+	 * The blkg_lookup performed in bfq_get_queue, protected
+	 * through rcu, may happen to return the address of a copy of
+	 * the original blkg. If this is the case, then the
+	 * bfqg_and_blkg_get performed in bfq_get_queue, to pin down
+	 * the blkg, is useless: it does not prevent blk-cgroup code
+	 * from destroying both the original blkg and all objects
+	 * directly or indirectly referred by the copy of the
+	 * blkg.
+	 *
+	 * On the bright side, destroy operations on a blkg invoke, as
+	 * a first step, hooks of the scheduler associated with the
+	 * blkg. And these hooks are executed with bfqd->lock held for
+	 * BFQ. As a consequence, for any blkg associated with the
+	 * request queue this instance of the scheduler is attached
+	 * to, we are guaranteed that such a blkg is not destroyed, and
+	 * that all the pointers it contains are consistent, while we
+	 * are holding bfqd->lock. A blkg_lookup performed with
+	 * bfqd->lock held then returns a fully consistent blkg, which
+	 * remains consistent until this lock is held.
+	 *
+	 * Thanks to the last fact, and to the fact that: (1) bfqg has
+	 * been obtained through a blkg_lookup in the above
+	 * assignment, and (2) bfqd->lock is being held, here we can
+	 * safely use the policy data for the involved blkg (i.e., the
+	 * field bfqg->pd) to get to the blkg associated with bfqg,
+	 * and then we can safely use any field of blkg. After we
+	 * release bfqd->lock, even just getting blkg through this
+	 * bfqg may cause dangling references to be traversed, as
+	 * bfqg->pd may not exist any more.
+	 *
+	 * In view of the above facts, here we cache, in the bfqg, any
+	 * blkg data we may need for this bic, and for its associated
+	 * bfq_queue. As of now, we need to cache only the path of the
+	 * blkg, which is used in the bfq_log_* functions.
+	 *
+	 * Finally, note that bfqg itself needs to be protected from
+	 * destruction on the blkg_free of the original blkg (which
+	 * invokes bfq_pd_free). We use an additional private
+	 * refcounter for bfqg, to let it disappear only after no
+	 * bfq_queue refers to it any longer.
+	 */
+	blkg_path(bfqg_to_blkg(bfqg), bfqg->blkg_path, sizeof(bfqg->blkg_path));
 	bic->blkcg_serial_nr = serial_nr;
 out:
 	rcu_read_unlock();
@@ -640,8 +713,6 @@ static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
  * @bfqd: the device data structure with the root group.
  * @bfqg: the group to move from.
  * @st: the service tree with the entities.
- *
- * Needs queue_lock to be taken and reference to be valid over the call.
  */
 static void bfq_reparent_active_entities(struct bfq_data *bfqd,
 					 struct bfq_group *bfqg,
@@ -692,8 +763,7 @@ void bfq_pd_offline(struct blkg_policy_data *pd)
 		/*
 		 * The idle tree may still contain bfq_queues belonging
 		 * to exited task because they never migrated to a different
-		 * cgroup from the one being destroyed now.  No one else
-		 * can access them so it's safe to act without any lock.
+		 * cgroup from the one being destroyed now.
 		 */
 		bfq_flush_idle_tree(st);
 
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 08ce450..ed93da2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3665,7 +3665,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 
 	kmem_cache_free(bfq_pool, bfqq);
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
-	bfqg_put(bfqg);
+	bfqg_and_blkg_put(bfqg);
 #endif
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index ae783c0..5c3bf98 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -759,6 +759,12 @@ struct bfq_group {
 	/* must be the first member */
 	struct blkg_policy_data pd;
 
+	/* cached path for this blkg (see comments in bfq_bic_update_cgroup) */
+	char blkg_path[128];
+
+	/* reference counter (see comments in bfq_bic_update_cgroup) */
+	int ref;
+
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
@@ -838,7 +844,7 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
-void bfqg_put(struct bfq_group *bfqg);
+void bfqg_and_blkg_put(struct bfq_group *bfqg);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 extern struct cftype bfq_blkcg_legacy_files[];
@@ -910,20 +916,13 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
-	char __pbuf[128];						\
-									\
-	blkg_path(bfqg_to_blkg(bfqq_group(bfqq)), __pbuf, sizeof(__pbuf)); \
-	blk_add_trace_msg((bfqd)->queue, "bfq%d%c %s " fmt, (bfqq)->pid, \
+	blk_add_trace_msg((bfqd)->queue, "bfq%d%c %s " fmt, (bfqq)->pid,\
 			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
-			  __pbuf, ##args);				\
+			bfqq_group(bfqq)->blkg_path, ##args);		\
 } while (0)
 
-#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)	do {			\
-	char __pbuf[128];						\
-									\
-	blkg_path(bfqg_to_blkg(bfqg), __pbuf, sizeof(__pbuf));		\
-	blk_add_trace_msg((bfqd)->queue, "%s " fmt, __pbuf, ##args);	\
-} while (0)
+#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)	\
+	blk_add_trace_msg((bfqd)->queue, "%s " fmt, (bfqg)->blkg_path, ##args)
 
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
-- 
2.10.0
