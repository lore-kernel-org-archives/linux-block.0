Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX] block, bfq: access and cache blkg data only when safe
Date: Fri, 19 May 2017 10:39:08 +0200
Message-Id: <20170519083908.2588-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Operations on blkg objects in blk-cgroup are protected with the
request_queue lock, which is no more the lock that protects
I/O-scheduler operations in blk-mq. The latter are now protected with
finer-grained per-scheduler-instance locks. As a consequence, if blkg
and blkg-related objects are accessed in a blk-mq I/O scheduler, it is
possible to have races, unless proper care is taken for these
accesses. BFQ does access these objects, and does incur these races.

This commit addresses this issue without introducing further locks, by
exploiting the following facts.  Destroy operations on a blkg invoke,
as a first step, hooks of the scheduler associated with the blkg. And
these hooks are executed with bfqd->lock held for BFQ. As a
consequence, for any blkg associated with the request queue an
instance of BFQ is attached to, we are guaranteed that such a blkg is
not destroyed and that all the pointers it contains are consistent,
(only) while that instance is holding its bfqd->lock. A blkg_lookup
performed with bfqd->lock held then returns a fully consistent blkg,
which remains consistent until this lock is held.

In view of these facts, this commit caches any needed blkg data (only)
when it (safely) detects a parent-blkg change for an internal entity,
and, to cache these data safely, it gets the new blkg, through a
blkg_lookup, and copies data while keeping the bfqd->lock held. As of
now, BFQ needs to cache only the path of the blkg, which is used in
the bfq_log_* functions.

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
 block/bfq-cgroup.c  | 56 +++++++++++++++++++++++++++++++++++++++++------------
 block/bfq-iosched.h | 18 +++++++----------
 2 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c8a32fb..06195ff 100644
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
@@ -496,9 +496,10 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
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
@@ -545,8 +546,9 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
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
@@ -604,6 +606,39 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
 		goto out;
 
 	bfqg = __bfq_bic_change_cgroup(bfqd, bic, bio_blkcg(bio));
+	/*
+	 * Update blkg_path for bfq_log_* functions. We cache this
+	 * path, and update it here, for the following
+	 * reasons. Operations on blkg objects in blk-cgroup are
+	 * protected with the request_queue lock, and not with the
+	 * lock that protects the instances of this scheduler
+	 * (bfqd->lock). However, destroy operations on a blkg invoke,
+	 * as a first step, hooks of the scheduler associated with the
+	 * blkg. And these hooks are executed with bfqd->lock held for
+	 * BFQ. As a consequence, for any blkg associated with the
+	 * request queue this instance of the scheduler is attached
+	 * to, we are guaranteed that such a blkg is not destroyed and
+	 * that all the pointers it contains are consistent, (only)
+	 * while we are holding bfqd->lock. A blkg_lookup performed
+	 * with bfqd->lock held then returns a fully consistent blkg,
+	 * which remains consistent until this lock is held.
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
+	 * In view of the above facts, here we cache any blkg data we
+	 * may need for this bic, and for its associated bfq_queue. As
+	 * of now, we need to cache only the path of the blkg, which
+	 * is used in the bfq_log_* functions.
+	*/
+	blkg_path(bfqg_to_blkg(bfqg), bfqg->blkg_path, sizeof(bfqg->blkg_path));
 	bic->blkcg_serial_nr = serial_nr;
 out:
 	rcu_read_unlock();
@@ -640,8 +675,6 @@ static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
  * @bfqd: the device data structure with the root group.
  * @bfqg: the group to move from.
  * @st: the service tree with the entities.
- *
- * Needs queue_lock to be taken and reference to be valid over the call.
  */
 static void bfq_reparent_active_entities(struct bfq_data *bfqd,
 					 struct bfq_group *bfqg,
@@ -692,8 +725,7 @@ void bfq_pd_offline(struct blkg_policy_data *pd)
 		/*
 		 * The idle tree may still contain bfq_queues belonging
 		 * to exited task because they never migrated to a different
-		 * cgroup from the one being destroyed now.  No one else
-		 * can access them so it's safe to act without any lock.
++                * cgroup from the one being destroyed now.
 		 */
 		bfq_flush_idle_tree(st);
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index ae783c0..64dfee7 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -759,6 +759,9 @@ struct bfq_group {
 	/* must be the first member */
 	struct blkg_policy_data pd;
 
+	/* cached path for this blkg (see comments in bfq_bic_update_cgroup) */
+	char blkg_path[128];
+
 	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
@@ -910,20 +913,13 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
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
+#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)				    \
+	blk_add_trace_msg((bfqd)->queue, "%s " fmt, bfqg->blkg_path, ##args)
 
 #else /* CONFIG_BFQ_GROUP_IOSCHED */
 
-- 
2.10.0
