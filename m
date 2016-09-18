Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932499AbcIRHhx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Sep 2016 03:37:53 -0400
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@redhat.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 14/14] blk-mq: Set flush_start_tag to BLK_MQ_MAX_DEPTH
Date: Sun, 18 Sep 2016 09:37:24 +0200
Message-Id: <1aa82162eff437f7f23f42d951e1249baf4faabf.1474183901.git.agordeev@redhat.com>
In-Reply-To: <cover.1474183901.git.agordeev@redhat.com>
References: <cover.1474183901.git.agordeev@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We need flush tags unique across hardware contexts and do
not overlap with normal tags. BLK_MQ_MAX_DEPTH as a base
number seems better choice than a queue's depth.

CC: linux-block@vger.kernel.org
Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
---
 block/blk-mq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c617002..d1f5c2e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1663,14 +1663,12 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
-	unsigned flush_start_tag = set->queue_depth;
-
 	blk_mq_tag_idle(hctx);
 
 	if (set->ops->exit_request)
 		set->ops->exit_request(set->driver_data,
 				       hctx->fq->flush_rq, hctx_idx,
-				       flush_start_tag + hctx_idx);
+				       BLK_MQ_MAX_DEPTH + hctx_idx);
 
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
@@ -1699,7 +1697,6 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set, unsigned hctx_idx)
 {
-	unsigned flush_start_tag = set->queue_depth;
 	struct blk_mq_hw_ctx *hctx;
 	int node;
 
@@ -1753,7 +1750,7 @@ static struct blk_mq_hw_ctx *blk_mq_init_hctx(struct request_queue *q,
 	if (set->ops->init_request &&
 	    set->ops->init_request(set->driver_data,
 				   hctx->fq->flush_rq, hctx_idx,
-				   flush_start_tag + hctx_idx, node))
+				   BLK_MQ_MAX_DEPTH + hctx_idx, node))
 		goto exit_hctx;
 
 	return hctx;
-- 
1.8.3.1

