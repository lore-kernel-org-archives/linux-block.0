Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753224AbcIRHhi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:38 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 06/14] blk-mq: Fix hardware context data node selection
Date: Sun, 18 Sep 2016 09:37:16 +0200
Message-Id: <2ca00b95f42aefc5423ab09db0c50fcd3e5ee578.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a38fd2e..9fbfe31 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1712,13 +1712,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned hctx_idx)
 {
-	int node;
+	int node = hctx->numa_node;
 	unsigned flush_start_tag = set->queue_depth;
 
-	node = hctx->numa_node;
-	if (node == NUMA_NO_NODE)
-		node = hctx->numa_node = set->numa_node;
-
 	INIT_WORK(&hctx->run_work, blk_mq_run_work_fn);
 	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
 	spin_lock_init(&hctx->lock);
@@ -1999,6 +1995,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			break;
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
+		if (node == NUMA_NO_NODE)
+			node = set->numa_node;
+
 		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
 					GFP_KERNEL, node);
 		if (!hctxs[i])
-- 
1.8.3.1

