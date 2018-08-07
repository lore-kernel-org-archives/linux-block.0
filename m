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
Subject: [RFC PATCH 13/14] block: simplify runtime PM support
Date: Wed,  8 Aug 2018 01:44:32 +0800
Message-Id: <20180807174433.8374-14-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patch simplifies runtime PM support by the following approach:

1) resume device in blk_queue_enter() if this device isn't active

2) freeze queue in blk_pre_runtime_suspend()

3) unfreeze queue in blk_pre_runtime_resume()

4) remove checking on RRF_PM because now we requires out-of-band PM
request to resume device

Then we can remove blk_pm_allow_request(), and more importantly this way
can be applied to blk-mq path too.

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
 block/blk-core.c        | 72 ++++++++++++++++++++++++++-----------------------
 block/elevator.c        |  7 +++--
 drivers/scsi/scsi_lib.c |  7 +++++
 include/linux/blkdev.h  |  2 ++
 4 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ea12e3fcfa11..7390149f4fd1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -884,6 +884,24 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+#ifdef CONFIG_PM
+static void blk_resume_queue(struct request_queue *q)
+{
+	if (!q->dev)
+		return;
+
+	/* PM request needs to be dealt with out of band */
+	mutex_lock(&q->pm_lock);
+	if (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING)
+		pm_runtime_resume(q->dev);
+	mutex_unlock(&q->pm_lock);
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
@@ -907,6 +925,8 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		 */
 		smp_rmb();
 
+		blk_resume_queue(q);
+
 		wait_event(q->mq_freeze_wq,
 			   atomic_read(&q->mq_freeze_depth) == 0 ||
 			   blk_queue_dying(q));
@@ -1684,7 +1704,7 @@ EXPORT_SYMBOL_GPL(part_round_stats);
 #ifdef CONFIG_PM
 static void blk_pm_put_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM) && !--rq->q->nr_pending)
+	if (rq->q->dev && !--rq->q->nr_pending)
 		pm_runtime_mark_last_busy(rq->q->dev);
 }
 #else
@@ -2702,30 +2722,6 @@ void blk_account_io_done(struct request *req, u64 now)
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
@@ -2770,13 +2766,8 @@ static struct request *elv_next_request(struct request_queue *q)
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
@@ -3737,6 +3728,7 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 		return;
 	}
 
+	mutex_init(&q->pm_lock);
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
 	pm_runtime_set_autosuspend_delay(q->dev, -1);
@@ -3772,6 +3764,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!q->dev)
 		return ret;
 
+	mutex_lock(&q->pm_lock);
 	spin_lock_irq(q->queue_lock);
 	if (q->nr_pending) {
 		ret = -EBUSY;
@@ -3780,6 +3773,13 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 		q->rpm_status = RPM_SUSPENDING;
 	}
 	spin_unlock_irq(q->queue_lock);
+
+	if (!ret) {
+		blk_freeze_queue(q);
+		q->rpm_q_frozen = true;
+	}
+	mutex_unlock(&q->pm_lock);
+
 	return ret;
 }
 EXPORT_SYMBOL(blk_pre_runtime_suspend);
@@ -3854,16 +3854,22 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 	if (!q->dev)
 		return;
 
+	lockdep_assert_held(&q->pm_lock);
+
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
+	if (!err && q->rpm_q_frozen) {
+		blk_mq_unfreeze_queue(q);
+		q->rpm_q_frozen = false;
+	}
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
 
diff --git a/block/elevator.c b/block/elevator.c
index a34fecbe7e81..d389b942378b 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -560,15 +560,14 @@ void elv_bio_merged(struct request_queue *q, struct request *rq,
 #ifdef CONFIG_PM
 static void blk_pm_requeue_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
+	if (rq->q->dev)
 		rq->q->nr_pending--;
 }
 
 static void blk_pm_add_request(struct request_queue *q, struct request *rq)
 {
-	if (q->dev && !(rq->rq_flags & RQF_PM) && q->nr_pending++ == 0 &&
-	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
-		pm_request_resume(q->dev);
+	if (q->dev)
+		q->nr_pending++;
 }
 #else
 static inline void blk_pm_requeue_request(struct request *rq) {}
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c78602f1a425..0aee332fbb63 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -279,6 +279,10 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	struct scsi_request *rq;
 	int ret = DRIVER_ERROR << 24;
 	struct request_queue *q = sdev->host->admin_q;
+	bool pm_rq = rq_flags & RQF_PM;
+
+	if (!pm_rq)
+		scsi_autopm_get_device(sdev);
 
 	req = blk_get_request(q,
 			data_direction == DMA_TO_DEVICE ?
@@ -328,6 +332,9 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	atomic_dec(&sdev->nr_admin_pending);
 	wake_up_all(&sdev->admin_wq);
 
+	if (!pm_rq)
+		scsi_autopm_put_device(sdev);
+
 	return ret;
 }
 EXPORT_SYMBOL(__scsi_execute);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a9d371f55ca5..b3dcba83a8d7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -544,6 +544,8 @@ struct request_queue {
 	struct device		*dev;
 	int			rpm_status;
 	unsigned int		nr_pending;
+	bool			rpm_q_frozen;
+	struct mutex		pm_lock;
 #endif
 
 	/*
-- 
2.9.5
