Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] blk-mq: change gfp flags to GFP_NOIO in blk_mq_realloc_hw_ctxs
Date: Fri, 12 Oct 2018 18:07:26 +0800
Message-Id: <1539338848-1789-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

blk_mq_realloc_hw_ctxs could be invoked during update hw queues.
At the momemt, IO is blocked. Change the gfp flags from GFP_KERNEL
to GFP_NOIO to avoid forever hang during memory allocation in
blk_mq_realloc_hw_ctxs.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c  |  2 +-
 block/blk-flush.c |  6 +++---
 block/blk-mq.c    | 17 ++++++++++-------
 block/blk.h       |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cff0a60..4fe7084 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1160,7 +1160,7 @@ int blk_init_allocated_queue(struct request_queue *q)
 {
 	WARN_ON_ONCE(q->mq_ops);
 
-	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size);
+	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size, GFP_KERNEL);
 	if (!q->fq)
 		return -ENOMEM;
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index ce41f66..8b44b86 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -566,12 +566,12 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 EXPORT_SYMBOL(blkdev_issue_flush);
 
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
-		int node, int cmd_size)
+		int node, int cmd_size, gfp_t flags)
 {
 	struct blk_flush_queue *fq;
 	int rq_sz = sizeof(struct request);
 
-	fq = kzalloc_node(sizeof(*fq), GFP_KERNEL, node);
+	fq = kzalloc_node(sizeof(*fq), flags, node);
 	if (!fq)
 		goto fail;
 
@@ -579,7 +579,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		spin_lock_init(&fq->mq_flush_lock);
 
 	rq_sz = round_up(rq_sz + cmd_size, cache_line_size());
-	fq->flush_rq = kzalloc_node(rq_sz, GFP_KERNEL, node);
+	fq->flush_rq = kzalloc_node(rq_sz, flags, node);
 	if (!fq->flush_rq)
 		goto fail_rq;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32be432..9805d6a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2193,12 +2193,12 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	 * runtime
 	 */
 	hctx->ctxs = kmalloc_array_node(nr_cpu_ids, sizeof(void *),
-					GFP_KERNEL, node);
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node);
 	if (!hctx->ctxs)
 		goto unregister_cpu_notifier;
 
-	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8), GFP_KERNEL,
-			      node))
+	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8),
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node))
 		goto free_ctxs;
 
 	hctx->nr_ctx = 0;
@@ -2211,7 +2211,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
 		goto free_bitmap;
 
-	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
+	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size,
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!hctx->fq)
 		goto exit_hctx;
 
@@ -2519,12 +2520,14 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
 		hctxs[i] = kzalloc_node(blk_mq_hw_ctx_size(set),
-					GFP_KERNEL, node);
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+				node);
 		if (!hctxs[i])
 			break;
 
-		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask, GFP_KERNEL,
-						node)) {
+		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask,
+					GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+					node)) {
 			kfree(hctxs[i]);
 			hctxs[i] = NULL;
 			break;
diff --git a/block/blk.h b/block/blk.h
index 9db4e38..0f86eda 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -124,7 +124,7 @@ static inline void __blk_get_queue(struct request_queue *q)
 }
 
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
-		int node, int cmd_size);
+		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 int blk_init_rl(struct request_list *rl, struct request_queue *q,
-- 
2.7.4
