Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34555 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbeHDCB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 22:01:57 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 07/10] block, scsi: Rework runtime power management
Date: Fri,  3 Aug 2018 17:03:22 -0700
Message-Id: <20180804000325.3610-8-bart.vanassche@wdc.com>
In-Reply-To: <20180804000325.3610-1-bart.vanassche@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Instead of allowing requests that are not power management requests
to enter the queue in runtime suspended status (RPM_SUSPENDED), make
the blk_get_request() caller block. This change fixes a starvation
issue: it is now guaranteed that power management requests will be
executed no matter how many blk_get_request() callers are waiting.
Instead of maintaining the q->nr_pending counter, rely on
q->q_usage_counter. Call pm_runtime_mark_last_busy() every time a
request finishes instead of only if the queue depth drops to zero.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-core.c       | 37 ++++++++-----------------------------
 block/blk-mq-debugfs.c |  1 -
 block/blk-pm.c         | 29 ++++++++++++++++++++++++-----
 block/blk-pm.h         | 14 ++++++++------
 include/linux/blkdev.h |  1 -
 5 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 59382c758155..1e208e134ca9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2736,30 +2736,6 @@ void blk_account_io_done(struct request *req, u64 now)
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
@@ -2805,11 +2781,14 @@ static struct request *elv_next_request(struct request_queue *q)
 
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
index a5ea86835fcb..7d74d53dc098 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -332,7 +332,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(ELVPRIV),
 	RQF_NAME(IO_STAT),
 	RQF_NAME(ALLOCED),
-	RQF_NAME(PM),
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 2a4632d0be4b..0708185ead61 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -107,17 +107,31 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!q->dev)
 		return ret;
 
+	WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
+
 	blk_pm_runtime_lock(q);
+	/*
+	 * Switch to preempt-only mode before calling synchronize_rcu() such
+	 * that later blk_queue_enter() calls see the preempt-only state. See
+	 * also http://lwn.net/Articles/573497/.
+	 */
+	blk_set_pm_only(q);
+	ret = -EBUSY;
+	if (percpu_ref_read(&q->q_usage_counter) == 1) {
+		synchronize_rcu();
+		if (percpu_ref_read(&q->q_usage_counter) == 1)
+			ret = 0;
+	}
 
 	spin_lock_irq(q->queue_lock);
-	if (q->nr_pending) {
-		ret = -EBUSY;
+	if (ret < 0)
 		pm_runtime_mark_last_busy(q->dev);
-	} else {
+	else
 		q->rpm_status = RPM_SUSPENDING;
-	}
 	spin_unlock_irq(q->queue_lock);
 
+	if (ret)
+		blk_clear_pm_only(q);
 	blk_pm_runtime_unlock(q);
 
 	return ret;
@@ -150,6 +164,9 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 		pm_runtime_mark_last_busy(q->dev);
 	}
 	spin_unlock_irq(q->queue_lock);
+
+	if (err)
+		blk_clear_pm_only(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_suspend);
 
@@ -197,13 +214,15 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
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
+		blk_clear_pm_only(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
 
diff --git a/block/blk-pm.h b/block/blk-pm.h
index 1ffc8ef203ec..8d250e545e42 100644
--- a/block/blk-pm.h
+++ b/block/blk-pm.h
@@ -8,21 +8,23 @@
 #ifdef CONFIG_PM
 static inline void blk_pm_requeue_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
-		rq->q->nr_pending--;
 }
 
 static inline void blk_pm_add_request(struct request_queue *q,
 				      struct request *rq)
 {
-	if (q->dev && !(rq->rq_flags & RQF_PM) && q->nr_pending++ == 0 &&
-	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
-		pm_request_resume(q->dev);
+	if (!q->dev || (rq->rq_flags & RQF_PREEMPT))
+		return;
+	/*
+	 * If the below warning is triggered then that means that the caller
+	 * did not use pm_runtime_get*().
+	 */
+	WARN_ON_ONCE(atomic_read(&q->dev->power.usage_count) == 0);
 }
 
 static inline void blk_pm_put_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM) && !--rq->q->nr_pending)
+	if (rq->q->dev && !(rq->rq_flags & RQF_PREEMPT))
 		pm_runtime_mark_last_busy(rq->q->dev);
 }
 #else
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 72d569218231..9f859f32757c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -547,7 +547,6 @@ struct request_queue {
 #ifdef CONFIG_PM
 	struct device		*dev;
 	int			rpm_status;
-	unsigned int		nr_pending;
 	wait_queue_head_t	rpm_wq;
 	/* rpm_lock protects rpm_owner and rpm_nesting_level */
 	spinlock_t		rpm_lock;
-- 
2.18.0
