Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v8 4/8] block, scsi: Change the preempt-only flag into a counter
Date: Tue, 18 Sep 2018 13:58:59 -0700
Message-Id: <20180918205903.15516-5-bvanassche@acm.org>
In-Reply-To: <20180918205903.15516-1-bvanassche@acm.org>
References: <20180918205903.15516-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The RQF_PREEMPT flag is used for three purposes:
- In the SCSI core, for making sure that power management requests
  are executed even if a device is in the "quiesced" state.
- For domain validation by SCSI drivers that use the parallel port.
- In the IDE driver, for IDE preempt requests.
Rename "preempt-only" into "pm-only" because the primary purpose of
this mode is power management. Since the power management core may
but does not have to resume a runtime suspended device before
performing system-wide suspend and since a later patch will set
"pm-only" mode as long as a block device is runtime suspended, make
it possible to set "pm-only" mode from more than one context. Since
with this change scsi_device_quiesce() is no longer idempotent, make
that function return early if it is called for a quiesced queue.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c        | 35 ++++++++++++++++++-----------------
 block/blk-mq-debugfs.c  | 10 +++++++++-
 drivers/scsi/scsi_lib.c | 11 +++++++----
 include/linux/blkdev.h  | 14 +++++++++-----
 4 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6d4dd176bd9d..1a691f5269bb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -422,24 +422,25 @@ void blk_sync_queue(struct request_queue *q)
 EXPORT_SYMBOL(blk_sync_queue);
 
 /**
- * blk_set_preempt_only - set QUEUE_FLAG_PREEMPT_ONLY
+ * blk_set_pm_only - increment pm_only counter
  * @q: request queue pointer
- *
- * Returns the previous value of the PREEMPT_ONLY flag - 0 if the flag was not
- * set and 1 if the flag was already set.
  */
-int blk_set_preempt_only(struct request_queue *q)
+void blk_set_pm_only(struct request_queue *q)
 {
-	return blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
+	atomic_inc(&q->pm_only);
 }
-EXPORT_SYMBOL_GPL(blk_set_preempt_only);
+EXPORT_SYMBOL_GPL(blk_set_pm_only);
 
-void blk_clear_preempt_only(struct request_queue *q)
+void blk_clear_pm_only(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
-	wake_up_all(&q->mq_freeze_wq);
+	int pm_only;
+
+	pm_only = atomic_dec_return(&q->pm_only);
+	WARN_ON_ONCE(pm_only < 0);
+	if (pm_only == 0)
+		wake_up_all(&q->mq_freeze_wq);
 }
-EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
+EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
 /**
  * __blk_run_queue_uncond - run a queue whether or not it has been stopped
@@ -918,7 +919,7 @@ EXPORT_SYMBOL(blk_alloc_queue);
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-	const bool preempt = flags & BLK_MQ_REQ_PREEMPT;
+	const bool pm = flags & BLK_MQ_REQ_PREEMPT;
 
 	while (true) {
 		bool success = false;
@@ -926,11 +927,11 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		rcu_read_lock();
 		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
 			/*
-			 * The code that sets the PREEMPT_ONLY flag is
-			 * responsible for ensuring that that flag is globally
-			 * visible before the queue is unfrozen.
+			 * The code that increments the pm_only counter is
+			 * responsible for ensuring that that counter is
+			 * globally visible before the queue is unfrozen.
 			 */
-			if (preempt || !blk_queue_preempt_only(q)) {
+			if (pm || !blk_queue_pm_only(q)) {
 				success = true;
 			} else {
 				percpu_ref_put(&q->q_usage_counter);
@@ -955,7 +956,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
 		wait_event(q->mq_freeze_wq,
 			   (atomic_read(&q->mq_freeze_depth) == 0 &&
-			    (preempt || !blk_queue_preempt_only(q))) ||
+			    (pm || !blk_queue_pm_only(q))) ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cb1e6cf7ac48..a5ea86835fcb 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -102,6 +102,14 @@ static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 	return 0;
 }
 
+static int queue_pm_only_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+
+	seq_printf(m, "%d\n", atomic_read(&q->pm_only));
+	return 0;
+}
+
 #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
 static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(QUEUED),
@@ -132,7 +140,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
-	QUEUE_FLAG_NAME(PREEMPT_ONLY),
 };
 #undef QUEUE_FLAG_NAME
 
@@ -209,6 +216,7 @@ static ssize_t queue_write_hint_store(void *data, const char __user *buf,
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{ "poll_stat", 0400, queue_poll_stat_show },
 	{ "requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops },
+	{ "pm_only", 0600, queue_pm_only_show, NULL },
 	{ "state", 0600, queue_state_show, queue_state_write },
 	{ "write_hints", 0600, queue_write_hint_show, queue_write_hint_store },
 	{ "zone_wlock", 0400, queue_zone_wlock_show, NULL },
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index eb97d2dd3651..62348412ed1b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3046,11 +3046,14 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	 */
 	WARN_ON_ONCE(sdev->quiesced_by && sdev->quiesced_by != current);
 
-	blk_set_preempt_only(q);
+	if (sdev->quiesced_by == current)
+		return 0;
+
+	blk_set_pm_only(q);
 
 	blk_mq_freeze_queue(q);
 	/*
-	 * Ensure that the effect of blk_set_preempt_only() will be visible
+	 * Ensure that the effect of blk_set_pm_only() will be visible
 	 * for percpu_ref_tryget() callers that occur after the queue
 	 * unfreeze even if the queue was already frozen before this function
 	 * was called. See also https://lwn.net/Articles/573497/.
@@ -3063,7 +3066,7 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	if (err == 0)
 		sdev->quiesced_by = current;
 	else
-		blk_clear_preempt_only(q);
+		blk_clear_pm_only(q);
 	mutex_unlock(&sdev->state_mutex);
 
 	return err;
@@ -3088,7 +3091,7 @@ void scsi_device_resume(struct scsi_device *sdev)
 	mutex_lock(&sdev->state_mutex);
 	WARN_ON_ONCE(!sdev->quiesced_by);
 	sdev->quiesced_by = NULL;
-	blk_clear_preempt_only(sdev->request_queue);
+	blk_clear_pm_only(sdev->request_queue);
 	if (sdev->sdev_state == SDEV_QUIESCE)
 		scsi_device_set_state(sdev, SDEV_RUNNING);
 	mutex_unlock(&sdev->state_mutex);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e25ce42c982d..5f6c36b5058c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -504,6 +504,12 @@ struct request_queue {
 	 * various queue flags, see QUEUE_* below
 	 */
 	unsigned long		queue_flags;
+	/*
+	 * Number of contexts that have called blk_set_pm_only(). If this
+	 * counter is above zero then only RQF_PM and RQF_PREEMPT requests are
+	 * processed.
+	 */
+	atomic_t		pm_only;
 
 	/*
 	 * ida allocated id for this queue.  Used to index queues from
@@ -698,7 +704,6 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
-#define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -736,12 +741,11 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
-#define blk_queue_preempt_only(q)				\
-	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
+#define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 
-extern int blk_set_preempt_only(struct request_queue *q);
-extern void blk_clear_preempt_only(struct request_queue *q);
+extern void blk_set_pm_only(struct request_queue *q);
+extern void blk_clear_pm_only(struct request_queue *q);
 
 static inline int queue_in_flight(struct request_queue *q)
 {
-- 
2.18.0
