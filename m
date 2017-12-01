Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60980 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbdLAAIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Nov 2017 19:08:51 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>, stable@vger.kernel.org
Subject: [PATCH 6/7] blk-mq: Rerun hardware queues after having called .put_budget()
Date: Thu, 30 Nov 2017 16:08:47 -0800
Message-Id: <20171201000848.2656-7-bart.vanassche@wdc.com>
In-Reply-To: <20171201000848.2656-1-bart.vanassche@wdc.com>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

During request dispatch, after a scheduler or per-CPU queue has
been examined, .put_budget() is called if the examined queue is
empty. Since a new request may be queued concurrently with the
.put_budget() call, a request queue needs to be rerun after each
.put_budget() call.

Fixes: commit 1f460b63d4b3 ("blk-mq: don't restart queue when .get_budget returns BLK_STS_RESOURCE")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: <stable@vger.kernel.org>
---
 block/blk-mq-sched.c | 39 ++++++++++++++++++++-------------------
 block/blk-mq-sched.h |  2 +-
 block/blk-mq.c       | 17 ++++++++++++-----
 3 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 398545d94521..3a935081a2d3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -82,12 +82,8 @@ static bool blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
 	return blk_mq_run_hw_queue(hctx, true);
 }
 
-/*
- * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
- * its queue by itself in its completion handler, so we don't need to
- * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
- */
-static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
+/* returns true if hctx needs to be run again */
+static bool blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
@@ -106,7 +102,7 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		rq = e->type->ops.mq.dispatch_request(hctx);
 		if (!rq) {
 			blk_mq_put_dispatch_budget(hctx);
-			break;
+			return true;
 		}
 
 		/*
@@ -116,6 +112,8 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 		 */
 		list_add(&rq->queuelist, &rq_list);
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
+
+	return false;
 }
 
 static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
@@ -129,16 +127,13 @@ static struct blk_mq_ctx *blk_mq_next_ctx(struct blk_mq_hw_ctx *hctx,
 	return hctx->ctxs[idx];
 }
 
-/*
- * Only SCSI implements .get_budget and .put_budget, and SCSI restarts
- * its queue by itself in its completion handler, so we don't need to
- * restart queue if .get_budget() returns BLK_STS_NO_RESOURCE.
- */
-static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
+/* returns true if hctx needs to be run again */
+static bool blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	LIST_HEAD(rq_list);
 	struct blk_mq_ctx *ctx = READ_ONCE(hctx->dispatch_from);
+	bool ret = false;
 
 	do {
 		struct request *rq;
@@ -152,6 +147,7 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 		rq = blk_mq_dequeue_from_ctx(hctx, ctx);
 		if (!rq) {
 			blk_mq_put_dispatch_budget(hctx);
+			ret = true;
 			break;
 		}
 
@@ -168,19 +164,22 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 	} while (blk_mq_dispatch_rq_list(q, &rq_list, true));
 
 	WRITE_ONCE(hctx->dispatch_from, ctx);
+
+	return ret;
 }
 
 /* return true if hw queue need to be run again */
-void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+bool blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;
 	LIST_HEAD(rq_list);
+	bool run_queue = false;
 
 	/* RCU or SRCU read lock is needed before checking quiesced flag */
 	if (unlikely(blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)))
-		return;
+		return false;
 
 	hctx->run++;
 
@@ -212,12 +211,12 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	if (!list_empty(&rq_list)) {
 		if (blk_mq_dispatch_rq_list(q, &rq_list, false)) {
 			if (has_sched_dispatch)
-				blk_mq_do_dispatch_sched(hctx);
+				run_queue = blk_mq_do_dispatch_sched(hctx);
 			else
-				blk_mq_do_dispatch_ctx(hctx);
+				run_queue = blk_mq_do_dispatch_ctx(hctx);
 		}
 	} else if (has_sched_dispatch) {
-		blk_mq_do_dispatch_sched(hctx);
+		run_queue = blk_mq_do_dispatch_sched(hctx);
 	} else if (q->mq_ops->get_budget) {
 		/*
 		 * If we need to get budget before queuing request, we
@@ -227,11 +226,13 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		 * TODO: get more budgets, and dequeue more requests in
 		 * one time.
 		 */
-		blk_mq_do_dispatch_ctx(hctx);
+		run_queue = blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
 		blk_mq_dispatch_rq_list(q, &rq_list, false);
 	}
+
+	return run_queue;
 }
 
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index ba1d1418a96d..1ccfb8027cfc 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -23,7 +23,7 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 				  struct blk_mq_ctx *ctx,
 				  struct list_head *list, bool run_queue_async);
 
-void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
+bool blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3e0ce940377f..b4225f606737 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1079,7 +1079,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 {
 	struct blk_mq_hw_ctx *hctx;
 	struct request *rq, *nxt;
-	bool no_tag = false;
+	bool restart = false, no_tag = false;
 	int errors, queued;
 
 	if (list_empty(list))
@@ -1105,8 +1105,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			 * we'll re-run it below.
 			 */
 			if (!blk_mq_mark_tag_wait(&hctx, rq)) {
-				if (got_budget)
+				if (got_budget) {
 					blk_mq_put_dispatch_budget(hctx);
+					restart = true;
+				}
 				/*
 				 * For non-shared tags, the RESTART check
 				 * will suffice.
@@ -1193,7 +1195,8 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 *   returning BLK_STS_RESOURCE. Two exceptions are scsi-mq
 		 *   and dm-rq.
 		 */
-		if (!blk_mq_sched_needs_restart(hctx) ||
+		if (restart ||
+		    !blk_mq_sched_needs_restart(hctx) ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
 	}
@@ -1204,6 +1207,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	int srcu_idx;
+	bool run_queue;
 
 	/*
 	 * We should be running this queue from one of the CPUs that
@@ -1220,15 +1224,18 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		rcu_read_lock();
-		blk_mq_sched_dispatch_requests(hctx);
+		run_queue = blk_mq_sched_dispatch_requests(hctx);
 		rcu_read_unlock();
 	} else {
 		might_sleep();
 
 		srcu_idx = srcu_read_lock(hctx->queue_rq_srcu);
-		blk_mq_sched_dispatch_requests(hctx);
+		run_queue = blk_mq_sched_dispatch_requests(hctx);
 		srcu_read_unlock(hctx->queue_rq_srcu, srcu_idx);
 	}
+
+	if (run_queue)
+		blk_mq_sched_restart(hctx);
 }
 
 /*
-- 
2.15.0
