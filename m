Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH RFC V2 2/3] blk-mq: prepare for supporting runtime PM
Date: Fri, 13 Jul 2018 16:06:01 +0800
Message-Id: <20180713080602.31602-3-ming.lei@redhat.com>
In-Reply-To: <20180713080602.31602-1-ming.lei@redhat.com>
References: <20180713080602.31602-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

This patch introduces blk_mq_pm_add_request() which is called after
allocating one request. Also blk_mq_pm_put_request() is introduced
and called after one request is freed.

For blk-mq, it can be quite expensive to accounting in-flight IOs,
so this patch calls pm_runtime_mark_last_busy() simply after each IO
is done, instead of doing that only after the last in-flight IO is done.
This way is still workable, since the active non-PM IO will be checked
in blk_pre_runtime_suspend(), and runtime suspend will be prevented
if there is any active non-PM IO.

Turns out that sync between runtime PM and IO path has to be done
for avoiding race, this patch applies one seqlock for this purpose.
So the cost introduced in fast IO path can be minimized given seqlock
is often used in fast path, such as reading jiffies &tick, or d_walk(),
...

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 121 +++++++++++++++++++++++++++++++++++++++++--------
 block/blk-mq.c         |  71 +++++++++++++++++++++++++++++
 block/blk-mq.h         |  10 ++++
 include/linux/blk-mq.h |   1 +
 include/linux/blkdev.h |   1 +
 5 files changed, 186 insertions(+), 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1087a58590f1..cd73db90d1e3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3775,7 +3775,10 @@ static void __blk_post_runtime_resume(struct request_queue *q, int err)
 {
 	if (!err) {
 		q->rpm_status = RPM_ACTIVE;
-		__blk_run_queue(q);
+		if (!q->mq_ops)
+			__blk_run_queue(q);
+		else
+			blk_mq_run_hw_queues(q, true);
 		pm_runtime_mark_last_busy(q->dev);
 		pm_request_autosuspend(q->dev);
 	} else {
@@ -3790,6 +3793,69 @@ static void __blk_set_runtime_active(struct request_queue *q)
 	pm_request_autosuspend(q->dev);
 }
 
+static bool blk_mq_support_runtime_pm(struct request_queue *q)
+{
+	if (!q->tag_set || !(q->tag_set->flags & BLK_MQ_F_SUPPORT_RPM))
+		return false;
+	return true;
+}
+
+static int blk_mq_pre_runtime_suspend(struct request_queue *q)
+{
+	bool active;
+	int ret = 0;
+
+	if (!blk_mq_support_runtime_pm(q))
+		return ret;
+
+	write_seqlock_irq(&q->rpm_lock);
+	active = blk_mq_pm_queue_idle(q);
+	ret = __blk_pre_runtime_suspend(q, active);
+	write_sequnlock_irq(&q->rpm_lock);
+
+	return ret;
+}
+
+static void blk_mq_post_runtime_suspend(struct request_queue *q, int err)
+{
+	if (!blk_mq_support_runtime_pm(q))
+		return;
+
+	write_seqlock_irq(&q->rpm_lock);
+	__blk_post_runtime_suspend(q, err);
+	write_sequnlock_irq(&q->rpm_lock);
+}
+
+static void blk_mq_pre_runtime_resume(struct request_queue *q)
+{
+	if (!blk_mq_support_runtime_pm(q))
+		return;
+
+	write_seqlock_irq(&q->rpm_lock);
+	q->rpm_status = RPM_RESUMING;
+	write_sequnlock_irq(&q->rpm_lock);
+}
+
+static void blk_mq_post_runtime_resume(struct request_queue *q, int err)
+{
+	if (!blk_mq_support_runtime_pm(q))
+		return;
+
+	write_seqlock_irq(&q->rpm_lock);
+	__blk_post_runtime_resume(q, err);
+	write_sequnlock_irq(&q->rpm_lock);
+}
+
+static void blk_mq_set_runtime_active(struct request_queue *q)
+{
+	if (!blk_mq_support_runtime_pm(q))
+		return;
+
+	write_seqlock_irq(&q->rpm_lock);
+	__blk_set_runtime_active(q);
+	write_sequnlock_irq(&q->rpm_lock);
+}
+
 /**
  * blk_pm_runtime_init - Block layer runtime PM initialization routine
  * @q: the queue of the device
@@ -3813,8 +3879,7 @@ static void __blk_set_runtime_active(struct request_queue *q)
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
-	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
-	if (q->mq_ops)
+	if (q->mq_ops && !blk_mq_support_runtime_pm(q))
 		return;
 
 	q->dev = dev;
@@ -3852,9 +3917,13 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!q->dev)
 		return ret;
 
-	spin_lock_irq(q->queue_lock);
-	ret = __blk_pre_runtime_suspend(q, q->nr_pending);
-	spin_unlock_irq(q->queue_lock);
+	if (q->mq_ops)
+		ret = blk_mq_pre_runtime_suspend(q);
+	else {
+		spin_lock_irq(q->queue_lock);
+		ret = __blk_pre_runtime_suspend(q, q->nr_pending);
+		spin_unlock_irq(q->queue_lock);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(blk_pre_runtime_suspend);
@@ -3877,9 +3946,13 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 	if (!q->dev)
 		return;
 
-	spin_lock_irq(q->queue_lock);
-	__blk_post_runtime_suspend(q, err);
-	spin_unlock_irq(q->queue_lock);
+	if (q->mq_ops)
+		blk_mq_post_runtime_suspend(q, err);
+	else {
+		spin_lock_irq(q->queue_lock);
+		__blk_post_runtime_suspend(q, err);
+		spin_unlock_irq(q->queue_lock);
+	}
 }
 EXPORT_SYMBOL(blk_post_runtime_suspend);
 
@@ -3899,9 +3972,13 @@ void blk_pre_runtime_resume(struct request_queue *q)
 	if (!q->dev)
 		return;
 
-	spin_lock_irq(q->queue_lock);
-	q->rpm_status = RPM_RESUMING;
-	spin_unlock_irq(q->queue_lock);
+	if (q->mq_ops)
+		blk_mq_pre_runtime_resume(q);
+	else {
+		spin_lock_irq(q->queue_lock);
+		q->rpm_status = RPM_RESUMING;
+		spin_unlock_irq(q->queue_lock);
+	}
 }
 EXPORT_SYMBOL(blk_pre_runtime_resume);
 
@@ -3924,9 +4001,13 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 	if (!q->dev)
 		return;
 
-	spin_lock_irq(q->queue_lock);
-	__blk_post_runtime_resume(q, err);
-	spin_unlock_irq(q->queue_lock);
+	if (q->mq_ops)
+		blk_mq_post_runtime_resume(q, err);
+	else {
+		spin_lock_irq(q->queue_lock);
+		__blk_post_runtime_resume(q, err);
+		spin_unlock_irq(q->queue_lock);
+	}
 }
 EXPORT_SYMBOL(blk_post_runtime_resume);
 
@@ -3946,9 +4027,13 @@ EXPORT_SYMBOL(blk_post_runtime_resume);
  */
 void blk_set_runtime_active(struct request_queue *q)
 {
-	spin_lock_irq(q->queue_lock);
-	__blk_set_runtime_active(q);
-	spin_unlock_irq(q->queue_lock);
+	if (q->mq_ops)
+		blk_mq_set_runtime_active(q);
+	else {
+		spin_lock_irq(q->queue_lock);
+		__blk_set_runtime_active(q);
+		spin_unlock_irq(q->queue_lock);
+	}
 }
 EXPORT_SYMBOL(blk_set_runtime_active);
 #endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 73a43b81b17d..8eb6ea1a7410 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -25,6 +25,8 @@
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
 #include <linux/prefetch.h>
+#include <linux/pm_runtime.h>
+#include <linux/seqlock.h>
 
 #include <trace/events/block.h>
 
@@ -58,6 +60,66 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
 	return bucket;
 }
 
+#ifdef CONFIG_PM
+static void blk_mq_pm_check_idle(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	unsigned long *cnt = priv;
+
+	if (!(rq->rq_flags & RQF_PM))
+		(*cnt)++;
+}
+
+bool blk_mq_pm_queue_idle(struct request_queue *q)
+{
+	unsigned long idle_cnt;
+
+	if (!q->tag_set || !(q->tag_set->flags & BLK_MQ_F_SUPPORT_RPM))
+		return false;
+
+	idle_cnt = 0;
+	blk_mq_queue_tag_busy_iter(q, blk_mq_pm_check_idle, &idle_cnt);
+
+	return idle_cnt == 0;
+}
+
+static void blk_mq_pm_init(struct request_queue *q)
+{
+	seqlock_init(&q->rpm_lock);
+}
+
+static void blk_mq_pm_add_request(struct request_queue *q, struct request *rq)
+{
+	unsigned int seq;
+	bool need_resume;
+
+	do {
+		seq = read_seqbegin(&q->rpm_lock);
+		need_resume = q->dev && !(rq->rq_flags & RQF_PM) &&
+			(q->rpm_status == RPM_SUSPENDED ||
+			 q->rpm_status == RPM_SUSPENDING);
+	} while (read_seqretry(&q->rpm_lock, seq));
+
+	if (need_resume)
+		pm_runtime_resume(q->dev);
+}
+
+static void blk_mq_pm_put_request(struct request_queue *q, struct request *rq)
+{
+	if (q->dev && !(rq->rq_flags & RQF_PM))
+		pm_runtime_mark_last_busy(q->dev);
+}
+#else
+static void blk_mq_pm_init(struct request_queue *q)
+{}
+
+static void blk_mq_pm_add_request(struct request_queue *q, struct request *rq)
+{}
+
+static void blk_mq_pm_put_request(struct request_queue *q, struct request *rq)
+{}
+#endif
+
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
@@ -391,6 +453,10 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		}
 	}
 	data->hctx->queued++;
+
+	if (data->hctx->flags & BLK_MQ_F_SUPPORT_RPM)
+		blk_mq_pm_add_request(q, rq);
+
 	return rq;
 }
 
@@ -509,6 +575,9 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
+	if (hctx->flags & BLK_MQ_F_SUPPORT_RPM)
+		blk_mq_pm_put_request(q, rq);
+
 	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
@@ -2619,6 +2688,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 			return ERR_PTR(ret);
 	}
 
+	blk_mq_pm_init(q);
+
 	return q;
 
 err_hctxs:
diff --git a/block/blk-mq.h b/block/blk-mq.h
index bc2b24735ed4..886e09b07628 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -88,6 +88,16 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
+/* blk-mq pm helpers */
+#ifdef CONFIG_PM
+extern bool blk_mq_pm_queue_idle(struct request_queue *q);
+#else
+static inline bool blk_mq_pm_queue_idle(struct request_queue *q)
+{
+	return false;
+}
+#endif
+
 /**
  * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
  * @rq: target request.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index d710e92874cc..f88639478d30 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -180,6 +180,7 @@ enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
+	BLK_MQ_F_SUPPORT_RPM	= 1 << 3,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
 	BLK_MQ_F_NO_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 137759862f07..16113921519d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -542,6 +542,7 @@ struct request_queue {
 
 #ifdef CONFIG_PM
 	struct device		*dev;
+	seqlock_t		rpm_lock;
 	int			rpm_status;
 	unsigned int		nr_pending;
 #endif
-- 
2.9.5
