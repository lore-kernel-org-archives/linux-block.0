Return-Path: <zhangweiping@didichuxing.com>
Date: Sat, 30 Sep 2017 15:01:48 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] blk-mq: remove unused function hctx_allow_merges
Message-ID: <20170930070143.GA14515@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

since 9bddeb2a5b981 "blk-mq: make per-sw-queue bio merge as default .bio_merge"
there is no caller for this function.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/blk-mq.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f84d145..520d257 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1484,12 +1484,6 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
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
2.9.4
