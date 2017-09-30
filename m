Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: remove unused function hctx_allow_merges
To: weiping zhang <zhangweiping@didichuxing.com>
References: <20170930070143.GA14515@localhost.didichuxing.com>
Cc: linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fb885765-3243-15ee-da3c-272e0a2d3cc5@kernel.dk>
Date: Sat, 30 Sep 2017 10:15:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170930070143.GA14515@localhost.didichuxing.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/30/2017 09:01 AM, weiping zhang wrote:
> since 9bddeb2a5b981 "blk-mq: make per-sw-queue bio merge as default .bio_merge"
> there is no caller for this function.

Looks like this should change the new check to actually use this function
instead, or we will be doing merges if someone has turned off merging
through the sysfs 'nomerges' function.


diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4ab69435708c..5a3fe1bc5de6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -224,6 +224,12 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 	return false;
 }
 
+static inline bool hctx_allow_merges(struct blk_mq_hw_ctx *hctx)
+{
+	return (hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
+		!blk_queue_nomerges(hctx->queue);
+}
+
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
 	struct elevator_queue *e = q->elevator;
@@ -236,7 +242,7 @@ bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 		return e->type->ops.mq.bio_merge(hctx, bio);
 	}
 
-	if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
+	if (hctx_allow_merges(hctx)) {
 		/* default per sw-queue merge */
 		spin_lock(&ctx->lock);
 		ret = blk_mq_attempt_merge(q, ctx, bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 98a18609755e..59687ed6561b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1504,12 +1504,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 	blk_account_io_start(rq, true);
 }
 
-static inline bool hctx_allow_merges(struct blk_mq_hw_ctx *hctx)
-{
-	return (hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
-		!blk_queue_nomerges(hctx->queue);
-}
-
 static inline void blk_mq_queue_io(struct blk_mq_hw_ctx *hctx,
 				   struct blk_mq_ctx *ctx,
 				   struct request *rq)

-- 
Jens Axboe
