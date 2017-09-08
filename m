Return-Path: <prvs=4177119eb=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/5] block: Make SCSI device suspend work reliably
Date: Fri,  8 Sep 2017 16:52:25 -0700
Message-Id: <20170908235226.26622-5-bart.vanassche@wdc.com>
In-Reply-To: <20170908235226.26622-1-bart.vanassche@wdc.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Instead of allowing request allocation to succeed for suspended
request queues and only to process power management requests, make
blk_get_request() wait until the request queue is resumed for
requests that are not power management requests.

This patch avoids that resume does not occur if the maximum queue
depth is reached when a power management request is submitted.

Note: this patch affects the behavior of scsi_device_quiesce() only
if that function is called from inside a power management callback.
This patch does not affect the behavior of scsi_device_quiesce()
when a call of that function is triggered by writing "quiesce" into
/sys/class/scsi_device/*/device/state.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 60 +++++++++++++++++++++++++++-----------------------
 block/blk.h            | 12 ++++++++++
 include/linux/blkdev.h |  1 +
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bb53c6b58e8c..cd2700c763ed 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1325,6 +1325,24 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 	return ERR_PTR(-ENOMEM);
 }
 
+#ifdef CONFIG_PM
+static bool blk_wait_until_active(struct request_queue *q, bool wait)
+	__releases(q->queue_lock)
+	__acquires(q->queue_lock)
+{
+	if (wait)
+		wait_event_lock_irq(q->rpm_active_wq,
+				    q->rpm_status == RPM_ACTIVE,
+				    *q->queue_lock);
+	return q->rpm_status == RPM_ACTIVE;
+}
+#else
+static bool blk_wait_until_active(struct request_queue *q, bool wait)
+{
+	return true;
+}
+#endif
+
 /**
  * get_request - get a free request
  * @q: request_queue to allocate request from
@@ -1350,6 +1368,16 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	lockdep_assert_held(q->queue_lock);
 	WARN_ON_ONCE(q->mq_ops);
 
+	WARN_ON_ONCE((op & REQ_PM) && blk_pm_suspended(q));
+
+	/*
+	 * Wait if the request queue is suspended or in the process of
+	 * suspending/resuming and the request being allocated will not be
+	 * used for power management purposes.
+	 */
+	if (!(op & REQ_PM) && !blk_wait_until_active(q, !(op & REQ_NOWAIT)))
+		return ERR_PTR(-EAGAIN);
+
 	rl = blk_get_rl(q, bio);	/* transferred to @rq on success */
 retry:
 	rq = __get_request(rl, op, bio, gfp_mask);
@@ -2458,28 +2486,6 @@ void blk_account_io_done(struct request *req)
 	}
 }
 
-#ifdef CONFIG_PM
-/*
- * Don't process normal requests when queue is suspended
- * or in the process of suspending/resuming
- */
-static struct request *blk_pm_peek_request(struct request_queue *q,
-					   struct request *rq)
-{
-	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
-	    (q->rpm_status != RPM_ACTIVE && !(rq->cmd_flags & REQ_PM))))
-		return NULL;
-	else
-		return rq;
-}
-#else
-static inline struct request *blk_pm_peek_request(struct request_queue *q,
-						  struct request *rq)
-{
-	return rq;
-}
-#endif
-
 void blk_account_io_start(struct request *rq, bool new_io)
 {
 	struct hd_struct *part;
@@ -2538,11 +2544,6 @@ struct request *blk_peek_request(struct request_queue *q)
 	WARN_ON_ONCE(q->mq_ops);
 
 	while ((rq = __elv_next_request(q)) != NULL) {
-
-		rq = blk_pm_peek_request(q, rq);
-		if (!rq)
-			break;
-
 		if (!(rq->rq_flags & RQF_STARTED)) {
 			/*
 			 * This is the first time the device driver
@@ -3443,6 +3444,7 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
+	init_waitqueue_head(&q->rpm_active_wq);
 	pm_runtime_set_autosuspend_delay(q->dev, -1);
 	pm_runtime_use_autosuspend(q->dev);
 }
@@ -3512,6 +3514,7 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 	} else {
 		q->rpm_status = RPM_ACTIVE;
 		pm_runtime_mark_last_busy(q->dev);
+		wake_up_all(&q->rpm_active_wq);
 	}
 	spin_unlock_irq(q->queue_lock);
 }
@@ -3561,8 +3564,8 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 	spin_lock_irq(q->queue_lock);
 	if (!err) {
 		q->rpm_status = RPM_ACTIVE;
-		__blk_run_queue(q);
 		pm_runtime_mark_last_busy(q->dev);
+		wake_up_all(&q->rpm_active_wq);
 		pm_request_autosuspend(q->dev);
 	} else {
 		q->rpm_status = RPM_SUSPENDED;
@@ -3590,6 +3593,7 @@ void blk_set_runtime_active(struct request_queue *q)
 	spin_lock_irq(q->queue_lock);
 	q->rpm_status = RPM_ACTIVE;
 	pm_runtime_mark_last_busy(q->dev);
+	wake_up_all(&q->rpm_active_wq);
 	pm_request_autosuspend(q->dev);
 	spin_unlock_irq(q->queue_lock);
 }
diff --git a/block/blk.h b/block/blk.h
index fcb9775b997d..f535ece723ab 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -361,4 +361,16 @@ static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
 }
 #endif /* CONFIG_BOUNCE */
 
+#ifdef CONFIG_PM
+static inline bool blk_pm_suspended(struct request_queue *q)
+{
+	return q->rpm_status == RPM_SUSPENDED;
+}
+#else
+static inline bool blk_pm_suspended(struct request_queue *q)
+{
+	return false;
+}
+#endif
+
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 7f9a0743fc09..08a709c0971b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -493,6 +493,7 @@ struct request_queue {
 #ifdef CONFIG_PM
 	struct device		*dev;
 	int			rpm_status;
+	struct wait_queue_head	rpm_active_wq;
 	unsigned int		nr_pending;
 #endif
 
-- 
2.14.1
