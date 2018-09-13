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
Subject: [PATCH V3 15/17] SCSI: use admin queue to implement queue QUIESCE
Date: Thu, 13 Sep 2018 20:15:44 +0800
Message-Id: <20180913121546.5710-16-ming.lei@redhat.com>
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
References: <20180913121546.5710-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

All admin commands are sent via per-host admin queue, so we can simply
freeze the IO queue for quiescing scsi device.

Also the current SCSI stack guarantees that any request originated from
admin queue won't be called back to block layer via the associated IO queue,
and it is always dealt with by the admin queue.

So it is safe to submit admin request via admin queue when the associated IO
queue is frozen, and this way matches the PREEMPT flag perfectly.

Finally, we can remove the preempt_only approach for supporting SCSI
quiesce, then the code in block fast path is simplified a lot.

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
 block/blk-core.c           | 44 ++------------------------------------------
 block/blk-mq-debugfs.c     |  1 -
 drivers/scsi/scsi_lib.c    | 29 +++--------------------------
 include/linux/blkdev.h     |  6 ------
 include/scsi/scsi_device.h |  1 -
 5 files changed, 5 insertions(+), 76 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 4dbc93f43b38..f51c19b381e3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -421,26 +421,6 @@ void blk_sync_queue(struct request_queue *q)
 EXPORT_SYMBOL(blk_sync_queue);
 
 /**
- * blk_set_preempt_only - set QUEUE_FLAG_PREEMPT_ONLY
- * @q: request queue pointer
- *
- * Returns the previous value of the PREEMPT_ONLY flag - 0 if the flag was not
- * set and 1 if the flag was already set.
- */
-int blk_set_preempt_only(struct request_queue *q)
-{
-	return blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
-}
-EXPORT_SYMBOL_GPL(blk_set_preempt_only);
-
-void blk_clear_preempt_only(struct request_queue *q)
-{
-	blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
-	wake_up_all(&q->mq_freeze_wq);
-}
-EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
-
-/**
  * __blk_run_queue_uncond - run a queue whether or not it has been stopped
  * @q:	The queue to run
  *
@@ -917,27 +897,8 @@ EXPORT_SYMBOL(blk_alloc_queue);
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-	const bool preempt = flags & BLK_MQ_REQ_PREEMPT;
-
 	while (true) {
-		bool success = false;
-
-		rcu_read_lock();
-		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
-			/*
-			 * The code that sets the PREEMPT_ONLY flag is
-			 * responsible for ensuring that that flag is globally
-			 * visible before the queue is unfrozen.
-			 */
-			if (preempt || !blk_queue_preempt_only(q)) {
-				success = true;
-			} else {
-				percpu_ref_put(&q->q_usage_counter);
-			}
-		}
-		rcu_read_unlock();
-
-		if (success)
+		if (percpu_ref_tryget_live(&q->q_usage_counter))
 			return 0;
 
 		if (flags & BLK_MQ_REQ_NOWAIT)
@@ -953,8 +914,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		smp_rmb();
 
 		wait_event(q->mq_freeze_wq,
-			   (atomic_read(&q->mq_freeze_depth) == 0 &&
-			    (preempt || !blk_queue_preempt_only(q))) ||
+			   atomic_read(&q->mq_freeze_depth) == 0 ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 8df013e9f242..82df43ec322f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -132,7 +132,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
-	QUEUE_FLAG_NAME(PREEMPT_ONLY),
 	QUEUE_FLAG_NAME(ADMIN),
 };
 #undef QUEUE_FLAG_NAME
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1e75515cc7ba..85fed8d96c8a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3180,34 +3180,12 @@ static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
 int
 scsi_device_quiesce(struct scsi_device *sdev)
 {
-	struct request_queue *q = sdev->request_queue;
 	int err;
 
-	/*
-	 * It is allowed to call scsi_device_quiesce() multiple times from
-	 * the same context but concurrent scsi_device_quiesce() calls are
-	 * not allowed.
-	 */
-	WARN_ON_ONCE(sdev->quiesced_by && sdev->quiesced_by != current);
-
-	blk_set_preempt_only(q);
-
-	blk_mq_freeze_queue(q);
-	/*
-	 * Ensure that the effect of blk_set_preempt_only() will be visible
-	 * for percpu_ref_tryget() callers that occur after the queue
-	 * unfreeze even if the queue was already frozen before this function
-	 * was called. See also https://lwn.net/Articles/573497/.
-	 */
-	synchronize_rcu();
-	blk_mq_unfreeze_queue(q);
+	blk_mq_freeze_queue(sdev->request_queue);
 
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
-	if (err == 0)
-		sdev->quiesced_by = current;
-	else
-		blk_clear_preempt_only(q);
 	mutex_unlock(&sdev->state_mutex);
 
 	return err;
@@ -3230,12 +3208,11 @@ void scsi_device_resume(struct scsi_device *sdev)
 	 * device deleted during suspend)
 	 */
 	mutex_lock(&sdev->state_mutex);
-	WARN_ON_ONCE(!sdev->quiesced_by);
-	sdev->quiesced_by = NULL;
-	blk_clear_preempt_only(sdev->request_queue);
 	if (sdev->sdev_state == SDEV_QUIESCE)
 		scsi_device_set_state(sdev, SDEV_RUNNING);
 	mutex_unlock(&sdev->state_mutex);
+
+	blk_mq_unfreeze_queue(sdev->request_queue);
 }
 EXPORT_SYMBOL(scsi_device_resume);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2dbc7524a169..1bd4f02d11c0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -698,7 +698,6 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
-#define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
 #define QUEUE_FLAG_ADMIN	30	/* admin queue */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
@@ -740,14 +739,9 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
-#define blk_queue_preempt_only(q)				\
-	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_admin(q)	test_bit(QUEUE_FLAG_ADMIN, &(q)->queue_flags)
 
-extern int blk_set_preempt_only(struct request_queue *q);
-extern void blk_clear_preempt_only(struct request_queue *q);
-
 static inline int queue_in_flight(struct request_queue *q)
 {
 	return q->in_flight[0] + q->in_flight[1];
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index f6820da1dc37..666b58799cec 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -226,7 +226,6 @@ struct scsi_device {
 	unsigned char		access_state;
 	struct mutex		state_mutex;
 	enum scsi_device_state sdev_state;
-	struct task_struct	*quiesced_by;
 
 	atomic_t		nr_admin_pending;
 	wait_queue_head_t       admin_wq;
-- 
2.9.5
