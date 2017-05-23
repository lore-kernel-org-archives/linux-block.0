Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933875AbdEWLsA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2017 07:48:00 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] blk-mq: merge bio into sw queue before plugging
Date: Tue, 23 May 2017 19:47:35 +0800
Message-Id: <20170523114736.12026-2-ming.lei@redhat.com>
In-Reply-To: <20170523114736.12026-1-ming.lei@redhat.com>
References: <20170523114736.12026-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Before blk-mq is introduced, I/O is merged to elevator
before being putted into plug queue, but blk-mq changed the
order and makes merging to sw queue basically impossible.
Then it is observed that throughput of sequential I/O is degraded
about 10%~20% on virtio-blk in the test[1] if mq-deadline isn't used.

This patch moves the bio merging per sw queue before plugging,
like what blk_queue_bio() does, and the performance regression is
fixed under this situation.

[1]. test script:
sudo fio --direct=1 --size=128G --bsrange=4k-4k --runtime=40 --numjobs=16 --ioengine=libaio --iodepth=64 --group_reporting=1 --filename=/dev/vdb --name=virtio_blk-test-$RW --rw=$RW --output-format=json

RW=read or write

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a69ad122ed66..b7ca64ef15e8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1446,30 +1446,31 @@ static inline bool hctx_allow_merges(struct blk_mq_hw_ctx *hctx)
 		!blk_queue_nomerges(hctx->queue);
 }
 
-static inline bool blk_mq_merge_queue_io(struct blk_mq_hw_ctx *hctx,
-					 struct blk_mq_ctx *ctx,
-					 struct request *rq, struct bio *bio)
+/* attempt to merge bio into current sw queue */
+static inline bool blk_mq_merge_bio(struct request_queue *q, struct bio *bio)
 {
-	if (!hctx_allow_merges(hctx) || !bio_mergeable(bio)) {
-		blk_mq_bio_to_request(rq, bio);
-		spin_lock(&ctx->lock);
-insert_rq:
-		__blk_mq_insert_request(hctx, rq, false);
-		spin_unlock(&ctx->lock);
-		return false;
-	} else {
-		struct request_queue *q = hctx->queue;
+	bool ret = false;
+	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 
-		spin_lock(&ctx->lock);
-		if (!blk_mq_attempt_merge(q, ctx, bio)) {
-			blk_mq_bio_to_request(rq, bio);
-			goto insert_rq;
-		}
+	if (!hctx_allow_merges(hctx) || !bio_mergeable(bio))
+		goto exit;
 
-		spin_unlock(&ctx->lock);
-		__blk_mq_finish_request(hctx, ctx, rq);
-		return true;
-	}
+	spin_lock(&ctx->lock);
+	ret = blk_mq_attempt_merge(q, ctx, bio);
+	spin_unlock(&ctx->lock);
+exit:
+	blk_mq_put_ctx(ctx);
+	return ret;
+}
+
+static inline void blk_mq_queue_io(struct blk_mq_hw_ctx *hctx,
+				   struct blk_mq_ctx *ctx,
+				   struct request *rq)
+{
+	spin_lock(&ctx->lock);
+	__blk_mq_insert_request(hctx, rq, false);
+	spin_unlock(&ctx->lock);
 }
 
 static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
@@ -1568,6 +1569,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	if (blk_mq_sched_bio_merge(q, bio))
 		return BLK_QC_T_NONE;
 
+	if (blk_mq_merge_bio(q, bio))
+		return BLK_QC_T_NONE;
+
 	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
 
 	trace_block_getrq(q, bio, bio->bi_opf);
@@ -1649,11 +1653,12 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_sched_insert_request(rq, false, true, true, true);
-	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
+	} else {
 		blk_mq_put_ctx(data.ctx);
+		blk_mq_bio_to_request(rq, bio);
+		blk_mq_queue_io(data.hctx, data.ctx, rq);
 		blk_mq_run_hw_queue(data.hctx, true);
-	} else
-		blk_mq_put_ctx(data.ctx);
+	}
 
 	return cookie;
 }
-- 
2.9.4
