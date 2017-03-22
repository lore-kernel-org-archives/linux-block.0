Return-Path: <BATV+90a41d470eb0ea9eda9a+4959+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@sandisk.com,
	linux-block@vger.kernel.org
Subject: [PATCH 5/5] blk-mq: streamline blk_mq_make_request
Date: Wed, 22 Mar 2017 15:01:53 -0400
Message-Id: <20170322190153.12217-6-hch@lst.de>
In-Reply-To: <20170322190153.12217-1-hch@lst.de>
References: <20170322190153.12217-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Turn the different ways of merging or issuing I/O into a series of if/else
statements instead of the current maze of gotos.  Note that this means we
pin the CPU a little longer for some cases as the CTX put is moved to
common code at the end of the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 51 +++++++++++++++------------------------------------
 1 file changed, 15 insertions(+), 36 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9d2e02a8e02..45b9bebf8436 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1531,16 +1531,17 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	cookie = request_to_qc_t(data.hctx, rq);
 
+	plug = current->plug;
 	if (unlikely(is_flush_fua)) {
-		if (q->elevator)
-			goto elv_insert;
 		blk_mq_bio_to_request(rq, bio);
-		blk_insert_flush(rq);
-		goto run_queue;
-	}
-
-	plug = current->plug;
-	if (plug && q->nr_hw_queues == 1) {
+		if (q->elevator) {
+			blk_mq_sched_insert_request(rq, false, true, true,
+					true);
+		} else {
+			blk_insert_flush(rq);
+			blk_mq_run_hw_queue(data.hctx, true);
+		}
+	} else if (plug && q->nr_hw_queues == 1) {
 		struct request *last = NULL;
 
 		blk_mq_bio_to_request(rq, bio);
@@ -1559,8 +1560,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		else
 			last = list_entry_rq(plug->mq_list.prev);
 
-		blk_mq_put_ctx(data.ctx);
-
 		if (request_count >= BLK_MAX_REQUEST_COUNT || (last &&
 		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
 			blk_flush_plug_list(plug, false);
@@ -1568,7 +1567,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 
 		list_add_tail(&rq->queuelist, &plug->mq_list);
-		goto done;
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
@@ -1585,39 +1583,20 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			list_del_init(&same_queue_rq->queuelist);
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 
-		blk_mq_put_ctx(data.ctx);
 		if (same_queue_rq)
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
-		goto done;
-	} else if (is_sync) {
+	} else if (q->nr_hw_queues > 1 && is_sync) {
 		blk_mq_bio_to_request(rq, bio);
-
-		blk_mq_put_ctx(data.ctx);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
-		goto done;
-	}
-
-	if (q->elevator) {
-elv_insert:
-		blk_mq_put_ctx(data.ctx);
+	} else if (q->elevator) {
 		blk_mq_bio_to_request(rq, bio);
-		blk_mq_sched_insert_request(rq, false, true,
-						!is_sync || is_flush_fua, true);
-		goto done;
-	}
-	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
-		/*
-		 * For a SYNC request, send it to the hardware immediately. For
-		 * an ASYNC request, just ensure that we run it later on. The
-		 * latter allows for merging opportunities and more efficient
-		 * dispatching.
-		 */
-run_queue:
-		blk_mq_run_hw_queue(data.hctx, !is_sync || is_flush_fua);
+		blk_mq_sched_insert_request(rq, false, true, true, true);
+	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
+		blk_mq_run_hw_queue(data.hctx, true);
 	}
+
 	blk_mq_put_ctx(data.ctx);
-done:
 	return cookie;
 }
 
-- 
2.11.0
