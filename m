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
Subject: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling and cgroups support
Date: Mon,  1 Feb 2016 23:12:46 +0100
Message-Id: <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Arianna Avanzini <avanzini.arianna@gmail.com>

Complete support for full hierarchical scheduling, with a cgroups
interface. The name of the added policy is bfq.

Weights can be assigned explicitly to groups and processes through the
cgroups interface, differently from what happens, for single
processes, if the cgroups interface is not used (as explained in the
description of the previous patch). In particular, since each node has
a full scheduler, each group can be assigned its own weight.

Signed-off-by: Fabio Checconi <fchecconi@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/Kconfig.iosched |    7 +
 block/bfq.h           |  176 ++++++-
 block/cfq-iosched.c   | 1398 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 1528 insertions(+), 53 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 92a8475..143d44b 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -32,6 +32,13 @@ config IOSCHED_CFQ
 
 	  This is the default I/O scheduler.
 
+config CFQ_GROUP_IOSCHED
+       bool "CFQ Group Scheduling support"
+       depends on IOSCHED_CFQ && BLK_CGROUP
+       default n
+       ---help---
+         Enable group (hierarchical) IO scheduling in CFQ.
+
 choice
 	prompt "Default I/O scheduler"
 	default DEFAULT_CFQ
diff --git a/block/bfq.h b/block/bfq.h
index 7ca6aeb..22088da 100644
--- a/block/bfq.h
+++ b/block/bfq.h
@@ -101,7 +101,7 @@ struct bfq_sched_data {
  * @budget: budget used to calculate F_i; F_i = S_i + @budget / @weight.
  * @weight: weight of the queue
  * @parent: parent entity, for hierarchical scheduling.
- * @my_sched_data: for non-leaf nodes in the hierarchy, the
+ * @my_sched_data: for non-leaf nodes in the cgroup hierarchy, the
  *                 associated scheduler queue, %NULL on leaf nodes.
  * @sched_data: the scheduler queue this entity belongs to.
  * @ioprio: the ioprio in use.
@@ -110,10 +110,11 @@ struct bfq_sched_data {
  * @prio_changed: flag, true when the user requested a weight, ioprio or
  *		  ioprio_class change.
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
@@ -124,13 +125,14 @@ struct bfq_sched_data {
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
 	struct rb_node rb_node;
@@ -156,6 +158,8 @@ struct bfq_entity {
 	int prio_changed;
 };
 
+struct bfq_group;
+
 /**
  * struct bfq_queue - leaf schedulable entity.
  * @ref: reference counter.
@@ -188,7 +192,11 @@ struct bfq_entity {
  * @pid: pid of the process owning the queue, used for logging purposes.
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
 	atomic_t ref;
@@ -252,9 +260,8 @@ struct bfq_io_cq {
 	struct bfq_queue *bfqq[2];
 	struct bfq_ttime ttime;
 	int ioprio;
-
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	uint64_t blkcg_id; /* the current blkcg ID */
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	uint64_t blkcg_serial_nr; /* the current blkcg serial */
 #endif
 };
 
@@ -266,7 +273,7 @@ enum bfq_device_speed {
 /**
  * struct bfq_data - per device data structure.
  * @queue: request queue for the managed device.
- * @sched_data: root @bfq_sched_data for the device.
+ * @root_group: root bfq_group for the device.
  * @busy_queues: number of bfq_queues containing requests (including the
  *		 queue in service, even if it is idling).
  * @queued: number of queued requests.
@@ -319,7 +326,7 @@ enum bfq_device_speed {
 struct bfq_data {
 	struct request_queue *queue;
 
-	struct bfq_sched_data sched_data;
+	struct bfq_group *root_group;
 
 	int busy_queues;
 	int queued;
@@ -404,8 +411,35 @@ BFQ_BFQQ_FNS(IO_bound);
 #undef BFQ_BFQQ_FNS
 
 /* Logging facilities. */
-#define bfq_log_bfqq(bfqd, bfqq, fmt, args...) \
-	blk_add_trace_msg((bfqd)->queue, "bfq%d " fmt, (bfqq)->pid, ##args)
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
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
+#else /* CONFIG_CFQ_GROUP_IOSCHED */
+
+#define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	\
+	blk_add_trace_msg((bfqd)->queue, "bfq%d%c " fmt, (bfqq)->pid,	\
+			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
+				##args)
+#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
+
+#endif /* CONFIG_CFQ_GROUP_IOSCHED */
 
 #define bfq_log(bfqd, fmt, args...) \
 	blk_add_trace_msg((bfqd)->queue, "bfq " fmt, ##args)
@@ -421,6 +455,107 @@ enum bfqq_expiration {
 	BFQ_BFQQ_NO_MORE_REQUESTS,	/* the queue has no more requests */
 };
 
+struct bfqg_stats {
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
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
+#ifdef CONFIG_DEBUG_BLK_CGROUP
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
+#endif	/* CONFIG_DEBUG_BLK_CGROUP */
+#endif	/* CONFIG_CFQ_GROUP_IOSCHED */
+};
+
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
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
 
 static struct bfq_service_tree *
@@ -497,6 +632,7 @@ static void bfq_dispatch_insert(struct request_queue *q, struct request *rq);
 static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 				       struct bio *bio, int is_sync,
 				       struct bfq_io_cq *bic, gfp_t gfp_mask);
+static void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 
 #endif /* _BFQ_H */
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 9d5d62a..c38dcef 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -35,9 +35,15 @@
  * guarantee a low latency to non-I/O bound processes (the latter
  * often belong to time-sensitive applications).
  *
- * B-WF2Q+ is based on WF2Q+, which is described in [2], while the
- * augmented tree used here to implement B-WF2Q+ with O(log N)
- * complexity derives from the one introduced with EEVDF in [3].
+ * With respect to the version of BFQ presented in [1], and in the
+ * papers cited therein, this implementation adds a hierarchical
+ * extension based on H-WF2Q+. In this extension, also the service of
+ * whole groups of queues is scheduled using B-WF2Q+.
+ *
+ * B-WF2Q+ is based on WF2Q+, which is described in [2], together with
+ * H-WF2Q+, while the augmented tree used here to implement B-WF2Q+
+ * with O(log N) complexity derives from the one introduced with EEVDF
+ * in [3].
  *
  * [1] P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
  *     Scheduler", Proceedings of the First Workshop on Mobile System
@@ -60,6 +66,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
+#include <linux/cgroup.h>
 #include <linux/elevator.h>
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
@@ -67,14 +74,6 @@
 #include "bfq.h"
 #include "blk.h"
 
-/*
- * Array of async queues for all the processes, one queue
- * per ioprio value per ioprio_class.
- */
-struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
-/* Async queue for the idle class (ioprio is ignored) */
-struct bfq_queue *async_idle_bfqq;
-
 /* Expiration time of sync (0) and async (1) requests, in jiffies. */
 static const int bfq_fifo_expire[2] = { HZ / 4, HZ / 8 };
 
@@ -152,26 +151,81 @@ static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
 	return NULL;
 }
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+
 #define for_each_entity(entity)	\
-	for (; entity ; entity = NULL)
+	for (; entity ; entity = entity->parent)
 
 #define for_each_entity_safe(entity, parent) \
-	for (parent = NULL; entity ; entity = parent)
+	for (; entity && ({ parent = entity->parent; 1; }); entity = parent)
+
+
+static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
+						 int extract,
+						 struct bfq_data *bfqd);
+
+static void bfq_update_budget(struct bfq_entity *next_in_service)
+{
+	struct bfq_entity *bfqg_entity;
+	struct bfq_group *bfqg;
+	struct bfq_sched_data *group_sd;
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
+	if (bfqg_entity)
+		bfqg_entity->budget = next_in_service->budget;
+}
 
 static int bfq_update_next_in_service(struct bfq_sched_data *sd)
 {
-	return 0;
+	struct bfq_entity *next_in_service;
+
+	if (sd->in_service_entity)
+		/* will update/requeue at the end of service */
+		return 0;
+
+	/*
+	 * NOTE: this can be improved in many ways, such as returning
+	 * 1 (and thus propagating upwards the update) only when the
+	 * budget changes, or caching the bfqq that will be scheduled
+	 * next from this subtree.  By now we worry more about
+	 * correctness than about performance...
+	 */
+	next_in_service = bfq_lookup_next_entity(sd, 0, NULL);
+	sd->next_in_service = next_in_service;
+
+	if (next_in_service)
+		bfq_update_budget(next_in_service);
+
+	return 1;
 }
 
-static void bfq_check_next_in_service(struct bfq_sched_data *sd,
-				      struct bfq_entity *entity)
+#else /* CONFIG_CFQ_GROUP_IOSCHED */
+
+#define for_each_entity(entity)	\
+	for (; entity ; entity = NULL)
+
+#define for_each_entity_safe(entity, parent) \
+	for (parent = NULL; entity ; entity = parent)
+
+static int bfq_update_next_in_service(struct bfq_sched_data *sd)
 {
+	return 0;
 }
 
 static void bfq_update_budget(struct bfq_entity *next_in_service)
 {
 }
 
+#endif /* CONFIG_CFQ_GROUP_IOSCHED */
+
 /*
  * Shift for timestamp calculations.  This actually limits the maximum
  * service allowed in one timestamp delta (small shift values increase it),
@@ -411,6 +465,11 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 	struct rb_node *node = &entity->rb_node;
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	struct bfq_sched_data *sd = NULL;
+	struct bfq_group *bfqg = NULL;
+	struct bfq_data *bfqd = NULL;
+#endif
 
 	bfq_insert(&st->active, entity);
 
@@ -421,6 +480,11 @@ static void bfq_active_insert(struct bfq_service_tree *st,
 
 	bfq_update_active_tree(node);
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	sd = entity->sched_data;
+	bfqg = container_of(sd, struct bfq_group, sched_data);
+	bfqd = (struct bfq_data *)bfqg->bfqd;
+#endif
 	if (bfqq)
 		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
 }
@@ -499,6 +563,11 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 	struct rb_node *node;
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	struct bfq_sched_data *sd = NULL;
+	struct bfq_group *bfqg = NULL;
+	struct bfq_data *bfqd = NULL;
+#endif
 
 	node = bfq_find_deepest(&entity->rb_node);
 	bfq_extract(&st->active, entity);
@@ -506,6 +575,11 @@ static void bfq_active_extract(struct bfq_service_tree *st,
 	if (node)
 		bfq_update_active_tree(node);
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	sd = entity->sched_data;
+	bfqg = container_of(sd, struct bfq_group, sched_data);
+	bfqd = (struct bfq_data *)bfqg->bfqd;
+#endif
 	if (bfqq)
 		list_del(&bfqq->bfqq_list);
 }
@@ -605,9 +679,20 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 		unsigned short prev_weight, new_weight;
 		struct bfq_data *bfqd = NULL;
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+		struct bfq_sched_data *sd;
+		struct bfq_group *bfqg;
+#endif
 
 		if (bfqq)
 			bfqd = bfqq->bfqd;
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+		else {
+			sd = entity->my_sched_data;
+			bfqg = container_of(sd, struct bfq_group, sched_data);
+			bfqd = (struct bfq_data *)bfqg->bfqd;
+		}
+#endif
 
 		old_st->wsum -= entity->weight;
 
@@ -653,6 +738,11 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 	return new_st;
 }
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+static void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
+static struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
+#endif
+
 /**
  * bfq_bfqq_served - update the scheduler status after selection for
  *                   service.
@@ -676,6 +766,9 @@ static void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
 		st->vtime += bfq_delta(served, st->wsum);
 		bfq_forget_idle(st);
 	}
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	bfqg_stats_set_start_empty_time(bfqq_group(bfqq));
+#endif
 	bfq_log_bfqq(bfqq->bfqd, bfqq, "bfqq_served %d secs", served);
 }
 
@@ -796,13 +889,16 @@ static void bfq_activate_entity(struct bfq_entity *entity)
 static int __bfq_deactivate_entity(struct bfq_entity *entity, int requeue)
 {
 	struct bfq_sched_data *sd = entity->sched_data;
-	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
-	int was_in_service = entity == sd->in_service_entity;
+	struct bfq_service_tree *st;
+	int was_in_service;
 	int ret = 0;
 
-	if (!entity->on_st)
+	if (sd == NULL || !entity->on_st) /* never activated, or inactive now */
 		return 0;
 
+	st = bfq_entity_service_tree(entity);
+	was_in_service = entity == sd->in_service_entity;
+
 	if (was_in_service) {
 		bfq_calc_finish(entity, entity->service);
 		sd->in_service_entity = NULL;
@@ -941,8 +1037,8 @@ left:
  * Update the virtual time in @st and return the first eligible entity
  * it contains.
  */
-static struct bfq_entity *__bfq_lookup_next_entity(struct bfq_service_tree *st,
-						   bool force)
+static struct bfq_entity *
+__bfq_lookup_next_entity(struct bfq_service_tree *st, bool force)
 {
 	struct bfq_entity *entity, *new_next_in_service = NULL;
 
@@ -1000,7 +1096,6 @@ static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd,
 		entity = __bfq_lookup_next_entity(st + i, false);
 		if (entity) {
 			if (extract) {
-				bfq_check_next_in_service(sd, entity);
 				bfq_active_extract(st + i, entity);
 				sd->in_service_entity = entity;
 				sd->next_in_service = NULL;
@@ -1024,7 +1119,7 @@ static struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
 	if (bfqd->busy_queues == 0)
 		return NULL;
 
-	sd = &bfqd->sched_data;
+	sd = &bfqd->root_group->sched_data;
 	for (; sd ; sd = entity->my_sched_data) {
 		entity = bfq_lookup_next_entity(sd, 1, bfqd);
 		entity->service = 0;
@@ -1064,6 +1159,10 @@ static void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_activate_entity(entity);
 }
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+static void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
+#endif
+
 /*
  * Called when the bfqq no longer has requests pending, remove it from
  * the service tree.
@@ -1077,6 +1176,10 @@ static void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqd->busy_queues--;
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	bfqg_stats_update_dequeue(bfqq_group(bfqq));
+#endif
+
 	bfq_deactivate_bfqq(bfqd, bfqq, requeue);
 }
 
@@ -1093,6 +1196,1109 @@ static void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfqd->busy_queues++;
 }
 
+#if defined(CONFIG_CFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
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
+#else	/* CONFIG_CFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
+
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
+#endif	/* CONFIG_CFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
+
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
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
+				     int rw)
+{
+	blkg_rwstat_add(&bfqg->stats.queued, rw, 1);
+	bfqg_stats_end_empty_time(&bfqg->stats);
+	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
+		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
+}
+
+static void bfqg_stats_update_io_remove(struct bfq_group *bfqg, int rw)
+{
+	blkg_rwstat_add(&bfqg->stats.queued, rw, -1);
+}
+
+static void bfqg_stats_update_io_merged(struct bfq_group *bfqg, int rw)
+{
+	blkg_rwstat_add(&bfqg->stats.merged, rw, 1);
+}
+
+static void bfqg_stats_update_completion(struct bfq_group *bfqg,
+			uint64_t start_time, uint64_t io_start_time, int rw)
+{
+	struct bfqg_stats *stats = &bfqg->stats;
+	unsigned long long now = sched_clock();
+
+	if (time_after64(now, io_start_time))
+		blkg_rwstat_add(&stats->service_time, rw, now - io_start_time);
+	if (time_after64(io_start_time, start_time))
+		blkg_rwstat_add(&stats->wait_time, rw,
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
+#ifdef CONFIG_DEBUG_BLK_CGROUP
+	blkg_stat_reset(&stats->avg_queue_size_sum);
+	blkg_stat_reset(&stats->avg_queue_size_samples);
+	blkg_stat_reset(&stats->dequeue);
+	blkg_stat_reset(&stats->group_wait_time);
+	blkg_stat_reset(&stats->idle_time);
+	blkg_stat_reset(&stats->empty_time);
+#endif
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
+#ifdef CONFIG_DEBUG_BLK_CGROUP
+	blkg_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
+	blkg_stat_add_aux(&to->avg_queue_size_samples,
+			  &from->avg_queue_size_samples);
+	blkg_stat_add_aux(&to->dequeue, &from->dequeue);
+	blkg_stat_add_aux(&to->group_wait_time, &from->group_wait_time);
+	blkg_stat_add_aux(&to->idle_time, &from->idle_time);
+	blkg_stat_add_aux(&to->empty_time, &from->empty_time);
+#endif
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
+	entity->parent = bfqg->my_entity;
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
+#ifdef CONFIG_DEBUG_BLK_CGROUP
+	blkg_stat_exit(&stats->avg_queue_size_sum);
+	blkg_stat_exit(&stats->avg_queue_size_samples);
+	blkg_stat_exit(&stats->dequeue);
+	blkg_stat_exit(&stats->group_wait_time);
+	blkg_stat_exit(&stats->idle_time);
+	blkg_stat_exit(&stats->empty_time);
+#endif
+}
+
+static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
+{
+	if (blkg_rwstat_init(&stats->merged, gfp) ||
+	    blkg_rwstat_init(&stats->service_time, gfp) ||
+	    blkg_rwstat_init(&stats->wait_time, gfp) ||
+	    blkg_rwstat_init(&stats->queued, gfp) ||
+	    blkg_stat_init(&stats->time, gfp))
+		goto err;
+
+#ifdef CONFIG_DEBUG_BLK_CGROUP
+	if (blkg_stat_init(&stats->avg_queue_size_sum, gfp) ||
+	    blkg_stat_init(&stats->avg_queue_size_samples, gfp) ||
+	    blkg_stat_init(&stats->dequeue, gfp) ||
+	    blkg_stat_init(&stats->group_wait_time, gfp) ||
+	    blkg_stat_init(&stats->idle_time, gfp) ||
+	    blkg_stat_init(&stats->empty_time, gfp))
+		goto err;
+#endif
+	return 0;
+err:
+	bfqg_stats_exit(stats);
+	return -ENOMEM;
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
+	bgd = kzalloc(sizeof(*bgd), GFP_KERNEL);
+	if (!bgd)
+		return NULL;
+	return &bgd->pd;
+}
+
+static void bfq_cpd_init(struct blkcg_policy_data *cpd)
+{
+	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
+
+	d->weight = BFQ_DEFAULT_GRP_WEIGHT;
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
+static struct bfq_group *bfq_find_alloc_group(struct bfq_data *bfqd,
+					      struct blkcg *blkcg)
+{
+	struct request_queue *q = bfqd->queue;
+	struct bfq_group *bfqg = NULL, *parent;
+	struct bfq_entity *entity = NULL;
+
+	assert_spin_locked(bfqd->queue->queue_lock);
+
+	/* avoid lookup for the common case where there's no blkcg */
+	if (blkcg == &blkcg_root) {
+		bfqg = bfqd->root_group;
+	} else {
+		struct blkcg_gq *blkg;
+
+		blkg = blkg_lookup_create(blkcg, q);
+		if (!IS_ERR(blkg))
+			bfqg = blkg_to_bfqg(blkg);
+		else /* fallback to root_group */
+			bfqg = bfqd->root_group;
+	}
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
+/**
+ * bfq_bfqq_move - migrate @bfqq to @bfqg.
+ * @bfqd: queue descriptor.
+ * @bfqq: the queue to move.
+ * @entity: @bfqq's entity.
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
+			  struct bfq_entity *entity, struct bfq_group *bfqg)
+{
+	int busy, resume;
+
+	busy = bfq_bfqq_busy(bfqq);
+	resume = !RB_EMPTY_ROOT(&bfqq->sort_list);
+
+	if (busy) {
+		if (!resume)
+			bfq_del_bfqq_busy(bfqd, bfqq, 0);
+		else
+			bfq_deactivate_bfqq(bfqd, bfqq, 0);
+	} else if (entity->on_st)
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
+	if (busy && resume)
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
+	lockdep_assert_held(bfqd->queue->queue_lock);
+
+	bfqg = bfq_find_alloc_group(bfqd, blkcg);
+	if (async_bfqq) {
+		entity = &async_bfqq->entity;
+
+		if (entity->sched_data != &bfqg->sched_data) {
+			bic_set_bfqq(bic, NULL, 0);
+			bfq_log_bfqq(bfqd, async_bfqq,
+				     "bic_change_group: %p %d",
+				     async_bfqq,
+				     atomic_read(&async_bfqq->ref));
+			bfq_put_queue(async_bfqq);
+		}
+	}
+
+	if (sync_bfqq) {
+		entity = &sync_bfqq->entity;
+		if (entity->sched_data != &bfqg->sched_data)
+			bfq_bfqq_move(bfqd, sync_bfqq, entity, bfqg);
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
+	rcu_read_unlock();
+
+	/*
+	 * Check whether blkcg has changed.  The condition may trigger
+	 * spuriously on a newly created cic but there's no harm.
+	 */
+	if (unlikely(!bfqd) || likely(bic->blkcg_serial_nr == serial_nr))
+		return;
+
+	bfqg = __bfq_bic_change_cgroup(bfqd, bic, bio_blkcg(bio));
+	bic->blkcg_serial_nr = serial_nr;
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
+		__bfq_deactivate_entity(entity, 0);
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
+	bfq_bfqq_move(bfqd, bfqq, entity, bfqd->root_group);
+}
+
+/**
+ * bfq_reparent_active_entities - move to the root group all active
+ *                                entities.
+ * @bfqd: the device data structure with the root group.
+ * @bfqg: the group to move from.
+ * @st: the service tree with the entities.
+ *
+ * Needs queue_lock to be taken and reference to be valid over the call.
+ */
+static void bfq_reparent_active_entities(struct bfq_data *bfqd,
+					 struct bfq_group *bfqg,
+					 struct bfq_service_tree *st)
+{
+	struct rb_root *active = &st->active;
+	struct bfq_entity *entity = NULL;
+
+	if (!RB_EMPTY_ROOT(&st->active))
+		entity = bfq_entity_of(rb_first(active));
+
+	for (; entity ; entity = bfq_entity_of(rb_first(active)))
+		bfq_reparent_leaf_entity(bfqd, entity);
+
+	if (bfqg->sched_data.in_service_entity)
+		bfq_reparent_leaf_entity(bfqd,
+			bfqg->sched_data.in_service_entity);
+}
+
+/**
+ * bfq_pd_offline - deactivate the entity associated with @pd,
+ *		    and reparent its children entities.
+ * @pd: descriptor of the policy going offline.
+ *
+ * blkio already grabs the queue_lock for us, so no need to use
+ * RCU-based magic
+ */
+static void bfq_pd_offline(struct blkg_policy_data *pd)
+{
+	struct bfq_service_tree *st;
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+	struct bfq_data *bfqd = bfqg->bfqd;
+	struct bfq_entity *entity = bfqg->my_entity;
+	int i;
+
+	if (!entity) /* root group */
+		return;
+
+	/*
+	 * Empty all service_trees belonging to this group before
+	 * deactivating the group itself.
+	 */
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
+	}
+
+	__bfq_deactivate_entity(entity, 0);
+	bfq_put_async_queues(bfqd, bfqg);
+
+	/*
+	 * @blkg is going offline and will be ignored by
+	 * blkg_[rw]stat_recursive_sum().  Transfer stats to the parent so
+	 * that they don't get lost.  If IOs complete after this point, the
+	 * stats for them will be lost.  Oh well...
+	 */
+	bfqg_stats_xfer_dead(bfqg);
+}
+
+static int bfq_io_show_weight(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+	unsigned int val = 0;
+
+	if (bfqgd)
+		val = bfqgd->weight;
+
+	seq_printf(sf, "%u\n", val);
+
+	return 0;
+}
+
+static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
+				    struct cftype *cftype,
+				    u64 val)
+{
+	struct blkcg *blkcg = css_to_blkcg(css);
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+	struct blkcg_gq *blkg;
+	int ret = -EINVAL;
+
+	if (val < BFQ_MIN_WEIGHT || val > BFQ_MAX_WEIGHT)
+		return ret;
+
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
+	}
+	spin_unlock_irq(&blkcg->lock);
+
+	return ret;
+}
+
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
+}
+
+static int bfqg_print_stat(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
+			  &blkcg_policy_bfq, seq_cft(sf)->private, false);
+	return 0;
+}
+
+static int bfqg_print_rwstat(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
+			  &blkcg_policy_bfq, seq_cft(sf)->private, true);
+	return 0;
+}
+
+static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
+				      struct blkg_policy_data *pd, int off)
+{
+	u64 sum = blkg_stat_recursive_sum(pd_to_blkg(pd),
+					  &blkcg_policy_bfq, off);
+	return __blkg_prfill_u64(sf, pd, sum);
+}
+
+static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
+					struct blkg_policy_data *pd, int off)
+{
+	struct blkg_rwstat sum = blkg_rwstat_recursive_sum(pd_to_blkg(pd),
+							   &blkcg_policy_bfq,
+							   off);
+	return __blkg_prfill_rwstat(sf, pd, &sum);
+}
+
+static int bfqg_print_stat_recursive(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_stat_recursive, &blkcg_policy_bfq,
+			  seq_cft(sf)->private, false);
+	return 0;
+}
+
+static int bfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_rwstat_recursive, &blkcg_policy_bfq,
+			  seq_cft(sf)->private, true);
+	return 0;
+}
+
+static u64 bfqg_prfill_sectors(struct seq_file *sf, struct blkg_policy_data *pd,
+			       int off)
+{
+	u64 sum = blkg_rwstat_total(&pd->blkg->stat_bytes);
+
+	return __blkg_prfill_u64(sf, pd, sum >> 9);
+}
+
+static int bfqg_print_stat_sectors(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_sectors, &blkcg_policy_bfq, 0, false);
+	return 0;
+}
+
+static u64 bfqg_prfill_sectors_recursive(struct seq_file *sf,
+					 struct blkg_policy_data *pd, int off)
+{
+	struct blkg_rwstat tmp = blkg_rwstat_recursive_sum(pd->blkg, NULL,
+					offsetof(struct blkcg_gq, stat_bytes));
+	u64 sum = atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
+		atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_WRITE]);
+
+	return __blkg_prfill_u64(sf, pd, sum >> 9);
+}
+
+static int bfqg_print_stat_sectors_recursive(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_sectors_recursive, &blkcg_policy_bfq, 0,
+			  false);
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_BLK_CGROUP
+static u64 bfqg_prfill_avg_queue_size(struct seq_file *sf,
+				      struct blkg_policy_data *pd, int off)
+{
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+	u64 samples = blkg_stat_read(&bfqg->stats.avg_queue_size_samples);
+	u64 v = 0;
+
+	if (samples) {
+		v = blkg_stat_read(&bfqg->stats.avg_queue_size_sum);
+		v = div64_u64(v, samples);
+	}
+	__blkg_prfill_u64(sf, pd, v);
+	return 0;
+}
+
+/* print avg_queue_size */
+static int bfqg_print_avg_queue_size(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_avg_queue_size, &blkcg_policy_bfq,
+			  0, false);
+	return 0;
+}
+#endif /* CONFIG_DEBUG_BLK_CGROUP */
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
+}
+
+static struct cftype bfq_blkcg_legacy_files[] = {
+	{
+		.name = "weight",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_weight,
+		.write_u64 = bfq_io_set_weight_legacy,
+	},
+
+	/* statistics, covers only the tasks in the bfqg */
+	{
+		.name = "time",
+		.private = offsetof(struct bfq_group, stats.time),
+		.seq_show = bfqg_print_stat,
+	},
+	{
+		.name = "sectors",
+		.seq_show = bfqg_print_stat_sectors,
+	},
+	{
+		.name = "io_service_bytes",
+		.private = (unsigned long)&blkcg_policy_bfq,
+		.seq_show = blkg_print_stat_bytes,
+	},
+	{
+		.name = "io_serviced",
+		.private = (unsigned long)&blkcg_policy_bfq,
+		.seq_show = blkg_print_stat_ios,
+	},
+	{
+		.name = "io_service_time",
+		.private = offsetof(struct bfq_group, stats.service_time),
+		.seq_show = bfqg_print_rwstat,
+	},
+	{
+		.name = "io_wait_time",
+		.private = offsetof(struct bfq_group, stats.wait_time),
+		.seq_show = bfqg_print_rwstat,
+	},
+	{
+		.name = "io_merged",
+		.private = offsetof(struct bfq_group, stats.merged),
+		.seq_show = bfqg_print_rwstat,
+	},
+	{
+		.name = "io_queued",
+		.private = offsetof(struct bfq_group, stats.queued),
+		.seq_show = bfqg_print_rwstat,
+	},
+
+	/* the same statictics which cover the bfqg and its descendants */
+	{
+		.name = "time_recursive",
+		.private = offsetof(struct bfq_group, stats.time),
+		.seq_show = bfqg_print_stat_recursive,
+	},
+	{
+		.name = "sectors_recursive",
+		.seq_show = bfqg_print_stat_sectors_recursive,
+	},
+	{
+		.name = "io_service_bytes_recursive",
+		.private = (unsigned long)&blkcg_policy_bfq,
+		.seq_show = blkg_print_stat_bytes_recursive,
+	},
+	{
+		.name = "io_serviced_recursive",
+		.private = (unsigned long)&blkcg_policy_bfq,
+		.seq_show = blkg_print_stat_ios_recursive,
+	},
+	{
+		.name = "io_service_time_recursive",
+		.private = offsetof(struct bfq_group, stats.service_time),
+		.seq_show = bfqg_print_rwstat_recursive,
+	},
+	{
+		.name = "io_wait_time_recursive",
+		.private = offsetof(struct bfq_group, stats.wait_time),
+		.seq_show = bfqg_print_rwstat_recursive,
+	},
+	{
+		.name = "io_merged_recursive",
+		.private = offsetof(struct bfq_group, stats.merged),
+		.seq_show = bfqg_print_rwstat_recursive,
+	},
+	{
+		.name = "io_queued_recursive",
+		.private = offsetof(struct bfq_group, stats.queued),
+		.seq_show = bfqg_print_rwstat_recursive,
+	},
+#ifdef CONFIG_DEBUG_BLK_CGROUP
+	{
+		.name = "avg_queue_size",
+		.seq_show = bfqg_print_avg_queue_size,
+	},
+	{
+		.name = "group_wait_time",
+		.private = offsetof(struct bfq_group, stats.group_wait_time),
+		.seq_show = bfqg_print_stat,
+	},
+	{
+		.name = "idle_time",
+		.private = offsetof(struct bfq_group, stats.idle_time),
+		.seq_show = bfqg_print_stat,
+	},
+	{
+		.name = "empty_time",
+		.private = offsetof(struct bfq_group, stats.empty_time),
+		.seq_show = bfqg_print_stat,
+	},
+	{
+		.name = "dequeue",
+		.private = offsetof(struct bfq_group, stats.dequeue),
+		.seq_show = bfqg_print_stat,
+	},
+#endif	/* CONFIG_DEBUG_BLK_CGROUP */
+	{ }	/* terminate */
+};
+
+static struct cftype bfq_blkg_files[] = {
+	{
+		.name = "weight",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_weight,
+		.write = bfq_io_set_weight,
+	},
+	{} /* terminate */
+};
+
+#else /* CONFIG_CFQ_GROUP_IOSCHED */
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
+	}
+	entity->sched_data = &bfqg->sched_data;
+}
+
+static struct bfq_group *
+bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
+{
+	struct bfq_data *bfqd = bic_to_bfqd(bic);
+
+	return bfqd->root_group;
+}
+
+static void bfq_bfqq_move(struct bfq_data *bfqd,
+			  struct bfq_queue *bfqq,
+			  struct bfq_entity *entity,
+			  struct bfq_group *bfqg)
+{
+}
+
+static void bfq_disconnect_groups(struct bfq_data *bfqd)
+{
+	bfq_put_async_queues(bfqd, bfqd->root_group);
+}
+
+static struct bfq_group *bfq_find_alloc_group(struct bfq_data *bfqd,
+					      struct blkcg *blkcg)
+{
+	return bfqd->root_group;
+}
+
+static struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd,
+						    int node)
+{
+	struct bfq_group *bfqg;
+	int i;
+
+	bfqg = kmalloc_node(sizeof(*bfqg), GFP_KERNEL | __GFP_ZERO, node);
+	if (!bfqg)
+		return NULL;
+
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
+		bfqg->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
+
+	return bfqg;
+}
+#endif /* CONFIG_CFQ_GROUP_IOSCHED */
+
 #define bfq_class_idle(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
 #define bfq_class_rt(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_RT)
 
@@ -1302,6 +2508,10 @@ static void bfq_add_request(struct request *rq)
 	bfqq->next_rq = next_rq;
 
 	if (!bfq_bfqq_busy(bfqq)) {
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+		bfqg_stats_update_io_add(bfqq_group(RQ_BFQQ(rq)), bfqq,
+					 rq->cmd_flags);
+#endif
 		entity->budget = max_t(unsigned long, bfqq->max_budget,
 				       bfq_serv_to_charge(next_rq, bfqq));
 
@@ -1382,6 +2592,10 @@ static void bfq_remove_request(struct request *rq)
 
 	if (rq->cmd_flags & REQ_META)
 		bfqq->meta_pending--;
+
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	bfqg_stats_update_io_remove(bfqq_group(bfqq), rq->cmd_flags);
+#endif
 }
 
 static int bfq_merge(struct request_queue *q, struct request **req,
@@ -1428,6 +2642,14 @@ static void bfq_merged_request(struct request_queue *q, struct request *req,
 	}
 }
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+static void bfq_bio_merged(struct request_queue *q, struct request *req,
+			   struct bio *bio)
+{
+	bfqg_stats_update_io_merged(bfqq_group(RQ_BFQQ(req)), bio->bi_rw);
+}
+#endif
+
 static void bfq_merged_requests(struct request_queue *q, struct request *rq,
 				struct request *next)
 {
@@ -1454,6 +2676,9 @@ static void bfq_merged_requests(struct request_queue *q, struct request *rq,
 		bfqq->next_rq = rq;
 
 	bfq_remove_request(next);
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
+#endif
 }
 
 static int bfq_allow_merge(struct request_queue *q, struct request *rq,
@@ -1487,6 +2712,9 @@ static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
 				       struct bfq_queue *bfqq)
 {
 	if (bfqq) {
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+		bfqg_stats_update_avg_queue_size(bfqq_group(bfqq));
+#endif
 		bfq_mark_bfqq_must_alloc(bfqq);
 		bfq_mark_bfqq_budget_new(bfqq);
 		bfq_clear_bfqq_fifo_expire(bfqq);
@@ -1595,6 +2823,9 @@ static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 
 	bfqd->last_idling_start = ktime_get();
 	mod_timer(&bfqd->idle_slice_timer, jiffies + sl);
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	bfqg_stats_set_start_idle_time(bfqq_group(bfqq));
+#endif
 	bfq_log(bfqd, "arm idle: %u/%u ms",
 		jiffies_to_msecs(sl), jiffies_to_msecs(bfqd->bfq_slice_idle));
 }
@@ -2088,6 +3319,9 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 				 */
 				bfq_clear_bfqq_wait_request(bfqq);
 				del_timer(&bfqd->idle_slice_timer);
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+				bfqg_stats_update_idle_time(bfqq_group(bfqq));
+#endif
 			}
 			goto keep_queue;
 		}
@@ -2282,6 +3516,9 @@ static int bfq_dispatch_requests(struct request_queue *q, int force)
 static void bfq_put_queue(struct bfq_queue *bfqq)
 {
 	struct bfq_data *bfqd = bfqq->bfqd;
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	struct bfq_group *bfqg = bfqq_group(bfqq);
+#endif
 
 	bfq_log_bfqq(bfqd, bfqq, "put_queue: %p %d", bfqq,
 		     atomic_read(&bfqq->ref));
@@ -2291,6 +3528,9 @@ static void bfq_put_queue(struct bfq_queue *bfqq)
 	bfq_log_bfqq(bfqd, bfqq, "put_queue: %p freed", bfqq);
 
 	kmem_cache_free(bfq_pool, bfqq);
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	bfqg_put(bfqg);
+#endif
 }
 
 static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
@@ -2446,11 +3686,15 @@ static struct bfq_queue *bfq_find_alloc_queue(struct bfq_data *bfqd,
 					      struct bfq_io_cq *bic,
 					      gfp_t gfp_mask)
 {
+	struct bfq_group *bfqg;
 	struct bfq_queue *bfqq, *new_bfqq = NULL;
+	struct blkcg *blkcg;
 
 retry:
 	rcu_read_lock();
 
+	blkcg = bio_blkcg(bio);
+	bfqg = bfq_find_alloc_group(bfqd, blkcg);
 	/* bic always exists here */
 	bfqq = bic_to_bfqq(bic, is_sync);
 
@@ -2481,6 +3725,7 @@ retry:
 		if (bfqq) {
 			bfq_init_bfqq(bfqd, bfqq, bic, current->pid,
 				      is_sync);
+			bfq_init_entity(&bfqq->entity, bfqg);
 			bfq_log_bfqq(bfqd, bfqq, "allocated");
 		} else {
 			bfqq = &bfqd->oom_bfqq;
@@ -2497,18 +3742,19 @@ retry:
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
@@ -2524,7 +3770,14 @@ static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 	struct bfq_queue *bfqq = NULL;
 
 	if (!is_sync) {
-		async_bfqq = bfq_async_queue_prio(bfqd, ioprio_class,
+		struct blkcg *blkcg;
+		struct bfq_group *bfqg;
+
+		rcu_read_lock();
+		blkcg = bio_blkcg(bio);
+		rcu_read_unlock();
+		bfqg = bfq_find_alloc_group(bfqd, blkcg);
+		async_bfqq = bfq_async_queue_prio(bfqd, bfqg, ioprio_class,
 						  ioprio);
 		bfqq = *async_bfqq;
 	}
@@ -2685,6 +3938,9 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		 */
 		bfq_clear_bfqq_wait_request(bfqq);
 		del_timer(&bfqd->idle_slice_timer);
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+		bfqg_stats_update_idle_time(bfqq_group(bfqq));
+#endif
 
 		/*
 		 * The queue is not empty, because a new request just
@@ -2758,6 +4014,11 @@ static void bfq_completed_request(struct request_queue *q, struct request *rq)
 
 	bfqd->rq_in_driver--;
 	bfqq->dispatched--;
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	bfqg_stats_update_completion(bfqq_group(bfqq),
+				     rq_start_time_ns(rq),
+				     rq_io_start_time_ns(rq), rq->cmd_flags);
+#endif
 
 	if (sync) {
 		bfqd->sync_flight--;
@@ -2869,6 +4130,8 @@ static int bfq_set_request(struct request_queue *q, struct request *rq,
 	if (!bic)
 		goto queue_fail;
 
+	bfq_bic_update_cgroup(bic, bio);
+
 	bfqq = bic_to_bfqq(bic, is_sync);
 	if (!bfqq || bfqq == &bfqd->oom_bfqq) {
 		bfqq = bfq_get_queue(bfqd, bio, is_sync, bic, gfp_mask);
@@ -2965,10 +4228,12 @@ static void bfq_shutdown_timer_wq(struct bfq_data *bfqd)
 static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
 					struct bfq_queue **bfqq_ptr)
 {
+	struct bfq_group *root_group = bfqd->root_group;
 	struct bfq_queue *bfqq = *bfqq_ptr;
 
 	bfq_log(bfqd, "put_async_bfqq: %p", bfqq);
 	if (bfqq) {
+		bfq_bfqq_move(bfqd, bfqq, &bfqq->entity, root_group);
 		bfq_log_bfqq(bfqd, bfqq, "put_async_bfqq: putting %p, %d",
 			     bfqq, atomic_read(&bfqq->ref));
 		bfq_put_queue(bfqq);
@@ -2977,18 +4242,20 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
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
@@ -3004,16 +4271,37 @@ static void bfq_exit_queue(struct elevator_queue *e)
 	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
 		bfq_deactivate_bfqq(bfqd, bfqq, 0);
 
-	bfq_put_async_queues(bfqd);
+#ifndef CONFIG_CFQ_GROUP_IOSCHED
+	bfq_disconnect_groups(bfqd);
+#endif
 	spin_unlock_irq(q->queue_lock);
 
 	bfq_shutdown_timer_wq(bfqd);
 
 	synchronize_rcu();
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	blkcg_deactivate_policy(q, &blkcg_policy_bfq);
+#else
+	kfree(bfqd->root_group);
+#endif
 	kfree(bfqd);
 }
 
+static void bfq_init_root_group(struct bfq_group *root_group,
+				struct bfq_data *bfqd)
+{
+	int i;
+
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	root_group->entity.parent = NULL;
+	root_group->my_entity = NULL;
+	root_group->bfqd = bfqd;
+#endif
+	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
+		root_group->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
+}
+
 static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct bfq_data *bfqd;
@@ -3054,6 +4342,12 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	q->elevator = eq;
 	spin_unlock_irq(q->queue_lock);
 
+	bfqd->root_group = bfq_create_group_hierarchy(bfqd, q->node);
+	if (!bfqd->root_group)
+		goto out_free;
+	bfq_init_root_group(bfqd->root_group, bfqd);
+	bfq_init_entity(&bfqd->oom_bfqq.entity, bfqd->root_group);
+
 	init_timer(&bfqd->idle_slice_timer);
 	bfqd->idle_slice_timer.function = bfq_idle_slice_timer;
 	bfqd->idle_slice_timer.data = (unsigned long)bfqd;
@@ -3080,6 +4374,11 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->bfq_requests_within_timer = 120;
 
 	return 0;
+
+out_free:
+	kfree(bfqd);
+	kobject_put(&eq->kobj);
+	return -ENOMEM;
 }
 
 static void bfq_slab_kill(void)
@@ -3294,6 +4593,9 @@ static struct elevator_type iosched_bfq = {
 		.elevator_merge_fn =		bfq_merge,
 		.elevator_merged_fn =		bfq_merged_request,
 		.elevator_merge_req_fn =	bfq_merged_requests,
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+		.elevator_bio_merged_fn =	bfq_bio_merged,
+#endif
 		.elevator_allow_merge_fn =	bfq_allow_merge,
 		.elevator_dispatch_fn =		bfq_dispatch_requests,
 		.elevator_add_req_fn =		bfq_insert_request,
@@ -3317,6 +4619,24 @@ static struct elevator_type iosched_bfq = {
 	.elevator_owner =	THIS_MODULE,
 };
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+static struct blkcg_policy blkcg_policy_bfq = {
+	.dfl_cftypes		= bfq_blkg_files,
+	.legacy_cftypes		= bfq_blkcg_legacy_files,
+
+	.cpd_alloc_fn		= bfq_cpd_alloc,
+	.cpd_init_fn		= bfq_cpd_init,
+	.cpd_bind_fn	       = bfq_cpd_init,
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
@@ -3330,6 +4650,12 @@ static int __init bfq_init(void)
 	if (bfq_timeout_async == 0)
 		bfq_timeout_async = 1;
 
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	ret = blkcg_policy_register(&blkcg_policy_bfq);
+	if (ret)
+		return ret;
+#endif
+
 	ret = -ENOMEM;
 	if (bfq_slab_setup())
 		goto err_pol_unreg;
@@ -3343,11 +4669,17 @@ static int __init bfq_init(void)
 	return 0;
 
 err_pol_unreg:
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	blkcg_policy_unregister(&blkcg_policy_bfq);
+#endif
 	return ret;
 }
 
 static void __exit bfq_exit(void)
 {
+#ifdef CONFIG_CFQ_GROUP_IOSCHED
+	blkcg_policy_unregister(&blkcg_policy_bfq);
+#endif
 	elv_unregister(&iosched_bfq);
 	bfq_slab_kill();
 }
-- 
1.9.1
