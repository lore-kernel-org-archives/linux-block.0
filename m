Return-Path: <prvs=737f04b27=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 3/5] block: Serialize queue freezing and blk_pre_runtime_suspend()
Date: Wed, 25 Jul 2018 15:26:05 -0700
Message-Id: <20180725222607.8854-4-bart.vanassche@wdc.com>
In-Reply-To: <20180725222607.8854-1-bart.vanassche@wdc.com>
References: <20180725222607.8854-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Serialize these operations because the next patch will add code into
blk_pre_runtime_suspend() that should not run concurrently with queue
freezing nor unfreezing.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c       |  5 +++++
 block/blk-mq.c         |  3 +++
 block/blk-pm.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-pm.h |  9 +++++++++
 include/linux/blkdev.h |  4 ++++
 5 files changed, 61 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 14c28197ea42..feac2b4d3b90 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -17,6 +17,7 @@
 #include <linux/bio.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-pm.h>
 #include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
@@ -694,6 +695,7 @@ void blk_set_queue_dying(struct request_queue *q)
 	 * prevent I/O from crossing blk_queue_enter().
 	 */
 	blk_freeze_queue_start(q);
+	blk_pm_runtime_unlock(q);
 
 	if (q->mq_ops)
 		blk_mq_wake_waiters(q);
@@ -754,6 +756,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * prevent that q->request_fn() gets invoked after draining finished.
 	 */
 	blk_freeze_queue(q);
+	blk_pm_runtime_unlock(q);
 	spin_lock_irq(lock);
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
@@ -1043,6 +1046,8 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	mutex_init(&q->blk_trace_mutex);
 #endif
+	blk_pm_init(q);
+
 	mutex_init(&q->sysfs_lock);
 	spin_lock_init(&q->__queue_lock);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c92ce06fd565..8d845872ea02 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -9,6 +9,7 @@
 #include <linux/backing-dev.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
+#include <linux/blk-pm.h>
 #include <linux/kmemleak.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -138,6 +139,7 @@ void blk_freeze_queue_start(struct request_queue *q)
 {
 	int freeze_depth;
 
+	blk_pm_runtime_lock(q);
 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
 	if (freeze_depth == 1) {
 		percpu_ref_kill(&q->q_usage_counter);
@@ -201,6 +203,7 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 		percpu_ref_reinit(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
+	blk_pm_runtime_unlock(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
diff --git a/block/blk-pm.c b/block/blk-pm.c
index 08d7222d4757..7dc9375a2f46 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -3,6 +3,41 @@
 #include <linux/blk-pm.h>
 #include <linux/blkdev.h>
 #include <linux/pm_runtime.h>
+#include <linux/wait.h>
+
+/*
+ * Initialize the request queue members used by blk_pm_runtime_lock() and
+ * blk_pm_runtime_unlock().
+ */
+void blk_pm_init(struct request_queue *q)
+{
+	spin_lock_init(&q->rpm_lock);
+	init_waitqueue_head(&q->rpm_wq);
+	q->rpm_owner = NULL;
+	q->rpm_nesting_level = 0;
+}
+
+void blk_pm_runtime_lock(struct request_queue *q)
+{
+	spin_lock(&q->rpm_lock);
+	wait_event_interruptible_locked(q->rpm_wq,
+			  q->rpm_owner == NULL || q->rpm_owner == current);
+	if (q->rpm_owner == NULL)
+		q->rpm_owner = current;
+	q->rpm_nesting_level++;
+	spin_unlock(&q->rpm_lock);
+}
+
+void blk_pm_runtime_unlock(struct request_queue *q)
+{
+	spin_lock(&q->rpm_lock);
+	WARN_ON_ONCE(q->rpm_nesting_level <= 0);
+	if (--q->rpm_nesting_level == 0) {
+		q->rpm_owner = NULL;
+		wake_up(&q->rpm_wq);
+	}
+	spin_unlock(&q->rpm_lock);
+}
 
 /**
  * blk_pm_runtime_init - Block layer runtime PM initialization routine
@@ -66,6 +101,8 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!q->dev)
 		return ret;
 
+	blk_pm_runtime_lock(q);
+
 	spin_lock_irq(q->queue_lock);
 	if (q->nr_pending) {
 		ret = -EBUSY;
@@ -74,6 +111,9 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 		q->rpm_status = RPM_SUSPENDING;
 	}
 	spin_unlock_irq(q->queue_lock);
+
+	blk_pm_runtime_unlock(q);
+
 	return ret;
 }
 EXPORT_SYMBOL(blk_pre_runtime_suspend);
diff --git a/include/linux/blk-pm.h b/include/linux/blk-pm.h
index fe3f4e8efbe9..aafcc7877e53 100644
--- a/include/linux/blk-pm.h
+++ b/include/linux/blk-pm.h
@@ -3,10 +3,16 @@
 #ifndef _BLK_PM_H_
 #define _BLK_PM_H_
 
+struct device;
+struct request_queue;
+
 /*
  * block layer runtime pm functions
  */
 #ifdef CONFIG_PM
+extern void blk_pm_init(struct request_queue *q);
+extern void blk_pm_runtime_lock(struct request_queue *q);
+extern void blk_pm_runtime_unlock(struct request_queue *q);
 extern void blk_pm_runtime_init(struct request_queue *q, struct device *dev);
 extern int blk_pre_runtime_suspend(struct request_queue *q);
 extern void blk_post_runtime_suspend(struct request_queue *q, int err);
@@ -14,6 +20,9 @@ extern void blk_pre_runtime_resume(struct request_queue *q);
 extern void blk_post_runtime_resume(struct request_queue *q, int err);
 extern void blk_set_runtime_active(struct request_queue *q);
 #else
+static inline void blk_pm_init(struct request_queue *q) {}
+static inline void blk_pm_runtime_lock(struct request_queue *q) {}
+static inline void blk_pm_runtime_unlock(struct request_queue *q) {}
 static inline void blk_pm_runtime_init(struct request_queue *q,
 				       struct device *dev) {}
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a0cf2e352a31..3a8c20eafe58 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -544,6 +544,10 @@ struct request_queue {
 	struct device		*dev;
 	int			rpm_status;
 	unsigned int		nr_pending;
+	spinlock_t		rpm_lock;
+	wait_queue_head_t	rpm_wq;
+	struct task_struct	*rpm_owner;
+	int			rpm_nesting_level;
 #endif
 
 	/*
-- 
2.18.0
