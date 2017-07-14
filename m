Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdGNXSg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 19:18:36 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/6] blk-mq: unexport APIs for start/stop queues
Date: Sat, 15 Jul 2017 07:16:01 +0800
Message-Id: <20170714231601.14444-7-ming.lei@redhat.com>
In-Reply-To: <20170714231601.14444-1-ming.lei@redhat.com>
References: <20170714231601.14444-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now no one uses these APIs anymore, so unexport them.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 83 ++------------------------------------------------
 block/blk-mq.h         |  1 +
 include/linux/blk-mq.h |  8 -----
 3 files changed, 3 insertions(+), 89 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f3b582eb492f..70ce222da405 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1200,12 +1200,6 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					 msecs_to_jiffies(msecs));
 }
 
-void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
-{
-	__blk_mq_delay_run_hw_queue(hctx, true, msecs);
-}
-EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
-
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
 	__blk_mq_delay_run_hw_queue(hctx, async, 0);
@@ -1247,61 +1241,8 @@ bool blk_mq_queue_stopped(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_mq_queue_stopped);
 
-/*
- * This function is often used for pausing .queue_rq() by driver when
- * there isn't enough resource or some conditions aren't satisfied, and
- * BLK_MQ_RQ_QUEUE_BUSY is usually returned.
- *
- * We do not guarantee that dispatch can be drained or blocked
- * after blk_mq_stop_hw_queue() returns. Please use
- * blk_mq_quiesce_queue() for that requirement.
- */
-void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
-{
-	cancel_delayed_work(&hctx->run_work);
-
-	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
-}
-EXPORT_SYMBOL(blk_mq_stop_hw_queue);
-
-/*
- * This function is often used for pausing .queue_rq() by driver when
- * there isn't enough resource or some conditions aren't satisfied, and
- * BLK_MQ_RQ_QUEUE_BUSY is usually returned.
- *
- * We do not guarantee that dispatch can be drained or blocked
- * after blk_mq_stop_hw_queues() returns. Please use
- * blk_mq_quiesce_queue() for that requirement.
- */
-void blk_mq_stop_hw_queues(struct request_queue *q)
-{
-	struct blk_mq_hw_ctx *hctx;
-	int i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_stop_hw_queue(hctx);
-}
-EXPORT_SYMBOL(blk_mq_stop_hw_queues);
-
-void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx)
-{
-	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
-
-	blk_mq_run_hw_queue(hctx, false);
-}
-EXPORT_SYMBOL(blk_mq_start_hw_queue);
-
-void blk_mq_start_hw_queues(struct request_queue *q)
-{
-	struct blk_mq_hw_ctx *hctx;
-	int i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_start_hw_queue(hctx);
-}
-EXPORT_SYMBOL(blk_mq_start_hw_queues);
-
-void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
+static void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx,
+					  bool async)
 {
 	if (!blk_mq_hctx_stopped(hctx))
 		return;
@@ -1309,7 +1250,6 @@ void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
 	blk_mq_run_hw_queue(hctx, async);
 }
-EXPORT_SYMBOL_GPL(blk_mq_start_stopped_hw_queue);
 
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async)
 {
@@ -1319,7 +1259,6 @@ void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async)
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_start_stopped_hw_queue(hctx, async);
 }
-EXPORT_SYMBOL(blk_mq_start_stopped_hw_queues);
 
 static void blk_mq_run_work_fn(struct work_struct *work)
 {
@@ -1344,24 +1283,6 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 }
 
 
-void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
-{
-	if (WARN_ON_ONCE(!blk_mq_hw_queue_mapped(hctx)))
-		return;
-
-	/*
-	 * Stop the hw queue, then modify currently delayed work.
-	 * This should prevent us from running the queue prematurely.
-	 * Mark the queue as auto-clearing STOPPED when it runs.
-	 */
-	blk_mq_stop_hw_queue(hctx);
-	set_bit(BLK_MQ_S_START_ON_RUN, &hctx->state);
-	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
-					&hctx->run_work,
-					msecs_to_jiffies(msecs));
-}
-EXPORT_SYMBOL(blk_mq_delay_queue);
-
 static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 					    struct request *rq,
 					    bool at_head)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 60b01c0309bc..2a26c74eaca1 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -25,6 +25,7 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
+void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_free_queue(struct request_queue *q);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 251af99e9ba8..203bc77fdea9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -242,18 +242,10 @@ void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs
 void blk_mq_complete_request(struct request *rq);
 
 bool blk_mq_queue_stopped(struct request_queue *q);
-void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
-void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
-void blk_mq_stop_hw_queues(struct request_queue *q);
-void blk_mq_start_hw_queues(struct request_queue *q);
-void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
-void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
 void blk_mq_unquiesce_queue(struct request_queue *q);
-void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
-void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv);
 void blk_mq_freeze_queue(struct request_queue *q);
-- 
2.9.4
