Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933677AbcI3NXx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2016 09:23:53 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 8/8] blk-mq: Cleanup (de-)allocation of blk_mq_hw_ctx::ctxs
Date: Fri, 30 Sep 2016 15:23:30 +0200
Message-Id: <b118f85ab37b4ca83e4490df6416351e77ec29db.1475241231.git.agordeev@redhat.com>
In-Reply-To: <cover.1475241231.git.agordeev@redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Handling of blk_mq_hw_ctx::ctxs field (de-)allocation is
confusing due to special treatment of the field introduced
in commit c3b4afca7023 ("blk-mq: free hctx->ctxs in queue's
release handler")'. Make it bit more readable by binding
hctx and hctx->ctxs (de-)allocation.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 51 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 78ee5af..03654af 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1641,18 +1641,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
 	hctx->tags = set->tags[hctx_idx];
 
-	/*
-	 * Allocate space for all possible cpus to avoid allocation at
-	 * runtime
-	 */
-	hctx->ctxs = kmalloc_node(nr_cpu_ids * sizeof(void *),
-					GFP_KERNEL, node);
-	if (!hctx->ctxs)
-		goto unregister_cpu_notifier;
-
 	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8), GFP_KERNEL,
 			      node))
-		goto free_ctxs;
+		goto unregister_cpu_notifier;
 
 	hctx->nr_ctx = 0;
 
@@ -1679,8 +1670,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		set->ops->exit_hctx(hctx, hctx_idx);
  free_bitmap:
 	sbitmap_free(&hctx->ctx_map);
- free_ctxs:
-	kfree(hctx->ctxs);
  unregister_cpu_notifier:
 	blk_mq_remove_cpuhp(hctx);
 	free_cpumask_var(hctx->cpumask);
@@ -1848,6 +1837,33 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	mutex_unlock(&set->tag_list_lock);
 }
 
+static struct blk_mq_hw_ctx *alloc_hctx(int node)
+{
+	struct blk_mq_hw_ctx *hctx = kzalloc_node(sizeof(*hctx),
+					GFP_KERNEL, node);
+	if (!hctx)
+		return NULL;
+
+	/*
+	 * Allocate space for all possible cpus to avoid allocation at
+	 * runtime
+	 */
+	hctx->ctxs = kmalloc_node(nr_cpu_ids * sizeof(void *),
+					GFP_KERNEL, node);
+	if (!hctx->ctxs) {
+		kfree(hctx);
+		return NULL;
+	}
+
+	return hctx;
+}
+
+static void free_hctx(struct blk_mq_hw_ctx *hctx)
+{
+	kfree(hctx->ctxs);
+	kfree(hctx);
+}
+
 /*
  * It is the actual release handler for mq, but we do it from
  * request queue's release handler for avoiding use-after-free
@@ -1863,8 +1879,7 @@ void blk_mq_release(struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx)
 			continue;
-		kfree(hctx->ctxs);
-		kfree(hctx);
+		free_hctx(hctx);
 	}
 
 	q->mq_map = NULL;
@@ -1909,12 +1924,12 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		if (node == NUMA_NO_NODE)
 			node = set->numa_node;
 
-		hctx = kzalloc_node(sizeof(*hctx), GFP_KERNEL, node);
+		hctx = alloc_hctx(node);
 		if (!hctx)
 			break;
 
 		if (blk_mq_init_hctx(q, set, hctx, i, node)) {
-			kfree(hctx);
+			free_hctx(hctx);
 			break;
 		}
 
@@ -1936,9 +1951,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		}
 
 		blk_mq_exit_hctx(q, set, hctx, j);
-
-		kfree(hctx->ctxs);
-		kfree(hctx);
+		free_hctx(hctx);
 	}
 	q->nr_hw_queues = i;
 	blk_mq_sysfs_register(q);
-- 
1.8.3.1

