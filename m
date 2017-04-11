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
Subject: [PATCH V3 16/16] block, bfq: split bfq-iosched.c into multiple source files
Date: Tue, 11 Apr 2017 15:43:15 +0200
Message-Id: <20170411134315.44135-17-paolo.valente@linaro.org>
In-Reply-To: <20170411134315.44135-1-paolo.valente@linaro.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The BFQ I/O scheduler features an optimal fair-queuing
(proportional-share) scheduling algorithm, enriched with several
mechanisms to boost throughput and reduce latency for interactive and
real-time applications. This makes BFQ a large and complex piece of
code. This commit addresses this issue by splitting BFQ into three
main, independent components, and by moving each component into a
separate source file:
1. Main algorithm: handles the interaction with the kernel, and
decides which requests to dispatch; it uses the following two further
components to achieve its goals.
2. Scheduling engine (Hierarchical B-WF2Q+ scheduling algorithm):
computes the schedule, using weights and budgets provided by the above
component.
3. cgroups support: handles group operations (creation, destruction,
move, ...).

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/Makefile      |    2 +-
 block/bfq-cgroup.c  | 1139 +++++++++++++++
 block/bfq-iosched.c | 3925 +++------------------------------------------------
 block/bfq-iosched.h |  942 +++++++++++++
 block/bfq-wf2q.c    | 1616 +++++++++++++++++++++
 5 files changed, 3868 insertions(+), 3756 deletions(-)
 create mode 100644 block/bfq-cgroup.c
 create mode 100644 block/bfq-iosched.h
 create mode 100644 block/bfq-wf2q.c

diff --git a/block/Makefile b/block/Makefile
index 91869f2..546066e 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_IOSCHED_NOOP)	+= noop-iosched.o
 obj-$(CONFIG_IOSCHED_DEADLINE)	+= deadline-iosched.o
 obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o
-obj-$(CONFIG_IOSCHED_BFQ)	+= bfq-iosched.o
+obj-$(CONFIG_IOSCHED_BFQ)	+= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 
 obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
new file mode 100644
index 0000000..c8a32fb
--- /dev/null
+++ b/block/bfq-cgroup.c
@@ -0,0 +1,1139 @@
+/*
+ * cgroups support for the BFQ I/O scheduler.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation; either version 2 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ */
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include <linux/cgroup.h>
+#include <linux/elevator.h>
+#include <linux/ktime.h>
+#include <linux/rbtree.h>
+#include <linux/ioprio.h>
+#include <linux/sbitmap.h>
+#include <linux/delay.h>
+
+#include "bfq-iosched.h"
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
+void bfqg_stats_update_dequeue(struct bfq_group *bfqg)
+{
+	blkg_stat_add(&bfqg->stats.dequeue, 1);
+}
+
+void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg)
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
+void bfqg_stats_update_idle_time(struct bfq_group *bfqg)
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
+void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg)
+{
+	struct bfqg_stats *stats = &bfqg->stats;
+
+	stats->start_idle_time = sched_clock();
+	bfqg_stats_mark_idling(stats);
+}
+
+void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
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
+struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg)
+{
+	return pd_to_blkg(&bfqg->pd);
+}
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
+struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
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
+void bfqg_put(struct bfq_group *bfqg)
+{
+	return blkg_put(bfqg_to_blkg(bfqg));
+}
+
+void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
+			      unsigned int op)
+{
+	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
+	bfqg_stats_end_empty_time(&bfqg->stats);
+	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
+		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
+}
+
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op)
+{
+	blkg_rwstat_add(&bfqg->stats.queued, op, -1);
+}
+
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op)
+{
+	blkg_rwstat_add(&bfqg->stats.merged, op, 1);
+}
+
+void bfqg_stats_update_completion(struct bfq_group *bfqg, uint64_t start_time,
+				  uint64_t io_start_time, unsigned int op)
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
+void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
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
+struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
+{
+	struct bfq_group_data *bgd;
+
+	bgd = kzalloc(sizeof(*bgd), gfp);
+	if (!bgd)
+		return NULL;
+	return &bgd->pd;
+}
+
+void bfq_cpd_init(struct blkcg_policy_data *cpd)
+{
+	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
+
+	d->weight = cgroup_subsys_on_dfl(io_cgrp_subsys) ?
+		CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
+}
+
+void bfq_cpd_free(struct blkcg_policy_data *cpd)
+{
+	kfree(cpd_to_bfqgd(cpd));
+}
+
+struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, int node)
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
+void bfq_pd_init(struct blkg_policy_data *pd)
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
+	bfqg->active_entities = 0;
+	bfqg->rq_pos_tree = RB_ROOT;
+}
+
+void bfq_pd_free(struct blkg_policy_data *pd)
+{
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+
+	bfqg_stats_exit(&bfqg->stats);
+	return kfree(bfqg);
+}
+
+void bfq_pd_reset_stats(struct blkg_policy_data *pd)
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
+struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
+				     struct blkcg *blkcg)
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
+void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+		   struct bfq_group *bfqg)
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
+	if (bfq_bfqq_busy(bfqq)) {
+		bfq_pos_tree_add_move(bfqd, bfqq);
+		bfq_activate_bfqq(bfqd, bfqq);
+	}
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
+				     async_bfqq, async_bfqq->ref);
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
+void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
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
+void bfq_pd_offline(struct blkg_policy_data *pd)
+{
+	struct bfq_service_tree *st;
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+	struct bfq_data *bfqd = bfqg->bfqd;
+	struct bfq_entity *entity = bfqg->my_entity;
+	unsigned long flags;
+	int i;
+
+	if (!entity) /* root group */
+		return;
+
+	spin_lock_irqsave(&bfqd->lock, flags);
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
+}
+
+void bfq_end_wr_async(struct bfq_data *bfqd)
+{
+	struct blkcg_gq *blkg;
+
+	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
+		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
+
+		bfq_end_wr_async_queues(bfqd, bfqg);
+	}
+	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
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
+	int ret = -ERANGE;
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
+
+struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
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
+struct blkcg_policy blkcg_policy_bfq = {
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
+
+struct cftype bfq_blkcg_legacy_files[] = {
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
+struct cftype bfq_blkg_files[] = {
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
+void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
+			      unsigned int op) { }
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op) { }
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op) { }
+void bfqg_stats_update_completion(struct bfq_group *bfqg, uint64_t start_time,
+				  uint64_t io_start_time, unsigned int op) { }
+void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
+void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
+void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
+void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg) { }
+void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg) { }
+
+void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+		   struct bfq_group *bfqg) {}
+
+void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
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
+void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio) {}
+
+void bfq_end_wr_async(struct bfq_data *bfqd)
+{
+	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
+}
+
+struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd, struct blkcg *blkcg)
+{
+	return bfqd->root_group;
+}
+
+struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
+{
+	return bfqq->bfqd->root_group;
+}
+
+struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
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
+#endif	/* CONFIG_BFQ_GROUP_IOSCHED */
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 30bb8f9..6d14f18 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -102,3765 +102,201 @@
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 #include "blk-mq-sched.h"
-#include <linux/blktrace_api.h>
-#include <linux/hrtimer.h>
-#include <linux/blk-cgroup.h>
+#include "bfq-iosched.h"
 
-#define BFQ_IOPRIO_CLASSES	3
-#define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
-
-#define BFQ_MIN_WEIGHT			1
-#define BFQ_MAX_WEIGHT			1000
-#define BFQ_WEIGHT_CONVERSION_COEFF	10
-
-#define BFQ_DEFAULT_QUEUE_IOPRIO	4
-
-#define BFQ_WEIGHT_LEGACY_DFL	100
-#define BFQ_DEFAULT_GRP_IOPRIO	0
-#define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
-
-/*
- * Soft real-time applications are extremely more latency sensitive
- * than interactive ones. Over-raise the weight of the former to
- * privilege them against the latter.
- */
-#define BFQ_SOFTRT_WEIGHT_FACTOR	100
-
-struct bfq_entity;
-
-/**
- * struct bfq_service_tree - per ioprio_class service tree.
- *
- * Each service tree represents a B-WF2Q+ scheduler on its own.  Each
- * ioprio_class has its own independent scheduler, and so its own
- * bfq_service_tree.  All the fields are protected by the queue lock
- * of the containing bfqd.
- */
-struct bfq_service_tree {
-	/* tree for active entities (i.e., those backlogged) */
-	struct rb_root active;
-	/* tree for idle entities (i.e., not backlogged, with V <= F_i)*/
-	struct rb_root idle;
-
-	/* idle entity with minimum F_i */
-	struct bfq_entity *first_idle;
-	/* idle entity with maximum F_i */
-	struct bfq_entity *last_idle;
-
-	/* scheduler virtual time */
-	u64 vtime;
-	/* scheduler weight sum; active and idle entities contribute to it */
-	unsigned long wsum;
-};
-
-/**
- * struct bfq_sched_data - multi-class scheduler.
- *
- * bfq_sched_data is the basic scheduler queue.  It supports three
- * ioprio_classes, and can be used either as a toplevel queue or as an
- * intermediate queue on a hierarchical setup.  @next_in_service
- * points to the active entity of the sched_data service trees that
- * will be scheduled next. It is used to reduce the number of steps
- * needed for each hierarchical-schedule update.
- *
- * The supported ioprio_classes are the same as in CFQ, in descending
- * priority order, IOPRIO_CLASS_RT, IOPRIO_CLASS_BE, IOPRIO_CLASS_IDLE.
- * Requests from higher priority queues are served before all the
- * requests from lower priority queues; among requests of the same
- * queue requests are served according to B-WF2Q+.
- * All the fields are protected by the queue lock of the containing bfqd.
- */
-struct bfq_sched_data {
-	/* entity in service */
-	struct bfq_entity *in_service_entity;
-	/* head-of-line entity (see comments above) */
-	struct bfq_entity *next_in_service;
-	/* array of service trees, one per ioprio_class */
-	struct bfq_service_tree service_tree[BFQ_IOPRIO_CLASSES];
-	/* last time CLASS_IDLE was served */
-	unsigned long bfq_class_idle_last_service;
-
-};
-
-/**
- * struct bfq_weight_counter - counter of the number of all active entities
- *                             with a given weight.
- */
-struct bfq_weight_counter {
-	unsigned int weight; /* weight of the entities this counter refers to */
-	unsigned int num_active; /* nr of active entities with this weight */
-	/*
-	 * Weights tree member (see bfq_data's @queue_weights_tree and
-	 * @group_weights_tree)
-	 */
-	struct rb_node weights_node;
-};
-
-/**
- * struct bfq_entity - schedulable entity.
- *
- * A bfq_entity is used to represent either a bfq_queue (leaf node in the
- * cgroup hierarchy) or a bfq_group into the upper level scheduler.  Each
- * entity belongs to the sched_data of the parent group in the cgroup
- * hierarchy.  Non-leaf entities have also their own sched_data, stored
- * in @my_sched_data.
- *
- * Each entity stores independently its priority values; this would
- * allow different weights on different devices, but this
- * functionality is not exported to userspace by now.  Priorities and
- * weights are updated lazily, first storing the new values into the
- * new_* fields, then setting the @prio_changed flag.  As soon as
- * there is a transition in the entity state that allows the priority
- * update to take place the effective and the requested priority
- * values are synchronized.
- *
- * Unless cgroups are used, the weight value is calculated from the
- * ioprio to export the same interface as CFQ.  When dealing with
- * ``well-behaved'' queues (i.e., queues that do not spend too much
- * time to consume their budget and have true sequential behavior, and
- * when there are no external factors breaking anticipation) the
- * relative weights at each level of the cgroups hierarchy should be
- * guaranteed.  All the fields are protected by the queue lock of the
- * containing bfqd.
- */
-struct bfq_entity {
-	/* service_tree member */
-	struct rb_node rb_node;
-	/* pointer to the weight counter associated with this entity */
-	struct bfq_weight_counter *weight_counter;
-
-	/*
-	 * Flag, true if the entity is on a tree (either the active or
-	 * the idle one of its service_tree) or is in service.
-	 */
-	bool on_st;
-
-	/* B-WF2Q+ start and finish timestamps [sectors/weight] */
-	u64 start, finish;
-
-	/* tree the entity is enqueued into; %NULL if not on a tree */
-	struct rb_root *tree;
-
-	/*
-	 * minimum start time of the (active) subtree rooted at this
-	 * entity; used for O(log N) lookups into active trees
-	 */
-	u64 min_start;
-
-	/* amount of service received during the last service slot */
-	int service;
-
-	/* budget, used also to calculate F_i: F_i = S_i + @budget / @weight */
-	int budget;
-
-	/* weight of the queue */
-	int weight;
-	/* next weight if a change is in progress */
-	int new_weight;
-
-	/* original weight, used to implement weight boosting */
-	int orig_weight;
-
-	/* parent entity, for hierarchical scheduling */
-	struct bfq_entity *parent;
-
-	/*
-	 * For non-leaf nodes in the hierarchy, the associated
-	 * scheduler queue, %NULL on leaf nodes.
-	 */
-	struct bfq_sched_data *my_sched_data;
-	/* the scheduler queue this entity belongs to */
-	struct bfq_sched_data *sched_data;
-
-	/* flag, set to request a weight, ioprio or ioprio_class change  */
-	int prio_changed;
-};
-
-struct bfq_group;
-
-/**
- * struct bfq_ttime - per process thinktime stats.
- */
-struct bfq_ttime {
-	/* completion time of the last request */
-	u64 last_end_request;
-
-	/* total process thinktime */
-	u64 ttime_total;
-	/* number of thinktime samples */
-	unsigned long ttime_samples;
-	/* average process thinktime */
-	u64 ttime_mean;
-};
-
-/**
- * struct bfq_queue - leaf schedulable entity.
- *
- * A bfq_queue is a leaf request queue; it can be associated with an
- * io_context or more, if it  is  async or shared  between  cooperating
- * processes. @cgroup holds a reference to the cgroup, to be sure that it
- * does not disappear while a bfqq still references it (mostly to avoid
- * races between request issuing and task migration followed by cgroup
- * destruction).
- * All the fields are protected by the queue lock of the containing bfqd.
- */
-struct bfq_queue {
-	/* reference counter */
-	int ref;
-	/* parent bfq_data */
-	struct bfq_data *bfqd;
-
-	/* current ioprio and ioprio class */
-	unsigned short ioprio, ioprio_class;
-	/* next ioprio and ioprio class if a change is in progress */
-	unsigned short new_ioprio, new_ioprio_class;
-
-	/*
-	 * Shared bfq_queue if queue is cooperating with one or more
-	 * other queues.
-	 */
-	struct bfq_queue *new_bfqq;
-	/* request-position tree member (see bfq_group's @rq_pos_tree) */
-	struct rb_node pos_node;
-	/* request-position tree root (see bfq_group's @rq_pos_tree) */
-	struct rb_root *pos_root;
-
-	/* sorted list of pending requests */
-	struct rb_root sort_list;
-	/* if fifo isn't expired, next request to serve */
-	struct request *next_rq;
-	/* number of sync and async requests queued */
-	int queued[2];
-	/* number of requests currently allocated */
-	int allocated;
-	/* number of pending metadata requests */
-	int meta_pending;
-	/* fifo list of requests in sort_list */
-	struct list_head fifo;
-
-	/* entity representing this queue in the scheduler */
-	struct bfq_entity entity;
-
-	/* maximum budget allowed from the feedback mechanism */
-	int max_budget;
-	/* budget expiration (in jiffies) */
-	unsigned long budget_timeout;
-
-	/* number of requests on the dispatch list or inside driver */
-	int dispatched;
-
-	/* status flags */
-	unsigned long flags;
-
-	/* node for active/idle bfqq list inside parent bfqd */
-	struct list_head bfqq_list;
-
-	/* associated @bfq_ttime struct */
-	struct bfq_ttime ttime;
-
-	/* bit vector: a 1 for each seeky requests in history */
-	u32 seek_history;
-
-	/* node for the device's burst list */
-	struct hlist_node burst_list_node;
-
-	/* position of the last request enqueued */
-	sector_t last_request_pos;
-
-	/* Number of consecutive pairs of request completion and
-	 * arrival, such that the queue becomes idle after the
-	 * completion, but the next request arrives within an idle
-	 * time slice; used only if the queue's IO_bound flag has been
-	 * cleared.
-	 */
-	unsigned int requests_within_timer;
-
-	/* pid of the process owning the queue, used for logging purposes */
-	pid_t pid;
-
-	/*
-	 * Pointer to the bfq_io_cq owning the bfq_queue, set to %NULL
-	 * if the queue is shared.
-	 */
-	struct bfq_io_cq *bic;
-
-	/* current maximum weight-raising time for this queue */
-	unsigned long wr_cur_max_time;
-	/*
-	 * Minimum time instant such that, only if a new request is
-	 * enqueued after this time instant in an idle @bfq_queue with
-	 * no outstanding requests, then the task associated with the
-	 * queue it is deemed as soft real-time (see the comments on
-	 * the function bfq_bfqq_softrt_next_start())
-	 */
-	unsigned long soft_rt_next_start;
-	/*
-	 * Start time of the current weight-raising period if
-	 * the @bfq-queue is being weight-raised, otherwise
-	 * finish time of the last weight-raising period.
-	 */
-	unsigned long last_wr_start_finish;
-	/* factor by which the weight of this queue is multiplied */
-	unsigned int wr_coeff;
-	/*
-	 * Time of the last transition of the @bfq_queue from idle to
-	 * backlogged.
-	 */
-	unsigned long last_idle_bklogged;
-	/*
-	 * Cumulative service received from the @bfq_queue since the
-	 * last transition from idle to backlogged.
-	 */
-	unsigned long service_from_backlogged;
-
-	/*
-	 * Value of wr start time when switching to soft rt
-	 */
-	unsigned long wr_start_at_switch_to_srt;
-
-	unsigned long split_time; /* time of last split */
-};
-
-/**
- * struct bfq_io_cq - per (request_queue, io_context) structure.
- */
-struct bfq_io_cq {
-	/* associated io_cq structure */
-	struct io_cq icq; /* must be the first member */
-	/* array of two process queues, the sync and the async */
-	struct bfq_queue *bfqq[2];
-	/* per (request_queue, blkcg) ioprio */
-	int ioprio;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	uint64_t blkcg_serial_nr; /* the current blkcg serial */
-#endif
-	/*
-	 * Snapshot of the idle window before merging; taken to
-	 * remember this value while the queue is merged, so as to be
-	 * able to restore it in case of split.
-	 */
-	bool saved_idle_window;
-	/*
-	 * Same purpose as the previous two fields for the I/O bound
-	 * classification of a queue.
-	 */
-	bool saved_IO_bound;
-
-	/*
-	 * Same purpose as the previous fields for the value of the
-	 * field keeping the queue's belonging to a large burst
-	 */
-	bool saved_in_large_burst;
-	/*
-	 * True if the queue belonged to a burst list before its merge
-	 * with another cooperating queue.
-	 */
-	bool was_in_burst_list;
-
-	/*
-	 * Similar to previous fields: save wr information.
-	 */
-	unsigned long saved_wr_coeff;
-	unsigned long saved_last_wr_start_finish;
-	unsigned long saved_wr_start_at_switch_to_srt;
-	unsigned int saved_wr_cur_max_time;
-	struct bfq_ttime saved_ttime;
-};
-
-enum bfq_device_speed {
-	BFQ_BFQD_FAST,
-	BFQ_BFQD_SLOW,
-};
-
-/**
- * struct bfq_data - per-device data structure.
- *
- * All the fields are protected by @lock.
- */
-struct bfq_data {
-	/* device request queue */
-	struct request_queue *queue;
-	/* dispatch queue */
-	struct list_head dispatch;
-
-	/* root bfq_group for the device */
-	struct bfq_group *root_group;
-
-	/*
-	 * rbtree of weight counters of @bfq_queues, sorted by
-	 * weight. Used to keep track of whether all @bfq_queues have
-	 * the same weight. The tree contains one counter for each
-	 * distinct weight associated to some active and not
-	 * weight-raised @bfq_queue (see the comments to the functions
-	 * bfq_weights_tree_[add|remove] for further details).
-	 */
-	struct rb_root queue_weights_tree;
-	/*
-	 * rbtree of non-queue @bfq_entity weight counters, sorted by
-	 * weight. Used to keep track of whether all @bfq_groups have
-	 * the same weight. The tree contains one counter for each
-	 * distinct weight associated to some active @bfq_group (see
-	 * the comments to the functions bfq_weights_tree_[add|remove]
-	 * for further details).
-	 */
-	struct rb_root group_weights_tree;
-
-	/*
-	 * Number of bfq_queues containing requests (including the
-	 * queue in service, even if it is idling).
-	 */
-	int busy_queues;
-	/* number of weight-raised busy @bfq_queues */
-	int wr_busy_queues;
-	/* number of queued requests */
-	int queued;
-	/* number of requests dispatched and waiting for completion */
-	int rq_in_driver;
-
-	/*
-	 * Maximum number of requests in driver in the last
-	 * @hw_tag_samples completed requests.
-	 */
-	int max_rq_in_driver;
-	/* number of samples used to calculate hw_tag */
-	int hw_tag_samples;
-	/* flag set to one if the driver is showing a queueing behavior */
-	int hw_tag;
-
-	/* number of budgets assigned */
-	int budgets_assigned;
-
-	/*
-	 * Timer set when idling (waiting) for the next request from
-	 * the queue in service.
-	 */
-	struct hrtimer idle_slice_timer;
-
-	/* bfq_queue in service */
-	struct bfq_queue *in_service_queue;
-
-	/* on-disk position of the last served request */
-	sector_t last_position;
-
-	/* time of last request completion (ns) */
-	u64 last_completion;
-
-	/* time of first rq dispatch in current observation interval (ns) */
-	u64 first_dispatch;
-	/* time of last rq dispatch in current observation interval (ns) */
-	u64 last_dispatch;
-
-	/* beginning of the last budget */
-	ktime_t last_budget_start;
-	/* beginning of the last idle slice */
-	ktime_t last_idling_start;
-
-	/* number of samples in current observation interval */
-	int peak_rate_samples;
-	/* num of samples of seq dispatches in current observation interval */
-	u32 sequential_samples;
-	/* total num of sectors transferred in current observation interval */
-	u64 tot_sectors_dispatched;
-	/* max rq size seen during current observation interval (sectors) */
-	u32 last_rq_max_size;
-	/* time elapsed from first dispatch in current observ. interval (us) */
-	u64 delta_from_first;
-	/*
-	 * Current estimate of the device peak rate, measured in
-	 * [BFQ_RATE_SHIFT * sectors/usec]. The left-shift by
-	 * BFQ_RATE_SHIFT is performed to increase precision in
-	 * fixed-point calculations.
-	 */
-	u32 peak_rate;
-
-	/* maximum budget allotted to a bfq_queue before rescheduling */
-	int bfq_max_budget;
-
-	/* list of all the bfq_queues active on the device */
-	struct list_head active_list;
-	/* list of all the bfq_queues idle on the device */
-	struct list_head idle_list;
-
-	/*
-	 * Timeout for async/sync requests; when it fires, requests
-	 * are served in fifo order.
-	 */
-	u64 bfq_fifo_expire[2];
-	/* weight of backward seeks wrt forward ones */
-	unsigned int bfq_back_penalty;
-	/* maximum allowed backward seek */
-	unsigned int bfq_back_max;
-	/* maximum idling time */
-	u32 bfq_slice_idle;
-
-	/* user-configured max budget value (0 for auto-tuning) */
-	int bfq_user_max_budget;
-	/*
-	 * Timeout for bfq_queues to consume their budget; used to
-	 * prevent seeky queues from imposing long latencies to
-	 * sequential or quasi-sequential ones (this also implies that
-	 * seeky queues cannot receive guarantees in the service
-	 * domain; after a timeout they are charged for the time they
-	 * have been in service, to preserve fairness among them, but
-	 * without service-domain guarantees).
-	 */
-	unsigned int bfq_timeout;
-
-	/*
-	 * Number of consecutive requests that must be issued within
-	 * the idle time slice to set again idling to a queue which
-	 * was marked as non-I/O-bound (see the definition of the
-	 * IO_bound flag for further details).
-	 */
-	unsigned int bfq_requests_within_timer;
-
-	/*
-	 * Force device idling whenever needed to provide accurate
-	 * service guarantees, without caring about throughput
-	 * issues. CAVEAT: this may even increase latencies, in case
-	 * of useless idling for processes that did stop doing I/O.
-	 */
-	bool strict_guarantees;
-
-	/*
-	 * Last time at which a queue entered the current burst of
-	 * queues being activated shortly after each other; for more
-	 * details about this and the following parameters related to
-	 * a burst of activations, see the comments on the function
-	 * bfq_handle_burst.
-	 */
-	unsigned long last_ins_in_burst;
-	/*
-	 * Reference time interval used to decide whether a queue has
-	 * been activated shortly after @last_ins_in_burst.
-	 */
-	unsigned long bfq_burst_interval;
-	/* number of queues in the current burst of queue activations */
-	int burst_size;
-
-	/* common parent entity for the queues in the burst */
-	struct bfq_entity *burst_parent_entity;
-	/* Maximum burst size above which the current queue-activation
-	 * burst is deemed as 'large'.
-	 */
-	unsigned long bfq_large_burst_thresh;
-	/* true if a large queue-activation burst is in progress */
-	bool large_burst;
-	/*
-	 * Head of the burst list (as for the above fields, more
-	 * details in the comments on the function bfq_handle_burst).
-	 */
-	struct hlist_head burst_list;
-
-	/* if set to true, low-latency heuristics are enabled */
-	bool low_latency;
-	/*
-	 * Maximum factor by which the weight of a weight-raised queue
-	 * is multiplied.
-	 */
-	unsigned int bfq_wr_coeff;
-	/* maximum duration of a weight-raising period (jiffies) */
-	unsigned int bfq_wr_max_time;
-
-	/* Maximum weight-raising duration for soft real-time processes */
-	unsigned int bfq_wr_rt_max_time;
-	/*
-	 * Minimum idle period after which weight-raising may be
-	 * reactivated for a queue (in jiffies).
-	 */
-	unsigned int bfq_wr_min_idle_time;
-	/*
-	 * Minimum period between request arrivals after which
-	 * weight-raising may be reactivated for an already busy async
-	 * queue (in jiffies).
-	 */
-	unsigned long bfq_wr_min_inter_arr_async;
-
-	/* Max service-rate for a soft real-time queue, in sectors/sec */
-	unsigned int bfq_wr_max_softrt_rate;
-	/*
-	 * Cached value of the product R*T, used for computing the
-	 * maximum duration of weight raising automatically.
-	 */
-	u64 RT_prod;
-	/* device-speed class for the low-latency heuristic */
-	enum bfq_device_speed device_speed;
-
-	/* fallback dummy bfqq for extreme OOM conditions */
-	struct bfq_queue oom_bfqq;
-
-	spinlock_t lock;
-
-	/*
-	 * bic associated with the task issuing current bio for
-	 * merging. This and the next field are used as a support to
-	 * be able to perform the bic lookup, needed by bio-merge
-	 * functions, before the scheduler lock is taken, and thus
-	 * avoid taking the request-queue lock while the scheduler
-	 * lock is being held.
-	 */
-	struct bfq_io_cq *bio_bic;
-	/* bfqq associated with the task issuing current bio for merging */
-	struct bfq_queue *bio_bfqq;
-};
-
-enum bfqq_state_flags {
-	BFQQF_just_created = 0,	/* queue just allocated */
-	BFQQF_busy,		/* has requests or is in service */
-	BFQQF_wait_request,	/* waiting for a request */
-	BFQQF_non_blocking_wait_rq, /*
-				     * waiting for a request
-				     * without idling the device
-				     */
-	BFQQF_fifo_expire,	/* FIFO checked in this slice */
-	BFQQF_idle_window,	/* slice idling enabled */
-	BFQQF_sync,		/* synchronous queue */
-	BFQQF_IO_bound,		/*
-				 * bfqq has timed-out at least once
-				 * having consumed at most 2/10 of
-				 * its budget
-				 */
-	BFQQF_in_large_burst,	/*
-				 * bfqq activated in a large burst,
-				 * see comments to bfq_handle_burst.
-				 */
-	BFQQF_softrt_update,	/*
-				 * may need softrt-next-start
-				 * update
-				 */
-	BFQQF_coop,		/* bfqq is shared */
-	BFQQF_split_coop	/* shared bfqq will be split */
-};
-
-#define BFQ_BFQQ_FNS(name)						\
-static void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)		\
-{									\
-	__set_bit(BFQQF_##name, &(bfqq)->flags);			\
-}									\
-static void bfq_clear_bfqq_##name(struct bfq_queue *bfqq)		\
-{									\
-	__clear_bit(BFQQF_##name, &(bfqq)->flags);		\
-}									\
-static int bfq_bfqq_##name(const struct bfq_queue *bfqq)		\
-{									\
-	return test_bit(BFQQF_##name, &(bfqq)->flags);		\
-}
-
-BFQ_BFQQ_FNS(just_created);
-BFQ_BFQQ_FNS(busy);
-BFQ_BFQQ_FNS(wait_request);
-BFQ_BFQQ_FNS(non_blocking_wait_rq);
-BFQ_BFQQ_FNS(fifo_expire);
-BFQ_BFQQ_FNS(idle_window);
-BFQ_BFQQ_FNS(sync);
-BFQ_BFQQ_FNS(IO_bound);
-BFQ_BFQQ_FNS(in_large_burst);
-BFQ_BFQQ_FNS(coop);
-BFQ_BFQQ_FNS(split_coop);
-BFQ_BFQQ_FNS(softrt_update);
-#undef BFQ_BFQQ_FNS
-
-/* Logging facilities. */
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-static struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
-static struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
-
-#define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
-	char __pbuf[128];						\
-									\
-	blkg_path(bfqg_to_blkg(bfqq_group(bfqq)), __pbuf, sizeof(__pbuf)); \
-	blk_add_trace_msg((bfqd)->queue, "bfq%d%c %s " fmt, (bfqq)->pid, \
-			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
-			  __pbuf, ##args);				\
-} while (0)
-
-#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)	do {			\
-	char __pbuf[128];						\
-									\
-	blkg_path(bfqg_to_blkg(bfqg), __pbuf, sizeof(__pbuf));		\
-	blk_add_trace_msg((bfqd)->queue, "%s " fmt, __pbuf, ##args);	\
-} while (0)
-
-#else /* CONFIG_BFQ_GROUP_IOSCHED */
-
-#define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	\
-	blk_add_trace_msg((bfqd)->queue, "bfq%d%c " fmt, (bfqq)->pid,	\
-			bfq_bfqq_sync((bfqq)) ? 'S' : 'A',		\
-				##args)
-#define bfq_log_bfqg(bfqd, bfqg, fmt, args...)		do {} while (0)
-
-#endif /* CONFIG_BFQ_GROUP_IOSCHED */
-
-#define bfq_log(bfqd, fmt, args...) \
-	blk_add_trace_msg((bfqd)->queue, "bfq " fmt, ##args)
-
-/* Expiration reasons. */
-enum bfqq_expiration {
-	BFQQE_TOO_IDLE = 0,		/*
-					 * queue has been idling for
-					 * too long
-					 */
-	BFQQE_BUDGET_TIMEOUT,	/* budget took too long to be used */
-	BFQQE_BUDGET_EXHAUSTED,	/* budget consumed */
-	BFQQE_NO_MORE_REQUESTS,	/* the queue has no more requests */
-	BFQQE_PREEMPTED		/* preemption in progress */
-};
-
-struct bfqg_stats {
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
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
-#endif	/* CONFIG_BFQ_GROUP_IOSCHED */
-};
-
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-
-/*
- * struct bfq_group_data - per-blkcg storage for the blkio subsystem.
- *
- * @ps: @blkcg_policy_storage that this structure inherits
- * @weight: weight of the bfq_group
- */
-struct bfq_group_data {
-	/* must be the first member */
-	struct blkcg_policy_data pd;
-
-	unsigned int weight;
-};
-
-/**
- * struct bfq_group - per (device, cgroup) data structure.
- * @entity: schedulable entity to insert into the parent group sched_data.
- * @sched_data: own sched_data, to contain child entities (they may be
- *              both bfq_queues and bfq_groups).
- * @bfqd: the bfq_data for the device this group acts upon.
- * @async_bfqq: array of async queues for all the tasks belonging to
- *              the group, one queue per ioprio value per ioprio_class,
- *              except for the idle class that has only one queue.
- * @async_idle_bfqq: async queue for the idle class (ioprio is ignored).
- * @my_entity: pointer to @entity, %NULL for the toplevel group; used
- *             to avoid too many special cases during group creation/
- *             migration.
- * @stats: stats for this bfqg.
- * @active_entities: number of active entities belonging to the group;
- *                   unused for the root group. Used to know whether there
- *                   are groups with more than one active @bfq_entity
- *                   (see the comments to the function
- *                   bfq_bfqq_may_idle()).
- * @rq_pos_tree: rbtree sorted by next_request position, used when
- *               determining if two or more queues have interleaving
- *               requests (see bfq_find_close_cooperator()).
- *
- * Each (device, cgroup) pair has its own bfq_group, i.e., for each cgroup
- * there is a set of bfq_groups, each one collecting the lower-level
- * entities belonging to the group that are acting on the same device.
- *
- * Locking works as follows:
- *    o @bfqd is protected by the queue lock, RCU is used to access it
- *      from the readers.
- *    o All the other fields are protected by the @bfqd queue lock.
- */
-struct bfq_group {
-	/* must be the first member */
-	struct blkg_policy_data pd;
-
-	struct bfq_entity entity;
-	struct bfq_sched_data sched_data;
-
-	void *bfqd;
-
-	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
-	struct bfq_queue *async_idle_bfqq;
-
-	struct bfq_entity *my_entity;
-
-	int active_entities;
-
-	struct rb_root rq_pos_tree;
-
-	struct bfqg_stats stats;
-};
-
-#else
-struct bfq_group {
-	struct bfq_sched_data sched_data;
-
-	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
-	struct bfq_queue *async_idle_bfqq;
-
-	struct rb_root rq_pos_tree;
-};
-#endif
-
-static struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
-
-static unsigned int bfq_class_idx(struct bfq_entity *entity)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-
-	return bfqq ? bfqq->ioprio_class - 1 :
-		BFQ_DEFAULT_GRP_CLASS - 1;
-}
-
-static struct bfq_service_tree *
-bfq_entity_service_tree(struct bfq_entity *entity)
-{
-	struct bfq_sched_data *sched_data = entity->sched_data;
-	unsigned int idx = bfq_class_idx(entity);
-
-	return sched_data->service_tree + idx;
-}
-
-static struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
-{
-	return bic->bfqq[is_sync];
-}
-
-static void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq,
-			 bool is_sync)
-{
-	bic->bfqq[is_sync] = bfqq;
-}
-
-static struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic)
-{
-	return bic->icq.q->elevator->elevator_data;
-}
-
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-
-static struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
-{
-	struct bfq_entity *group_entity = bfqq->entity.parent;
-
-	if (!group_entity)
-		group_entity = &bfqq->bfqd->root_group->entity;
-
-	return container_of(group_entity, struct bfq_group, entity);
-}
-
-#else
-
-static struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
-{
-	return bfqq->bfqd->root_group;
-}
-
-#endif
-
-static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio);
-static void bfq_put_queue(struct bfq_queue *bfqq);
-static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
-				       struct bio *bio, bool is_sync,
-				       struct bfq_io_cq *bic);
-static void bfq_end_wr_async_queues(struct bfq_data *bfqd,
-				    struct bfq_group *bfqg);
-static void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
-static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
-
-/* Expiration time of sync (0) and async (1) requests, in ns. */
-static const u64 bfq_fifo_expire[2] = { NSEC_PER_SEC / 4, NSEC_PER_SEC / 8 };
-
-/* Maximum backwards seek (magic number lifted from CFQ), in KiB. */
-static const int bfq_back_max = 16 * 1024;
-
-/* Penalty of a backwards seek, in number of sectors. */
-static const int bfq_back_penalty = 2;
-
-/* Idling period duration, in ns. */
-static u64 bfq_slice_idle = NSEC_PER_SEC / 125;
-
-/* Minimum number of assigned budgets for which stats are safe to compute. */
-static const int bfq_stats_min_budgets = 194;
-
-/* Default maximum budget values, in sectors and number of requests. */
-static const int bfq_default_max_budget = 16 * 1024;
-
-/*
- * Async to sync throughput distribution is controlled as follows:
- * when an async request is served, the entity is charged the number
- * of sectors of the request, multiplied by the factor below
- */
-static const int bfq_async_charge_factor = 10;
-
-/* Default timeout values, in jiffies, approximating CFQ defaults. */
-static const int bfq_timeout = HZ / 8;
-
-static struct kmem_cache *bfq_pool;
-
-/* Below this threshold (in ns), we consider thinktime immediate. */
-#define BFQ_MIN_TT		(2 * NSEC_PER_MSEC)
-
-/* hw_tag detection: parallel requests threshold and min samples needed. */
-#define BFQ_HW_QUEUE_THRESHOLD	4
-#define BFQ_HW_QUEUE_SAMPLES	32
-
-#define BFQQ_SEEK_THR		(sector_t)(8 * 100)
-#define BFQQ_SECT_THR_NONROT	(sector_t)(2 * 32)
-#define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
-#define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 32/8)
-
-/* Min number of samples required to perform peak-rate update */
-#define BFQ_RATE_MIN_SAMPLES	32
-/* Min observation time interval required to perform a peak-rate update (ns) */
-#define BFQ_RATE_MIN_INTERVAL	(300*NSEC_PER_MSEC)
-/* Target observation time interval for a peak-rate update (ns) */
-#define BFQ_RATE_REF_INTERVAL	NSEC_PER_SEC
-
-/* Shift used for peak rate fixed precision calculations. */
-#define BFQ_RATE_SHIFT		16
-
-/*
- * By default, BFQ computes the duration of the weight raising for
- * interactive applications automatically, using the following formula:
- * duration = (R / r) * T, where r is the peak rate of the device, and
- * R and T are two reference parameters.
- * In particular, R is the peak rate of the reference device (see below),
- * and T is a reference time: given the systems that are likely to be
- * installed on the reference device according to its speed class, T is
- * about the maximum time needed, under BFQ and while reading two files in
- * parallel, to load typical large applications on these systems.
- * In practice, the slower/faster the device at hand is, the more/less it
- * takes to load applications with respect to the reference device.
- * Accordingly, the longer/shorter BFQ grants weight raising to interactive
- * applications.
- *
- * BFQ uses four different reference pairs (R, T), depending on:
- * . whether the device is rotational or non-rotational;
- * . whether the device is slow, such as old or portable HDDs, as well as
- *   SD cards, or fast, such as newer HDDs and SSDs.
- *
- * The device's speed class is dynamically (re)detected in
- * bfq_update_peak_rate() every time the estimated peak rate is updated.
- *
- * In the following definitions, R_slow[0]/R_fast[0] and
- * T_slow[0]/T_fast[0] are the reference values for a slow/fast
- * rotational device, whereas R_slow[1]/R_fast[1] and
- * T_slow[1]/T_fast[1] are the reference values for a slow/fast
- * non-rotational device. Finally, device_speed_thresh are the
- * thresholds used to switch between speed classes. The reference
- * rates are not the actual peak rates of the devices used as a
- * reference, but slightly lower values. The reason for using these
- * slightly lower values is that the peak-rate estimator tends to
- * yield slightly lower values than the actual peak rate (it can yield
- * the actual peak rate only if there is only one process doing I/O,
- * and the process does sequential I/O).
- *
- * Both the reference peak rates and the thresholds are measured in
- * sectors/usec, left-shifted by BFQ_RATE_SHIFT.
- */
-static int R_slow[2] = {1000, 10700};
-static int R_fast[2] = {14000, 33000};
-/*
- * To improve readability, a conversion function is used to initialize the
- * following arrays, which entails that they can be initialized only in a
- * function.
- */
-static int T_slow[2];
-static int T_fast[2];
-static int device_speed_thresh[2];
-
-#define BFQ_SERVICE_TREE_INIT	((struct bfq_service_tree)		\
-				{ RB_ROOT, RB_ROOT, NULL, NULL, 0, 0 })
-
-#define RQ_BIC(rq)		((struct bfq_io_cq *) (rq)->elv.priv[0])
-#define RQ_BFQQ(rq)		((rq)->elv.priv[1])
-
-/**
- * icq_to_bic - convert iocontext queue structure to bfq_io_cq.
- * @icq: the iocontext queue.
- */
-static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
-{
-	/* bic->icq is the first member, %NULL will convert to %NULL */
-	return container_of(icq, struct bfq_io_cq, icq);
-}
-
-/**
- * bfq_bic_lookup - search into @ioc a bic associated to @bfqd.
- * @bfqd: the lookup key.
- * @ioc: the io_context of the process doing I/O.
- * @q: the request queue.
- */
-static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
-					struct io_context *ioc,
-					struct request_queue *q)
-{
-	if (ioc) {
-		unsigned long flags;
-		struct bfq_io_cq *icq;
-
-		spin_lock_irqsave(q->queue_lock, flags);
-		icq = icq_to_bic(ioc_lookup_icq(ioc, q));
-		spin_unlock_irqrestore(q->queue_lock, flags);
-
-		return icq;
-	}
-
-	return NULL;
-}
-
-/*
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
-static struct bfq_entity *bfq_root_active_entity(struct rb_root *tree)
-{
-	struct rb_node *node = tree->rb_node;
-
-	return rb_entry(node, struct bfq_entity, rb_node);
-}
-
-static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd);
-
-static bool bfq_update_parent_budget(struct bfq_entity *next_in_service);
-
-/**
- * bfq_update_next_in_service - update sd->next_in_service
- * @sd: sched_data for which to perform the update.
- * @new_entity: if not NULL, pointer to the entity whose activation,
- *		requeueing or repositionig triggered the invocation of
- *		this function.
- *
- * This function is called to update sd->next_in_service, which, in
- * its turn, may change as a consequence of the insertion or
- * extraction of an entity into/from one of the active trees of
- * sd. These insertions/extractions occur as a consequence of
- * activations/deactivations of entities, with some activations being
- * 'true' activations, and other activations being requeueings (i.e.,
- * implementing the second, requeueing phase of the mechanism used to
- * reposition an entity in its active tree; see comments on
- * __bfq_activate_entity and __bfq_requeue_entity for details). In
- * both the last two activation sub-cases, new_entity points to the
- * just activated or requeued entity.
- *
- * Returns true if sd->next_in_service changes in such a way that
- * entity->parent may become the next_in_service for its parent
- * entity.
- */
-static bool bfq_update_next_in_service(struct bfq_sched_data *sd,
-				       struct bfq_entity *new_entity)
-{
-	struct bfq_entity *next_in_service = sd->next_in_service;
-	bool parent_sched_may_change = false;
-
-	/*
-	 * If this update is triggered by the activation, requeueing
-	 * or repositiong of an entity that does not coincide with
-	 * sd->next_in_service, then a full lookup in the active tree
-	 * can be avoided. In fact, it is enough to check whether the
-	 * just-modified entity has a higher priority than
-	 * sd->next_in_service, or, even if it has the same priority
-	 * as sd->next_in_service, is eligible and has a lower virtual
-	 * finish time than sd->next_in_service. If this compound
-	 * condition holds, then the new entity becomes the new
-	 * next_in_service. Otherwise no change is needed.
-	 */
-	if (new_entity && new_entity != sd->next_in_service) {
-		/*
-		 * Flag used to decide whether to replace
-		 * sd->next_in_service with new_entity. Tentatively
-		 * set to true, and left as true if
-		 * sd->next_in_service is NULL.
-		 */
-		bool replace_next = true;
-
-		/*
-		 * If there is already a next_in_service candidate
-		 * entity, then compare class priorities or timestamps
-		 * to decide whether to replace sd->service_tree with
-		 * new_entity.
-		 */
-		if (next_in_service) {
-			unsigned int new_entity_class_idx =
-				bfq_class_idx(new_entity);
-			struct bfq_service_tree *st =
-				sd->service_tree + new_entity_class_idx;
-
-			/*
-			 * For efficiency, evaluate the most likely
-			 * sub-condition first.
-			 */
-			replace_next =
-				(new_entity_class_idx ==
-				 bfq_class_idx(next_in_service)
-				 &&
-				 !bfq_gt(new_entity->start, st->vtime)
-				 &&
-				 bfq_gt(next_in_service->finish,
-					new_entity->finish))
-				||
-				new_entity_class_idx <
-				bfq_class_idx(next_in_service);
-		}
-
-		if (replace_next)
-			next_in_service = new_entity;
-	} else /* invoked because of a deactivation: lookup needed */
-		next_in_service = bfq_lookup_next_entity(sd);
-
-	if (next_in_service) {
-		parent_sched_may_change = !sd->next_in_service ||
-			bfq_update_parent_budget(next_in_service);
-	}
-
-	sd->next_in_service = next_in_service;
-
-	if (!next_in_service)
-		return parent_sched_may_change;
-
-	return parent_sched_may_change;
-}
-
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-/* both next loops stop at one of the child entities of the root group */
-#define for_each_entity(entity)	\
-	for (; entity ; entity = entity->parent)
-
-/*
- * For each iteration, compute parent in advance, so as to be safe if
- * entity is deallocated during the iteration. Such a deallocation may
- * happen as a consequence of a bfq_put_queue that frees the bfq_queue
- * containing entity.
- */
-#define for_each_entity_safe(entity, parent) \
-	for (; entity && ({ parent = entity->parent; 1; }); entity = parent)
-
-/*
- * Returns true if this budget changes may let next_in_service->parent
- * become the next_in_service entity for its parent entity.
- */
-static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
-{
-	struct bfq_entity *bfqg_entity;
-	struct bfq_group *bfqg;
-	struct bfq_sched_data *group_sd;
-	bool ret = false;
-
-	group_sd = next_in_service->sched_data;
-
-	bfqg = container_of(group_sd, struct bfq_group, sched_data);
-	/*
-	 * bfq_group's my_entity field is not NULL only if the group
-	 * is not the root group. We must not touch the root entity
-	 * as it must never become an in-service entity.
-	 */
-	bfqg_entity = bfqg->my_entity;
-	if (bfqg_entity) {
-		if (bfqg_entity->budget > next_in_service->budget)
-			ret = true;
-		bfqg_entity->budget = next_in_service->budget;
-	}
-
-	return ret;
-}
-
-/*
- * This function tells whether entity stops being a candidate for next
- * service, according to the following logic.
- *
- * This function is invoked for an entity that is about to be set in
- * service. If such an entity is a queue, then the entity is no longer
- * a candidate for next service (i.e, a candidate entity to serve
- * after the in-service entity is expired). The function then returns
- * true.
- *
- * In contrast, the entity could stil be a candidate for next service
- * if it is not a queue, and has more than one child. In fact, even if
- * one of its children is about to be set in service, other children
- * may still be the next to serve. As a consequence, a non-queue
- * entity is not a candidate for next-service only if it has only one
- * child. And only if this condition holds, then the function returns
- * true for a non-queue entity.
- */
-static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
-{
-	struct bfq_group *bfqg;
-
-	if (bfq_entity_to_bfqq(entity))
-		return true;
-
-	bfqg = container_of(entity, struct bfq_group, entity);
-
-	if (bfqg->active_entities == 1)
-		return true;
-
-	return false;
-}
-
-#else /* CONFIG_BFQ_GROUP_IOSCHED */
-/*
- * Next two macros are fake loops when cgroups support is not
- * enabled. I fact, in such a case, there is only one level to go up
- * (to reach the root group).
- */
-#define for_each_entity(entity)	\
-	for (; entity ; entity = NULL)
-
-#define for_each_entity_safe(entity, parent) \
-	for (parent = NULL; entity ; entity = parent)
-
-static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
-{
-	return false;
-}
-
-static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
-{
-	return true;
-}
-
-#endif /* CONFIG_BFQ_GROUP_IOSCHED */
-
-/*
- * Shift for timestamp calculations.  This actually limits the maximum
- * service allowed in one timestamp delta (small shift values increase it),
- * the maximum total weight that can be used for the queues in the system
- * (big shift values increase it), and the period of virtual time
- * wraparounds.
- */
-#define WFQ_SERVICE_SHIFT	22
-
-static struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
-{
-	struct bfq_queue *bfqq = NULL;
-
-	if (!entity->my_sched_data)
-		bfqq = container_of(entity, struct bfq_queue, entity);
-
-	return bfqq;
-}
-
-
-/**
- * bfq_delta - map service into the virtual time domain.
- * @service: amount of service.
- * @weight: scale factor (weight of an entity or weight sum).
- */
-static u64 bfq_delta(unsigned long service, unsigned long weight)
-{
-	u64 d = (u64)service << WFQ_SERVICE_SHIFT;
-
-	do_div(d, weight);
-	return d;
-}
-
-/**
- * bfq_calc_finish - assign the finish time to an entity.
- * @entity: the entity to act upon.
- * @service: the service to be charged to the entity.
- */
-static void bfq_calc_finish(struct bfq_entity *entity, unsigned long service)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-
-	entity->finish = entity->start +
-		bfq_delta(service, entity->weight);
-
-	if (bfqq) {
-		bfq_log_bfqq(bfqq->bfqd, bfqq,
-			"calc_finish: serv %lu, w %d",
-			service, entity->weight);
-		bfq_log_bfqq(bfqq->bfqd, bfqq,
-			"calc_finish: start %llu, finish %llu, delta %llu",
-			entity->start, entity->finish,
-			bfq_delta(service, entity->weight));
-	}
-}
-
-/**
- * bfq_entity_of - get an entity from a node.
- * @node: the node field of the entity.
- *
- * Convert a node pointer to the relative entity.  This is used only
- * to simplify the logic of some functions and not as the generic
- * conversion mechanism because, e.g., in the tree walking functions,
- * the check for a %NULL value would be redundant.
- */
-static struct bfq_entity *bfq_entity_of(struct rb_node *node)
-{
-	struct bfq_entity *entity = NULL;
-
-	if (node)
-		entity = rb_entry(node, struct bfq_entity, rb_node);
-
-	return entity;
-}
-
-/**
- * bfq_extract - remove an entity from a tree.
- * @root: the tree root.
- * @entity: the entity to remove.
- */
-static void bfq_extract(struct rb_root *root, struct bfq_entity *entity)
-{
-	entity->tree = NULL;
-	rb_erase(&entity->rb_node, root);
-}
-
-/**
- * bfq_idle_extract - extract an entity from the idle tree.
- * @st: the service tree of the owning @entity.
- * @entity: the entity being removed.
- */
-static void bfq_idle_extract(struct bfq_service_tree *st,
-			     struct bfq_entity *entity)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-	struct rb_node *next;
-
-	if (entity == st->first_idle) {
-		next = rb_next(&entity->rb_node);
-		st->first_idle = bfq_entity_of(next);
-	}
-
-	if (entity == st->last_idle) {
-		next = rb_prev(&entity->rb_node);
-		st->last_idle = bfq_entity_of(next);
-	}
-
-	bfq_extract(&st->idle, entity);
-
-	if (bfqq)
-		list_del(&bfqq->bfqq_list);
-}
-
-/**
- * bfq_insert - generic tree insertion.
- * @root: tree root.
- * @entity: entity to insert.
- *
- * This is used for the idle and the active tree, since they are both
- * ordered by finish time.
- */
-static void bfq_insert(struct rb_root *root, struct bfq_entity *entity)
-{
-	struct bfq_entity *entry;
-	struct rb_node **node = &root->rb_node;
-	struct rb_node *parent = NULL;
-
-	while (*node) {
-		parent = *node;
-		entry = rb_entry(parent, struct bfq_entity, rb_node);
-
-		if (bfq_gt(entry->finish, entity->finish))
-			node = &parent->rb_left;
-		else
-			node = &parent->rb_right;
-	}
-
-	rb_link_node(&entity->rb_node, parent, node);
-	rb_insert_color(&entity->rb_node, root);
-
-	entity->tree = root;
-}
-
-/**
- * bfq_update_min - update the min_start field of a entity.
- * @entity: the entity to update.
- * @node: one of its children.
- *
- * This function is called when @entity may store an invalid value for
- * min_start due to updates to the active tree.  The function  assumes
- * that the subtree rooted at @node (which may be its left or its right
- * child) has a valid min_start value.
- */
-static void bfq_update_min(struct bfq_entity *entity, struct rb_node *node)
-{
-	struct bfq_entity *child;
-
-	if (node) {
-		child = rb_entry(node, struct bfq_entity, rb_node);
-		if (bfq_gt(entity->min_start, child->min_start))
-			entity->min_start = child->min_start;
-	}
-}
-
-/**
- * bfq_update_active_node - recalculate min_start.
- * @node: the node to update.
- *
- * @node may have changed position or one of its children may have moved,
- * this function updates its min_start value.  The left and right subtrees
- * are assumed to hold a correct min_start value.
- */
-static void bfq_update_active_node(struct rb_node *node)
-{
-	struct bfq_entity *entity = rb_entry(node, struct bfq_entity, rb_node);
-
-	entity->min_start = entity->start;
-	bfq_update_min(entity, node->rb_right);
-	bfq_update_min(entity, node->rb_left);
-}
-
-/**
- * bfq_update_active_tree - update min_start for the whole active tree.
- * @node: the starting node.
- *
- * @node must be the deepest modified node after an update.  This function
- * updates its min_start using the values held by its children, assuming
- * that they did not change, and then updates all the nodes that may have
- * changed in the path to the root.  The only nodes that may have changed
- * are the ones in the path or their siblings.
- */
-static void bfq_update_active_tree(struct rb_node *node)
-{
-	struct rb_node *parent;
-
-up:
-	bfq_update_active_node(node);
-
-	parent = rb_parent(node);
-	if (!parent)
-		return;
-
-	if (node == parent->rb_left && parent->rb_right)
-		bfq_update_active_node(parent->rb_right);
-	else if (parent->rb_left)
-		bfq_update_active_node(parent->rb_left);
-
-	node = parent;
-	goto up;
-}
-
-static void bfq_weights_tree_add(struct bfq_data *bfqd,
-				 struct bfq_entity *entity,
-				 struct rb_root *root);
-
-static void bfq_weights_tree_remove(struct bfq_data *bfqd,
-				    struct bfq_entity *entity,
-				    struct rb_root *root);
-
-
-/**
- * bfq_active_insert - insert an entity in the active tree of its
- *                     group/device.
- * @st: the service tree of the entity.
- * @entity: the entity being inserted.
- *
- * The active tree is ordered by finish time, but an extra key is kept
- * per each node, containing the minimum value for the start times of
- * its children (and the node itself), so it's possible to search for
- * the eligible node with the lowest finish time in logarithmic time.
- */
-static void bfq_active_insert(struct bfq_service_tree *st,
-			      struct bfq_entity *entity)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-	struct rb_node *node = &entity->rb_node;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	struct bfq_sched_data *sd = NULL;
-	struct bfq_group *bfqg = NULL;
-	struct bfq_data *bfqd = NULL;
-#endif
-
-	bfq_insert(&st->active, entity);
-
-	if (node->rb_left)
-		node = node->rb_left;
-	else if (node->rb_right)
-		node = node->rb_right;
-
-	bfq_update_active_tree(node);
-
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	sd = entity->sched_data;
-	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
-#endif
-	if (bfqq)
-		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	else /* bfq_group */
-		bfq_weights_tree_add(bfqd, entity, &bfqd->group_weights_tree);
-
-	if (bfqg != bfqd->root_group)
-		bfqg->active_entities++;
-#endif
-}
-
-/**
- * bfq_ioprio_to_weight - calc a weight from an ioprio.
- * @ioprio: the ioprio value to convert.
- */
-static unsigned short bfq_ioprio_to_weight(int ioprio)
-{
-	return (IOPRIO_BE_NR - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;
-}
-
-/**
- * bfq_weight_to_ioprio - calc an ioprio from a weight.
- * @weight: the weight value to convert.
- *
- * To preserve as much as possible the old only-ioprio user interface,
- * 0 is used as an escape ioprio value for weights (numerically) equal or
- * larger than IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF.
- */
-static unsigned short bfq_weight_to_ioprio(int weight)
-{
-	return max_t(int, 0,
-		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
-}
-
-static void bfq_get_entity(struct bfq_entity *entity)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-
-	if (bfqq) {
-		bfqq->ref++;
-		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
-			     bfqq, bfqq->ref);
-	}
-}
-
-/**
- * bfq_find_deepest - find the deepest node that an extraction can modify.
- * @node: the node being removed.
- *
- * Do the first step of an extraction in an rb tree, looking for the
- * node that will replace @node, and returning the deepest node that
- * the following modifications to the tree can touch.  If @node is the
- * last node in the tree return %NULL.
- */
-static struct rb_node *bfq_find_deepest(struct rb_node *node)
-{
-	struct rb_node *deepest;
-
-	if (!node->rb_right && !node->rb_left)
-		deepest = rb_parent(node);
-	else if (!node->rb_right)
-		deepest = node->rb_left;
-	else if (!node->rb_left)
-		deepest = node->rb_right;
-	else {
-		deepest = rb_next(node);
-		if (deepest->rb_right)
-			deepest = deepest->rb_right;
-		else if (rb_parent(deepest) != node)
-			deepest = rb_parent(deepest);
-	}
-
-	return deepest;
-}
-
-/**
- * bfq_active_extract - remove an entity from the active tree.
- * @st: the service_tree containing the tree.
- * @entity: the entity being removed.
- */
-static void bfq_active_extract(struct bfq_service_tree *st,
-			       struct bfq_entity *entity)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-	struct rb_node *node;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	struct bfq_sched_data *sd = NULL;
-	struct bfq_group *bfqg = NULL;
-	struct bfq_data *bfqd = NULL;
-#endif
-
-	node = bfq_find_deepest(&entity->rb_node);
-	bfq_extract(&st->active, entity);
-
-	if (node)
-		bfq_update_active_tree(node);
-
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	sd = entity->sched_data;
-	bfqg = container_of(sd, struct bfq_group, sched_data);
-	bfqd = (struct bfq_data *)bfqg->bfqd;
-#endif
-	if (bfqq)
-		list_del(&bfqq->bfqq_list);
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	else /* bfq_group */
-		bfq_weights_tree_remove(bfqd, entity,
-					&bfqd->group_weights_tree);
-
-	if (bfqg != bfqd->root_group)
-		bfqg->active_entities--;
-#endif
-}
-
-/**
- * bfq_idle_insert - insert an entity into the idle tree.
- * @st: the service tree containing the tree.
- * @entity: the entity to insert.
- */
-static void bfq_idle_insert(struct bfq_service_tree *st,
-			    struct bfq_entity *entity)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-	struct bfq_entity *first_idle = st->first_idle;
-	struct bfq_entity *last_idle = st->last_idle;
-
-	if (!first_idle || bfq_gt(first_idle->finish, entity->finish))
-		st->first_idle = entity;
-	if (!last_idle || bfq_gt(entity->finish, last_idle->finish))
-		st->last_idle = entity;
-
-	bfq_insert(&st->idle, entity);
-
-	if (bfqq)
-		list_add(&bfqq->bfqq_list, &bfqq->bfqd->idle_list);
-}
-
-/**
- * bfq_forget_entity - do not consider entity any longer for scheduling
- * @st: the service tree.
- * @entity: the entity being removed.
- * @is_in_service: true if entity is currently the in-service entity.
- *
- * Forget everything about @entity. In addition, if entity represents
- * a queue, and the latter is not in service, then release the service
- * reference to the queue (the one taken through bfq_get_entity). In
- * fact, in this case, there is really no more service reference to
- * the queue, as the latter is also outside any service tree. If,
- * instead, the queue is in service, then __bfq_bfqd_reset_in_service
- * will take care of putting the reference when the queue finally
- * stops being served.
- */
-static void bfq_forget_entity(struct bfq_service_tree *st,
-			      struct bfq_entity *entity,
-			      bool is_in_service)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-
-	entity->on_st = false;
-	st->wsum -= entity->weight;
-	if (bfqq && !is_in_service)
-		bfq_put_queue(bfqq);
-}
-
-/**
- * bfq_put_idle_entity - release the idle tree ref of an entity.
- * @st: service tree for the entity.
- * @entity: the entity being released.
- */
-static void bfq_put_idle_entity(struct bfq_service_tree *st,
-				struct bfq_entity *entity)
-{
-	bfq_idle_extract(st, entity);
-	bfq_forget_entity(st, entity,
-			  entity == entity->sched_data->in_service_entity);
-}
-
-/**
- * bfq_forget_idle - update the idle tree if necessary.
- * @st: the service tree to act upon.
- *
- * To preserve the global O(log N) complexity we only remove one entry here;
- * as the idle tree will not grow indefinitely this can be done safely.
- */
-static void bfq_forget_idle(struct bfq_service_tree *st)
-{
-	struct bfq_entity *first_idle = st->first_idle;
-	struct bfq_entity *last_idle = st->last_idle;
-
-	if (RB_EMPTY_ROOT(&st->active) && last_idle &&
-	    !bfq_gt(last_idle->finish, st->vtime)) {
-		/*
-		 * Forget the whole idle tree, increasing the vtime past
-		 * the last finish time of idle entities.
-		 */
-		st->vtime = last_idle->finish;
-	}
-
-	if (first_idle && !bfq_gt(first_idle->finish, st->vtime))
-		bfq_put_idle_entity(st, first_idle);
-}
-
-static struct bfq_service_tree *
-__bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
-				struct bfq_entity *entity)
-{
-	struct bfq_service_tree *new_st = old_st;
-
-	if (entity->prio_changed) {
-		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-		unsigned int prev_weight, new_weight;
-		struct bfq_data *bfqd = NULL;
-		struct rb_root *root;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-		struct bfq_sched_data *sd;
-		struct bfq_group *bfqg;
-#endif
-
-		if (bfqq)
-			bfqd = bfqq->bfqd;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-		else {
-			sd = entity->my_sched_data;
-			bfqg = container_of(sd, struct bfq_group, sched_data);
-			bfqd = (struct bfq_data *)bfqg->bfqd;
-		}
-#endif
-
-		old_st->wsum -= entity->weight;
-
-		if (entity->new_weight != entity->orig_weight) {
-			if (entity->new_weight < BFQ_MIN_WEIGHT ||
-			    entity->new_weight > BFQ_MAX_WEIGHT) {
-				pr_crit("update_weight_prio: new_weight %d\n",
-					entity->new_weight);
-				if (entity->new_weight < BFQ_MIN_WEIGHT)
-					entity->new_weight = BFQ_MIN_WEIGHT;
-				else
-					entity->new_weight = BFQ_MAX_WEIGHT;
-			}
-			entity->orig_weight = entity->new_weight;
-			if (bfqq)
-				bfqq->ioprio =
-				  bfq_weight_to_ioprio(entity->orig_weight);
-		}
-
-		if (bfqq)
-			bfqq->ioprio_class = bfqq->new_ioprio_class;
-		entity->prio_changed = 0;
-
-		/*
-		 * NOTE: here we may be changing the weight too early,
-		 * this will cause unfairness.  The correct approach
-		 * would have required additional complexity to defer
-		 * weight changes to the proper time instants (i.e.,
-		 * when entity->finish <= old_st->vtime).
-		 */
-		new_st = bfq_entity_service_tree(entity);
-
-		prev_weight = entity->weight;
-		new_weight = entity->orig_weight *
-			     (bfqq ? bfqq->wr_coeff : 1);
-		/*
-		 * If the weight of the entity changes, remove the entity
-		 * from its old weight counter (if there is a counter
-		 * associated with the entity), and add it to the counter
-		 * associated with its new weight.
-		 */
-		if (prev_weight != new_weight) {
-			root = bfqq ? &bfqd->queue_weights_tree :
-				      &bfqd->group_weights_tree;
-			bfq_weights_tree_remove(bfqd, entity, root);
-		}
-		entity->weight = new_weight;
-		/*
-		 * Add the entity to its weights tree only if it is
-		 * not associated with a weight-raised queue.
-		 */
-		if (prev_weight != new_weight &&
-		    (bfqq ? bfqq->wr_coeff == 1 : 1))
-			/* If we get here, root has been initialized. */
-			bfq_weights_tree_add(bfqd, entity, root);
-
-		new_st->wsum += entity->weight;
-
-		if (new_st != old_st)
-			entity->start = new_st->vtime;
-	}
-
-	return new_st;
-}
-
-static void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
-static struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
-
-/**
- * bfq_bfqq_served - update the scheduler status after selection for
- *                   service.
- * @bfqq: the queue being served.
- * @served: bytes to transfer.
- *
- * NOTE: this can be optimized, as the timestamps of upper level entities
- * are synchronized every time a new bfqq is selected for service.  By now,
- * we keep it to better check consistency.
- */
-static void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
-{
-	struct bfq_entity *entity = &bfqq->entity;
-	struct bfq_service_tree *st;
-
-	for_each_entity(entity) {
-		st = bfq_entity_service_tree(entity);
-
-		entity->service += served;
-
-		st->vtime += bfq_delta(served, st->wsum);
-		bfq_forget_idle(st);
-	}
-	bfqg_stats_set_start_empty_time(bfqq_group(bfqq));
-	bfq_log_bfqq(bfqq->bfqd, bfqq, "bfqq_served %d secs", served);
-}
-
-/**
- * bfq_bfqq_charge_time - charge an amount of service equivalent to the length
- *			  of the time interval during which bfqq has been in
- *			  service.
- * @bfqd: the device
- * @bfqq: the queue that needs a service update.
- * @time_ms: the amount of time during which the queue has received service
- *
- * If a queue does not consume its budget fast enough, then providing
- * the queue with service fairness may impair throughput, more or less
- * severely. For this reason, queues that consume their budget slowly
- * are provided with time fairness instead of service fairness. This
- * goal is achieved through the BFQ scheduling engine, even if such an
- * engine works in the service, and not in the time domain. The trick
- * is charging these queues with an inflated amount of service, equal
- * to the amount of service that they would have received during their
- * service slot if they had been fast, i.e., if their requests had
- * been dispatched at a rate equal to the estimated peak rate.
- *
- * It is worth noting that time fairness can cause important
- * distortions in terms of bandwidth distribution, on devices with
- * internal queueing. The reason is that I/O requests dispatched
- * during the service slot of a queue may be served after that service
- * slot is finished, and may have a total processing time loosely
- * correlated with the duration of the service slot. This is
- * especially true for short service slots.
- */
-static void bfq_bfqq_charge_time(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-				 unsigned long time_ms)
-{
-	struct bfq_entity *entity = &bfqq->entity;
-	int tot_serv_to_charge = entity->service;
-	unsigned int timeout_ms = jiffies_to_msecs(bfq_timeout);
-
-	if (time_ms > 0 && time_ms < timeout_ms)
-		tot_serv_to_charge =
-			(bfqd->bfq_max_budget * time_ms) / timeout_ms;
-
-	if (tot_serv_to_charge < entity->service)
-		tot_serv_to_charge = entity->service;
-
-	/* Increase budget to avoid inconsistencies */
-	if (tot_serv_to_charge > entity->budget)
-		entity->budget = tot_serv_to_charge;
-
-	bfq_bfqq_served(bfqq,
-			max_t(int, 0, tot_serv_to_charge - entity->service));
-}
-
-static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
-					struct bfq_service_tree *st,
-					bool backshifted)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-
-	st = __bfq_entity_update_weight_prio(st, entity);
-	bfq_calc_finish(entity, entity->budget);
-
-	/*
-	 * If some queues enjoy backshifting for a while, then their
-	 * (virtual) finish timestamps may happen to become lower and
-	 * lower than the system virtual time.	In particular, if
-	 * these queues often happen to be idle for short time
-	 * periods, and during such time periods other queues with
-	 * higher timestamps happen to be busy, then the backshifted
-	 * timestamps of the former queues can become much lower than
-	 * the system virtual time. In fact, to serve the queues with
-	 * higher timestamps while the ones with lower timestamps are
-	 * idle, the system virtual time may be pushed-up to much
-	 * higher values than the finish timestamps of the idle
-	 * queues. As a consequence, the finish timestamps of all new
-	 * or newly activated queues may end up being much larger than
-	 * those of lucky queues with backshifted timestamps. The
-	 * latter queues may then monopolize the device for a lot of
-	 * time. This would simply break service guarantees.
-	 *
-	 * To reduce this problem, push up a little bit the
-	 * backshifted timestamps of the queue associated with this
-	 * entity (only a queue can happen to have the backshifted
-	 * flag set): just enough to let the finish timestamp of the
-	 * queue be equal to the current value of the system virtual
-	 * time. This may introduce a little unfairness among queues
-	 * with backshifted timestamps, but it does not break
-	 * worst-case fairness guarantees.
-	 *
-	 * As a special case, if bfqq is weight-raised, push up
-	 * timestamps much less, to keep very low the probability that
-	 * this push up causes the backshifted finish timestamps of
-	 * weight-raised queues to become higher than the backshifted
-	 * finish timestamps of non weight-raised queues.
-	 */
-	if (backshifted && bfq_gt(st->vtime, entity->finish)) {
-		unsigned long delta = st->vtime - entity->finish;
-
-		if (bfqq)
-			delta /= bfqq->wr_coeff;
-
-		entity->start += delta;
-		entity->finish += delta;
-	}
-
-	bfq_active_insert(st, entity);
-}
-
-/**
- * __bfq_activate_entity - handle activation of entity.
- * @entity: the entity being activated.
- * @non_blocking_wait_rq: true if entity was waiting for a request
- *
- * Called for a 'true' activation, i.e., if entity is not active and
- * one of its children receives a new request.
- *
- * Basically, this function updates the timestamps of entity and
- * inserts entity into its active tree, ater possible extracting it
- * from its idle tree.
- */
-static void __bfq_activate_entity(struct bfq_entity *entity,
-				  bool non_blocking_wait_rq)
-{
-	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
-	bool backshifted = false;
-	unsigned long long min_vstart;
-
-	/* See comments on bfq_fqq_update_budg_for_activation */
-	if (non_blocking_wait_rq && bfq_gt(st->vtime, entity->finish)) {
-		backshifted = true;
-		min_vstart = entity->finish;
-	} else
-		min_vstart = st->vtime;
-
-	if (entity->tree == &st->idle) {
-		/*
-		 * Must be on the idle tree, bfq_idle_extract() will
-		 * check for that.
-		 */
-		bfq_idle_extract(st, entity);
-		entity->start = bfq_gt(min_vstart, entity->finish) ?
-			min_vstart : entity->finish;
-	} else {
-		/*
-		 * The finish time of the entity may be invalid, and
-		 * it is in the past for sure, otherwise the queue
-		 * would have been on the idle tree.
-		 */
-		entity->start = min_vstart;
-		st->wsum += entity->weight;
-		/*
-		 * entity is about to be inserted into a service tree,
-		 * and then set in service: get a reference to make
-		 * sure entity does not disappear until it is no
-		 * longer in service or scheduled for service.
-		 */
-		bfq_get_entity(entity);
-
-		entity->on_st = true;
-	}
-
-	bfq_update_fin_time_enqueue(entity, st, backshifted);
-}
-
-/**
- * __bfq_requeue_entity - handle requeueing or repositioning of an entity.
- * @entity: the entity being requeued or repositioned.
- *
- * Requeueing is needed if this entity stops being served, which
- * happens if a leaf descendant entity has expired. On the other hand,
- * repositioning is needed if the next_inservice_entity for the child
- * entity has changed. See the comments inside the function for
- * details.
- *
- * Basically, this function: 1) removes entity from its active tree if
- * present there, 2) updates the timestamps of entity and 3) inserts
- * entity back into its active tree (in the new, right position for
- * the new values of the timestamps).
- */
-static void __bfq_requeue_entity(struct bfq_entity *entity)
-{
-	struct bfq_sched_data *sd = entity->sched_data;
-	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
-
-	if (entity == sd->in_service_entity) {
-		/*
-		 * We are requeueing the current in-service entity,
-		 * which may have to be done for one of the following
-		 * reasons:
-		 * - entity represents the in-service queue, and the
-		 *   in-service queue is being requeued after an
-		 *   expiration;
-		 * - entity represents a group, and its budget has
-		 *   changed because one of its child entities has
-		 *   just been either activated or requeued for some
-		 *   reason; the timestamps of the entity need then to
-		 *   be updated, and the entity needs to be enqueued
-		 *   or repositioned accordingly.
-		 *
-		 * In particular, before requeueing, the start time of
-		 * the entity must be moved forward to account for the
-		 * service that the entity has received while in
-		 * service. This is done by the next instructions. The
-		 * finish time will then be updated according to this
-		 * new value of the start time, and to the budget of
-		 * the entity.
-		 */
-		bfq_calc_finish(entity, entity->service);
-		entity->start = entity->finish;
-		/*
-		 * In addition, if the entity had more than one child
-		 * when set in service, then was not extracted from
-		 * the active tree. This implies that the position of
-		 * the entity in the active tree may need to be
-		 * changed now, because we have just updated the start
-		 * time of the entity, and we will update its finish
-		 * time in a moment (the requeueing is then, more
-		 * precisely, a repositioning in this case). To
-		 * implement this repositioning, we: 1) dequeue the
-		 * entity here, 2) update the finish time and
-		 * requeue the entity according to the new
-		 * timestamps below.
-		 */
-		if (entity->tree)
-			bfq_active_extract(st, entity);
-	} else { /* The entity is already active, and not in service */
-		/*
-		 * In this case, this function gets called only if the
-		 * next_in_service entity below this entity has
-		 * changed, and this change has caused the budget of
-		 * this entity to change, which, finally implies that
-		 * the finish time of this entity must be
-		 * updated. Such an update may cause the scheduling,
-		 * i.e., the position in the active tree, of this
-		 * entity to change. We handle this change by: 1)
-		 * dequeueing the entity here, 2) updating the finish
-		 * time and requeueing the entity according to the new
-		 * timestamps below. This is the same approach as the
-		 * non-extracted-entity sub-case above.
-		 */
-		bfq_active_extract(st, entity);
-	}
-
-	bfq_update_fin_time_enqueue(entity, st, false);
-}
-
-static void __bfq_activate_requeue_entity(struct bfq_entity *entity,
-					  struct bfq_sched_data *sd,
-					  bool non_blocking_wait_rq)
-{
-	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
-
-	if (sd->in_service_entity == entity || entity->tree == &st->active)
-		 /*
-		  * in service or already queued on the active tree,
-		  * requeue or reposition
-		  */
-		__bfq_requeue_entity(entity);
-	else
-		/*
-		 * Not in service and not queued on its active tree:
-		 * the activity is idle and this is a true activation.
-		 */
-		__bfq_activate_entity(entity, non_blocking_wait_rq);
-}
-
-
-/**
- * bfq_activate_entity - activate or requeue an entity representing a bfq_queue,
- *			 and activate, requeue or reposition all ancestors
- *			 for which such an update becomes necessary.
- * @entity: the entity to activate.
- * @non_blocking_wait_rq: true if this entity was waiting for a request
- * @requeue: true if this is a requeue, which implies that bfqq is
- *	     being expired; thus ALL its ancestors stop being served and must
- *	     therefore be requeued
- */
-static void bfq_activate_requeue_entity(struct bfq_entity *entity,
-					bool non_blocking_wait_rq,
-					bool requeue)
-{
-	struct bfq_sched_data *sd;
-
-	for_each_entity(entity) {
-		sd = entity->sched_data;
-		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq);
-
-		if (!bfq_update_next_in_service(sd, entity) && !requeue)
-			break;
-	}
-}
-
-/**
- * __bfq_deactivate_entity - deactivate an entity from its service tree.
- * @entity: the entity to deactivate.
- * @ins_into_idle_tree: if false, the entity will not be put into the
- *			idle tree.
- *
- * Deactivates an entity, independently from its previous state.  Must
- * be invoked only if entity is on a service tree. Extracts the entity
- * from that tree, and if necessary and allowed, puts it on the idle
- * tree.
- */
-static bool __bfq_deactivate_entity(struct bfq_entity *entity,
-				    bool ins_into_idle_tree)
-{
-	struct bfq_sched_data *sd = entity->sched_data;
-	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
-	int is_in_service = entity == sd->in_service_entity;
-
-	if (!entity->on_st) /* entity never activated, or already inactive */
-		return false;
-
-	if (is_in_service)
-		bfq_calc_finish(entity, entity->service);
-
-	if (entity->tree == &st->active)
-		bfq_active_extract(st, entity);
-	else if (!is_in_service && entity->tree == &st->idle)
-		bfq_idle_extract(st, entity);
-
-	if (!ins_into_idle_tree || !bfq_gt(entity->finish, st->vtime))
-		bfq_forget_entity(st, entity, is_in_service);
-	else
-		bfq_idle_insert(st, entity);
-
-	return true;
-}
-
-/**
- * bfq_deactivate_entity - deactivate an entity representing a bfq_queue.
- * @entity: the entity to deactivate.
- * @ins_into_idle_tree: true if the entity can be put on the idle tree
- */
-static void bfq_deactivate_entity(struct bfq_entity *entity,
-				  bool ins_into_idle_tree,
-				  bool expiration)
-{
-	struct bfq_sched_data *sd;
-	struct bfq_entity *parent = NULL;
-
-	for_each_entity_safe(entity, parent) {
-		sd = entity->sched_data;
-
-		if (!__bfq_deactivate_entity(entity, ins_into_idle_tree)) {
-			/*
-			 * entity is not in any tree any more, so
-			 * this deactivation is a no-op, and there is
-			 * nothing to change for upper-level entities
-			 * (in case of expiration, this can never
-			 * happen).
-			 */
-			return;
-		}
-
-		if (sd->next_in_service == entity)
-			/*
-			 * entity was the next_in_service entity,
-			 * then, since entity has just been
-			 * deactivated, a new one must be found.
-			 */
-			bfq_update_next_in_service(sd, NULL);
-
-		if (sd->next_in_service)
-			/*
-			 * The parent entity is still backlogged,
-			 * because next_in_service is not NULL. So, no
-			 * further upwards deactivation must be
-			 * performed.  Yet, next_in_service has
-			 * changed.  Then the schedule does need to be
-			 * updated upwards.
-			 */
-			break;
-
-		/*
-		 * If we get here, then the parent is no more
-		 * backlogged and we need to propagate the
-		 * deactivation upwards. Thus let the loop go on.
-		 */
-
-		/*
-		 * Also let parent be queued into the idle tree on
-		 * deactivation, to preserve service guarantees, and
-		 * assuming that who invoked this function does not
-		 * need parent entities too to be removed completely.
-		 */
-		ins_into_idle_tree = true;
-	}
-
-	/*
-	 * If the deactivation loop is fully executed, then there are
-	 * no more entities to touch and next loop is not executed at
-	 * all. Otherwise, requeue remaining entities if they are
-	 * about to stop receiving service, or reposition them if this
-	 * is not the case.
-	 */
-	entity = parent;
-	for_each_entity(entity) {
-		/*
-		 * Invoke __bfq_requeue_entity on entity, even if
-		 * already active, to requeue/reposition it in the
-		 * active tree (because sd->next_in_service has
-		 * changed)
-		 */
-		__bfq_requeue_entity(entity);
-
-		sd = entity->sched_data;
-		if (!bfq_update_next_in_service(sd, entity) &&
-		    !expiration)
-			/*
-			 * next_in_service unchanged or not causing
-			 * any change in entity->parent->sd, and no
-			 * requeueing needed for expiration: stop
-			 * here.
-			 */
-			break;
-	}
-}
-
-/**
- * bfq_calc_vtime_jump - compute the value to which the vtime should jump,
- *                       if needed, to have at least one entity eligible.
- * @st: the service tree to act upon.
- *
- * Assumes that st is not empty.
- */
-static u64 bfq_calc_vtime_jump(struct bfq_service_tree *st)
-{
-	struct bfq_entity *root_entity = bfq_root_active_entity(&st->active);
-
-	if (bfq_gt(root_entity->min_start, st->vtime))
-		return root_entity->min_start;
-
-	return st->vtime;
-}
-
-static void bfq_update_vtime(struct bfq_service_tree *st, u64 new_value)
-{
-	if (new_value > st->vtime) {
-		st->vtime = new_value;
-		bfq_forget_idle(st);
-	}
-}
-
-/**
- * bfq_first_active_entity - find the eligible entity with
- *                           the smallest finish time
- * @st: the service tree to select from.
- * @vtime: the system virtual to use as a reference for eligibility
- *
- * This function searches the first schedulable entity, starting from the
- * root of the tree and going on the left every time on this side there is
- * a subtree with at least one eligible (start >= vtime) entity. The path on
- * the right is followed only if a) the left subtree contains no eligible
- * entities and b) no eligible entity has been found yet.
- */
-static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st,
-						  u64 vtime)
-{
-	struct bfq_entity *entry, *first = NULL;
-	struct rb_node *node = st->active.rb_node;
-
-	while (node) {
-		entry = rb_entry(node, struct bfq_entity, rb_node);
-left:
-		if (!bfq_gt(entry->start, vtime))
-			first = entry;
-
-		if (node->rb_left) {
-			entry = rb_entry(node->rb_left,
-					 struct bfq_entity, rb_node);
-			if (!bfq_gt(entry->min_start, vtime)) {
-				node = node->rb_left;
-				goto left;
-			}
-		}
-		if (first)
-			break;
-		node = node->rb_right;
-	}
-
-	return first;
-}
-
-/**
- * __bfq_lookup_next_entity - return the first eligible entity in @st.
- * @st: the service tree.
- *
- * If there is no in-service entity for the sched_data st belongs to,
- * then return the entity that will be set in service if:
- * 1) the parent entity this st belongs to is set in service;
- * 2) no entity belonging to such parent entity undergoes a state change
- * that would influence the timestamps of the entity (e.g., becomes idle,
- * becomes backlogged, changes its budget, ...).
- *
- * In this first case, update the virtual time in @st too (see the
- * comments on this update inside the function).
- *
- * In constrast, if there is an in-service entity, then return the
- * entity that would be set in service if not only the above
- * conditions, but also the next one held true: the currently
- * in-service entity, on expiration,
- * 1) gets a finish time equal to the current one, or
- * 2) is not eligible any more, or
- * 3) is idle.
- */
-static struct bfq_entity *
-__bfq_lookup_next_entity(struct bfq_service_tree *st, bool in_service)
-{
-	struct bfq_entity *entity;
-	u64 new_vtime;
-
-	if (RB_EMPTY_ROOT(&st->active))
-		return NULL;
-
-	/*
-	 * Get the value of the system virtual time for which at
-	 * least one entity is eligible.
-	 */
-	new_vtime = bfq_calc_vtime_jump(st);
-
-	/*
-	 * If there is no in-service entity for the sched_data this
-	 * active tree belongs to, then push the system virtual time
-	 * up to the value that guarantees that at least one entity is
-	 * eligible. If, instead, there is an in-service entity, then
-	 * do not make any such update, because there is already an
-	 * eligible entity, namely the in-service one (even if the
-	 * entity is not on st, because it was extracted when set in
-	 * service).
-	 */
-	if (!in_service)
-		bfq_update_vtime(st, new_vtime);
-
-	entity = bfq_first_active_entity(st, new_vtime);
-
-	return entity;
-}
-
-/**
- * bfq_lookup_next_entity - return the first eligible entity in @sd.
- * @sd: the sched_data.
- *
- * This function is invoked when there has been a change in the trees
- * for sd, and we need know what is the new next entity after this
- * change.
- */
-static struct bfq_entity *bfq_lookup_next_entity(struct bfq_sched_data *sd)
-{
-	struct bfq_service_tree *st = sd->service_tree;
-	struct bfq_service_tree *idle_class_st = st + (BFQ_IOPRIO_CLASSES - 1);
-	struct bfq_entity *entity = NULL;
-	int class_idx = 0;
-
-	/*
-	 * Choose from idle class, if needed to guarantee a minimum
-	 * bandwidth to this class (and if there is some active entity
-	 * in idle class). This should also mitigate
-	 * priority-inversion problems in case a low priority task is
-	 * holding file system resources.
-	 */
-	if (time_is_before_jiffies(sd->bfq_class_idle_last_service +
-				   BFQ_CL_IDLE_TIMEOUT)) {
-		if (!RB_EMPTY_ROOT(&idle_class_st->active))
-			class_idx = BFQ_IOPRIO_CLASSES - 1;
-		/* About to be served if backlogged, or not yet backlogged */
-		sd->bfq_class_idle_last_service = jiffies;
-	}
-
-	/*
-	 * Find the next entity to serve for the highest-priority
-	 * class, unless the idle class needs to be served.
-	 */
-	for (; class_idx < BFQ_IOPRIO_CLASSES; class_idx++) {
-		entity = __bfq_lookup_next_entity(st + class_idx,
-						  sd->in_service_entity);
-
-		if (entity)
-			break;
-	}
-
-	if (!entity)
-		return NULL;
-
-	return entity;
-}
-
-static bool next_queue_may_preempt(struct bfq_data *bfqd)
-{
-	struct bfq_sched_data *sd = &bfqd->root_group->sched_data;
-
-	return sd->next_in_service != sd->in_service_entity;
-}
-
-/*
- * Get next queue for service.
- */
-static struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
-{
-	struct bfq_entity *entity = NULL;
-	struct bfq_sched_data *sd;
-	struct bfq_queue *bfqq;
-
-	if (bfqd->busy_queues == 0)
-		return NULL;
-
-	/*
-	 * Traverse the path from the root to the leaf entity to
-	 * serve. Set in service all the entities visited along the
-	 * way.
-	 */
-	sd = &bfqd->root_group->sched_data;
-	for (; sd ; sd = entity->my_sched_data) {
-		/*
-		 * WARNING. We are about to set the in-service entity
-		 * to sd->next_in_service, i.e., to the (cached) value
-		 * returned by bfq_lookup_next_entity(sd) the last
-		 * time it was invoked, i.e., the last time when the
-		 * service order in sd changed as a consequence of the
-		 * activation or deactivation of an entity. In this
-		 * respect, if we execute bfq_lookup_next_entity(sd)
-		 * in this very moment, it may, although with low
-		 * probability, yield a different entity than that
-		 * pointed to by sd->next_in_service. This rare event
-		 * happens in case there was no CLASS_IDLE entity to
-		 * serve for sd when bfq_lookup_next_entity(sd) was
-		 * invoked for the last time, while there is now one
-		 * such entity.
-		 *
-		 * If the above event happens, then the scheduling of
-		 * such entity in CLASS_IDLE is postponed until the
-		 * service of the sd->next_in_service entity
-		 * finishes. In fact, when the latter is expired,
-		 * bfq_lookup_next_entity(sd) gets called again,
-		 * exactly to update sd->next_in_service.
-		 */
-
-		/* Make next_in_service entity become in_service_entity */
-		entity = sd->next_in_service;
-		sd->in_service_entity = entity;
-
-		/*
-		 * Reset the accumulator of the amount of service that
-		 * the entity is about to receive.
-		 */
-		entity->service = 0;
-
-		/*
-		 * If entity is no longer a candidate for next
-		 * service, then we extract it from its active tree,
-		 * for the following reason. To further boost the
-		 * throughput in some special case, BFQ needs to know
-		 * which is the next candidate entity to serve, while
-		 * there is already an entity in service. In this
-		 * respect, to make it easy to compute/update the next
-		 * candidate entity to serve after the current
-		 * candidate has been set in service, there is a case
-		 * where it is necessary to extract the current
-		 * candidate from its service tree. Such a case is
-		 * when the entity just set in service cannot be also
-		 * a candidate for next service. Details about when
-		 * this conditions holds are reported in the comments
-		 * on the function bfq_no_longer_next_in_service()
-		 * invoked below.
-		 */
-		if (bfq_no_longer_next_in_service(entity))
-			bfq_active_extract(bfq_entity_service_tree(entity),
-					   entity);
-
-		/*
-		 * For the same reason why we may have just extracted
-		 * entity from its active tree, we may need to update
-		 * next_in_service for the sched_data of entity too,
-		 * regardless of whether entity has been extracted.
-		 * In fact, even if entity has not been extracted, a
-		 * descendant entity may get extracted. Such an event
-		 * would cause a change in next_in_service for the
-		 * level of the descendant entity, and thus possibly
-		 * back to upper levels.
-		 *
-		 * We cannot perform the resulting needed update
-		 * before the end of this loop, because, to know which
-		 * is the correct next-to-serve candidate entity for
-		 * each level, we need first to find the leaf entity
-		 * to set in service. In fact, only after we know
-		 * which is the next-to-serve leaf entity, we can
-		 * discover whether the parent entity of the leaf
-		 * entity becomes the next-to-serve, and so on.
-		 */
-
-	}
-
-	bfqq = bfq_entity_to_bfqq(entity);
-
-	/*
-	 * We can finally update all next-to-serve entities along the
-	 * path from the leaf entity just set in service to the root.
-	 */
-	for_each_entity(entity) {
-		struct bfq_sched_data *sd = entity->sched_data;
-
-		if (!bfq_update_next_in_service(sd, NULL))
-			break;
-	}
-
-	return bfqq;
-}
-
-static void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
-{
-	struct bfq_queue *in_serv_bfqq = bfqd->in_service_queue;
-	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
-	struct bfq_entity *entity = in_serv_entity;
-
-	bfq_clear_bfqq_wait_request(in_serv_bfqq);
-	hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
-	bfqd->in_service_queue = NULL;
-
-	/*
-	 * When this function is called, all in-service entities have
-	 * been properly deactivated or requeued, so we can safely
-	 * execute the final step: reset in_service_entity along the
-	 * path from entity to the root.
-	 */
-	for_each_entity(entity)
-		entity->sched_data->in_service_entity = NULL;
-
-	/*
-	 * in_serv_entity is no longer in service, so, if it is in no
-	 * service tree either, then release the service reference to
-	 * the queue it represents (taken with bfq_get_entity).
-	 */
-	if (!in_serv_entity->on_st)
-		bfq_put_queue(in_serv_bfqq);
-}
-
-static void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-				bool ins_into_idle_tree, bool expiration)
-{
-	struct bfq_entity *entity = &bfqq->entity;
-
-	bfq_deactivate_entity(entity, ins_into_idle_tree, expiration);
-}
-
-static void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
-{
-	struct bfq_entity *entity = &bfqq->entity;
-
-	bfq_activate_requeue_entity(entity, bfq_bfqq_non_blocking_wait_rq(bfqq),
-				    false);
-	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
-}
-
-static void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
-{
-	struct bfq_entity *entity = &bfqq->entity;
-
-	bfq_activate_requeue_entity(entity, false,
-				    bfqq == bfqd->in_service_queue);
-}
-
-static void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
-
-/*
- * Called when the bfqq no longer has requests pending, remove it from
- * the service tree. As a special case, it can be invoked during an
- * expiration.
- */
-static void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			      bool expiration)
-{
-	bfq_log_bfqq(bfqd, bfqq, "del from busy");
-
-	bfq_clear_bfqq_busy(bfqq);
-
-	bfqd->busy_queues--;
-
-	if (!bfqq->dispatched)
-		bfq_weights_tree_remove(bfqd, &bfqq->entity,
-					&bfqd->queue_weights_tree);
-
-	if (bfqq->wr_coeff > 1)
-		bfqd->wr_busy_queues--;
-
-	bfqg_stats_update_dequeue(bfqq_group(bfqq));
-
-	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
-}
-
-/*
- * Called when an inactive queue receives a new request.
- */
-static void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
-{
-	bfq_log_bfqq(bfqd, bfqq, "add to busy");
-
-	bfq_activate_bfqq(bfqd, bfqq);
-
-	bfq_mark_bfqq_busy(bfqq);
-	bfqd->busy_queues++;
-
-	if (!bfqq->dispatched)
-		if (bfqq->wr_coeff == 1)
-			bfq_weights_tree_add(bfqd, &bfqq->entity,
-					     &bfqd->queue_weights_tree);
-
-	if (bfqq->wr_coeff > 1)
-		bfqd->wr_busy_queues++;
-}
-
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-
-/* bfqg stats flags */
-enum bfqg_stats_flags {
-	BFQG_stats_waiting = 0,
-	BFQG_stats_idling,
-	BFQG_stats_empty,
-};
-
-#define BFQG_FLAG_FNS(name)						\
-static void bfqg_stats_mark_##name(struct bfqg_stats *stats)	\
-{									\
-	stats->flags |= (1 << BFQG_stats_##name);			\
-}									\
-static void bfqg_stats_clear_##name(struct bfqg_stats *stats)	\
-{									\
-	stats->flags &= ~(1 << BFQG_stats_##name);			\
-}									\
-static int bfqg_stats_##name(struct bfqg_stats *stats)		\
-{									\
-	return (stats->flags & (1 << BFQG_stats_##name)) != 0;		\
-}									\
-
-BFQG_FLAG_FNS(waiting)
-BFQG_FLAG_FNS(idling)
-BFQG_FLAG_FNS(empty)
-#undef BFQG_FLAG_FNS
-
-/* This should be called with the queue_lock held. */
-static void bfqg_stats_update_group_wait_time(struct bfqg_stats *stats)
-{
-	unsigned long long now;
-
-	if (!bfqg_stats_waiting(stats))
-		return;
-
-	now = sched_clock();
-	if (time_after64(now, stats->start_group_wait_time))
-		blkg_stat_add(&stats->group_wait_time,
-			      now - stats->start_group_wait_time);
-	bfqg_stats_clear_waiting(stats);
-}
-
-/* This should be called with the queue_lock held. */
-static void bfqg_stats_set_start_group_wait_time(struct bfq_group *bfqg,
-						 struct bfq_group *curr_bfqg)
-{
-	struct bfqg_stats *stats = &bfqg->stats;
-
-	if (bfqg_stats_waiting(stats))
-		return;
-	if (bfqg == curr_bfqg)
-		return;
-	stats->start_group_wait_time = sched_clock();
-	bfqg_stats_mark_waiting(stats);
-}
-
-/* This should be called with the queue_lock held. */
-static void bfqg_stats_end_empty_time(struct bfqg_stats *stats)
-{
-	unsigned long long now;
-
-	if (!bfqg_stats_empty(stats))
-		return;
-
-	now = sched_clock();
-	if (time_after64(now, stats->start_empty_time))
-		blkg_stat_add(&stats->empty_time,
-			      now - stats->start_empty_time);
-	bfqg_stats_clear_empty(stats);
-}
-
-static void bfqg_stats_update_dequeue(struct bfq_group *bfqg)
-{
-	blkg_stat_add(&bfqg->stats.dequeue, 1);
-}
-
-static void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg)
-{
-	struct bfqg_stats *stats = &bfqg->stats;
-
-	if (blkg_rwstat_total(&stats->queued))
-		return;
-
-	/*
-	 * group is already marked empty. This can happen if bfqq got new
-	 * request in parent group and moved to this group while being added
-	 * to service tree. Just ignore the event and move on.
-	 */
-	if (bfqg_stats_empty(stats))
-		return;
-
-	stats->start_empty_time = sched_clock();
-	bfqg_stats_mark_empty(stats);
-}
-
-static void bfqg_stats_update_idle_time(struct bfq_group *bfqg)
-{
-	struct bfqg_stats *stats = &bfqg->stats;
-
-	if (bfqg_stats_idling(stats)) {
-		unsigned long long now = sched_clock();
-
-		if (time_after64(now, stats->start_idle_time))
-			blkg_stat_add(&stats->idle_time,
-				      now - stats->start_idle_time);
-		bfqg_stats_clear_idling(stats);
-	}
-}
-
-static void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg)
-{
-	struct bfqg_stats *stats = &bfqg->stats;
-
-	stats->start_idle_time = sched_clock();
-	bfqg_stats_mark_idling(stats);
-}
-
-static void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg)
-{
-	struct bfqg_stats *stats = &bfqg->stats;
-
-	blkg_stat_add(&stats->avg_queue_size_sum,
-		      blkg_rwstat_total(&stats->queued));
-	blkg_stat_add(&stats->avg_queue_size_samples, 1);
-	bfqg_stats_update_group_wait_time(stats);
-}
-
-/*
- * blk-cgroup policy-related handlers
- * The following functions help in converting between blk-cgroup
- * internal structures and BFQ-specific structures.
- */
-
-static struct bfq_group *pd_to_bfqg(struct blkg_policy_data *pd)
-{
-	return pd ? container_of(pd, struct bfq_group, pd) : NULL;
-}
-
-static struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg)
-{
-	return pd_to_blkg(&bfqg->pd);
-}
-
-static struct blkcg_policy blkcg_policy_bfq;
-
-static struct bfq_group *blkg_to_bfqg(struct blkcg_gq *blkg)
-{
-	return pd_to_bfqg(blkg_to_pd(blkg, &blkcg_policy_bfq));
-}
-
-/*
- * bfq_group handlers
- * The following functions help in navigating the bfq_group hierarchy
- * by allowing to find the parent of a bfq_group or the bfq_group
- * associated to a bfq_queue.
- */
-
-static struct bfq_group *bfqg_parent(struct bfq_group *bfqg)
-{
-	struct blkcg_gq *pblkg = bfqg_to_blkg(bfqg)->parent;
-
-	return pblkg ? blkg_to_bfqg(pblkg) : NULL;
-}
-
-static struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
-{
-	struct bfq_entity *group_entity = bfqq->entity.parent;
-
-	return group_entity ? container_of(group_entity, struct bfq_group,
-					   entity) :
-			      bfqq->bfqd->root_group;
-}
-
-/*
- * The following two functions handle get and put of a bfq_group by
- * wrapping the related blk-cgroup hooks.
- */
-
-static void bfqg_get(struct bfq_group *bfqg)
-{
-	return blkg_get(bfqg_to_blkg(bfqg));
-}
-
-static void bfqg_put(struct bfq_group *bfqg)
-{
-	return blkg_put(bfqg_to_blkg(bfqg));
-}
-
-static void bfqg_stats_update_io_add(struct bfq_group *bfqg,
-				     struct bfq_queue *bfqq,
-				     unsigned int op)
-{
-	blkg_rwstat_add(&bfqg->stats.queued, op, 1);
-	bfqg_stats_end_empty_time(&bfqg->stats);
-	if (!(bfqq == ((struct bfq_data *)bfqg->bfqd)->in_service_queue))
-		bfqg_stats_set_start_group_wait_time(bfqg, bfqq_group(bfqq));
-}
-
-static void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op)
-{
-	blkg_rwstat_add(&bfqg->stats.queued, op, -1);
-}
-
-static void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op)
-{
-	blkg_rwstat_add(&bfqg->stats.merged, op, 1);
-}
-
-static void bfqg_stats_update_completion(struct bfq_group *bfqg,
-			uint64_t start_time, uint64_t io_start_time,
-			unsigned int op)
-{
-	struct bfqg_stats *stats = &bfqg->stats;
-	unsigned long long now = sched_clock();
-
-	if (time_after64(now, io_start_time))
-		blkg_rwstat_add(&stats->service_time, op,
-				now - io_start_time);
-	if (time_after64(io_start_time, start_time))
-		blkg_rwstat_add(&stats->wait_time, op,
-				io_start_time - start_time);
-}
-
-/* @stats = 0 */
-static void bfqg_stats_reset(struct bfqg_stats *stats)
-{
-	/* queued stats shouldn't be cleared */
-	blkg_rwstat_reset(&stats->merged);
-	blkg_rwstat_reset(&stats->service_time);
-	blkg_rwstat_reset(&stats->wait_time);
-	blkg_stat_reset(&stats->time);
-	blkg_stat_reset(&stats->avg_queue_size_sum);
-	blkg_stat_reset(&stats->avg_queue_size_samples);
-	blkg_stat_reset(&stats->dequeue);
-	blkg_stat_reset(&stats->group_wait_time);
-	blkg_stat_reset(&stats->idle_time);
-	blkg_stat_reset(&stats->empty_time);
-}
-
-/* @to += @from */
-static void bfqg_stats_add_aux(struct bfqg_stats *to, struct bfqg_stats *from)
-{
-	if (!to || !from)
-		return;
-
-	/* queued stats shouldn't be cleared */
-	blkg_rwstat_add_aux(&to->merged, &from->merged);
-	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
-	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
-	blkg_stat_add_aux(&from->time, &from->time);
-	blkg_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
-	blkg_stat_add_aux(&to->avg_queue_size_samples,
-			  &from->avg_queue_size_samples);
-	blkg_stat_add_aux(&to->dequeue, &from->dequeue);
-	blkg_stat_add_aux(&to->group_wait_time, &from->group_wait_time);
-	blkg_stat_add_aux(&to->idle_time, &from->idle_time);
-	blkg_stat_add_aux(&to->empty_time, &from->empty_time);
-}
-
-/*
- * Transfer @bfqg's stats to its parent's aux counts so that the ancestors'
- * recursive stats can still account for the amount used by this bfqg after
- * it's gone.
- */
-static void bfqg_stats_xfer_dead(struct bfq_group *bfqg)
-{
-	struct bfq_group *parent;
-
-	if (!bfqg) /* root_group */
-		return;
-
-	parent = bfqg_parent(bfqg);
-
-	lockdep_assert_held(bfqg_to_blkg(bfqg)->q->queue_lock);
-
-	if (unlikely(!parent))
-		return;
-
-	bfqg_stats_add_aux(&parent->stats, &bfqg->stats);
-	bfqg_stats_reset(&bfqg->stats);
-}
-
-static void bfq_init_entity(struct bfq_entity *entity,
-			    struct bfq_group *bfqg)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-
-	entity->weight = entity->new_weight;
-	entity->orig_weight = entity->new_weight;
-	if (bfqq) {
-		bfqq->ioprio = bfqq->new_ioprio;
-		bfqq->ioprio_class = bfqq->new_ioprio_class;
-		bfqg_get(bfqg);
-	}
-	entity->parent = bfqg->my_entity; /* NULL for root group */
-	entity->sched_data = &bfqg->sched_data;
-}
-
-static void bfqg_stats_exit(struct bfqg_stats *stats)
-{
-	blkg_rwstat_exit(&stats->merged);
-	blkg_rwstat_exit(&stats->service_time);
-	blkg_rwstat_exit(&stats->wait_time);
-	blkg_rwstat_exit(&stats->queued);
-	blkg_stat_exit(&stats->time);
-	blkg_stat_exit(&stats->avg_queue_size_sum);
-	blkg_stat_exit(&stats->avg_queue_size_samples);
-	blkg_stat_exit(&stats->dequeue);
-	blkg_stat_exit(&stats->group_wait_time);
-	blkg_stat_exit(&stats->idle_time);
-	blkg_stat_exit(&stats->empty_time);
-}
-
-static int bfqg_stats_init(struct bfqg_stats *stats, gfp_t gfp)
-{
-	if (blkg_rwstat_init(&stats->merged, gfp) ||
-	    blkg_rwstat_init(&stats->service_time, gfp) ||
-	    blkg_rwstat_init(&stats->wait_time, gfp) ||
-	    blkg_rwstat_init(&stats->queued, gfp) ||
-	    blkg_stat_init(&stats->time, gfp) ||
-	    blkg_stat_init(&stats->avg_queue_size_sum, gfp) ||
-	    blkg_stat_init(&stats->avg_queue_size_samples, gfp) ||
-	    blkg_stat_init(&stats->dequeue, gfp) ||
-	    blkg_stat_init(&stats->group_wait_time, gfp) ||
-	    blkg_stat_init(&stats->idle_time, gfp) ||
-	    blkg_stat_init(&stats->empty_time, gfp)) {
-		bfqg_stats_exit(stats);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static struct bfq_group_data *cpd_to_bfqgd(struct blkcg_policy_data *cpd)
-{
-	return cpd ? container_of(cpd, struct bfq_group_data, pd) : NULL;
-}
-
-static struct bfq_group_data *blkcg_to_bfqgd(struct blkcg *blkcg)
-{
-	return cpd_to_bfqgd(blkcg_to_cpd(blkcg, &blkcg_policy_bfq));
-}
-
-static struct blkcg_policy_data *bfq_cpd_alloc(gfp_t gfp)
-{
-	struct bfq_group_data *bgd;
-
-	bgd = kzalloc(sizeof(*bgd), gfp);
-	if (!bgd)
-		return NULL;
-	return &bgd->pd;
-}
-
-static void bfq_cpd_init(struct blkcg_policy_data *cpd)
-{
-	struct bfq_group_data *d = cpd_to_bfqgd(cpd);
-
-	d->weight = cgroup_subsys_on_dfl(io_cgrp_subsys) ?
-		CGROUP_WEIGHT_DFL : BFQ_WEIGHT_LEGACY_DFL;
-}
-
-static void bfq_cpd_free(struct blkcg_policy_data *cpd)
-{
-	kfree(cpd_to_bfqgd(cpd));
-}
-
-static struct blkg_policy_data *bfq_pd_alloc(gfp_t gfp, int node)
-{
-	struct bfq_group *bfqg;
-
-	bfqg = kzalloc_node(sizeof(*bfqg), gfp, node);
-	if (!bfqg)
-		return NULL;
-
-	if (bfqg_stats_init(&bfqg->stats, gfp)) {
-		kfree(bfqg);
-		return NULL;
-	}
-
-	return &bfqg->pd;
-}
-
-static void bfq_pd_init(struct blkg_policy_data *pd)
-{
-	struct blkcg_gq *blkg = pd_to_blkg(pd);
-	struct bfq_group *bfqg = blkg_to_bfqg(blkg);
-	struct bfq_data *bfqd = blkg->q->elevator->elevator_data;
-	struct bfq_entity *entity = &bfqg->entity;
-	struct bfq_group_data *d = blkcg_to_bfqgd(blkg->blkcg);
-
-	entity->orig_weight = entity->weight = entity->new_weight = d->weight;
-	entity->my_sched_data = &bfqg->sched_data;
-	bfqg->my_entity = entity; /*
-				   * the root_group's will be set to NULL
-				   * in bfq_init_queue()
-				   */
-	bfqg->bfqd = bfqd;
-	bfqg->active_entities = 0;
-	bfqg->rq_pos_tree = RB_ROOT;
-}
-
-static void bfq_pd_free(struct blkg_policy_data *pd)
-{
-	struct bfq_group *bfqg = pd_to_bfqg(pd);
-
-	bfqg_stats_exit(&bfqg->stats);
-	return kfree(bfqg);
-}
-
-static void bfq_pd_reset_stats(struct blkg_policy_data *pd)
-{
-	struct bfq_group *bfqg = pd_to_bfqg(pd);
-
-	bfqg_stats_reset(&bfqg->stats);
-}
-
-static void bfq_group_set_parent(struct bfq_group *bfqg,
-					struct bfq_group *parent)
-{
-	struct bfq_entity *entity;
-
-	entity = &bfqg->entity;
-	entity->parent = parent->my_entity;
-	entity->sched_data = &parent->sched_data;
-}
-
-static struct bfq_group *bfq_lookup_bfqg(struct bfq_data *bfqd,
-					 struct blkcg *blkcg)
-{
-	struct blkcg_gq *blkg;
-
-	blkg = blkg_lookup(blkcg, bfqd->queue);
-	if (likely(blkg))
-		return blkg_to_bfqg(blkg);
-	return NULL;
-}
-
-static struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
-					    struct blkcg *blkcg)
-{
-	struct bfq_group *bfqg, *parent;
-	struct bfq_entity *entity;
-
-	bfqg = bfq_lookup_bfqg(bfqd, blkcg);
-
-	if (unlikely(!bfqg))
-		return NULL;
-
-	/*
-	 * Update chain of bfq_groups as we might be handling a leaf group
-	 * which, along with some of its relatives, has not been hooked yet
-	 * to the private hierarchy of BFQ.
-	 */
-	entity = &bfqg->entity;
-	for_each_entity(entity) {
-		bfqg = container_of(entity, struct bfq_group, entity);
-		if (bfqg != bfqd->root_group) {
-			parent = bfqg_parent(bfqg);
-			if (!parent)
-				parent = bfqd->root_group;
-			bfq_group_set_parent(bfqg, parent);
-		}
-	}
-
-	return bfqg;
-}
-
-static void bfq_pos_tree_add_move(struct bfq_data *bfqd,
-				  struct bfq_queue *bfqq);
-static void bfq_bfqq_expire(struct bfq_data *bfqd,
-			    struct bfq_queue *bfqq,
-			    bool compensate,
-			    enum bfqq_expiration reason);
-
-/**
- * bfq_bfqq_move - migrate @bfqq to @bfqg.
- * @bfqd: queue descriptor.
- * @bfqq: the queue to move.
- * @bfqg: the group to move to.
- *
- * Move @bfqq to @bfqg, deactivating it from its old group and reactivating
- * it on the new one.  Avoid putting the entity on the old group idle tree.
- *
- * Must be called under the queue lock; the cgroup owning @bfqg must
- * not disappear (by now this just means that we are called under
- * rcu_read_lock()).
- */
-static void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct bfq_group *bfqg)
-{
-	struct bfq_entity *entity = &bfqq->entity;
-
-	/* If bfqq is empty, then bfq_bfqq_expire also invokes
-	 * bfq_del_bfqq_busy, thereby removing bfqq and its entity
-	 * from data structures related to current group. Otherwise we
-	 * need to remove bfqq explicitly with bfq_deactivate_bfqq, as
-	 * we do below.
-	 */
-	if (bfqq == bfqd->in_service_queue)
-		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
-				false, BFQQE_PREEMPTED);
-
-	if (bfq_bfqq_busy(bfqq))
-		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
-	else if (entity->on_st)
-		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
-	bfqg_put(bfqq_group(bfqq));
-
-	/*
-	 * Here we use a reference to bfqg.  We don't need a refcounter
-	 * as the cgroup reference will not be dropped, so that its
-	 * destroy() callback will not be invoked.
-	 */
-	entity->parent = bfqg->my_entity;
-	entity->sched_data = &bfqg->sched_data;
-	bfqg_get(bfqg);
-
-	if (bfq_bfqq_busy(bfqq)) {
-		bfq_pos_tree_add_move(bfqd, bfqq);
-		bfq_activate_bfqq(bfqd, bfqq);
-	}
-
-	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
-		bfq_schedule_dispatch(bfqd);
-}
-
-/**
- * __bfq_bic_change_cgroup - move @bic to @cgroup.
- * @bfqd: the queue descriptor.
- * @bic: the bic to move.
- * @blkcg: the blk-cgroup to move to.
- *
- * Move bic to blkcg, assuming that bfqd->queue is locked; the caller
- * has to make sure that the reference to cgroup is valid across the call.
- *
- * NOTE: an alternative approach might have been to store the current
- * cgroup in bfqq and getting a reference to it, reducing the lookup
- * time here, at the price of slightly more complex code.
- */
-static struct bfq_group *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
-						struct bfq_io_cq *bic,
-						struct blkcg *blkcg)
-{
-	struct bfq_queue *async_bfqq = bic_to_bfqq(bic, 0);
-	struct bfq_queue *sync_bfqq = bic_to_bfqq(bic, 1);
-	struct bfq_group *bfqg;
-	struct bfq_entity *entity;
-
-	bfqg = bfq_find_set_group(bfqd, blkcg);
-
-	if (unlikely(!bfqg))
-		bfqg = bfqd->root_group;
-
-	if (async_bfqq) {
-		entity = &async_bfqq->entity;
-
-		if (entity->sched_data != &bfqg->sched_data) {
-			bic_set_bfqq(bic, NULL, 0);
-			bfq_log_bfqq(bfqd, async_bfqq,
-				     "bic_change_group: %p %d",
-				     async_bfqq, async_bfqq->ref);
-			bfq_put_queue(async_bfqq);
-		}
-	}
-
-	if (sync_bfqq) {
-		entity = &sync_bfqq->entity;
-		if (entity->sched_data != &bfqg->sched_data)
-			bfq_bfqq_move(bfqd, sync_bfqq, bfqg);
-	}
-
-	return bfqg;
-}
-
-static void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
-{
-	struct bfq_data *bfqd = bic_to_bfqd(bic);
-	struct bfq_group *bfqg = NULL;
-	uint64_t serial_nr;
-
-	rcu_read_lock();
-	serial_nr = bio_blkcg(bio)->css.serial_nr;
-
-	/*
-	 * Check whether blkcg has changed.  The condition may trigger
-	 * spuriously on a newly created cic but there's no harm.
-	 */
-	if (unlikely(!bfqd) || likely(bic->blkcg_serial_nr == serial_nr))
-		goto out;
-
-	bfqg = __bfq_bic_change_cgroup(bfqd, bic, bio_blkcg(bio));
-	bic->blkcg_serial_nr = serial_nr;
-out:
-	rcu_read_unlock();
-}
-
-/**
- * bfq_flush_idle_tree - deactivate any entity on the idle tree of @st.
- * @st: the service tree being flushed.
- */
-static void bfq_flush_idle_tree(struct bfq_service_tree *st)
-{
-	struct bfq_entity *entity = st->first_idle;
-
-	for (; entity ; entity = st->first_idle)
-		__bfq_deactivate_entity(entity, false);
-}
-
-/**
- * bfq_reparent_leaf_entity - move leaf entity to the root_group.
- * @bfqd: the device data structure with the root group.
- * @entity: the entity to move.
- */
-static void bfq_reparent_leaf_entity(struct bfq_data *bfqd,
-				     struct bfq_entity *entity)
-{
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-
-	bfq_bfqq_move(bfqd, bfqq, bfqd->root_group);
-}
-
-/**
- * bfq_reparent_active_entities - move to the root group all active
- *                                entities.
- * @bfqd: the device data structure with the root group.
- * @bfqg: the group to move from.
- * @st: the service tree with the entities.
- *
- * Needs queue_lock to be taken and reference to be valid over the call.
- */
-static void bfq_reparent_active_entities(struct bfq_data *bfqd,
-					 struct bfq_group *bfqg,
-					 struct bfq_service_tree *st)
-{
-	struct rb_root *active = &st->active;
-	struct bfq_entity *entity = NULL;
-
-	if (!RB_EMPTY_ROOT(&st->active))
-		entity = bfq_entity_of(rb_first(active));
-
-	for (; entity ; entity = bfq_entity_of(rb_first(active)))
-		bfq_reparent_leaf_entity(bfqd, entity);
-
-	if (bfqg->sched_data.in_service_entity)
-		bfq_reparent_leaf_entity(bfqd,
-			bfqg->sched_data.in_service_entity);
-}
-
-/**
- * bfq_pd_offline - deactivate the entity associated with @pd,
- *		    and reparent its children entities.
- * @pd: descriptor of the policy going offline.
- *
- * blkio already grabs the queue_lock for us, so no need to use
- * RCU-based magic
- */
-static void bfq_pd_offline(struct blkg_policy_data *pd)
-{
-	struct bfq_service_tree *st;
-	struct bfq_group *bfqg = pd_to_bfqg(pd);
-	struct bfq_data *bfqd = bfqg->bfqd;
-	struct bfq_entity *entity = bfqg->my_entity;
-	unsigned long flags;
-	int i;
-
-	if (!entity) /* root group */
-		return;
-
-	spin_lock_irqsave(&bfqd->lock, flags);
-	/*
-	 * Empty all service_trees belonging to this group before
-	 * deactivating the group itself.
-	 */
-	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++) {
-		st = bfqg->sched_data.service_tree + i;
-
-		/*
-		 * The idle tree may still contain bfq_queues belonging
-		 * to exited task because they never migrated to a different
-		 * cgroup from the one being destroyed now.  No one else
-		 * can access them so it's safe to act without any lock.
-		 */
-		bfq_flush_idle_tree(st);
-
-		/*
-		 * It may happen that some queues are still active
-		 * (busy) upon group destruction (if the corresponding
-		 * processes have been forced to terminate). We move
-		 * all the leaf entities corresponding to these queues
-		 * to the root_group.
-		 * Also, it may happen that the group has an entity
-		 * in service, which is disconnected from the active
-		 * tree: it must be moved, too.
-		 * There is no need to put the sync queues, as the
-		 * scheduler has taken no reference.
-		 */
-		bfq_reparent_active_entities(bfqd, bfqg, st);
-	}
-
-	__bfq_deactivate_entity(entity, false);
-	bfq_put_async_queues(bfqd, bfqg);
-
-	spin_unlock_irqrestore(&bfqd->lock, flags);
-	/*
-	 * @blkg is going offline and will be ignored by
-	 * blkg_[rw]stat_recursive_sum().  Transfer stats to the parent so
-	 * that they don't get lost.  If IOs complete after this point, the
-	 * stats for them will be lost.  Oh well...
-	 */
-	bfqg_stats_xfer_dead(bfqg);
-}
-
-static void bfq_end_wr_async(struct bfq_data *bfqd)
-{
-	struct blkcg_gq *blkg;
-
-	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
-		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
-
-		bfq_end_wr_async_queues(bfqd, bfqg);
-	}
-	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
+#define BFQ_BFQQ_FNS(name)						\
+void bfq_mark_bfqq_##name(struct bfq_queue *bfqq)			\
+{									\
+	__set_bit(BFQQF_##name, &(bfqq)->flags);			\
+}									\
+void bfq_clear_bfqq_##name(struct bfq_queue *bfqq)			\
+{									\
+	__clear_bit(BFQQF_##name, &(bfqq)->flags);		\
+}									\
+int bfq_bfqq_##name(const struct bfq_queue *bfqq)			\
+{									\
+	return test_bit(BFQQF_##name, &(bfqq)->flags);		\
 }
 
-static int bfq_io_show_weight(struct seq_file *sf, void *v)
-{
-	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
-	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
-	unsigned int val = 0;
+BFQ_BFQQ_FNS(just_created);
+BFQ_BFQQ_FNS(busy);
+BFQ_BFQQ_FNS(wait_request);
+BFQ_BFQQ_FNS(non_blocking_wait_rq);
+BFQ_BFQQ_FNS(fifo_expire);
+BFQ_BFQQ_FNS(idle_window);
+BFQ_BFQQ_FNS(sync);
+BFQ_BFQQ_FNS(IO_bound);
+BFQ_BFQQ_FNS(in_large_burst);
+BFQ_BFQQ_FNS(coop);
+BFQ_BFQQ_FNS(split_coop);
+BFQ_BFQQ_FNS(softrt_update);
+#undef BFQ_BFQQ_FNS						\
 
-	if (bfqgd)
-		val = bfqgd->weight;
+/* Expiration time of sync (0) and async (1) requests, in ns. */
+static const u64 bfq_fifo_expire[2] = { NSEC_PER_SEC / 4, NSEC_PER_SEC / 8 };
 
-	seq_printf(sf, "%u\n", val);
+/* Maximum backwards seek (magic number lifted from CFQ), in KiB. */
+static const int bfq_back_max = 16 * 1024;
 
-	return 0;
-}
+/* Penalty of a backwards seek, in number of sectors. */
+static const int bfq_back_penalty = 2;
 
-static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
-				    struct cftype *cftype,
-				    u64 val)
-{
-	struct blkcg *blkcg = css_to_blkcg(css);
-	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
-	struct blkcg_gq *blkg;
-	int ret = -ERANGE;
+/* Idling period duration, in ns. */
+static u64 bfq_slice_idle = NSEC_PER_SEC / 125;
 
-	if (val < BFQ_MIN_WEIGHT || val > BFQ_MAX_WEIGHT)
-		return ret;
+/* Minimum number of assigned budgets for which stats are safe to compute. */
+static const int bfq_stats_min_budgets = 194;
 
-	ret = 0;
-	spin_lock_irq(&blkcg->lock);
-	bfqgd->weight = (unsigned short)val;
-	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
+/* Default maximum budget values, in sectors and number of requests. */
+static const int bfq_default_max_budget = 16 * 1024;
 
-		if (!bfqg)
-			continue;
-		/*
-		 * Setting the prio_changed flag of the entity
-		 * to 1 with new_weight == weight would re-set
-		 * the value of the weight to its ioprio mapping.
-		 * Set the flag only if necessary.
-		 */
-		if ((unsigned short)val != bfqg->entity.new_weight) {
-			bfqg->entity.new_weight = (unsigned short)val;
-			/*
-			 * Make sure that the above new value has been
-			 * stored in bfqg->entity.new_weight before
-			 * setting the prio_changed flag. In fact,
-			 * this flag may be read asynchronously (in
-			 * critical sections protected by a different
-			 * lock than that held here), and finding this
-			 * flag set may cause the execution of the code
-			 * for updating parameters whose value may
-			 * depend also on bfqg->entity.new_weight (in
-			 * __bfq_entity_update_weight_prio).
-			 * This barrier makes sure that the new value
-			 * of bfqg->entity.new_weight is correctly
-			 * seen in that code.
-			 */
-			smp_wmb();
-			bfqg->entity.prio_changed = 1;
-		}
-	}
-	spin_unlock_irq(&blkcg->lock);
+/*
+ * Async to sync throughput distribution is controlled as follows:
+ * when an async request is served, the entity is charged the number
+ * of sectors of the request, multiplied by the factor below
+ */
+static const int bfq_async_charge_factor = 10;
 
-	return ret;
-}
+/* Default timeout values, in jiffies, approximating CFQ defaults. */
+const int bfq_timeout = HZ / 8;
 
-static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
-				 char *buf, size_t nbytes,
-				 loff_t off)
-{
-	u64 weight;
-	/* First unsigned long found in the file is used */
-	int ret = kstrtoull(strim(buf), 0, &weight);
+static struct kmem_cache *bfq_pool;
 
-	if (ret)
-		return ret;
+/* Below this threshold (in ns), we consider thinktime immediate. */
+#define BFQ_MIN_TT		(2 * NSEC_PER_MSEC)
 
-	return bfq_io_set_weight_legacy(of_css(of), NULL, weight);
-}
+/* hw_tag detection: parallel requests threshold and min samples needed. */
+#define BFQ_HW_QUEUE_THRESHOLD	4
+#define BFQ_HW_QUEUE_SAMPLES	32
 
-static int bfqg_print_stat(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
-			  &blkcg_policy_bfq, seq_cft(sf)->private, false);
-	return 0;
-}
+#define BFQQ_SEEK_THR		(sector_t)(8 * 100)
+#define BFQQ_SECT_THR_NONROT	(sector_t)(2 * 32)
+#define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
+#define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 32/8)
 
-static int bfqg_print_rwstat(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
-			  &blkcg_policy_bfq, seq_cft(sf)->private, true);
-	return 0;
-}
+/* Min number of samples required to perform peak-rate update */
+#define BFQ_RATE_MIN_SAMPLES	32
+/* Min observation time interval required to perform a peak-rate update (ns) */
+#define BFQ_RATE_MIN_INTERVAL	(300*NSEC_PER_MSEC)
+/* Target observation time interval for a peak-rate update (ns) */
+#define BFQ_RATE_REF_INTERVAL	NSEC_PER_SEC
 
-static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
-				      struct blkg_policy_data *pd, int off)
-{
-	u64 sum = blkg_stat_recursive_sum(pd_to_blkg(pd),
-					  &blkcg_policy_bfq, off);
-	return __blkg_prfill_u64(sf, pd, sum);
-}
+/* Shift used for peak rate fixed precision calculations. */
+#define BFQ_RATE_SHIFT		16
 
-static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
-					struct blkg_policy_data *pd, int off)
-{
-	struct blkg_rwstat sum = blkg_rwstat_recursive_sum(pd_to_blkg(pd),
-							   &blkcg_policy_bfq,
-							   off);
-	return __blkg_prfill_rwstat(sf, pd, &sum);
-}
+/*
+ * By default, BFQ computes the duration of the weight raising for
+ * interactive applications automatically, using the following formula:
+ * duration = (R / r) * T, where r is the peak rate of the device, and
+ * R and T are two reference parameters.
+ * In particular, R is the peak rate of the reference device (see below),
+ * and T is a reference time: given the systems that are likely to be
+ * installed on the reference device according to its speed class, T is
+ * about the maximum time needed, under BFQ and while reading two files in
+ * parallel, to load typical large applications on these systems.
+ * In practice, the slower/faster the device at hand is, the more/less it
+ * takes to load applications with respect to the reference device.
+ * Accordingly, the longer/shorter BFQ grants weight raising to interactive
+ * applications.
+ *
+ * BFQ uses four different reference pairs (R, T), depending on:
+ * . whether the device is rotational or non-rotational;
+ * . whether the device is slow, such as old or portable HDDs, as well as
+ *   SD cards, or fast, such as newer HDDs and SSDs.
+ *
+ * The device's speed class is dynamically (re)detected in
+ * bfq_update_peak_rate() every time the estimated peak rate is updated.
+ *
+ * In the following definitions, R_slow[0]/R_fast[0] and
+ * T_slow[0]/T_fast[0] are the reference values for a slow/fast
+ * rotational device, whereas R_slow[1]/R_fast[1] and
+ * T_slow[1]/T_fast[1] are the reference values for a slow/fast
+ * non-rotational device. Finally, device_speed_thresh are the
+ * thresholds used to switch between speed classes. The reference
+ * rates are not the actual peak rates of the devices used as a
+ * reference, but slightly lower values. The reason for using these
+ * slightly lower values is that the peak-rate estimator tends to
+ * yield slightly lower values than the actual peak rate (it can yield
+ * the actual peak rate only if there is only one process doing I/O,
+ * and the process does sequential I/O).
+ *
+ * Both the reference peak rates and the thresholds are measured in
+ * sectors/usec, left-shifted by BFQ_RATE_SHIFT.
+ */
+static int R_slow[2] = {1000, 10700};
+static int R_fast[2] = {14000, 33000};
+/*
+ * To improve readability, a conversion function is used to initialize the
+ * following arrays, which entails that they can be initialized only in a
+ * function.
+ */
+static int T_slow[2];
+static int T_fast[2];
+static int device_speed_thresh[2];
 
-static int bfqg_print_stat_recursive(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  bfqg_prfill_stat_recursive, &blkcg_policy_bfq,
-			  seq_cft(sf)->private, false);
-	return 0;
-}
+#define RQ_BIC(rq)		((struct bfq_io_cq *) (rq)->elv.priv[0])
+#define RQ_BFQQ(rq)		((rq)->elv.priv[1])
 
-static int bfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
+struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  bfqg_prfill_rwstat_recursive, &blkcg_policy_bfq,
-			  seq_cft(sf)->private, true);
-	return 0;
+	return bic->bfqq[is_sync];
 }
 
-static u64 bfqg_prfill_sectors(struct seq_file *sf, struct blkg_policy_data *pd,
-			       int off)
+void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync)
 {
-	u64 sum = blkg_rwstat_total(&pd->blkg->stat_bytes);
-
-	return __blkg_prfill_u64(sf, pd, sum >> 9);
+	bic->bfqq[is_sync] = bfqq;
 }
 
-static int bfqg_print_stat_sectors(struct seq_file *sf, void *v)
+struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  bfqg_prfill_sectors, &blkcg_policy_bfq, 0, false);
-	return 0;
+	return bic->icq.q->elevator->elevator_data;
 }
 
-static u64 bfqg_prfill_sectors_recursive(struct seq_file *sf,
-					 struct blkg_policy_data *pd, int off)
+/**
+ * icq_to_bic - convert iocontext queue structure to bfq_io_cq.
+ * @icq: the iocontext queue.
+ */
+static struct bfq_io_cq *icq_to_bic(struct io_cq *icq)
 {
-	struct blkg_rwstat tmp = blkg_rwstat_recursive_sum(pd->blkg, NULL,
-					offsetof(struct blkcg_gq, stat_bytes));
-	u64 sum = atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_READ]) +
-		atomic64_read(&tmp.aux_cnt[BLKG_RWSTAT_WRITE]);
-
-	return __blkg_prfill_u64(sf, pd, sum >> 9);
+	/* bic->icq is the first member, %NULL will convert to %NULL */
+	return container_of(icq, struct bfq_io_cq, icq);
 }
 
-static int bfqg_print_stat_sectors_recursive(struct seq_file *sf, void *v)
+/**
+ * bfq_bic_lookup - search into @ioc a bic associated to @bfqd.
+ * @bfqd: the lookup key.
+ * @ioc: the io_context of the process doing I/O.
+ * @q: the request queue.
+ */
+static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
+					struct io_context *ioc,
+					struct request_queue *q)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  bfqg_prfill_sectors_recursive, &blkcg_policy_bfq, 0,
-			  false);
-	return 0;
-}
+	if (ioc) {
+		unsigned long flags;
+		struct bfq_io_cq *icq;
 
-static u64 bfqg_prfill_avg_queue_size(struct seq_file *sf,
-				      struct blkg_policy_data *pd, int off)
-{
-	struct bfq_group *bfqg = pd_to_bfqg(pd);
-	u64 samples = blkg_stat_read(&bfqg->stats.avg_queue_size_samples);
-	u64 v = 0;
+		spin_lock_irqsave(q->queue_lock, flags);
+		icq = icq_to_bic(ioc_lookup_icq(ioc, q));
+		spin_unlock_irqrestore(q->queue_lock, flags);
 
-	if (samples) {
-		v = blkg_stat_read(&bfqg->stats.avg_queue_size_sum);
-		v = div64_u64(v, samples);
+		return icq;
 	}
-	__blkg_prfill_u64(sf, pd, v);
-	return 0;
-}
-
-/* print avg_queue_size */
-static int bfqg_print_avg_queue_size(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  bfqg_prfill_avg_queue_size, &blkcg_policy_bfq,
-			  0, false);
-	return 0;
-}
-
-static struct bfq_group *
-bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
-{
-	int ret;
-
-	ret = blkcg_activate_policy(bfqd->queue, &blkcg_policy_bfq);
-	if (ret)
-		return NULL;
 
-	return blkg_to_bfqg(bfqd->queue->root_blkg);
+	return NULL;
 }
 
-static struct cftype bfq_blkcg_legacy_files[] = {
-	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = bfq_io_show_weight,
-		.write_u64 = bfq_io_set_weight_legacy,
-	},
-
-	/* statistics, covers only the tasks in the bfqg */
-	{
-		.name = "bfq.time",
-		.private = offsetof(struct bfq_group, stats.time),
-		.seq_show = bfqg_print_stat,
-	},
-	{
-		.name = "bfq.sectors",
-		.seq_show = bfqg_print_stat_sectors,
-	},
-	{
-		.name = "bfq.io_service_bytes",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_bytes,
-	},
-	{
-		.name = "bfq.io_serviced",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_ios,
-	},
-	{
-		.name = "bfq.io_service_time",
-		.private = offsetof(struct bfq_group, stats.service_time),
-		.seq_show = bfqg_print_rwstat,
-	},
-	{
-		.name = "bfq.io_wait_time",
-		.private = offsetof(struct bfq_group, stats.wait_time),
-		.seq_show = bfqg_print_rwstat,
-	},
-	{
-		.name = "bfq.io_merged",
-		.private = offsetof(struct bfq_group, stats.merged),
-		.seq_show = bfqg_print_rwstat,
-	},
-	{
-		.name = "bfq.io_queued",
-		.private = offsetof(struct bfq_group, stats.queued),
-		.seq_show = bfqg_print_rwstat,
-	},
-
-	/* the same statictics which cover the bfqg and its descendants */
-	{
-		.name = "bfq.time_recursive",
-		.private = offsetof(struct bfq_group, stats.time),
-		.seq_show = bfqg_print_stat_recursive,
-	},
-	{
-		.name = "bfq.sectors_recursive",
-		.seq_show = bfqg_print_stat_sectors_recursive,
-	},
-	{
-		.name = "bfq.io_service_bytes_recursive",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_bytes_recursive,
-	},
-	{
-		.name = "bfq.io_serviced_recursive",
-		.private = (unsigned long)&blkcg_policy_bfq,
-		.seq_show = blkg_print_stat_ios_recursive,
-	},
-	{
-		.name = "bfq.io_service_time_recursive",
-		.private = offsetof(struct bfq_group, stats.service_time),
-		.seq_show = bfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "bfq.io_wait_time_recursive",
-		.private = offsetof(struct bfq_group, stats.wait_time),
-		.seq_show = bfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "bfq.io_merged_recursive",
-		.private = offsetof(struct bfq_group, stats.merged),
-		.seq_show = bfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "bfq.io_queued_recursive",
-		.private = offsetof(struct bfq_group, stats.queued),
-		.seq_show = bfqg_print_rwstat_recursive,
-	},
-	{
-		.name = "bfq.avg_queue_size",
-		.seq_show = bfqg_print_avg_queue_size,
-	},
-	{
-		.name = "bfq.group_wait_time",
-		.private = offsetof(struct bfq_group, stats.group_wait_time),
-		.seq_show = bfqg_print_stat,
-	},
-	{
-		.name = "bfq.idle_time",
-		.private = offsetof(struct bfq_group, stats.idle_time),
-		.seq_show = bfqg_print_stat,
-	},
-	{
-		.name = "bfq.empty_time",
-		.private = offsetof(struct bfq_group, stats.empty_time),
-		.seq_show = bfqg_print_stat,
-	},
-	{
-		.name = "bfq.dequeue",
-		.private = offsetof(struct bfq_group, stats.dequeue),
-		.seq_show = bfqg_print_stat,
-	},
-	{ }	/* terminate */
-};
-
-static struct cftype bfq_blkg_files[] = {
-	{
-		.name = "bfq.weight",
-		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = bfq_io_show_weight,
-		.write = bfq_io_set_weight,
-	},
-	{} /* terminate */
-};
-
-#else	/* CONFIG_BFQ_GROUP_IOSCHED */
-
-static inline void bfqg_stats_update_io_add(struct bfq_group *bfqg,
-			struct bfq_queue *bfqq, unsigned int op) { }
-static inline void
-bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op) { }
-static inline void
-bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op) { }
-static inline void bfqg_stats_update_completion(struct bfq_group *bfqg,
-			uint64_t start_time, uint64_t io_start_time,
-			unsigned int op) { }
-static inline void
-bfqg_stats_set_start_group_wait_time(struct bfq_group *bfqg,
-				     struct bfq_group *curr_bfqg) { }
-static inline void bfqg_stats_end_empty_time(struct bfqg_stats *stats) { }
-static inline void bfqg_stats_update_dequeue(struct bfq_group *bfqg) { }
-static inline void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg) { }
-static inline void bfqg_stats_update_idle_time(struct bfq_group *bfqg) { }
-static inline void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg) { }
-static inline void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg) { }
-
-static void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-			  struct bfq_group *bfqg) {}
-
-static void bfq_init_entity(struct bfq_entity *entity,
-			    struct bfq_group *bfqg)
+/*
+ * Scheduler run of queue, if there are requests pending and no one in the
+ * driver that will restart queueing.
+ */
+void bfq_schedule_dispatch(struct bfq_data *bfqd)
 {
-	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-
-	entity->weight = entity->new_weight;
-	entity->orig_weight = entity->new_weight;
-	if (bfqq) {
-		bfqq->ioprio = bfqq->new_ioprio;
-		bfqq->ioprio_class = bfqq->new_ioprio_class;
+	if (bfqd->queued != 0) {
+		bfq_log(bfqd, "schedule dispatch");
+		blk_mq_run_hw_queues(bfqd->queue, true);
 	}
-	entity->sched_data = &bfqg->sched_data;
-}
-
-static void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio) {}
-
-static void bfq_end_wr_async(struct bfq_data *bfqd)
-{
-	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
-}
-
-static struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
-					    struct blkcg *blkcg)
-{
-	return bfqd->root_group;
-}
-
-static struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
-{
-	return bfqq->bfqd->root_group;
-}
-
-static struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd,
-						    int node)
-{
-	struct bfq_group *bfqg;
-	int i;
-
-	bfqg = kmalloc_node(sizeof(*bfqg), GFP_KERNEL | __GFP_ZERO, node);
-	if (!bfqg)
-		return NULL;
-
-	for (i = 0; i < BFQ_IOPRIO_CLASSES; i++)
-		bfqg->sched_data.service_tree[i] = BFQ_SERVICE_TREE_INIT;
-
-	return bfqg;
 }
-#endif	/* CONFIG_BFQ_GROUP_IOSCHED */
 
 #define bfq_class_idle(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_IDLE)
 #define bfq_class_rt(bfqq)	((bfqq)->ioprio_class == IOPRIO_CLASS_RT)
@@ -4002,7 +438,7 @@ bfq_rq_pos_tree_lookup(struct bfq_data *bfqd, struct rb_root *root,
 	return bfqq;
 }
 
-static void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
 	struct rb_node **p, *parent;
 	struct bfq_queue *__bfqq;
@@ -4091,9 +527,8 @@ static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
  * In most scenarios, the rate at which nodes are created/destroyed
  * should be low too.
  */
-static void bfq_weights_tree_add(struct bfq_data *bfqd,
-				 struct bfq_entity *entity,
-				 struct rb_root *root)
+void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_entity *entity,
+			  struct rb_root *root)
 {
 	struct rb_node **new = &(root->rb_node), *parent = NULL;
 
@@ -4161,9 +596,8 @@ static void bfq_weights_tree_add(struct bfq_data *bfqd,
  * See the comments to the function bfq_weights_tree_add() for considerations
  * about overhead.
  */
-static void bfq_weights_tree_remove(struct bfq_data *bfqd,
-				    struct bfq_entity *entity,
-				    struct rb_root *root)
+void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_entity *entity,
+			     struct rb_root *root)
 {
 	if (!entity->weight_counter)
 		return;
@@ -4580,11 +1014,6 @@ static int bfq_min_budget(struct bfq_data *bfqd)
 		return bfqd->bfq_max_budget / 32;
 }
 
-static void bfq_bfqq_expire(struct bfq_data *bfqd,
-			    struct bfq_queue *bfqq,
-			    bool compensate,
-			    enum bfqq_expiration reason);
-
 /*
  * The next function, invoked after the input queue bfqq switches from
  * idle to busy, updates the budget of bfqq. The function also tells
@@ -5275,8 +1704,8 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
 	bfqq->entity.prio_changed = 1;
 }
 
-static void bfq_end_wr_async_queues(struct bfq_data *bfqd,
-				    struct bfq_group *bfqg)
+void bfq_end_wr_async_queues(struct bfq_data *bfqd,
+			     struct bfq_group *bfqg)
 {
 	int i, j;
 
@@ -6495,10 +2924,10 @@ static unsigned long bfq_smallest_from_now(void)
  * former on a timeslice basis, without violating service domain
  * guarantees among the latter.
  */
-static void bfq_bfqq_expire(struct bfq_data *bfqd,
-			    struct bfq_queue *bfqq,
-			    bool compensate,
-			    enum bfqq_expiration reason)
+void bfq_bfqq_expire(struct bfq_data *bfqd,
+		     struct bfq_queue *bfqq,
+		     bool compensate,
+		     enum bfqq_expiration reason)
 {
 	bool slow;
 	unsigned long delta = 0;
@@ -7204,7 +3633,7 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
  * Scheduler lock must be held here. Recall not to use bfqq after calling
  * this function on it.
  */
-static void bfq_put_queue(struct bfq_queue *bfqq)
+void bfq_put_queue(struct bfq_queue *bfqq)
 {
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	struct bfq_group *bfqg = bfqq_group(bfqq);
@@ -7345,6 +3774,10 @@ bfq_set_next_ioprio_data(struct bfq_queue *bfqq, struct bfq_io_cq *bic)
 	bfqq->entity.prio_changed = 1;
 }
 
+static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
+				       struct bio *bio, bool is_sync,
+				       struct bfq_io_cq *bic);
+
 static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio)
 {
 	struct bfq_data *bfqd = bic_to_bfqd(bic);
@@ -8121,7 +4554,7 @@ static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
  * we reparent them to the root cgroup (i.e., the only one that will
  * exist for sure until all the requests on a device are gone).
  */
-static void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
+void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 {
 	int i, j;
 
@@ -8537,24 +4970,6 @@ static struct elevator_type iosched_bfq_mq = {
 	.elevator_owner =	THIS_MODULE,
 };
 
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-static struct blkcg_policy blkcg_policy_bfq = {
-	.dfl_cftypes		= bfq_blkg_files,
-	.legacy_cftypes		= bfq_blkcg_legacy_files,
-
-	.cpd_alloc_fn		= bfq_cpd_alloc,
-	.cpd_init_fn		= bfq_cpd_init,
-	.cpd_bind_fn	        = bfq_cpd_init,
-	.cpd_free_fn		= bfq_cpd_free,
-
-	.pd_alloc_fn		= bfq_pd_alloc,
-	.pd_init_fn		= bfq_pd_init,
-	.pd_offline_fn		= bfq_pd_offline,
-	.pd_free_fn		= bfq_pd_free,
-	.pd_reset_stats_fn	= bfq_pd_reset_stats,
-};
-#endif
-
 static int __init bfq_init(void)
 {
 	int ret;
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
new file mode 100644
index 0000000..4ce7915
--- /dev/null
+++ b/block/bfq-iosched.h
@@ -0,0 +1,942 @@
+/*
+ * Header file for the BFQ I/O scheduler: data structures and
+ * prototypes of interface functions among BFQ components.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation; either version 2 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ */
+#ifndef _BFQ_H
+#define _BFQ_H
+
+#include <linux/blktrace_api.h>
+#include <linux/hrtimer.h>
+#include <linux/blk-cgroup.h>
+
+#define BFQ_IOPRIO_CLASSES	3
+#define BFQ_CL_IDLE_TIMEOUT	(HZ/5)
+
+#define BFQ_MIN_WEIGHT			1
+#define BFQ_MAX_WEIGHT			1000
+#define BFQ_WEIGHT_CONVERSION_COEFF	10
+
+#define BFQ_DEFAULT_QUEUE_IOPRIO	4
+
+#define BFQ_WEIGHT_LEGACY_DFL	100
+#define BFQ_DEFAULT_GRP_IOPRIO	0
+#define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
+
+/*
+ * Soft real-time applications are extremely more latency sensitive
+ * than interactive ones. Over-raise the weight of the former to
+ * privilege them against the latter.
+ */
+#define BFQ_SOFTRT_WEIGHT_FACTOR	100
+
+struct bfq_entity;
+
+/**
+ * struct bfq_service_tree - per ioprio_class service tree.
+ *
+ * Each service tree represents a B-WF2Q+ scheduler on its own.  Each
+ * ioprio_class has its own independent scheduler, and so its own
+ * bfq_service_tree.  All the fields are protected by the queue lock
+ * of the containing bfqd.
+ */
+struct bfq_service_tree {
+	/* tree for active entities (i.e., those backlogged) */
+	struct rb_root active;
+	/* tree for idle entities (i.e., not backlogged, with V <= F_i)*/
+	struct rb_root idle;
+
+	/* idle entity with minimum F_i */
+	struct bfq_entity *first_idle;
+	/* idle entity with maximum F_i */
+	struct bfq_entity *last_idle;
+
+	/* scheduler virtual time */
+	u64 vtime;
+	/* scheduler weight sum; active and idle entities contribute to it */
+	unsigned long wsum;
+};
+
+/**
+ * struct bfq_sched_data - multi-class scheduler.
+ *
+ * bfq_sched_data is the basic scheduler queue.  It supports three
+ * ioprio_classes, and can be used either as a toplevel queue or as an
+ * intermediate queue on a hierarchical setup.  @next_in_service
+ * points to the active entity of the sched_data service trees that
+ * will be scheduled next. It is used to reduce the number of steps
+ * needed for each hierarchical-schedule update.
+ *
+ * The supported ioprio_classes are the same as in CFQ, in descending
+ * priority order, IOPRIO_CLASS_RT, IOPRIO_CLASS_BE, IOPRIO_CLASS_IDLE.
+ * Requests from higher priority queues are served before all the
+ * requests from lower priority queues; among requests of the same
+ * queue requests are served according to B-WF2Q+.
+ * All the fields are protected by the queue lock of the containing bfqd.
+ */
+struct bfq_sched_data {
+	/* entity in service */
+	struct bfq_entity *in_service_entity;
+	/* head-of-line entity (see comments above) */
+	struct bfq_entity *next_in_service;
+	/* array of service trees, one per ioprio_class */
+	struct bfq_service_tree service_tree[BFQ_IOPRIO_CLASSES];
+	/* last time CLASS_IDLE was served */
+	unsigned long bfq_class_idle_last_service;
+
+};
+
+/**
+ * struct bfq_weight_counter - counter of the number of all active entities
+ *                             with a given weight.
+ */
+struct bfq_weight_counter {
+	unsigned int weight; /* weight of the entities this counter refers to */
+	unsigned int num_active; /* nr of active entities with this weight */
+	/*
+	 * Weights tree member (see bfq_data's @queue_weights_tree and
+	 * @group_weights_tree)
+	 */
+	struct rb_node weights_node;
+};
+
+/**
+ * struct bfq_entity - schedulable entity.
+ *
+ * A bfq_entity is used to represent either a bfq_queue (leaf node in the
+ * cgroup hierarchy) or a bfq_group into the upper level scheduler.  Each
+ * entity belongs to the sched_data of the parent group in the cgroup
+ * hierarchy.  Non-leaf entities have also their own sched_data, stored
+ * in @my_sched_data.
+ *
+ * Each entity stores independently its priority values; this would
+ * allow different weights on different devices, but this
+ * functionality is not exported to userspace by now.  Priorities and
+ * weights are updated lazily, first storing the new values into the
+ * new_* fields, then setting the @prio_changed flag.  As soon as
+ * there is a transition in the entity state that allows the priority
+ * update to take place the effective and the requested priority
+ * values are synchronized.
+ *
+ * Unless cgroups are used, the weight value is calculated from the
+ * ioprio to export the same interface as CFQ.  When dealing with
+ * ``well-behaved'' queues (i.e., queues that do not spend too much
+ * time to consume their budget and have true sequential behavior, and
+ * when there are no external factors breaking anticipation) the
+ * relative weights at each level of the cgroups hierarchy should be
+ * guaranteed.  All the fields are protected by the queue lock of the
+ * containing bfqd.
+ */
+struct bfq_entity {
+	/* service_tree member */
+	struct rb_node rb_node;
+	/* pointer to the weight counter associated with this entity */
+	struct bfq_weight_counter *weight_counter;
+
+	/*
+	 * Flag, true if the entity is on a tree (either the active or
+	 * the idle one of its service_tree) or is in service.
+	 */
+	bool on_st;
+
+	/* B-WF2Q+ start and finish timestamps [sectors/weight] */
+	u64 start, finish;
+
+	/* tree the entity is enqueued into; %NULL if not on a tree */
+	struct rb_root *tree;
+
+	/*
+	 * minimum start time of the (active) subtree rooted at this
+	 * entity; used for O(log N) lookups into active trees
+	 */
+	u64 min_start;
+
+	/* amount of service received during the last service slot */
+	int service;
+
+	/* budget, used also to calculate F_i: F_i = S_i + @budget / @weight */
+	int budget;
+
+	/* weight of the queue */
+	int weight;
+	/* next weight if a change is in progress */
+	int new_weight;
+
+	/* original weight, used to implement weight boosting */
+	int orig_weight;
+
+	/* parent entity, for hierarchical scheduling */
+	struct bfq_entity *parent;
+
+	/*
+	 * For non-leaf nodes in the hierarchy, the associated
+	 * scheduler queue, %NULL on leaf nodes.
+	 */
+	struct bfq_sched_data *my_sched_data;
+	/* the scheduler queue this entity belongs to */
+	struct bfq_sched_data *sched_data;
+
+	/* flag, set to request a weight, ioprio or ioprio_class change  */
+	int prio_changed;
+};
+
+struct bfq_group;
+
+/**
+ * struct bfq_ttime - per process thinktime stats.
+ */
+struct bfq_ttime {
+	/* completion time of the last request */
+	u64 last_end_request;
+
+	/* total process thinktime */
+	u64 ttime_total;
+	/* number of thinktime samples */
+	unsigned long ttime_samples;
+	/* average process thinktime */
+	u64 ttime_mean;
+};
+
+/**
+ * struct bfq_queue - leaf schedulable entity.
+ *
+ * A bfq_queue is a leaf request queue; it can be associated with an
+ * io_context or more, if it  is  async or shared  between  cooperating
+ * processes. @cgroup holds a reference to the cgroup, to be sure that it
+ * does not disappear while a bfqq still references it (mostly to avoid
+ * races between request issuing and task migration followed by cgroup
+ * destruction).
+ * All the fields are protected by the queue lock of the containing bfqd.
+ */
+struct bfq_queue {
+	/* reference counter */
+	int ref;
+	/* parent bfq_data */
+	struct bfq_data *bfqd;
+
+	/* current ioprio and ioprio class */
+	unsigned short ioprio, ioprio_class;
+	/* next ioprio and ioprio class if a change is in progress */
+	unsigned short new_ioprio, new_ioprio_class;
+
+	/*
+	 * Shared bfq_queue if queue is cooperating with one or more
+	 * other queues.
+	 */
+	struct bfq_queue *new_bfqq;
+	/* request-position tree member (see bfq_group's @rq_pos_tree) */
+	struct rb_node pos_node;
+	/* request-position tree root (see bfq_group's @rq_pos_tree) */
+	struct rb_root *pos_root;
+
+	/* sorted list of pending requests */
+	struct rb_root sort_list;
+	/* if fifo isn't expired, next request to serve */
+	struct request *next_rq;
+	/* number of sync and async requests queued */
+	int queued[2];
+	/* number of requests currently allocated */
+	int allocated;
+	/* number of pending metadata requests */
+	int meta_pending;
+	/* fifo list of requests in sort_list */
+	struct list_head fifo;
+
+	/* entity representing this queue in the scheduler */
+	struct bfq_entity entity;
+
+	/* maximum budget allowed from the feedback mechanism */
+	int max_budget;
+	/* budget expiration (in jiffies) */
+	unsigned long budget_timeout;
+
+	/* number of requests on the dispatch list or inside driver */
+	int dispatched;
+
+	/* status flags */
+	unsigned long flags;
+
+	/* node for active/idle bfqq list inside parent bfqd */
+	struct list_head bfqq_list;
+
+	/* associated @bfq_ttime struct */
+	struct bfq_ttime ttime;
+
+	/* bit vector: a 1 for each seeky requests in history */
+	u32 seek_history;
+
+	/* node for the device's burst list */
+	struct hlist_node burst_list_node;
+
+	/* position of the last request enqueued */
+	sector_t last_request_pos;
+
+	/* Number of consecutive pairs of request completion and
+	 * arrival, such that the queue becomes idle after the
+	 * completion, but the next request arrives within an idle
+	 * time slice; used only if the queue's IO_bound flag has been
+	 * cleared.
+	 */
+	unsigned int requests_within_timer;
+
+	/* pid of the process owning the queue, used for logging purposes */
+	pid_t pid;
+
+	/*
+	 * Pointer to the bfq_io_cq owning the bfq_queue, set to %NULL
+	 * if the queue is shared.
+	 */
+	struct bfq_io_cq *bic;
+
+	/* current maximum weight-raising time for this queue */
+	unsigned long wr_cur_max_time;
+	/*
+	 * Minimum time instant such that, only if a new request is
+	 * enqueued after this time instant in an idle @bfq_queue with
+	 * no outstanding requests, then the task associated with the
+	 * queue it is deemed as soft real-time (see the comments on
+	 * the function bfq_bfqq_softrt_next_start())
+	 */
+	unsigned long soft_rt_next_start;
+	/*
+	 * Start time of the current weight-raising period if
+	 * the @bfq-queue is being weight-raised, otherwise
+	 * finish time of the last weight-raising period.
+	 */
+	unsigned long last_wr_start_finish;
+	/* factor by which the weight of this queue is multiplied */
+	unsigned int wr_coeff;
+	/*
+	 * Time of the last transition of the @bfq_queue from idle to
+	 * backlogged.
+	 */
+	unsigned long last_idle_bklogged;
+	/*
+	 * Cumulative service received from the @bfq_queue since the
+	 * last transition from idle to backlogged.
+	 */
+	unsigned long service_from_backlogged;
+
+	/*
+	 * Value of wr start time when switching to soft rt
+	 */
+	unsigned long wr_start_at_switch_to_srt;
+
+	unsigned long split_time; /* time of last split */
+};
+
+/**
+ * struct bfq_io_cq - per (request_queue, io_context) structure.
+ */
+struct bfq_io_cq {
+	/* associated io_cq structure */
+	struct io_cq icq; /* must be the first member */
+	/* array of two process queues, the sync and the async */
+	struct bfq_queue *bfqq[2];
+	/* per (request_queue, blkcg) ioprio */
+	int ioprio;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	uint64_t blkcg_serial_nr; /* the current blkcg serial */
+#endif
+	/*
+	 * Snapshot of the idle window before merging; taken to
+	 * remember this value while the queue is merged, so as to be
+	 * able to restore it in case of split.
+	 */
+	bool saved_idle_window;
+	/*
+	 * Same purpose as the previous two fields for the I/O bound
+	 * classification of a queue.
+	 */
+	bool saved_IO_bound;
+
+	/*
+	 * Same purpose as the previous fields for the value of the
+	 * field keeping the queue's belonging to a large burst
+	 */
+	bool saved_in_large_burst;
+	/*
+	 * True if the queue belonged to a burst list before its merge
+	 * with another cooperating queue.
+	 */
+	bool was_in_burst_list;
+
+	/*
+	 * Similar to previous fields: save wr information.
+	 */
+	unsigned long saved_wr_coeff;
+	unsigned long saved_last_wr_start_finish;
+	unsigned long saved_wr_start_at_switch_to_srt;
+	unsigned int saved_wr_cur_max_time;
+	struct bfq_ttime saved_ttime;
+};
+
+enum bfq_device_speed {
+	BFQ_BFQD_FAST,
+	BFQ_BFQD_SLOW,
+};
+
+/**
+ * struct bfq_data - per-device data structure.
+ *
+ * All the fields are protected by @lock.
+ */
+struct bfq_data {
+	/* device request queue */
+	struct request_queue *queue;
+	/* dispatch queue */
+	struct list_head dispatch;
+
+	/* root bfq_group for the device */
+	struct bfq_group *root_group;
+
+	/*
+	 * rbtree of weight counters of @bfq_queues, sorted by
+	 * weight. Used to keep track of whether all @bfq_queues have
+	 * the same weight. The tree contains one counter for each
+	 * distinct weight associated to some active and not
+	 * weight-raised @bfq_queue (see the comments to the functions
+	 * bfq_weights_tree_[add|remove] for further details).
+	 */
+	struct rb_root queue_weights_tree;
+	/*
+	 * rbtree of non-queue @bfq_entity weight counters, sorted by
+	 * weight. Used to keep track of whether all @bfq_groups have
+	 * the same weight. The tree contains one counter for each
+	 * distinct weight associated to some active @bfq_group (see
+	 * the comments to the functions bfq_weights_tree_[add|remove]
+	 * for further details).
+	 */
+	struct rb_root group_weights_tree;
+
+	/*
+	 * Number of bfq_queues containing requests (including the
+	 * queue in service, even if it is idling).
+	 */
+	int busy_queues;
+	/* number of weight-raised busy @bfq_queues */
+	int wr_busy_queues;
+	/* number of queued requests */
+	int queued;
+	/* number of requests dispatched and waiting for completion */
+	int rq_in_driver;
+
+	/*
+	 * Maximum number of requests in driver in the last
+	 * @hw_tag_samples completed requests.
+	 */
+	int max_rq_in_driver;
+	/* number of samples used to calculate hw_tag */
+	int hw_tag_samples;
+	/* flag set to one if the driver is showing a queueing behavior */
+	int hw_tag;
+
+	/* number of budgets assigned */
+	int budgets_assigned;
+
+	/*
+	 * Timer set when idling (waiting) for the next request from
+	 * the queue in service.
+	 */
+	struct hrtimer idle_slice_timer;
+
+	/* bfq_queue in service */
+	struct bfq_queue *in_service_queue;
+
+	/* on-disk position of the last served request */
+	sector_t last_position;
+
+	/* time of last request completion (ns) */
+	u64 last_completion;
+
+	/* time of first rq dispatch in current observation interval (ns) */
+	u64 first_dispatch;
+	/* time of last rq dispatch in current observation interval (ns) */
+	u64 last_dispatch;
+
+	/* beginning of the last budget */
+	ktime_t last_budget_start;
+	/* beginning of the last idle slice */
+	ktime_t last_idling_start;
+
+	/* number of samples in current observation interval */
+	int peak_rate_samples;
+	/* num of samples of seq dispatches in current observation interval */
+	u32 sequential_samples;
+	/* total num of sectors transferred in current observation interval */
+	u64 tot_sectors_dispatched;
+	/* max rq size seen during current observation interval (sectors) */
+	u32 last_rq_max_size;
+	/* time elapsed from first dispatch in current observ. interval (us) */
+	u64 delta_from_first;
+	/*
+	 * Current estimate of the device peak rate, measured in
+	 * [BFQ_RATE_SHIFT * sectors/usec]. The left-shift by
+	 * BFQ_RATE_SHIFT is performed to increase precision in
+	 * fixed-point calculations.
+	 */
+	u32 peak_rate;
+
+	/* maximum budget allotted to a bfq_queue before rescheduling */
+	int bfq_max_budget;
+
+	/* list of all the bfq_queues active on the device */
+	struct list_head active_list;
+	/* list of all the bfq_queues idle on the device */
+	struct list_head idle_list;
+
+	/*
+	 * Timeout for async/sync requests; when it fires, requests
+	 * are served in fifo order.
+	 */
+	u64 bfq_fifo_expire[2];
+	/* weight of backward seeks wrt forward ones */
+	unsigned int bfq_back_penalty;
+	/* maximum allowed backward seek */
+	unsigned int bfq_back_max;
+	/* maximum idling time */
+	u32 bfq_slice_idle;
+
+	/* user-configured max budget value (0 for auto-tuning) */
+	int bfq_user_max_budget;
+	/*
+	 * Timeout for bfq_queues to consume their budget; used to
+	 * prevent seeky queues from imposing long latencies to
+	 * sequential or quasi-sequential ones (this also implies that
+	 * seeky queues cannot receive guarantees in the service
+	 * domain; after a timeout they are charged for the time they
+	 * have been in service, to preserve fairness among them, but
+	 * without service-domain guarantees).
+	 */
+	unsigned int bfq_timeout;
+
+	/*
+	 * Number of consecutive requests that must be issued within
+	 * the idle time slice to set again idling to a queue which
+	 * was marked as non-I/O-bound (see the definition of the
+	 * IO_bound flag for further details).
+	 */
+	unsigned int bfq_requests_within_timer;
+
+	/*
+	 * Force device idling whenever needed to provide accurate
+	 * service guarantees, without caring about throughput
+	 * issues. CAVEAT: this may even increase latencies, in case
+	 * of useless idling for processes that did stop doing I/O.
+	 */
+	bool strict_guarantees;
+
+	/*
+	 * Last time at which a queue entered the current burst of
+	 * queues being activated shortly after each other; for more
+	 * details about this and the following parameters related to
+	 * a burst of activations, see the comments on the function
+	 * bfq_handle_burst.
+	 */
+	unsigned long last_ins_in_burst;
+	/*
+	 * Reference time interval used to decide whether a queue has
+	 * been activated shortly after @last_ins_in_burst.
+	 */
+	unsigned long bfq_burst_interval;
+	/* number of queues in the current burst of queue activations */
+	int burst_size;
+
+	/* common parent entity for the queues in the burst */
+	struct bfq_entity *burst_parent_entity;
+	/* Maximum burst size above which the current queue-activation
+	 * burst is deemed as 'large'.
+	 */
+	unsigned long bfq_large_burst_thresh;
+	/* true if a large queue-activation burst is in progress */
+	bool large_burst;
+	/*
+	 * Head of the burst list (as for the above fields, more
+	 * details in the comments on the function bfq_handle_burst).
+	 */
+	struct hlist_head burst_list;
+
+	/* if set to true, low-latency heuristics are enabled */
+	bool low_latency;
+	/*
+	 * Maximum factor by which the weight of a weight-raised queue
+	 * is multiplied.
+	 */
+	unsigned int bfq_wr_coeff;
+	/* maximum duration of a weight-raising period (jiffies) */
+	unsigned int bfq_wr_max_time;
+
+	/* Maximum weight-raising duration for soft real-time processes */
+	unsigned int bfq_wr_rt_max_time;
+	/*
+	 * Minimum idle period after which weight-raising may be
+	 * reactivated for a queue (in jiffies).
+	 */
+	unsigned int bfq_wr_min_idle_time;
+	/*
+	 * Minimum period between request arrivals after which
+	 * weight-raising may be reactivated for an already busy async
+	 * queue (in jiffies).
+	 */
+	unsigned long bfq_wr_min_inter_arr_async;
+
+	/* Max service-rate for a soft real-time queue, in sectors/sec */
+	unsigned int bfq_wr_max_softrt_rate;
+	/*
+	 * Cached value of the product R*T, used for computing the
+	 * maximum duration of weight raising automatically.
+	 */
+	u64 RT_prod;
+	/* device-speed class for the low-latency heuristic */
+	enum bfq_device_speed device_speed;
+
+	/* fallback dummy bfqq for extreme OOM conditions */
+	struct bfq_queue oom_bfqq;
+
+	spinlock_t lock;
+
+	/*
+	 * bic associated with the task issuing current bio for
+	 * merging. This and the next field are used as a support to
+	 * be able to perform the bic lookup, needed by bio-merge
+	 * functions, before the scheduler lock is taken, and thus
+	 * avoid taking the request-queue lock while the scheduler
+	 * lock is being held.
+	 */
+	struct bfq_io_cq *bio_bic;
+	/* bfqq associated with the task issuing current bio for merging */
+	struct bfq_queue *bio_bfqq;
+};
+
+enum bfqq_state_flags {
+	BFQQF_just_created = 0,	/* queue just allocated */
+	BFQQF_busy,		/* has requests or is in service */
+	BFQQF_wait_request,	/* waiting for a request */
+	BFQQF_non_blocking_wait_rq, /*
+				     * waiting for a request
+				     * without idling the device
+				     */
+	BFQQF_fifo_expire,	/* FIFO checked in this slice */
+	BFQQF_idle_window,	/* slice idling enabled */
+	BFQQF_sync,		/* synchronous queue */
+	BFQQF_IO_bound,		/*
+				 * bfqq has timed-out at least once
+				 * having consumed at most 2/10 of
+				 * its budget
+				 */
+	BFQQF_in_large_burst,	/*
+				 * bfqq activated in a large burst,
+				 * see comments to bfq_handle_burst.
+				 */
+	BFQQF_softrt_update,	/*
+				 * may need softrt-next-start
+				 * update
+				 */
+	BFQQF_coop,		/* bfqq is shared */
+	BFQQF_split_coop	/* shared bfqq will be split */
+};
+
+#define BFQ_BFQQ_FNS(name)						\
+void bfq_mark_bfqq_##name(struct bfq_queue *bfqq);			\
+void bfq_clear_bfqq_##name(struct bfq_queue *bfqq);			\
+int bfq_bfqq_##name(const struct bfq_queue *bfqq);
+
+BFQ_BFQQ_FNS(just_created);
+BFQ_BFQQ_FNS(busy);
+BFQ_BFQQ_FNS(wait_request);
+BFQ_BFQQ_FNS(non_blocking_wait_rq);
+BFQ_BFQQ_FNS(fifo_expire);
+BFQ_BFQQ_FNS(idle_window);
+BFQ_BFQQ_FNS(sync);
+BFQ_BFQQ_FNS(IO_bound);
+BFQ_BFQQ_FNS(in_large_burst);
+BFQ_BFQQ_FNS(coop);
+BFQ_BFQQ_FNS(split_coop);
+BFQ_BFQQ_FNS(softrt_update);
+#undef BFQ_BFQQ_FNS
+
+/* Expiration reasons. */
+enum bfqq_expiration {
+	BFQQE_TOO_IDLE = 0,		/*
+					 * queue has been idling for
+					 * too long
+					 */
+	BFQQE_BUDGET_TIMEOUT,	/* budget took too long to be used */
+	BFQQE_BUDGET_EXHAUSTED,	/* budget consumed */
+	BFQQE_NO_MORE_REQUESTS,	/* the queue has no more requests */
+	BFQQE_PREEMPTED		/* preemption in progress */
+};
+
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
+	unsigned int weight;
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
+ * @active_entities: number of active entities belonging to the group;
+ *                   unused for the root group. Used to know whether there
+ *                   are groups with more than one active @bfq_entity
+ *                   (see the comments to the function
+ *                   bfq_bfqq_may_idle()).
+ * @rq_pos_tree: rbtree sorted by next_request position, used when
+ *               determining if two or more queues have interleaving
+ *               requests (see bfq_find_close_cooperator()).
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
+	int active_entities;
+
+	struct rb_root rq_pos_tree;
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
+struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+
+/* --------------- main algorithm interface ----------------- */
+
+#define BFQ_SERVICE_TREE_INIT	((struct bfq_service_tree)		\
+				{ RB_ROOT, RB_ROOT, NULL, NULL, 0, 0 })
+
+extern const int bfq_timeout;
+
+struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync);
+void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync);
+struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic);
+void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void bfq_weights_tree_add(struct bfq_data *bfqd, struct bfq_entity *entity,
+			  struct rb_root *root);
+void bfq_weights_tree_remove(struct bfq_data *bfqd, struct bfq_entity *entity,
+			     struct rb_root *root);
+void bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+		     bool compensate, enum bfqq_expiration reason);
+void bfq_put_queue(struct bfq_queue *bfqq);
+void bfq_end_wr_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
+void bfq_schedule_dispatch(struct bfq_data *bfqd);
+void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
+
+/* ------------ end of main algorithm interface -------------- */
+
+/* ---------------- cgroups-support interface ---------------- */
+
+extern struct cftype bfq_blkcg_legacy_files[];
+extern struct cftype bfq_blkg_files[];
+
+void bfqg_stats_update_io_add(struct bfq_group *bfqg, struct bfq_queue *bfqq,
+			      unsigned int op);
+void bfqg_stats_update_io_remove(struct bfq_group *bfqg, unsigned int op);
+void bfqg_stats_update_io_merged(struct bfq_group *bfqg, unsigned int op);
+void bfqg_stats_update_completion(struct bfq_group *bfqg, uint64_t start_time,
+				  uint64_t io_start_time, unsigned int op);
+void bfqg_stats_update_dequeue(struct bfq_group *bfqg);
+void bfqg_stats_set_start_empty_time(struct bfq_group *bfqg);
+void bfqg_stats_update_idle_time(struct bfq_group *bfqg);
+void bfqg_stats_set_start_idle_time(struct bfq_group *bfqg);
+void bfqg_stats_update_avg_queue_size(struct bfq_group *bfqg);
+void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+		   struct bfq_group *bfqg);
+
+void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg);
+void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio);
+void bfq_end_wr_async(struct bfq_data *bfqd);
+struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
+				     struct blkcg *blkcg);
+struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
+struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
+struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
+void bfqg_put(struct bfq_group *bfqg);
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+extern struct blkcg_policy blkcg_policy_bfq;
+#endif
+
+/* ------------- end of cgroups-support interface ------------- */
+
+/* - interface of the internal hierarchical B-WF2Q+ scheduler - */
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+/* both next loops stop at one of the child entities of the root group */
+#define for_each_entity(entity)	\
+	for (; entity ; entity = entity->parent)
+
+/*
+ * For each iteration, compute parent in advance, so as to be safe if
+ * entity is deallocated during the iteration. Such a deallocation may
+ * happen as a consequence of a bfq_put_queue that frees the bfq_queue
+ * containing entity.
+ */
+#define for_each_entity_safe(entity, parent) \
+	for (; entity && ({ parent = entity->parent; 1; }); entity = parent)
+
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
+#endif /* CONFIG_BFQ_GROUP_IOSCHED */
+
+struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq);
+struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity);
+struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity *entity);
+struct bfq_entity *bfq_entity_of(struct rb_node *node);
+unsigned short bfq_ioprio_to_weight(int ioprio);
+void bfq_put_idle_entity(struct bfq_service_tree *st,
+			 struct bfq_entity *entity);
+struct bfq_service_tree *
+__bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
+				struct bfq_entity *entity);
+void bfq_bfqq_served(struct bfq_queue *bfqq, int served);
+void bfq_bfqq_charge_time(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			  unsigned long time_ms);
+bool __bfq_deactivate_entity(struct bfq_entity *entity,
+			     bool ins_into_idle_tree);
+bool next_queue_may_preempt(struct bfq_data *bfqd);
+struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd);
+void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd);
+void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			 bool ins_into_idle_tree, bool expiration);
+void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+		       bool expiration);
+void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq);
+
+/* --------------- end of interface of B-WF2Q+ ---------------- */
+
+/* Logging facilities. */
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
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
+
+#define bfq_log(bfqd, fmt, args...) \
+	blk_add_trace_msg((bfqd)->queue, "bfq " fmt, ##args)
+
+#endif /* _BFQ_H */
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
new file mode 100644
index 0000000..b4fc3e4
--- /dev/null
+++ b/block/bfq-wf2q.c
@@ -0,0 +1,1616 @@
+/*
+ * Hierarchical Budget Worst-case Fair Weighted Fair Queueing
+ * (B-WF2Q+): hierarchical scheduling algorithm by which the BFQ I/O
+ * scheduler schedules generic entities. The latter can represent
+ * either single bfq queues (associated with processes) or groups of
+ * bfq queues (associated with cgroups).
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License as
+ *  published by the Free Software Foundation; either version 2 of the
+ *  License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ */
+#include "bfq-iosched.h"
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
+static unsigned int bfq_class_idx(struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	return bfqq ? bfqq->ioprio_class - 1 :
+		BFQ_DEFAULT_GRP_CLASS - 1;
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
+ */
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
+
+struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
+{
+	struct bfq_entity *group_entity = bfqq->entity.parent;
+
+	if (!group_entity)
+		group_entity = &bfqq->bfqd->root_group->entity;
+
+	return container_of(group_entity, struct bfq_group, entity);
+}
+
+/*
+ * Returns true if this budget changes may let next_in_service->parent
+ * become the next_in_service entity for its parent entity.
+ */
+static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
+{
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
+ *
+ * In contrast, the entity could stil be a candidate for next service
+ * if it is not a queue, and has more than one child. In fact, even if
+ * one of its children is about to be set in service, other children
+ * may still be the next to serve. As a consequence, a non-queue
+ * entity is not a candidate for next-service only if it has only one
+ * child. And only if this condition holds, then the function returns
+ * true for a non-queue entity.
+ */
+static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
+{
+	struct bfq_group *bfqg;
+
+	if (bfq_entity_to_bfqq(entity))
+		return true;
+
+	bfqg = container_of(entity, struct bfq_group, entity);
+
+	if (bfqg->active_entities == 1)
+		return true;
+
+	return false;
+}
+
+#else /* CONFIG_BFQ_GROUP_IOSCHED */
+
+struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
+{
+	return bfqq->bfqd->root_group;
+}
+
+static bool bfq_update_parent_budget(struct bfq_entity *next_in_service)
+{
+	return false;
+}
+
+static bool bfq_no_longer_next_in_service(struct bfq_entity *entity)
+{
+	return true;
+}
+
+#endif /* CONFIG_BFQ_GROUP_IOSCHED */
+
+/*
+ * Shift for timestamp calculations.  This actually limits the maximum
+ * service allowed in one timestamp delta (small shift values increase it),
+ * the maximum total weight that can be used for the queues in the system
+ * (big shift values increase it), and the period of virtual time
+ * wraparounds.
+ */
+#define WFQ_SERVICE_SHIFT	22
+
+struct bfq_queue *bfq_entity_to_bfqq(struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = NULL;
+
+	if (!entity->my_sched_data)
+		bfqq = container_of(entity, struct bfq_queue, entity);
+
+	return bfqq;
+}
+
+
+/**
+ * bfq_delta - map service into the virtual time domain.
+ * @service: amount of service.
+ * @weight: scale factor (weight of an entity or weight sum).
+ */
+static u64 bfq_delta(unsigned long service, unsigned long weight)
+{
+	u64 d = (u64)service << WFQ_SERVICE_SHIFT;
+
+	do_div(d, weight);
+	return d;
+}
+
+/**
+ * bfq_calc_finish - assign the finish time to an entity.
+ * @entity: the entity to act upon.
+ * @service: the service to be charged to the entity.
+ */
+static void bfq_calc_finish(struct bfq_entity *entity, unsigned long service)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	entity->finish = entity->start +
+		bfq_delta(service, entity->weight);
+
+	if (bfqq) {
+		bfq_log_bfqq(bfqq->bfqd, bfqq,
+			"calc_finish: serv %lu, w %d",
+			service, entity->weight);
+		bfq_log_bfqq(bfqq->bfqd, bfqq,
+			"calc_finish: start %llu, finish %llu, delta %llu",
+			entity->start, entity->finish,
+			bfq_delta(service, entity->weight));
+	}
+}
+
+/**
+ * bfq_entity_of - get an entity from a node.
+ * @node: the node field of the entity.
+ *
+ * Convert a node pointer to the relative entity.  This is used only
+ * to simplify the logic of some functions and not as the generic
+ * conversion mechanism because, e.g., in the tree walking functions,
+ * the check for a %NULL value would be redundant.
+ */
+struct bfq_entity *bfq_entity_of(struct rb_node *node)
+{
+	struct bfq_entity *entity = NULL;
+
+	if (node)
+		entity = rb_entry(node, struct bfq_entity, rb_node);
+
+	return entity;
+}
+
+/**
+ * bfq_extract - remove an entity from a tree.
+ * @root: the tree root.
+ * @entity: the entity to remove.
+ */
+static void bfq_extract(struct rb_root *root, struct bfq_entity *entity)
+{
+	entity->tree = NULL;
+	rb_erase(&entity->rb_node, root);
+}
+
+/**
+ * bfq_idle_extract - extract an entity from the idle tree.
+ * @st: the service tree of the owning @entity.
+ * @entity: the entity being removed.
+ */
+static void bfq_idle_extract(struct bfq_service_tree *st,
+			     struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct rb_node *next;
+
+	if (entity == st->first_idle) {
+		next = rb_next(&entity->rb_node);
+		st->first_idle = bfq_entity_of(next);
+	}
+
+	if (entity == st->last_idle) {
+		next = rb_prev(&entity->rb_node);
+		st->last_idle = bfq_entity_of(next);
+	}
+
+	bfq_extract(&st->idle, entity);
+
+	if (bfqq)
+		list_del(&bfqq->bfqq_list);
+}
+
+/**
+ * bfq_insert - generic tree insertion.
+ * @root: tree root.
+ * @entity: entity to insert.
+ *
+ * This is used for the idle and the active tree, since they are both
+ * ordered by finish time.
+ */
+static void bfq_insert(struct rb_root *root, struct bfq_entity *entity)
+{
+	struct bfq_entity *entry;
+	struct rb_node **node = &root->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*node) {
+		parent = *node;
+		entry = rb_entry(parent, struct bfq_entity, rb_node);
+
+		if (bfq_gt(entry->finish, entity->finish))
+			node = &parent->rb_left;
+		else
+			node = &parent->rb_right;
+	}
+
+	rb_link_node(&entity->rb_node, parent, node);
+	rb_insert_color(&entity->rb_node, root);
+
+	entity->tree = root;
+}
+
+/**
+ * bfq_update_min - update the min_start field of a entity.
+ * @entity: the entity to update.
+ * @node: one of its children.
+ *
+ * This function is called when @entity may store an invalid value for
+ * min_start due to updates to the active tree.  The function  assumes
+ * that the subtree rooted at @node (which may be its left or its right
+ * child) has a valid min_start value.
+ */
+static void bfq_update_min(struct bfq_entity *entity, struct rb_node *node)
+{
+	struct bfq_entity *child;
+
+	if (node) {
+		child = rb_entry(node, struct bfq_entity, rb_node);
+		if (bfq_gt(entity->min_start, child->min_start))
+			entity->min_start = child->min_start;
+	}
+}
+
+/**
+ * bfq_update_active_node - recalculate min_start.
+ * @node: the node to update.
+ *
+ * @node may have changed position or one of its children may have moved,
+ * this function updates its min_start value.  The left and right subtrees
+ * are assumed to hold a correct min_start value.
+ */
+static void bfq_update_active_node(struct rb_node *node)
+{
+	struct bfq_entity *entity = rb_entry(node, struct bfq_entity, rb_node);
+
+	entity->min_start = entity->start;
+	bfq_update_min(entity, node->rb_right);
+	bfq_update_min(entity, node->rb_left);
+}
+
+/**
+ * bfq_update_active_tree - update min_start for the whole active tree.
+ * @node: the starting node.
+ *
+ * @node must be the deepest modified node after an update.  This function
+ * updates its min_start using the values held by its children, assuming
+ * that they did not change, and then updates all the nodes that may have
+ * changed in the path to the root.  The only nodes that may have changed
+ * are the ones in the path or their siblings.
+ */
+static void bfq_update_active_tree(struct rb_node *node)
+{
+	struct rb_node *parent;
+
+up:
+	bfq_update_active_node(node);
+
+	parent = rb_parent(node);
+	if (!parent)
+		return;
+
+	if (node == parent->rb_left && parent->rb_right)
+		bfq_update_active_node(parent->rb_right);
+	else if (parent->rb_left)
+		bfq_update_active_node(parent->rb_left);
+
+	node = parent;
+	goto up;
+}
+
+/**
+ * bfq_active_insert - insert an entity in the active tree of its
+ *                     group/device.
+ * @st: the service tree of the entity.
+ * @entity: the entity being inserted.
+ *
+ * The active tree is ordered by finish time, but an extra key is kept
+ * per each node, containing the minimum value for the start times of
+ * its children (and the node itself), so it's possible to search for
+ * the eligible node with the lowest finish time in logarithmic time.
+ */
+static void bfq_active_insert(struct bfq_service_tree *st,
+			      struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct rb_node *node = &entity->rb_node;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_sched_data *sd = NULL;
+	struct bfq_group *bfqg = NULL;
+	struct bfq_data *bfqd = NULL;
+#endif
+
+	bfq_insert(&st->active, entity);
+
+	if (node->rb_left)
+		node = node->rb_left;
+	else if (node->rb_right)
+		node = node->rb_right;
+
+	bfq_update_active_tree(node);
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	sd = entity->sched_data;
+	bfqg = container_of(sd, struct bfq_group, sched_data);
+	bfqd = (struct bfq_data *)bfqg->bfqd;
+#endif
+	if (bfqq)
+		list_add(&bfqq->bfqq_list, &bfqq->bfqd->active_list);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	else /* bfq_group */
+		bfq_weights_tree_add(bfqd, entity, &bfqd->group_weights_tree);
+
+	if (bfqg != bfqd->root_group)
+		bfqg->active_entities++;
+#endif
+}
+
+/**
+ * bfq_ioprio_to_weight - calc a weight from an ioprio.
+ * @ioprio: the ioprio value to convert.
+ */
+unsigned short bfq_ioprio_to_weight(int ioprio)
+{
+	return (IOPRIO_BE_NR - ioprio) * BFQ_WEIGHT_CONVERSION_COEFF;
+}
+
+/**
+ * bfq_weight_to_ioprio - calc an ioprio from a weight.
+ * @weight: the weight value to convert.
+ *
+ * To preserve as much as possible the old only-ioprio user interface,
+ * 0 is used as an escape ioprio value for weights (numerically) equal or
+ * larger than IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF.
+ */
+static unsigned short bfq_weight_to_ioprio(int weight)
+{
+	return max_t(int, 0,
+		     IOPRIO_BE_NR * BFQ_WEIGHT_CONVERSION_COEFF - weight);
+}
+
+static void bfq_get_entity(struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	if (bfqq) {
+		bfqq->ref++;
+		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
+			     bfqq, bfqq->ref);
+	}
+}
+
+/**
+ * bfq_find_deepest - find the deepest node that an extraction can modify.
+ * @node: the node being removed.
+ *
+ * Do the first step of an extraction in an rb tree, looking for the
+ * node that will replace @node, and returning the deepest node that
+ * the following modifications to the tree can touch.  If @node is the
+ * last node in the tree return %NULL.
+ */
+static struct rb_node *bfq_find_deepest(struct rb_node *node)
+{
+	struct rb_node *deepest;
+
+	if (!node->rb_right && !node->rb_left)
+		deepest = rb_parent(node);
+	else if (!node->rb_right)
+		deepest = node->rb_left;
+	else if (!node->rb_left)
+		deepest = node->rb_right;
+	else {
+		deepest = rb_next(node);
+		if (deepest->rb_right)
+			deepest = deepest->rb_right;
+		else if (rb_parent(deepest) != node)
+			deepest = rb_parent(deepest);
+	}
+
+	return deepest;
+}
+
+/**
+ * bfq_active_extract - remove an entity from the active tree.
+ * @st: the service_tree containing the tree.
+ * @entity: the entity being removed.
+ */
+static void bfq_active_extract(struct bfq_service_tree *st,
+			       struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct rb_node *node;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_sched_data *sd = NULL;
+	struct bfq_group *bfqg = NULL;
+	struct bfq_data *bfqd = NULL;
+#endif
+
+	node = bfq_find_deepest(&entity->rb_node);
+	bfq_extract(&st->active, entity);
+
+	if (node)
+		bfq_update_active_tree(node);
+
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	sd = entity->sched_data;
+	bfqg = container_of(sd, struct bfq_group, sched_data);
+	bfqd = (struct bfq_data *)bfqg->bfqd;
+#endif
+	if (bfqq)
+		list_del(&bfqq->bfqq_list);
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	else /* bfq_group */
+		bfq_weights_tree_remove(bfqd, entity,
+					&bfqd->group_weights_tree);
+
+	if (bfqg != bfqd->root_group)
+		bfqg->active_entities--;
+#endif
+}
+
+/**
+ * bfq_idle_insert - insert an entity into the idle tree.
+ * @st: the service tree containing the tree.
+ * @entity: the entity to insert.
+ */
+static void bfq_idle_insert(struct bfq_service_tree *st,
+			    struct bfq_entity *entity)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+	struct bfq_entity *first_idle = st->first_idle;
+	struct bfq_entity *last_idle = st->last_idle;
+
+	if (!first_idle || bfq_gt(first_idle->finish, entity->finish))
+		st->first_idle = entity;
+	if (!last_idle || bfq_gt(entity->finish, last_idle->finish))
+		st->last_idle = entity;
+
+	bfq_insert(&st->idle, entity);
+
+	if (bfqq)
+		list_add(&bfqq->bfqq_list, &bfqq->bfqd->idle_list);
+}
+
+/**
+ * bfq_forget_entity - do not consider entity any longer for scheduling
+ * @st: the service tree.
+ * @entity: the entity being removed.
+ * @is_in_service: true if entity is currently the in-service entity.
+ *
+ * Forget everything about @entity. In addition, if entity represents
+ * a queue, and the latter is not in service, then release the service
+ * reference to the queue (the one taken through bfq_get_entity). In
+ * fact, in this case, there is really no more service reference to
+ * the queue, as the latter is also outside any service tree. If,
+ * instead, the queue is in service, then __bfq_bfqd_reset_in_service
+ * will take care of putting the reference when the queue finally
+ * stops being served.
+ */
+static void bfq_forget_entity(struct bfq_service_tree *st,
+			      struct bfq_entity *entity,
+			      bool is_in_service)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	entity->on_st = false;
+	st->wsum -= entity->weight;
+	if (bfqq && !is_in_service)
+		bfq_put_queue(bfqq);
+}
+
+/**
+ * bfq_put_idle_entity - release the idle tree ref of an entity.
+ * @st: service tree for the entity.
+ * @entity: the entity being released.
+ */
+void bfq_put_idle_entity(struct bfq_service_tree *st, struct bfq_entity *entity)
+{
+	bfq_idle_extract(st, entity);
+	bfq_forget_entity(st, entity,
+			  entity == entity->sched_data->in_service_entity);
+}
+
+/**
+ * bfq_forget_idle - update the idle tree if necessary.
+ * @st: the service tree to act upon.
+ *
+ * To preserve the global O(log N) complexity we only remove one entry here;
+ * as the idle tree will not grow indefinitely this can be done safely.
+ */
+static void bfq_forget_idle(struct bfq_service_tree *st)
+{
+	struct bfq_entity *first_idle = st->first_idle;
+	struct bfq_entity *last_idle = st->last_idle;
+
+	if (RB_EMPTY_ROOT(&st->active) && last_idle &&
+	    !bfq_gt(last_idle->finish, st->vtime)) {
+		/*
+		 * Forget the whole idle tree, increasing the vtime past
+		 * the last finish time of idle entities.
+		 */
+		st->vtime = last_idle->finish;
+	}
+
+	if (first_idle && !bfq_gt(first_idle->finish, st->vtime))
+		bfq_put_idle_entity(st, first_idle);
+}
+
+struct bfq_service_tree *bfq_entity_service_tree(struct bfq_entity *entity)
+{
+	struct bfq_sched_data *sched_data = entity->sched_data;
+	unsigned int idx = bfq_class_idx(entity);
+
+	return sched_data->service_tree + idx;
+}
+
+
+struct bfq_service_tree *
+__bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
+				struct bfq_entity *entity)
+{
+	struct bfq_service_tree *new_st = old_st;
+
+	if (entity->prio_changed) {
+		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+		unsigned int prev_weight, new_weight;
+		struct bfq_data *bfqd = NULL;
+		struct rb_root *root;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		struct bfq_sched_data *sd;
+		struct bfq_group *bfqg;
+#endif
+
+		if (bfqq)
+			bfqd = bfqq->bfqd;
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+		else {
+			sd = entity->my_sched_data;
+			bfqg = container_of(sd, struct bfq_group, sched_data);
+			bfqd = (struct bfq_data *)bfqg->bfqd;
+		}
+#endif
+
+		old_st->wsum -= entity->weight;
+
+		if (entity->new_weight != entity->orig_weight) {
+			if (entity->new_weight < BFQ_MIN_WEIGHT ||
+			    entity->new_weight > BFQ_MAX_WEIGHT) {
+				pr_crit("update_weight_prio: new_weight %d\n",
+					entity->new_weight);
+				if (entity->new_weight < BFQ_MIN_WEIGHT)
+					entity->new_weight = BFQ_MIN_WEIGHT;
+				else
+					entity->new_weight = BFQ_MAX_WEIGHT;
+			}
+			entity->orig_weight = entity->new_weight;
+			if (bfqq)
+				bfqq->ioprio =
+				  bfq_weight_to_ioprio(entity->orig_weight);
+		}
+
+		if (bfqq)
+			bfqq->ioprio_class = bfqq->new_ioprio_class;
+		entity->prio_changed = 0;
+
+		/*
+		 * NOTE: here we may be changing the weight too early,
+		 * this will cause unfairness.  The correct approach
+		 * would have required additional complexity to defer
+		 * weight changes to the proper time instants (i.e.,
+		 * when entity->finish <= old_st->vtime).
+		 */
+		new_st = bfq_entity_service_tree(entity);
+
+		prev_weight = entity->weight;
+		new_weight = entity->orig_weight *
+			     (bfqq ? bfqq->wr_coeff : 1);
+		/*
+		 * If the weight of the entity changes, remove the entity
+		 * from its old weight counter (if there is a counter
+		 * associated with the entity), and add it to the counter
+		 * associated with its new weight.
+		 */
+		if (prev_weight != new_weight) {
+			root = bfqq ? &bfqd->queue_weights_tree :
+				      &bfqd->group_weights_tree;
+			bfq_weights_tree_remove(bfqd, entity, root);
+		}
+		entity->weight = new_weight;
+		/*
+		 * Add the entity to its weights tree only if it is
+		 * not associated with a weight-raised queue.
+		 */
+		if (prev_weight != new_weight &&
+		    (bfqq ? bfqq->wr_coeff == 1 : 1))
+			/* If we get here, root has been initialized. */
+			bfq_weights_tree_add(bfqd, entity, root);
+
+		new_st->wsum += entity->weight;
+
+		if (new_st != old_st)
+			entity->start = new_st->vtime;
+	}
+
+	return new_st;
+}
+
+/**
+ * bfq_bfqq_served - update the scheduler status after selection for
+ *                   service.
+ * @bfqq: the queue being served.
+ * @served: bytes to transfer.
+ *
+ * NOTE: this can be optimized, as the timestamps of upper level entities
+ * are synchronized every time a new bfqq is selected for service.  By now,
+ * we keep it to better check consistency.
+ */
+void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+	struct bfq_service_tree *st;
+
+	for_each_entity(entity) {
+		st = bfq_entity_service_tree(entity);
+
+		entity->service += served;
+
+		st->vtime += bfq_delta(served, st->wsum);
+		bfq_forget_idle(st);
+	}
+	bfqg_stats_set_start_empty_time(bfqq_group(bfqq));
+	bfq_log_bfqq(bfqq->bfqd, bfqq, "bfqq_served %d secs", served);
+}
+
+/**
+ * bfq_bfqq_charge_time - charge an amount of service equivalent to the length
+ *			  of the time interval during which bfqq has been in
+ *			  service.
+ * @bfqd: the device
+ * @bfqq: the queue that needs a service update.
+ * @time_ms: the amount of time during which the queue has received service
+ *
+ * If a queue does not consume its budget fast enough, then providing
+ * the queue with service fairness may impair throughput, more or less
+ * severely. For this reason, queues that consume their budget slowly
+ * are provided with time fairness instead of service fairness. This
+ * goal is achieved through the BFQ scheduling engine, even if such an
+ * engine works in the service, and not in the time domain. The trick
+ * is charging these queues with an inflated amount of service, equal
+ * to the amount of service that they would have received during their
+ * service slot if they had been fast, i.e., if their requests had
+ * been dispatched at a rate equal to the estimated peak rate.
+ *
+ * It is worth noting that time fairness can cause important
+ * distortions in terms of bandwidth distribution, on devices with
+ * internal queueing. The reason is that I/O requests dispatched
+ * during the service slot of a queue may be served after that service
+ * slot is finished, and may have a total processing time loosely
+ * correlated with the duration of the service slot. This is
+ * especially true for short service slots.
+ */
+void bfq_bfqq_charge_time(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			  unsigned long time_ms)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+	int tot_serv_to_charge = entity->service;
+	unsigned int timeout_ms = jiffies_to_msecs(bfq_timeout);
+
+	if (time_ms > 0 && time_ms < timeout_ms)
+		tot_serv_to_charge =
+			(bfqd->bfq_max_budget * time_ms) / timeout_ms;
+
+	if (tot_serv_to_charge < entity->service)
+		tot_serv_to_charge = entity->service;
+
+	/* Increase budget to avoid inconsistencies */
+	if (tot_serv_to_charge > entity->budget)
+		entity->budget = tot_serv_to_charge;
+
+	bfq_bfqq_served(bfqq,
+			max_t(int, 0, tot_serv_to_charge - entity->service));
+}
+
+static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
+					struct bfq_service_tree *st,
+					bool backshifted)
+{
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	st = __bfq_entity_update_weight_prio(st, entity);
+	bfq_calc_finish(entity, entity->budget);
+
+	/*
+	 * If some queues enjoy backshifting for a while, then their
+	 * (virtual) finish timestamps may happen to become lower and
+	 * lower than the system virtual time.	In particular, if
+	 * these queues often happen to be idle for short time
+	 * periods, and during such time periods other queues with
+	 * higher timestamps happen to be busy, then the backshifted
+	 * timestamps of the former queues can become much lower than
+	 * the system virtual time. In fact, to serve the queues with
+	 * higher timestamps while the ones with lower timestamps are
+	 * idle, the system virtual time may be pushed-up to much
+	 * higher values than the finish timestamps of the idle
+	 * queues. As a consequence, the finish timestamps of all new
+	 * or newly activated queues may end up being much larger than
+	 * those of lucky queues with backshifted timestamps. The
+	 * latter queues may then monopolize the device for a lot of
+	 * time. This would simply break service guarantees.
+	 *
+	 * To reduce this problem, push up a little bit the
+	 * backshifted timestamps of the queue associated with this
+	 * entity (only a queue can happen to have the backshifted
+	 * flag set): just enough to let the finish timestamp of the
+	 * queue be equal to the current value of the system virtual
+	 * time. This may introduce a little unfairness among queues
+	 * with backshifted timestamps, but it does not break
+	 * worst-case fairness guarantees.
+	 *
+	 * As a special case, if bfqq is weight-raised, push up
+	 * timestamps much less, to keep very low the probability that
+	 * this push up causes the backshifted finish timestamps of
+	 * weight-raised queues to become higher than the backshifted
+	 * finish timestamps of non weight-raised queues.
+	 */
+	if (backshifted && bfq_gt(st->vtime, entity->finish)) {
+		unsigned long delta = st->vtime - entity->finish;
+
+		if (bfqq)
+			delta /= bfqq->wr_coeff;
+
+		entity->start += delta;
+		entity->finish += delta;
+	}
+
+	bfq_active_insert(st, entity);
+}
+
+/**
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
+ * @entity: the entity to activate.
+ * @non_blocking_wait_rq: true if this entity was waiting for a request
+ * @requeue: true if this is a requeue, which implies that bfqq is
+ *	     being expired; thus ALL its ancestors stop being served and must
+ *	     therefore be requeued
+ */
+static void bfq_activate_requeue_entity(struct bfq_entity *entity,
+					bool non_blocking_wait_rq,
+					bool requeue)
+{
+	struct bfq_sched_data *sd;
+
+	for_each_entity(entity) {
+		sd = entity->sched_data;
+		__bfq_activate_requeue_entity(entity, sd, non_blocking_wait_rq);
+
+		if (!bfq_update_next_in_service(sd, entity) && !requeue)
+			break;
+	}
+}
+
+/**
+ * __bfq_deactivate_entity - deactivate an entity from its service tree.
+ * @entity: the entity to deactivate.
+ * @ins_into_idle_tree: if false, the entity will not be put into the
+ *			idle tree.
+ *
+ * Deactivates an entity, independently from its previous state.  Must
+ * be invoked only if entity is on a service tree. Extracts the entity
+ * from that tree, and if necessary and allowed, puts it on the idle
+ * tree.
+ */
+bool __bfq_deactivate_entity(struct bfq_entity *entity, bool ins_into_idle_tree)
+{
+	struct bfq_sched_data *sd = entity->sched_data;
+	struct bfq_service_tree *st = bfq_entity_service_tree(entity);
+	int is_in_service = entity == sd->in_service_entity;
+
+	if (!entity->on_st) /* entity never activated, or already inactive */
+		return false;
+
+	if (is_in_service)
+		bfq_calc_finish(entity, entity->service);
+
+	if (entity->tree == &st->active)
+		bfq_active_extract(st, entity);
+	else if (!is_in_service && entity->tree == &st->idle)
+		bfq_idle_extract(st, entity);
+
+	if (!ins_into_idle_tree || !bfq_gt(entity->finish, st->vtime))
+		bfq_forget_entity(st, entity, is_in_service);
+	else
+		bfq_idle_insert(st, entity);
+
+	return true;
+}
+
+/**
+ * bfq_deactivate_entity - deactivate an entity representing a bfq_queue.
+ * @entity: the entity to deactivate.
+ * @ins_into_idle_tree: true if the entity can be put on the idle tree
+ */
+static void bfq_deactivate_entity(struct bfq_entity *entity,
+				  bool ins_into_idle_tree,
+				  bool expiration)
+{
+	struct bfq_sched_data *sd;
+	struct bfq_entity *parent = NULL;
+
+	for_each_entity_safe(entity, parent) {
+		sd = entity->sched_data;
+
+		if (!__bfq_deactivate_entity(entity, ins_into_idle_tree)) {
+			/*
+			 * entity is not in any tree any more, so
+			 * this deactivation is a no-op, and there is
+			 * nothing to change for upper-level entities
+			 * (in case of expiration, this can never
+			 * happen).
+			 */
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
+
+		if (sd->next_in_service)
+			/*
+			 * The parent entity is still backlogged,
+			 * because next_in_service is not NULL. So, no
+			 * further upwards deactivation must be
+			 * performed.  Yet, next_in_service has
+			 * changed.  Then the schedule does need to be
+			 * updated upwards.
+			 */
+			break;
+
+		/*
+		 * If we get here, then the parent is no more
+		 * backlogged and we need to propagate the
+		 * deactivation upwards. Thus let the loop go on.
+		 */
+
+		/*
+		 * Also let parent be queued into the idle tree on
+		 * deactivation, to preserve service guarantees, and
+		 * assuming that who invoked this function does not
+		 * need parent entities too to be removed completely.
+		 */
+		ins_into_idle_tree = true;
+	}
+
+	/*
+	 * If the deactivation loop is fully executed, then there are
+	 * no more entities to touch and next loop is not executed at
+	 * all. Otherwise, requeue remaining entities if they are
+	 * about to stop receiving service, or reposition them if this
+	 * is not the case.
+	 */
+	entity = parent;
+	for_each_entity(entity) {
+		/*
+		 * Invoke __bfq_requeue_entity on entity, even if
+		 * already active, to requeue/reposition it in the
+		 * active tree (because sd->next_in_service has
+		 * changed)
+		 */
+		__bfq_requeue_entity(entity);
+
+		sd = entity->sched_data;
+		if (!bfq_update_next_in_service(sd, entity) &&
+		    !expiration)
+			/*
+			 * next_in_service unchanged or not causing
+			 * any change in entity->parent->sd, and no
+			 * requeueing needed for expiration: stop
+			 * here.
+			 */
+			break;
+	}
+}
+
+/**
+ * bfq_calc_vtime_jump - compute the value to which the vtime should jump,
+ *                       if needed, to have at least one entity eligible.
+ * @st: the service tree to act upon.
+ *
+ * Assumes that st is not empty.
+ */
+static u64 bfq_calc_vtime_jump(struct bfq_service_tree *st)
+{
+	struct bfq_entity *root_entity = bfq_root_active_entity(&st->active);
+
+	if (bfq_gt(root_entity->min_start, st->vtime))
+		return root_entity->min_start;
+
+	return st->vtime;
+}
+
+static void bfq_update_vtime(struct bfq_service_tree *st, u64 new_value)
+{
+	if (new_value > st->vtime) {
+		st->vtime = new_value;
+		bfq_forget_idle(st);
+	}
+}
+
+/**
+ * bfq_first_active_entity - find the eligible entity with
+ *                           the smallest finish time
+ * @st: the service tree to select from.
+ * @vtime: the system virtual to use as a reference for eligibility
+ *
+ * This function searches the first schedulable entity, starting from the
+ * root of the tree and going on the left every time on this side there is
+ * a subtree with at least one eligible (start >= vtime) entity. The path on
+ * the right is followed only if a) the left subtree contains no eligible
+ * entities and b) no eligible entity has been found yet.
+ */
+static struct bfq_entity *bfq_first_active_entity(struct bfq_service_tree *st,
+						  u64 vtime)
+{
+	struct bfq_entity *entry, *first = NULL;
+	struct rb_node *node = st->active.rb_node;
+
+	while (node) {
+		entry = rb_entry(node, struct bfq_entity, rb_node);
+left:
+		if (!bfq_gt(entry->start, vtime))
+			first = entry;
+
+		if (node->rb_left) {
+			entry = rb_entry(node->rb_left,
+					 struct bfq_entity, rb_node);
+			if (!bfq_gt(entry->min_start, vtime)) {
+				node = node->rb_left;
+				goto left;
+			}
+		}
+		if (first)
+			break;
+		node = node->rb_right;
+	}
+
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
+bool next_queue_may_preempt(struct bfq_data *bfqd)
+{
+	struct bfq_sched_data *sd = &bfqd->root_group->sched_data;
+
+	return sd->next_in_service != sd->in_service_entity;
+}
+
+/*
+ * Get next queue for service.
+ */
+struct bfq_queue *bfq_get_next_queue(struct bfq_data *bfqd)
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
+void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
+{
+	struct bfq_queue *in_serv_bfqq = bfqd->in_service_queue;
+	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
+	struct bfq_entity *entity = in_serv_entity;
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
+void bfq_deactivate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+			 bool ins_into_idle_tree, bool expiration)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	bfq_deactivate_entity(entity, ins_into_idle_tree, expiration);
+}
+
+void bfq_activate_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	bfq_activate_requeue_entity(entity, bfq_bfqq_non_blocking_wait_rq(bfqq),
+				    false);
+	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
+}
+
+void bfq_requeue_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	bfq_activate_requeue_entity(entity, false,
+				    bfqq == bfqd->in_service_queue);
+}
+
+/*
+ * Called when the bfqq no longer has requests pending, remove it from
+ * the service tree. As a special case, it can be invoked during an
+ * expiration.
+ */
+void bfq_del_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+		       bool expiration)
+{
+	bfq_log_bfqq(bfqd, bfqq, "del from busy");
+
+	bfq_clear_bfqq_busy(bfqq);
+
+	bfqd->busy_queues--;
+
+	if (!bfqq->dispatched)
+		bfq_weights_tree_remove(bfqd, &bfqq->entity,
+					&bfqd->queue_weights_tree);
+
+	if (bfqq->wr_coeff > 1)
+		bfqd->wr_busy_queues--;
+
+	bfqg_stats_update_dequeue(bfqq_group(bfqq));
+
+	bfq_deactivate_bfqq(bfqd, bfqq, true, expiration);
+}
+
+/*
+ * Called when an inactive queue receives a new request.
+ */
+void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	bfq_log_bfqq(bfqd, bfqq, "add to busy");
+
+	bfq_activate_bfqq(bfqd, bfqq);
+
+	bfq_mark_bfqq_busy(bfqq);
+	bfqd->busy_queues++;
+
+	if (!bfqq->dispatched)
+		if (bfqq->wr_coeff == 1)
+			bfq_weights_tree_add(bfqd, &bfqq->entity,
+					     &bfqd->queue_weights_tree);
+
+	if (bfqq->wr_coeff > 1)
+		bfqd->wr_busy_queues++;
+}
-- 
2.10.0
