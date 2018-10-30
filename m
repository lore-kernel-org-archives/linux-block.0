Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] blk-mq: cleanup and improve list insertion
Date: Tue, 30 Oct 2018 12:32:46 -0600
Message-Id: <20181030183252.17857-11-axboe@kernel.dk>
In-Reply-To: <20181030183252.17857-1-axboe@kernel.dk>
References: <20181030183252.17857-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

It's somewhat strange to have a list insertion function that
relies on the fact that the caller has mapped things correctly.
Pass in the hardware queue directly for insertion, which makes
for a much cleaner interface and implementation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sched.c |  8 +-------
 block/blk-mq-sched.h |  2 +-
 block/blk-mq.c       | 25 ++++++++++++++-----------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 8bc1f37acca2..6e7375246e2f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -396,17 +396,11 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		blk_mq_run_hw_queue(hctx, async);
 }
 
-void blk_mq_sched_insert_requests(struct request_queue *q,
+void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 				  struct blk_mq_ctx *ctx,
 				  struct list_head *list, bool run_queue_async)
 {
-	struct blk_mq_hw_ctx *hctx;
 	struct elevator_queue *e;
-	struct request *rq;
-
-	/* For list inserts, requests better be on the same hw queue */
-	rq = list_first_entry(list, struct request, queuelist);
-	hctx = rq->mq_hctx;
 
 	e = hctx->queue->elevator;
 	if (e && e->type->ops.mq.insert_requests)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 8a9544203173..ffd7b5989d63 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -19,7 +19,7 @@ void blk_mq_sched_restart(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 				 bool run_queue, bool async);
-void blk_mq_sched_insert_requests(struct request_queue *q,
+void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
 				  struct blk_mq_ctx *ctx,
 				  struct list_head *list, bool run_queue_async);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b86d725958d3..51b8166959b9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1623,11 +1623,12 @@ static int plug_ctx_cmp(void *priv, struct list_head *a, struct list_head *b)
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 {
+	struct blk_mq_hw_ctx *this_hctx;
 	struct blk_mq_ctx *this_ctx;
 	struct request_queue *this_q;
 	struct request *rq;
 	LIST_HEAD(list);
-	LIST_HEAD(ctx_list);
+	LIST_HEAD(rq_list);
 	unsigned int depth;
 
 	list_splice_init(&plug->mq_list, &list);
@@ -1635,6 +1636,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	list_sort(NULL, &list, plug_ctx_cmp);
 
 	this_q = NULL;
+	this_hctx = NULL;
 	this_ctx = NULL;
 	depth = 0;
 
@@ -1642,30 +1644,31 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		rq = list_entry_rq(list.next);
 		list_del_init(&rq->queuelist);
 		BUG_ON(!rq->q);
-		if (rq->mq_ctx != this_ctx) {
-			if (this_ctx) {
+		if (rq->mq_hctx != this_hctx || rq->mq_ctx != this_ctx) {
+			if (this_hctx) {
 				trace_block_unplug(this_q, depth, !from_schedule);
-				blk_mq_sched_insert_requests(this_q, this_ctx,
-								&ctx_list,
+				blk_mq_sched_insert_requests(this_hctx, this_ctx,
+								&rq_list,
 								from_schedule);
 			}
 
-			this_ctx = rq->mq_ctx;
 			this_q = rq->q;
+			this_ctx = rq->mq_ctx;
+			this_hctx = rq->mq_hctx;
 			depth = 0;
 		}
 
 		depth++;
-		list_add_tail(&rq->queuelist, &ctx_list);
+		list_add_tail(&rq->queuelist, &rq_list);
 	}
 
 	/*
-	 * If 'this_ctx' is set, we know we have entries to complete
-	 * on 'ctx_list'. Do those.
+	 * If 'this_hctx' is set, we know we have entries to complete
+	 * on 'rq_list'. Do those.
 	 */
-	if (this_ctx) {
+	if (this_hctx) {
 		trace_block_unplug(this_q, depth, !from_schedule);
-		blk_mq_sched_insert_requests(this_q, this_ctx, &ctx_list,
+		blk_mq_sched_insert_requests(this_hctx, this_ctx, &rq_list,
 						from_schedule);
 	}
 }
-- 
2.17.1
