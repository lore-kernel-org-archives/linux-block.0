Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/16] blk-mq: support multiple hctx maps
Date: Tue, 30 Oct 2018 12:32:43 -0600
Message-Id: <20181030183252.17857-8-axboe@kernel.dk>
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Add support for the tag set carrying multiple queue maps, and
for the driver to inform blk-mq how many it wishes to support
through setting set->nr_maps.

This adds an mq_ops helper for drivers that support more than 1
map, mq_ops->flags_to_type(). The function takes request/bio flags
and CPU, and returns a queue map index for that. We then use the
type information in blk_mq_map_queue() to index the map set.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 92 ++++++++++++++++++++++++++++--------------
 block/blk-mq.h         | 33 +++++++++++----
 include/linux/blk-mq.h | 14 +++++++
 3 files changed, 100 insertions(+), 39 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 34afbad0ebf6..9d6e2f6f8ee9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2257,7 +2257,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 static void blk_mq_init_cpu_queues(struct request_queue *q,
 				   unsigned int nr_hw_queues)
 {
-	unsigned int i;
+	struct blk_mq_tag_set *set = q->tag_set;
+	unsigned int i, j;
 
 	for_each_possible_cpu(i) {
 		struct blk_mq_ctx *__ctx = per_cpu_ptr(q->queue_ctx, i);
@@ -2272,9 +2273,11 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		 * Set local node, IFF we have more than one hw queue. If
 		 * not, we remain on the home node of the device
 		 */
-		hctx = blk_mq_map_queue_type(q, 0, i);
-		if (nr_hw_queues > 1 && hctx->numa_node == NUMA_NO_NODE)
-			hctx->numa_node = local_memory_node(cpu_to_node(i));
+		for (j = 0; j < set->nr_maps; j++) {
+			hctx = blk_mq_map_queue_type(q, j, i);
+			if (nr_hw_queues > 1 && hctx->numa_node == NUMA_NO_NODE)
+				hctx->numa_node = local_memory_node(cpu_to_node(i));
+		}
 	}
 }
 
@@ -2309,7 +2312,7 @@ static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 
 static void blk_mq_map_swqueue(struct request_queue *q)
 {
-	unsigned int i, hctx_idx;
+	unsigned int i, j, hctx_idx;
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	struct blk_mq_tag_set *set = q->tag_set;
@@ -2345,17 +2348,28 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		}
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
-		hctx = blk_mq_map_queue_type(q, 0, i);
-		hctx->type = 0;
-		cpumask_set_cpu(i, hctx->cpumask);
-		ctx->index_hw[hctx->type] = hctx->nr_ctx;
-		hctx->ctxs[hctx->nr_ctx++] = ctx;
+		for (j = 0; j < set->nr_maps; j++) {
+			hctx = blk_mq_map_queue_type(q, j, i);
 
-		/*
-		 * If the nr_ctx type overflows, we have exceeded the
-		 * amount of sw queues we can support.
-		 */
-		BUG_ON(!hctx->nr_ctx);
+			/*
+			 * If the CPU is already set in the mask, then we've
+			 * mapped this one already. This can happen if
+			 * devices share queues across queue maps.
+			 */
+			if (cpumask_test_cpu(i, hctx->cpumask))
+				continue;
+
+			cpumask_set_cpu(i, hctx->cpumask);
+			hctx->type = j;
+			ctx->index_hw[hctx->type] = hctx->nr_ctx;
+			hctx->ctxs[hctx->nr_ctx++] = ctx;
+
+			/*
+			 * If the nr_ctx type overflows, we have exceeded the
+			 * amount of sw queues we can support.
+			 */
+			BUG_ON(!hctx->nr_ctx);
+		}
 	}
 
 	mutex_unlock(&q->sysfs_lock);
@@ -2523,6 +2537,7 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 	memset(set, 0, sizeof(*set));
 	set->ops = ops;
 	set->nr_hw_queues = 1;
+	set->nr_maps = 1;
 	set->queue_depth = queue_depth;
 	set->numa_node = NUMA_NO_NODE;
 	set->flags = set_flags;
@@ -2802,6 +2817,8 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
 	if (set->ops->map_queues) {
+		int i;
+
 		/*
 		 * transport .map_queues is usually done in the following
 		 * way:
@@ -2809,18 +2826,21 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		 * for (queue = 0; queue < set->nr_hw_queues; queue++) {
 		 * 	mask = get_cpu_mask(queue)
 		 * 	for_each_cpu(cpu, mask)
-		 * 		set->map.mq_map[cpu] = queue;
+		 * 		set->map[x].mq_map[cpu] = queue;
 		 * }
 		 *
 		 * When we need to remap, the table has to be cleared for
 		 * killing stale mapping since one CPU may not be mapped
 		 * to any hw queue.
 		 */
-		blk_mq_clear_mq_map(&set->map[0]);
+		for (i = 0; i < set->nr_maps; i++)
+			blk_mq_clear_mq_map(&set->map[i]);
 
 		return set->ops->map_queues(set);
-	} else
+	} else {
+		BUG_ON(set->nr_maps > 1);
 		return blk_mq_map_queues(&set->map[0]);
+	}
 }
 
 /*
@@ -2831,7 +2851,7 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
  */
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 {
-	int ret;
+	int i, ret;
 
 	BUILD_BUG_ON(BLK_MQ_MAX_DEPTH > 1 << BLK_MQ_UNIQUE_TAG_BITS);
 
@@ -2854,6 +2874,11 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		set->queue_depth = BLK_MQ_MAX_DEPTH;
 	}
 
+	if (!set->nr_maps)
+		set->nr_maps = 1;
+	else if (set->nr_maps > HCTX_MAX_TYPES)
+		return -EINVAL;
+
 	/*
 	 * If a crashdump is active, then we are potentially in a very
 	 * memory constrained environment. Limit us to 1 queue and
@@ -2875,12 +2900,14 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 		return -ENOMEM;
 
 	ret = -ENOMEM;
-	set->map[0].mq_map = kcalloc_node(nr_cpu_ids,
-					  sizeof(*set->map[0].mq_map),
-					  GFP_KERNEL, set->numa_node);
-	if (!set->map[0].mq_map)
-		goto out_free_tags;
-	set->map[0].nr_queues = set->nr_hw_queues;
+	for (i = 0; i < set->nr_maps; i++) {
+		set->map[i].mq_map = kcalloc_node(nr_cpu_ids,
+						  sizeof(struct blk_mq_queue_map),
+						  GFP_KERNEL, set->numa_node);
+		if (!set->map[i].mq_map)
+			goto out_free_mq_map;
+		set->map[i].nr_queues = set->nr_hw_queues;
+	}
 
 	ret = blk_mq_update_queue_map(set);
 	if (ret)
@@ -2896,9 +2923,10 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	return 0;
 
 out_free_mq_map:
-	kfree(set->map[0].mq_map);
-	set->map[0].mq_map = NULL;
-out_free_tags:
+	for (i = 0; i < set->nr_maps; i++) {
+		kfree(set->map[i].mq_map);
+		set->map[i].mq_map = NULL;
+	}
 	kfree(set->tags);
 	set->tags = NULL;
 	return ret;
@@ -2907,13 +2935,15 @@ EXPORT_SYMBOL(blk_mq_alloc_tag_set);
 
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < nr_cpu_ids; i++)
 		blk_mq_free_map_and_requests(set, i);
 
-	kfree(set->map[0].mq_map);
-	set->map[0].mq_map = NULL;
+	for (j = 0; j < set->nr_maps; j++) {
+		kfree(set->map[j].mq_map);
+		set->map[j].mq_map = NULL;
+	}
 
 	kfree(set->tags);
 	set->tags = NULL;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1821f448f7c4..8329017badc8 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -72,20 +72,37 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
  */
 extern int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int);
 
-static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
-						     unsigned int flags,
-						     unsigned int cpu)
+/*
+ * blk_mq_map_queue_type() - map (hctx_type,cpu) to hardware queue
+ * @q: request queue
+ * @hctx_type: the hctx type index
+ * @cpu: CPU
+ */
+static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
+							  unsigned int hctx_type,
+							  unsigned int cpu)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	return q->queue_hw_ctx[set->map[0].mq_map[cpu]];
+	return q->queue_hw_ctx[set->map[hctx_type].mq_map[cpu]];
 }
 
-static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
-							  unsigned int hctx_type,
-							  unsigned int cpu)
+/*
+ * blk_mq_map_queue() - map (cmd_flags,type) to hardware queue
+ * @q: request queue
+ * @flags: request command flags
+ * @cpu: CPU
+ */
+static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
+						     unsigned int flags,
+						     unsigned int cpu)
 {
-	return blk_mq_map_queue(q, hctx_type, cpu);
+	int hctx_type = 0;
+
+	if (q->mq_ops->flags_to_type)
+		hctx_type = q->mq_ops->flags_to_type(q, flags);
+
+	return blk_mq_map_queue_type(q, hctx_type, cpu);
 }
 
 /*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 466b9202b69c..26768c8f5af5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -85,7 +85,14 @@ enum {
 };
 
 struct blk_mq_tag_set {
+	/*
+	 * map[] holds ctx -> hctx mappings, one map exists for each type
+	 * that the driver wishes to support. There are no restrictions
+	 * on maps being of the same size, and it's perfectly legal to
+	 * share maps between types.
+	 */
 	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
+	unsigned int		nr_maps;	/* nr entries in map[] */
 	const struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;	/* nr hw queues across maps */
 	unsigned int		queue_depth;	/* max hw supported */
@@ -109,6 +116,8 @@ struct blk_mq_queue_data {
 
 typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
 		const struct blk_mq_queue_data *);
+/* takes rq->cmd_flags as input, returns a hardware type index */
+typedef int (flags_to_type_fn)(struct request_queue *, unsigned int);
 typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
 typedef void (put_budget_fn)(struct blk_mq_hw_ctx *);
 typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
@@ -133,6 +142,11 @@ struct blk_mq_ops {
 	 */
 	queue_rq_fn		*queue_rq;
 
+	/*
+	 * Return a queue map type for the given request/bio flags
+	 */
+	flags_to_type_fn	*flags_to_type;
+
 	/*
 	 * Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
-- 
2.17.1
