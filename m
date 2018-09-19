Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v9 7/8] block: Make blk_get_request() block for non-PM requests while suspended
Date: Wed, 19 Sep 2018 15:45:29 -0700
Message-Id: <20180919224530.222469-8-bvanassche@acm.org>
In-Reply-To: <20180919224530.222469-1-bvanassche@acm.org>
References: <20180919224530.222469-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Instead of allowing requests that are not power management requests
to enter the queue in runtime suspended status (RPM_SUSPENDED), make
the blk_get_request() caller block. This change fixes a starvation
issue: it is now guaranteed that power management requests will be
executed no matter how many blk_get_request() callers are waiting.
For blk-mq, instead of maintaining the q->nr_pending counter, rely
on q->q_usage_counter. Call pm_runtime_mark_last_busy() every time a
request finishes instead of only if the queue depth drops to zero.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c | 37 +++++-----------------
 block/blk-pm.c   | 81 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 34 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 18b874d5c9c9..ae092ca121d5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2747,30 +2747,6 @@ void blk_account_io_done(struct request *req, u64 now)
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
@@ -2816,11 +2792,14 @@ static struct request *elv_next_request(struct request_queue *q)
 
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
index 9b636960d285..3ad5a7334baa 100644
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
@@ -40,6 +43,34 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 }
 EXPORT_SYMBOL(blk_pm_runtime_init);
 
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
+ * queues.
+ */
+static int blk_requests_in_flight(struct request_queue *q)
+{
+	struct in_flight_data in_flight = { .q = q };
+
+	if (q->mq_ops)
+		blk_mq_queue_rq_iter(q, blk_count_in_flight, &in_flight);
+	return q->nr_pending + in_flight.in_flight;
+}
+
 /**
  * blk_pre_runtime_suspend - Pre runtime suspend check
  * @q: the queue of the device
@@ -68,14 +99,49 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!q->dev)
 		return ret;
 
+	WARN_ON_ONCE(q->rpm_status != RPM_ACTIVE);
+
+	/*
+	 * Increase the pm_only counter before checking whether any
+	 * non-PM blk_queue_enter() calls are in progress to avoid that any
+	 * new non-PM blk_queue_enter() calls succeed before the pm_only
+	 * counter is decreased again.
+	 */
+	blk_set_pm_only(q);
+	/*
+	 * This function only gets called if the most recent request activity
+	 * occurred at least autosuspend_delay_ms ago. Since blk_queue_enter()
+	 * is called by the request allocation code before
+	 * pm_request_resume(), if no requests have a tag assigned it is safe
+	 * to suspend the device.
+	 */
+	ret = -EBUSY;
+	if (blk_requests_in_flight(q) == 0) {
+		blk_freeze_queue_start(q);
+		/*
+		 * Freezing a queue starts a transition of the queue
+		 * usage counter to atomic mode. Wait until atomic
+		 * mode has been reached. This involves calling
+		 * call_rcu(). That call guarantees that later
+		 * blk_queue_enter() calls see the pm-only state. See
+		 * also http://lwn.net/Articles/573497/.
+		 */
+		percpu_ref_switch_to_atomic_sync(&q->q_usage_counter);
+		if (percpu_ref_is_zero(&q->q_usage_counter))
+			ret = 0;
+		blk_mq_unfreeze_queue(q);
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
@@ -106,6 +172,9 @@ void blk_post_runtime_suspend(struct request_queue *q, int err)
 		pm_runtime_mark_last_busy(q->dev);
 	}
 	spin_unlock_irq(q->queue_lock);
+
+	if (err)
+		blk_clear_pm_only(q);
 }
 EXPORT_SYMBOL(blk_post_runtime_suspend);
 
@@ -153,13 +222,15 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
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
2.19.0.397.gdd90340f6a-goog
