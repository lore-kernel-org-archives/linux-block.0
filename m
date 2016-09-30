Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933619AbcI3NXr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Sep 2016 09:23:47 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH v2 3/8] blk-mq: Fix hardware context data node selection
Date: Fri, 30 Sep 2016 15:23:25 +0200
Message-Id: <326a467ee21f2324c9161f7f814a3ed9780dc767.1475241231.git.agordeev@redhat.com>
In-Reply-To: <cover.1475241231.git.agordeev@redhat.com>
References: <cover.1475241231.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 92c2519..e3e9b23 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1633,13 +1633,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
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
@@ -1914,6 +1910,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 			continue;
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
+		if (node == NUMA_NO_NODE)
+			node = set->numa_node;
+
 		hctxs[i] = kzalloc_node(sizeof(struct blk_mq_hw_ctx),
 					GFP_KERNEL, node);
 		if (!hctxs[i])
-- 
1.8.3.1

