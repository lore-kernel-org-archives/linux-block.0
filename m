Return-Path: <BATV+90a41d470eb0ea9eda9a+4959+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@sandisk.com,
	linux-block@vger.kernel.org
Subject: [PATCH 3/5] blk-mq: improve blk_mq_try_issue_directly
Date: Wed, 22 Mar 2017 15:01:51 -0400
Message-Id: <20170322190153.12217-4-hch@lst.de>
In-Reply-To: <20170322190153.12217-1-hch@lst.de>
References: <20170322190153.12217-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Rename blk_mq_try_issue_directly to __blk_mq_try_issue_directly and add a
new wrapper that takes care of RCU / SRCU locking to avoid having
boileplate code in the caller which would get duplicated with new callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 block/blk-mq.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5a1ff4894285..e82e1a9c7d5e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1430,7 +1430,7 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
 }
 
-static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
+static void __blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 				      bool may_sleep)
 {
 	struct request_queue *q = rq->q;
@@ -1475,13 +1475,27 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 	blk_mq_sched_insert_request(rq, false, true, false, may_sleep);
 }
 
+static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, blk_qc_t *cookie)
+{
+	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
+		rcu_read_lock();
+		__blk_mq_try_issue_directly(rq, cookie, false);
+		rcu_read_unlock();
+	} else {
+		unsigned int srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
+		__blk_mq_try_issue_directly(rq, cookie, true);
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
@@ -1579,18 +1593,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		} else /* is_sync */
 			old_rq = rq;
 		blk_mq_put_ctx(data.ctx);
-		if (!old_rq)
-			goto done;
-
-		if (!(data.hctx->flags & BLK_MQ_F_BLOCKING)) {
-			rcu_read_lock();
-			blk_mq_try_issue_directly(old_rq, &cookie, false);
-			rcu_read_unlock();
-		} else {
-			srcu_idx = srcu_read_lock(&data.hctx->queue_rq_srcu);
-			blk_mq_try_issue_directly(old_rq, &cookie, true);
-			srcu_read_unlock(&data.hctx->queue_rq_srcu, srcu_idx);
-		}
+		if (old_rq)
+			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
 		goto done;
 	}
 
-- 
2.11.0
