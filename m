Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Omar Sandoval <osandov@fb.com>,
	Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 01/10] blk-mq: mark blk_mq_rq_ctx_init static
Date: Fri, 16 Jun 2017 18:15:18 +0200
Message-Id: <20170616161527.17649-2-hch@lst.de>
In-Reply-To: <20170616161527.17649-1-hch@lst.de>
References: <20170616161527.17649-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 5 ++---
 block/blk-mq.h | 2 --
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 359d2dc0d414..e1d650804c8e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -204,8 +204,8 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 }
 EXPORT_SYMBOL(blk_mq_can_queue);
 
-void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
-			struct request *rq, unsigned int op)
+static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
+		struct request *rq, unsigned int op)
 {
 	INIT_LIST_HEAD(&rq->queuelist);
 	/* csd/requeue_work/fifo_time is initialized before use */
@@ -243,7 +243,6 @@ void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 
 	ctx->rq_dispatched[op_is_sync(op)]++;
 }
-EXPORT_SYMBOL_GPL(blk_mq_rq_ctx_init);
 
 struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
 				       unsigned int op)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index cc67b48e3551..806fed53f607 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -131,8 +131,6 @@ static inline struct blk_mq_tags *blk_mq_tags_from_data(struct blk_mq_alloc_data
 /*
  * Internal helpers for request allocation/init/free
  */
-void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
-			struct request *rq, unsigned int op);
 void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 				struct request *rq);
 void blk_mq_finish_request(struct request *rq);
-- 
2.11.0
