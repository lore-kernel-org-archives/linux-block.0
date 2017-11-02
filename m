Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50368 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933983AbdKBPZr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Nov 2017 11:25:47 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 5/7] blk-mq-sched: decide how to handle flush rq via RQF_FLUSH_SEQ
Date: Thu,  2 Nov 2017 23:24:36 +0800
Message-Id: <20171102152438.25324-6-ming.lei@redhat.com>
In-Reply-To: <20171102152438.25324-1-ming.lei@redhat.com>
References: <20171102152438.25324-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In case of IO scheduler we always pre-allocate one driver tag before
calling blk_insert_flush(), and flush request will be marked as
RQF_FLUSH_SEQ once it is in flush machinary.

So if RQF_FLUSH_SEQ isn't set, we call blk_insert_flush() to handle
the request, otherwise the flush request is dispatched to ->dispatch
list directly.

This is a prepare patch for not preallocating driver tag on flush rq,
and don't treat flush rq as special case, just what the legacy path
did.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 7775f6b12fa9..32e4ea2d0a77 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -355,21 +355,23 @@ void blk_mq_sched_request_inserted(struct request *rq)
 EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);
 
 static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
+				       bool has_sched,
 				       struct request *rq)
 {
-	if (rq->tag == -1) {
+	/* dispatch flush rq directly */
+	if (rq->rq_flags & RQF_FLUSH_SEQ) {
+		spin_lock(&hctx->lock);
+		list_add(&rq->queuelist, &hctx->dispatch);
+		spin_unlock(&hctx->lock);
+		return true;
+	}
+
+	if (has_sched) {
 		rq->rq_flags |= RQF_SORTED;
-		return false;
+		WARN_ON(rq->tag != -1);
 	}
 
-	/*
-	 * If we already have a real request tag, send directly to
-	 * the dispatch list.
-	 */
-	spin_lock(&hctx->lock);
-	list_add(&rq->queuelist, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
-	return true;
+	return false;
 }
 
 /*
@@ -395,12 +397,13 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 
-	if (rq->tag == -1 && op_is_flush(rq->cmd_flags)) {
+	/* flush rq in flush machinery need to be dispatched directly */
+	if (!(rq->rq_flags & RQF_FLUSH_SEQ) && op_is_flush(rq->cmd_flags)) {
 		blk_mq_sched_insert_flush(hctx, rq, can_block);
 		return;
 	}
 
-	if (e && blk_mq_sched_bypass_insert(hctx, rq))
+	if (blk_mq_sched_bypass_insert(hctx, !!e, rq))
 		goto run;
 
 	if (e && e->type->ops.mq.insert_requests) {
@@ -438,7 +441,7 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 		list_for_each_entry_safe(rq, next, list, queuelist) {
 			if (WARN_ON_ONCE(rq->tag != -1)) {
 				list_del_init(&rq->queuelist);
-				blk_mq_sched_bypass_insert(hctx, rq);
+				blk_mq_sched_bypass_insert(hctx, true, rq);
 			}
 		}
 	}
-- 
2.9.5
