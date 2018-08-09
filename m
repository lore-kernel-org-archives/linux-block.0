Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 11/12] block: Change the runtime power management approach (2/2)
Date: Thu,  9 Aug 2018 12:41:48 -0700
Message-Id: <20180809194149.15285-12-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Instead of allowing requests that are not power management requests
to enter the queue in runtime suspended status (RPM_SUSPENDED), make
the blk_get_request() caller block. This change fixes a starvation
issue: it is now guaranteed that power management requests will be
executed no matter how many blk_get_request() callers are waiting.
Instead of maintaining the q->nr_pending counter, rely on
q->q_usage_counter. Call pm_runtime_mark_last_busy() every time a
request finishes instead of only if the queue depth drops to zero.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c | 37 ++++++-------------------
 block/blk-pm.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 75 insertions(+), 34 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f30545fb2de2..b0bb6b5320fe 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2772,30 +2772,6 @@ void blk_account_io_done(struct request *req, u64 now)
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
@@ -2841,11 +2817,14 @@ static struct request *elv_next_request(struct request_queue *q)
 
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
diff --git a/block/blk-pm.c b/block/blk-pm.c
index bf8532da952d..977beffdccd2 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -1,8 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/blk-mq.h>
 #include <linux/blk-pm.h>
 #include <linux/blkdev.h>
 #include <linux/pm_runtime.h>
+#include "blk-mq.h"
+#include "blk-mq-tag.h"
 
 /**
  * blk_pm_runtime_init - Block layer runtime PM initialization routine
@@ -58,6 +61,36 @@ void blk_pm_runtime_exit(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_pm_runtime_exit);
 
+struct in_flight_data {
+	struct request_queue	*q;
+	int			in_flight;
+};
+
+static void blk_count_in_flight(struct blk_mq_hw_ctx *hctx, struct request *rq,
+				void *priv, bool reserved)
+{
+	struct in_flight_data *in_flight = priv;
+
+	if (rq->q == in_flight->q)
+		in_flight->in_flight++;
+}
+
+/*
+ * Count the number of requests that are in flight for request queue @q. Use
+ * @q->nr_pending for legacy queues. Iterate over the tag set for blk-mq
+ * queues.  Use blk_mq_queue_tag_busy_iter() instead of
+ * blk_mq_tagset_busy_iter() because the latter only considers requests that
+ * have already been started.
+ */
+static int blk_requests_in_flight(struct request_queue *q)
+{
+	struct in_flight_data in_flight = { .q = q };
+
+	if (q->mq_ops)
+		blk_mq_queue_tag_busy_iter(q, blk_count_in_flight, &in_flight);
+	return q->nr_pending + in_flight.in_flight;
+}
+
 /**
  * blk_pre_runtime_suspend - Pre runtime suspend check
  * @q: the queue of the device
@@ -86,14 +119,38 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!q->dev)
 		return ret;
 
+	WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
+
+	blk_set_pm_only(q);
+	/*
+	 * This function only gets called if the most recent
+	 * pm_request_resume() call occurred at least autosuspend_delay_ms
+	 * ago. Since blk_queue_enter() is called by the request allocation
+	 * code before pm_request_resume(), if no requests have a tag assigned
+	 * it is safe to suspend the device.
+	 */
+	ret = -EBUSY;
+	if (blk_requests_in_flight(q) == 0) {
+		/*
+		 * Call synchronize_rcu() such that later blk_queue_enter()
+		 * calls see the preempt-only state. See also
+		 * http://lwn.net/Articles/573497/.
+		 */
+		synchronize_rcu();
+		if (blk_requests_in_flight(q) == 0)
+			ret = 0;
+	}
+
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
+
+	if (ret)
+		blk_clear_pm_only(q);
+
 	return ret;
 }
 EXPORT_SYMBOL(blk_pre_runtime_suspend);
@@ -124,6 +181,9 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 		pm_runtime_mark_last_busy(q->dev);
 	}
 	spin_unlock_irq(q->queue_lock);
+
+	if (err)
+		blk_clear_pm_only(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_suspend);
 
@@ -171,13 +231,15 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
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
 
-- 
2.18.0
