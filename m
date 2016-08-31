Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-dm3nam03on0058.outbound.protection.outlook.com ([104.47.41.58]:12704
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1759519AbcHaWSc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2016 18:18:32 -0400
To: Jens Axboe <axboe@fb.com>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH] blk-mq: Use non-atomic operations to manipulate the sw-ctx
 busy bits
Message-ID: <aa1d8314-3c5e-4554-61e1-95c61aa11624@sandisk.com>
Date: Wed, 31 Aug 2016 15:03:24 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Protect sw-ctx busy bit manipulations via the sw queue lock.
This allows to convert the atomic bit operations into slightly
faster non-atomic operations. Document that blk_mq_run_hw_queues()
tests these bits without holding the sw queue lock.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 13f5a6c..0dcafa6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -66,8 +66,9 @@ static void blk_mq_hctx_mark_pending(struct blk_mq_hw_ctx *hctx,
 {
 	struct blk_align_bitmap *bm = get_bm(hctx, ctx);
 
+	lockdep_assert_held(&ctx->lock);
 	if (!test_bit(CTX_TO_BIT(hctx, ctx), &bm->word))
-		set_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
+		__set_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
 }
 
 static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
@@ -75,7 +76,8 @@ static void blk_mq_hctx_clear_pending(struct blk_mq_hw_ctx *hctx,
 {
 	struct blk_align_bitmap *bm = get_bm(hctx, ctx);
 
-	clear_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
+	lockdep_assert_held(&ctx->lock);
+	__clear_bit(CTX_TO_BIT(hctx, ctx), &bm->word);
 }
 
 void blk_mq_freeze_queue_start(struct request_queue *q)
@@ -768,8 +770,8 @@ static void flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 				break;
 
 			ctx = hctx->ctxs[bit + off];
-			clear_bit(bit, &bm->word);
 			spin_lock(&ctx->lock);
+			__clear_bit(bit, &bm->word);
 			list_splice_tail_init(&ctx->rq_list, list);
 			spin_unlock(&ctx->lock);
 
@@ -940,6 +942,13 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 			&hctx->run_work, 0);
 }
 
+/**
+ * blk_mq_run_hw_queues - run all hardware queues
+ *
+ * Note: this function checks the SW and HW busy status without serialization
+ * against the functions that modify that status information. The caller is
+ * responsible for realizing that serialization.
+ */
 void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 {
 	struct blk_mq_hw_ctx *hctx;
@@ -1055,6 +1064,7 @@ static void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
+	lockdep_assert_held(&ctx->lock);
 	__blk_mq_insert_req_list(hctx, rq, at_head);
 	blk_mq_hctx_mark_pending(hctx, ctx);
 }
-- 
2.9.3

