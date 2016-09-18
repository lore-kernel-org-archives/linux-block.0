Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932343AbcIRHhq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:46 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 12/14] blk-mq: Rework blk_mq_init_hctx() function
Date: Sun, 18 Sep 2016 09:37:22 +0200
Message-Id: <46cd9de883dde4c85fd31f5ca4b1fbafb64f5728.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Rework blk_mq_init_hctx() function so all memory allocations
are done before data initialization and callbacks invocation.
As result, the latter is avoided in tight memory conditions.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 50 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index af6d049..5ecbb5f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1714,6 +1714,22 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 	if (!zalloc_cpumask_var_node(&hctx->cpumask, GFP_KERNEL, node))
 		goto free_hctx;
 
+	/*
+	 * Allocate space for all possible cpus to avoid allocation at
+	 * runtime
+	 */
+	hctx->ctxs = kmalloc_node(nr_cpu_ids * sizeof(void *),
+					GFP_KERNEL, node);
+	if (!hctx->ctxs)
+		goto free_cpumask;
+
+	if (blk_mq_alloc_bitmap(&hctx->ctx_map, node))
+		goto free_ctxs;
+
+	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
+	if (!hctx->fq)
+		goto free_bitmap;
+
 	INIT_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
 	spin_lock_init(&hctx->lock);
@@ -1722,55 +1738,37 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 	hctx->numa_node = node;
 	hctx->queue = q;
 	hctx->queue_num = hctx_idx;
+	hctx->nr_ctx = 0;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
+	hctx->tags = set->tags[hctx_idx];
 
 	blk_mq_init_cpu_notifier(&hctx->cpu_notifier,
 					blk_mq_hctx_notify, hctx);
 	blk_mq_register_cpu_notifier(&hctx->cpu_notifier);
 
-	hctx->tags = set->tags[hctx_idx];
-
-	/*
-	 * Allocate space for all possible cpus to avoid allocation at
-	 * runtime
-	 */
-	hctx->ctxs = kmalloc_node(nr_cpu_ids * sizeof(void *),
-					GFP_KERNEL, node);
-	if (!hctx->ctxs)
-		goto unregister_cpu_notifier;
-
-	if (blk_mq_alloc_bitmap(&hctx->ctx_map, node))
-		goto free_ctxs;
-
-	hctx->nr_ctx = 0;
-
 	if (set->ops->init_hctx &&
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
-		goto free_bitmap;
-
-	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
-	if (!hctx->fq)
-		goto exit_hctx;
+		goto unregister_cpu_notifier;
 
 	if (set->ops->init_request &&
 	    set->ops->init_request(set->driver_data,
 				   hctx->fq->flush_rq, hctx_idx,
 				   flush_start_tag + hctx_idx, node))
-		goto free_fq;
+		goto exit_hctx;
 
 	return hctx;
 
- free_fq:
-	kfree(hctx->fq);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
+ unregister_cpu_notifier:
+	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
+	kfree(hctx->fq);
  free_bitmap:
 	blk_mq_free_bitmap(&hctx->ctx_map);
  free_ctxs:
 	kfree(hctx->ctxs);
- unregister_cpu_notifier:
-	blk_mq_unregister_cpu_notifier(&hctx->cpu_notifier);
+ free_cpumask:
 	free_cpumask_var(hctx->cpumask);
  free_hctx:
 	kfree(hctx);
-- 
1.8.3.1

