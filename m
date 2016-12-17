Return-Path: <prvs=1159fc908b=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/8] blk-mq: un-export blk_mq_free_hctx_request()
Date: Fri, 16 Dec 2016 17:12:12 -0700
Message-ID: <1481933536-12844-5-git-send-email-axboe@fb.com>
In-Reply-To: <1481933536-12844-1-git-send-email-axboe@fb.com>
References: <1481933536-12844-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

It's only used in blk-mq, kill it from the main exported header
and kill the symbol export as well.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c         | 5 ++---
 include/linux/blk-mq.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 87b7eaa1cb74..6eeae30cc027 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -337,15 +337,14 @@ static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
 	blk_queue_exit(q);
 }
 
-void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *hctx, struct request *rq)
+static void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *hctx,
+				     struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
 	ctx->rq_completed[rq_is_sync(rq)]++;
 	__blk_mq_free_request(hctx, ctx, rq);
-
 }
-EXPORT_SYMBOL_GPL(blk_mq_free_hctx_request);
 
 void blk_mq_free_request(struct request *rq)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index afc81d77e471..2686f9e7302a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -181,7 +181,6 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
 
 void blk_mq_insert_request(struct request *, bool, bool, bool);
 void blk_mq_free_request(struct request *rq);
-void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *, struct request *rq);
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
 
 enum {
-- 
2.7.4
