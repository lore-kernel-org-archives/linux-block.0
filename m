Return-Path: <BATV+b8442eb9fd62b0a9e465+4950+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 3/4] blk-mq: improve blk_mq_try_issue_directly
Date: Mon, 13 Mar 2017 09:48:32 -0600
Message-Id: <20170313154833.14165-4-hch@lst.de>
In-Reply-To: <20170313154833.14165-1-hch@lst.de>
References: <20170313154833.14165-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Rename blk_mq_try_issue_directly to __blk_mq_try_issue_directly and add a
new wrapper that takes care of RCU / SRCU locking to avoid having
boileplate code in the caller which would get duplicated with new callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 53e49a3f6f0a..48748cb799ed 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1434,7 +1434,7 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
 }
 
-static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
+static void __blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
 {
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
@@ -1478,13 +1478,27 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
 	blk_mq_sched_insert_request(rq, false, true, true, false);
 }
 
+static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, blk_qc_t *cookie)
+{
+	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
+		rcu_read_lock();
+		__blk_mq_try_issue_directly(rq, cookie);
+		rcu_read_unlock();
+	} else {
+		unsigned int srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
+		__blk_mq_try_issue_directly(rq, cookie);
+		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
+	}
+}
+
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
 	struct blk_mq_alloc_data data = { .flags = 0 };
 	struct request *rq;
-	unsigned int request_count = 0, srcu_idx;
+	unsigned int request_count = 0;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
 	blk_qc_t cookie;
@@ -1582,18 +1596,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		} else /* is_sync */
 			old_rq = rq;
 		blk_mq_put_ctx(data.ctx);
-		if (!old_rq)
-			goto done;
-
-		if (!(data.hctx->flags & BLK_MQ_F_BLOCKING)) {
-			rcu_read_lock();
-			blk_mq_try_issue_directly(old_rq, &cookie);
-			rcu_read_unlock();
-		} else {
-			srcu_idx = srcu_read_lock(&data.hctx->queue_rq_srcu);
-			blk_mq_try_issue_directly(old_rq, &cookie);
-			srcu_read_unlock(&data.hctx->queue_rq_srcu, srcu_idx);
-		}
+		if (old_rq)
+			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
 		goto done;
 	}
 
-- 
2.11.0
