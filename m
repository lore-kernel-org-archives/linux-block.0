Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: count the hctx as active before allocate tag
Date: Wed,  8 Aug 2018 16:22:28 +0800
Message-Id: <1533716548-1645-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Currently, we count the hctx as active after allocate tag
successfully. The other shared-tags users could exhaust the tags
and starve a non-active and waiting-tag hctx. Count the hctx as
active before try to allocate tag to fix this.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae44e85..acd40eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -369,6 +369,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 			e->type->ops.mq.limit_depth(op, data);
 	}
 
+	blk_mq_tag_busy(data.hctx);
+
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
 		if (put_ctx_on_error) {
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
