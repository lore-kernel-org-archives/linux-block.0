Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51947 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753991AbdDJP4a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 11:56:30 -0400
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <osandov@fb.com>, <hch@lst.de>, <bart.vanassche@sandisk.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 3/3] blk-mq: unify hctx delay_work and run_work
Date: Mon, 10 Apr 2017 09:54:56 -0600
Message-ID: <1491839696-24783-4-git-send-email-axboe@fb.com>
In-Reply-To: <1491839696-24783-1-git-send-email-axboe@fb.com>
References: <1491839696-24783-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The only difference between ->run_work and ->delay_work, is that
the latter is used to defer running a queue. This is done by
marking the queue stopped, and scheduling ->delay_work to run
sometime in the future. While the queue is stopped, direct runs
or runs through ->run_work will not run the queue.

If we combine the handlers, then we need to handle two things:

1) If a delayed/stopped run is scheduled, then we should not run
   the queue before that has been completed.
2) If a queue is delayed/stopped, the handler needs to restart
   the queue. Normally a run of a queue with the stopped bit set
   would be a no-op.

Case 1 is handled by modifying a currently pending queue run
to the deadline set by the caller of blk_mq_delay_queue().
Subsequent attempts to queue a queue run will find the work
item already pending, and direct runs will see a stopped queue
as before.

Case 2 is handled by adding a new bit, BLK_MQ_S_START_ON_RUN,
that tells the work handler that it should clear a stopped
queue and run the handler.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-core.c       |  4 +---
 block/blk-mq.c         | 34 ++++++++++++++++++++++------------
 include/linux/blk-mq.h |  3 +--
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bffb8640346b..4f0104afa848 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -268,10 +268,8 @@ void blk_sync_queue(struct request_queue *q)
 		struct blk_mq_hw_ctx *hctx;
 		int i;
 
-		queue_for_each_hw_ctx(q, hctx, i) {
+		queue_for_each_hw_ctx(q, hctx, i)
 			cancel_delayed_work_sync(&hctx->run_work);
-			cancel_delayed_work_sync(&hctx->delay_work);
-		}
 	} else {
 		cancel_delayed_work_sync(&q->delay_work);
 	}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7afba6ab5a96..e97ed8e7f359 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1223,7 +1223,6 @@ EXPORT_SYMBOL(blk_mq_queue_stopped);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	cancel_delayed_work(&hctx->run_work);
-	cancel_delayed_work(&hctx->delay_work);
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 EXPORT_SYMBOL(blk_mq_stop_hw_queue);
@@ -1281,27 +1280,39 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	struct blk_mq_hw_ctx *hctx;
 
 	hctx = container_of(work, struct blk_mq_hw_ctx, run_work.work);
-	__blk_mq_run_hw_queue(hctx);
-}
 
-static void blk_mq_delay_work_fn(struct work_struct *work)
-{
-	struct blk_mq_hw_ctx *hctx;
+	/*
+	 * If we are stopped, don't run the queue. The exception is if
+	 * BLK_MQ_S_START_ON_RUN is set. For that case, we auto-clear
+	 * the STOPPED bit and run it.
+	 */
+	if (test_bit(BLK_MQ_S_STOPPED, &hctx->state)) {
+		if (!test_bit(BLK_MQ_S_START_ON_RUN, &hctx->state))
+			return;
 
-	hctx = container_of(work, struct blk_mq_hw_ctx, delay_work.work);
+		clear_bit(BLK_MQ_S_START_ON_RUN, &hctx->state);
+		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	}
 
-	if (test_and_clear_bit(BLK_MQ_S_STOPPED, &hctx->state))
-		__blk_mq_run_hw_queue(hctx);
+	__blk_mq_run_hw_queue(hctx);
 }
 
+
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs)
 {
 	if (unlikely(!blk_mq_hw_queue_mapped(hctx)))
 		return;
 
+	/*
+	 * Stop the hw queue, then modify currently delayed work.
+	 * This should prevent us from running the queue prematurely.
+	 * Mark the queue as auto-clearing STOPPED when it runs.
+	 */
 	blk_mq_stop_hw_queue(hctx);
-	kblockd_schedule_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
-			&hctx->delay_work, msecs_to_jiffies(msecs));
+	set_bit(BLK_MQ_S_START_ON_RUN, &hctx->state);
+	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
+					&hctx->run_work,
+					msecs_to_jiffies(msecs));
 }
 EXPORT_SYMBOL(blk_mq_delay_queue);
 
@@ -1886,7 +1897,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 		node = hctx->numa_node = set->numa_node;
 
 	INIT_DELAYED_WORK(&hctx->run_work, blk_mq_run_work_fn);
-	INIT_DELAYED_WORK(&hctx->delay_work, blk_mq_delay_work_fn);
 	spin_lock_init(&hctx->lock);
 	INIT_LIST_HEAD(&hctx->dispatch);
 	hctx->queue = q;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2b4573a9ccf4..7a114b7b943c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -51,8 +51,6 @@ struct blk_mq_hw_ctx {
 
 	atomic_t		nr_active;
 
-	struct delayed_work	delay_work;
-
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
 
@@ -160,6 +158,7 @@ enum {
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
 	BLK_MQ_S_TAG_WAITING	= 3,
+	BLK_MQ_S_START_ON_RUN	= 4,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
-- 
2.7.4
