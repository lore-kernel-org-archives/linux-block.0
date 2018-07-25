Return-Path: <prvs=737f04b27=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 4/5] block, scsi: Rework runtime power management
Date: Wed, 25 Jul 2018 15:26:06 -0700
Message-Id: <20180725222607.8854-5-bart.vanassche@wdc.com>
In-Reply-To: <20180725222607.8854-1-bart.vanassche@wdc.com>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Instead of allowing requests that are not power management requests
to enter the queue in runtime suspended status (RPM_SUSPENDED), make
the blk_get_request() caller block. This change fixes a starvation
issue: it is now guaranteed that power management requests will be
executed no matter how many blk_get_request() callers are waiting.
Instead of maintaining the q->nr_pending counter, rely on
q->q_usage_counter. Call pm_runtime_mark_last_busy() every time a
request finishes instead of only if the queue depth drops to zero.
Use RQF_PREEMPT to mark power management requests instead of RQF_PM.
This is safe because the power management core serializes system-wide
suspend/resume and runtime power management state changes.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-core.c          | 49 +++++++++++++++------------------------
 block/blk-mq-debugfs.c    |  1 -
 block/blk-pm.c            | 19 +++++++++++++--
 block/elevator.c          | 11 +--------
 drivers/scsi/sd.c         |  4 ++--
 drivers/scsi/ufs/ufshcd.c | 10 ++++----
 include/linux/blkdev.h    |  7 ++----
 7 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index feac2b4d3b90..195a99de7c7e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -689,6 +689,16 @@ void blk_set_queue_dying(struct request_queue *q)
 {
 	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 
+#ifdef CONFIG_PM
+	/*
+	 * Avoid that runtime power management tries to modify the state of
+	 * q->q_usage_counter after that counter has been transitioned to the
+	 * "dead" state.
+	 */
+	if (q->dev)
+		pm_runtime_dont_use_autosuspend(q->dev);
+#endif
+
 	/*
 	 * When queue DYING flag is set, we need to block new req
 	 * entering queue, so we call blk_freeze_queue_start() to
@@ -1728,7 +1738,7 @@ EXPORT_SYMBOL_GPL(part_round_stats);
 #ifdef CONFIG_PM
 static void blk_pm_put_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM) && !--rq->q->nr_pending)
+	if (rq->q->dev && !(rq->rq_flags & RQF_PREEMPT))
 		pm_runtime_mark_last_busy(rq->q->dev);
 }
 #else
@@ -2745,30 +2755,6 @@ void blk_account_io_done(struct request *req, u64 now)
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
@@ -2814,11 +2800,14 @@ static struct request *elv_next_request(struct request_queue *q)
 
 	while (1) {
 		list_for_each_entry(rq, &q->queue_head, queuelist) {
-			if (blk_pm_allow_request(rq))
-				return rq;
-
-			if (rq->rq_flags & RQF_SOFTBARRIER)
-				break;
+#ifdef CONFIG_PM
+			/*
+			 * If a request gets queued in state RPM_SUSPENDED
+			 * then that's a kernel bug.
+			 */
+			WARN_ON_ONCE(q->rpm_status == RPM_SUSPENDED);
+#endif
+			return rq;
 		}
 
 		/*
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cb1e6cf7ac48..994bdd41feb2 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -324,7 +324,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(ELVPRIV),
 	RQF_NAME(IO_STAT),
 	RQF_NAME(ALLOCED),
-	RQF_NAME(PM),
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 7dc9375a2f46..9f1130381322 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -73,6 +73,13 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 }
 EXPORT_SYMBOL(blk_pm_runtime_init);
 
+static void blk_unprepare_runtime_suspend(struct request_queue *q)
+{
+	blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
+	/* Because QUEUE_FLAG_PREEMPT_ONLY has been cleared. */
+	wake_up_all(&q->mq_freeze_wq);
+}
+
 /**
  * blk_pre_runtime_suspend - Pre runtime suspend check
  * @q: the queue of the device
@@ -102,9 +109,11 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 		return ret;
 
 	blk_pm_runtime_lock(q);
+	blk_set_preempt_only(q);
+	percpu_ref_switch_to_atomic_sync(&q->q_usage_counter);
 
 	spin_lock_irq(q->queue_lock);
-	if (q->nr_pending) {
+	if (!percpu_ref_is_zero(&q->q_usage_counter)) {
 		ret = -EBUSY;
 		pm_runtime_mark_last_busy(q->dev);
 	} else {
@@ -112,6 +121,7 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	}
 	spin_unlock_irq(q->queue_lock);
 
+	percpu_ref_switch_to_percpu(&q->q_usage_counter);
 	blk_pm_runtime_unlock(q);
 
 	return ret;
@@ -144,6 +154,9 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 		pm_runtime_mark_last_busy(q->dev);
 	}
 	spin_unlock_irq(q->queue_lock);
+
+	if (err)
+		blk_unprepare_runtime_suspend(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_suspend);
 
@@ -191,13 +204,15 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
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
+		blk_unprepare_runtime_suspend(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
 
diff --git a/block/elevator.c b/block/elevator.c
index fa828b5bfd4b..68174953e730 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -558,20 +558,13 @@ void elv_bio_merged(struct request_queue *q, struct request *rq,
 }
 
 #ifdef CONFIG_PM
-static void blk_pm_requeue_request(struct request *rq)
-{
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
-		rq->q->nr_pending--;
-}
-
 static void blk_pm_add_request(struct request_queue *q, struct request *rq)
 {
-	if (q->dev && !(rq->rq_flags & RQF_PM) && q->nr_pending++ == 0 &&
+	if (q->dev && !(rq->rq_flags & RQF_PREEMPT) &&
 	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
 		pm_request_resume(q->dev);
 }
 #else
-static inline void blk_pm_requeue_request(struct request *rq) {}
 static inline void blk_pm_add_request(struct request_queue *q,
 				      struct request *rq)
 {
@@ -592,8 +585,6 @@ void elv_requeue_request(struct request_queue *q, struct request *rq)
 
 	rq->rq_flags &= ~RQF_STARTED;
 
-	blk_pm_requeue_request(rq);
-
 	__elv_add_request(q, rq, ELEVATOR_INSERT_REQUEUE);
 }
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index e60cd8480a03..876401f4764e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1628,7 +1628,7 @@ static int sd_sync_cache(struct scsi_disk *sdkp, struct scsi_sense_hdr *sshdr)
 		 * flush everything.
 		 */
 		res = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, sshdr,
-				timeout, SD_MAX_RETRIES, 0, RQF_PM, NULL);
+				timeout, SD_MAX_RETRIES, 0, RQF_PREEMPT, NULL);
 		if (res == 0)
 			break;
 	}
@@ -3488,7 +3488,7 @@ static int sd_start_stop_device(struct scsi_disk *sdkp, int start)
 		return -ENODEV;
 
 	res = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, &sshdr,
-			SD_TIMEOUT, SD_MAX_RETRIES, 0, RQF_PM, NULL);
+			   SD_TIMEOUT, SD_MAX_RETRIES, 0, RQF_PREEMPT, NULL);
 	if (res) {
 		sd_print_result(sdkp, "Start/Stop Unit failed", res);
 		if (driver_byte(res) & DRIVER_SENSE)
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 397081d320b1..4a16d6e90e65 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7219,7 +7219,7 @@ ufshcd_send_request_sense(struct ufs_hba *hba, struct scsi_device *sdp)
 
 	ret = scsi_execute(sdp, cmd, DMA_FROM_DEVICE, buffer,
 			UFSHCD_REQ_SENSE_SIZE, NULL, NULL,
-			msecs_to_jiffies(1000), 3, 0, RQF_PM, NULL);
+			msecs_to_jiffies(1000), 3, 0, RQF_PREEMPT, NULL);
 	if (ret)
 		pr_err("%s: failed with err %d\n", __func__, ret);
 
@@ -7280,12 +7280,12 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	cmd[4] = pwr_mode << 4;
 
 	/*
-	 * Current function would be generally called from the power management
-	 * callbacks hence set the RQF_PM flag so that it doesn't resume the
-	 * already suspended childs.
+	 * Current function would be generally called from the power
+	 * management callbacks hence set the RQF_PREEMPT flag so that it
+	 * doesn't resume the already suspended childs.
 	 */
 	ret = scsi_execute(sdp, cmd, DMA_NONE, NULL, 0, NULL, &sshdr,
-			START_STOP_TIMEOUT, 0, 0, RQF_PM, NULL);
+			   START_STOP_TIMEOUT, 0, 0, RQF_PREEMPT, NULL);
 	if (ret) {
 		sdev_printk(KERN_WARNING, sdp,
 			    "START_STOP failed for power mode: %d, result %x\n",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3a8c20eafe58..4cee277fd1af 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -99,8 +99,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_INFLIGHT		((__force req_flags_t)(1 << 6))
 /* don't call prep for this one */
 #define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
-/* set for "ide_preempt" requests and also for requests for which the SCSI
-   "quiesce" state must be ignored. */
+/* set for requests that must be processed even if QUEUE_FLAG_PREEMPT_ONLY has
+   been set, e.g. power management requests and "ide_preempt" requests. */
 #define RQF_PREEMPT		((__force req_flags_t)(1 << 8))
 /* contains copies of user pages */
 #define RQF_COPY_USER		((__force req_flags_t)(1 << 9))
@@ -114,8 +114,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
 /* request came from our alloc pool */
 #define RQF_ALLOCED		((__force req_flags_t)(1 << 14))
-/* runtime pm request */
-#define RQF_PM			((__force req_flags_t)(1 << 15))
 /* on IO scheduler merge hash */
 #define RQF_HASHED		((__force req_flags_t)(1 << 16))
 /* IO stats tracking on */
@@ -543,7 +541,6 @@ struct request_queue {
 #ifdef CONFIG_PM
 	struct device		*dev;
 	int			rpm_status;
-	unsigned int		nr_pending;
 	spinlock_t		rpm_lock;
 	wait_queue_head_t	rpm_wq;
 	struct task_struct	*rpm_owner;
-- 
2.18.0
