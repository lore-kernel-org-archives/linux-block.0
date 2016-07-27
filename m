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
Subject: [PATCH RFC V8 05/22] block, cfq: get rid of hierarchical support
Date: Wed, 27 Jul 2016 18:13:21 +0200
Message-Id: <1469636018-31247-6-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
References: <2D83ACA0-2513-4019-9A0D-3166FDDE7485@linaro.org>
 <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Arianna Avanzini <avanzini.arianna@gmail.com>

BFQ implements hierarchical support in a radically different way with
respect to CFQ. CFQ reduces hierarchical scheduling to flat scheduling
by a clever tree-flattening mechanism. Unfortunately, such a scheme
suffers from a large deviation with respect to an ideal and smooth
service (such an ideal service also guarantees low latencies and
jitters). This is not a problem with CFQ, because its engine already
suffers from a similar deviation. Instead, such a deviation would
render useless, in a hierarchical setting, the tight service
guarantees provided by BFQ. For this reason, BFQ implements
hierarchical scheduling in such an accurate way to fully preserve its
tight service guarantees.

This commit removes CFQ's hierarchical support, while one of the next
commit then adds BFQ's one.

Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/Kconfig.iosched |    7 -
 block/cfq-iosched.c   | 2139 ++++---------------------------------------------
 2 files changed, 160 insertions(+), 1986 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 421bef9..8bd1051 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -32,13 +32,6 @@ config IOSCHED_CFQ
 
 	  This is the default I/O scheduler.
 
-config CFQ_GROUP_IOSCHED
-	bool "CFQ Group Scheduling support"
-	depends on IOSCHED_CFQ && BLK_CGROUP
-	default n
-	---help---
-	  Enable group IO scheduling in CFQ.
-
 choice
 	prompt "Default I/O scheduler"
 	default DEFAULT_CFQ
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index fc53555..fab01e2 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -14,7 +14,6 @@
 #include <linux/rbtree.h>
 #include <linux/ioprio.h>
 #include <linux/blktrace_api.h>
-#include <linux/blk-cgroup.h>
 #include "blk.h"
 
 /*
@@ -31,7 +30,6 @@ static const int cfq_slice_sync = HZ / 10;
 static int cfq_slice_async = HZ / 25;
 static const int cfq_slice_async_rq = 2;
 static int cfq_slice_idle = HZ / 125;
-static int cfq_group_idle = HZ / 125;
 static const int cfq_target_latency = HZ * 3/10; /* 300 ms */
 static const int cfq_hist_divisor = 4;
 
@@ -55,7 +53,6 @@ static const int cfq_hist_divisor = 4;
 
 #define RQ_CIC(rq)		icq_to_cic((rq)->elv.icq)
 #define RQ_CFQQ(rq)		(struct cfq_queue *) ((rq)->elv.priv[0])
-#define RQ_CFQG(rq)		(struct cfq_group *) ((rq)->elv.priv[1])
 
 static struct kmem_cache *cfq_pool;
 
@@ -64,12 +61,6 @@ static struct kmem_cache *cfq_pool;
 #define cfq_class_rt(cfqq)	((cfqq)->ioprio_class == IOPRIO_CLASS_RT)
 
 #define sample_valid(samples)	((samples) > 80)
-#define rb_entry_cfqg(node)	rb_entry((node), struct cfq_group, rb_node)
-
-/* blkio-related constants */
-#define CFQ_WEIGHT_LEGACY_MIN	10
-#define CFQ_WEIGHT_LEGACY_DFL	500
-#define CFQ_WEIGHT_LEGACY_MAX	1000
 
 struct cfq_ttime {
 	unsigned long last_end_request;
@@ -149,7 +140,6 @@ struct cfq_queue {
 
 	struct cfq_rb_root *service_tree;
 	struct cfq_queue *new_cfqq;
-	struct cfq_group *cfqg;
 	/* Number of sectors dispatched from queue in single dispatch round */
 	unsigned long nr_sectors;
 };
@@ -174,111 +164,20 @@ enum wl_type_t {
 	SYNC_WORKLOAD = 2
 };
 
-struct cfqg_stats {
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	/* number of ios merged */
-	struct blkg_rwstat		merged;
-	/* total time spent on device in ns, may not be accurate w/ queueing */
-	struct blkg_rwstat		service_time;
-	/* total time spent waiting in scheduler queue in ns */
-	struct blkg_rwstat		wait_time;
-	/* number of IOs queued up */
-	struct blkg_rwstat		queued;
-	/* total disk time and nr sectors dispatched by this group */
-	struct blkg_stat		time;
-#ifdef CONFIG_DEBUG_BLK_CGROUP
-	/* time not charged to this cgroup */
-	struct blkg_stat		unaccounted_time;
-	/* sum of number of ios queued across all samples */
-	struct blkg_stat		avg_queue_size_sum;
-	/* count of samples taken for average */
-	struct blkg_stat		avg_queue_size_samples;
-	/* how many times this group has been removed from service tree */
-	struct blkg_stat		dequeue;
-	/* total time spent waiting for it to be assigned a timeslice. */
-	struct blkg_stat		group_wait_time;
-	/* time spent idling for this blkcg_gq */
-	struct blkg_stat		idle_time;
-	/* total time with empty current active q with other requests queued */
-	struct blkg_stat		empty_time;
-	/* fields after this shouldn't be cleared on stat reset */
-	uint64_t			start_group_wait_time;
-	uint64_t			start_idle_time;
-	uint64_t			start_empty_time;
-	uint16_t			flags;
-#endif	/* CONFIG_DEBUG_BLK_CGROUP */
-#endif	/* CONFIG_CFQ_GROUP_IOSCHED */
-};
-
-/* Per-cgroup data */
-struct cfq_group_data {
-	/* must be the first member */
-	struct blkcg_policy_data cpd;
-
-	unsigned int weight;
-	unsigned int leaf_weight;
+struct cfq_io_cq {
+	struct io_cq		icq;		/* must be the first member */
+	struct cfq_queue	*cfqq[2];
+	struct cfq_ttime	ttime;
+	int			ioprio;		/* the current ioprio */
 };
 
-/* This is per cgroup per device grouping structure */
-struct cfq_group {
-	/* must be the first member */
-	struct blkg_policy_data pd;
-
-	/* group service_tree member */
-	struct rb_node rb_node;
-
-	/* group service_tree key */
-	u64 vdisktime;
-
-	/*
-	 * The number of active cfqgs and sum of their weights under this
-	 * cfqg.  This covers this cfqg's leaf_weight and all children's
-	 * weights, but does not cover weights of further descendants.
-	 *
-	 * If a cfqg is on the service tree, it's active.  An active cfqg
-	 * also activates its parent and contributes to the children_weight
-	 * of the parent.
-	 */
-	int nr_active;
-	unsigned int children_weight;
-
-	/*
-	 * vfraction is the fraction of vdisktime that the tasks in this
-	 * cfqg are entitled to.  This is determined by compounding the
-	 * ratios walking up from this cfqg to the root.
-	 *
-	 * It is in fixed point w/ CFQ_SERVICE_SHIFT and the sum of all
-	 * vfractions on a service tree is approximately 1.  The sum may
-	 * deviate a bit due to rounding errors and fluctuations caused by
-	 * cfqgs entering and leaving the service tree.
-	 */
-	unsigned int vfraction;
-
-	/*
-	 * There are two weights - (internal) weight is the weight of this
-	 * cfqg against the sibling cfqgs.  leaf_weight is the wight of
-	 * this cfqg against the child cfqgs.  For the root cfqg, both
-	 * weights are kept in sync for backward compatibility.
-	 */
-	unsigned int weight;
-	unsigned int new_weight;
-	unsigned int dev_weight;
-
-	unsigned int leaf_weight;
-	unsigned int new_leaf_weight;
-	unsigned int dev_leaf_weight;
-
-	/* number of cfqq currently on this group */
-	int nr_cfqq;
+/*
+ * Per block device queue structure
+ */
+struct cfq_data {
+	struct request_queue *queue;
 
 	/*
-	 * Per group busy queues average. Useful for workload slice calc. We
-	 * create the array for each prio class but at run time it is used
-	 * only for RT and BE class and slot for IDLE class remains unused.
-	 * This is primarily done to avoid confusion and a gcc warning.
-	 */
-	unsigned int busy_queues_avg[CFQ_PRIO_NR];
-	/*
 	 * rr lists of queues with requests. We maintain service trees for
 	 * RT and BE classes. These trees are subdivided in subclasses
 	 * of SYNC, SYNC_NOIDLE and ASYNC based on workload type. For IDLE
@@ -289,47 +188,12 @@ struct cfq_group {
 	struct cfq_rb_root service_trees[2][3];
 	struct cfq_rb_root service_tree_idle;
 
-	unsigned long saved_wl_slice;
-	enum wl_type_t saved_wl_type;
-	enum wl_class_t saved_wl_class;
-
-	/* number of requests that are on the dispatch list or inside driver */
-	int dispatched;
-	struct cfq_ttime ttime;
-	struct cfqg_stats stats;	/* stats for this cfqg */
-
-	/* async queue for each priority case */
-	struct cfq_queue *async_cfqq[2][IOPRIO_BE_NR];
-	struct cfq_queue *async_idle_cfqq;
-
-};
-
-struct cfq_io_cq {
-	struct io_cq		icq;		/* must be the first member */
-	struct cfq_queue	*cfqq[2];
-	struct cfq_ttime	ttime;
-	int			ioprio;		/* the current ioprio */
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	uint64_t		blkcg_serial_nr; /* the current blkcg serial */
-#endif
-};
-
-/*
- * Per block device queue structure
- */
-struct cfq_data {
-	struct request_queue *queue;
-	/* Root service tree for cfq_groups */
-	struct cfq_rb_root grp_service_tree;
-	struct cfq_group *root_group;
-
 	/*
 	 * The priority currently being served
 	 */
 	enum wl_class_t serving_wl_class;
 	enum wl_type_t serving_wl_type;
 	unsigned long workload_expires;
-	struct cfq_group *serving_group;
 
 	unsigned int busy_queues;
 	unsigned int busy_sync_queues;
@@ -360,6 +224,10 @@ struct cfq_data {
 	struct cfq_queue *active_queue;
 	struct cfq_io_cq *active_cic;
 
+	/* async queue for each priority case */
+	struct cfq_queue *async_cfqq[2][IOPRIO_BE_NR];
+	struct cfq_queue *async_idle_cfqq;
+
 	sector_t last_position;
 
 	/*
@@ -372,7 +240,6 @@ struct cfq_data {
 	unsigned int cfq_slice[2];
 	unsigned int cfq_slice_async_rq;
 	unsigned int cfq_slice_idle;
-	unsigned int cfq_group_idle;
 	unsigned int cfq_latency;
 	unsigned int cfq_target_latency;
 
@@ -384,22 +251,6 @@ struct cfq_data {
 	unsigned long last_delayed_sync;
 };
 
-static struct cfq_group *cfq_get_next_cfqg(struct cfq_data *cfqd);
-static void cfq_put_queue(struct cfq_queue *cfqq);
-
-static struct cfq_rb_root *st_for(struct cfq_group *cfqg,
-					    enum wl_class_t class,
-					    enum wl_type_t type)
-{
-	if (!cfqg)
-		return NULL;
-
-	if (class == IDLE_WORKLOAD)
-		return &cfqg->service_tree_idle;
-
-	return &cfqg->service_trees[class][type];
-}
-
 enum cfqq_state_flags {
 	CFQ_CFQQ_FLAG_on_rr = 0,	/* on round-robin busy list */
 	CFQ_CFQQ_FLAG_wait_request,	/* waiting for a request */
@@ -439,385 +290,34 @@ CFQ_CFQQ_FNS(sync);
 CFQ_CFQQ_FNS(wait_busy);
 #undef CFQ_CFQQ_FNS
 
-#if defined(CONFIG_CFQ_GROUP_IOSCHED) && defined(CONFIG_DEBUG_BLK_CGROUP)
-
-/* cfqg stats flags */
-enum cfqg_stats_flags {
-	CFQG_stats_waiting = 0,
-	CFQG_stats_idling,
-	CFQG_stats_empty,
-};
-
-#define CFQG_FLAG_FNS(name)						\
-static inline void cfqg_stats_mark_##name(struct cfqg_stats *stats)	\
-{									\
-	stats->flags |= (1 << CFQG_stats_##name);			\
-}									\
-static inline void cfqg_stats_clear_##name(struct cfqg_stats *stats)	\
-{									\
-	stats->flags &= ~(1 << CFQG_stats_##name);			\
-}									\
-static inline int cfqg_stats_##name(struct cfqg_stats *stats)		\
-{									\
-	return (stats->flags & (1 << CFQG_stats_##name)) != 0;		\
-}									\
-
-CFQG_FLAG_FNS(waiting)
-CFQG_FLAG_FNS(idling)
-CFQG_FLAG_FNS(empty)
-#undef CFQG_FLAG_FNS
-
-/* This should be called with the queue_lock held. */
-static void cfqg_stats_update_group_wait_time(struct cfqg_stats *stats)
-{
-	unsigned long long now;
-
-	if (!cfqg_stats_waiting(stats))
-		return;
-
-	now = sched_clock();
-	if (time_after64(now, stats->start_group_wait_time))
-		blkg_stat_add(&stats->group_wait_time,
-			      now - stats->start_group_wait_time);
-	cfqg_stats_clear_waiting(stats);
-}
-
-/* This should be called with the queue_lock held. */
-static void cfqg_stats_set_start_group_wait_time(struct cfq_group *cfqg,
-						 struct cfq_group *curr_cfqg)
-{
-	struct cfqg_stats *stats = &cfqg->stats;
-
-	if (cfqg_stats_waiting(stats))
-		return;
-	if (cfqg == curr_cfqg)
-		return;
-	stats->start_group_wait_time = sched_clock();
-	cfqg_stats_mark_waiting(stats);
-}
-
-/* This should be called with the queue_lock held. */
-static void cfqg_stats_end_empty_time(struct cfqg_stats *stats)
-{
-	unsigned long long now;
-
-	if (!cfqg_stats_empty(stats))
-		return;
-
-	now = sched_clock();
-	if (time_after64(now, stats->start_empty_time))
-		blkg_stat_add(&stats->empty_time,
-			      now - stats->start_empty_time);
-	cfqg_stats_clear_empty(stats);
-}
-
-static void cfqg_stats_update_dequeue(struct cfq_group *cfqg)
-{
-	blkg_stat_add(&cfqg->stats.dequeue, 1);
-}
-
-static void cfqg_stats_set_start_empty_time(struct cfq_group *cfqg)
-{
-	struct cfqg_stats *stats = &cfqg->stats;
-
-	if (blkg_rwstat_total(&stats->queued))
-		return;
-
-	/*
-	 * group is already marked empty. This can happen if cfqq got new
-	 * request in parent group and moved to this group while being added
-	 * to service tree. Just ignore the event and move on.
-	 */
-	if (cfqg_stats_empty(stats))
-		return;
-
-	stats->start_empty_time = sched_clock();
-	cfqg_stats_mark_empty(stats);
-}
-
-static void cfqg_stats_update_idle_time(struct cfq_group *cfqg)
-{
-	struct cfqg_stats *stats = &cfqg->stats;
-
-	if (cfqg_stats_idling(stats)) {
-		unsigned long long now = sched_clock();
-
-		if (time_after64(now, stats->start_idle_time))
-			blkg_stat_add(&stats->idle_time,
-				      now - stats->start_idle_time);
-		cfqg_stats_clear_idling(stats);
-	}
-}
-
-static void cfqg_stats_set_start_idle_time(struct cfq_group *cfqg)
-{
-	struct cfqg_stats *stats = &cfqg->stats;
-
-	BUG_ON(cfqg_stats_idling(stats));
-
-	stats->start_idle_time = sched_clock();
-	cfqg_stats_mark_idling(stats);
-}
-
-static void cfqg_stats_update_avg_queue_size(struct cfq_group *cfqg)
-{
-	struct cfqg_stats *stats = &cfqg->stats;
-
-	blkg_stat_add(&stats->avg_queue_size_sum,
-		      blkg_rwstat_total(&stats->queued));
-	blkg_stat_add(&stats->avg_queue_size_samples, 1);
-	cfqg_stats_update_group_wait_time(stats);
-}
-
-#else	/* CONFIG_CFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
-
-static inline void cfqg_stats_set_start_group_wait_time(struct cfq_group *cfqg, struct cfq_group *curr_cfqg) { }
-static inline void cfqg_stats_end_empty_time(struct cfqg_stats *stats) { }
-static inline void cfqg_stats_update_dequeue(struct cfq_group *cfqg) { }
-static inline void cfqg_stats_set_start_empty_time(struct cfq_group *cfqg) { }
-static inline void cfqg_stats_update_idle_time(struct cfq_group *cfqg) { }
-static inline void cfqg_stats_set_start_idle_time(struct cfq_group *cfqg) { }
-static inline void cfqg_stats_update_avg_queue_size(struct cfq_group *cfqg) { }
-
-#endif	/* CONFIG_CFQ_GROUP_IOSCHED && CONFIG_DEBUG_BLK_CGROUP */
-
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-
-static inline struct cfq_group *pd_to_cfqg(struct blkg_policy_data *pd)
-{
-	return pd ? container_of(pd, struct cfq_group, pd) : NULL;
-}
-
-static struct cfq_group_data
-*cpd_to_cfqgd(struct blkcg_policy_data *cpd)
-{
-	return cpd ? container_of(cpd, struct cfq_group_data, cpd) : NULL;
-}
-
-static inline struct blkcg_gq *cfqg_to_blkg(struct cfq_group *cfqg)
-{
-	return pd_to_blkg(&cfqg->pd);
-}
-
-static struct blkcg_policy blkcg_policy_cfq;
-
-static inline struct cfq_group *blkg_to_cfqg(struct blkcg_gq *blkg)
-{
-	return pd_to_cfqg(blkg_to_pd(blkg, &blkcg_policy_cfq));
-}
-
-static struct cfq_group_data *blkcg_to_cfqgd(struct blkcg *blkcg)
-{
-	return cpd_to_cfqgd(blkcg_to_cpd(blkcg, &blkcg_policy_cfq));
-}
-
-static inline struct cfq_group *cfqg_parent(struct cfq_group *cfqg)
-{
-	struct blkcg_gq *pblkg = cfqg_to_blkg(cfqg)->parent;
-
-	return pblkg ? blkg_to_cfqg(pblkg) : NULL;
-}
-
-static inline bool cfqg_is_descendant(struct cfq_group *cfqg,
-				      struct cfq_group *ancestor)
-{
-	return cgroup_is_descendant(cfqg_to_blkg(cfqg)->blkcg->css.cgroup,
-				    cfqg_to_blkg(ancestor)->blkcg->css.cgroup);
-}
-
-static inline void cfqg_get(struct cfq_group *cfqg)
-{
-	return blkg_get(cfqg_to_blkg(cfqg));
-}
-
-static inline void cfqg_put(struct cfq_group *cfqg)
-{
-	return blkg_put(cfqg_to_blkg(cfqg));
-}
-
-#define cfq_log_cfqq(cfqd, cfqq, fmt, args...)	do {			\
-	char __pbuf[128];						\
-									\
-	blkg_path(cfqg_to_blkg((cfqq)->cfqg), __pbuf, sizeof(__pbuf));	\
-	blk_add_trace_msg((cfqd)->queue, "cfq%d%c%c %s " fmt, (cfqq)->pid, \
-			cfq_cfqq_sync((cfqq)) ? 'S' : 'A',		\
-			cfqq_type((cfqq)) == SYNC_NOIDLE_WORKLOAD ? 'N' : ' ',\
-			  __pbuf, ##args);				\
-} while (0)
-
-#define cfq_log_cfqg(cfqd, cfqg, fmt, args...)	do {			\
-	char __pbuf[128];						\
-									\
-	blkg_path(cfqg_to_blkg(cfqg), __pbuf, sizeof(__pbuf));		\
-	blk_add_trace_msg((cfqd)->queue, "%s " fmt, __pbuf, ##args);	\
-} while (0)
-
-static inline void cfqg_stats_update_io_add(struct cfq_group *cfqg,
-					    struct cfq_group *curr_cfqg, int rw)
-{
-	blkg_rwstat_add(&cfqg->stats.queued, rw, 1);
-	cfqg_stats_end_empty_time(&cfqg->stats);
-	cfqg_stats_set_start_group_wait_time(cfqg, curr_cfqg);
-}
-
-static inline void cfqg_stats_update_timeslice_used(struct cfq_group *cfqg,
-			unsigned long time, unsigned long unaccounted_time)
-{
-	blkg_stat_add(&cfqg->stats.time, time);
-#ifdef CONFIG_DEBUG_BLK_CGROUP
-	blkg_stat_add(&cfqg->stats.unaccounted_time, unaccounted_time);
-#endif
-}
-
-static inline void cfqg_stats_update_io_remove(struct cfq_group *cfqg, int rw)
-{
-	blkg_rwstat_add(&cfqg->stats.queued, rw, -1);
-}
-
-static inline void cfqg_stats_update_io_merged(struct cfq_group *cfqg, int rw)
-{
-	blkg_rwstat_add(&cfqg->stats.merged, rw, 1);
-}
-
-static inline void cfqg_stats_update_completion(struct cfq_group *cfqg,
-			uint64_t start_time, uint64_t io_start_time, int rw)
-{
-	struct cfqg_stats *stats = &cfqg->stats;
-	unsigned long long now = sched_clock();
-
-	if (time_after64(now, io_start_time))
-		blkg_rwstat_add(&stats->service_time, rw, now - io_start_time);
-	if (time_after64(io_start_time, start_time))
-		blkg_rwstat_add(&stats->wait_time, rw,
-				io_start_time - start_time);
-}
-
-/* @stats = 0 */
-static void cfqg_stats_reset(struct cfqg_stats *stats)
-{
-	/* queued stats shouldn't be cleared */
-	blkg_rwstat_reset(&stats->merged);
-	blkg_rwstat_reset(&stats->service_time);
-	blkg_rwstat_reset(&stats->wait_time);
-	blkg_stat_reset(&stats->time);
-#ifdef CONFIG_DEBUG_BLK_CGROUP
-	blkg_stat_reset(&stats->unaccounted_time);
-	blkg_stat_reset(&stats->avg_queue_size_sum);
-	blkg_stat_reset(&stats->avg_queue_size_samples);
-	blkg_stat_reset(&stats->dequeue);
-	blkg_stat_reset(&stats->group_wait_time);
-	blkg_stat_reset(&stats->idle_time);
-	blkg_stat_reset(&stats->empty_time);
-#endif
-}
-
-/* @to += @from */
-static void cfqg_stats_add_aux(struct cfqg_stats *to, struct cfqg_stats *from)
-{
-	/* queued stats shouldn't be cleared */
-	blkg_rwstat_add_aux(&to->merged, &from->merged);
-	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
-	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
-	blkg_stat_add_aux(&from->time, &from->time);
-#ifdef CONFIG_DEBUG_BLK_CGROUP
-	blkg_stat_add_aux(&to->unaccounted_time, &from->unaccounted_time);
-	blkg_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
-	blkg_stat_add_aux(&to->avg_queue_size_samples, &from->avg_queue_size_samples);
-	blkg_stat_add_aux(&to->dequeue, &from->dequeue);
-	blkg_stat_add_aux(&to->group_wait_time, &from->group_wait_time);
-	blkg_stat_add_aux(&to->idle_time, &from->idle_time);
-	blkg_stat_add_aux(&to->empty_time, &from->empty_time);
-#endif
-}
-
-/*
- * Transfer @cfqg's stats to its parent's aux counts so that the ancestors'
- * recursive stats can still account for the amount used by this cfqg after
- * it's gone.
- */
-static void cfqg_stats_xfer_dead(struct cfq_group *cfqg)
-{
-	struct cfq_group *parent = cfqg_parent(cfqg);
-
-	lockdep_assert_held(cfqg_to_blkg(cfqg)->q->queue_lock);
-
-	if (unlikely(!parent))
-		return;
-
-	cfqg_stats_add_aux(&parent->stats, &cfqg->stats);
-	cfqg_stats_reset(&cfqg->stats);
-}
-
-#else	/* CONFIG_CFQ_GROUP_IOSCHED */
-
-static inline struct cfq_group *cfqg_parent(struct cfq_group *cfqg) { return NULL; }
-static inline bool cfqg_is_descendant(struct cfq_group *cfqg,
-				      struct cfq_group *ancestor)
-{
-	return true;
-}
-static inline void cfqg_get(struct cfq_group *cfqg) { }
-static inline void cfqg_put(struct cfq_group *cfqg) { }
-
 #define cfq_log_cfqq(cfqd, cfqq, fmt, args...)	\
 	blk_add_trace_msg((cfqd)->queue, "cfq%d%c%c " fmt, (cfqq)->pid,	\
 			cfq_cfqq_sync((cfqq)) ? 'S' : 'A',		\
 			cfqq_type((cfqq)) == SYNC_NOIDLE_WORKLOAD ? 'N' : ' ',\
 				##args)
-#define cfq_log_cfqg(cfqd, cfqg, fmt, args...)		do {} while (0)
-
-static inline void cfqg_stats_update_io_add(struct cfq_group *cfqg,
-			struct cfq_group *curr_cfqg, int rw) { }
-static inline void cfqg_stats_update_timeslice_used(struct cfq_group *cfqg,
-			unsigned long time, unsigned long unaccounted_time) { }
-static inline void cfqg_stats_update_io_remove(struct cfq_group *cfqg, int rw) { }
-static inline void cfqg_stats_update_io_merged(struct cfq_group *cfqg, int rw) { }
-static inline void cfqg_stats_update_completion(struct cfq_group *cfqg,
-			uint64_t start_time, uint64_t io_start_time, int rw) { }
-
-#endif	/* CONFIG_CFQ_GROUP_IOSCHED */
-
 #define cfq_log(cfqd, fmt, args...)	\
 	blk_add_trace_msg((cfqd)->queue, "cfq " fmt, ##args)
 
-/* Traverses through cfq group service trees */
-#define for_each_cfqg_st(cfqg, i, j, st) \
+/* Traverses through cfq service trees */
+#define for_each_st(cfqd, i, j, st) \
 	for (i = 0; i <= IDLE_WORKLOAD; i++) \
-		for (j = 0, st = i < IDLE_WORKLOAD ? &cfqg->service_trees[i][j]\
-			: &cfqg->service_tree_idle; \
+		for (j = 0, st = i < IDLE_WORKLOAD ? &cfqd->service_trees[i][j]\
+			: &cfqd->service_tree_idle; \
 			(i < IDLE_WORKLOAD && j <= SYNC_WORKLOAD) || \
 			(i == IDLE_WORKLOAD && j == 0); \
 			j++, st = i < IDLE_WORKLOAD ? \
-			&cfqg->service_trees[i][j]: NULL) \
+			&cfqd->service_trees[i][j] : NULL) \
 
 static inline bool cfq_io_thinktime_big(struct cfq_data *cfqd,
-	struct cfq_ttime *ttime, bool group_idle)
+	struct cfq_ttime *ttime)
 {
 	unsigned long slice;
 	if (!sample_valid(ttime->ttime_samples))
 		return false;
-	if (group_idle)
-		slice = cfqd->cfq_group_idle;
-	else
-		slice = cfqd->cfq_slice_idle;
+	slice = cfqd->cfq_slice_idle;
 	return ttime->ttime_mean > slice;
 }
 
-static inline bool iops_mode(struct cfq_data *cfqd)
-{
-	/*
-	 * If we are not idling on queues and it is a NCQ drive, parallel
-	 * execution of requests is on and measuring time is not possible
-	 * in most of the cases until and unless we drive shallower queue
-	 * depths and that becomes a performance bottleneck. In such cases
-	 * switch to start providing fairness in terms of number of IOs.
-	 */
-	if (!cfqd->cfq_slice_idle && cfqd->hw_tag)
-		return true;
-	else
-		return false;
-}
-
 static inline enum wl_class_t cfqq_class(struct cfq_queue *cfqq)
 {
 	if (cfq_class_idle(cfqq))
@@ -837,23 +337,21 @@ static enum wl_type_t cfqq_type(struct cfq_queue *cfqq)
 	return SYNC_WORKLOAD;
 }
 
-static inline int cfq_group_busy_queues_wl(enum wl_class_t wl_class,
-					struct cfq_data *cfqd,
-					struct cfq_group *cfqg)
+static inline int cfq_busy_queues_wl(enum wl_class_t wl_class,
+					struct cfq_data *cfqd)
 {
 	if (wl_class == IDLE_WORKLOAD)
-		return cfqg->service_tree_idle.count;
+		return cfqd->service_tree_idle.count;
 
-	return cfqg->service_trees[wl_class][ASYNC_WORKLOAD].count +
-		cfqg->service_trees[wl_class][SYNC_NOIDLE_WORKLOAD].count +
-		cfqg->service_trees[wl_class][SYNC_WORKLOAD].count;
+	return cfqd->service_trees[wl_class][ASYNC_WORKLOAD].count +
+		cfqd->service_trees[wl_class][SYNC_NOIDLE_WORKLOAD].count +
+		cfqd->service_trees[wl_class][SYNC_WORKLOAD].count;
 }
 
-static inline int cfqg_busy_async_queues(struct cfq_data *cfqd,
-					struct cfq_group *cfqg)
+static inline int cfq_busy_async_queues(struct cfq_data *cfqd)
 {
-	return cfqg->service_trees[RT_WORKLOAD][ASYNC_WORKLOAD].count +
-		cfqg->service_trees[BE_WORKLOAD][ASYNC_WORKLOAD].count;
+	return cfqd->service_trees[RT_WORKLOAD][ASYNC_WORKLOAD].count +
+		cfqd->service_trees[BE_WORKLOAD][ASYNC_WORKLOAD].count;
 }
 
 static void cfq_dispatch_insert(struct request_queue *, struct request *);
@@ -932,29 +430,6 @@ cfq_prio_to_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 	return cfq_prio_slice(cfqd, cfq_cfqq_sync(cfqq), cfqq->ioprio);
 }
 
-/**
- * cfqg_scale_charge - scale disk time charge according to cfqg weight
- * @charge: disk time being charged
- * @vfraction: vfraction of the cfqg, fixed point w/ CFQ_SERVICE_SHIFT
- *
- * Scale @charge according to @vfraction, which is in range (0, 1].  The
- * scaling is inversely proportional.
- *
- * scaled = charge / vfraction
- *
- * The result is also in fixed point w/ CFQ_SERVICE_SHIFT.
- */
-static inline u64 cfqg_scale_charge(unsigned long charge,
-				    unsigned int vfraction)
-{
-	u64 c = charge << CFQ_SERVICE_SHIFT;	/* make it fixed point */
-
-	/* charge / vfraction */
-	c <<= CFQ_SERVICE_SHIFT;
-	do_div(c, vfraction);
-	return c;
-}
-
 static inline u64 max_vdisktime(u64 min_vdisktime, u64 vdisktime)
 {
 	s64 delta = (s64)(vdisktime - min_vdisktime);
@@ -973,72 +448,10 @@ static inline u64 min_vdisktime(u64 min_vdisktime, u64 vdisktime)
 	return min_vdisktime;
 }
 
-static void update_min_vdisktime(struct cfq_rb_root *st)
-{
-	struct cfq_group *cfqg;
-
-	if (st->left) {
-		cfqg = rb_entry_cfqg(st->left);
-		st->min_vdisktime = max_vdisktime(st->min_vdisktime,
-						  cfqg->vdisktime);
-	}
-}
-
-/*
- * get averaged number of queues of RT/BE priority.
- * average is updated, with a formula that gives more weight to higher numbers,
- * to quickly follows sudden increases and decrease slowly
- */
-
-static inline unsigned cfq_group_get_avg_queues(struct cfq_data *cfqd,
-					struct cfq_group *cfqg, bool rt)
-{
-	unsigned min_q, max_q;
-	unsigned mult  = cfq_hist_divisor - 1;
-	unsigned round = cfq_hist_divisor / 2;
-	unsigned busy = cfq_group_busy_queues_wl(rt, cfqd, cfqg);
-
-	min_q = min(cfqg->busy_queues_avg[rt], busy);
-	max_q = max(cfqg->busy_queues_avg[rt], busy);
-	cfqg->busy_queues_avg[rt] = (mult * max_q + min_q + round) /
-		cfq_hist_divisor;
-	return cfqg->busy_queues_avg[rt];
-}
-
-static inline unsigned
-cfq_group_slice(struct cfq_data *cfqd, struct cfq_group *cfqg)
-{
-	return cfqd->cfq_target_latency * cfqg->vfraction >> CFQ_SERVICE_SHIFT;
-}
-
 static inline unsigned
 cfq_scaled_cfqq_slice(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
-	unsigned slice = cfq_prio_to_slice(cfqd, cfqq);
-	if (cfqd->cfq_latency) {
-		/*
-		 * interested queues (we consider only the ones with the same
-		 * priority class in the cfq group)
-		 */
-		unsigned iq = cfq_group_get_avg_queues(cfqd, cfqq->cfqg,
-						cfq_class_rt(cfqq));
-		unsigned sync_slice = cfqd->cfq_slice[1];
-		unsigned expect_latency = sync_slice * iq;
-		unsigned group_slice = cfq_group_slice(cfqd, cfqq->cfqg);
-
-		if (expect_latency > group_slice) {
-			unsigned base_low_slice = 2 * cfqd->cfq_slice_idle;
-			/* scale low_slice according to IO priority
-			 * and sync vs async */
-			unsigned low_slice =
-				min(slice, base_low_slice * slice / sync_slice);
-			/* the adapted slice value is scaled to fit all iqs
-			 * into the target latency */
-			slice = max(slice * group_slice / expect_latency,
-				    low_slice);
-		}
-	}
-	return slice;
+	return cfq_prio_to_slice(cfqd, cfqq);
 }
 
 static inline void
@@ -1128,1067 +541,127 @@ cfq_choose_req(struct cfq_data *cfqd, struct request *rq1, struct request *rq2,
 	switch (wrap) {
 	case 0: /* common case for CFQ: rq1 and rq2 not wrapped */
 		if (d1 < d2)
-			return rq1;
-		else if (d2 < d1)
-			return rq2;
-		else {
-			if (s1 >= s2)
-				return rq1;
-			else
-				return rq2;
-		}
-
-	case CFQ_RQ2_WRAP:
-		return rq1;
-	case CFQ_RQ1_WRAP:
-		return rq2;
-	case (CFQ_RQ1_WRAP|CFQ_RQ2_WRAP): /* both rqs wrapped */
-	default:
-		/*
-		 * Since both rqs are wrapped,
-		 * start with the one that's further behind head
-		 * (--> only *one* back seek required),
-		 * since back seek takes more time than forward.
-		 */
-		if (s1 <= s2)
-			return rq1;
-		else
-			return rq2;
-	}
-}
-
-/*
- * The below is leftmost cache rbtree addon
- */
-static struct cfq_queue *cfq_rb_first(struct cfq_rb_root *root)
-{
-	/* Service tree is empty */
-	if (!root->count)
-		return NULL;
-
-	if (!root->left)
-		root->left = rb_first(&root->rb);
-
-	if (root->left)
-		return rb_entry(root->left, struct cfq_queue, rb_node);
-
-	return NULL;
-}
-
-static struct cfq_group *cfq_rb_first_group(struct cfq_rb_root *root)
-{
-	if (!root->left)
-		root->left = rb_first(&root->rb);
-
-	if (root->left)
-		return rb_entry_cfqg(root->left);
-
-	return NULL;
-}
-
-static void rb_erase_init(struct rb_node *n, struct rb_root *root)
-{
-	rb_erase(n, root);
-	RB_CLEAR_NODE(n);
-}
-
-static void cfq_rb_erase(struct rb_node *n, struct cfq_rb_root *root)
-{
-	if (root->left == n)
-		root->left = NULL;
-	rb_erase_init(n, &root->rb);
-	--root->count;
-}
-
-/*
- * would be nice to take fifo expire time into account as well
- */
-static struct request *
-cfq_find_next_rq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
-		  struct request *last)
-{
-	struct rb_node *rbnext = rb_next(&last->rb_node);
-	struct rb_node *rbprev = rb_prev(&last->rb_node);
-	struct request *next = NULL, *prev = NULL;
-
-	BUG_ON(RB_EMPTY_NODE(&last->rb_node));
-
-	if (rbprev)
-		prev = rb_entry_rq(rbprev);
-
-	if (rbnext)
-		next = rb_entry_rq(rbnext);
-	else {
-		rbnext = rb_first(&cfqq->sort_list);
-		if (rbnext && rbnext != &last->rb_node)
-			next = rb_entry_rq(rbnext);
-	}
-
-	return cfq_choose_req(cfqd, next, prev, blk_rq_pos(last));
-}
-
-static unsigned long cfq_slice_offset(struct cfq_data *cfqd,
-				      struct cfq_queue *cfqq)
-{
-	/*
-	 * just an approximation, should be ok.
-	 */
-	return (cfqq->cfqg->nr_cfqq - 1) * (cfq_prio_slice(cfqd, 1, 0) -
-		       cfq_prio_slice(cfqd, cfq_cfqq_sync(cfqq), cfqq->ioprio));
-}
-
-static inline s64
-cfqg_key(struct cfq_rb_root *st, struct cfq_group *cfqg)
-{
-	return cfqg->vdisktime - st->min_vdisktime;
-}
-
-static void
-__cfq_group_service_tree_add(struct cfq_rb_root *st, struct cfq_group *cfqg)
-{
-	struct rb_node **node = &st->rb.rb_node;
-	struct rb_node *parent = NULL;
-	struct cfq_group *__cfqg;
-	s64 key = cfqg_key(st, cfqg);
-	int left = 1;
-
-	while (*node != NULL) {
-		parent = *node;
-		__cfqg = rb_entry_cfqg(parent);
-
-		if (key < cfqg_key(st, __cfqg))
-			node = &parent->rb_left;
-		else {
-			node = &parent->rb_right;
-			left = 0;
-		}
-	}
-
-	if (left)
-		st->left = &cfqg->rb_node;
-
-	rb_link_node(&cfqg->rb_node, parent, node);
-	rb_insert_color(&cfqg->rb_node, &st->rb);
-}
-
-/*
- * This has to be called only on activation of cfqg
- */
-static void
-cfq_update_group_weight(struct cfq_group *cfqg)
-{
-	if (cfqg->new_weight) {
-		cfqg->weight = cfqg->new_weight;
-		cfqg->new_weight = 0;
-	}
-}
-
-static void
-cfq_update_group_leaf_weight(struct cfq_group *cfqg)
-{
-	BUG_ON(!RB_EMPTY_NODE(&cfqg->rb_node));
-
-	if (cfqg->new_leaf_weight) {
-		cfqg->leaf_weight = cfqg->new_leaf_weight;
-		cfqg->new_leaf_weight = 0;
-	}
-}
-
-static void
-cfq_group_service_tree_add(struct cfq_rb_root *st, struct cfq_group *cfqg)
-{
-	unsigned int vfr = 1 << CFQ_SERVICE_SHIFT;	/* start with 1 */
-	struct cfq_group *pos = cfqg;
-	struct cfq_group *parent;
-	bool propagate;
-
-	/* add to the service tree */
-	BUG_ON(!RB_EMPTY_NODE(&cfqg->rb_node));
-
-	/*
-	 * Update leaf_weight.  We cannot update weight at this point
-	 * because cfqg might already have been activated and is
-	 * contributing its current weight to the parent's child_weight.
-	 */
-	cfq_update_group_leaf_weight(cfqg);
-	__cfq_group_service_tree_add(st, cfqg);
-
-	/*
-	 * Activate @cfqg and calculate the portion of vfraction @cfqg is
-	 * entitled to.  vfraction is calculated by walking the tree
-	 * towards the root calculating the fraction it has at each level.
-	 * The compounded ratio is how much vfraction @cfqg owns.
-	 *
-	 * Start with the proportion tasks in this cfqg has against active
-	 * children cfqgs - its leaf_weight against children_weight.
-	 */
-	propagate = !pos->nr_active++;
-	pos->children_weight += pos->leaf_weight;
-	vfr = vfr * pos->leaf_weight / pos->children_weight;
-
-	/*
-	 * Compound ->weight walking up the tree.  Both activation and
-	 * vfraction calculation are done in the same loop.  Propagation
-	 * stops once an already activated node is met.  vfraction
-	 * calculation should always continue to the root.
-	 */
-	while ((parent = cfqg_parent(pos))) {
-		if (propagate) {
-			cfq_update_group_weight(pos);
-			propagate = !parent->nr_active++;
-			parent->children_weight += pos->weight;
-		}
-		vfr = vfr * pos->weight / parent->children_weight;
-		pos = parent;
-	}
-
-	cfqg->vfraction = max_t(unsigned, vfr, 1);
-}
-
-static void
-cfq_group_notify_queue_add(struct cfq_data *cfqd, struct cfq_group *cfqg)
-{
-	struct cfq_rb_root *st = &cfqd->grp_service_tree;
-	struct cfq_group *__cfqg;
-	struct rb_node *n;
-
-	cfqg->nr_cfqq++;
-	if (!RB_EMPTY_NODE(&cfqg->rb_node))
-		return;
-
-	/*
-	 * Currently put the group at the end. Later implement something
-	 * so that groups get lesser vtime based on their weights, so that
-	 * if group does not loose all if it was not continuously backlogged.
-	 */
-	n = rb_last(&st->rb);
-	if (n) {
-		__cfqg = rb_entry_cfqg(n);
-		cfqg->vdisktime = __cfqg->vdisktime + CFQ_IDLE_DELAY;
-	} else
-		cfqg->vdisktime = st->min_vdisktime;
-	cfq_group_service_tree_add(st, cfqg);
-}
-
-static void
-cfq_group_service_tree_del(struct cfq_rb_root *st, struct cfq_group *cfqg)
-{
-	struct cfq_group *pos = cfqg;
-	bool propagate;
-
-	/*
-	 * Undo activation from cfq_group_service_tree_add().  Deactivate
-	 * @cfqg and propagate deactivation upwards.
-	 */
-	propagate = !--pos->nr_active;
-	pos->children_weight -= pos->leaf_weight;
-
-	while (propagate) {
-		struct cfq_group *parent = cfqg_parent(pos);
-
-		/* @pos has 0 nr_active at this point */
-		WARN_ON_ONCE(pos->children_weight);
-		pos->vfraction = 0;
-
-		if (!parent)
-			break;
-
-		propagate = !--parent->nr_active;
-		parent->children_weight -= pos->weight;
-		pos = parent;
-	}
-
-	/* remove from the service tree */
-	if (!RB_EMPTY_NODE(&cfqg->rb_node))
-		cfq_rb_erase(&cfqg->rb_node, st);
-}
-
-static void
-cfq_group_notify_queue_del(struct cfq_data *cfqd, struct cfq_group *cfqg)
-{
-	struct cfq_rb_root *st = &cfqd->grp_service_tree;
-
-	BUG_ON(cfqg->nr_cfqq < 1);
-	cfqg->nr_cfqq--;
-
-	/* If there are other cfq queues under this group, don't delete it */
-	if (cfqg->nr_cfqq)
-		return;
-
-	cfq_log_cfqg(cfqd, cfqg, "del_from_rr group");
-	cfq_group_service_tree_del(st, cfqg);
-	cfqg->saved_wl_slice = 0;
-	cfqg_stats_update_dequeue(cfqg);
-}
-
-static inline unsigned int cfq_cfqq_slice_usage(struct cfq_queue *cfqq,
-						unsigned int *unaccounted_time)
-{
-	unsigned int slice_used;
-
-	/*
-	 * Queue got expired before even a single request completed or
-	 * got expired immediately after first request completion.
-	 */
-	if (!cfqq->slice_start || cfqq->slice_start == jiffies) {
-		/*
-		 * Also charge the seek time incurred to the group, otherwise
-		 * if there are mutiple queues in the group, each can dispatch
-		 * a single request on seeky media and cause lots of seek time
-		 * and group will never know it.
-		 */
-		slice_used = max_t(unsigned, (jiffies - cfqq->dispatch_start),
-					1);
-	} else {
-		slice_used = jiffies - cfqq->slice_start;
-		if (slice_used > cfqq->allocated_slice) {
-			*unaccounted_time = slice_used - cfqq->allocated_slice;
-			slice_used = cfqq->allocated_slice;
-		}
-		if (time_after(cfqq->slice_start, cfqq->dispatch_start))
-			*unaccounted_time += cfqq->slice_start -
-					cfqq->dispatch_start;
-	}
-
-	return slice_used;
-}
-
-static void cfq_group_served(struct cfq_data *cfqd, struct cfq_group *cfqg,
-				struct cfq_queue *cfqq)
-{
-	struct cfq_rb_root *st = &cfqd->grp_service_tree;
-	unsigned int used_sl, charge, unaccounted_sl = 0;
-	int nr_sync = cfqg->nr_cfqq - cfqg_busy_async_queues(cfqd, cfqg)
-			- cfqg->service_tree_idle.count;
-	unsigned int vfr;
-
-	BUG_ON(nr_sync < 0);
-	used_sl = charge = cfq_cfqq_slice_usage(cfqq, &unaccounted_sl);
-
-	if (iops_mode(cfqd))
-		charge = cfqq->slice_dispatch;
-	else if (!cfq_cfqq_sync(cfqq) && !nr_sync)
-		charge = cfqq->allocated_slice;
-
-	/*
-	 * Can't update vdisktime while on service tree and cfqg->vfraction
-	 * is valid only while on it.  Cache vfr, leave the service tree,
-	 * update vdisktime and go back on.  The re-addition to the tree
-	 * will also update the weights as necessary.
-	 */
-	vfr = cfqg->vfraction;
-	cfq_group_service_tree_del(st, cfqg);
-	cfqg->vdisktime += cfqg_scale_charge(charge, vfr);
-	cfq_group_service_tree_add(st, cfqg);
-
-	/* This group is being expired. Save the context */
-	if (time_after(cfqd->workload_expires, jiffies)) {
-		cfqg->saved_wl_slice = cfqd->workload_expires
-						- jiffies;
-		cfqg->saved_wl_type = cfqd->serving_wl_type;
-		cfqg->saved_wl_class = cfqd->serving_wl_class;
-	} else
-		cfqg->saved_wl_slice = 0;
-
-	cfq_log_cfqg(cfqd, cfqg, "served: vt=%llu min_vt=%llu", cfqg->vdisktime,
-					st->min_vdisktime);
-	cfq_log_cfqq(cfqq->cfqd, cfqq,
-		     "sl_used=%u disp=%u charge=%u iops=%u sect=%lu",
-		     used_sl, cfqq->slice_dispatch, charge,
-		     iops_mode(cfqd), cfqq->nr_sectors);
-	cfqg_stats_update_timeslice_used(cfqg, used_sl, unaccounted_sl);
-	cfqg_stats_set_start_empty_time(cfqg);
-}
-
-/**
- * cfq_init_cfqg_base - initialize base part of a cfq_group
- * @cfqg: cfq_group to initialize
- *
- * Initialize the base part which is used whether %CONFIG_CFQ_GROUP_IOSCHED
- * is enabled or not.
- */
-static void cfq_init_cfqg_base(struct cfq_group *cfqg)
-{
-	struct cfq_rb_root *st;
-	int i, j;
-
-	for_each_cfqg_st(cfqg, i, j, st)
-		*st = CFQ_RB_ROOT;
-	RB_CLEAR_NODE(&cfqg->rb_node);
-
-	cfqg->ttime.last_end_request = jiffies;
-}
-
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-static int __cfq_set_weight(struct cgroup_subsys_state *css, u64 val,
-			    bool on_dfl, bool reset_dev, bool is_leaf_weight);
-
-static void cfqg_stats_exit(struct cfqg_stats *stats)
-{
-	blkg_rwstat_exit(&stats->merged);
-	blkg_rwstat_exit(&stats->service_time);
-	blkg_rwstat_exit(&stats->wait_time);
-	blkg_rwstat_exit(&stats->queued);
-	blkg_stat_exit(&stats->time);
-#ifdef CONFIG_DEBUG_BLK_CGROUP
-	blkg_stat_exit(&stats->unaccounted_time);
-	blkg_stat_exit(&stats->avg_queue_size_sum);
-	blkg_stat_exit(&stats->avg_queue_size_samples);
-	blkg_stat_exit(&stats->dequeue);
-	blkg_stat_exit(&stats->group_wait_time);
-	blkg_stat_exit(&stats->idle_time);
-	blkg_stat_exit(&stats->empty_time);
-#endif
-}
-
-static int cfqg_stats_init(struct cfqg_stats *stats, gfp_t gfp)
-{
-	if (blkg_rwstat_init(&stats->merged, gfp) ||
-	    blkg_rwstat_init(&stats->service_time, gfp) ||
-	    blkg_rwstat_init(&stats->wait_time, gfp) ||
-	    blkg_rwstat_init(&stats->queued, gfp) ||
-	    blkg_stat_init(&stats->time, gfp))
-		goto err;
-
-#ifdef CONFIG_DEBUG_BLK_CGROUP
-	if (blkg_stat_init(&stats->unaccounted_time, gfp) ||
-	    blkg_stat_init(&stats->avg_queue_size_sum, gfp) ||
-	    blkg_stat_init(&stats->avg_queue_size_samples, gfp) ||
-	    blkg_stat_init(&stats->dequeue, gfp) ||
-	    blkg_stat_init(&stats->group_wait_time, gfp) ||
-	    blkg_stat_init(&stats->idle_time, gfp) ||
-	    blkg_stat_init(&stats->empty_time, gfp))
-		goto err;
-#endif
-	return 0;
-err:
-	cfqg_stats_exit(stats);
-	return -ENOMEM;
-}
-
-static struct blkcg_policy_data *cfq_cpd_alloc(gfp_t gfp)
-{
-	struct cfq_group_data *cgd;
-
-	cgd = kzalloc(sizeof(*cgd), GFP_KERNEL);
-	if (!cgd)
-		return NULL;
-	return &cgd->cpd;
-}
-
-static void cfq_cpd_init(struct blkcg_policy_data *cpd)
-{
-	struct cfq_group_data *cgd = cpd_to_cfqgd(cpd);
-	unsigned int weight = cgroup_subsys_on_dfl(io_cgrp_subsys) ?
-			      CGROUP_WEIGHT_DFL : CFQ_WEIGHT_LEGACY_DFL;
-
-	if (cpd_to_blkcg(cpd) == &blkcg_root)
-		weight *= 2;
-
-	cgd->weight = weight;
-	cgd->leaf_weight = weight;
-}
-
-static void cfq_cpd_free(struct blkcg_policy_data *cpd)
-{
-	kfree(cpd_to_cfqgd(cpd));
-}
-
-static void cfq_cpd_bind(struct blkcg_policy_data *cpd)
-{
-	struct blkcg *blkcg = cpd_to_blkcg(cpd);
-	bool on_dfl = cgroup_subsys_on_dfl(io_cgrp_subsys);
-	unsigned int weight = on_dfl ? CGROUP_WEIGHT_DFL : CFQ_WEIGHT_LEGACY_DFL;
-
-	if (blkcg == &blkcg_root)
-		weight *= 2;
-
-	WARN_ON_ONCE(__cfq_set_weight(&blkcg->css, weight, on_dfl, true, false));
-	WARN_ON_ONCE(__cfq_set_weight(&blkcg->css, weight, on_dfl, true, true));
-}
-
-static struct blkg_policy_data *cfq_pd_alloc(gfp_t gfp, int node)
-{
-	struct cfq_group *cfqg;
-
-	cfqg = kzalloc_node(sizeof(*cfqg), gfp, node);
-	if (!cfqg)
-		return NULL;
-
-	cfq_init_cfqg_base(cfqg);
-	if (cfqg_stats_init(&cfqg->stats, gfp)) {
-		kfree(cfqg);
-		return NULL;
-	}
-
-	return &cfqg->pd;
-}
-
-static void cfq_pd_init(struct blkg_policy_data *pd)
-{
-	struct cfq_group *cfqg = pd_to_cfqg(pd);
-	struct cfq_group_data *cgd = blkcg_to_cfqgd(pd->blkg->blkcg);
-
-	cfqg->weight = cgd->weight;
-	cfqg->leaf_weight = cgd->leaf_weight;
-}
-
-static void cfq_pd_offline(struct blkg_policy_data *pd)
-{
-	struct cfq_group *cfqg = pd_to_cfqg(pd);
-	int i;
-
-	for (i = 0; i < IOPRIO_BE_NR; i++) {
-		if (cfqg->async_cfqq[0][i])
-			cfq_put_queue(cfqg->async_cfqq[0][i]);
-		if (cfqg->async_cfqq[1][i])
-			cfq_put_queue(cfqg->async_cfqq[1][i]);
-	}
-
-	if (cfqg->async_idle_cfqq)
-		cfq_put_queue(cfqg->async_idle_cfqq);
-
-	/*
-	 * @blkg is going offline and will be ignored by
-	 * blkg_[rw]stat_recursive_sum().  Transfer stats to the parent so
-	 * that they don't get lost.  If IOs complete after this point, the
-	 * stats for them will be lost.  Oh well...
-	 */
-	cfqg_stats_xfer_dead(cfqg);
-}
-
-static void cfq_pd_free(struct blkg_policy_data *pd)
-{
-	struct cfq_group *cfqg = pd_to_cfqg(pd);
-
-	cfqg_stats_exit(&cfqg->stats);
-	return kfree(cfqg);
-}
-
-static void cfq_pd_reset_stats(struct blkg_policy_data *pd)
-{
-	struct cfq_group *cfqg = pd_to_cfqg(pd);
-
-	cfqg_stats_reset(&cfqg->stats);
-}
-
-static struct cfq_group *cfq_lookup_cfqg(struct cfq_data *cfqd,
-					 struct blkcg *blkcg)
-{
-	struct blkcg_gq *blkg;
-
-	blkg = blkg_lookup(blkcg, cfqd->queue);
-	if (likely(blkg))
-		return blkg_to_cfqg(blkg);
-	return NULL;
-}
-
-static void cfq_link_cfqq_cfqg(struct cfq_queue *cfqq, struct cfq_group *cfqg)
-{
-	cfqq->cfqg = cfqg;
-	/* cfqq reference on cfqg */
-	cfqg_get(cfqg);
-}
-
-static u64 cfqg_prfill_weight_device(struct seq_file *sf,
-				     struct blkg_policy_data *pd, int off)
-{
-	struct cfq_group *cfqg = pd_to_cfqg(pd);
-
-	if (!cfqg->dev_weight)
-		return 0;
-	return __blkg_prfill_u64(sf, pd, cfqg->dev_weight);
-}
-
-static int cfqg_print_weight_device(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  cfqg_prfill_weight_device, &blkcg_policy_cfq,
-			  0, false);
-	return 0;
-}
-
-static u64 cfqg_prfill_leaf_weight_device(struct seq_file *sf,
-					  struct blkg_policy_data *pd, int off)
-{
-	struct cfq_group *cfqg = pd_to_cfqg(pd);
-
-	if (!cfqg->dev_leaf_weight)
-		return 0;
-	return __blkg_prfill_u64(sf, pd, cfqg->dev_leaf_weight);
-}
-
-static int cfqg_print_leaf_weight_device(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  cfqg_prfill_leaf_weight_device, &blkcg_policy_cfq,
-			  0, false);
-	return 0;
-}
-
-static int cfq_print_weight(struct seq_file *sf, void *v)
-{
-	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
-	struct cfq_group_data *cgd = blkcg_to_cfqgd(blkcg);
-	unsigned int val = 0;
-
-	if (cgd)
-		val = cgd->weight;
-
-	seq_printf(sf, "%u\n", val);
-	return 0;
-}
-
-static int cfq_print_leaf_weight(struct seq_file *sf, void *v)
-{
-	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
-	struct cfq_group_data *cgd = blkcg_to_cfqgd(blkcg);
-	unsigned int val = 0;
-
-	if (cgd)
-		val = cgd->leaf_weight;
-
-	seq_printf(sf, "%u\n", val);
-	return 0;
-}
-
-static ssize_t __cfqg_set_weight_device(struct kernfs_open_file *of,
-					char *buf, size_t nbytes, loff_t off,
-					bool on_dfl, bool is_leaf_weight)
-{
-	unsigned int min = on_dfl ? CGROUP_WEIGHT_MIN : CFQ_WEIGHT_LEGACY_MIN;
-	unsigned int max = on_dfl ? CGROUP_WEIGHT_MAX : CFQ_WEIGHT_LEGACY_MAX;
-	struct blkcg *blkcg = css_to_blkcg(of_css(of));
-	struct blkg_conf_ctx ctx;
-	struct cfq_group *cfqg;
-	struct cfq_group_data *cfqgd;
-	int ret;
-	u64 v;
-
-	ret = blkg_conf_prep(blkcg, &blkcg_policy_cfq, buf, &ctx);
-	if (ret)
-		return ret;
-
-	if (sscanf(ctx.body, "%llu", &v) == 1) {
-		/* require "default" on dfl */
-		ret = -ERANGE;
-		if (!v && on_dfl)
-			goto out_finish;
-	} else if (!strcmp(strim(ctx.body), "default")) {
-		v = 0;
-	} else {
-		ret = -EINVAL;
-		goto out_finish;
-	}
-
-	cfqg = blkg_to_cfqg(ctx.blkg);
-	cfqgd = blkcg_to_cfqgd(blkcg);
-
-	ret = -ERANGE;
-	if (!v || (v >= min && v <= max)) {
-		if (!is_leaf_weight) {
-			cfqg->dev_weight = v;
-			cfqg->new_weight = v ?: cfqgd->weight;
-		} else {
-			cfqg->dev_leaf_weight = v;
-			cfqg->new_leaf_weight = v ?: cfqgd->leaf_weight;
-		}
-		ret = 0;
-	}
-out_finish:
-	blkg_conf_finish(&ctx);
-	return ret ?: nbytes;
-}
-
-static ssize_t cfqg_set_weight_device(struct kernfs_open_file *of,
-				      char *buf, size_t nbytes, loff_t off)
-{
-	return __cfqg_set_weight_device(of, buf, nbytes, off, false, false);
-}
-
-static ssize_t cfqg_set_leaf_weight_device(struct kernfs_open_file *of,
-					   char *buf, size_t nbytes, loff_t off)
-{
-	return __cfqg_set_weight_device(of, buf, nbytes, off, false, true);
-}
-
-static int __cfq_set_weight(struct cgroup_subsys_state *css, u64 val,
-			    bool on_dfl, bool reset_dev, bool is_leaf_weight)
-{
-	unsigned int min = on_dfl ? CGROUP_WEIGHT_MIN : CFQ_WEIGHT_LEGACY_MIN;
-	unsigned int max = on_dfl ? CGROUP_WEIGHT_MAX : CFQ_WEIGHT_LEGACY_MAX;
-	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg_gq *blkg;
-	struct cfq_group_data *cfqgd;
-	int ret = 0;
-
-	if (val < min || val > max)
-		return -ERANGE;
-
-	spin_lock_irq(&blkcg->lock);
-	cfqgd = blkcg_to_cfqgd(blkcg);
-	if (!cfqgd) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (!is_leaf_weight)
-		cfqgd->weight = val;
-	else
-		cfqgd->leaf_weight = val;
-
-	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct cfq_group *cfqg = blkg_to_cfqg(blkg);
-
-		if (!cfqg)
-			continue;
-
-		if (!is_leaf_weight) {
-			if (reset_dev)
-				cfqg->dev_weight = 0;
-			if (!cfqg->dev_weight)
-				cfqg->new_weight = cfqgd->weight;
-		} else {
-			if (reset_dev)
-				cfqg->dev_leaf_weight = 0;
-			if (!cfqg->dev_leaf_weight)
-				cfqg->new_leaf_weight = cfqgd->leaf_weight;
-		}
-	}
-
-out:
-	spin_unlock_irq(&blkcg->lock);
-	return ret;
-}
-
-static int cfq_set_weight(struct cgroup_subsys_state *css, struct cftype *cft,
-			  u64 val)
-{
-	return __cfq_set_weight(css, val, false, false, false);
-}
-
-static int cfq_set_leaf_weight(struct cgroup_subsys_state *css,
-			       struct cftype *cft, u64 val)
-{
-	return __cfq_set_weight(css, val, false, false, true);
-}
-
-static int cfqg_print_stat(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
-			  &blkcg_policy_cfq, seq_cft(sf)->private, false);
-	return 0;
-}
-
-static int cfqg_print_rwstat(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
-			  &blkcg_policy_cfq, seq_cft(sf)->private, true);
-	return 0;
-}
-
-static u64 cfqg_prfill_stat_recursive(struct seq_file *sf,
-				      struct blkg_policy_data *pd, int off)
-{
-	u64 sum = blkg_stat_recursive_sum(pd_to_blkg(pd),
-					  &blkcg_policy_cfq, off);
-	return __blkg_prfill_u64(sf, pd, sum);
-}
+			return rq1;
+		else if (d2 < d1)
+			return rq2;
+		if (s1 >= s2)
+			return rq1;
+		else
+			return rq2;
 
-static u64 cfqg_prfill_rwstat_recursive(struct seq_file *sf,
-					struct blkg_policy_data *pd, int off)
-{
-	struct blkg_rwstat sum = blkg_rwstat_recursive_sum(pd_to_blkg(pd),
-							&blkcg_policy_cfq, off);
-	return __blkg_prfill_rwstat(sf, pd, &sum);
+	case CFQ_RQ2_WRAP:
+		return rq1;
+	case CFQ_RQ1_WRAP:
+		return rq2;
+	case (CFQ_RQ1_WRAP|CFQ_RQ2_WRAP): /* both rqs wrapped */
+	default:
+		/*
+		 * Since both rqs are wrapped,
+		 * start with the one that's further behind head
+		 * (--> only *one* back seek required),
+		 * since back seek takes more time than forward.
+		 */
+		if (s1 <= s2)
+			return rq1;
+		else
+			return rq2;
+	}
 }
 
-static int cfqg_print_stat_recursive(struct seq_file *sf, void *v)
+/*
+ * The below is leftmost cache rbtree addon
+ */
+static struct cfq_queue *cfq_rb_first(struct cfq_rb_root *root)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  cfqg_prfill_stat_recursive, &blkcg_policy_cfq,
-			  seq_cft(sf)->private, false);
-	return 0;
-}
+	/* Service tree is empty */
+	if (!root->count)
+		return NULL;
 
-static int cfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  cfqg_prfill_rwstat_recursive, &blkcg_policy_cfq,
-			  seq_cft(sf)->private, true);
-	return 0;
-}
+	if (!root->left)
+		root->left = rb_first(&root->rb);
 
-static u64 cfqg_prfill_sectors(struct seq_file *sf, struct blkg_policy_data *pd,
-			       int off)
-{
-	u64 sum = blkg_rwstat_total(&pd->blkg->stat_bytes);
+	if (root->left)
+		return rb_entry(root->left, struct cfq_queue, rb_node);
 
-	return __blkg_prfill_u64(sf, pd, sum >> 9);
+	return NULL;
 }
 
-static int cfqg_print_stat_sectors(struct seq_file *sf, void *v)
+static void rb_erase_init(struct rb_node *n, struct rb_root *root)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  cfqg_prfill_sectors, &blkcg_policy_cfq, 0, false);
-	return 0;
+	rb_erase(n, root);
+	RB_CLEAR_NODE(n);
 }
 
-static u64 cfqg_prfill_sectors_recursive(struct seq_file *sf,
-					 struct blkg_policy_data *pd, int off)
+static void cfq_rb_erase(struct rb_node *n, struct cfq_rb_root *root)
 {
-	struct blkg_rwstat tmp = blkg_rwstat_recursive_sum(pd->blkg, NULL,
-					offsetof(struct blkcg_gq, stat_bytes));
-	u64 sum = atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
-		atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_WRITE]);
-
-	return __blkg_prfill_u64(sf, pd, sum >> 9);
+	if (root->left == n)
+		root->left = NULL;
+	rb_erase_init(n, &root->rb);
+	--root->count;
 }
 
-static int cfqg_print_stat_sectors_recursive(struct seq_file *sf, void *v)
+/*
+ * would be nice to take fifo expire time into account as well
+ */
+static struct request *
+cfq_find_next_rq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
+		  struct request *last)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  cfqg_prfill_sectors_recursive, &blkcg_policy_cfq, 0,
-			  false);
-	return 0;
-}
+	struct rb_node *rbnext = rb_next(&last->rb_node);
+	struct rb_node *rbprev = rb_prev(&last->rb_node);
+	struct request *next = NULL, *prev = NULL;
 
-#ifdef CONFIG_DEBUG_BLK_CGROUP
-static u64 cfqg_prfill_avg_queue_size(struct seq_file *sf,
-				      struct blkg_policy_data *pd, int off)
-{
-	struct cfq_group *cfqg = pd_to_cfqg(pd);
-	u64 samples = blkg_stat_read(&cfqg->stats.avg_queue_size_samples);
-	u64 v = 0;
+	if (rbprev)
+		prev = rb_entry_rq(rbprev);
 
-	if (samples) {
-		v = blkg_stat_read(&cfqg->stats.avg_queue_size_sum);
-		v = div64_u64(v, samples);
+	if (rbnext)
+		next = rb_entry_rq(rbnext);
+	else {
+		rbnext = rb_first(&cfqq->sort_list);
+		if (rbnext && rbnext != &last->rb_node)
+			next = rb_entry_rq(rbnext);
 	}
-	__blkg_prfill_u64(sf, pd, v);
-	return 0;
-}
 
-/* print avg_queue_size */
-static int cfqg_print_avg_queue_size(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  cfqg_prfill_avg_queue_size, &blkcg_policy_cfq,
-			  0, false);
-	return 0;
+	return cfq_choose_req(cfqd, next, prev, blk_rq_pos(last));
 }
-#endif	/* CONFIG_DEBUG_BLK_CGROUP */
-
-static struct cftype cfq_blkcg_legacy_files[] = {
-	/* on root, weight is mapped to leaf_weight */
-	{
-		.name = "weight_device",
-		.flags = CFTYPE_ONLY_ON_ROOT,
-		.seq_show = cfqg_print_leaf_weight_device,
-		.write = cfqg_set_leaf_weight_device,
-	},
-	{
-		.name = "weight",
-		.flags = CFTYPE_ONLY_ON_ROOT,
-		.seq_show = cfq_print_leaf_weight,
-		.write_u64 = cfq_set_leaf_weight,
-	},
-
-	/* no such mapping necessary for !roots */
-	{
-		.name = "weight_device",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = cfqg_print_weight_device,
-		.write = cfqg_set_weight_device,
-	},
-	{
-		.name = "weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = cfq_print_weight,
-		.write_u64 = cfq_set_weight,
-	},
-
-	{
-		.name = "leaf_weight_device",
-		.seq_show = cfqg_print_leaf_weight_device,
-		.write = cfqg_set_leaf_weight_device,
-	},
-	{
-		.name = "leaf_weight",
-		.seq_show = cfq_print_leaf_weight,
-		.write_u64 = cfq_set_leaf_weight,
-	},
-
-	/* statistics, covers only the tasks in the cfqg */
-	{
-		.name = "time",
-		.private = offsetof(struct cfq_group, stats.time),
-		.seq_show = cfqg_print_stat,
-	},
-	{
-		.name = "sectors",
-		.seq_show = cfqg_print_stat_sectors,
-	},
-	{
-		.name = "io_service_bytes",
-		.private = (unsigned long)&blkcg_policy_cfq,
-		.seq_show = blkg_print_stat_bytes,
-	},
-	{
-		.name = "io_serviced",
-		.private = (unsigned long)&blkcg_policy_cfq,
-		.seq_show = blkg_print_stat_ios,
-	},
-	{
-		.name = "io_service_time",
-		.private = offsetof(struct cfq_group, stats.service_time),
-		.seq_show = cfqg_print_rwstat,
-	},
-	{
-		.name = "io_wait_time",
-		.private = offsetof(struct cfq_group, stats.wait_time),
-		.seq_show = cfqg_print_rwstat,
-	},
-	{
-		.name = "io_merged",
-		.private = offsetof(struct cfq_group, stats.merged),
-		.seq_show = cfqg_print_rwstat,
-	},
-	{
-		.name = "io_queued",
-		.private = offsetof(struct cfq_group, stats.queued),
-		.seq_show = cfqg_print_rwstat,
-	},
-
-	/* the same statictics which cover the cfqg and its descendants */
-	{
-		.name = "time_recursive",
-		.private = offsetof(struct cfq_group, stats.time),
-		.seq_show = cfqg_print_stat_recursive,
-	},
-	{
-		.name = "sectors_recursive",
-		.seq_show = cfqg_print_stat_sectors_recursive,
-	},
-	{
-		.name = "io_service_bytes_recursive",
-		.private = (unsigned long)&blkcg_policy_cfq,
-		.seq_show = blkg_print_stat_bytes_recursive,
-	},
-	{
-		.name = "io_serviced_recursive",
-		.private = (unsigned long)&blkcg_policy_cfq,
-		.seq_show = blkg_print_stat_ios_recursive,
-	},
-	{
-		.name = "io_service_time_recursive",
-		.private = offsetof(struct cfq_group, stats.service_time),
-		.seq_show = cfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "io_wait_time_recursive",
-		.private = offsetof(struct cfq_group, stats.wait_time),
-		.seq_show = cfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "io_merged_recursive",
-		.private = offsetof(struct cfq_group, stats.merged),
-		.seq_show = cfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "io_queued_recursive",
-		.private = offsetof(struct cfq_group, stats.queued),
-		.seq_show = cfqg_print_rwstat_recursive,
-	},
-#ifdef CONFIG_DEBUG_BLK_CGROUP
-	{
-		.name = "avg_queue_size",
-		.seq_show = cfqg_print_avg_queue_size,
-	},
-	{
-		.name = "group_wait_time",
-		.private = offsetof(struct cfq_group, stats.group_wait_time),
-		.seq_show = cfqg_print_stat,
-	},
-	{
-		.name = "idle_time",
-		.private = offsetof(struct cfq_group, stats.idle_time),
-		.seq_show = cfqg_print_stat,
-	},
-	{
-		.name = "empty_time",
-		.private = offsetof(struct cfq_group, stats.empty_time),
-		.seq_show = cfqg_print_stat,
-	},
-	{
-		.name = "dequeue",
-		.private = offsetof(struct cfq_group, stats.dequeue),
-		.seq_show = cfqg_print_stat,
-	},
-	{
-		.name = "unaccounted_time",
-		.private = offsetof(struct cfq_group, stats.unaccounted_time),
-		.seq_show = cfqg_print_stat,
-	},
-#endif	/* CONFIG_DEBUG_BLK_CGROUP */
-	{ }	/* terminate */
-};
 
-static int cfq_print_weight_on_dfl(struct seq_file *sf, void *v)
+static unsigned long cfq_slice_offset(struct cfq_data *cfqd,
+				      struct cfq_queue *cfqq)
 {
-	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
-	struct cfq_group_data *cgd = blkcg_to_cfqgd(blkcg);
-
-	seq_printf(sf, "default %u\n", cgd->weight);
-	blkcg_print_blkgs(sf, blkcg, cfqg_prfill_weight_device,
-			  &blkcg_policy_cfq, 0, false);
-	return 0;
+	/*
+	 * just an approximation, should be ok.
+	 */
+	return (cfqd->busy_queues - 1) * (cfq_prio_slice(cfqd, 1, 0) -
+		       cfq_prio_slice(cfqd, cfq_cfqq_sync(cfqq), cfqq->ioprio));
 }
 
-static ssize_t cfq_set_weight_on_dfl(struct kernfs_open_file *of,
-				     char *buf, size_t nbytes, loff_t off)
+static inline unsigned int cfq_cfqq_slice_usage(struct cfq_queue *cfqq,
+						unsigned int *unaccounted_time)
 {
-	char *endp;
-	int ret;
-	u64 v;
-
-	buf = strim(buf);
+	unsigned int slice_used;
 
-	/* "WEIGHT" or "default WEIGHT" sets the default weight */
-	v = simple_strtoull(buf, &endp, 0);
-	if (*endp == '\0' || sscanf(buf, "default %llu", &v) == 1) {
-		ret = __cfq_set_weight(of_css(of), v, true, false, false);
-		return ret ?: nbytes;
+	/*
+	 * Queue got expired before even a single request completed or
+	 * got expired immediately after first request completion.
+	 */
+	if (!cfqq->slice_start ||
+	    time_in_range(cfqq->slice_start, jiffies, jiffies))
+		slice_used = max_t(unsigned int,
+				   (jiffies - cfqq->dispatch_start), 1);
+	else {
+		slice_used = jiffies - cfqq->slice_start;
+		if (slice_used > cfqq->allocated_slice) {
+			*unaccounted_time = slice_used - cfqq->allocated_slice;
+			slice_used = cfqq->allocated_slice;
+		}
+		if (time_after(cfqq->slice_start, cfqq->dispatch_start))
+			*unaccounted_time += cfqq->slice_start -
+					cfqq->dispatch_start;
 	}
 
-	/* "MAJ:MIN WEIGHT" */
-	return __cfqg_set_weight_device(of, buf, nbytes, off, true, false);
-}
-
-static struct cftype cfq_blkcg_files[] = {
-	{
-		.name = "weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = cfq_print_weight_on_dfl,
-		.write = cfq_set_weight_on_dfl,
-	},
-	{ }	/* terminate */
-};
-
-#else /* GROUP_IOSCHED */
-static struct cfq_group *cfq_lookup_cfqg(struct cfq_data *cfqd,
-					 struct blkcg *blkcg)
-{
-	return cfqd->root_group;
-}
-
-static inline void
-cfq_link_cfqq_cfqg(struct cfq_queue *cfqq, struct cfq_group *cfqg) {
-	cfqq->cfqg = cfqg;
+	return slice_used;
 }
 
-#endif /* GROUP_IOSCHED */
-
 /*
  * The cfqd->service_trees holds all pending cfq_queue's that have
  * requests waiting to be processed. It is sorted in the order that
@@ -2204,7 +677,7 @@ static void cfq_service_tree_add(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	int left;
 	int new_cfqq = 1;
 
-	st = st_for(cfqq->cfqg, cfqq_class(cfqq), cfqq_type(cfqq));
+	st = &cfqd->service_trees[cfqq_class(cfqq)][cfqq_type(cfqq)];
 	if (cfq_class_idle(cfqq)) {
 		rb_key = CFQ_IDLE_DELAY;
 		parent = rb_last(&st->rb);
@@ -2269,7 +742,6 @@ static void cfq_service_tree_add(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	st->count++;
 	if (add_front || !new_cfqq)
 		return;
-	cfq_group_notify_queue_add(cfqd, cfqq->cfqg);
 }
 
 /*
@@ -2319,7 +791,6 @@ static void cfq_del_cfqq_rr(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 		cfqq->p_root = NULL;
 	}
 
-	cfq_group_notify_queue_del(cfqd, cfqq->cfqg);
 	BUG_ON(!cfqd->busy_queues);
 	cfqd->busy_queues--;
 	if (cfq_cfqq_sync(cfqq))
@@ -2378,10 +849,7 @@ static void cfq_reposition_rq_rb(struct cfq_queue *cfqq, struct request *rq)
 {
 	elv_rb_del(&cfqq->sort_list, rq);
 	cfqq->queued[rq_is_sync(rq)]--;
-	cfqg_stats_update_io_remove(RQ_CFQG(rq), rq->cmd_flags);
 	cfq_add_rq_rb(rq);
-	cfqg_stats_update_io_add(RQ_CFQG(rq), cfqq->cfqd->serving_group,
-				 rq->cmd_flags);
 }
 
 static struct request *
@@ -2434,7 +902,6 @@ static void cfq_remove_request(struct request *rq)
 	cfq_del_rq_rb(rq);
 
 	cfqq->cfqd->rq_queued--;
-	cfqg_stats_update_io_remove(RQ_CFQG(rq), rq->cmd_flags);
 	if (rq->cmd_flags & REQ_PRIO) {
 		WARN_ON(!cfqq->prio_pending);
 		cfqq->prio_pending--;
@@ -2466,12 +933,6 @@ static void cfq_merged_request(struct request_queue *q, struct request *req,
 	}
 }
 
-static void cfq_bio_merged(struct request_queue *q, struct request *req,
-				struct bio *bio)
-{
-	cfqg_stats_update_io_merged(RQ_CFQG(req), bio->bi_rw);
-}
-
 static void
 cfq_merged_requests(struct request_queue *q, struct request *rq,
 		    struct request *next)
@@ -2492,7 +953,6 @@ cfq_merged_requests(struct request_queue *q, struct request *rq,
 	if (cfqq->next_rq == next)
 		cfqq->next_rq = rq;
 	cfq_remove_request(next);
-	cfqg_stats_update_io_merged(RQ_CFQG(rq), next->cmd_flags);
 
 	cfqq = RQ_CFQQ(next);
 	/*
@@ -2533,7 +993,6 @@ static int cfq_allow_merge(struct request_queue *q, struct request *rq,
 static inline void cfq_del_timer(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
 	del_timer(&cfqd->idle_slice_timer);
-	cfqg_stats_update_idle_time(cfqq->cfqg);
 }
 
 static void __cfq_set_active_queue(struct cfq_data *cfqd,
@@ -2542,7 +1001,6 @@ static void __cfq_set_active_queue(struct cfq_data *cfqd,
 	if (cfqq) {
 		cfq_log_cfqq(cfqd, cfqq, "set_active wl_class:%d wl_type:%d",
 				cfqd->serving_wl_class, cfqd->serving_wl_type);
-		cfqg_stats_update_avg_queue_size(cfqq->cfqg);
 		cfqq->slice_start = 0;
 		cfqq->dispatch_start = jiffies;
 		cfqq->allocated_slice = 0;
@@ -2588,8 +1046,6 @@ __cfq_slice_expired(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 		cfq_log_cfqq(cfqd, cfqq, "resid=%ld", cfqq->slice_resid);
 	}
 
-	cfq_group_served(cfqd, cfqq->cfqg, cfqq);
-
 	if (cfq_cfqq_on_rr(cfqq) && RB_EMPTY_ROOT(&cfqq->sort_list))
 		cfq_del_cfqq_rr(cfqd, cfqq);
 
@@ -2618,8 +1074,9 @@ static inline void cfq_slice_expired(struct cfq_data *cfqd, bool timed_out)
  */
 static struct cfq_queue *cfq_get_next_queue(struct cfq_data *cfqd)
 {
-	struct cfq_rb_root *st = st_for(cfqd->serving_group,
-			cfqd->serving_wl_class, cfqd->serving_wl_type);
+	struct cfq_rb_root *st =
+		&cfqd->service_trees[cfqd->serving_wl_class]
+				    [cfqd->serving_wl_type];
 
 	if (!cfqd->rq_queued)
 		return NULL;
@@ -2634,7 +1091,6 @@ static struct cfq_queue *cfq_get_next_queue(struct cfq_data *cfqd)
 
 static struct cfq_queue *cfq_get_next_queue_forced(struct cfq_data *cfqd)
 {
-	struct cfq_group *cfqg;
 	struct cfq_queue *cfqq;
 	int i, j;
 	struct cfq_rb_root *st;
@@ -2642,11 +1098,7 @@ static struct cfq_queue *cfq_get_next_queue_forced(struct cfq_data *cfqd)
 	if (!cfqd->rq_queued)
 		return NULL;
 
-	cfqg = cfq_get_next_cfqg(cfqd);
-	if (!cfqg)
-		return NULL;
-
-	for_each_cfqg_st(cfqg, i, j, st)
+	for_each_st(cfqd, i, j, st)
 		if ((cfqq = cfq_rb_first(st)) != NULL)
 			return cfqq;
 	return NULL;
@@ -2702,7 +1154,7 @@ static bool cfq_should_idle(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 	 * in their service tree.
 	 */
 	if (st->count == 1 && cfq_cfqq_sync(cfqq) &&
-	   !cfq_io_thinktime_big(cfqd, &st->ttime, false))
+	   !cfq_io_thinktime_big(cfqd, &st->ttime))
 		return true;
 	cfq_log_cfqq(cfqd, cfqq, "Not idling. st->count:%d", st->count);
 	return false;
@@ -2711,25 +1163,13 @@ static bool cfq_should_idle(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 static void cfq_arm_slice_timer(struct cfq_data *cfqd)
 {
 	struct cfq_queue *cfqq = cfqd->active_queue;
-	struct cfq_rb_root *st = cfqq->service_tree;
 	struct cfq_io_cq *cic;
-	unsigned long sl, group_idle = 0;
+	unsigned long sl;
 
 	WARN_ON(!RB_EMPTY_ROOT(&cfqq->sort_list));
 	WARN_ON(cfq_cfqq_slice_new(cfqq));
 
 	/*
-	 * idle is disabled, either manually or by past process history
-	 */
-	if (!cfq_should_idle(cfqd, cfqq)) {
-		/* no queue idling. Check for group idling */
-		if (cfqd->cfq_group_idle)
-			group_idle = cfqd->cfq_group_idle;
-		else
-			return;
-	}
-
-	/*
 	 * still active requests from this queue, don't idle
 	 */
 	if (cfqq->dispatched)
@@ -2754,26 +1194,12 @@ static void cfq_arm_slice_timer(struct cfq_data *cfqd)
 		return;
 	}
 
-	/*
-	 * There are other queues in the group or this is the only group and
-	 * it has too big thinktime, don't do group idle.
-	 */
-	if (group_idle &&
-	    (cfqq->cfqg->nr_cfqq > 1 ||
-	     cfq_io_thinktime_big(cfqd, &st->ttime, true)))
-		return;
-
 	cfq_mark_cfqq_wait_request(cfqq);
 
-	if (group_idle)
-		sl = cfqd->cfq_group_idle;
-	else
-		sl = cfqd->cfq_slice_idle;
+	sl = cfqd->cfq_slice_idle;
 
 	mod_timer(&cfqd->idle_slice_timer, jiffies + sl);
-	cfqg_stats_set_start_idle_time(cfqq->cfqg);
-	cfq_log_cfqq(cfqd, cfqq, "arm_idle: %lu group_idle: %d", sl,
-			group_idle ? 1 : 0);
+	cfq_log_cfqq(cfqd, cfqq, "arm_idle: %lu", sl);
 }
 
 /*
@@ -2789,7 +1215,6 @@ static void cfq_dispatch_insert(struct request_queue *q, struct request *rq)
 	cfqq->next_rq = cfq_find_next_rq(cfqd, cfqq, rq);
 	cfq_remove_request(rq);
 	cfqq->dispatched++;
-	(RQ_CFQG(rq))->dispatched++;
 	elv_dispatch_sort(q, rq);
 
 	cfqd->rq_in_flight[cfq_cfqq_sync(cfqq)]++;
@@ -2830,7 +1255,7 @@ cfq_prio_to_maxrq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 }
 
 static enum wl_type_t cfq_choose_wl_type(struct cfq_data *cfqd,
-			struct cfq_group *cfqg, enum wl_class_t wl_class)
+			enum wl_class_t wl_class)
 {
 	struct cfq_queue *queue;
 	int i;
@@ -2840,7 +1265,7 @@ static enum wl_type_t cfq_choose_wl_type(struct cfq_data *cfqd,
 
 	for (i = 0; i <= SYNC_WORKLOAD; ++i) {
 		/* select the one with lowest rb_key */
-		queue = cfq_rb_first(st_for(cfqg, wl_class, i));
+		queue = cfq_rb_first(&cfqd->service_trees[wl_class][i]);
 		if (queue &&
 		    (!key_valid || time_before(queue->rb_key, lowest_key))) {
 			lowest_key = queue->rb_key;
@@ -2853,18 +1278,17 @@ static enum wl_type_t cfq_choose_wl_type(struct cfq_data *cfqd,
 }
 
 static void
-choose_wl_class_and_type(struct cfq_data *cfqd, struct cfq_group *cfqg)
+choose_wl_class_and_type(struct cfq_data *cfqd)
 {
 	unsigned slice;
 	unsigned count;
 	struct cfq_rb_root *st;
-	unsigned group_slice;
 	enum wl_class_t original_class = cfqd->serving_wl_class;
 
 	/* Choose next priority. RT > BE > IDLE */
-	if (cfq_group_busy_queues_wl(RT_WORKLOAD, cfqd, cfqg))
+	if (cfq_busy_queues_wl(RT_WORKLOAD, cfqd))
 		cfqd->serving_wl_class = RT_WORKLOAD;
-	else if (cfq_group_busy_queues_wl(BE_WORKLOAD, cfqd, cfqg))
+	else if (cfq_busy_queues_wl(BE_WORKLOAD, cfqd))
 		cfqd->serving_wl_class = BE_WORKLOAD;
 	else {
 		cfqd->serving_wl_class = IDLE_WORKLOAD;
@@ -2880,7 +1304,8 @@ choose_wl_class_and_type(struct cfq_data *cfqd, struct cfq_group *cfqg)
 	 * (SYNC, SYNC_NOIDLE, ASYNC), and to compute a workload
 	 * expiration time
 	 */
-	st = st_for(cfqg, cfqd->serving_wl_class, cfqd->serving_wl_type);
+	st = &cfqd->service_trees[cfqd->serving_wl_class]
+				 [cfqd->serving_wl_type];
 	count = st->count;
 
 	/*
@@ -2891,79 +1316,29 @@ choose_wl_class_and_type(struct cfq_data *cfqd, struct cfq_group *cfqg)
 
 new_workload:
 	/* otherwise select new workload type */
-	cfqd->serving_wl_type = cfq_choose_wl_type(cfqd, cfqg,
+	cfqd->serving_wl_type = cfq_choose_wl_type(cfqd,
 					cfqd->serving_wl_class);
-	st = st_for(cfqg, cfqd->serving_wl_class, cfqd->serving_wl_type);
+	st = &cfqd->service_trees[cfqd->serving_wl_class]
+				 [cfqd->serving_wl_type];
 	count = st->count;
 
-	/*
-	 * the workload slice is computed as a fraction of target latency
-	 * proportional to the number of queues in that workload, over
-	 * all the queues in the same priority class
-	 */
-	group_slice = cfq_group_slice(cfqd, cfqg);
-
-	slice = group_slice * count /
-		max_t(unsigned, cfqg->busy_queues_avg[cfqd->serving_wl_class],
-		      cfq_group_busy_queues_wl(cfqd->serving_wl_class, cfqd,
-					cfqg));
-
 	if (cfqd->serving_wl_type == ASYNC_WORKLOAD) {
-		unsigned int tmp;
-
-		/*
-		 * Async queues are currently system wide. Just taking
-		 * proportion of queues with-in same group will lead to higher
-		 * async ratio system wide as generally root group is going
-		 * to have higher weight. A more accurate thing would be to
-		 * calculate system wide asnc/sync ratio.
-		 */
-		tmp = cfqd->cfq_target_latency *
-			cfqg_busy_async_queues(cfqd, cfqg);
-		tmp = tmp/cfqd->busy_queues;
-		slice = min_t(unsigned, slice, tmp);
+		slice = cfqd->cfq_target_latency *
+			cfq_busy_async_queues(cfqd);
+		slice = slice/cfqd->busy_queues;
 
 		/* async workload slice is scaled down according to
 		 * the sync/async slice ratio. */
 		slice = slice * cfqd->cfq_slice[0] / cfqd->cfq_slice[1];
 	} else
-		/* sync workload slice is at least 2 * cfq_slice_idle */
-		slice = max(slice, 2 * cfqd->cfq_slice_idle);
+		/* sync workload slice is 2 * cfq_slice_idle */
+		slice = 2 * cfqd->cfq_slice_idle;
 
 	slice = max_t(unsigned, slice, CFQ_MIN_TT);
 	cfq_log(cfqd, "workload slice:%d", slice);
 	cfqd->workload_expires = jiffies + slice;
 }
 
-static struct cfq_group *cfq_get_next_cfqg(struct cfq_data *cfqd)
-{
-	struct cfq_rb_root *st = &cfqd->grp_service_tree;
-	struct cfq_group *cfqg;
-
-	if (RB_EMPTY_ROOT(&st->rb))
-		return NULL;
-	cfqg = cfq_rb_first_group(st);
-	update_min_vdisktime(st);
-	return cfqg;
-}
-
-static void cfq_choose_cfqg(struct cfq_data *cfqd)
-{
-	struct cfq_group *cfqg = cfq_get_next_cfqg(cfqd);
-
-	cfqd->serving_group = cfqg;
-
-	/* Restore the workload type data */
-	if (cfqg->saved_wl_slice) {
-		cfqd->workload_expires = jiffies + cfqg->saved_wl_slice;
-		cfqd->serving_wl_type = cfqg->saved_wl_type;
-		cfqd->serving_wl_class = cfqg->saved_wl_class;
-	} else
-		cfqd->workload_expires = jiffies - 1;
-
-	choose_wl_class_and_type(cfqd, cfqg);
-}
-
 /*
  * Select a queue for service. If we have a current active queue,
  * check whether to continue servicing it, or retrieve and set a new one.
@@ -2979,9 +1354,6 @@ static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
 	if (!cfqd->rq_queued)
 		return NULL;
 
-	/*
-	 * We were waiting for group to get backlogged. Expire the queue
-	 */
 	if (cfq_cfqq_wait_busy(cfqq) && !RB_EMPTY_ROOT(&cfqq->sort_list))
 		goto expire;
 
@@ -2992,18 +1364,17 @@ static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
 		/*
 		 * If slice had not expired at the completion of last request
 		 * we might not have turned on wait_busy flag. Don't expire
-		 * the queue yet. Allow the group to get backlogged.
+		 * the queue yet. Allow the device to get backlogged.
 		 *
 		 * The very fact that we have used the slice, that means we
 		 * have been idling all along on this queue and it should be
 		 * ok to wait for this request to complete.
 		 */
-		if (cfqq->cfqg->nr_cfqq == 1 && RB_EMPTY_ROOT(&cfqq->sort_list)
+		if (cfqd->busy_queues == 1 && RB_EMPTY_ROOT(&cfqq->sort_list)
 		    && cfqq->dispatched && cfq_should_idle(cfqd, cfqq)) {
 			cfqq = NULL;
 			goto keep_queue;
-		} else
-			goto check_group_idle;
+		}
 	}
 
 	/*
@@ -3037,18 +1408,6 @@ static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
 		goto keep_queue;
 	}
 
-	/*
-	 * If group idle is enabled and there are requests dispatched from
-	 * this group, wait for requests to complete.
-	 */
-check_group_idle:
-	if (cfqd->cfq_group_idle && cfqq->cfqg->nr_cfqq == 1 &&
-	    cfqq->cfqg->dispatched &&
-	    !cfq_io_thinktime_big(cfqd, &cfqq->cfqg->ttime, true)) {
-		cfqq = NULL;
-		goto keep_queue;
-	}
-
 expire:
 	cfq_slice_expired(cfqd, 0);
 new_queue:
@@ -3057,7 +1416,7 @@ new_queue:
 	 * service tree
 	 */
 	if (!new_cfqq)
-		cfq_choose_cfqg(cfqd);
+		choose_wl_class_and_type(cfqd);
 
 	cfqq = cfq_set_active_queue(cfqd, new_cfqq);
 keep_queue:
@@ -3282,13 +1641,11 @@ static int cfq_dispatch_requests(struct request_queue *q, int force)
  * task holds one reference to the queue, dropped when task exits. each rq
  * in-flight on this queue also holds a reference, dropped when rq is freed.
  *
- * Each cfq queue took a reference on the parent group. Drop it now.
- * queue lock must be held here.
+ * Queue lock must be held here.
  */
 static void cfq_put_queue(struct cfq_queue *cfqq)
 {
 	struct cfq_data *cfqd = cfqq->cfqd;
-	struct cfq_group *cfqg;
 
 	BUG_ON(cfqq->ref <= 0);
 
@@ -3299,7 +1656,6 @@ static void cfq_put_queue(struct cfq_queue *cfqq)
 	cfq_log_cfqq(cfqd, cfqq, "put_queue");
 	BUG_ON(rb_first(&cfqq->sort_list));
 	BUG_ON(cfqq->allocated[READ] + cfqq->allocated[WRITE]);
-	cfqg = cfqq->cfqg;
 
 	if (unlikely(cfqd->active_queue == cfqq)) {
 		__cfq_slice_expired(cfqd, cfqq, 0);
@@ -3308,7 +1664,6 @@ static void cfq_put_queue(struct cfq_queue *cfqq)
 
 	BUG_ON(cfq_cfqq_on_rr(cfqq));
 	kmem_cache_free(cfq_pool, cfqq);
-	cfqg_put(cfqg);
 }
 
 static void cfq_exit_cfqq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
@@ -3433,61 +1788,19 @@ static void cfq_init_cfqq(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	cfqq->pid = pid;
 }
 
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-static void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio)
-{
-	struct cfq_data *cfqd = cic_to_cfqd(cic);
-	struct cfq_queue *cfqq;
-	uint64_t serial_nr;
-
-	rcu_read_lock();
-	serial_nr = bio_blkcg(bio)->css.serial_nr;
-	rcu_read_unlock();
-
-	/*
-	 * Check whether blkcg has changed.  The condition may trigger
-	 * spuriously on a newly created cic but there's no harm.
-	 */
-	if (unlikely(!cfqd) || likely(cic->blkcg_serial_nr == serial_nr))
-		return;
-
-	/*
-	 * Drop reference to queues.  New queues will be assigned in new
-	 * group upon arrival of fresh requests.
-	 */
-	cfqq = cic_to_cfqq(cic, false);
-	if (cfqq) {
-		cfq_log_cfqq(cfqd, cfqq, "changed cgroup");
-		cic_set_cfqq(cic, NULL, false);
-		cfq_put_queue(cfqq);
-	}
-
-	cfqq = cic_to_cfqq(cic, true);
-	if (cfqq) {
-		cfq_log_cfqq(cfqd, cfqq, "changed cgroup");
-		cic_set_cfqq(cic, NULL, true);
-		cfq_put_queue(cfqq);
-	}
-
-	cic->blkcg_serial_nr = serial_nr;
-}
-#else
-static inline void check_blkcg_changed(struct cfq_io_cq *cic, struct bio *bio) { }
-#endif  /* CONFIG_CFQ_GROUP_IOSCHED */
-
 static struct cfq_queue **
-cfq_async_queue_prio(struct cfq_group *cfqg, int ioprio_class, int ioprio)
+cfq_async_queue_prio(struct cfq_data *cfqd, int ioprio_class, int ioprio)
 {
 	switch (ioprio_class) {
 	case IOPRIO_CLASS_RT:
-		return &cfqg->async_cfqq[0][ioprio];
+		return &cfqd->async_cfqq[0][ioprio];
 	case IOPRIO_CLASS_NONE:
 		ioprio = IOPRIO_NORM;
 		/* fall through */
 	case IOPRIO_CLASS_BE:
-		return &cfqg->async_cfqq[1][ioprio];
+		return &cfqd->async_cfqq[1][ioprio];
 	case IOPRIO_CLASS_IDLE:
-		return &cfqg->async_idle_cfqq;
+		return &cfqd->async_idle_cfqq;
 	default:
 		BUG();
 	}
@@ -3501,14 +1814,8 @@ cfq_get_queue(struct cfq_data *cfqd, bool is_sync, struct cfq_io_cq *cic,
 	int ioprio = IOPRIO_PRIO_DATA(cic->ioprio);
 	struct cfq_queue **async_cfqq = NULL;
 	struct cfq_queue *cfqq;
-	struct cfq_group *cfqg;
 
 	rcu_read_lock();
-	cfqg = cfq_lookup_cfqg(cfqd, bio_blkcg(bio));
-	if (!cfqg) {
-		cfqq = &cfqd->oom_cfqq;
-		goto out;
-	}
 
 	if (!is_sync) {
 		if (!ioprio_valid(cic->ioprio)) {
@@ -3516,7 +1823,7 @@ cfq_get_queue(struct cfq_data *cfqd, bool is_sync, struct cfq_io_cq *cic,
 			ioprio = task_nice_ioprio(tsk);
 			ioprio_class = task_nice_ioclass(tsk);
 		}
-		async_cfqq = cfq_async_queue_prio(cfqg, ioprio_class, ioprio);
+		async_cfqq = cfq_async_queue_prio(cfqd, ioprio_class, ioprio);
 		cfqq = *async_cfqq;
 		if (cfqq)
 			goto out;
@@ -3531,7 +1838,6 @@ cfq_get_queue(struct cfq_data *cfqd, bool is_sync, struct cfq_io_cq *cic,
 
 	cfq_init_cfqq(cfqd, cfqq, current->pid, is_sync);
 	cfq_init_prio_data(cfqq, cic);
-	cfq_link_cfqq_cfqg(cfqq, cfqg);
 	cfq_log_cfqq(cfqd, cfqq, "alloced");
 
 	if (async_cfqq) {
@@ -3565,9 +1871,6 @@ cfq_update_io_thinktime(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 		__cfq_update_io_thinktime(&cfqq->service_tree->ttime,
 			cfqd->cfq_slice_idle);
 	}
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	__cfq_update_io_thinktime(&cfqq->cfqg->ttime, cfqd->cfq_group_idle);
-#endif
 }
 
 static void
@@ -3658,14 +1961,6 @@ cfq_should_preempt(struct cfq_data *cfqd, struct cfq_queue *new_cfqq,
 	if (rq_is_sync(rq) && !cfq_cfqq_sync(cfqq))
 		return true;
 
-	/*
-	 * Treat ancestors of current cgroup the same way as current cgroup.
-	 * For anybody else we disallow preemption to guarantee service
-	 * fairness among cgroups.
-	 */
-	if (!cfqg_is_descendant(cfqq->cfqg, new_cfqq->cfqg))
-		return false;
-
 	if (cfq_slice_used(cfqq))
 		return true;
 
@@ -3705,19 +2000,10 @@ cfq_should_preempt(struct cfq_data *cfqd, struct cfq_queue *new_cfqq,
  */
 static void cfq_preempt_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 {
-	enum wl_type_t old_type = cfqq_type(cfqd->active_queue);
-
 	cfq_log_cfqq(cfqd, cfqq, "preempt");
 	cfq_slice_expired(cfqd, 1);
 
 	/*
-	 * workload type is changed, don't save slice, otherwise preempt
-	 * doesn't happen
-	 */
-	if (old_type != cfqq_type(cfqq))
-		cfqq->cfqg->saved_wl_slice = 0;
-
-	/*
 	 * Put the new queue at the front of the of the current list,
 	 * so we know that it will be selected next.
 	 */
@@ -3766,10 +2052,8 @@ cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 				cfq_del_timer(cfqd, cfqq);
 				cfq_clear_cfqq_wait_request(cfqq);
 				__blk_run_queue(cfqd->queue);
-			} else {
-				cfqg_stats_update_idle_time(cfqq->cfqg);
+			} else
 				cfq_mark_cfqq_must_dispatch(cfqq);
-			}
 		}
 	} else if (cfq_should_preempt(cfqd, cfqq, rq)) {
 		/*
@@ -3794,8 +2078,6 @@ static void cfq_insert_request(struct request_queue *q, struct request *rq)
 	rq->fifo_time = jiffies + cfqd->cfq_fifo_expire[rq_is_sync(rq)];
 	list_add_tail(&rq->queuelist, &cfqq->fifo);
 	cfq_add_rq_rb(rq);
-	cfqg_stats_update_io_add(RQ_CFQG(rq), cfqd->serving_group,
-				 rq->cmd_flags);
 	cfq_rq_enqueued(cfqd, cfqq, rq);
 }
 
@@ -3844,14 +2126,6 @@ static bool cfq_should_wait_busy(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 	if (!RB_EMPTY_ROOT(&cfqq->sort_list))
 		return false;
 
-	/* If there are other queues in the group, don't wait */
-	if (cfqq->cfqg->nr_cfqq > 1)
-		return false;
-
-	/* the only queue in the group, but think time is big */
-	if (cfq_io_thinktime_big(cfqd, &cfqq->cfqg->ttime, true))
-		return false;
-
 	if (cfq_slice_used(cfqq))
 		return true;
 
@@ -3890,9 +2164,6 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 	WARN_ON(!cfqq->dispatched);
 	cfqd->rq_in_driver--;
 	cfqq->dispatched--;
-	(RQ_CFQG(rq))->dispatched--;
-	cfqg_stats_update_completion(cfqq->cfqg, rq_start_time_ns(rq),
-				     rq_io_start_time_ns(rq), rq->cmd_flags);
 
 	cfqd->rq_in_flight[cfq_cfqq_sync(cfqq)]--;
 
@@ -3904,18 +2175,14 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 		if (cfq_cfqq_on_rr(cfqq))
 			st = cfqq->service_tree;
 		else
-			st = st_for(cfqq->cfqg, cfqq_class(cfqq),
-					cfqq_type(cfqq));
+			st = &cfqd->service_trees[cfqq_class(cfqq)]
+						 [cfqq_type(cfqq)];
 
 		st->ttime.last_end_request = now;
 		if (!time_after(rq->start_time + cfqd->cfq_fifo_expire[1], now))
 			cfqd->last_delayed_sync = now;
 	}
 
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	cfqq->cfqg->ttime.last_end_request = now;
-#endif
-
 	/*
 	 * If this is the active queue, check if it needs to be expired,
 	 * or if we want to idle in case it has no pending requests.
@@ -3934,8 +2201,6 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 		 */
 		if (cfq_should_wait_busy(cfqd, cfqq)) {
 			unsigned long extend_sl = cfqd->cfq_slice_idle;
-			if (!cfqd->cfq_slice_idle)
-				extend_sl = cfqd->cfq_group_idle;
 			cfqq->slice_end = jiffies + extend_sl;
 			cfq_mark_cfqq_wait_busy(cfqq);
 			cfq_log_cfqq(cfqd, cfqq, "will busy wait");
@@ -4008,8 +2273,6 @@ static void cfq_put_request(struct request *rq)
 		BUG_ON(!cfqq->allocated[rw]);
 		cfqq->allocated[rw]--;
 
-		/* Put down rq reference on cfqg */
-		cfqg_put(RQ_CFQG(rq));
 		rq->elv.priv[0] = NULL;
 		rq->elv.priv[1] = NULL;
 
@@ -4033,7 +2296,6 @@ cfq_set_request(struct request_queue *q, struct request *rq, struct bio *bio,
 	spin_lock_irq(q->queue_lock);
 
 	check_ioprio_changed(cic, bio);
-	check_blkcg_changed(cic, bio);
 
 	cfqq = cic_to_cfqq(cic, is_sync);
 	if (!cfqq || cfqq == &cfqd->oom_cfqq) {
@@ -4046,9 +2308,7 @@ cfq_set_request(struct request_queue *q, struct request *rq, struct bio *bio,
 	cfqq->allocated[rw]++;
 
 	cfqq->ref++;
-	cfqg_get(cfqq->cfqg);
 	rq->elv.priv[0] = cfqq;
-	rq->elv.priv[1] = cfqq->cfqg;
 	spin_unlock_irq(q->queue_lock);
 	return 0;
 }
@@ -4137,19 +2397,12 @@ static void cfq_exit_queue(struct elevator_queue *e)
 
 	cfq_shutdown_timer_wq(cfqd);
 
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	blkcg_deactivate_policy(q, &blkcg_policy_cfq);
-#else
-	kfree(cfqd->root_group);
-#endif
 	kfree(cfqd);
 }
 
 static int cfq_init_queue(struct request_queue *q, struct elevator_type *e)
 {
 	struct cfq_data *cfqd;
-	struct blkcg_gq *blkg __maybe_unused;
-	int ret;
 	struct elevator_queue *eq;
 
 	eq = elevator_alloc(q, e);
@@ -4168,41 +2421,15 @@ static int cfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	q->elevator = eq;
 	spin_unlock_irq(q->queue_lock);
 
-	/* Init root service tree */
-	cfqd->grp_service_tree = CFQ_RB_ROOT;
-
-	/* Init root group and prefer root group over other groups by default */
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	ret = blkcg_activate_policy(q, &blkcg_policy_cfq);
-	if (ret)
-		goto out_free;
-
-	cfqd->root_group = blkg_to_cfqg(q->root_blkg);
-#else
-	ret = -ENOMEM;
-	cfqd->root_group = kzalloc_node(sizeof(*cfqd->root_group),
-					GFP_KERNEL, cfqd->queue->node);
-	if (!cfqd->root_group)
-		goto out_free;
-
-	cfq_init_cfqg_base(cfqd->root_group);
-	cfqd->root_group->weight = 2 * CFQ_WEIGHT_LEGACY_DFL;
-	cfqd->root_group->leaf_weight = 2 * CFQ_WEIGHT_LEGACY_DFL;
-#endif
-
 	/*
 	 * Our fallback cfqq if cfq_get_queue() runs into OOM issues.
 	 * Grab a permanent reference to it, so that the normal code flow
-	 * will not attempt to free it.  oom_cfqq is linked to root_group
-	 * but shouldn't hold a reference as it'll never be unlinked.  Lose
-	 * the reference from linking right away.
+	 * will not attempt to free it.
 	 */
 	cfq_init_cfqq(cfqd, &cfqd->oom_cfqq, 1, 0);
 	cfqd->oom_cfqq.ref++;
 
 	spin_lock_irq(q->queue_lock);
-	cfq_link_cfqq_cfqg(&cfqd->oom_cfqq, cfqd->root_group);
-	cfqg_put(cfqd->root_group);
 	spin_unlock_irq(q->queue_lock);
 
 	init_timer(&cfqd->idle_slice_timer);
@@ -4221,7 +2448,6 @@ static int cfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	cfqd->cfq_target_latency = cfq_target_latency;
 	cfqd->cfq_slice_async_rq = cfq_slice_async_rq;
 	cfqd->cfq_slice_idle = cfq_slice_idle;
-	cfqd->cfq_group_idle = cfq_group_idle;
 	cfqd->cfq_latency = 1;
 	cfqd->hw_tag = -1;
 	/*
@@ -4230,11 +2456,6 @@ static int cfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 */
 	cfqd->last_delayed_sync = jiffies - HZ;
 	return 0;
-
-out_free:
-	kfree(cfqd);
-	kobject_put(&eq->kobj);
-	return ret;
 }
 
 static void cfq_registered_queue(struct request_queue *q)
@@ -4282,7 +2503,6 @@ SHOW_FUNCTION(cfq_fifo_expire_async_show, cfqd->cfq_fifo_expire[0], 1);
 SHOW_FUNCTION(cfq_back_seek_max_show, cfqd->cfq_back_max, 0);
 SHOW_FUNCTION(cfq_back_seek_penalty_show, cfqd->cfq_back_penalty, 0);
 SHOW_FUNCTION(cfq_slice_idle_show, cfqd->cfq_slice_idle, 1);
-SHOW_FUNCTION(cfq_group_idle_show, cfqd->cfq_group_idle, 1);
 SHOW_FUNCTION(cfq_slice_sync_show, cfqd->cfq_slice[1], 1);
 SHOW_FUNCTION(cfq_slice_async_show, cfqd->cfq_slice[0], 1);
 SHOW_FUNCTION(cfq_slice_async_rq_show, cfqd->cfq_slice_async_rq, 0);
@@ -4315,7 +2535,6 @@ STORE_FUNCTION(cfq_back_seek_max_store, &cfqd->cfq_back_max, 0, UINT_MAX, 0);
 STORE_FUNCTION(cfq_back_seek_penalty_store, &cfqd->cfq_back_penalty, 1,
 		UINT_MAX, 0);
 STORE_FUNCTION(cfq_slice_idle_store, &cfqd->cfq_slice_idle, 0, UINT_MAX, 1);
-STORE_FUNCTION(cfq_group_idle_store, &cfqd->cfq_group_idle, 0, UINT_MAX, 1);
 STORE_FUNCTION(cfq_slice_sync_store, &cfqd->cfq_slice[1], 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_slice_async_store, &cfqd->cfq_slice[0], 1, UINT_MAX, 1);
 STORE_FUNCTION(cfq_slice_async_rq_store, &cfqd->cfq_slice_async_rq, 1,
@@ -4337,7 +2556,6 @@ static struct elv_fs_entry cfq_attrs[] = {
 	CFQ_ATTR(slice_async),
 	CFQ_ATTR(slice_async_rq),
 	CFQ_ATTR(slice_idle),
-	CFQ_ATTR(group_idle),
 	CFQ_ATTR(low_latency),
 	CFQ_ATTR(target_latency),
 	__ATTR_NULL
@@ -4349,7 +2567,6 @@ static struct elevator_type iosched_cfq = {
 		.elevator_merged_fn =		cfq_merged_request,
 		.elevator_merge_req_fn =	cfq_merged_requests,
 		.elevator_allow_merge_fn =	cfq_allow_merge,
-		.elevator_bio_merged_fn =	cfq_bio_merged,
 		.elevator_dispatch_fn =		cfq_dispatch_requests,
 		.elevator_add_req_fn =		cfq_insert_request,
 		.elevator_activate_req_fn =	cfq_activate_request,
@@ -4373,24 +2590,6 @@ static struct elevator_type iosched_cfq = {
 	.elevator_owner =	THIS_MODULE,
 };
 
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-static struct blkcg_policy blkcg_policy_cfq = {
-	.dfl_cftypes		= cfq_blkcg_files,
-	.legacy_cftypes		= cfq_blkcg_legacy_files,
-
-	.cpd_alloc_fn		= cfq_cpd_alloc,
-	.cpd_init_fn		= cfq_cpd_init,
-	.cpd_free_fn		= cfq_cpd_free,
-	.cpd_bind_fn		= cfq_cpd_bind,
-
-	.pd_alloc_fn		= cfq_pd_alloc,
-	.pd_init_fn		= cfq_pd_init,
-	.pd_offline_fn		= cfq_pd_offline,
-	.pd_free_fn		= cfq_pd_free,
-	.pd_reset_stats_fn	= cfq_pd_reset_stats,
-};
-#endif
-
 static int __init cfq_init(void)
 {
 	int ret;
@@ -4403,21 +2602,10 @@ static int __init cfq_init(void)
 	if (!cfq_slice_idle)
 		cfq_slice_idle = 1;
 
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	if (!cfq_group_idle)
-		cfq_group_idle = 1;
-
-	ret = blkcg_policy_register(&blkcg_policy_cfq);
-	if (ret)
-		return ret;
-#else
-	cfq_group_idle = 0;
-#endif
-
 	ret = -ENOMEM;
 	cfq_pool = KMEM_CACHE(cfq_queue, 0);
 	if (!cfq_pool)
-		goto err_pol_unreg;
+		return ret;
 
 	ret = elv_register(&iosched_cfq);
 	if (ret)
@@ -4427,18 +2615,11 @@ static int __init cfq_init(void)
 
 err_free_pool:
 	kmem_cache_destroy(cfq_pool);
-err_pol_unreg:
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	blkcg_policy_unregister(&blkcg_policy_cfq);
-#endif
 	return ret;
 }
 
 static void __exit cfq_exit(void)
 {
-#ifdef CONFIG_CFQ_GROUP_IOSCHED
-	blkcg_policy_unregister(&blkcg_policy_cfq);
-#endif
 	elv_unregister(&iosched_cfq);
 	kmem_cache_destroy(cfq_pool);
 }
-- 
1.9.1
