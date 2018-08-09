Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 05/12] block, scsi: Rename QUEUE_FLAG_PREEMPT_ONLY into DV_ONLY and introduce PM_ONLY
Date: Thu,  9 Aug 2018 12:41:42 -0700
Message-Id: <20180809194149.15285-6-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Instead of having one queue state (PREEMPT_ONLY) in which both
power management and SCSI domain validation requests are processed,
rename the PREEMPT_ONLY state into DV_ONLY and introduce a new queue
flag QUEUE_FLAG_PM_ONLY. Provide the new functions blk_set_pm_only()
and blk_clear_pm_only() for power management and blk_set_dv_only()
and blk_clear_dv_only() functions for SCSI domain validation purposes.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c        | 65 ++++++++++++++++++++++++++++++-----------
 block/blk-mq-debugfs.c  |  3 +-
 drivers/scsi/scsi_lib.c | 16 +++++-----
 include/linux/blkdev.h  | 13 +++++----
 4 files changed, 66 insertions(+), 31 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c4ff58491758..401f4927a8db 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -421,24 +421,44 @@ void blk_sync_queue(struct request_queue *q)
 EXPORT_SYMBOL(blk_sync_queue);
 
 /**
- * blk_set_preempt_only - set QUEUE_FLAG_PREEMPT_ONLY
+ * blk_set_dv_only - set QUEUE_FLAG_DV_ONLY
  * @q: request queue pointer
  *
- * Returns the previous value of the PREEMPT_ONLY flag - 0 if the flag was not
+ * Returns the previous value of the DV_ONLY flag - 0 if the flag was not
  * set and 1 if the flag was already set.
  */
-int blk_set_preempt_only(struct request_queue *q)
+int blk_set_dv_only(struct request_queue *q)
 {
-	return blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
+	return blk_queue_flag_test_and_set(QUEUE_FLAG_DV_ONLY, q);
 }
-EXPORT_SYMBOL_GPL(blk_set_preempt_only);
+EXPORT_SYMBOL_GPL(blk_set_dv_only);
 
-void blk_clear_preempt_only(struct request_queue *q)
+void blk_clear_dv_only(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
+	blk_queue_flag_clear(QUEUE_FLAG_DV_ONLY, q);
 	wake_up_all(&q->mq_freeze_wq);
 }
-EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
+EXPORT_SYMBOL_GPL(blk_clear_dv_only);
+
+/**
+ * blk_set_pm_only - set QUEUE_FLAG_PM_ONLY
+ * @q: request queue pointer
+ *
+ * Returns the previous value of the PM_ONLY flag - 0 if the flag was not
+ * set and 1 if the flag was already set.
+ */
+int blk_set_pm_only(struct request_queue *q)
+{
+	return blk_queue_flag_test_and_set(QUEUE_FLAG_PM_ONLY, q);
+}
+EXPORT_SYMBOL_GPL(blk_set_pm_only);
+
+void blk_clear_pm_only(struct request_queue *q)
+{
+	blk_queue_flag_clear(QUEUE_FLAG_PM_ONLY, q);
+	wake_up_all(&q->mq_freeze_wq);
+}
+EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
 /**
  * __blk_run_queue_uncond - run a queue whether or not it has been stopped
@@ -910,6 +930,20 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+/*
+ * Whether or not blk_queue_enter() should proceed. RQF_PM requests are always
+ * allowed. RQF_DV requests are allowed if the PM_ONLY queue flag has not been
+ * set. Other requests are only allowed if neither PM_ONLY nor DV_ONLY has been
+ * set.
+ */
+static inline bool blk_enter_allowed(struct request_queue *q,
+				     blk_mq_req_flags_t flags)
+{
+	return flags & BLK_MQ_REQ_PM ||
+		(!blk_queue_pm_only(q) &&
+		 (flags & BLK_MQ_REQ_DV || !blk_queue_dv_only(q)));
+}
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -917,23 +951,20 @@ EXPORT_SYMBOL(blk_alloc_queue);
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-	const bool preempt = flags & (BLK_MQ_REQ_PM | BLK_MQ_REQ_DV);
-
 	while (true) {
 		bool success = false;
 
 		rcu_read_lock();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
 			/*
-			 * The code that sets the PREEMPT_ONLY flag is
-			 * responsible for ensuring that that flag is globally
-			 * visible before the queue is unfrozen.
+			 * The code that sets the PM_ONLY or DV_ONLY queue
+			 * flags is responsible for ensuring that that flag is
+			 * globally visible before the queue is unfrozen.
 			 */
-			if (preempt || !blk_queue_preempt_only(q)) {
+			if (blk_enter_allowed(q, flags))
 				success = true;
-			} else {
+			else
 				percpu_ref_put(&q->q_usage_counter);
-			}
 		}
 		rcu_read_unlock();
 
@@ -954,7 +985,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
 		wait_event(q->mq_freeze_wq,
 			   (atomic_read(&q->mq_freeze_depth) == 0 &&
-			    (preempt || !blk_queue_preempt_only(q))) ||
+			    blk_enter_allowed(q, flags)) ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b4e722311ae1..2ac9949bf68e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -132,7 +132,8 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
-	QUEUE_FLAG_NAME(PREEMPT_ONLY),
+	QUEUE_FLAG_NAME(PM_ONLY),
+	QUEUE_FLAG_NAME(DV_ONLY),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index eb914d8e17fd..d466f846043f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2997,11 +2997,11 @@ scsi_device_suspend(struct scsi_device *sdev)
 	if (sdev->sdev_state == SDEV_SUSPENDED)
 		return 0;
 
-	blk_set_preempt_only(q);
+	blk_set_pm_only(q);
 
 	blk_mq_freeze_queue(q);
 	/*
-	 * Ensure that the effect of blk_set_preempt_only() will be visible
+	 * Ensure that the effect of blk_set_pm_only() will be visible
 	 * for percpu_ref_tryget() callers that occur after the queue
 	 * unfreeze even if the queue was already frozen before this function
 	 * was called. See also https://lwn.net/Articles/573497/.
@@ -3012,7 +3012,7 @@ scsi_device_suspend(struct scsi_device *sdev)
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_SUSPENDED);
 	if (err)
-		blk_clear_preempt_only(q);
+		blk_clear_pm_only(q);
 	mutex_unlock(&sdev->state_mutex);
 
 	return err;
@@ -3030,7 +3030,7 @@ EXPORT_SYMBOL(scsi_device_suspend);
 void scsi_device_unsuspend(struct scsi_device *sdev)
 {
 	mutex_lock(&sdev->state_mutex);
-	blk_clear_preempt_only(sdev->request_queue);
+	blk_clear_pm_only(sdev->request_queue);
 	if (sdev->sdev_state == SDEV_SUSPENDED)
 		scsi_device_set_state(sdev, SDEV_RUNNING);
 	mutex_unlock(&sdev->state_mutex);
@@ -3088,11 +3088,11 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	 */
 	WARN_ON_ONCE(sdev->quiesced_by && sdev->quiesced_by != current);
 
-	blk_set_preempt_only(q);
+	blk_set_dv_only(q);
 
 	blk_mq_freeze_queue(q);
 	/*
-	 * Ensure that the effect of blk_set_preempt_only() will be visible
+	 * Ensure that the effect of blk_set_dv_only() will be visible
 	 * for percpu_ref_tryget() callers that occur after the queue
 	 * unfreeze even if the queue was already frozen before this function
 	 * was called. See also https://lwn.net/Articles/573497/.
@@ -3105,7 +3105,7 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	if (err == 0)
 		sdev->quiesced_by = current;
 	else
-		blk_clear_preempt_only(q);
+		blk_clear_dv_only(q);
 	mutex_unlock(&sdev->state_mutex);
 
 	return err;
@@ -3125,7 +3125,7 @@ void scsi_device_unquiesce(struct scsi_device *sdev)
 	mutex_lock(&sdev->state_mutex);
 	WARN_ON_ONCE(!sdev->quiesced_by);
 	sdev->quiesced_by = NULL;
-	blk_clear_preempt_only(sdev->request_queue);
+	blk_clear_dv_only(sdev->request_queue);
 	if (sdev->sdev_state == SDEV_QUIESCE)
 		scsi_device_set_state(sdev, SDEV_RUNNING);
 	mutex_unlock(&sdev->state_mutex);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 938725ef492b..7717b71c6da3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -699,7 +699,8 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
-#define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
+#define QUEUE_FLAG_PM_ONLY	29	/* only process RQF_PM requests */
+#define QUEUE_FLAG_DV_ONLY	30	/* only process RQF_DV requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -737,12 +738,14 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
-#define blk_queue_preempt_only(q)				\
-	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
+#define blk_queue_pm_only(q)	test_bit(QUEUE_FLAG_PM_ONLY, &(q)->queue_flags)
+#define blk_queue_dv_only(q)	test_bit(QUEUE_FLAG_DV_ONLY, &(q)->queue_flags)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 
-extern int blk_set_preempt_only(struct request_queue *q);
-extern void blk_clear_preempt_only(struct request_queue *q);
+extern int blk_set_pm_only(struct request_queue *q);
+extern void blk_clear_pm_only(struct request_queue *q);
+extern int blk_set_dv_only(struct request_queue *q);
+extern void blk_clear_dv_only(struct request_queue *q);
 
 static inline int queue_in_flight(struct request_queue *q)
 {
-- 
2.18.0
