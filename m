Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/17] null_blk: remove legacy IO path
Date: Thu, 11 Oct 2018 10:59:09 -0600
Message-Id: <20181011165909.32615-18-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

We're planning on removing this code completely, kill the old
path.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/null_blk_main.c | 96 +++--------------------------------
 1 file changed, 6 insertions(+), 90 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 093b614d6524..8142cc8ff952 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -616,10 +616,6 @@ static void end_cmd(struct nullb_cmd *cmd)
 	case NULL_Q_MQ:
 		blk_mq_end_request(cmd->rq, cmd->error);
 		return;
-	case NULL_Q_RQ:
-		INIT_LIST_HEAD(&cmd->rq->queuelist);
-		blk_end_request_all(cmd->rq, cmd->error);
-		break;
 	case NULL_Q_BIO:
 		cmd->bio->bi_status = cmd->error;
 		bio_endio(cmd->bio);
@@ -627,15 +623,6 @@ static void end_cmd(struct nullb_cmd *cmd)
 	}
 
 	free_cmd(cmd);
-
-	/* Restart queue if needed, as we are freeing a tag */
-	if (queue_mode == NULL_Q_RQ && blk_queue_stopped(q)) {
-		unsigned long flags;
-
-		spin_lock_irqsave(q->queue_lock, flags);
-		blk_start_queue_async(q);
-		spin_unlock_irqrestore(q->queue_lock, flags);
-	}
 }
 
 static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer)
@@ -1197,17 +1184,8 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 			/* race with timer */
 			if (atomic_long_read(&nullb->cur_bytes) > 0)
 				null_restart_queue_async(nullb);
-			if (dev->queue_mode == NULL_Q_RQ) {
-				struct request_queue *q = nullb->q;
-
-				spin_lock_irq(q->queue_lock);
-				rq->rq_flags |= RQF_DONTPREP;
-				blk_requeue_request(q, rq);
-				spin_unlock_irq(q->queue_lock);
-				return BLK_STS_OK;
-			} else
-				/* requeue request */
-				return BLK_STS_DEV_RESOURCE;
+			/* requeue request */
+			return BLK_STS_DEV_RESOURCE;
 		}
 	}
 
@@ -1278,9 +1256,6 @@ static blk_status_t null_handle_cmd(struct nullb_cmd *cmd)
 		case NULL_Q_MQ:
 			blk_mq_complete_request(cmd->rq);
 			break;
-		case NULL_Q_RQ:
-			blk_complete_request(cmd->rq);
-			break;
 		case NULL_Q_BIO:
 			/*
 			 * XXX: no proper submitting cpu information available.
@@ -1349,30 +1324,6 @@ static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 	return BLK_QC_T_NONE;
 }
 
-static enum blk_eh_timer_return null_rq_timed_out_fn(struct request *rq)
-{
-	pr_info("null: rq %p timed out\n", rq);
-	__blk_complete_request(rq);
-	return BLK_EH_DONE;
-}
-
-static int null_rq_prep_fn(struct request_queue *q, struct request *req)
-{
-	struct nullb *nullb = q->queuedata;
-	struct nullb_queue *nq = nullb_to_queue(nullb);
-	struct nullb_cmd *cmd;
-
-	cmd = alloc_cmd(nq, 0);
-	if (cmd) {
-		cmd->rq = req;
-		req->special = cmd;
-		return BLKPREP_OK;
-	}
-	blk_stop_queue(q);
-
-	return BLKPREP_DEFER;
-}
-
 static bool should_timeout_request(struct request *rq)
 {
 #ifdef CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
@@ -1391,27 +1342,6 @@ static bool should_requeue_request(struct request *rq)
 	return false;
 }
 
-static void null_request_fn(struct request_queue *q)
-{
-	struct request *rq;
-
-	while ((rq = blk_fetch_request(q)) != NULL) {
-		struct nullb_cmd *cmd = rq->special;
-
-		/* just ignore the request */
-		if (should_timeout_request(rq))
-			continue;
-		if (should_requeue_request(rq)) {
-			blk_requeue_request(q, rq);
-			continue;
-		}
-
-		spin_unlock_irq(q->queue_lock);
-		null_handle_cmd(cmd);
-		spin_lock_irq(q->queue_lock);
-	}
-}
-
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
 	pr_info("null: rq %p timed out\n", rq);
@@ -1766,24 +1696,6 @@ static int null_add_dev(struct nullb_device *dev)
 		rv = init_driver_queues(nullb);
 		if (rv)
 			goto out_cleanup_blk_queue;
-	} else {
-		nullb->q = blk_init_queue_node(null_request_fn, &nullb->lock,
-						dev->home_node);
-		if (!nullb->q) {
-			rv = -ENOMEM;
-			goto out_cleanup_queues;
-		}
-
-		if (!null_setup_fault())
-			goto out_cleanup_blk_queue;
-
-		blk_queue_prep_rq(nullb->q, null_rq_prep_fn);
-		blk_queue_softirq_done(nullb->q, null_softirq_done_fn);
-		blk_queue_rq_timed_out(nullb->q, null_rq_timed_out_fn);
-		nullb->q->rq_timeout = 5 * HZ;
-		rv = init_driver_queues(nullb);
-		if (rv)
-			goto out_cleanup_blk_queue;
 	}
 
 	if (dev->mbps) {
@@ -1865,6 +1777,10 @@ static int __init null_init(void)
 		return -EINVAL;
 	}
 
+	if (g_queue_mode == NULL_Q_RQ) {
+		pr_err("null_blk: legacy IO path no longer available\n");
+		return -EINVAL;
+	}
 	if (g_queue_mode == NULL_Q_MQ && g_use_per_node_hctx) {
 		if (g_submit_queues != nr_online_nodes) {
 			pr_warn("null_blk: submit_queues param is set to %u.\n",
-- 
2.17.1
