Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdIMNcv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2017 09:32:51 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: don't allocate driver tag beforehand for flush rq
Date: Wed, 13 Sep 2017 21:32:30 +0800
Message-Id: <20170913133230.13639-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The behind idea is simple:

1) for none scheduler, driver tag has to be borrowed for flush
rq, otherwise we may run out of tag, and IO hang is caused.
get/put driver tag is actually a nop, so reorder tags isn't
necessary at all.

2) for real I/O scheduler, we needn't to allocate driver tag
beforehand for flush rq, and it works just fine to follow the
way for normal requests: allocate driver tag for each rq just
before calling .queue_rq().

Then flush rq isn't treated specially wrt. get/put driver tag,
codes get cleanup much, such as, reorder_tags_to_front() is
removed, needn't to worry about request order in dispatch list
any more.

One visible change to driver is that flush rq's tag may not be
same with the data rq in flush sequence, that won't be a
problem, since we always do that in legacy path.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c    | 43 ++++++++++++++++++++++++++++++-----
 block/blk-mq-sched.c | 64 ++++++++++++----------------------------------------
 block/blk-mq.c       | 38 ++++---------------------------
 3 files changed, 56 insertions(+), 89 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4938bec8cfef..080f778257cf 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -216,6 +216,17 @@ static bool blk_flush_complete_seq(struct request *rq,
 	return kicked | queued;
 }
 
+/*
+ * We don't share tag between flush rq and data rq in case of
+ * IO scheduler, so have to release tag and restart queue
+ */
+static void put_flush_driver_tag(struct blk_mq_hw_ctx *hctx,
+				 struct blk_mq_ctx *ctx, int tag)
+{
+	blk_mq_put_tag(hctx, hctx->tags, ctx, tag);
+	blk_mq_sched_restart(hctx);
+}
+
 static void flush_end_io(struct request *flush_rq, blk_status_t error)
 {
 	struct request_queue *q = flush_rq->q;
@@ -231,8 +242,14 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		/* release the tag's ownership to the req cloned from */
 		spin_lock_irqsave(&fq->mq_flush_lock, flags);
 		hctx = blk_mq_map_queue(q, flush_rq->mq_ctx->cpu);
-		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
-		flush_rq->tag = -1;
+		if (!q->elevator) {
+			blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
+			flush_rq->tag = -1;
+		} else {
+			put_flush_driver_tag(hctx, flush_rq->mq_ctx,
+					     flush_rq->tag);
+			flush_rq->internal_tag = -1;
+		}
 	}
 
 	running = &fq->flush_queue[fq->flush_running_idx];
@@ -321,16 +338,24 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 	 * Borrow tag from the first request since they can't
 	 * be in flight at the same time. And acquire the tag's
 	 * ownership for flush req.
+	 *
+	 * In case of io scheduler, flush rq need to borrow
+	 * scheduler tag for making put/get driver tag workable.
+	 * In case of none, flush rq need to borrow driver tag.
 	 */
 	if (q->mq_ops) {
 		struct blk_mq_hw_ctx *hctx;
 
 		flush_rq->mq_ctx = first_rq->mq_ctx;
-		flush_rq->tag = first_rq->tag;
-		fq->orig_rq = first_rq;
 
-		hctx = blk_mq_map_queue(q, first_rq->mq_ctx->cpu);
-		blk_mq_tag_set_rq(hctx, first_rq->tag, flush_rq);
+		if (!q->elevator) {
+			fq->orig_rq = first_rq;
+			flush_rq->tag = first_rq->tag;
+			hctx = blk_mq_map_queue(q, first_rq->mq_ctx->cpu);
+			blk_mq_tag_set_rq(hctx, first_rq->tag, flush_rq);
+		} else {
+			flush_rq->internal_tag = first_rq->internal_tag;
+		}
 	}
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
@@ -394,6 +419,12 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 
 	hctx = blk_mq_map_queue(q, ctx->cpu);
 
+	if (q->elevator) {
+		WARN_ON(rq->tag < 0);
+		put_flush_driver_tag(hctx, ctx, rq->tag);
+		rq->tag = -1;
+	}
+
 	/*
 	 * After populating an empty queue, kick it to avoid stall.  Read
 	 * the comment in flush_end_io().
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 4ab69435708c..dbf100871ad6 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -259,22 +259,20 @@ void blk_mq_sched_request_inserted(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);
 
-static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
-				       struct request *rq)
+static bool blk_mq_bypass_insert(struct blk_mq_hw_ctx *hctx,
+				 bool has_sched, struct request *rq)
 {
-	if (rq->tag == -1) {
-		rq->rq_flags |= RQF_SORTED;
-		return false;
+	/* Send flush request directly to the dispatch list */
+	if (rq->rq_flags & RQF_FLUSH_SEQ) {
+		spin_lock(&hctx->lock);
+		list_add(&rq->queuelist, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
+		return true;
 	}
 
-	/*
-	 * If we already have a real request tag, send directly to
-	 * the dispatch list.
-	 */
-	spin_lock(&hctx->lock);
-	list_add(&rq->queuelist, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
-	return true;
+	if (has_sched && rq->tag == -1)
+		rq->rq_flags |= RQF_SORTED;
+	return false;
 }
 
 /**
@@ -339,21 +337,6 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *const hctx)
 	}
 }
 
-/*
- * Add flush/fua to the queue. If we fail getting a driver tag, then
- * punt to the requeue list. Requeue will re-invoke us from a context
- * that's safe to block from.
- */
-static void blk_mq_sched_insert_flush(struct blk_mq_hw_ctx *hctx,
-				      struct request *rq, bool can_block)
-{
-	if (blk_mq_get_driver_tag(rq, &hctx, can_block)) {
-		blk_insert_flush(rq);
-		blk_mq_run_hw_queue(hctx, true);
-	} else
-		blk_mq_add_to_requeue_list(rq, false, true);
-}
-
 void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 				 bool run_queue, bool async, bool can_block)
 {
@@ -362,12 +345,12 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 
-	if (rq->tag == -1 && op_is_flush(rq->cmd_flags)) {
-		blk_mq_sched_insert_flush(hctx, rq, can_block);
-		return;
+	if (op_is_flush(rq->cmd_flags) && !(rq->rq_flags & RQF_FLUSH_SEQ)) {
+		blk_insert_flush(rq);
+		goto run;
 	}
 
-	if (e && blk_mq_sched_bypass_insert(hctx, rq))
+	if (blk_mq_bypass_insert(hctx, !!e, rq))
 		goto run;
 
 	if (e && e->type->ops.mq.insert_requests) {
@@ -393,23 +376,6 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	struct elevator_queue *e = hctx->queue->elevator;
 
-	if (e) {
-		struct request *rq, *next;
-
-		/*
-		 * We bypass requests that already have a driver tag assigned,
-		 * which should only be flushes. Flushes are only ever inserted
-		 * as single requests, so we shouldn't ever hit the
-		 * WARN_ON_ONCE() below (but let's handle it just in case).
-		 */
-		list_for_each_entry_safe(rq, next, list, queuelist) {
-			if (WARN_ON_ONCE(rq->tag != -1)) {
-				list_del_init(&rq->queuelist);
-				blk_mq_sched_bypass_insert(hctx, rq);
-			}
-		}
-	}
-
 	if (e && e->type->ops.mq.insert_requests)
 		e->type->ops.mq.insert_requests(hctx, list, false);
 	else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8c4d691dca03..bfab3ce4006c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1044,30 +1044,6 @@ static void blk_mq_put_driver_tag(struct request *rq)
 	__blk_mq_put_driver_tag(hctx, rq);
 }
 
-/*
- * If we fail getting a driver tag because all the driver tags are already
- * assigned and on the dispatch list, BUT the first entry does not have a
- * tag, then we could deadlock. For that case, move entries with assigned
- * driver tags to the front, leaving the set of tagged requests in the
- * same order, and the untagged set in the same order.
- */
-static bool reorder_tags_to_front(struct list_head *list)
-{
-	struct request *rq, *tmp, *first = NULL;
-
-	list_for_each_entry_safe_reverse(rq, tmp, list, queuelist) {
-		if (rq == first)
-			break;
-		if (rq->tag != -1) {
-			list_move(&rq->queuelist, list);
-			if (!first)
-				first = rq;
-		}
-	}
-
-	return first != NULL;
-}
-
 static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
 				void *key)
 {
@@ -1125,9 +1101,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 
 		rq = list_first_entry(list, struct request, queuelist);
 		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
-			if (!queued && reorder_tags_to_front(list))
-				continue;
-
 			/*
 			 * The initial allocation attempt failed, so we need to
 			 * rerun the hardware queue when a tag is freed.
@@ -1716,13 +1689,10 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	if (unlikely(is_flush_fua)) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-		if (q->elevator) {
-			blk_mq_sched_insert_request(rq, false, true, true,
-					true);
-		} else {
-			blk_insert_flush(rq);
-			blk_mq_run_hw_queue(data.hctx, true);
-		}
+
+		/* bypass scheduler for flush rq */
+		blk_insert_flush(rq);
+		blk_mq_run_hw_queue(data.hctx, true);
 	} else if (plug && q->nr_hw_queues == 1) {
 		struct request *last = NULL;
 
-- 
2.9.5
