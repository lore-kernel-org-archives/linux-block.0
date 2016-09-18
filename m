Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36456 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758349AbcIRHhk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:40 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 08/14] blk-mq: Get rid of unnecessary blk_mq_free_hw_queues()
Date: Sun, 18 Sep 2016 09:37:18 +0200
Message-Id: <ebefdd0df6b24fd8e94854f8798fc609042f1dd1.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b2ef8f5..3efb700 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1686,17 +1686,8 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_exit_hctx(q, set, hctx, i);
-}
-
-static void blk_mq_free_hw_queues(struct request_queue *q,
-		struct blk_mq_tag_set *set)
-{
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-
 	queue_for_each_hw_ctx(q, hctx, i) {
+		blk_mq_exit_hctx(q, set, hctx, i);
 		free_cpumask_var(hctx->cpumask);
 		kfree(hctx->ctxs);
 		kfree(hctx);
@@ -2120,9 +2111,7 @@ void blk_mq_free_queue(struct request_queue *q)
 	mutex_unlock(&all_q_mutex);
 
 	blk_mq_del_queue_tag_set(q);
-
 	blk_mq_exit_hw_queues(q, set);
-	blk_mq_free_hw_queues(q, set);
 }
 
 /* Basically redo blk_mq_init_queue with queue frozen */
-- 
1.8.3.1

