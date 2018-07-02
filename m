Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH V3 2/3] blk-mq: only attempt to merge bio if there is rq in sw queue
Date: Mon,  2 Jul 2018 17:35:59 +0800
Message-Id: <20180702093600.10315-3-ming.lei@redhat.com>
In-Reply-To: <20180702093600.10315-1-ming.lei@redhat.com>
References: <20180702093600.10315-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Only attempt to merge bio iff the ctx->rq_list isn't empty, because:

1) for high-performance SSD, most of times dispatch may succeed, then
there may be nothing left in ctx->rq_list, so don't try to merge over
sw queue if it is empty, then we can save one acquiring of ctx->lock

2) we can't expect good merge performance on per-cpu sw queue, and missing
one merge on sw queue won't be a big deal since tasks can be scheduled from
one CPU to another.

Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 56c493c6cd90..f5745acc2d98 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -339,7 +339,8 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 		return e->type->ops.mq.bio_merge(hctx, bio);
 	}
 
-	if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
+	if ((hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
+			!list_empty_careful(&ctx->rq_list)) {
 		/* default per sw-queue merge */
 		spin_lock(&ctx->lock);
 		ret = blk_mq_attempt_merge(q, ctx, bio);
-- 
2.9.5
