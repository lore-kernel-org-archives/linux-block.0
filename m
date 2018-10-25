Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/28] block: remove non mq parts from the flush code
Date: Thu, 25 Oct 2018 15:10:29 -0600
Message-Id: <20181025211039.11559-19-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-flush.c | 154 +++++++++-------------------------------------
 block/blk.h       |   4 +-
 2 files changed, 31 insertions(+), 127 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 8b44b86779da..9baa9a119447 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -134,16 +134,8 @@ static void blk_flush_restore_request(struct request *rq)
 
 static bool blk_flush_queue_rq(struct request *rq, bool add_front)
 {
-	if (rq->q->mq_ops) {
-		blk_mq_add_to_requeue_list(rq, add_front, true);
-		return false;
-	} else {
-		if (add_front)
-			list_add(&rq->queuelist, &rq->q->queue_head);
-		else
-			list_add_tail(&rq->queuelist, &rq->q->queue_head);
-		return true;
-	}
+	blk_mq_add_to_requeue_list(rq, add_front, true);
+	return false;
 }
 
 /**
@@ -204,10 +196,7 @@ static bool blk_flush_complete_seq(struct request *rq,
 		BUG_ON(!list_empty(&rq->queuelist));
 		list_del_init(&rq->flush.list);
 		blk_flush_restore_request(rq);
-		if (q->mq_ops)
-			blk_mq_end_request(rq, error);
-		else
-			__blk_end_request_all(rq, error);
+		blk_mq_end_request(rq, error);
 		break;
 
 	default:
@@ -226,20 +215,17 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	struct request *rq, *n;
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
+	struct blk_mq_hw_ctx *hctx;
 
-	if (q->mq_ops) {
-		struct blk_mq_hw_ctx *hctx;
-
-		/* release the tag's ownership to the req cloned from */
-		spin_lock_irqsave(&fq->mq_flush_lock, flags);
-		hctx = blk_mq_map_queue(q, flush_rq->mq_ctx->cpu);
-		if (!q->elevator) {
-			blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
-			flush_rq->tag = -1;
-		} else {
-			blk_mq_put_driver_tag_hctx(hctx, flush_rq);
-			flush_rq->internal_tag = -1;
-		}
+	/* release the tag's ownership to the req cloned from */
+	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	hctx = blk_mq_map_queue(q, flush_rq->mq_ctx->cpu);
+	if (!q->elevator) {
+		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
+		flush_rq->tag = -1;
+	} else {
+		blk_mq_put_driver_tag_hctx(hctx, flush_rq);
+		flush_rq->internal_tag = -1;
 	}
 
 	running = &fq->flush_queue[fq->flush_running_idx];
@@ -248,9 +234,6 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 	/* account completion of the flush request */
 	fq->flush_running_idx ^= 1;
 
-	if (!q->mq_ops)
-		elv_completed_request(q, flush_rq);
-
 	/* and push the waiting requests to the next stage */
 	list_for_each_entry_safe(rq, n, running, flush.list) {
 		unsigned int seq = blk_flush_cur_seq(rq);
@@ -259,24 +242,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		queued |= blk_flush_complete_seq(rq, fq, seq, error);
 	}
 
-	/*
-	 * Kick the queue to avoid stall for two cases:
-	 * 1. Moving a request silently to empty queue_head may stall the
-	 * queue.
-	 * 2. When flush request is running in non-queueable queue, the
-	 * queue is hold. Restart the queue after flush request is finished
-	 * to avoid stall.
-	 * This function is called from request completion path and calling
-	 * directly into request_fn may confuse the driver.  Always use
-	 * kblockd.
-	 */
-	if (queued || fq->flush_queue_delayed) {
-		WARN_ON(q->mq_ops);
-		blk_run_queue_async(q);
-	}
 	fq->flush_queue_delayed = 0;
-	if (q->mq_ops)
-		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
+	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 }
 
 /**
@@ -301,6 +268,7 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	struct request *first_rq =
 		list_first_entry(pending, struct request, flush.list);
 	struct request *flush_rq = fq->flush_rq;
+	struct blk_mq_hw_ctx *hctx;
 
 	/* C1 described at the top of this file */
 	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
@@ -334,19 +302,15 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	 * In case of IO scheduler, flush rq need to borrow scheduler tag
 	 * just for cheating put/get driver tag.
 	 */
-	if (q->mq_ops) {
-		struct blk_mq_hw_ctx *hctx;
-
-		flush_rq->mq_ctx = first_rq->mq_ctx;
-
-		if (!q->elevator) {
-			fq->orig_rq = first_rq;
-			flush_rq->tag = first_rq->tag;
-			hctx = blk_mq_map_queue(q, first_rq->mq_ctx->cpu);
-			blk_mq_tag_set_rq(hctx, first_rq->tag, flush_rq);
-		} else {
-			flush_rq->internal_tag = first_rq->internal_tag;
-		}
+	flush_rq->mq_ctx = first_rq->mq_ctx;
+
+	if (!q->elevator) {
+		fq->orig_rq = first_rq;
+		flush_rq->tag = first_rq->tag;
+		hctx = blk_mq_map_queue(q, first_rq->mq_ctx->cpu);
+		blk_mq_tag_set_rq(hctx, first_rq->tag, flush_rq);
+	} else {
+		flush_rq->internal_tag = first_rq->internal_tag;
 	}
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
@@ -358,49 +322,6 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	return blk_flush_queue_rq(flush_rq, false);
 }
 
-static void flush_data_end_io(struct request *rq, blk_status_t error)
-{
-	struct request_queue *q = rq->q;
-	struct blk_flush_queue *fq = blk_get_flush_queue(q, NULL);
-
-	lockdep_assert_held(q->queue_lock);
-
-	/*
-	 * Updating q->in_flight[] here for making this tag usable
-	 * early. Because in blk_queue_start_tag(),
-	 * q->in_flight[BLK_RW_ASYNC] is used to limit async I/O and
-	 * reserve tags for sync I/O.
-	 *
-	 * More importantly this way can avoid the following I/O
-	 * deadlock:
-	 *
-	 * - suppose there are 40 fua requests comming to flush queue
-	 *   and queue depth is 31
-	 * - 30 rqs are scheduled then blk_queue_start_tag() can't alloc
-	 *   tag for async I/O any more
-	 * - all the 30 rqs are completed before FLUSH_PENDING_TIMEOUT
-	 *   and flush_data_end_io() is called
-	 * - the other rqs still can't go ahead if not updating
-	 *   q->in_flight[BLK_RW_ASYNC] here, meantime these rqs
-	 *   are held in flush data queue and make no progress of
-	 *   handling post flush rq
-	 * - only after the post flush rq is handled, all these rqs
-	 *   can be completed
-	 */
-
-	elv_completed_request(q, rq);
-
-	/* for avoiding double accounting */
-	rq->rq_flags &= ~RQF_STARTED;
-
-	/*
-	 * After populating an empty queue, kick it to avoid stall.  Read
-	 * the comment in flush_end_io().
-	 */
-	if (blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error))
-		blk_run_queue_async(q);
-}
-
 static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 {
 	struct request_queue *q = rq->q;
@@ -443,9 +364,6 @@ void blk_insert_flush(struct request *rq)
 	unsigned int policy = blk_flush_policy(fflags, rq);
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, rq->mq_ctx);
 
-	if (!q->mq_ops)
-		lockdep_assert_held(q->queue_lock);
-
 	/*
 	 * @policy now records what operations need to be done.  Adjust
 	 * REQ_PREFLUSH and FUA for the driver.
@@ -468,10 +386,7 @@ void blk_insert_flush(struct request *rq)
 	 * complete the request.
 	 */
 	if (!policy) {
-		if (q->mq_ops)
-			blk_mq_end_request(rq, 0);
-		else
-			__blk_end_request(rq, 0, 0);
+		blk_mq_end_request(rq, 0);
 		return;
 	}
 
@@ -484,10 +399,7 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		if (q->mq_ops)
-			blk_mq_request_bypass_insert(rq, false);
-		else
-			list_add_tail(&rq->queuelist, &q->queue_head);
+		blk_mq_request_bypass_insert(rq, false);
 		return;
 	}
 
@@ -499,17 +411,12 @@ void blk_insert_flush(struct request *rq)
 	INIT_LIST_HEAD(&rq->flush.list);
 	rq->rq_flags |= RQF_FLUSH_SEQ;
 	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
-	if (q->mq_ops) {
-		rq->end_io = mq_flush_data_end_io;
 
-		spin_lock_irq(&fq->mq_flush_lock);
-		blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
-		spin_unlock_irq(&fq->mq_flush_lock);
-		return;
-	}
-	rq->end_io = flush_data_end_io;
+	rq->end_io = mq_flush_data_end_io;
 
+	spin_lock_irq(&fq->mq_flush_lock);
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
+	spin_unlock_irq(&fq->mq_flush_lock);
 }
 
 /**
@@ -575,8 +482,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 	if (!fq)
 		goto fail;
 
-	if (q->mq_ops)
-		spin_lock_init(&fq->mq_flush_lock);
+	spin_lock_init(&fq->mq_flush_lock);
 
 	rq_sz = round_up(rq_sz + cmd_size, cache_line_size());
 	fq->flush_rq = kzalloc_node(rq_sz, flags, node);
diff --git a/block/blk.h b/block/blk.h
index a1841b8ff129..57a302bf5a70 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -114,9 +114,7 @@ static inline void queue_flag_clear(unsigned int flag, struct request_queue *q)
 static inline struct blk_flush_queue *blk_get_flush_queue(
 		struct request_queue *q, struct blk_mq_ctx *ctx)
 {
-	if (q->mq_ops)
-		return blk_mq_map_queue(q, ctx->cpu)->fq;
-	return q->fq;
+	return blk_mq_map_queue(q, ctx->cpu)->fq;
 }
 
 static inline void __blk_get_queue(struct request_queue *q)
-- 
2.17.1
