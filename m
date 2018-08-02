Return-Path: <prvs=7457c2e9b=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v3 3/9] block: Serialize queue freezing and blk_pre_runtime_suspend()
Date: Thu,  2 Aug 2018 11:29:38 -0700
Message-Id: <20180802182944.14442-4-bart.vanassche@wdc.com>
In-Reply-To: <20180802182944.14442-1-bart.vanassche@wdc.com>
References: <20180802182944.14442-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Serialize these operations because a later patch will add code into
blk_pre_runtime_suspend() that should not run concurrently with queue
freezing nor unfreezing.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c       |  5 +++++
 block/blk-mq.c         |  3 +++
 block/blk-pm.c         | 44 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-pm.h |  6 ++++++
 include/linux/blkdev.h |  5 +++++
 5 files changed, 63 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 236071a487a2..7ca76cf26870 100644
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
@@ -695,6 +696,7 @@ void blk_set_queue_dying(struct request_queue *q)
 	 * prevent I/O from crossing blk_queue_enter().
 	 */
 	blk_freeze_queue_start(q);
+	blk_pm_runtime_unlock(q);
 
 	if (q->mq_ops)
 		blk_mq_wake_waiters(q);
@@ -755,6 +757,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * prevent that q->request_fn() gets invoked after draining finished.
 	 */
 	blk_freeze_queue(q);
+	blk_pm_runtime_unlock(q);
 	spin_lock_irq(lock);
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
@@ -1044,6 +1047,8 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
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
index 08d7222d4757..524e19b67380 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -3,6 +3,45 @@
 #include <linux/blk-pm.h>
 #include <linux/blkdev.h>
 #include <linux/pm_runtime.h>
+#include <linux/spinlock.h>
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
+	might_sleep();
+
+	spin_lock(&q->rpm_lock);
+	wait_event_exclusive_cmd(q->rpm_wq,
+			q->rpm_owner == NULL || q->rpm_owner == current,
+			spin_unlock(&q->rpm_lock), spin_lock(&q->rpm_lock));
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
@@ -66,6 +105,8 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!q->dev)
 		return ret;
 
+	blk_pm_runtime_lock(q);
+
 	spin_lock_irq(q->queue_lock);
 	if (q->nr_pending) {
 		ret = -EBUSY;
@@ -74,6 +115,9 @@ int blk_pre_runtime_suspend(struct request_queue *q)
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
index b80c65aba249..aafcc7877e53 100644
--- a/include/linux/blk-pm.h
+++ b/include/linux/blk-pm.h
@@ -10,6 +10,9 @@ struct request_queue;
  * block layer runtime pm functions
  */
 #ifdef CONFIG_PM
+extern void blk_pm_init(struct request_queue *q);
+extern void blk_pm_runtime_lock(struct request_queue *q);
+extern void blk_pm_runtime_unlock(struct request_queue *q);
 extern void blk_pm_runtime_init(struct request_queue *q, struct device *dev);
 extern int blk_pre_runtime_suspend(struct request_queue *q);
 extern void blk_post_runtime_suspend(struct request_queue *q, int err);
@@ -17,6 +20,9 @@ extern void blk_pre_runtime_resume(struct request_queue *q);
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
index dc24e9e2bea1..74a2f9f5718b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -544,6 +544,11 @@ struct request_queue {
 	struct device		*dev;
 	int			rpm_status;
 	unsigned int		nr_pending;
+	wait_queue_head_t	rpm_wq;
+	/* rpm_lock protects rpm_owner and rpm_nesting_level */
+	spinlock_t		rpm_lock;
+	struct task_struct	*rpm_owner;
+	int			rpm_nesting_level;
 #endif
 
 	/*
-- 
2.18.0
