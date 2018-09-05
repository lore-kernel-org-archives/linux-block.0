Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com, bart.vanassche@wdc.com,
        sagi@grimberg.me, keith.busch@intel.com, jthumshirn@suse.de,
        jsmart2021@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: [PATCH 1/3] blk-core: migrate preempt-only mode to queue_gate
Date: Wed,  5 Sep 2018 12:09:44 +0800
Message-Id: <1536120586-3378-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

This patch introduce queue_gate into request_queue which is
dedicated to entering conditions control in blk_queue_enter.
Helper blk_queue_gate_allow is in charge of checking entering
conditions. If not allowed, go to wait on wq_freeze_wq. This is
a preparation for the next light-weight queue close feature.
And also the preempt-only mode is migrated from the queue_flags
to queue_gate in this patch.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c        | 65 +++++++++++++++++++++++++++++--------------------
 block/blk-mq-debugfs.c  |  1 -
 block/blk.h             |  4 +++
 drivers/scsi/scsi_lib.c | 10 --------
 include/linux/blkdev.h  |  4 +--
 5 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dee56c2..d1bdded 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -420,22 +420,31 @@ void blk_sync_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_sync_queue);
 
-/**
- * blk_set_preempt_only - set QUEUE_FLAG_PREEMPT_ONLY
- * @q: request queue pointer
- *
- * Returns the previous value of the PREEMPT_ONLY flag - 0 if the flag was not
- * set and 1 if the flag was already set.
+/*
+ * When blk_set_preempt_only returns:
+ *  - only preempt bio could enter the queue
+ *  - there is no non-preempt bios in the queue
  */
 int blk_set_preempt_only(struct request_queue *q)
 {
-	return blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
+	if (test_and_set_bit(BLK_QUEUE_GATE_PREEMPT_ONLY, &q->queue_gate))
+		return 1;
+
+	synchronize_rcu();
+	/*
+	 * After this, the non-preempt bios either get q_usage_counter
+	 * and enter, or go to wait.
+	 * Next, let's drain the entered ones.
+	 */
+	blk_mq_freeze_queue(q);
+	blk_mq_unfreeze_queue(q);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_set_preempt_only);
 
 void blk_clear_preempt_only(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
+	clear_bit(BLK_QUEUE_GATE_PREEMPT_ONLY, &q->queue_gate);
 	wake_up_all(&q->mq_freeze_wq);
 }
 EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
@@ -910,6 +919,19 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+static inline bool blk_queue_gate_allow(struct request_queue *q,
+		blk_mq_req_flags_t flags)
+{
+	if (!q->queue_gate)
+		return true;
+
+	if (test_bit(BLK_QUEUE_GATE_PREEMPT_ONLY, &q->queue_gate) &&
+		!(flags & BLK_MQ_REQ_PREEMPT))
+		return false;
+
+	return true;
+}
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -917,29 +939,20 @@ EXPORT_SYMBOL(blk_alloc_queue);
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-	const bool preempt = flags & BLK_MQ_REQ_PREEMPT;
-
 	while (true) {
-		bool success = false;
 
 		rcu_read_lock();
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
+		if (unlikely(READ_ONCE(q->queue_gate))) {
+			if (!blk_queue_gate_allow(q, flags))
+				goto wait;
 		}
-		rcu_read_unlock();
 
-		if (success)
+		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
+			rcu_read_unlock();
 			return 0;
-
+		}
+wait:
+		rcu_read_unlock();
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
@@ -954,7 +967,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
 		wait_event(q->mq_freeze_wq,
 			   (atomic_read(&q->mq_freeze_depth) == 0 &&
-			    (preempt || !blk_queue_preempt_only(q))) ||
+			    blk_queue_gate_allow(q, flags)) ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cb1e6cf..4174951 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -132,7 +132,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
-	QUEUE_FLAG_NAME(PREEMPT_ONLY),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk.h b/block/blk.h
index 9db4e38..cdef4c1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -19,6 +19,10 @@
 extern struct dentry *blk_debugfs_root;
 #endif
 
+enum blk_queue_gate_flag_t {
+	BLK_QUEUE_GATE_PREEMPT_ONLY,
+};
+
 struct blk_flush_queue {
 	unsigned int		flush_queue_delayed:1;
 	unsigned int		flush_pending_idx:1;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0adfb3b..491d8bf 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3059,16 +3059,6 @@ scsi_device_quiesce(struct scsi_device *sdev)
 
 	blk_set_preempt_only(q);
 
-	blk_mq_freeze_queue(q);
-	/*
-	 * Ensure that the effect of blk_set_preempt_only() will be visible
-	 * for percpu_ref_tryget() callers that occur after the queue
-	 * unfreeze even if the queue was already frozen before this function
-	 * was called. See also https://lwn.net/Articles/573497/.
-	 */
-	synchronize_rcu();
-	blk_mq_unfreeze_queue(q);
-
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
 	if (err == 0)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0..4a33814 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -504,6 +504,7 @@ struct request_queue {
 	 * various queue flags, see QUEUE_* below
 	 */
 	unsigned long		queue_flags;
+	unsigned long		queue_gate;
 
 	/*
 	 * ida allocated id for this queue.  Used to index queues from
@@ -698,7 +699,6 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
-#define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -736,8 +736,6 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
-#define blk_queue_preempt_only(q)				\
-	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 
 extern int blk_set_preempt_only(struct request_queue *q);
-- 
2.7.4
