Return-Path: <BATV+790fc1df0de68f83423e+4778+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 22 Sep 2016 11:56:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, jbacik@fb.com
Subject: Re: [PATCH 1/2] blk-mq: get rid of manual run of queue with
 __blk_mq_run_hw_queue()
Message-ID: <20160922185603.GA32468@infradead.org>
References: <1474555980-2787-1-git-send-email-axboe@fb.com>
 <1474555980-2787-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474555980-2787-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

Ok, I looked into this a bit more, and while I'm still fine with the
patch I think it's only half of what we should do here.  There really
is no point in doing the first non-blocking path in blk_mq_map_request
either as bt_get itself already does the non-blocking pass, and also
runs the queue when scheduling in the later loop as well.  So to get
towards what I had in my tree we also need something like this:

---
>From c69bf02929d9c37d193b004a4c3c85c1142fa996 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 22 Sep 2016 11:38:23 -0700
Subject: blk-mq: remove non-blocking pass in blk_mq_map_request

bt_get already does a non-blocking pass as well as running the queue
when scheduling internally, no need to duplicate it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eae2f12..e9ebe98 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1210,20 +1210,8 @@ static struct request *blk_mq_map_request(struct request_queue *q,
 		op_flags |= REQ_SYNC;
 
 	trace_block_getrq(q, bio, op);
-	blk_mq_set_alloc_data(&alloc_data, q, BLK_MQ_REQ_NOWAIT, ctx, hctx);
+	blk_mq_set_alloc_data(&alloc_data, q, 0, ctx, hctx);
 	rq = __blk_mq_alloc_request(&alloc_data, op, op_flags);
-	if (unlikely(!rq)) {
-		blk_mq_run_hw_queue(hctx, false);
-		blk_mq_put_ctx(ctx);
-		trace_block_sleeprq(q, bio, op);
-
-		ctx = blk_mq_get_ctx(q);
-		hctx = q->mq_ops->map_queue(q, ctx->cpu);
-		blk_mq_set_alloc_data(&alloc_data, q, 0, ctx, hctx);
-		rq = __blk_mq_alloc_request(&alloc_data, op, op_flags);
-		ctx = alloc_data.ctx;
-		hctx = alloc_data.hctx;
-	}
 
 	hctx->queued++;
 	data->hctx = hctx;
-- 
2.1.4
