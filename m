Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <tom.leiming@gmail.com>,
	Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCH] blk-mq: User defined HCTX CPU mapping
Date: Mon, 18 Jun 2018 11:32:06 -0600
Message-Id: <20180618173206.19506-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The default mapping of a cpu to a hardware context is often generally
applicable, however a user may know of a more appropriate mapping for
their specific access usage.

This patch allows a user to define their own policy by making the mq hctx
cpu_list writable. The usage allows a user to append a comma separated
and/or range list of CPUs to a given hctx's tag set mapping to reassign
what hctx a cpu may map.

While the writable attribute exists under a specific request_queue, the
settings will affect all request queues sharing the same tagset.

The user defined setting is lost if the block device is removed and
re-added, or if the driver re-runs the queue mapping.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq-debugfs.c | 16 ++++++----
 block/blk-mq-debugfs.h | 11 +++++++
 block/blk-mq-sysfs.c   | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-
 block/blk-mq.c         |  9 ------
 block/blk-mq.h         | 12 ++++++++
 5 files changed, 112 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ffa622366922..df163a79511c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -870,18 +870,22 @@ void blk_mq_debugfs_unregister(struct request_queue *q)
 	q->debugfs_dir = NULL;
 }
 
-static int blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
-				       struct blk_mq_ctx *ctx)
+void blk_mq_debugfs_unregister_ctx(struct blk_mq_ctx *ctx)
+{
+	debugfs_remove_recursive(ctx->debugfs_dir);
+}
+
+int blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
+				struct blk_mq_ctx *ctx)
 {
-	struct dentry *ctx_dir;
 	char name[20];
 
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
-	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
-	if (!ctx_dir)
+	ctx->debugfs_dir = debugfs_create_dir(name, hctx->debugfs_dir);
+	if (!ctx->debugfs_dir)
 		return -ENOMEM;
 
-	if (!debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs))
+	if (!debugfs_create_files(ctx->debugfs_dir, ctx, blk_mq_debugfs_ctx_attrs))
 		return -ENOMEM;
 
 	return 0;
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index b9d366e57097..93df02eabf2b 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -18,6 +18,9 @@ struct blk_mq_debugfs_attr {
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq);
 int blk_mq_debugfs_rq_show(struct seq_file *m, void *v);
 
+void blk_mq_debugfs_unregister_ctx(struct blk_mq_ctx *ctx);
+int blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
+				struct blk_mq_ctx *ctx);
 int blk_mq_debugfs_register(struct request_queue *q);
 void blk_mq_debugfs_unregister(struct request_queue *q);
 int blk_mq_debugfs_register_hctx(struct request_queue *q,
@@ -41,6 +44,14 @@ static inline void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 }
 
+void blk_mq_debugfs_unregister_ctx(struct blk_mq_ctx *ctx) {}
+
+int blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
+				struct blk_mq_ctx *ctx)
+{
+	return 0;
+}
+
 static inline int blk_mq_debugfs_register_hctx(struct request_queue *q,
 					       struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index aafb44224c89..ec2a07dd86e9 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -11,6 +11,7 @@
 
 #include <linux/blk-mq.h>
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 
 static void blk_mq_sysfs_release(struct kobject *kobj)
@@ -161,6 +162,82 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return ret;
 }
 
+static void blk_mq_reassign_swqueue(unsigned int cpu,  unsigned int new_index,
+				    struct blk_mq_tag_set *set)
+{
+	struct blk_mq_hw_ctx *hctx;
+	struct request_queue *q;
+	struct blk_mq_ctx *ctx;
+
+	if (set->mq_map[cpu] == new_index)
+		return;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		ctx = per_cpu_ptr(q->queue_ctx, cpu);
+		blk_mq_debugfs_unregister_ctx(ctx);
+		kobject_del(&ctx->kobj);
+
+		hctx = blk_mq_map_queue(q, cpu);
+		cpumask_clear_cpu(cpu, hctx->cpumask);
+		hctx->nr_ctx--;
+		if (hctx->dispatch_from == ctx)
+			hctx->dispatch_from = NULL;
+	}
+
+	set->mq_map[cpu] = new_index;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		ctx = per_cpu_ptr(q->queue_ctx, cpu);
+		hctx = blk_mq_map_queue(q, cpu);
+		cpumask_set_cpu(cpu, hctx->cpumask);
+		ctx->index_hw = hctx->nr_ctx;
+		hctx->ctxs[hctx->nr_ctx++] = ctx;
+		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
+		hctx->next_cpu = blk_mq_first_mapped_cpu(hctx);
+
+		if (kobject_add(&ctx->kobj, &hctx->kobj, "cpu%u", ctx->cpu))
+			printk(KERN_WARNING "ctx object failure\n");
+		blk_mq_debugfs_register_ctx(hctx, ctx);
+	}
+}
+
+static ssize_t blk_mq_hw_sysfs_cpus_store(struct blk_mq_hw_ctx *hctx,
+					  const char *page, size_t length)
+{
+	unsigned int cpu, queue_index = hctx->queue_num;
+	struct blk_mq_tag_set *set = hctx->queue->tag_set;
+	struct request_queue *q;
+	cpumask_var_t new_value;
+	int err;
+
+	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
+		return -ENOMEM;
+
+	err = cpulist_parse(page, new_value);
+	if (err)
+		goto free_mask;
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (q != hctx->queue)
+			mutex_lock(&q->sysfs_lock);
+		blk_mq_freeze_queue(q);
+	}
+
+	for_each_cpu(cpu, new_value)
+		blk_mq_reassign_swqueue(cpu, queue_index, set);
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (q != hctx->queue)
+			mutex_unlock(&q->sysfs_lock);
+		blk_mq_unfreeze_queue(q);
+	}
+	err = length;
+
+ free_mask:
+	free_cpumask_var(new_value);
+	return err;
+}
+
 static struct attribute *default_ctx_attrs[] = {
 	NULL,
 };
@@ -174,8 +251,9 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_reserved_tags = {
 	.show = blk_mq_hw_sysfs_nr_reserved_tags_show,
 };
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
-	.attr = {.name = "cpu_list", .mode = 0444 },
+	.attr = {.name = "cpu_list", .mode = 0644 },
 	.show = blk_mq_hw_sysfs_cpus_show,
+	.store = blk_mq_hw_sysfs_cpus_store,
 };
 
 static struct attribute *default_hw_ctx_attrs[] = {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d2de0a719ab8..a8dde5d70eb6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1248,15 +1248,6 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 	hctx_unlock(hctx, srcu_idx);
 }
 
-static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
-{
-	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
-
-	if (cpu >= nr_cpu_ids)
-		cpu = cpumask_first(hctx->cpumask);
-	return cpu;
-}
-
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 89231e439b2f..34dc0baf62cc 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -28,6 +28,9 @@ struct blk_mq_ctx {
 
 	struct request_queue	*queue;
 	struct kobject		kobj;
+#ifdef CONFIG_BLK_DEBUG_FS
+	struct dentry		*debugfs_dir;
+#endif
 } ____cacheline_aligned_in_smp;
 
 void blk_mq_freeze_queue(struct request_queue *q);
@@ -203,4 +206,13 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
 	__blk_mq_put_driver_tag(hctx, rq);
 }
 
+static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
+{
+	int cpu = cpumask_first_and(hctx->cpumask, cpu_online_mask);
+
+	if (cpu >= nr_cpu_ids)
+		cpu = cpumask_first(hctx->cpumask);
+	return cpu;
+}
+
 #endif
-- 
2.14.3
