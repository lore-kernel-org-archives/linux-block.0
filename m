Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753544AbdDOMkv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Apr 2017 08:40:51 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>,
        Jozef Mikovic <jmikovic@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] blk-mq: introduce BLK_MQ_F_SCHED_USE_HW_TAG
Date: Sat, 15 Apr 2017 20:38:24 +0800
Message-Id: <20170415123825.32716-4-ming.lei@redhat.com>
In-Reply-To: <20170415123825.32716-1-ming.lei@redhat.com>
References: <20170415123825.32716-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some drivers, for example of mtip32xx, use the 'request_index'
passed to .init_request() as hardware tag index for initializing
hardware queue, and these drivers actually require that rq->tag
is always same with 'request_index' passed to .init_request().

After blk-mq I/O scheduler is in, the driver tag is allocated
during dispatching, and the allocated driver tag can't be same
with I/O scheduler's tag, so blk-mq I/O scheduler breaks these
devices, like mtip32xx.

This patch introduces BLK_MQ_F_SCHED_USE_HW_TAG flag, and just
allocate hardware tag for scheduler directly, then we can address
mtip32xx's issue.

On the other hand, this feature should make blk-mq io scheduler
more efficient than current way if the hardware tag space is big
enough, because we can save one tag allocation/release.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c   | 10 +++++++++-
 block/blk-mq.c         | 35 +++++++++++++++++++++++++++++------
 include/linux/blk-mq.h |  1 +
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9e3c0f92851b..1ff4b61135bc 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -83,7 +83,12 @@ struct request *blk_mq_sched_get_request(struct request_queue *q,
 		data->hctx = blk_mq_map_queue(q, data->ctx->cpu);
 
 	if (e) {
-		data->flags |= BLK_MQ_REQ_INTERNAL;
+		/*
+		 * If BLK_MQ_F_SCHED_USE_HW_TAG is set, we use hardware
+		 * tag as scheduler tag.
+		 */
+		if (!(data->hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG))
+			data->flags |= BLK_MQ_REQ_INTERNAL;
 
 		/*
 		 * Flush requests are special and go directly to the
@@ -445,6 +450,9 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
 	struct blk_mq_tag_set *set = q->tag_set;
 	int ret;
 
+	if (hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG)
+		return 0;
+
 	hctx->sched_tags = blk_mq_alloc_rq_map(set, hctx_idx, q->nr_requests,
 					       set->reserved_tags);
 	if (!hctx->sched_tags)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e536dacfae4c..ac6245bdbc8c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -247,9 +247,19 @@ struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 				rq->rq_flags = RQF_MQ_INFLIGHT;
 				atomic_inc(&data->hctx->nr_active);
 			}
-			rq->tag = tag;
-			rq->internal_tag = -1;
-			data->hctx->tags->rqs[rq->tag] = rq;
+			data->hctx->tags->rqs[tag] = rq;
+
+			/*
+			 * If we use hw tag for scheduling, postpone setting
+			 * rq->tag in blk_mq_get_driver_tag().
+			 */
+			if (data->hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG) {
+				rq->tag = -1;
+				rq->internal_tag = tag;
+			} else {
+				rq->tag = tag;
+				rq->internal_tag = -1;
+			}
 		}
 
 		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
@@ -349,7 +359,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
-	if (sched_tag != -1)
+	if (sched_tag != -1 && !(hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG))
 		blk_mq_sched_completed_request(hctx, rq);
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
@@ -866,6 +876,12 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	if (rq->tag != -1)
 		goto done;
 
+	/* we buffered driver tag in rq->internal_tag */
+	if (data.hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG) {
+		rq->tag = rq->internal_tag;
+		goto done;
+	}
+
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
 		data.flags |= BLK_MQ_REQ_RESERVED;
 
@@ -887,9 +903,15 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
 				    struct request *rq)
 {
-	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, rq->tag);
+	unsigned tag = rq->tag;
+
 	rq->tag = -1;
 
+	if (hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG)
+		return;
+
+	blk_mq_put_tag(hctx, hctx->tags, rq->mq_ctx, tag);
+
 	if (rq->rq_flags & RQF_MQ_INFLIGHT) {
 		rq->rq_flags &= ~RQF_MQ_INFLIGHT;
 		atomic_dec(&hctx->nr_active);
@@ -2852,7 +2874,8 @@ bool blk_mq_poll(struct request_queue *q, blk_qc_t cookie)
 		blk_flush_plug_list(plug, false);
 
 	hctx = q->queue_hw_ctx[blk_qc_t_to_queue_num(cookie)];
-	if (!blk_qc_t_is_internal(cookie))
+	if (!blk_qc_t_is_internal(cookie) || (hctx->flags &
+			BLK_MQ_F_SCHED_USE_HW_TAG))
 		rq = blk_mq_tag_to_rq(hctx->tags, blk_qc_t_to_tag(cookie));
 	else
 		rq = blk_mq_tag_to_rq(hctx->sched_tags, blk_qc_t_to_tag(cookie));
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b90c3d5766cd..be605a05f340 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -154,6 +154,7 @@ enum {
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
+	BLK_MQ_F_SCHED_USE_HW_TAG	= 1 << 7,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
-- 
2.9.3
