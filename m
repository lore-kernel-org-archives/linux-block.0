Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763738AbcINOTi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:38 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] blk-mq: allow the driver to pass in a queue mapping
Date: Wed, 14 Sep 2016 16:18:55 +0200
Message-Id: <1473862739-15032-10-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This allows drivers specify their own queue mapping by overriding the
setup-time function that builds the mq_map.  This can be used for
example to build the map based on the MSI-X vector mapping provided
by the core interrupt layer for PCI devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-cpumap.c  | 25 +++++--------------------
 block/blk-mq.c         | 18 +++++++++++++++---
 block/blk-mq.h         |  4 +---
 include/linux/blk-mq.h |  3 +++
 4 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index d0634bc..19b1d9c 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -31,14 +31,16 @@ static int get_first_sibling(unsigned int cpu)
 	return cpu;
 }
 
-int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
-			    const struct cpumask *online_mask)
+int blk_mq_map_queues(struct blk_mq_tag_set *set)
 {
+	unsigned int *map = set->mq_map;
+	unsigned int nr_queues = set->nr_hw_queues;
+	const struct cpumask *online_mask = cpu_online_mask;
 	unsigned int i, nr_cpus, nr_uniq_cpus, queue, first_sibling;
 	cpumask_var_t cpus;
 
 	if (!alloc_cpumask_var(&cpus, GFP_ATOMIC))
-		return 1;
+		return -ENOMEM;
 
 	cpumask_clear(cpus);
 	nr_cpus = nr_uniq_cpus = 0;
@@ -86,23 +88,6 @@ int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
 	return 0;
 }
 
-unsigned int *blk_mq_make_queue_map(struct blk_mq_tag_set *set)
-{
-	unsigned int *map;
-
-	/* If cpus are offline, map them to first hctx */
-	map = kzalloc_node(sizeof(*map) * nr_cpu_ids, GFP_KERNEL,
-				set->numa_node);
-	if (!map)
-		return NULL;
-
-	if (!blk_mq_update_queue_map(map, set->nr_hw_queues, cpu_online_mask))
-		return map;
-
-	kfree(map);
-	return NULL;
-}
-
 /*
  * We have no quick way of doing reverse lookups. This is only used at
  * queue init time, so runtime isn't important.
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 434df39..f3ef898 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2276,6 +2276,8 @@ EXPORT_SYMBOL_GPL(blk_mq_tags_cpumask);
  */
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 {
+	int ret;
+
 	BUILD_BUG_ON(BLK_MQ_MAX_DEPTH > 1 << BLK_MQ_UNIQUE_TAG_BITS);
 
 	if (!set->nr_hw_queues)
@@ -2314,11 +2316,21 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (!set->tags)
 		return -ENOMEM;
 
-	set->mq_map = blk_mq_make_queue_map(set);
+	ret = -ENOMEM;
+	set->mq_map = kzalloc_node(sizeof(*set->mq_map) * nr_cpu_ids,
+			GFP_KERNEL, set->numa_node);
 	if (!set->mq_map)
 		goto out_free_tags;
 
-	if (blk_mq_alloc_rq_maps(set))
+	if (set->ops->map_queues)
+		ret = set->ops->map_queues(set);
+	else
+		ret = blk_mq_map_queues(set);
+	if (ret)
+		goto out_free_mq_map;
+
+	ret = blk_mq_alloc_rq_maps(set);
+	if (ret)
 		goto out_free_mq_map;
 
 	mutex_init(&set->tag_list_lock);
@@ -2332,7 +2344,7 @@ out_free_mq_map:
 out_free_tags:
 	kfree(set->tags);
 	set->tags = NULL;
-	return -ENOMEM;
+	return ret;
 }
 EXPORT_SYMBOL(blk_mq_alloc_tag_set);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ec774bf..c92bb7d 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,9 +47,7 @@ void blk_mq_disable_hotplug(void);
 /*
  * CPU -> queue mappings
  */
-extern unsigned int *blk_mq_make_queue_map(struct blk_mq_tag_set *set);
-extern int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
-				   const struct cpumask *online_mask);
+int blk_mq_map_queues(struct blk_mq_tag_set *set);
 extern int blk_mq_hw_queue_to_node(unsigned int *map, unsigned int);
 
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d4d8bc8..ead450a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -102,6 +102,7 @@ typedef void (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
 		bool);
 typedef void (busy_tag_iter_fn)(struct request *, void *, bool);
 typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
+typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
 
 
 struct blk_mq_ops {
@@ -142,6 +143,8 @@ struct blk_mq_ops {
 	init_request_fn		*init_request;
 	exit_request_fn		*exit_request;
 	reinit_request_fn	*reinit_request;
+
+	map_queues_fn		*map_queues;
 };
 
 enum {
-- 
2.1.4

