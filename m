Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933635AbcI3NXt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2016 09:23:49 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 5/8] blk-mq: Cleanup blk_mq_hw_ctx::cpumask (de-)allocation
Date: Fri, 30 Sep 2016 15:23:27 +0200
Message-Id: <49a669af2c7e281527b31727392e4ad781831c80.1475241231.git.agordeev@redhat.com>
In-Reply-To: <cover.1475241231.git.agordeev@redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eed6e348..15c03c2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1604,6 +1604,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	blk_mq_remove_cpuhp(hctx);
 	blk_free_flush_queue(hctx->fq);
 	sbitmap_free(&hctx->ctx_map);
+
+	free_cpumask_var(hctx->cpumask);
 }
 
 static void blk_mq_exit_hw_queues(struct request_queue *q,
@@ -1616,27 +1618,21 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 		blk_mq_exit_hctx(q, set, hctx, i);
 }
 
-static void blk_mq_free_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		free_cpumask_var(hctx->cpumask);
-}
-
 static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
-		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
+		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx, int node)
 {
-	int node = hctx->numa_node;
 	unsigned flush_start_tag = set->queue_depth;
 
+	if (!zalloc_cpumask_var_node(&hctx->cpumask, GFP_KERNEL, node))
+		goto err_cpumask;
+
 	INIT_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
 	spin_lock_init(&hctx->lock);
 	INIT_LIST_HEAD(&hctx->dispatch);
+	atomic_set(&hctx->nr_active, 0);
+	hctx->numa_node = node;
 	hctx->queue = q;
 	hctx->queue_num = hctx_idx;
 	hctx->flags = set->flags & ~BLK_MQ_F_TAG_SHARED;
@@ -1687,6 +1683,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	kfree(hctx->ctxs);
  unregister_cpu_notifier:
 	blk_mq_remove_cpuhp(hctx);
+	free_cpumask_var(hctx->cpumask);
+ err_cpumask:
 	return -1;
 }
 
@@ -1915,18 +1913,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		if (!hctxs[i])
 			break;
 
-		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask, GFP_KERNEL,
-						node)) {
-			kfree(hctxs[i]);
-			hctxs[i] = NULL;
-			break;
-		}
-
-		atomic_set(&hctxs[i]->nr_active, 0);
-		hctxs[i]->numa_node = node;
-
-		if (blk_mq_init_hctx(q, set, hctxs[i], i)) {
-			free_cpumask_var(hctxs[i]->cpumask);
+		if (blk_mq_init_hctx(q, set, hctxs[i], i, node)) {
 			kfree(hctxs[i]);
 			hctxs[i] = NULL;
 			break;
@@ -1942,7 +1929,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 				set->tags[j] = NULL;
 			}
 			blk_mq_exit_hctx(q, set, hctx, j);
-			free_cpumask_var(hctx->cpumask);
 			kobject_put(&hctx->kobj);
 			kfree(hctx->ctxs);
 			kfree(hctx);
@@ -2037,7 +2023,6 @@ void blk_mq_free_queue(struct request_queue *q)
 	blk_mq_del_queue_tag_set(q);
 
 	blk_mq_exit_hw_queues(q, set);
-	blk_mq_free_hw_queues(q, set);
 }
 
 /* Basically redo blk_mq_init_queue with queue frozen */
-- 
1.8.3.1

