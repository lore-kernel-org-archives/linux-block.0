Return-Path: <BATV+b8442eb9fd62b0a9e465+4950+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/4] blk-mq: streamline blk_mq_make_request
Date: Mon, 13 Mar 2017 09:48:33 -0600
Message-Id: <20170313154833.14165-5-hch@lst.de>
In-Reply-To: <20170313154833.14165-1-hch@lst.de>
References: <20170313154833.14165-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Turn the different ways of merging or issuing I/O into a series of if/else
statements instead of the current maze of gotos.  Note that this means we
pin the CPU a little longer for some cases as the CTX put is moved to
common code at the end of the function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 67 +++++++++++++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 48748cb799ed..18e449cc832f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1534,16 +1534,17 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
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
+			blk_mq_sched_insert_request(rq, false, true,
+						!is_sync || is_flush_fua, true);
+		} else {
+			blk_insert_flush(rq);
+			blk_mq_run_hw_queue(data.hctx, !is_sync || is_flush_fua);
+		}
+	} else if (plug && q->nr_hw_queues == 1) {
 		struct request *last = NULL;
 
 		blk_mq_bio_to_request(rq, bio);
@@ -1562,8 +1563,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		else
 			last = list_entry_rq(plug->mq_list.prev);
 
-		blk_mq_put_ctx(data.ctx);
-
 		if (request_count >= BLK_MAX_REQUEST_COUNT || (last &&
 		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
 			blk_flush_plug_list(plug, false);
@@ -1571,56 +1570,44 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		}
 
 		list_add_tail(&rq->queuelist, &plug->mq_list);
-		goto done;
-	} else if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
-		struct request *old_rq = NULL;
-
+	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
 		/*
 		 * We do limited plugging. If the bio can be merged, do that.
 		 * Otherwise the existing request in the plug list will be
 		 * issued. So the plug list will have one request at most
+		 *
+		 * The plug list might get flushed before this. If that happens,
+		 * the plug list is emptry and same_queue_rq is invalid.
 		 */
-		if (plug) {
-			/*
-			 * The plug list might get flushed before this. If that
-			 * happens, same_queue_rq is invalid and plug list is
-			 * empty
-			 */
-			if (same_queue_rq && !list_empty(&plug->mq_list)) {
-				old_rq = same_queue_rq;
-				list_del_init(&old_rq->queuelist);
-			}
-			list_add_tail(&rq->queuelist, &plug->mq_list);
-		} else /* is_sync */
-			old_rq = rq;
-		blk_mq_put_ctx(data.ctx);
-		if (old_rq)
-			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
-		goto done;
-	}
+		if (!list_empty(&plug->mq_list))
+			list_del_init(&same_queue_rq->queuelist);
+		else
+			same_queue_rq = NULL;
 
-	if (q->elevator) {
-elv_insert:
-		blk_mq_put_ctx(data.ctx);
+		list_add_tail(&rq->queuelist, &plug->mq_list);
+		if (same_queue_rq)
+			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
+					&cookie);
+	} else if (is_sync) {
+		blk_mq_bio_to_request(rq, bio);
+		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+	} else if (q->elevator) {
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_sched_insert_request(rq, false, true,
 						!is_sync || is_flush_fua, true);
-		goto done;
-	}
-	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
+	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
 		/*
 		 * For a SYNC request, send it to the hardware immediately. For
 		 * an ASYNC request, just ensure that we run it later on. The
 		 * latter allows for merging opportunities and more efficient
 		 * dispatching.
 		 */
-run_queue:
 		blk_mq_run_hw_queue(data.hctx, !is_sync || is_flush_fua);
 	}
+
 	blk_mq_put_ctx(data.ctx);
-done:
 	return cookie;
 }
 
-- 
2.11.0
