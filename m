Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751751AbdEFAql (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 May 2017 20:46:41 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH] blk-mq: release sched tag just after getting driver tag
Date: Sat,  6 May 2017 08:46:02 +0800
Message-Id: <20170506004602.17508-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In theory sched tag is used just for scheduling, and its
lifetime should have been over just after rq is transfered to
dispatch queue. Unfortunately the rq itself is allocated from
tag set of .sched_tags, so we can't do that simply.

In this way, scheduler will have a independent queue depth,
and device's queue depth doesn't depend on schedluer's queue
depth any more.

This patch solves the issue by replacing the req in
hctx->sched_tag->static[rq->internal] with
hctx->tags->static[rq->tag] once the driver tag is allocated.

Also blk_mq_put_driver_tag() is removed because all these requests
need to be dispatched soon and it is reasonable to not release
the driver tag for cases of BLK_MQ_RQ_QUEUE_BUSY.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1996cab92841..32dce59fe437 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -855,6 +855,18 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
+static void blk_mq_replace_rq(struct blk_mq_hw_ctx *hctx, struct request *rq)
+{
+	struct request *rq_for_replacement = hctx->tags->static_rqs[rq->tag];
+
+	hctx->sched_tags->static_rqs[rq->internal_tag] = rq_for_replacement;
+	hctx->tags->static_rqs[rq->tag] = rq;
+
+	/* now transfer rq's ownership to driver tag*/
+	blk_mq_put_tag(hctx, hctx->sched_tags, rq->mq_ctx, rq->internal_tag);
+	rq->internal_tag = -1;
+}
+
 bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 			   bool wait)
 {
@@ -878,7 +890,9 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
 			atomic_inc(&data.hctx->nr_active);
 		}
+
 		data.hctx->tags->rqs[rq->tag] = rq;
+		blk_mq_replace_rq(data.hctx, rq);
 	}
 
 done:
@@ -887,38 +901,6 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	return rq->tag != -1;
 }
 
-static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
-				    struct request *rq)
-{
-	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
-	rq->tag = -1;
-
-	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
-		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
-		atomic_dec(&hctx->nr_active);
-	}
-}
-
-static void blk_mq_put_driver_tag_hctx(struct blk_mq_hw_ctx *hctx,
-				       struct request *rq)
-{
-	if (rq->tag == -1 || rq->internal_tag == -1)
-		return;
-
-	__blk_mq_put_driver_tag(hctx, rq);
-}
-
-static void blk_mq_put_driver_tag(struct request *rq)
-{
-	struct blk_mq_hw_ctx *hctx;
-
-	if (rq->tag == -1 || rq->internal_tag == -1)
-		return;
-
-	hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu);
-	__blk_mq_put_driver_tag(hctx, rq);
-}
-
 /*
  * If we fail getting a driver tag because all the driver tags are already
  * assigned and on the dispatch list, BUT the first entry does not have a
@@ -1041,7 +1023,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 			queued++;
 			break;
 		case BLK_MQ_RQ_QUEUE_BUSY:
-			blk_mq_put_driver_tag_hctx(hctx, rq);
 			list_add(&rq->queuelist, list);
 			__blk_mq_requeue_request(rq);
 			break;
@@ -1069,7 +1050,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 		 * tag for the next request already, free it again.
 		 */
 		rq = list_first_entry(list, struct request, queuelist);
-		blk_mq_put_driver_tag(rq);
 
 		spin_lock(&hctx->lock);
 		list_splice_init(list, &hctx->dispatch);
-- 
2.9.3
