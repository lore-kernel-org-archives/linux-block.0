Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH V3 16/17] block: simplify runtime PM support
Date: Thu, 13 Sep 2018 20:15:45 +0800
Message-Id: <20180913121546.5710-17-ming.lei@redhat.com>
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
References: <20180913121546.5710-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patch simplifies runtime PM support by the following approach:

1) resume device in blk_queue_enter() if this device is
runtime-suspended or runtime-suspending

2) freeze queue in blk_pre_runtime_suspend()

3) unfreeze queue in blk_pre_runtime_resume()

4) remove checking on RRF_PM because now we requires out-of-band PM
request to resume device

5) introduce blk_unfreeze_queue_lock() and blk_freeze_queue_lock()
so that both runtime-PM and system-PM can use them to freeze/unfreeze
queue and avoid freeze & unfreeze mismatch

Then we can remove blk_pm_allow_request(), and more importantly this way
can be applied to blk-mq path too.

Finally the IO queue associated with scsi_device is kept as runtime
resumed in __scsi_execute() when sending non-PM RQF_REQUEST, and this
way makes sure that the LUN is active for handling non-PM RQF_PREEMPT.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c        | 106 ++++++++++++++++++++++++++++--------------------
 block/blk-mq.c          |  22 ++++++++++
 block/elevator.c        |  25 ------------
 drivers/scsi/scsi_lib.c |  14 +++++--
 include/linux/blk-mq.h  |   2 +
 include/linux/blkdev.h  |   3 ++
 6 files changed, 101 insertions(+), 71 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f51c19b381e3..07c5243c51ec 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -890,6 +890,28 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+#ifdef CONFIG_PM
+static void blk_resume_queue(struct request_queue *q)
+{
+	int rpm_status;
+
+	if (!q->dev)
+		return;
+
+	spin_lock_irq(q->queue_lock);
+	rpm_status = q->rpm_status;
+	spin_unlock_irq(q->queue_lock);
+
+	/* PM request needs to be dealt with out of band */
+	if (rpm_status == RPM_SUSPENDED || rpm_status == RPM_SUSPENDING)
+		pm_runtime_resume(q->dev);
+}
+#else
+static void blk_resume_queue(struct request_queue *q)
+{
+}
+#endif
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -913,11 +935,20 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		 */
 		smp_rmb();
 
+		blk_resume_queue(q);
+
 		wait_event(q->mq_freeze_wq,
 			   atomic_read(&q->mq_freeze_depth) == 0 ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
+
+		/*
+		 * This allocation may be blocked via queue freezing before
+		 * the queue is suspended, so we have to resume queue again
+		 * after waking up.
+		 */
+		blk_resume_queue(q);
 	}
 }
 
@@ -1023,6 +1054,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	q->bypass_depth = 1;
 	queue_flag_set_unlocked(QUEUE_FLAG_BYPASS, q);
 
+	mutex_init(&q->freeze_lock);
 	init_waitqueue_head(&q->mq_freeze_wq);
 
 	/*
@@ -1470,6 +1502,23 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 	return ERR_PTR(-ENOMEM);
 }
 
+#ifdef CONFIG_PM
+static void blk_pm_add_request(struct request_queue *q)
+{
+	if (q->dev)
+		q->nr_pending++;
+}
+static void blk_pm_put_request(struct request_queue *q)
+{
+	if (q->dev && !--q->nr_pending)
+		pm_runtime_mark_last_busy(q->dev);
+}
+#else
+static inline void blk_pm_put_request(struct request_queue *q) {}
+static inline void blk_pm_add_request(struct request_queue *q){}
+#endif
+
+
 /**
  * get_request - get a free request
  * @q: request_queue to allocate request from
@@ -1498,16 +1547,19 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 
 	rl = blk_get_rl(q, bio);	/* transferred to @rq on success */
 retry:
+	blk_pm_add_request(q);
 	rq = __get_request(rl, op, bio, flags, gfp);
 	if (!IS_ERR(rq))
 		return rq;
 
 	if (op & REQ_NOWAIT) {
+		blk_pm_put_request(q);
 		blk_put_rl(rl);
 		return ERR_PTR(-EAGAIN);
 	}
 
 	if ((flags & BLK_MQ_REQ_NOWAIT) || unlikely(blk_queue_dying(q))) {
+		blk_pm_put_request(q);
 		blk_put_rl(rl);
 		return rq;
 	}
@@ -1518,6 +1570,7 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 
 	trace_block_sleeprq(q, bio, op);
 
+	blk_pm_put_request(q);
 	spin_unlock_irq(q->queue_lock);
 	io_schedule();
 
@@ -1686,16 +1739,6 @@ void part_round_stats(struct request_queue *q, int cpu, struct hd_struct *part)
 }
 EXPORT_SYMBOL_GPL(part_round_stats);
 
-#ifdef CONFIG_PM
-static void blk_pm_put_request(struct request *rq)
-{
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM) && !--rq->q->nr_pending)
-		pm_runtime_mark_last_busy(rq->q->dev);
-}
-#else
-static inline void blk_pm_put_request(struct request *rq) {}
-#endif
-
 void __blk_put_request(struct request_queue *q, struct request *req)
 {
 	req_flags_t rq_flags = req->rq_flags;
@@ -1711,7 +1754,7 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 	lockdep_assert_held(q->queue_lock);
 
 	blk_req_zone_write_unlock(req);
-	blk_pm_put_request(req);
+	blk_pm_put_request(q);
 
 	elv_completed_request(q, req);
 
@@ -2712,30 +2755,6 @@ void blk_account_io_done(struct request *req, u64 now)
 	}
 }
 
-#ifdef CONFIG_PM
-/*
- * Don't process normal requests when queue is suspended
- * or in the process of suspending/resuming
- */
-static bool blk_pm_allow_request(struct request *rq)
-{
-	switch (rq->q->rpm_status) {
-	case RPM_RESUMING:
-	case RPM_SUSPENDING:
-		return rq->rq_flags & RQF_PM;
-	case RPM_SUSPENDED:
-		return false;
-	default:
-		return true;
-	}
-}
-#else
-static bool blk_pm_allow_request(struct request *rq)
-{
-	return true;
-}
-#endif
-
 void blk_account_io_start(struct request *rq, bool new_io)
 {
 	struct hd_struct *part;
@@ -2780,13 +2799,8 @@ static struct request *elv_next_request(struct request_queue *q)
 	WARN_ON_ONCE(q->mq_ops);
 
 	while (1) {
-		list_for_each_entry(rq, &q->queue_head, queuelist) {
-			if (blk_pm_allow_request(rq))
-				return rq;
-
-			if (rq->rq_flags & RQF_SOFTBARRIER)
-				break;
-		}
+		list_for_each_entry(rq, &q->queue_head, queuelist)
+			return rq;
 
 		/*
 		 * Flush request is running and flush request isn't queueable
@@ -3790,6 +3804,10 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 		q->rpm_status = RPM_SUSPENDING;
 	}
 	spin_unlock_irq(q->queue_lock);
+
+	if (!ret)
+		blk_freeze_queue_lock(q);
+
 	return ret;
 }
 EXPORT_SYMBOL(blk_pre_runtime_suspend);
@@ -3867,13 +3885,15 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 	spin_lock_irq(q->queue_lock);
 	if (!err) {
 		q->rpm_status = RPM_ACTIVE;
-		__blk_run_queue(q);
 		pm_runtime_mark_last_busy(q->dev);
 		pm_request_autosuspend(q->dev);
 	} else {
 		q->rpm_status = RPM_SUSPENDED;
 	}
 	spin_unlock_irq(q->queue_lock);
+
+	if (!err)
+		blk_unfreeze_queue_lock(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7868daaf6de0..c119336d0561 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -204,6 +204,28 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
+void blk_unfreeze_queue_lock(struct request_queue *q)
+{
+	mutex_lock(&q->freeze_lock);
+	if (q->q_frozen) {
+		blk_mq_unfreeze_queue(q);
+		q->q_frozen = false;
+	}
+	mutex_unlock(&q->freeze_lock);
+}
+EXPORT_SYMBOL(blk_unfreeze_queue_lock);
+
+void blk_freeze_queue_lock(struct request_queue *q)
+{
+	mutex_lock(&q->freeze_lock);
+	if (!q->q_frozen) {
+		blk_mq_freeze_queue(q);
+		q->q_frozen = true;
+	}
+	mutex_unlock(&q->freeze_lock);
+}
+EXPORT_SYMBOL(blk_freeze_queue_lock);
+
 /*
  * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
  * mpt3sas driver such that this function can be removed.
diff --git a/block/elevator.c b/block/elevator.c
index d6abba76c89e..2e4d347ad726 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -557,27 +557,6 @@ void elv_bio_merged(struct request_queue *q, struct request *rq,
 		e->type->ops.sq.elevator_bio_merged_fn(q, rq, bio);
 }
 
-#ifdef CONFIG_PM
-static void blk_pm_requeue_request(struct request *rq)
-{
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
-		rq->q->nr_pending--;
-}
-
-static void blk_pm_add_request(struct request_queue *q, struct request *rq)
-{
-	if (q->dev && !(rq->rq_flags & RQF_PM) && q->nr_pending++ == 0 &&
-	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
-		pm_request_resume(q->dev);
-}
-#else
-static inline void blk_pm_requeue_request(struct request *rq) {}
-static inline void blk_pm_add_request(struct request_queue *q,
-				      struct request *rq)
-{
-}
-#endif
-
 void elv_requeue_request(struct request_queue *q, struct request *rq)
 {
 	/*
@@ -592,8 +571,6 @@ void elv_requeue_request(struct request_queue *q, struct request *rq)
 
 	rq->rq_flags &= ~RQF_STARTED;
 
-	blk_pm_requeue_request(rq);
-
 	__elv_add_request(q, rq, ELEVATOR_INSERT_REQUEUE);
 }
 
@@ -620,8 +597,6 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 {
 	trace_block_rq_insert(q, rq);
 
-	blk_pm_add_request(q, rq);
-
 	rq->q = q;
 
 	if (rq->rq_flags & RQF_SOFTBARRIER) {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 85fed8d96c8a..84d1c450b858 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -278,12 +278,17 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	struct request *req;
 	struct scsi_request *rq;
 	int ret = DRIVER_ERROR << 24;
+	bool pm_rq = rq_flags & RQF_PM;
+
+	if (!pm_rq)
+		scsi_autopm_get_device(sdev);
 
 	req = blk_get_request(sdev->host->admin_q,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
 	if (IS_ERR(req))
-		return ret;
+		goto fail;
+
 	rq = scsi_req(req);
 
 	if (bufflen &&	blk_rq_map_kern(req->q, req,
@@ -327,6 +332,9 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 
 	atomic_dec(&sdev->nr_admin_pending);
 	wake_up_all(&sdev->admin_wq);
+ fail:
+	if (!pm_rq)
+		scsi_autopm_put_device(sdev);
 
 	return ret;
 }
@@ -3182,7 +3190,7 @@ scsi_device_quiesce(struct scsi_device *sdev)
 {
 	int err;
 
-	blk_mq_freeze_queue(sdev->request_queue);
+	blk_freeze_queue_lock(sdev->request_queue);
 
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
@@ -3212,7 +3220,7 @@ void scsi_device_resume(struct scsi_device *sdev)
 		scsi_device_set_state(sdev, SDEV_RUNNING);
 	mutex_unlock(&sdev->state_mutex);
 
-	blk_mq_unfreeze_queue(sdev->request_queue);
+	blk_unfreeze_queue_lock(sdev->request_queue);
 }
 EXPORT_SYMBOL(scsi_device_resume);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index afde18ac5b31..00970a0b4b06 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -295,6 +295,8 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+void blk_freeze_queue_lock(struct request_queue *q);
+void blk_unfreeze_queue_lock(struct request_queue *q);
 
 int blk_mq_map_queues(struct blk_mq_tag_set *set);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1bd4f02d11c0..4b2abdccec1f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -635,6 +635,9 @@ struct request_queue {
 	int			bypass_depth;
 	atomic_t		mq_freeze_depth;
 
+	bool			q_frozen;
+	struct mutex		freeze_lock;
+
 #if defined(CONFIG_BLK_DEV_BSG)
 	bsg_job_fn		*bsg_job_fn;
 	struct bsg_class_device bsg_dev;
-- 
2.9.5
