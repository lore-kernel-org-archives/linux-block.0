Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751257AbdIPDGl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Sep 2017 23:06:41 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 6/7] blk-mq: don't allocate driver tag beforehand for flush rq
Date: Sat, 16 Sep 2017 11:03:50 +0800
Message-Id: <20170916030351.28019-8-ming.lei@redhat.com>
In-Reply-To: <20170916030351.28019-1-ming.lei@redhat.com>
References: <20170916030351.28019-1-ming.lei@redhat.com>
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

One visible change to driver is that the driver tag isn't
shared in the flush request sequence, that won't be a
problem, since we always do that in legacy path.

Then flush rq isn't treated specially wrt. get/put driver tag,
code gets cleanup much, such as, reorder_tags_to_front() is
removed, and we needn't to worry about request order in
dispatch list for avoiding I/O deadlock.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c    | 41 +++++++++++++++++++++++++++++++++++------
 block/blk-mq-sched.c | 36 ++----------------------------------
 block/blk-mq.c       | 44 ++++++++++----------------------------------
 3 files changed, 47 insertions(+), 74 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index a9773d2075ac..65914a23fa77 100644
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
+				 struct request *rq)
+{
+	blk_mq_put_driver_tag_hctx(hctx, rq);
+	blk_mq_sched_restart(hctx);
+}
+
 static void flush_end_io(struct request *flush_rq, blk_status_t error)
 {
 	struct request_queue *q = flush_rq->q;
@@ -231,8 +242,13 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		/* release the tag's ownership to the req cloned from */
 		spin_lock_irqsave(&fq->mq_flush_lock, flags);
 		hctx = blk_mq_map_queue(q, flush_rq->mq_ctx->cpu);
-		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
-		flush_rq->tag = -1;
+		if (!q->elevator) {
+			blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
+			flush_rq->tag = -1;
+		} else {
+			put_flush_driver_tag(hctx, flush_rq);
+			flush_rq->internal_tag = -1;
+		}
 	}
 
 	running = &fq->flush_queue[fq->flush_running_idx];
@@ -321,16 +337,24 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
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
@@ -394,6 +418,11 @@ static void mq_flush_data_end_io(struct request *rq, blk_status_t error)
 
 	hctx = blk_mq_map_queue(q, ctx->cpu);
 
+	if (q->elevator) {
+		WARN_ON(rq->tag < 0);
+		put_flush_driver_tag(hctx, rq);
+	}
+
 	/*
 	 * After populating an empty queue, kick it to avoid stall.  Read
 	 * the comment in flush_end_io().
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index fa0f33d7efb9..c2ea8c2b896b 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -341,21 +341,6 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *const hctx)
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
@@ -366,8 +351,8 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 
 	/* flush rq in flush machinery need to be dispatched directly */
 	if (!(rq->rq_flags & RQF_FLUSH_SEQ) && op_is_flush(rq->cmd_flags)) {
-		blk_mq_sched_insert_flush(hctx, rq, can_block);
-		return;
+		blk_insert_flush(rq);
+		goto run;
 	}
 
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq))
@@ -396,23 +381,6 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
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
-				blk_mq_sched_bypass_insert(hctx, true, rq);
-			}
-		}
-	}
-
 	if (e && e->type->ops.mq.insert_requests)
 		e->type->ops.mq.insert_requests(hctx, list, false);
 	else
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b799d4e22c0b..c02dea2e3c1e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -634,6 +634,12 @@ static void __blk_mq_requeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
+	/*
+	 * release driver tag if the rq is being requeued from
+	 * completion path
+	 */
+	blk_mq_put_driver_tag(rq);
+
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, &rq->issue_stat);
 	blk_mq_sched_requeue_request(rq);
@@ -920,30 +926,6 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	return rq->tag != -1;
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
@@ -1001,9 +983,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 
 		rq = list_first_entry(list, struct request, queuelist);
 		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
-			if (!queued && reorder_tags_to_front(list))
-				continue;
-
 			/*
 			 * The initial allocation attempt failed, so we need to
 			 * rerun the hardware queue when a tag is freed.
@@ -1610,13 +1589,10 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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
