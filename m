Return-Path: <prvs=80731d7bfe=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <jbacik@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/2] blk-mq: get rid of manual run of queue with __blk_mq_run_hw_queue()
Date: Thu, 22 Sep 2016 08:52:59 -0600
Message-ID: <1474555980-2787-2-git-send-email-axboe@fb.com>
In-Reply-To: <1474555980-2787-1-git-send-email-axboe@fb.com>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Two cases:

1) blk_mq_alloc_request() needlessly re-runs the queue, after
   calling into the tag allocation without NOWAIT set. We don't
   need to do that.

2) blk_mq_map_request() should just use blk_mq_run_hw_queue() with
   the async flag set to false.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e0a69daddbd8..c29700010b5c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -34,8 +34,6 @@
 static DEFINE_MUTEX(all_q_mutex);
 static LIST_HEAD(all_q_list);
 
-static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx);
-
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
@@ -228,19 +226,9 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 	ctx = blk_mq_get_ctx(q);
 	hctx = q->mq_ops->map_queue(q, ctx->cpu);
 	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
-
 	rq = __blk_mq_alloc_request(&alloc_data, rw, 0);
-	if (!rq && !(flags & BLK_MQ_REQ_NOWAIT)) {
-		__blk_mq_run_hw_queue(hctx);
-		blk_mq_put_ctx(ctx);
-
-		ctx = blk_mq_get_ctx(q);
-		hctx = q->mq_ops->map_queue(q, ctx->cpu);
-		blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
-		rq =  __blk_mq_alloc_request(&alloc_data, rw, 0);
-		ctx = alloc_data.ctx;
-	}
 	blk_mq_put_ctx(ctx);
+
 	if (!rq) {
 		blk_queue_exit(q);
 		return ERR_PTR(-EWOULDBLOCK);
@@ -1225,7 +1213,7 @@ static struct request *blk_mq_map_request(struct request_queue *q,
 	blk_mq_set_alloc_data(&alloc_data, q, BLK_MQ_REQ_NOWAIT, ctx, hctx);
 	rq = __blk_mq_alloc_request(&alloc_data, op, op_flags);
 	if (unlikely(!rq)) {
-		__blk_mq_run_hw_queue(hctx);
+		blk_mq_run_hw_queue(hctx, false);
 		blk_mq_put_ctx(ctx);
 		trace_block_sleeprq(q, bio, op);
 
-- 
2.7.4
