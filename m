Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933418AbdKBPZ3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Nov 2017 11:25:29 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/7] block: pass 'run_queue' to blk_mq_request_bypass_insert
Date: Thu,  2 Nov 2017 23:24:34 +0800
Message-Id: <20171102152438.25324-4-ming.lei@redhat.com>
In-Reply-To: <20171102152438.25324-1-ming.lei@redhat.com>
References: <20171102152438.25324-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Block flush need this function without running queue, so introduce the
parameter.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 2 +-
 block/blk-mq.c   | 5 +++--
 block/blk-mq.h   | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bb4fce694a60..279d9f41a492 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2352,7 +2352,7 @@ blk_status_t blk_insert_cloned_request(struct request_queue *q, struct request *
 		 * bypass a potential scheduler on the bottom device for
 		 * insert.
 		 */
-		blk_mq_request_bypass_insert(rq);
+		blk_mq_request_bypass_insert(rq, true);
 		return BLK_STS_OK;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fe14b28760eb..5e2866b83305 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1495,7 +1495,7 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
  * Should only be used carefully, when the caller knows we want to
  * bypass a potential IO scheduler on the target device.
  */
-void blk_mq_request_bypass_insert(struct request *rq)
+void blk_mq_request_bypass_insert(struct request *rq, bool run_queue)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, ctx->cpu);
@@ -1504,7 +1504,8 @@ void blk_mq_request_bypass_insert(struct request *rq)
 	list_add_tail(&rq->queuelist, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
 
-	blk_mq_run_hw_queue(hctx, false);
+	if (run_queue)
+		blk_mq_run_hw_queue(hctx, false);
 }
 
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 522b420dedc0..713be5ae83ba 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -56,7 +56,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
  */
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 				bool at_head);
-void blk_mq_request_bypass_insert(struct request *rq);
+void blk_mq_request_bypass_insert(struct request *rq, bool run_queue);
 void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct list_head *list);
 
-- 
2.9.5
