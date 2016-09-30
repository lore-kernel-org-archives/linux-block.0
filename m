Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933651AbcI3NXu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2016 09:23:50 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 6/8] blk-mq: Rework blk_mq_realloc_hw_ctxs()
Date: Fri, 30 Sep 2016 15:23:28 +0200
Message-Id: <7459c980dd965b5f7b91e3bf1c3114d658535229.1475241231.git.agordeev@redhat.com>
In-Reply-To: <cover.1475241231.git.agordeev@redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Rework blk_mq_realloc_hw_ctxs() so deallocation is done in order
reverse to allocation and indentation is bit more easy to read.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 15c03c2..4b07901 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1895,6 +1895,7 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
 	int i, j;
+	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	blk_mq_sysfs_unregister(q);
@@ -1908,33 +1909,36 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		if (node == NUMA_NO_NODE)
 			node = set->numa_node;
 
-		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
-					GFP_KERNEL, node);
-		if (!hctxs[i])
+		hctx = kzalloc_node(sizeof(*hctx), GFP_KERNEL, node);
+		if (!hctx)
 			break;
 
-		if (blk_mq_init_hctx(q, set, hctxs[i], i, node)) {
-			kfree(hctxs[i]);
-			hctxs[i] = NULL;
+		if (blk_mq_init_hctx(q, set, hctx, i, node)) {
+			kfree(hctx);
 			break;
 		}
-		blk_mq_hctx_kobj_init(hctxs[i]);
+
+		blk_mq_hctx_kobj_init(hctx);
+		hctxs[i] = hctx;
 	}
 	for (j = i; j < q->nr_hw_queues; j++) {
-		struct blk_mq_hw_ctx *hctx = hctxs[j];
+		hctx = hctxs[i];
 
-		if (hctx) {
-			if (hctx->tags) {
-				blk_mq_free_rq_map(set, hctx->tags, j);
-				set->tags[j] = NULL;
-			}
-			blk_mq_exit_hctx(q, set, hctx, j);
-			kobject_put(&hctx->kobj);
-			kfree(hctx->ctxs);
-			kfree(hctx);
-			hctxs[j] = NULL;
+		if (!hctx)
+			continue;
 
+		hctxs[i] = NULL;
+		kobject_put(&hctx->kobj);
+
+		if (hctx->tags) {
+			blk_mq_free_rq_map(set, hctx->tags, j);
+			set->tags[j] = NULL;
 		}
+
+		blk_mq_exit_hctx(q, set, hctx, j);
+
+		kfree(hctx->ctxs);
+		kfree(hctx);
 	}
 	q->nr_hw_queues = i;
 	blk_mq_sysfs_register(q);
-- 
1.8.3.1

