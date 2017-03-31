Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 02/16] block, bfq: add full hierarchical scheduling and cgroups support
Date: Fri, 31 Mar 2017 14:47:29 +0200
Message-Id: <20170331124743.3530-3-paolo.valente@linaro.org>
In-Reply-To: <20170331124743.3530-1-paolo.valente@linaro.org>
References: <20170331124743.3530-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Arianna Avanzini <avanzini.arianna@gmail.com>

Add complete support for full hierarchical scheduling, with a cgroups
interface. Full hierarchical scheduling is implemented through the
'entity' abstraction: both bfq_queues, i.e., the internal BFQ queues
associated with processes, and groups are represented in general by
entities. Given the bfq_queues associated with the processes belonging
to a given group, the entities representing these queues are sons of
the entity representing the group. At higher levels, if a group, say
G, contains other groups, then the entity representing G is the parent
entity of the entities representing the groups in G.

Hierarchical scheduling is performed as follows: if the timestamps of
a leaf entity (i.e., of a bfq_queue) change, and such a change lets
the entity become the next-to-serve entity for its parent entity, then
the timestamps of the parent entity are recomputed as a function of
the budget of its new next-to-serve leaf entity. If the parent entity
belongs, in its turn, to a group, and its new timestamps let it become
the next-to-serve for its parent entity, then the timestamps of the
latter parent entity are recomputed as well, and so on. When a new
bfq_queue must be set in service, the reverse path is followed: the
next-to-serve highest-level entity is chosen, then its next-to-serve
child entity, and so on, until the next-to-serve leaf entity is
reached, and the bfq_queue that this entity represents is set in
service.

Writeback is accounted for on a per-group basis, i.e., for each group,
the async I/O requests of the processes of the group are enqueued in a
distinct bfq_queue, and the entity associated with this queue is a
child of the entity associated with the group.

Weights can be assigned explicitly to groups and processes through the
cgroups interface, differently from what happens, for single
processes, if the cgroups interface is not used (as explained in the
description of the previous patch). In particular, since each node has
a full scheduler, each group can be assigned its own weight.

Signed-off-by: Fabio Checconi <fchecconi@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 Documentation/block/bfq-iosched.txt |   17 +-
 block/Kconfig.iosched               |   10 +
 block/bfq-iosched.c                 | 2568 ++++++++++++++++++++++++++++++-----
 include/linux/blkdev.h              |    2 +-
 4 files changed, 2213 insertions(+), 384 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index cbf85f6f..461b27f 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -253,9 +253,14 @@ of slice_idle are copied from CFQ too.
 per-process ioprio and weight
 -----------------------------
 
-Unless the cgroups interface is used, weights can be assigned to
-processes only indirectly, through I/O priorities, and according to
-the relation: weight = (IOPRIO_BE_NR - ioprio) * 10.
+Unless the cgroups interface is used (see "4. BFQ group scheduling"),
+weights can be assigned to processes only indirectly, through I/O
+priorities, and according to the relation:
+weight = (IOPRIO_BE_NR - ioprio) * 10.
+
+Beware that, if low-latency is set, then BFQ automatically raises the
+weight of the queues associated with interactive and soft real-time
+applications. Unset this tunable if you need/want to control weights.
 
 slice_idle
 ----------
@@ -450,9 +455,9 @@ may be reactivated for an already busy async queue (in ms).
 4. Group scheduling with BFQ
 ============================
 
-BFQ supports both cgroup-v1 and cgroup-v2 io controllers, namely blkio
-and io. In particular, BFQ supports weight-based proportional
-share.
+BFQ supports both cgroups-v1 and cgroups-v2 io controllers, namely
+blkio and io. In particular, BFQ supports weight-based proportional
+share. To activate cgroups support, set BFQ_GROUP_IOSCHED.
 
 4-1 Service guarantees provided
 -------------------------------
diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 562e30e..a37cd03 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -40,6 +40,7 @@ config CFQ_GROUP_IOSCHED
 	  Enable group IO scheduling in CFQ.
 
 choice
+
 	prompt "Default I/O scheduler"
 	default DEFAULT_CFQ
 	help
@@ -80,6 +81,15 @@ config IOSCHED_BFQ
 	real-time applications.  Details in
 	Documentation/block/bfq-iosched.txt
 
+config BFQ_GROUP_IOSCHED
+       bool "BFQ hierarchical scheduling support"
+       depends on IOSCHED_BFQ && BLK_CGROUP
+       default n
+       ---help---
+
+       Enable hierarchical scheduling in BFQ, using the blkio
+       (cgroups-v1) or io (cgroups-v2) controller.
+
 endmenu
 
 endif
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 38f9411..5b0d693 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -90,6 +90,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/cgroup.h>
 #include <linux/elevator.h>
 #include <linux/ktime.h>
 #include <linux/rbtree.h>
@@ -114,7 +115,7 @@
 
 #define BFQ_DEFAULT_QUEUE_IOPRIO	4
 
-#define BFQ_DEFAULT_GRP_WEIGHT	10
+#define BFQ_WEIGHT_LEGACY_DFL	100
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
@@ -149,10 +150,11 @@ struct bfq_service_tree {
  * struct bfq_sched_data - multi-class scheduler.
  *
  * bfq_sched_data is the basic scheduler queue.  It supports three
- * ioprio_classes, and can be used either as a toplevel queue or as
- * an intermediate queue on a hierarchical setup.
- * @next_in_service points to the active entity of the sched_data
- * service trees that will be scheduled next.
+ * ioprio_classes, and can be used either as a toplevel queue or as an
+ * intermediate queue on a hierarchical setup.  @next_in_service
+ * points to the active entity of the sched_data service trees that
+ * will be scheduled next. It is used to reduce the number of steps
+ * needed for each hierarchical-schedule update.
  *
  * The supported ioprio_classes are the same as in CFQ, in descending
  * priority order, IOPRIO_CLASS_RT, IOPRIO_CLASS_BE, IOPRIO_CLASS_IDLE.
@@ -164,19 +166,23 @@ struct bfq_service_tree {
 struct bfq_sched_data {
 	/* entity in service */
 	struct bfq_entity *in_service_entity;
-	/* head-of-the-line entity in the scheduler */
+	/* head-of-line entity (see comments above) */
 	struct bfq_entity *next_in_service;
 	/* array of service trees, one per ioprio_class */
 	struct bfq_service_tree service_tree[BFQ_IOPRIO_CLASSES];
+	/* last time CLASS_IDLE was served */
+	unsigned long bfq_class_idle_last_service;
+
 };
 
 /**
  * struct bfq_entity - schedulable entity.
  *
- * A bfq_entity is used to represent a bfq_queue (leaf node in the upper
- * level scheduler). Each entity belongs to the sched_data of the parent
- * group hierarchy. Non-leaf entities have also their own sched_data,
- * stored in @my_sched_data.
+ * A bfq_entity is used to represent either a bfq_queue (leaf node in the
+ * cgroup hierarchy) or a bfq_group into the upper level scheduler.  Each
+ * entity belongs to the sched_data of the parent group in the cgroup
+ * hierarchy.  Non-leaf entities have also their own sched_data, stored
+ * in @my_sched_data.
  *
  * Each entity stores independently its priority values; this would
  * allow different weights on different devices, but this
@@ -187,23 +193,24 @@ struct bfq_sched_data {
  * update to take place the effective and the requested priority
  * values are synchronized.
  *
- * The weight value is calculated from the ioprio to export the same
- * interface as CFQ.  When dealing with  ``well-behaved'' queues (i.e.,
- * queues that do not spend too much time to consume their budget
- * and have true sequential behavior, and when there are no external
- * factors breaking anticipation) the relative weights at each level
- * of the hierarchy should be guaranteed.  All the fields are
- * protected by the queue lock of the containing bfqd.
+ * Unless cgroups are used, the weight value is calculated from the
+ * ioprio to export the same interface as CFQ.  When dealing with
+ * ``well-behaved'' queues (i.e., queues that do not spend too much
+ * time to consume their budget and have true sequential behavior, and
+ * when there are no external factors breaking anticipation) the
+ * relative weights at each level of the cgroups hierarchy should be
+ * guaranteed.  All the fields are protected by the queue lock of the
+ * containing bfqd.
  */
 struct bfq_entity {
 	/* service_tree member */
 	struct rb_node rb_node;
 
 	/*
-	 * flag, true if the entity is on a tree (either the active or
-	 * the idle one of its service_tree).
+	 * Flag, true if the entity is on a tree (either the active or
+	 * the idle one of its service_tree) or is in service.
 	 */
-	int on_st;
+	bool on_st;
 
 	/* B-WF2Q+ start and finish timestamps [sectors/weight] */
 	u64 start, finish;
@@ -246,6 +253,8 @@ struct bfq_entity {
 	int prio_changed;
 };
 
+struct bfq_group;
+
 /**
  * struct bfq_ttime - per process thinktime stats.
  */
@@ -265,7 +274,11 @@ struct bfq_ttime {
  * struct bfq_queue - leaf schedulable entity.
  *
  * A bfq_queue is a leaf request queue; it can be associated with an
- * io_context or more, if it is async.
+ * io_context or more, if it is async. @cgroup holds a reference to
+ * the cgroup, to be sure that it does not disappear while a bfqq
+ * still references it (mostly to avoid races between request issuing
+ * and task migration followed by cgroup destruction).  All the fields
+ * are protected by the queue lock of the containing bfqd.
  */
 struct bfq_queue {
 	/* reference counter */
@@ -338,6 +351,9 @@ struct bfq_io_cq {
 	struct bfq_queue *bfqq[2];
 	/* per (request_queue, blkcg) ioprio */
 	int ioprio;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	uint64_t blkcg_serial_nr; /* the current blkcg serial */
+#endif
 };
 
 /**
@@ -351,8 +367,8 @@ struct bfq_data {
 	/* dispatch queue */
 	struct list_head dispatch;
 
-	/* root @bfq_sched_data for the device */
-	struct bfq_sched_data sched_data;
+	/* root bfq_group for the device */
+	struct bfq_group *root_group;
 
 	/*
 	 * Number of bfq_queues containing requests (including the
@@ -423,8 +439,6 @@ struct bfq_data {
 	unsigned int bfq_back_max;
 	/* maximum idling time */
 	u32 bfq_slice_idle;
-	/* last time CLASS_IDLE was served */
-	u64 bfq_class_idle_last_service;
 
 	/* user-configured max budget value (0 for auto-tuning) */
 	int bfq_user_max_budget;
@@ -516,8 +530,35 @@ BFQ_BFQQ_FNS(IO_bound);
 #undef BFQ_BFQQ_FNS
 
 /* Logging facilities. */
-#define bfq_log_bfqq(bfqd, bfqq, fmt, args...) \
-	blk_add_trace_msg((bfqd)->queue, "bfq%d " fmt, (bfqq)->pid, ##args)
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+static struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
+static struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
+
+#define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
+	char __pbuf[128];						\
+									\
+	blkg_path(bfqg_to_blkg(bfqq_group(bfqq)), __pbuf, sizeof(__pbuf)); \
+	blk_add_trace_msg((bfqd)->queue, "bfq%d%c %s " fmt, (bfqq)->pid, \
+			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
+			  __pbuf, ##args);				\
+} while (0)
+
+#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)	do {			\
+	char __pbuf[128];						\
+									\
+	blkg_path(bfqg_to_blkg(bfqg), __pbuf, sizeof(__pbuf));		\
+	blk_add_trace_msg((bfqd)->queue, "%s " fmt, __pbuf, ##args);	\
+} while (0)
+
+#else /* CONFIG_BFQ_GROUP_IOSCHED */
+
+#define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	\
+	blk_add_trace_msg((bfqd)->queue, "bfq%d%c " fmt, (bfqq)->pid,	\
+			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
+				##args)
+#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
+
+#endif /* CONFIG_BFQ_GROUP_IOSCHED */
 
 #define bfq_log(bfqd, fmt, args...) \
 	blk_add_trace_msg((bfqd)->queue, "bfq " fmt, ##args)
@@ -534,15 +575,120 @@ enum bfqq_expiration {
 	BFQQE_PREEMPTED		/* preemption in progress */
 };
 
+struct bfqg_stats {
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	/* number of ios merged */
+	struct blkg_rwstat		merged;
+	/* total time spent on device in ns, may not be accurate w/ queueing */
+	struct blkg_rwstat		service_time;
+	/* total time spent waiting in scheduler queue in ns */
+	struct blkg_rwstat		wait_time;
+	/* number of IOs queued up */
+	struct blkg_rwstat		queued;
+	/* total disk time and nr sectors dispatched by this group */
+	struct blkg_stat		time;
+	/* sum of number of ios queued across all samples */
+	struct blkg_stat		avg_queue_size_sum;
+	/* count of samples taken for average */
+	struct blkg_stat		avg_queue_size_samples;
+	/* how many times this group has been removed from service tree */
+	struct blkg_stat		dequeue;
+	/* total time spent waiting for it to be assigned a timeslice. */
+	struct blkg_stat		group_wait_time;
+	/* time spent idling for this blkcg_gq */
+	struct blkg_stat		idle_time;
+	/* total time with empty current active q with other requests queued */
+	struct blkg_stat		empty_time;
+	/* fields after this shouldn't be cleared on stat reset */
+	uint64_t			start_group_wait_time;
+	uint64_t			start_idle_time;
+	uint64_t			start_empty_time;
+	uint16_t			flags;
+#endif	/* CONFIG_BFQ_GROUP_IOSCHED */
+};
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+
+/*
+ * struct bfq_group_data - per-blkcg storage for the blkio subsystem.
+ *
+ * @ps: @blkcg_policy_storage that this structure inherits
+ * @weight: weight of the bfq_group
+ */
+struct bfq_group_data {
+	/* must be the first member */
+	struct blkcg_policy_data pd;
+
+	unsigned short weight;
+};
+
+/**
+ * struct bfq_group - per (device, cgroup) data structure.
+ * @entity: schedulable entity to insert into the parent group sched_data.
+ * @sched_data: own sched_data, to contain child entities (they may be
+ *              both bfq_queues and bfq_groups).
+ * @bfqd: the bfq_data for the device this group acts upon.
+ * @async_bfqq: array of async queues for all the tasks belonging to
+ *              the group, one queue per ioprio value per ioprio_class,
+ *              except for the idle class that has only one queue.
+ * @async_idle_bfqq: async queue for the idle class (ioprio is ignored).
+ * @my_entity: pointer to @entity, %NULL for the toplevel group; used
+ *             to avoid too many special cases during group creation/
+ *             migration.
+ * @stats: stats for this bfqg.
+ *
+ * Each (device, cgroup) pair has its own bfq_group, i.e., for each cgroup
+ * there is a set of bfq_groups, each one collecting the lower-level
+ * entities belonging to the group that are acting on the same device.
+ *
+ * Locking works as follows:
+ *    o @bfqd is protected by the queue lock, RCU is used to access it
+ *      from the readers.
+ *    o All the other fields are protected by the @bfqd queue lock.
+ */
+struct bfq_group {
+	/* must be the first member */
+	struct blkg_policy_data pd;
+
+	struct bfq_entity entity;
+	struct bfq_sched_data sched_data;
+
+	void *bfqd;
+
+	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
+	struct bfq_queue *async_idle_bfqq;
+
+	struct bfq_entity *my_entity;
+
+	struct bfqg_stats stats;
+};
+
+#else
+struct bfq_group {
+	struct bfq_sched_data sched_data;
+
+	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
+	struct bfq_queue *async_idle_bfqq;
+
+	struct rb_root rq_pos_tree;
+};
+#endif
+
 static struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
 
+static unsigned int bfq_class_idx(struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	return bfqq ? bfqq->ioprio_class - 1 :
+		BFQ_DEFAULT_GRP_CLASS - 1;
+}
+
 static struct bfq_service_tree *
 bfq_entity_service_tree(struct bfq_entity *entity)
 {
 	struct bfq_sched_data *sched_data = entity->sched_data;
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-	unsigned int idx = bfqq ? bfqq->ioprio_class - 1 :
-				  BFQ_DEFAULT_GRP_CLASS - 1;
+	unsigned int idx = bfq_class_idx(entity);
 
 	return sched_data->service_tree + idx;
 }
@@ -568,16 +714,9 @@ static void bfq_put_queue(struct bfq_queue *bfqq);
 static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 				       struct bio *bio, bool is_sync,
 				       struct bfq_io_cq *bic);
+static void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 
-/*
- * Array of async queues for all the processes, one queue
- * per ioprio value per ioprio_class.
- */
-struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
-/* Async queue for the idle class (ioprio is ignored) */
-struct bfq_queue *async_idle_bfqq;
-
 /* Expiration time of sync (0) and async (1) requests, in ns. */
 static const u64 bfq_fifo_expire[2] = { NSEC_PER_SEC / 4, NSEC_PER_SEC / 8 };
 
@@ -663,30 +802,222 @@ static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
 }
 
 /*
- * Next two macros are just fake loops for the moment. They will
- * become true loops in the cgroups-enabled variant of the code. Such
- * a variant, in its turn, will be introduced by next commit.
+ * Scheduler run of queue, if there are requests pending and no one in the
+ * driver that will restart queueing.
+ */
+static void bfq_schedule_dispatch(struct bfq_data *bfqd)
+{
+	if (bfqd->queued != 0) {
+		bfq_log(bfqd, "schedule dispatch");
+		blk_mq_run_hw_queues(bfqd->queue, true);
+	}
+}
+
+/**
+ * bfq_gt - compare two timestamps.
+ * @a: first ts.
+ * @b: second ts.
+ *
+ * Return @a > @b, dealing with wrapping correctly.
+ */
+static int bfq_gt(u64 a, u64 b)
+{
+	return (s64)(a - b) > 0;
+}
+
+static struct bfq_entity *bfq_root_active_entity(struct rb_root *tree)
+{
+	struct rb_node *node = tree->rb_node;
+
+	return rb_entry(node, struct bfq_entity, rb_node);
+}
+
+static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd);
+
+static bool bfq_update_parent_budget(struct bfq_entity *next_in_service);
+
+/**
+ * bfq_update_next_in_service - update sd->next_in_service
+ * @sd: sched_data for which to perform the update.
+ * @new_entity: if not NULL, pointer to the entity whose activation,
+ *		requeueing or repositionig triggered the invocation of
+ *		this function.
+ *
+ * This function is called to update sd->next_in_service, which, in
+ * its turn, may change as a consequence of the insertion or
+ * extraction of an entity into/from one of the active trees of
+ * sd. These insertions/extractions occur as a consequence of
+ * activations/deactivations of entities, with some activations being
+ * 'true' activations, and other activations being requeueings (i.e.,
+ * implementing the second, requeueing phase of the mechanism used to
+ * reposition an entity in its active tree; see comments on
+ * __bfq_activate_entity and __bfq_requeue_entity for details). In
+ * both the last two activation sub-cases, new_entity points to the
+ * just activated or requeued entity.
+ *
+ * Returns true if sd->next_in_service changes in such a way that
+ * entity->parent may become the next_in_service for its parent
+ * entity.
  */
+static bool bfq_update_next_in_service(struct bfq_sched_data *sd,
+				       struct bfq_entity *new_entity)
+{
+	struct bfq_entity *next_in_service = sd->next_in_service;
+	bool parent_sched_may_change = false;
+
+	/*
+	 * If this update is triggered by the activation, requeueing
+	 * or repositiong of an entity that does not coincide with
+	 * sd->next_in_service, then a full lookup in the active tree
+	 * can be avoided. In fact, it is enough to check whether the
+	 * just-modified entity has a higher priority than
+	 * sd->next_in_service, or, even if it has the same priority
+	 * as sd->next_in_service, is eligible and has a lower virtual
+	 * finish time than sd->next_in_service. If this compound
+	 * condition holds, then the new entity becomes the new
+	 * next_in_service. Otherwise no change is needed.
+	 */
+	if (new_entity && new_entity != sd->next_in_service) {
+		/*
+		 * Flag used to decide whether to replace
+		 * sd->next_in_service with new_entity. Tentatively
+		 * set to true, and left as true if
+		 * sd->next_in_service is NULL.
+		 */
+		bool replace_next = true;
+
+		/*
+		 * If there is already a next_in_service candidate
+		 * entity, then compare class priorities or timestamps
+		 * to decide whether to replace sd->service_tree with
+		 * new_entity.
+		 */
+		if (next_in_service) {
+			unsigned int new_entity_class_idx =
+				bfq_class_idx(new_entity);
+			struct bfq_service_tree *st =
+				sd->service_tree + new_entity_class_idx;
+
+			/*
+			 * For efficiency, evaluate the most likely
+			 * sub-condition first.
+			 */
+			replace_next =
+				(new_entity_class_idx ==
+				 bfq_class_idx(next_in_service)
+				 &&
+				 !bfq_gt(new_entity->start, st->vtime)
+				 &&
+				 bfq_gt(next_in_service->finish,
+					new_entity->finish))
+				||
+				new_entity_class_idx <
+				bfq_class_idx(next_in_service);
+		}
+
+		if (replace_next)
+			next_in_service = new_entity;
+	} else /* invoked because of a deactivation: lookup needed */
+		next_in_service = bfq_lookup_next_entity(sd);
+
+	if (next_in_service) {
+		parent_sched_may_change = !sd->next_in_service ||
+			bfq_update_parent_budget(next_in_service);
+	}
+
+	sd->next_in_service = next_in_service;
+
+	if (!next_in_service)
+		return parent_sched_may_change;
+
+	return parent_sched_may_change;
+}
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+/* both next loops stop at one of the child entities of the root group */
 #define for_each_entity(entity)	\
-	for (; entity ; entity = NULL)
+	for (; entity ; entity = entity->parent)
 
+/*
+ * For each iteration, compute parent in advance, so as to be safe if
+ * entity is deallocated during the iteration. Such a deallocation may
+ * happen as a consequence of a bfq_put_queue that frees the bfq_queue
+ * containing entity.
+ */
 #define for_each_entity_safe(entity, parent) \
-	for (parent = NULL; entity ; entity = parent)
+	for (; entity && ({ parent = entity->parent; 1; }); entity = parent)
 
-static int bfq_update_next_in_service(struct bfq_sched_data *sd)
+/*
+ * Returns true if this budget changes may let next_in_service->parent
+ * become the next_in_service entity for its parent entity.
+ */
+static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
 {
-	return 0;
+	struct bfq_entity *bfqg_entity;
+	struct bfq_group *bfqg;
+	struct bfq_sched_data *group_sd;
+	bool ret = false;
+
+	group_sd = next_in_service->sched_data;
+
+	bfqg = container_of(group_sd, struct bfq_group, sched_data);
+	/*
+	 * bfq_group's my_entity field is not NULL only if the group
+	 * is not the root group. We must not touch the root entity
+	 * as it must never become an in-service entity.
+	 */
+	bfqg_entity = bfqg->my_entity;
+	if (bfqg_entity) {
+		if (bfqg_entity->budget > next_in_service->budget)
+			ret = true;
+		bfqg_entity->budget = next_in_service->budget;
+	}
+
+	return ret;
+}
+
+/*
+ * This function tells whether entity stops being a candidate for next
+ * service, according to the following logic.
+ *
+ * This function is invoked for an entity that is about to be set in
+ * service. If such an entity is a queue, then the entity is no longer
+ * a candidate for next service (i.e, a candidate entity to serve
+ * after the in-service entity is expired). The function then returns
+ * true.
+ */
+static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
+{
+	if (bfq_entity_to_bfqq(entity))
+		return true;
+
+	return false;
 }
 
-static void bfq_check_next_in_service(struct bfq_sched_data *sd,
-				      struct bfq_entity *entity)
+#else /* CONFIG_BFQ_GROUP_IOSCHED */
+/*
+ * Next two macros are fake loops when cgroups support is not
+ * enabled. I fact, in such a case, there is only one level to go up
+ * (to reach the root group).
+ */
+#define for_each_entity(entity)	\
+	for (; entity ; entity = NULL)
+
+#define for_each_entity_safe(entity, parent) \
+	for (parent = NULL; entity ; entity = parent)
+
+static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
 {
+	return false;
 }
 
-static void bfq_update_budget(struct bfq_entity *next_in_service)
+static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
 {
+	return true;
 }
 
+#endif /* CONFIG_BFQ_GROUP_IOSCHED */
+
 /*
  * Shift for timestamp calculations.  This actually limits the maximum
  * service allowed in one timestamp delta (small shift values increase it),
@@ -696,18 +1027,6 @@ static void bfq_update_budget(struct bfq_entity *next_in_service)
  */
 #define WFQ_SERVICE_SHIFT	22
 
-/**
- * bfq_gt - compare two timestamps.
- * @a: first ts.
- * @b: second ts.
- *
- * Return @a > @b, dealing with wrapping correctly.
- */
-static int bfq_gt(u64 a, u64 b)
-{
-	return (s64)(a - b) > 0;
-}
-
 static struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
 {
 	struct bfq_queue *bfqq = NULL;
@@ -926,6 +1245,11 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 	struct rb_node *node = &entity->rb_node;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_sched_data *sd = NULL;
+	struct bfq_group *bfqg = NULL;
+	struct bfq_data *bfqd = NULL;
+#endif
 
 	bfq_insert(&st->active, entity);
 
@@ -936,6 +1260,11 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 
 	bfq_update_active_tree(node);
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	sd = entity->sched_data;
+	bfqg = container_of(sd, struct bfq_group, sched_data);
+	bfqd = (struct bfq_data *)bfqg->bfqd;
+#endif
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
 }
@@ -1014,6 +1343,11 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 	struct rb_node *node;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_sched_data *sd = NULL;
+	struct bfq_group *bfqg = NULL;
+	struct bfq_data *bfqd = NULL;
+#endif
 
 	node = bfq_find_deepest(&entity->rb_node);
 	bfq_extract(&st->active, entity);
@@ -1021,6 +1355,11 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 	if (node)
 		bfq_update_active_tree(node);
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	sd = entity->sched_data;
+	bfqg = container_of(sd, struct bfq_group, sched_data);
+	bfqd = (struct bfq_data *)bfqg->bfqd;
+#endif
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
 }
@@ -1069,7 +1408,7 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 
-	entity->on_st = 0;
+	entity->on_st = false;
 	st->wsum -= entity->weight;
 	if (bfqq && !is_in_service)
 		bfq_put_queue(bfqq);
@@ -1115,7 +1454,7 @@ static void bfq_forget_idle(struct bfq_service_tree *st)
 
 static struct bfq_service_tree *
 __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
-			 struct bfq_entity *entity)
+				struct bfq_entity *entity)
 {
 	struct bfq_service_tree *new_st = old_st;
 
@@ -1123,9 +1462,20 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 		unsigned short prev_weight, new_weight;
 		struct bfq_data *bfqd = NULL;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		struct bfq_sched_data *sd;
+		struct bfq_group *bfqg;
+#endif
 
 		if (bfqq)
 			bfqd = bfqq->bfqd;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		else {
+			sd = entity->my_sched_data;
+			bfqg = container_of(sd, struct bfq_group, sched_data);
+			bfqd = (struct bfq_data *)bfqg->bfqd;
+		}
+#endif
 
 		old_st->wsum -= entity->weight;
 
@@ -1171,6 +1521,9 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 	return new_st;
 }
 
+static void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
+static struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
+
 /**
  * bfq_bfqq_served - update the scheduler status after selection for
  *                   service.
@@ -1194,6 +1547,7 @@ static void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
 		st->vtime += bfq_delta(served, st->wsum);
 		bfq_forget_idle(st);
 	}
+	bfqg_stats_set_start_empty_time(bfqq_group(bfqq));
 	bfq_log_bfqq(bfqq->bfqd, bfqq, "bfqq_served %d secs", served);
 }
 
@@ -1216,78 +1570,10 @@ static void bfq_bfqq_charge_full_budget(struct bfq_queue *bfqq)
 	bfq_bfqq_served(bfqq, entity->budget - entity->service);
 }
 
-/**
- * __bfq_activate_entity - activate an entity.
- * @entity: the entity being activated.
- * @non_blocking_wait_rq: true if this entity was waiting for a request
- *
- * Called whenever an entity is activated, i.e., it is not active and one
- * of its children receives a new request, or has to be reactivated due to
- * budget exhaustion.  It uses the current budget of the entity (and the
- * service received if @entity is active) of the queue to calculate its
- * timestamps.
- */
-static void __bfq_activate_entity(struct bfq_entity *entity,
-				  bool non_blocking_wait_rq)
+static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
+					struct bfq_service_tree *st,
+					bool backshifted)
 {
-	struct bfq_sched_data *sd = entity->sched_data;
-	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
-	bool backshifted = false;
-
-	if (entity == sd->in_service_entity) {
-		/*
-		 * If we are requeueing the current entity we have
-		 * to take care of not charging to it service it has
-		 * not received.
-		 */
-		bfq_calc_finish(entity, entity->service);
-		entity->start = entity->finish;
-		sd->in_service_entity = NULL;
-	} else if (entity->tree == &st->active) {
-		/*
-		 * Requeueing an entity due to a change of some
-		 * next_in_service entity below it.  We reuse the
-		 * old start time.
-		 */
-		bfq_active_extract(st, entity);
-	} else {
-		unsigned long long min_vstart;
-
-		/* See comments on bfq_fqq_update_budg_for_activation */
-		if (non_blocking_wait_rq && bfq_gt(st->vtime, entity->finish)) {
-			backshifted = true;
-			min_vstart = entity->finish;
-		} else
-			min_vstart = st->vtime;
-
-		if (entity->tree == &st->idle) {
-			/*
-			 * Must be on the idle tree, bfq_idle_extract() will
-			 * check for that.
-			 */
-			bfq_idle_extract(st, entity);
-			entity->start = bfq_gt(min_vstart, entity->finish) ?
-				min_vstart : entity->finish;
-		} else {
-			/*
-			 * The finish time of the entity may be invalid, and
-			 * it is in the past for sure, otherwise the queue
-			 * would have been on the idle tree.
-			 */
-			entity->start = min_vstart;
-			st->wsum += entity->weight;
-			/*
-			 * entity is about to be inserted into a service tree,
-			 * and then set in service: get a reference to make
-			 * sure entity does not disappear until it is no
-			 * longer in service or scheduled for service.
-			 */
-			bfq_get_entity(entity);
-
-			entity->on_st = 1;
-		}
-	}
-
 	st = __bfq_entity_update_weight_prio(st, entity);
 	bfq_calc_finish(entity, entity->budget);
 
@@ -1329,27 +1615,185 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 }
 
 /**
- * bfq_activate_entity - activate an entity and its ancestors if necessary.
+ * __bfq_activate_entity - handle activation of entity.
+ * @entity: the entity being activated.
+ * @non_blocking_wait_rq: true if entity was waiting for a request
+ *
+ * Called for a 'true' activation, i.e., if entity is not active and
+ * one of its children receives a new request.
+ *
+ * Basically, this function updates the timestamps of entity and
+ * inserts entity into its active tree, ater possible extracting it
+ * from its idle tree.
+ */
+static void __bfq_activate_entity(struct bfq_entity *entity,
+				  bool non_blocking_wait_rq)
+{
+	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
+	bool backshifted = false;
+	unsigned long long min_vstart;
+
+	/* See comments on bfq_fqq_update_budg_for_activation */
+	if (non_blocking_wait_rq && bfq_gt(st->vtime, entity->finish)) {
+		backshifted = true;
+		min_vstart = entity->finish;
+	} else
+		min_vstart = st->vtime;
+
+	if (entity->tree == &st->idle) {
+		/*
+		 * Must be on the idle tree, bfq_idle_extract() will
+		 * check for that.
+		 */
+		bfq_idle_extract(st, entity);
+		entity->start = bfq_gt(min_vstart, entity->finish) ?
+			min_vstart : entity->finish;
+	} else {
+		/*
+		 * The finish time of the entity may be invalid, and
+		 * it is in the past for sure, otherwise the queue
+		 * would have been on the idle tree.
+		 */
+		entity->start = min_vstart;
+		st->wsum += entity->weight;
+		/*
+		 * entity is about to be inserted into a service tree,
+		 * and then set in service: get a reference to make
+		 * sure entity does not disappear until it is no
+		 * longer in service or scheduled for service.
+		 */
+		bfq_get_entity(entity);
+
+		entity->on_st = true;
+	}
+
+	bfq_update_fin_time_enqueue(entity, st, backshifted);
+}
+
+/**
+ * __bfq_requeue_entity - handle requeueing or repositioning of an entity.
+ * @entity: the entity being requeued or repositioned.
+ *
+ * Requeueing is needed if this entity stops being served, which
+ * happens if a leaf descendant entity has expired. On the other hand,
+ * repositioning is needed if the next_inservice_entity for the child
+ * entity has changed. See the comments inside the function for
+ * details.
+ *
+ * Basically, this function: 1) removes entity from its active tree if
+ * present there, 2) updates the timestamps of entity and 3) inserts
+ * entity back into its active tree (in the new, right position for
+ * the new values of the timestamps).
+ */
+static void __bfq_requeue_entity(struct bfq_entity *entity)
+{
+	struct bfq_sched_data *sd = entity->sched_data;
+	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
+
+	if (entity == sd->in_service_entity) {
+		/*
+		 * We are requeueing the current in-service entity,
+		 * which may have to be done for one of the following
+		 * reasons:
+		 * - entity represents the in-service queue, and the
+		 *   in-service queue is being requeued after an
+		 *   expiration;
+		 * - entity represents a group, and its budget has
+		 *   changed because one of its child entities has
+		 *   just been either activated or requeued for some
+		 *   reason; the timestamps of the entity need then to
+		 *   be updated, and the entity needs to be enqueued
+		 *   or repositioned accordingly.
+		 *
+		 * In particular, before requeueing, the start time of
+		 * the entity must be moved forward to account for the
+		 * service that the entity has received while in
+		 * service. This is done by the next instructions. The
+		 * finish time will then be updated according to this
+		 * new value of the start time, and to the budget of
+		 * the entity.
+		 */
+		bfq_calc_finish(entity, entity->service);
+		entity->start = entity->finish;
+		/*
+		 * In addition, if the entity had more than one child
+		 * when set in service, then was not extracted from
+		 * the active tree. This implies that the position of
+		 * the entity in the active tree may need to be
+		 * changed now, because we have just updated the start
+		 * time of the entity, and we will update its finish
+		 * time in a moment (the requeueing is then, more
+		 * precisely, a repositioning in this case). To
+		 * implement this repositioning, we: 1) dequeue the
+		 * entity here, 2) update the finish time and
+		 * requeue the entity according to the new
+		 * timestamps below.
+		 */
+		if (entity->tree)
+			bfq_active_extract(st, entity);
+	} else { /* The entity is already active, and not in service */
+		/*
+		 * In this case, this function gets called only if the
+		 * next_in_service entity below this entity has
+		 * changed, and this change has caused the budget of
+		 * this entity to change, which, finally implies that
+		 * the finish time of this entity must be
+		 * updated. Such an update may cause the scheduling,
+		 * i.e., the position in the active tree, of this
+		 * entity to change. We handle this change by: 1)
+		 * dequeueing the entity here, 2) updating the finish
+		 * time and requeueing the entity according to the new
+		 * timestamps below. This is the same approach as the
+		 * non-extracted-entity sub-case above.
+		 */
+		bfq_active_extract(st, entity);
+	}
+
+	bfq_update_fin_time_enqueue(entity, st, false);
+}
+
+static void __bfq_activate_requeue_entity(struct bfq_entity *entity,
+					  struct bfq_sched_data *sd,
+					  bool non_blocking_wait_rq)
+{
+	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
+
+	if (sd->in_service_entity == entity || entity->tree == &st->active)
+		 /*
+		  * in service or already queued on the active tree,
+		  * requeue or reposition
+		  */
+		__bfq_requeue_entity(entity);
+	else
+		/*
+		 * Not in service and not queued on its active tree:
+		 * the activity is idle and this is a true activation.
+		 */
+		__bfq_activate_entity(entity, non_blocking_wait_rq);
+}
+
+
+/**
+ * bfq_activate_entity - activate or requeue an entity representing a bfq_queue,
+ *			 and activate, requeue or reposition all ancestors
+ *			 for which such an update becomes necessary.
  * @entity: the entity to activate.
  * @non_blocking_wait_rq: true if this entity was waiting for a request
- *
- * Activate @entity and all the entities on the path from it to the root.
+ * @requeue: true if this is a requeue, which implies that bfqq is
+ *	     being expired; thus ALL its ancestors stop being served and must
+ *	     therefore be requeued
  */
-static void bfq_activate_entity(struct bfq_entity *entity,
-				bool non_blocking_wait_rq)
+static void bfq_activate_requeue_entity(struct bfq_entity *entity,
+					bool non_blocking_wait_rq,
+					bool requeue)
 {
 	struct bfq_sched_data *sd;
 
 	for_each_entity(entity) {
-		__bfq_activate_entity(entity, non_blocking_wait_rq);
-
 		sd = entity->sched_data;
-		if (!bfq_update_next_in_service(sd))
-			/*
-			 * No need to propagate the activation to the
-			 * upper entities, as they will be updated when
-			 * the in-service entity is rescheduled.
-			 */
+		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq);
+
+		if (!bfq_update_next_in_service(sd, entity) && !requeue)
 			break;
 	}
 }
@@ -1357,52 +1801,48 @@ static void bfq_activate_entity(struct bfq_entity *entity,
 /**
  * __bfq_deactivate_entity - deactivate an entity from its service tree.
  * @entity: the entity to deactivate.
- * @requeue: if false, the entity will not be put into the idle tree.
+ * @ins_into_idle_tree: if false, the entity will not be put into the
+ *			idle tree.
  *
- * Deactivate an entity, independently from its previous state.  If the
- * entity was not on a service tree just return, otherwise if it is on
- * any scheduler tree, extract it from that tree, and if necessary
- * and if the caller did not specify @requeue, put it on the idle tree.
- *
- * Return %1 if the caller should update the entity hierarchy, i.e.,
- * if the entity was in service or if it was the next_in_service for
- * its sched_data; return %0 otherwise.
+ * Deactivates an entity, independently from its previous state.  Must
+ * be invoked only if entity is on a service tree. Extracts the entity
+ * from that tree, and if necessary and allowed, puts it on the idle
+ * tree.
  */
-static int __bfq_deactivate_entity(struct bfq_entity *entity, int requeue)
+static bool __bfq_deactivate_entity(struct bfq_entity *entity,
+				    bool ins_into_idle_tree)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
 	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
 	int is_in_service = entity == sd->in_service_entity;
-	int ret = 0;
 
-	if (!entity->on_st)
-		return 0;
+	if (!entity->on_st) /* entity never activated, or already inactive */
+		return false;
 
-	if (is_in_service) {
+	if (is_in_service)
 		bfq_calc_finish(entity, entity->service);
-		sd->in_service_entity = NULL;
-	} else if (entity->tree == &st->active)
+
+	if (entity->tree == &st->active)
 		bfq_active_extract(st, entity);
-	else if (entity->tree == &st->idle)
+	else if (!is_in_service && entity->tree == &st->idle)
 		bfq_idle_extract(st, entity);
 
-	if (is_in_service || sd->next_in_service == entity)
-		ret = bfq_update_next_in_service(sd);
-
-	if (!requeue || !bfq_gt(entity->finish, st->vtime))
+	if (!ins_into_idle_tree || !bfq_gt(entity->finish, st->vtime))
 		bfq_forget_entity(st, entity, is_in_service);
 	else
 		bfq_idle_insert(st, entity);
 
-	return ret;
+	return true;
 }
 
 /**
- * bfq_deactivate_entity - deactivate an entity.
+ * bfq_deactivate_entity - deactivate an entity representing a bfq_queue.
  * @entity: the entity to deactivate.
- * @requeue: true if the entity can be put on the idle tree
+ * @ins_into_idle_tree: true if the entity can be put on the idle tree
  */
-static void bfq_deactivate_entity(struct bfq_entity *entity, int requeue)
+static void bfq_deactivate_entity(struct bfq_entity *entity,
+				  bool ins_into_idle_tree,
+				  bool expiration)
 {
 	struct bfq_sched_data *sd;
 	struct bfq_entity *parent = NULL;
@@ -1410,63 +1850,102 @@ static void bfq_deactivate_entity(struct bfq_entity *entity, int requeue)
 	for_each_entity_safe(entity, parent) {
 		sd = entity->sched_data;
 
-		if (!__bfq_deactivate_entity(entity, requeue))
+		if (!__bfq_deactivate_entity(entity, ins_into_idle_tree)) {
 			/*
-			 * The parent entity is still backlogged, and
-			 * we don't need to update it as it is still
-			 * in service.
+			 * entity is not in any tree any more, so
+			 * this deactivation is a no-op, and there is
+			 * nothing to change for upper-level entities
+			 * (in case of expiration, this can never
+			 * happen).
 			 */
-			break;
+			return;
+		}
+
+		if (sd->next_in_service == entity)
+			/*
+			 * entity was the next_in_service entity,
+			 * then, since entity has just been
+			 * deactivated, a new one must be found.
+			 */
+			bfq_update_next_in_service(sd, NULL);
 
 		if (sd->next_in_service)
 			/*
-			 * The parent entity is still backlogged and
-			 * the budgets on the path towards the root
-			 * need to be updated.
+			 * The parent entity is still backlogged,
+			 * because next_in_service is not NULL. So, no
+			 * further upwards deactivation must be
+			 * performed.  Yet, next_in_service has
+			 * changed.  Then the schedule does need to be
+			 * updated upwards.
 			 */
-			goto update;
+			break;
 
 		/*
-		 * If we get here, then the parent is no more backlogged and
-		 * we want to propagate the deactivation upwards.
+		 * If we get here, then the parent is no more
+		 * backlogged and we need to propagate the
+		 * deactivation upwards. Thus let the loop go on.
 		 */
-		requeue = 1;
-	}
 
-	return;
+		/*
+		 * Also let parent be queued into the idle tree on
+		 * deactivation, to preserve service guarantees, and
+		 * assuming that who invoked this function does not
+		 * need parent entities too to be removed completely.
+		 */
+		ins_into_idle_tree = true;
+	}
 
-update:
+	/*
+	 * If the deactivation loop is fully executed, then there are
+	 * no more entities to touch and next loop is not executed at
+	 * all. Otherwise, requeue remaining entities if they are
+	 * about to stop receiving service, or reposition them if this
+	 * is not the case.
+	 */
 	entity = parent;
 	for_each_entity(entity) {
-		__bfq_activate_entity(entity, false);
+		/*
+		 * Invoke __bfq_requeue_entity on entity, even if
+		 * already active, to requeue/reposition it in the
+		 * active tree (because sd->next_in_service has
+		 * changed)
+		 */
+		__bfq_requeue_entity(entity);
 
 		sd = entity->sched_data;
-		if (!bfq_update_next_in_service(sd))
+		if (!bfq_update_next_in_service(sd, entity) &&
+		    !expiration)
+			/*
+			 * next_in_service unchanged or not causing
+			 * any change in entity->parent->sd, and no
+			 * requeueing needed for expiration: stop
+			 * here.
+			 */
 			break;
 	}
 }
 
 /**
- * bfq_update_vtime - update vtime if necessary.
+ * bfq_calc_vtime_jump - compute the value to which the vtime should jump,
+ *                       if needed, to have at least one entity eligible.
  * @st: the service tree to act upon.
  *
- * If necessary update the service tree vtime to have at least one
- * eligible entity, skipping to its start time.  Assumes that the
- * active tree of the device is not empty.
- *
- * NOTE: this hierarchical implementation updates vtimes quite often,
- * we may end up with reactivated processes getting timestamps after a
- * vtime skip done because we needed a ->first_active entity on some
- * intermediate node.
+ * Assumes that st is not empty.
  */
-static void bfq_update_vtime(struct bfq_service_tree *st)
+static u64 bfq_calc_vtime_jump(struct bfq_service_tree *st)
 {
-	struct bfq_entity *entry;
-	struct rb_node *node = st->active.rb_node;
+	struct bfq_entity *root_entity = bfq_root_active_entity(&st->active);
+
+	if (bfq_gt(root_entity->min_start, st->vtime))
+		return root_entity->min_start;
+
+	return st->vtime;
+}
 
-	entry = rb_entry(node, struct bfq_entity, rb_node);
-	if (bfq_gt(entry->min_start, st->vtime)) {
-		st->vtime = entry->min_start;
+static void bfq_update_vtime(struct bfq_service_tree *st, u64 new_value)
+{
+	if (new_value > st->vtime) {
+		st->vtime = new_value;
 		bfq_forget_idle(st);
 	}
 }
@@ -1475,6 +1954,7 @@ static void bfq_update_vtime(struct bfq_service_tree *st)
  * bfq_first_active_entity - find the eligible entity with
  *                           the smallest finish time
  * @st: the service tree to select from.
+ * @vtime: the system virtual to use as a reference for eligibility
  *
  * This function searches the first schedulable entity, starting from the
  * root of the tree and going on the left every time on this side there is
@@ -1482,7 +1962,8 @@ static void bfq_update_vtime(struct bfq_service_tree *st)
  * the right is followed only if a) the left subtree contains no eligible
  * entities and b) no eligible entity has been found yet.
  */
-static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st)
+static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st,
+						  u64 vtime)
 {
 	struct bfq_entity *entry, *first = NULL;
 	struct rb_node *node = st->active.rb_node;
@@ -1490,13 +1971,13 @@ static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st)
 	while (node) {
 		entry = rb_entry(node, struct bfq_entity, rb_node);
 left:
-		if (!bfq_gt(entry->start, st->vtime))
+		if (!bfq_gt(entry->start, vtime))
 			first = entry;
 
 		if (node->rb_left) {
 			entry = rb_entry(node->rb_left,
 					 struct bfq_entity, rb_node);
-			if (!bfq_gt(entry->min_start, st->vtime)) {
+			if (!bfq_gt(entry->min_start, vtime)) {
 				node = node->rb_left;
 				goto left;
 			}
@@ -1506,204 +1987,1423 @@ static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st)
 		node = node->rb_right;
 	}
 
-	return first;
+	return first;
+}
+
+/**
+ * __bfq_lookup_next_entity - return the first eligible entity in @st.
+ * @st: the service tree.
+ *
+ * If there is no in-service entity for the sched_data st belongs to,
+ * then return the entity that will be set in service if:
+ * 1) the parent entity this st belongs to is set in service;
+ * 2) no entity belonging to such parent entity undergoes a state change
+ * that would influence the timestamps of the entity (e.g., becomes idle,
+ * becomes backlogged, changes its budget, ...).
+ *
+ * In this first case, update the virtual time in @st too (see the
+ * comments on this update inside the function).
+ *
+ * In constrast, if there is an in-service entity, then return the
+ * entity that would be set in service if not only the above
+ * conditions, but also the next one held true: the currently
+ * in-service entity, on expiration,
+ * 1) gets a finish time equal to the current one, or
+ * 2) is not eligible any more, or
+ * 3) is idle.
+ */
+static struct bfq_entity *
+__bfq_lookup_next_entity(struct bfq_service_tree *st, bool in_service)
+{
+	struct bfq_entity *entity;
+	u64 new_vtime;
+
+	if (RB_EMPTY_ROOT(&st->active))
+		return NULL;
+
+	/*
+	 * Get the value of the system virtual time for which at
+	 * least one entity is eligible.
+	 */
+	new_vtime = bfq_calc_vtime_jump(st);
+
+	/*
+	 * If there is no in-service entity for the sched_data this
+	 * active tree belongs to, then push the system virtual time
+	 * up to the value that guarantees that at least one entity is
+	 * eligible. If, instead, there is an in-service entity, then
+	 * do not make any such update, because there is already an
+	 * eligible entity, namely the in-service one (even if the
+	 * entity is not on st, because it was extracted when set in
+	 * service).
+	 */
+	if (!in_service)
+		bfq_update_vtime(st, new_vtime);
+
+	entity = bfq_first_active_entity(st, new_vtime);
+
+	return entity;
+}
+
+/**
+ * bfq_lookup_next_entity - return the first eligible entity in @sd.
+ * @sd: the sched_data.
+ *
+ * This function is invoked when there has been a change in the trees
+ * for sd, and we need know what is the new next entity after this
+ * change.
+ */
+static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd)
+{
+	struct bfq_service_tree *st = sd->service_tree;
+	struct bfq_service_tree *idle_class_st = st + (BFQ_IOPRIO_CLASSES - 1);
+	struct bfq_entity *entity = NULL;
+	int class_idx = 0;
+
+	/*
+	 * Choose from idle class, if needed to guarantee a minimum
+	 * bandwidth to this class (and if there is some active entity
+	 * in idle class). This should also mitigate
+	 * priority-inversion problems in case a low priority task is
+	 * holding file system resources.
+	 */
+	if (time_is_before_jiffies(sd->bfq_class_idle_last_service +
+				   BFQ_CL_IDLE_TIMEOUT)) {
+		if (!RB_EMPTY_ROOT(&idle_class_st->active))
+			class_idx = BFQ_IOPRIO_CLASSES - 1;
+		/* About to be served if backlogged, or not yet backlogged */
+		sd->bfq_class_idle_last_service = jiffies;
+	}
+
+	/*
+	 * Find the next entity to serve for the highest-priority
+	 * class, unless the idle class needs to be served.
+	 */
+	for (; class_idx < BFQ_IOPRIO_CLASSES; class_idx++) {
+		entity = __bfq_lookup_next_entity(st + class_idx,
+						  sd->in_service_entity);
+
+		if (entity)
+			break;
+	}
+
+	if (!entity)
+		return NULL;
+
+	return entity;
+}
+
+static bool next_queue_may_preempt(struct bfq_data *bfqd)
+{
+	struct bfq_sched_data *sd = &bfqd->root_group->sched_data;
+
+	return sd->next_in_service != sd->in_service_entity;
+}
+
+/*
+ * Get next queue for service.
+ */
+static struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
+{
+	struct bfq_entity *entity = NULL;
+	struct bfq_sched_data *sd;
+	struct bfq_queue *bfqq;
+
+	if (bfqd->busy_queues == 0)
+		return NULL;
+
+	/*
+	 * Traverse the path from the root to the leaf entity to
+	 * serve. Set in service all the entities visited along the
+	 * way.
+	 */
+	sd = &bfqd->root_group->sched_data;
+	for (; sd ; sd = entity->my_sched_data) {
+		/*
+		 * WARNING. We are about to set the in-service entity
+		 * to sd->next_in_service, i.e., to the (cached) value
+		 * returned by bfq_lookup_next_entity(sd) the last
+		 * time it was invoked, i.e., the last time when the
+		 * service order in sd changed as a consequence of the
+		 * activation or deactivation of an entity. In this
+		 * respect, if we execute bfq_lookup_next_entity(sd)
+		 * in this very moment, it may, although with low
+		 * probability, yield a different entity than that
+		 * pointed to by sd->next_in_service. This rare event
+		 * happens in case there was no CLASS_IDLE entity to
+		 * serve for sd when bfq_lookup_next_entity(sd) was
+		 * invoked for the last time, while there is now one
+		 * such entity.
+		 *
+		 * If the above event happens, then the scheduling of
+		 * such entity in CLASS_IDLE is postponed until the
+		 * service of the sd->next_in_service entity
+		 * finishes. In fact, when the latter is expired,
+		 * bfq_lookup_next_entity(sd) gets called again,
+		 * exactly to update sd->next_in_service.
+		 */
+
+		/* Make next_in_service entity become in_service_entity */
+		entity = sd->next_in_service;
+		sd->in_service_entity = entity;
+
+		/*
+		 * Reset the accumulator of the amount of service that
+		 * the entity is about to receive.
+		 */
+		entity->service = 0;
+
+		/*
+		 * If entity is no longer a candidate for next
+		 * service, then we extract it from its active tree,
+		 * for the following reason. To further boost the
+		 * throughput in some special case, BFQ needs to know
+		 * which is the next candidate entity to serve, while
+		 * there is already an entity in service. In this
+		 * respect, to make it easy to compute/update the next
+		 * candidate entity to serve after the current
+		 * candidate has been set in service, there is a case
+		 * where it is necessary to extract the current
+		 * candidate from its service tree. Such a case is
+		 * when the entity just set in service cannot be also
+		 * a candidate for next service. Details about when
+		 * this conditions holds are reported in the comments
+		 * on the function bfq_no_longer_next_in_service()
+		 * invoked below.
+		 */
+		if (bfq_no_longer_next_in_service(entity))
+			bfq_active_extract(bfq_entity_service_tree(entity),
+					   entity);
+
+		/*
+		 * For the same reason why we may have just extracted
+		 * entity from its active tree, we may need to update
+		 * next_in_service for the sched_data of entity too,
+		 * regardless of whether entity has been extracted.
+		 * In fact, even if entity has not been extracted, a
+		 * descendant entity may get extracted. Such an event
+		 * would cause a change in next_in_service for the
+		 * level of the descendant entity, and thus possibly
+		 * back to upper levels.
+		 *
+		 * We cannot perform the resulting needed update
+		 * before the end of this loop, because, to know which
+		 * is the correct next-to-serve candidate entity for
+		 * each level, we need first to find the leaf entity
+		 * to set in service. In fact, only after we know
+		 * which is the next-to-serve leaf entity, we can
+		 * discover whether the parent entity of the leaf
+		 * entity becomes the next-to-serve, and so on.
+		 */
+
+	}
+
+	bfqq = bfq_entity_to_bfqq(entity);
+
+	/*
+	 * We can finally update all next-to-serve entities along the
+	 * path from the leaf entity just set in service to the root.
+	 */
+	for_each_entity(entity) {
+		struct bfq_sched_data *sd = entity->sched_data;
+
+		if (!bfq_update_next_in_service(sd, NULL))
+			break;
+	}
+
+	return bfqq;
+}
+
+static void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
+{
+	struct bfq_queue *in_serv_bfqq = bfqd->in_service_queue;
+	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
+	struct bfq_entity *entity = in_serv_entity;
+
+	if (bfqd->in_service_bic) {
+		put_io_context(bfqd->in_service_bic->icq.ioc);
+		bfqd->in_service_bic = NULL;
+	}
+
+	bfq_clear_bfqq_wait_request(in_serv_bfqq);
+	hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
+	bfqd->in_service_queue = NULL;
+
+	/*
+	 * When this function is called, all in-service entities have
+	 * been properly deactivated or requeued, so we can safely
+	 * execute the final step: reset in_service_entity along the
+	 * path from entity to the root.
+	 */
+	for_each_entity(entity)
+		entity->sched_data->in_service_entity = NULL;
+
+	/*
+	 * in_serv_entity is no longer in service, so, if it is in no
+	 * service tree either, then release the service reference to
+	 * the queue it represents (taken with bfq_get_entity).
+	 */
+	if (!in_serv_entity->on_st)
+		bfq_put_queue(in_serv_bfqq);
+}
+
+static void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+				bool ins_into_idle_tree, bool expiration)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	bfq_deactivate_entity(entity, ins_into_idle_tree, expiration);
+}
+
+static void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	bfq_activate_requeue_entity(entity, bfq_bfqq_non_blocking_wait_rq(bfqq),
+				    false);
+	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
+}
+
+static void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	bfq_activate_requeue_entity(entity, false,
+				    bfqq == bfqd->in_service_queue);
+}
+
+static void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
+
+/*
+ * Called when the bfqq no longer has requests pending, remove it from
+ * the service tree. As a special case, it can be invoked during an
+ * expiration.
+ */
+static void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			      bool expiration)
+{
+	bfq_log_bfqq(bfqd, bfqq, "del from busy");
+
+	bfq_clear_bfqq_busy(bfqq);
+
+	bfqd->busy_queues--;
+
+	bfqg_stats_update_dequeue(bfqq_group(bfqq));
+
+	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
+}
+
+/*
+ * Called when an inactive queue receives a new request.
+ */
+static void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	bfq_log_bfqq(bfqd, bfqq, "add to busy");
+
+	bfq_activate_bfqq(bfqd, bfqq);
+
+	bfq_mark_bfqq_busy(bfqq);
+	bfqd->busy_queues++;
+}
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+
+/* bfqg stats flags */
+enum bfqg_stats_flags {
+	BFQG_stats_waiting = 0,
+	BFQG_stats_idling,
+	BFQG_stats_empty,
+};
+
+#define BFQG_FLAG_FNS(name)						\
+static void bfqg_stats_mark_##name(struct bfqg_stats *stats)	\
+{									\
+	stats->flags |= (1 << BFQG_stats_##name);			\
+}									\
+static void bfqg_stats_clear_##name(struct bfqg_stats *stats)	\
+{									\
+	stats->flags &= ~(1 << BFQG_stats_##name);			\
+}									\
+static int bfqg_stats_##name(struct bfqg_stats *stats)		\
+{									\
+	return (stats->flags & (1 << BFQG_stats_##name)) != 0;		\
+}									\
+
+BFQG_FLAG_FNS(waiting)
+BFQG_FLAG_FNS(idling)
+BFQG_FLAG_FNS(empty)
+#undef BFQG_FLAG_FNS
+
+/* This should be called with the queue_lock held. */
+static void bfqg_stats_update_group_wait_time(struct bfqg_stats *stats)
+{
+	unsigned long long now;
+
+	if (!bfqg_stats_waiting(stats))
+		return;
+
+	now = sched_clock();
+	if (time_after64(now, stats->start_group_wait_time))
+		blkg_stat_add(&stats->group_wait_time,
+			      now - stats->start_group_wait_time);
+	bfqg_stats_clear_waiting(stats);
+}
+
+/* This should be called with the queue_lock held. */
+static void bfqg_stats_set_start_group_wait_time(struct bfq_group *bfqg,
+						 struct bfq_group *curr_bfqg)
+{
+	struct bfqg_stats *stats = &bfqg->stats;
+
+	if (bfqg_stats_waiting(stats))
+		return;
+	if (bfqg == curr_bfqg)
+		return;
+	stats->start_group_wait_time = sched_clock();
+	bfqg_stats_mark_waiting(stats);
+}
+
+/* This should be called with the queue_lock held. */
+static void bfqg_stats_end_empty_time(struct bfqg_stats *stats)
+{
+	unsigned long long now;
+
+	if (!bfqg_stats_empty(stats))
+		return;
+
+	now = sched_clock();
+	if (time_after64(now, stats->start_empty_time))
+		blkg_stat_add(&stats->empty_time,
+			      now - stats->start_empty_time);
+	bfqg_stats_clear_empty(stats);
+}
+
+static void bfqg_stats_update_dequeue(struct bfq_group *bfqg)
+{
+	blkg_stat_add(&bfqg->stats.dequeue, 1);
+}
+
+static void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg)
+{
+	struct bfqg_stats *stats = &bfqg->stats;
+
+	if (blkg_rwstat_total(&stats->queued))
+		return;
+
+	/*
+	 * group is already marked empty. This can happen if bfqq got new
+	 * request in parent group and moved to this group while being added
+	 * to service tree. Just ignore the event and move on.
+	 */
+	if (bfqg_stats_empty(stats))
+		return;
+
+	stats->start_empty_time = sched_clock();
+	bfqg_stats_mark_empty(stats);
+}
+
+static void bfqg_stats_update_idle_time(struct bfq_group *bfqg)
+{
+	struct bfqg_stats *stats = &bfqg->stats;
+
+	if (bfqg_stats_idling(stats)) {
+		unsigned long long now = sched_clock();
+
+		if (time_after64(now, stats->start_idle_time))
+			blkg_stat_add(&stats->idle_time,
+				      now - stats->start_idle_time);
+		bfqg_stats_clear_idling(stats);
+	}
+}
+
+static void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg)
+{
+	struct bfqg_stats *stats = &bfqg->stats;
+
+	stats->start_idle_time = sched_clock();
+	bfqg_stats_mark_idling(stats);
+}
+
+static void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
+{
+	struct bfqg_stats *stats = &bfqg->stats;
+
+	blkg_stat_add(&stats->avg_queue_size_sum,
+		      blkg_rwstat_total(&stats->queued));
+	blkg_stat_add(&stats->avg_queue_size_samples, 1);
+	bfqg_stats_update_group_wait_time(stats);
+}
+
+/*
+ * blk-cgroup policy-related handlers
+ * The following functions help in converting between blk-cgroup
+ * internal structures and BFQ-specific structures.
+ */
+
+static struct bfq_group *pd_to_bfqg(struct blkg_policy_data *pd)
+{
+	return pd ? container_of(pd, struct bfq_group, pd) : NULL;
+}
+
+static struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg)
+{
+	return pd_to_blkg(&bfqg->pd);
+}
+
+static struct blkcg_policy blkcg_policy_bfq;
+
+static struct bfq_group *blkg_to_bfqg(struct blkcg_gq *blkg)
+{
+	return pd_to_bfqg(blkg_to_pd(blkg, &blkcg_policy_bfq));
+}
+
+/*
+ * bfq_group handlers
+ * The following functions help in navigating the bfq_group hierarchy
+ * by allowing to find the parent of a bfq_group or the bfq_group
+ * associated to a bfq_queue.
+ */
+
+static struct bfq_group *bfqg_parent(struct bfq_group *bfqg)
+{
+	struct blkcg_gq *pblkg = bfqg_to_blkg(bfqg)->parent;
+
+	return pblkg ? blkg_to_bfqg(pblkg) : NULL;
+}
+
+static struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
+{
+	struct bfq_entity *group_entity = bfqq->entity.parent;
+
+	return group_entity ? container_of(group_entity, struct bfq_group,
+					   entity) :
+			      bfqq->bfqd->root_group;
+}
+
+/*
+ * The following two functions handle get and put of a bfq_group by
+ * wrapping the related blk-cgroup hooks.
+ */
+
+static void bfqg_get(struct bfq_group *bfqg)
+{
+	return blkg_get(bfqg_to_blkg(bfqg));
+}
+
+static void bfqg_put(struct bfq_group *bfqg)
+{
+	return blkg_put(bfqg_to_blkg(bfqg));
+}
+
+static void bfqg_stats_update_io_add(struct bfq_group *bfqg,
+				     struct bfq_queue *bfqq,
+				     unsigned int op)
+{
+	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
+	bfqg_stats_end_empty_time(&bfqg->stats);
+	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
+		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
+}
+
+static void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op)
+{
+	blkg_rwstat_add(&bfqg->stats.queued, op, -1);
+}
+
+static void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op)
+{
+	blkg_rwstat_add(&bfqg->stats.merged, op, 1);
+}
+
+static void bfqg_stats_update_completion(struct bfq_group *bfqg,
+			uint64_t start_time, uint64_t io_start_time,
+			unsigned int op)
+{
+	struct bfqg_stats *stats = &bfqg->stats;
+	unsigned long long now = sched_clock();
+
+	if (time_after64(now, io_start_time))
+		blkg_rwstat_add(&stats->service_time, op,
+				now - io_start_time);
+	if (time_after64(io_start_time, start_time))
+		blkg_rwstat_add(&stats->wait_time, op,
+				io_start_time - start_time);
+}
+
+/* @stats = 0 */
+static void bfqg_stats_reset(struct bfqg_stats *stats)
+{
+	/* queued stats shouldn't be cleared */
+	blkg_rwstat_reset(&stats->merged);
+	blkg_rwstat_reset(&stats->service_time);
+	blkg_rwstat_reset(&stats->wait_time);
+	blkg_stat_reset(&stats->time);
+	blkg_stat_reset(&stats->avg_queue_size_sum);
+	blkg_stat_reset(&stats->avg_queue_size_samples);
+	blkg_stat_reset(&stats->dequeue);
+	blkg_stat_reset(&stats->group_wait_time);
+	blkg_stat_reset(&stats->idle_time);
+	blkg_stat_reset(&stats->empty_time);
+}
+
+/* @to += @from */
+static void bfqg_stats_add_aux(struct bfqg_stats *to, struct bfqg_stats *from)
+{
+	if (!to || !from)
+		return;
+
+	/* queued stats shouldn't be cleared */
+	blkg_rwstat_add_aux(&to->merged, &from->merged);
+	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
+	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
+	blkg_stat_add_aux(&from->time, &from->time);
+	blkg_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
+	blkg_stat_add_aux(&to->avg_queue_size_samples,
+			  &from->avg_queue_size_samples);
+	blkg_stat_add_aux(&to->dequeue, &from->dequeue);
+	blkg_stat_add_aux(&to->group_wait_time, &from->group_wait_time);
+	blkg_stat_add_aux(&to->idle_time, &from->idle_time);
+	blkg_stat_add_aux(&to->empty_time, &from->empty_time);
+}
+
+/*
+ * Transfer @bfqg's stats to its parent's aux counts so that the ancestors'
+ * recursive stats can still account for the amount used by this bfqg after
+ * it's gone.
+ */
+static void bfqg_stats_xfer_dead(struct bfq_group *bfqg)
+{
+	struct bfq_group *parent;
+
+	if (!bfqg) /* root_group */
+		return;
+
+	parent = bfqg_parent(bfqg);
+
+	lockdep_assert_held(bfqg_to_blkg(bfqg)->q->queue_lock);
+
+	if (unlikely(!parent))
+		return;
+
+	bfqg_stats_add_aux(&parent->stats, &bfqg->stats);
+	bfqg_stats_reset(&bfqg->stats);
+}
+
+static void bfq_init_entity(struct bfq_entity *entity,
+			    struct bfq_group *bfqg)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	entity->weight = entity->new_weight;
+	entity->orig_weight = entity->new_weight;
+	if (bfqq) {
+		bfqq->ioprio = bfqq->new_ioprio;
+		bfqq->ioprio_class = bfqq->new_ioprio_class;
+		bfqg_get(bfqg);
+	}
+	entity->parent = bfqg->my_entity; /* NULL for root group */
+	entity->sched_data = &bfqg->sched_data;
+}
+
+static void bfqg_stats_exit(struct bfqg_stats *stats)
+{
+	blkg_rwstat_exit(&stats->merged);
+	blkg_rwstat_exit(&stats->service_time);
+	blkg_rwstat_exit(&stats->wait_time);
+	blkg_rwstat_exit(&stats->queued);
+	blkg_stat_exit(&stats->time);
+	blkg_stat_exit(&stats->avg_queue_size_sum);
+	blkg_stat_exit(&stats->avg_queue_size_samples);
+	blkg_stat_exit(&stats->dequeue);
+	blkg_stat_exit(&stats->group_wait_time);
+	blkg_stat_exit(&stats->idle_time);
+	blkg_stat_exit(&stats->empty_time);
+}
+
+static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
+{
+	if (blkg_rwstat_init(&stats->merged, gfp) ||
+	    blkg_rwstat_init(&stats->service_time, gfp) ||
+	    blkg_rwstat_init(&stats->wait_time, gfp) ||
+	    blkg_rwstat_init(&stats->queued, gfp) ||
+	    blkg_stat_init(&stats->time, gfp) ||
+	    blkg_stat_init(&stats->avg_queue_size_sum, gfp) ||
+	    blkg_stat_init(&stats->avg_queue_size_samples, gfp) ||
+	    blkg_stat_init(&stats->dequeue, gfp) ||
+	    blkg_stat_init(&stats->group_wait_time, gfp) ||
+	    blkg_stat_init(&stats->idle_time, gfp) ||
+	    blkg_stat_init(&stats->empty_time, gfp)) {
+		bfqg_stats_exit(stats);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static struct bfq_group_data *cpd_to_bfqgd(struct blkcg_policy_data *cpd)
+{
+	return cpd ? container_of(cpd, struct bfq_group_data, pd) : NULL;
+}
+
+static struct bfq_group_data *blkcg_to_bfqgd(struct blkcg *blkcg)
+{
+	return cpd_to_bfqgd(blkcg_to_cpd(blkcg, &blkcg_policy_bfq));
+}
+
+static struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
+{
+	struct bfq_group_data *bgd;
+
+	bgd = kzalloc(sizeof(*bgd), gfp);
+	if (!bgd)
+		return NULL;
+	return &bgd->pd;
+}
+
+static void bfq_cpd_init(struct blkcg_policy_data *cpd)
+{
+	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
+
+	d->weight = cgroup_subsys_on_dfl(io_cgrp_subsys) ?
+		CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
+}
+
+static void bfq_cpd_free(struct blkcg_policy_data *cpd)
+{
+	kfree(cpd_to_bfqgd(cpd));
+}
+
+static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, int node)
+{
+	struct bfq_group *bfqg;
+
+	bfqg = kzalloc_node(sizeof(*bfqg), gfp, node);
+	if (!bfqg)
+		return NULL;
+
+	if (bfqg_stats_init(&bfqg->stats, gfp)) {
+		kfree(bfqg);
+		return NULL;
+	}
+
+	return &bfqg->pd;
+}
+
+static void bfq_pd_init(struct blkg_policy_data *pd)
+{
+	struct blkcg_gq *blkg = pd_to_blkg(pd);
+	struct bfq_group *bfqg = blkg_to_bfqg(blkg);
+	struct bfq_data *bfqd = blkg->q->elevator->elevator_data;
+	struct bfq_entity *entity = &bfqg->entity;
+	struct bfq_group_data *d = blkcg_to_bfqgd(blkg->blkcg);
+
+	entity->orig_weight = entity->weight = entity->new_weight = d->weight;
+	entity->my_sched_data = &bfqg->sched_data;
+	bfqg->my_entity = entity; /*
+				   * the root_group's will be set to NULL
+				   * in bfq_init_queue()
+				   */
+	bfqg->bfqd = bfqd;
+}
+
+static void bfq_pd_free(struct blkg_policy_data *pd)
+{
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+
+	bfqg_stats_exit(&bfqg->stats);
+	return kfree(bfqg);
+}
+
+static void bfq_pd_reset_stats(struct blkg_policy_data *pd)
+{
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+
+	bfqg_stats_reset(&bfqg->stats);
+}
+
+static void bfq_group_set_parent(struct bfq_group *bfqg,
+					struct bfq_group *parent)
+{
+	struct bfq_entity *entity;
+
+	entity = &bfqg->entity;
+	entity->parent = parent->my_entity;
+	entity->sched_data = &parent->sched_data;
+}
+
+static struct bfq_group *bfq_lookup_bfqg(struct bfq_data *bfqd,
+					 struct blkcg *blkcg)
+{
+	struct blkcg_gq *blkg;
+
+	blkg = blkg_lookup(blkcg, bfqd->queue);
+	if (likely(blkg))
+		return blkg_to_bfqg(blkg);
+	return NULL;
+}
+
+static struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
+					    struct blkcg *blkcg)
+{
+	struct bfq_group *bfqg, *parent;
+	struct bfq_entity *entity;
+
+	bfqg = bfq_lookup_bfqg(bfqd, blkcg);
+
+	if (unlikely(!bfqg))
+		return NULL;
+
+	/*
+	 * Update chain of bfq_groups as we might be handling a leaf group
+	 * which, along with some of its relatives, has not been hooked yet
+	 * to the private hierarchy of BFQ.
+	 */
+	entity = &bfqg->entity;
+	for_each_entity(entity) {
+		bfqg = container_of(entity, struct bfq_group, entity);
+		if (bfqg != bfqd->root_group) {
+			parent = bfqg_parent(bfqg);
+			if (!parent)
+				parent = bfqd->root_group;
+			bfq_group_set_parent(bfqg, parent);
+		}
+	}
+
+	return bfqg;
+}
+
+static void bfq_bfqq_expire(struct bfq_data *bfqd,
+			    struct bfq_queue *bfqq,
+			    bool compensate,
+			    enum bfqq_expiration reason);
+
+/**
+ * bfq_bfqq_move - migrate @bfqq to @bfqg.
+ * @bfqd: queue descriptor.
+ * @bfqq: the queue to move.
+ * @bfqg: the group to move to.
+ *
+ * Move @bfqq to @bfqg, deactivating it from its old group and reactivating
+ * it on the new one.  Avoid putting the entity on the old group idle tree.
+ *
+ * Must be called under the queue lock; the cgroup owning @bfqg must
+ * not disappear (by now this just means that we are called under
+ * rcu_read_lock()).
+ */
+static void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			  struct bfq_group *bfqg)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	/* If bfqq is empty, then bfq_bfqq_expire also invokes
+	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
+	 * from data structures related to current group. Otherwise we
+	 * need to remove bfqq explicitly with bfq_deactivate_bfqq, as
+	 * we do below.
+	 */
+	if (bfqq == bfqd->in_service_queue)
+		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
+				false, BFQQE_PREEMPTED);
+
+	if (bfq_bfqq_busy(bfqq))
+		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
+	else if (entity->on_st)
+		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
+	bfqg_put(bfqq_group(bfqq));
+
+	/*
+	 * Here we use a reference to bfqg.  We don't need a refcounter
+	 * as the cgroup reference will not be dropped, so that its
+	 * destroy() callback will not be invoked.
+	 */
+	entity->parent = bfqg->my_entity;
+	entity->sched_data = &bfqg->sched_data;
+	bfqg_get(bfqg);
+
+	if (bfq_bfqq_busy(bfqq))
+		bfq_activate_bfqq(bfqd, bfqq);
+
+	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
+		bfq_schedule_dispatch(bfqd);
+}
+
+/**
+ * __bfq_bic_change_cgroup - move @bic to @cgroup.
+ * @bfqd: the queue descriptor.
+ * @bic: the bic to move.
+ * @blkcg: the blk-cgroup to move to.
+ *
+ * Move bic to blkcg, assuming that bfqd->queue is locked; the caller
+ * has to make sure that the reference to cgroup is valid across the call.
+ *
+ * NOTE: an alternative approach might have been to store the current
+ * cgroup in bfqq and getting a reference to it, reducing the lookup
+ * time here, at the price of slightly more complex code.
+ */
+static struct bfq_group *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
+						struct bfq_io_cq *bic,
+						struct blkcg *blkcg)
+{
+	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0);
+	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1);
+	struct bfq_group *bfqg;
+	struct bfq_entity *entity;
+
+	bfqg = bfq_find_set_group(bfqd, blkcg);
+
+	if (unlikely(!bfqg))
+		bfqg = bfqd->root_group;
+
+	if (async_bfqq) {
+		entity = &async_bfqq->entity;
+
+		if (entity->sched_data != &bfqg->sched_data) {
+			bic_set_bfqq(bic, NULL, 0);
+			bfq_log_bfqq(bfqd, async_bfqq,
+				     "bic_change_group: %p %d",
+				     async_bfqq,
+				     async_bfqq->ref);
+			bfq_put_queue(async_bfqq);
+		}
+	}
+
+	if (sync_bfqq) {
+		entity = &sync_bfqq->entity;
+		if (entity->sched_data != &bfqg->sched_data)
+			bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
+	}
+
+	return bfqg;
+}
+
+static void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
+{
+	struct bfq_data *bfqd = bic_to_bfqd(bic);
+	struct bfq_group *bfqg = NULL;
+	uint64_t serial_nr;
+
+	rcu_read_lock();
+	serial_nr = bio_blkcg(bio)->css.serial_nr;
+
+	/*
+	 * Check whether blkcg has changed.  The condition may trigger
+	 * spuriously on a newly created cic but there's no harm.
+	 */
+	if (unlikely(!bfqd) || likely(bic->blkcg_serial_nr == serial_nr))
+		goto out;
+
+	bfqg = __bfq_bic_change_cgroup(bfqd, bic, bio_blkcg(bio));
+	bic->blkcg_serial_nr = serial_nr;
+out:
+	rcu_read_unlock();
+}
+
+/**
+ * bfq_flush_idle_tree - deactivate any entity on the idle tree of @st.
+ * @st: the service tree being flushed.
+ */
+static void bfq_flush_idle_tree(struct bfq_service_tree *st)
+{
+	struct bfq_entity *entity = st->first_idle;
+
+	for (; entity ; entity = st->first_idle)
+		__bfq_deactivate_entity(entity, false);
+}
+
+/**
+ * bfq_reparent_leaf_entity - move leaf entity to the root_group.
+ * @bfqd: the device data structure with the root group.
+ * @entity: the entity to move.
+ */
+static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
+				     struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
 }
 
 /**
- * __bfq_lookup_next_entity - return the first eligible entity in @st.
- * @st: the service tree.
+ * bfq_reparent_active_entities - move to the root group all active
+ *                                entities.
+ * @bfqd: the device data structure with the root group.
+ * @bfqg: the group to move from.
+ * @st: the service tree with the entities.
  *
- * Update the virtual time in @st and return the first eligible entity
- * it contains.
+ * Needs queue_lock to be taken and reference to be valid over the call.
  */
-static struct bfq_entity *__bfq_lookup_next_entity(struct bfq_service_tree *st,
-						   bool force)
+static void bfq_reparent_active_entities(struct bfq_data *bfqd,
+					 struct bfq_group *bfqg,
+					 struct bfq_service_tree *st)
 {
-	struct bfq_entity *entity, *new_next_in_service = NULL;
-
-	if (RB_EMPTY_ROOT(&st->active))
-		return NULL;
+	struct rb_root *active = &st->active;
+	struct bfq_entity *entity = NULL;
 
-	bfq_update_vtime(st);
-	entity = bfq_first_active_entity(st);
+	if (!RB_EMPTY_ROOT(&st->active))
+		entity = bfq_entity_of(rb_first(active));
 
-	/*
-	 * If the chosen entity does not match with the sched_data's
-	 * next_in_service and we are forcedly serving the IDLE priority
-	 * class tree, bubble up budget update.
-	 */
-	if (unlikely(force && entity != entity->sched_data->next_in_service)) {
-		new_next_in_service = entity;
-		for_each_entity(new_next_in_service)
-			bfq_update_budget(new_next_in_service);
-	}
+	for (; entity ; entity = bfq_entity_of(rb_first(active)))
+		bfq_reparent_leaf_entity(bfqd, entity);
 
-	return entity;
+	if (bfqg->sched_data.in_service_entity)
+		bfq_reparent_leaf_entity(bfqd,
+			bfqg->sched_data.in_service_entity);
 }
 
 /**
- * bfq_lookup_next_entity - return the first eligible entity in @sd.
- * @sd: the sched_data.
- * @extract: if true the returned entity will be also extracted from @sd.
+ * bfq_pd_offline - deactivate the entity associated with @pd,
+ *		    and reparent its children entities.
+ * @pd: descriptor of the policy going offline.
  *
- * NOTE: since we cache the next_in_service entity at each level of the
- * hierarchy, the complexity of the lookup can be decreased with
- * absolutely no effort just returning the cached next_in_service value;
- * we prefer to do full lookups to test the consistency of the data
- * structures.
+ * blkio already grabs the queue_lock for us, so no need to use
+ * RCU-based magic
  */
-static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
-						 int extract,
-						 struct bfq_data *bfqd)
+static void bfq_pd_offline(struct blkg_policy_data *pd)
 {
-	struct bfq_service_tree *st = sd->service_tree;
-	struct bfq_entity *entity;
-	int i = 0;
+	struct bfq_service_tree *st;
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+	struct bfq_data *bfqd = bfqg->bfqd;
+	struct bfq_entity *entity = bfqg->my_entity;
+	unsigned long flags;
+	int i;
 
+	if (!entity) /* root group */
+		return;
+
+	spin_lock_irqsave(&bfqd->lock, flags);
 	/*
-	 * Choose from idle class, if needed to guarantee a minimum
-	 * bandwidth to this class. This should also mitigate
-	 * priority-inversion problems in case a low priority task is
-	 * holding file system resources.
+	 * Empty all service_trees belonging to this group before
+	 * deactivating the group itself.
 	 */
-	if (bfqd &&
-	    jiffies - bfqd->bfq_class_idle_last_service >
-	    BFQ_CL_IDLE_TIMEOUT) {
-		entity = __bfq_lookup_next_entity(st + BFQ_IOPRIO_CLASSES - 1,
-						  true);
-		if (entity) {
-			i = BFQ_IOPRIO_CLASSES - 1;
-			bfqd->bfq_class_idle_last_service = jiffies;
-			sd->next_in_service = entity;
-		}
-	}
-	for (; i < BFQ_IOPRIO_CLASSES; i++) {
-		entity = __bfq_lookup_next_entity(st + i, false);
-		if (entity) {
-			if (extract) {
-				bfq_check_next_in_service(sd, entity);
-				bfq_active_extract(st + i, entity);
-				sd->in_service_entity = entity;
-				sd->next_in_service = NULL;
-			}
-			break;
-		}
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
+		st = bfqg->sched_data.service_tree + i;
+
+		/*
+		 * The idle tree may still contain bfq_queues belonging
+		 * to exited task because they never migrated to a different
+		 * cgroup from the one being destroyed now.  No one else
+		 * can access them so it's safe to act without any lock.
+		 */
+		bfq_flush_idle_tree(st);
+
+		/*
+		 * It may happen that some queues are still active
+		 * (busy) upon group destruction (if the corresponding
+		 * processes have been forced to terminate). We move
+		 * all the leaf entities corresponding to these queues
+		 * to the root_group.
+		 * Also, it may happen that the group has an entity
+		 * in service, which is disconnected from the active
+		 * tree: it must be moved, too.
+		 * There is no need to put the sync queues, as the
+		 * scheduler has taken no reference.
+		 */
+		bfq_reparent_active_entities(bfqd, bfqg, st);
 	}
 
-	return entity;
+	__bfq_deactivate_entity(entity, false);
+	bfq_put_async_queues(bfqd, bfqg);
+
+	spin_unlock_irqrestore(&bfqd->lock, flags);
+	/*
+	 * @blkg is going offline and will be ignored by
+	 * blkg_[rw]stat_recursive_sum().  Transfer stats to the parent so
+	 * that they don't get lost.  If IOs complete after this point, the
+	 * stats for them will be lost.  Oh well...
+	 */
+	bfqg_stats_xfer_dead(bfqg);
 }
 
-static bool next_queue_may_preempt(struct bfq_data *bfqd)
+static int bfq_io_show_weight(struct seq_file *sf, void *v)
 {
-	struct bfq_sched_data *sd = &bfqd->sched_data;
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+	unsigned int val = 0;
 
-	return sd->next_in_service != sd->in_service_entity;
-}
+	if (bfqgd)
+		val = bfqgd->weight;
 
+	seq_printf(sf, "%u\n", val);
 
-/*
- * Get next queue for service.
- */
-static struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
+	return 0;
+}
+
+static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
+				    struct cftype *cftype,
+				    u64 val)
 {
-	struct bfq_entity *entity = NULL;
-	struct bfq_sched_data *sd;
-	struct bfq_queue *bfqq;
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+	struct blkcg_gq *blkg;
+	int ret = -ERANGE;
 
-	if (bfqd->busy_queues == 0)
-		return NULL;
+	if (val < BFQ_MIN_WEIGHT || val > BFQ_MAX_WEIGHT)
+		return ret;
 
-	sd = &bfqd->sched_data;
-	for (; sd ; sd = entity->my_sched_data) {
-		entity = bfq_lookup_next_entity(sd, 1, bfqd);
-		entity->service = 0;
+	ret = 0;
+	spin_lock_irq(&blkcg->lock);
+	bfqgd->weight = (unsigned short)val;
+	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
+		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
+
+		if (!bfqg)
+			continue;
+		/*
+		 * Setting the prio_changed flag of the entity
+		 * to 1 with new_weight == weight would re-set
+		 * the value of the weight to its ioprio mapping.
+		 * Set the flag only if necessary.
+		 */
+		if ((unsigned short)val != bfqg->entity.new_weight) {
+			bfqg->entity.new_weight = (unsigned short)val;
+			/*
+			 * Make sure that the above new value has been
+			 * stored in bfqg->entity.new_weight before
+			 * setting the prio_changed flag. In fact,
+			 * this flag may be read asynchronously (in
+			 * critical sections protected by a different
+			 * lock than that held here), and finding this
+			 * flag set may cause the execution of the code
+			 * for updating parameters whose value may
+			 * depend also on bfqg->entity.new_weight (in
+			 * __bfq_entity_update_weight_prio).
+			 * This barrier makes sure that the new value
+			 * of bfqg->entity.new_weight is correctly
+			 * seen in that code.
+			 */
+			smp_wmb();
+			bfqg->entity.prio_changed = 1;
+		}
 	}
+	spin_unlock_irq(&blkcg->lock);
 
-	bfqq = bfq_entity_to_bfqq(entity);
+	return ret;
+}
 
-	return bfqq;
+static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
+				 char *buf, size_t nbytes,
+				 loff_t off)
+{
+	u64 weight;
+	/* First unsigned long found in the file is used */
+	int ret = kstrtoull(strim(buf), 0, &weight);
+
+	if (ret)
+		return ret;
+
+	return bfq_io_set_weight_legacy(of_css(of), NULL, weight);
 }
 
-static void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
+static int bfqg_print_stat(struct seq_file *sf, void *v)
 {
-	struct bfq_queue *in_serv_bfqq = bfqd->in_service_queue;
-	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
+			  &blkcg_policy_bfq, seq_cft(sf)->private, false);
+	return 0;
+}
 
-	if (bfqd->in_service_bic) {
-		put_io_context(bfqd->in_service_bic->icq.ioc);
-		bfqd->in_service_bic = NULL;
-	}
+static int bfqg_print_rwstat(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
+			  &blkcg_policy_bfq, seq_cft(sf)->private, true);
+	return 0;
+}
 
-	bfq_clear_bfqq_wait_request(in_serv_bfqq);
-	hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
-	bfqd->in_service_queue = NULL;
+static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
+				      struct blkg_policy_data *pd, int off)
+{
+	u64 sum = blkg_stat_recursive_sum(pd_to_blkg(pd),
+					  &blkcg_policy_bfq, off);
+	return __blkg_prfill_u64(sf, pd, sum);
+}
 
-	/*
-	 * in_serv_entity is no longer in service, so, if it is in no
-	 * service tree either, then release the service reference to
-	 * the queue it represents (taken with bfq_get_entity).
-	 */
-	if (!in_serv_entity->on_st)
-		bfq_put_queue(in_serv_bfqq);
+static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
+					struct blkg_policy_data *pd, int off)
+{
+	struct blkg_rwstat sum = blkg_rwstat_recursive_sum(pd_to_blkg(pd),
+							   &blkcg_policy_bfq,
+							   off);
+	return __blkg_prfill_rwstat(sf, pd, &sum);
 }
 
-static void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-				int requeue)
+static int bfqg_print_stat_recursive(struct seq_file *sf, void *v)
 {
-	struct bfq_entity *entity = &bfqq->entity;
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_stat_recursive, &blkcg_policy_bfq,
+			  seq_cft(sf)->private, false);
+	return 0;
+}
 
-	bfq_deactivate_entity(entity, requeue);
+static int bfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_rwstat_recursive, &blkcg_policy_bfq,
+			  seq_cft(sf)->private, true);
+	return 0;
 }
 
-static void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+static u64 bfqg_prfill_sectors(struct seq_file *sf, struct blkg_policy_data *pd,
+			       int off)
 {
-	struct bfq_entity *entity = &bfqq->entity;
+	u64 sum = blkg_rwstat_total(&pd->blkg->stat_bytes);
 
-	bfq_activate_entity(entity, bfq_bfqq_non_blocking_wait_rq(bfqq));
-	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
+	return __blkg_prfill_u64(sf, pd, sum >> 9);
 }
 
-/*
- * Called when the bfqq no longer has requests pending, remove it from
- * the service tree.
- */
-static void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			      int requeue)
+static int bfqg_print_stat_sectors(struct seq_file *sf, void *v)
 {
-	bfq_log_bfqq(bfqd, bfqq, "del from busy");
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_sectors, &blkcg_policy_bfq, 0, false);
+	return 0;
+}
 
-	bfq_clear_bfqq_busy(bfqq);
+static u64 bfqg_prfill_sectors_recursive(struct seq_file *sf,
+					 struct blkg_policy_data *pd, int off)
+{
+	struct blkg_rwstat tmp = blkg_rwstat_recursive_sum(pd->blkg, NULL,
+					offsetof(struct blkcg_gq, stat_bytes));
+	u64 sum = atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
+		atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_WRITE]);
 
-	bfqd->busy_queues--;
+	return __blkg_prfill_u64(sf, pd, sum >> 9);
+}
 
-	bfq_deactivate_bfqq(bfqd, bfqq, requeue);
+static int bfqg_print_stat_sectors_recursive(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_sectors_recursive, &blkcg_policy_bfq, 0,
+			  false);
+	return 0;
 }
 
-/*
- * Called when an inactive queue receives a new request.
- */
-static void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+static u64 bfqg_prfill_avg_queue_size(struct seq_file *sf,
+				      struct blkg_policy_data *pd, int off)
 {
-	bfq_log_bfqq(bfqd, bfqq, "add to busy");
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+	u64 samples = blkg_stat_read(&bfqg->stats.avg_queue_size_samples);
+	u64 v = 0;
 
-	bfq_activate_bfqq(bfqd, bfqq);
+	if (samples) {
+		v = blkg_stat_read(&bfqg->stats.avg_queue_size_sum);
+		v = div64_u64(v, samples);
+	}
+	__blkg_prfill_u64(sf, pd, v);
+	return 0;
+}
 
-	bfq_mark_bfqq_busy(bfqq);
-	bfqd->busy_queues++;
+/* print avg_queue_size */
+static int bfqg_print_avg_queue_size(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_avg_queue_size, &blkcg_policy_bfq,
+			  0, false);
+	return 0;
+}
+
+static struct bfq_group *
+bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
+{
+	int ret;
+
+	ret = blkcg_activate_policy(bfqd->queue, &blkcg_policy_bfq);
+	if (ret)
+		return NULL;
+
+	return blkg_to_bfqg(bfqd->queue->root_blkg);
 }
 
-static void bfq_init_entity(struct bfq_entity *entity)
+static struct cftype bfq_blkcg_legacy_files[] = {
+	{
+		.name = "bfq.weight",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_weight,
+		.write_u64 = bfq_io_set_weight_legacy,
+	},
+
+	/* statistics, covers only the tasks in the bfqg */
+	{
+		.name = "bfq.time",
+		.private = offsetof(struct bfq_group, stats.time),
+		.seq_show = bfqg_print_stat,
+	},
+	{
+		.name = "bfq.sectors",
+		.seq_show = bfqg_print_stat_sectors,
+	},
+	{
+		.name = "bfq.io_service_bytes",
+		.private = (unsigned long)&blkcg_policy_bfq,
+		.seq_show = blkg_print_stat_bytes,
+	},
+	{
+		.name = "bfq.io_serviced",
+		.private = (unsigned long)&blkcg_policy_bfq,
+		.seq_show = blkg_print_stat_ios,
+	},
+	{
+		.name = "bfq.io_service_time",
+		.private = offsetof(struct bfq_group, stats.service_time),
+		.seq_show = bfqg_print_rwstat,
+	},
+	{
+		.name = "bfq.io_wait_time",
+		.private = offsetof(struct bfq_group, stats.wait_time),
+		.seq_show = bfqg_print_rwstat,
+	},
+	{
+		.name = "bfq.io_merged",
+		.private = offsetof(struct bfq_group, stats.merged),
+		.seq_show = bfqg_print_rwstat,
+	},
+	{
+		.name = "bfq.io_queued",
+		.private = offsetof(struct bfq_group, stats.queued),
+		.seq_show = bfqg_print_rwstat,
+	},
+
+	/* the same statictics which cover the bfqg and its descendants */
+	{
+		.name = "bfq.time_recursive",
+		.private = offsetof(struct bfq_group, stats.time),
+		.seq_show = bfqg_print_stat_recursive,
+	},
+	{
+		.name = "bfq.sectors_recursive",
+		.seq_show = bfqg_print_stat_sectors_recursive,
+	},
+	{
+		.name = "bfq.io_service_bytes_recursive",
+		.private = (unsigned long)&blkcg_policy_bfq,
+		.seq_show = blkg_print_stat_bytes_recursive,
+	},
+	{
+		.name = "bfq.io_serviced_recursive",
+		.private = (unsigned long)&blkcg_policy_bfq,
+		.seq_show = blkg_print_stat_ios_recursive,
+	},
+	{
+		.name = "bfq.io_service_time_recursive",
+		.private = offsetof(struct bfq_group, stats.service_time),
+		.seq_show = bfqg_print_rwstat_recursive,
+	},
+	{
+		.name = "bfq.io_wait_time_recursive",
+		.private = offsetof(struct bfq_group, stats.wait_time),
+		.seq_show = bfqg_print_rwstat_recursive,
+	},
+	{
+		.name = "bfq.io_merged_recursive",
+		.private = offsetof(struct bfq_group, stats.merged),
+		.seq_show = bfqg_print_rwstat_recursive,
+	},
+	{
+		.name = "bfq.io_queued_recursive",
+		.private = offsetof(struct bfq_group, stats.queued),
+		.seq_show = bfqg_print_rwstat_recursive,
+	},
+	{
+		.name = "bfq.avg_queue_size",
+		.seq_show = bfqg_print_avg_queue_size,
+	},
+	{
+		.name = "bfq.group_wait_time",
+		.private = offsetof(struct bfq_group, stats.group_wait_time),
+		.seq_show = bfqg_print_stat,
+	},
+	{
+		.name = "bfq.idle_time",
+		.private = offsetof(struct bfq_group, stats.idle_time),
+		.seq_show = bfqg_print_stat,
+	},
+	{
+		.name = "bfq.empty_time",
+		.private = offsetof(struct bfq_group, stats.empty_time),
+		.seq_show = bfqg_print_stat,
+	},
+	{
+		.name = "bfq.dequeue",
+		.private = offsetof(struct bfq_group, stats.dequeue),
+		.seq_show = bfqg_print_stat,
+	},
+	{ }	/* terminate */
+};
+
+static struct cftype bfq_blkg_files[] = {
+	{
+		.name = "bfq.weight",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_weight,
+		.write = bfq_io_set_weight,
+	},
+	{} /* terminate */
+};
+
+#else	/* CONFIG_BFQ_GROUP_IOSCHED */
+
+static inline void bfqg_stats_update_io_add(struct bfq_group *bfqg,
+			struct bfq_queue *bfqq, unsigned int op) { }
+static inline void
+bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op) { }
+static inline void
+bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op) { }
+static inline void bfqg_stats_update_completion(struct bfq_group *bfqg,
+			uint64_t start_time, uint64_t io_start_time,
+			unsigned int op) { }
+static inline void
+bfqg_stats_set_start_group_wait_time(struct bfq_group *bfqg,
+				     struct bfq_group *curr_bfqg) { }
+static inline void bfqg_stats_end_empty_time(struct bfqg_stats *stats) { }
+static inline void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
+static inline void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
+static inline void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
+static inline void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg) { }
+static inline void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg) { }
+
+static void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			  struct bfq_group *bfqg) {}
+
+static void bfq_init_entity(struct bfq_entity *entity,
+			    struct bfq_group *bfqg)
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 
 	entity->weight = entity->new_weight;
 	entity->orig_weight = entity->new_weight;
+	if (bfqq) {
+		bfqq->ioprio = bfqq->new_ioprio;
+		bfqq->ioprio_class = bfqq->new_ioprio_class;
+	}
+	entity->sched_data = &bfqg->sched_data;
+}
+
+static void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio) {}
+
+static struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
+					    struct blkcg *blkcg)
+{
+	return bfqd->root_group;
+}
+
+static struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
+{
+	return bfqq->bfqd->root_group;
+}
 
-	bfqq->ioprio = bfqq->new_ioprio;
-	bfqq->ioprio_class = bfqq->new_ioprio_class;
+static struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd,
+						    int node)
+{
+	struct bfq_group *bfqg;
+	int i;
+
+	bfqg = kmalloc_node(sizeof(*bfqg), GFP_KERNEL | __GFP_ZERO, node);
+	if (!bfqg)
+		return NULL;
 
-	entity->sched_data = &bfqq->bfqd->sched_data;
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
+		bfqg->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
+
+	return bfqg;
 }
+#endif	/* CONFIG_BFQ_GROUP_IOSCHED */
 
 #define bfq_class_idle(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
 #define bfq_class_rt(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_RT)
@@ -1711,18 +3411,6 @@ static void bfq_init_entity(struct bfq_entity *entity)
 #define bfq_sample_valid(samples)	((samples) > 80)
 
 /*
- * Scheduler run of queue, if there are requests pending and no one in the
- * driver that will restart queueing.
- */
-static void bfq_schedule_dispatch(struct bfq_data *bfqd)
-{
-	if (bfqd->queued != 0) {
-		bfq_log(bfqd, "schedule dispatch");
-		blk_mq_run_hw_queues(bfqd->queue, true);
-	}
-}
-
-/*
  * Lifted from AS - choose which of rq1 and rq2 that is best served now.
  * We choose the request that is closesr to the head right now.  Distance
  * behind the head is penalized and only allowed to a certain extent.
@@ -1905,7 +3593,7 @@ static void bfq_updated_next_req(struct bfq_data *bfqd,
 		entity->budget = new_budget;
 		bfq_log_bfqq(bfqd, bfqq, "updated next rq: new budget %lu",
 					 new_budget);
-		bfq_activate_bfqq(bfqd, bfqq);
+		bfq_requeue_bfqq(bfqd, bfqq);
 	}
 }
 
@@ -2076,6 +3764,8 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 			bfqq->ttime.last_end_request +
 			bfqd->bfq_slice_idle * 3;
 
+	bfqg_stats_update_io_add(bfqq_group(RQ_BFQQ(rq)), bfqq, rq->cmd_flags);
+
 	/*
 	 * Update budget and check whether bfqq may want to preempt
 	 * the in-service queue.
@@ -2195,7 +3885,7 @@ static void bfq_remove_request(struct request_queue *q,
 		bfqq->next_rq = NULL;
 
 		if (bfq_bfqq_busy(bfqq) && bfqq != bfqd->in_service_queue) {
-			bfq_del_bfqq_busy(bfqd, bfqq, 1);
+			bfq_del_bfqq_busy(bfqd, bfqq, false);
 			/*
 			 * bfqq emptied. In normal operation, when
 			 * bfqq is empty, bfqq->entity.service and
@@ -2215,6 +3905,8 @@ static void bfq_remove_request(struct request_queue *q,
 
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending--;
+
+	bfqg_stats_update_io_remove(bfqq_group(bfqq), rq->cmd_flags);
 }
 
 static bool bfq_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
@@ -2300,7 +3992,7 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	struct bfq_queue *bfqq = RQ_BFQQ(rq), *next_bfqq = RQ_BFQQ(next);
 
 	if (!RB_EMPTY_NODE(&rq->rb_node))
-		return;
+		goto end;
 	spin_lock_irq(&bfqq->bfqd->lock);
 
 	/*
@@ -2326,6 +4018,8 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	bfq_remove_request(q, next);
 
 	spin_unlock_irq(&bfqq->bfqd->lock);
+end:
+	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
 }
 
 static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
@@ -2355,6 +4049,7 @@ static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
 				       struct bfq_queue *bfqq)
 {
 	if (bfqq) {
+		bfqg_stats_update_avg_queue_size(bfqq_group(bfqq));
 		bfq_mark_bfqq_budget_new(bfqq);
 		bfq_clear_bfqq_fifo_expire(bfqq);
 
@@ -2441,6 +4136,7 @@ static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 	bfqd->last_idling_start = ktime_get();
 	hrtimer_start(&bfqd->idle_slice_timer, ns_to_ktime(sl),
 		      HRTIMER_MODE_REL);
+	bfqg_stats_set_start_idle_time(bfqq_group(bfqq));
 }
 
 /*
@@ -2490,12 +4186,17 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 
 static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
-	__bfq_bfqd_reset_in_service(bfqd);
-
 	if (RB_EMPTY_ROOT(&bfqq->sort_list))
-		bfq_del_bfqq_busy(bfqd, bfqq, 1);
+		bfq_del_bfqq_busy(bfqd, bfqq, true);
 	else
-		bfq_activate_bfqq(bfqd, bfqq);
+		bfq_requeue_bfqq(bfqd, bfqq);
+
+	/*
+	 * All in-service entities must have been properly deactivated
+	 * or requeued before executing the next function, which
+	 * resets all in-service entites as no more in service.
+	 */
+	__bfq_bfqd_reset_in_service(bfqd);
 }
 
 /**
@@ -2972,6 +4673,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 				 */
 				bfq_clear_bfqq_wait_request(bfqq);
 				hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
+				bfqg_stats_update_idle_time(bfqq_group(bfqq));
 			}
 			goto keep_queue;
 		}
@@ -3159,6 +4861,10 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
  */
 static void bfq_put_queue(struct bfq_queue *bfqq)
 {
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_group *bfqg = bfqq_group(bfqq);
+#endif
+
 	if (bfqq->bfqd)
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d",
 			     bfqq, bfqq->ref);
@@ -3167,7 +4873,12 @@ static void bfq_put_queue(struct bfq_queue *bfqq)
 	if (bfqq->ref)
 		return;
 
+	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p freed", bfqq);
+
 	kmem_cache_free(bfq_pool, bfqq);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	bfqg_put(bfqg);
+#endif
 }
 
 static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
@@ -3323,18 +5034,19 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 }
 
 static struct bfq_queue **bfq_async_queue_prio(struct bfq_data *bfqd,
+					       struct bfq_group *bfqg,
 					       int ioprio_class, int ioprio)
 {
 	switch (ioprio_class) {
 	case IOPRIO_CLASS_RT:
-		return &async_bfqq[0][ioprio];
+		return &bfqg->async_bfqq[0][ioprio];
 	case IOPRIO_CLASS_NONE:
 		ioprio = IOPRIO_NORM;
 		/* fall through */
 	case IOPRIO_CLASS_BE:
-		return &async_bfqq[1][ioprio];
+		return &bfqg->async_bfqq[1][ioprio];
 	case IOPRIO_CLASS_IDLE:
-		return &async_idle_bfqq;
+		return &bfqg->async_idle_bfqq;
 	default:
 		return NULL;
 	}
@@ -3348,11 +5060,18 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	const int ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	struct bfq_queue **async_bfqq = NULL;
 	struct bfq_queue *bfqq;
+	struct bfq_group *bfqg;
 
 	rcu_read_lock();
 
+	bfqg = bfq_find_set_group(bfqd, bio_blkcg(bio));
+	if (!bfqg) {
+		bfqq = &bfqd->oom_bfqq;
+		goto out;
+	}
+
 	if (!is_sync) {
-		async_bfqq = bfq_async_queue_prio(bfqd, ioprio_class,
+		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
 						  ioprio);
 		bfqq = *async_bfqq;
 		if (bfqq)
@@ -3366,7 +5085,7 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	if (bfqq) {
 		bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
 			      is_sync);
-		bfq_init_entity(&bfqq->entity);
+		bfq_init_entity(&bfqq->entity, bfqg);
 		bfq_log_bfqq(bfqd, bfqq, "allocated");
 	} else {
 		bfqq = &bfqd->oom_bfqq;
@@ -3379,9 +5098,14 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	 * prune it.
 	 */
 	if (async_bfqq) {
-		bfqq->ref++;
-		bfq_log_bfqq(bfqd, bfqq,
-			     "get_queue, bfqq not in async: %p, %d",
+		bfqq->ref++; /*
+			      * Extra group reference, w.r.t. sync
+			      * queue. This extra reference is removed
+			      * only if bfqq->bfqg disappears, to
+			      * guarantee that this queue is not freed
+			      * until its group goes away.
+			      */
+		bfq_log_bfqq(bfqd, bfqq, "get_queue, bfqq not in async: %p, %d",
 			     bfqq, bfqq->ref);
 		*async_bfqq = bfqq;
 	}
@@ -3516,6 +5240,7 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		 */
 		bfq_clear_bfqq_wait_request(bfqq);
 		hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
+		bfqg_stats_update_idle_time(bfqq_group(bfqq));
 
 		/*
 		 * The queue is not empty, because a new request just
@@ -3657,6 +5382,11 @@ static void bfq_put_rq_private(struct request_queue *q, struct request *rq)
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd = bfqq->bfqd;
 
+	if (rq->rq_flags & RQF_STARTED)
+		bfqg_stats_update_completion(bfqq_group(bfqq),
+					     rq_start_time_ns(rq),
+					     rq_io_start_time_ns(rq),
+					     rq->cmd_flags);
 
 	if (likely(rq->rq_flags & RQF_STARTED)) {
 		unsigned long flags;
@@ -3707,6 +5437,8 @@ static int bfq_get_rq_private(struct request_queue *q, struct request *rq,
 	if (!bic)
 		goto queue_fail;
 
+	bfq_bic_update_cgroup(bic, bio);
+
 	bfqq = bic_to_bfqq(bic, is_sync);
 	if (!bfqq || bfqq == &bfqd->oom_bfqq) {
 		if (bfqq)
@@ -3803,6 +5535,8 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
 
 	bfq_log(bfqd, "put_async_bfqq: %p", bfqq);
 	if (bfqq) {
+		bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
+
 		bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: putting %p, %d",
 			     bfqq, bfqq->ref);
 		bfq_put_queue(bfqq);
@@ -3811,18 +5545,20 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
 }
 
 /*
- * Release the extra reference of the async queues as the device
- * goes away.
+ * Release all the bfqg references to its async queues.  If we are
+ * deallocating the group these queues may still contain requests, so
+ * we reparent them to the root cgroup (i.e., the only one that will
+ * exist for sure until all the requests on a device are gone).
  */
-static void bfq_put_async_queues(struct bfq_data *bfqd)
+static void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
 	int i, j;
 
 	for (i = 0; i < 2; i++)
 		for (j = 0; j < IOPRIO_BE_NR; j++)
-			__bfq_put_async_bfqq(bfqd, &async_bfqq[i][j]);
+			__bfq_put_async_bfqq(bfqd, &bfqg->async_bfqq[i][j]);
 
-	__bfq_put_async_bfqq(bfqd, &async_idle_bfqq);
+	__bfq_put_async_bfqq(bfqd, &bfqg->async_idle_bfqq);
 }
 
 static void bfq_exit_queue(struct elevator_queue *e)
@@ -3834,20 +5570,42 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	spin_lock_irq(&bfqd->lock);
 	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
-		bfq_deactivate_bfqq(bfqd, bfqq, false);
-	bfq_put_async_queues(bfqd);
+		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	spin_unlock_irq(&bfqd->lock);
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
+#else
+	spin_lock_irq(&bfqd->lock);
+	bfq_put_async_queues(bfqd, bfqd->root_group);
+	kfree(bfqd->root_group);
+	spin_unlock_irq(&bfqd->lock);
+#endif
+
 	kfree(bfqd);
 }
 
+static void bfq_init_root_group(struct bfq_group *root_group,
+				struct bfq_data *bfqd)
+{
+	int i;
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	root_group->entity.parent = NULL;
+	root_group->my_entity = NULL;
+	root_group->bfqd = bfqd;
+#endif
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
+		root_group->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
+	root_group->sched_data.bfq_class_idle_last_service = jiffies;
+}
+
 static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
 	struct elevator_queue *eq;
-	int i;
 
 	eq = elevator_alloc(q, e);
 	if (!eq)
@@ -3860,6 +5618,10 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	}
 	eq->elevator_data = bfqd;
 
+	spin_lock_irq(q->queue_lock);
+	q->elevator = eq;
+	spin_unlock_irq(q->queue_lock);
+
 	/*
 	 * Our fallback bfqq if bfq_find_alloc_queue() runs into OOM issues.
 	 * Grab a permanent reference to it, so that the normal code flow
@@ -3880,8 +5642,7 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
-	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
-		bfqd->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
+	INIT_LIST_HEAD(&bfqd->dispatch);
 
 	hrtimer_init(&bfqd->idle_slice_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
@@ -3899,17 +5660,40 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->bfq_back_max = bfq_back_max;
 	bfqd->bfq_back_penalty = bfq_back_penalty;
 	bfqd->bfq_slice_idle = bfq_slice_idle;
-	bfqd->bfq_class_idle_last_service = 0;
 	bfqd->bfq_timeout = bfq_timeout;
 
 	bfqd->bfq_requests_within_timer = 120;
 
 	spin_lock_init(&bfqd->lock);
-	INIT_LIST_HEAD(&bfqd->dispatch);
 
-	q->elevator = eq;
+	/*
+	 * The invocation of the next bfq_create_group_hierarchy
+	 * function is the head of a chain of function calls
+	 * (bfq_create_group_hierarchy->blkcg_activate_policy->
+	 * blk_mq_freeze_queue) that may lead to the invocation of the
+	 * has_work hook function. For this reason,
+	 * bfq_create_group_hierarchy is invoked only after all
+	 * scheduler data has been initialized, apart from the fields
+	 * that can be initialized only after invoking
+	 * bfq_create_group_hierarchy. This, in particular, enables
+	 * has_work to correctly return false. Of course, to avoid
+	 * other inconsistencies, the blk-mq stack must then refrain
+	 * from invoking further scheduler hooks before this init
+	 * function is finished.
+	 */
+	bfqd->root_group = bfq_create_group_hierarchy(bfqd, q->node);
+	if (!bfqd->root_group)
+		goto out_free;
+	bfq_init_root_group(bfqd->root_group, bfqd);
+	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
+
 
 	return 0;
+
+out_free:
+	kfree(bfqd);
+	kobject_put(&eq->kobj);
+	return -ENOMEM;
 }
 
 static void bfq_slab_kill(void)
@@ -4134,10 +5918,34 @@ static struct elevator_type iosched_bfq_mq = {
 	.elevator_owner =	THIS_MODULE,
 };
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+static struct blkcg_policy blkcg_policy_bfq = {
+	.dfl_cftypes		= bfq_blkg_files,
+	.legacy_cftypes		= bfq_blkcg_legacy_files,
+
+	.cpd_alloc_fn		= bfq_cpd_alloc,
+	.cpd_init_fn		= bfq_cpd_init,
+	.cpd_bind_fn	        = bfq_cpd_init,
+	.cpd_free_fn		= bfq_cpd_free,
+
+	.pd_alloc_fn		= bfq_pd_alloc,
+	.pd_init_fn		= bfq_pd_init,
+	.pd_offline_fn		= bfq_pd_offline,
+	.pd_free_fn		= bfq_pd_free,
+	.pd_reset_stats_fn	= bfq_pd_reset_stats,
+};
+#endif
+
 static int __init bfq_init(void)
 {
 	int ret;
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	ret = blkcg_policy_register(&blkcg_policy_bfq);
+	if (ret)
+		return ret;
+#endif
+
 	ret = -ENOMEM;
 	if (bfq_slab_setup())
 		goto err_pol_unreg;
@@ -4149,12 +5957,18 @@ static int __init bfq_init(void)
 	return 0;
 
 err_pol_unreg:
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	blkcg_policy_unregister(&blkcg_policy_bfq);
+#endif
 	return ret;
 }
 
 static void __exit bfq_exit(void)
 {
 	elv_unregister(&iosched_bfq_mq);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	blkcg_policy_unregister(&blkcg_policy_bfq);
+#endif
 	bfq_slab_kill();
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5a7da60..5b1753e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -48,7 +48,7 @@ struct rq_wb;
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
  */
-#define BLKCG_MAX_POLS		2
+#define BLKCG_MAX_POLS		3
 
 typedef void (rq_end_io_fn)(struct request *, int);
 
-- 
2.10.0
