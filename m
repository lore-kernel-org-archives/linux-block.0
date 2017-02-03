Return-Path: <BATV+1f42f42caf748e0126fd+4912+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] blk-mq: create hctx for each present CPU
Date: Fri,  3 Feb 2017 15:35:59 +0100
Message-Id: <20170203143600.32307-6-hch@lst.de>
In-Reply-To: <20170203143600.32307-1-hch@lst.de>
References: <20170203143600.32307-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Currently we only create hctx for online CPUs, which can lead to a lot
of churn due to frequent soft offline / online operations.  Instead
allocate one for each present CPU to avoid this and dramatically simplify
the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-sysfs.c       |  26 +++------
 block/blk-mq.c             | 137 +++++----------------------------------------
 block/blk-mq.h             |   5 --
 include/linux/cpuhotplug.h |   1 -
 4 files changed, 20 insertions(+), 149 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 295e69670c39..c69ec94a2ad8 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -239,7 +239,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	return ret;
 }
 
-static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
+void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
@@ -265,13 +265,6 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	q->mq_sysfs_init_done = false;
 }
 
-void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
-{
-	blk_mq_disable_hotplug();
-	__blk_mq_unregister_dev(dev, q);
-	blk_mq_enable_hotplug();
-}
-
 void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
 {
 	kobject_init(&hctx->kobj, &blk_mq_hw_ktype);
@@ -295,13 +288,11 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int ret, i;
 
-	blk_mq_disable_hotplug();
-
 	blk_mq_sysfs_init(q);
 
 	ret = kobject_add(&q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	kobject_uevent(&q->mq_kobj, KOBJ_ADD);
 
@@ -310,16 +301,13 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
-			break;
+			goto fail;
 	}
 
-	if (ret)
-		__blk_mq_unregister_dev(dev, q);
-	else
-		q->mq_sysfs_init_done = true;
-out:
-	blk_mq_enable_hotplug();
-
+	q->mq_sysfs_init_done = true;
+	return 0;
+fail:
+	blk_mq_unregister_dev(dev, q);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_mq_register_dev);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index be183e6115a1..3578d678a871 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -34,9 +34,6 @@
 #include "blk-wbt.h"
 #include "blk-mq-sched.h"
 
-static DEFINE_MUTEX(all_q_mutex);
-static LIST_HEAD(all_q_list);
-
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
@@ -1948,8 +1945,8 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		blk_stat_init(&__ctx->stat[BLK_STAT_READ]);
 		blk_stat_init(&__ctx->stat[BLK_STAT_WRITE]);
 
-		/* If the cpu isn't online, the cpu is mapped to first hctx */
-		if (!cpu_online(i))
+		/* If the cpu isn't present, the cpu is mapped to first hctx */
+		if (!cpu_present(i))
 			continue;
 
 		hctx = blk_mq_map_queue(q, i);
@@ -1992,8 +1989,7 @@ static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 	}
 }
 
-static void blk_mq_map_swqueue(struct request_queue *q,
-			       const struct cpumask *online_mask)
+static void blk_mq_map_swqueue(struct request_queue *q)
 {
 	unsigned int i, hctx_idx;
 	struct blk_mq_hw_ctx *hctx;
@@ -2011,13 +2007,11 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 	}
 
 	/*
-	 * Map software to hardware queues
+	 * Map software to hardware queues.
+	 *
+	 * If the cpu isn't present, the cpu is mapped to first hctx.
 	 */
-	for_each_possible_cpu(i) {
-		/* If the cpu isn't online, the cpu is mapped to first hctx */
-		if (!cpumask_test_cpu(i, online_mask))
-			continue;
-
+	for_each_present_cpu(i) {
 		hctx_idx = q->mq_map[i];
 		/* unmapped hw queue can be remapped after CPU topo changed */
 		if (!set->tags[hctx_idx] &&
@@ -2293,16 +2287,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		blk_queue_softirq_done(q, set->ops->complete);
 
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
-
-	get_online_cpus();
-	mutex_lock(&all_q_mutex);
-
-	list_add_tail(&q->all_q_node, &all_q_list);
 	blk_mq_add_queue_tag_set(set, q);
-	blk_mq_map_swqueue(q, cpu_online_mask);
-
-	mutex_unlock(&all_q_mutex);
-	put_online_cpus();
+	blk_mq_map_swqueue(q);
 
 	if (!(set->flags & BLK_MQ_F_NO_SCHED)) {
 		int ret;
@@ -2328,10 +2314,6 @@ void blk_mq_free_queue(struct request_queue *q)
 {
 	struct blk_mq_tag_set	*set = q->tag_set;
 
-	mutex_lock(&all_q_mutex);
-	list_del_init(&q->all_q_node);
-	mutex_unlock(&all_q_mutex);
-
 	wbt_exit(q);
 
 	blk_mq_del_queue_tag_set(q);
@@ -2340,89 +2322,6 @@ void blk_mq_free_queue(struct request_queue *q)
 	blk_mq_free_hw_queues(q, set);
 }
 
-/* Basically redo blk_mq_init_queue with queue frozen */
-static void blk_mq_queue_reinit(struct request_queue *q,
-				const struct cpumask *online_mask)
-{
-	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
-
-	blk_mq_sysfs_unregister(q);
-
-	/*
-	 * redo blk_mq_init_cpu_queues and blk_mq_init_hw_queues. FIXME: maybe
-	 * we should change hctx numa_node according to new topology (this
-	 * involves free and re-allocate memory, worthy doing?)
-	 */
-
-	blk_mq_map_swqueue(q, online_mask);
-
-	blk_mq_sysfs_register(q);
-}
-
-/*
- * New online cpumask which is going to be set in this hotplug event.
- * Declare this cpumasks as global as cpu-hotplug operation is invoked
- * one-by-one and dynamically allocating this could result in a failure.
- */
-static struct cpumask cpuhp_online_new;
-
-static void blk_mq_queue_reinit_work(void)
-{
-	struct request_queue *q;
-
-	mutex_lock(&all_q_mutex);
-	/*
-	 * We need to freeze and reinit all existing queues.  Freezing
-	 * involves synchronous wait for an RCU grace period and doing it
-	 * one by one may take a long time.  Start freezing all queues in
-	 * one swoop and then wait for the completions so that freezing can
-	 * take place in parallel.
-	 */
-	list_for_each_entry(q, &all_q_list, all_q_node)
-		blk_mq_freeze_queue_start(q);
-	list_for_each_entry(q, &all_q_list, all_q_node)
-		blk_mq_freeze_queue_wait(q);
-
-	list_for_each_entry(q, &all_q_list, all_q_node)
-		blk_mq_queue_reinit(q, &cpuhp_online_new);
-
-	list_for_each_entry(q, &all_q_list, all_q_node)
-		blk_mq_unfreeze_queue(q);
-
-	mutex_unlock(&all_q_mutex);
-}
-
-static int blk_mq_queue_reinit_dead(unsigned int cpu)
-{
-	cpumask_copy(&cpuhp_online_new, cpu_online_mask);
-	blk_mq_queue_reinit_work();
-	return 0;
-}
-
-/*
- * Before hotadded cpu starts handling requests, new mappings must be
- * established.  Otherwise, these requests in hw queue might never be
- * dispatched.
- *
- * For example, there is a single hw queue (hctx) and two CPU queues (ctx0
- * for CPU0, and ctx1 for CPU1).
- *
- * Now CPU1 is just onlined and a request is inserted into ctx1->rq_list
- * and set bit0 in pending bitmap as ctx1->index_hw is still zero.
- *
- * And then while running hw queue, blk_mq_flush_busy_ctxs() finds bit0 is set
- * in pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
- * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list is
- * ignored.
- */
-static int blk_mq_queue_reinit_prepare(unsigned int cpu)
-{
-	cpumask_copy(&cpuhp_online_new, cpu_online_mask);
-	cpumask_set_cpu(cpu, &cpuhp_online_new);
-	blk_mq_queue_reinit_work();
-	return 0;
-}
-
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
@@ -2632,7 +2531,11 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 		else
 			blk_queue_make_request(q, blk_sq_make_request);
 
-		blk_mq_queue_reinit(q, cpu_online_mask);
+		/* Basically redo blk_mq_init_queue with queue frozen */
+		WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
+		blk_mq_sysfs_unregister(q);
+		blk_mq_map_swqueue(q);
+		blk_mq_sysfs_register(q);
 	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
@@ -2802,24 +2705,10 @@ bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 }
 EXPORT_SYMBOL_GPL(blk_mq_poll);
 
-void blk_mq_disable_hotplug(void)
-{
-	mutex_lock(&all_q_mutex);
-}
-
-void blk_mq_enable_hotplug(void)
-{
-	mutex_unlock(&all_q_mutex);
-}
-
 static int __init blk_mq_init(void)
 {
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
-
-	cpuhp_setup_state_nocalls(CPUHP_BLK_MQ_PREPARE, "block/mq:prepare",
-				  blk_mq_queue_reinit_prepare,
-				  blk_mq_queue_reinit_dead);
 	return 0;
 }
 subsys_initcall(blk_mq_init);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 24b2256186f3..0d77b914d29f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -57,11 +57,6 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 				bool at_head);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
-/*
- * CPU hotplug helpers
- */
-void blk_mq_enable_hotplug(void);
-void blk_mq_disable_hotplug(void);
 
 /*
  * CPU -> queue mappings
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 63406ae5b2df..992a09a297da 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -61,7 +61,6 @@ enum cpuhp_state {
 	CPUHP_XEN_EVTCHN_PREPARE,
 	CPUHP_ARM_SHMOBILE_SCU_PREPARE,
 	CPUHP_SH_SH3X_PREPARE,
-	CPUHP_BLK_MQ_PREPARE,
 	CPUHP_NET_FLOW_PREPARE,
 	CPUHP_TOPOLOGY_PREPARE,
 	CPUHP_NET_IUCV_PREPARE,
-- 
2.11.0
