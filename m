Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] blk-mq: count the hctx as active before allocate tag
Date: Wed,  8 Aug 2018 17:56:52 +0800
Message-Id: <1533722212-20327-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Currently, we count the hctx as active after allocate driver tag
successfully. The other shared-tags users could exhaust the driver
tags and starve a non-active and waiting-tag hctx. Count the hctx as
active before try to allocate driver tag to fix this.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
V2:
   only invoke blk_mq_tag_busy w/o io scheduler in blk_mq_get_request

 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae44e85..75ac3fbd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -285,7 +285,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->tag = -1;
 		rq->internal_tag = tag;
 	} else {
-		if (blk_mq_tag_busy(data->hctx)) {
+		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
 			atomic_inc(&data->hctx->nr_active);
 		}
@@ -367,6 +367,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		if (!op_is_flush(op) && e->type->ops.mq.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.mq.limit_depth(op, data);
+	} else {
+		blk_mq_tag_busy(data->hctx);
 	}
 
 	tag = blk_mq_get_tag(data);
@@ -972,6 +974,7 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 		.hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu),
 		.flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
 	};
+	bool shared;
 
 	might_sleep_if(wait);
 
@@ -981,9 +984,10 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
 		data.flags |= BLK_MQ_REQ_RESERVED;
 
+	shared = blk_mq_tag_busy(data.hctx);
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
-		if (blk_mq_tag_busy(data.hctx)) {
+		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
 			atomic_inc(&data.hctx->nr_active);
 		}
-- 
2.7.4
