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
Subject: [PATCH 5/5] blk-mq: Implement power management support
Date: Fri,  8 Sep 2017 16:52:26 -0700
Message-Id: <20170908235226.26622-6-bart.vanassche@wdc.com>
In-Reply-To: <20170908235226.26622-1-bart.vanassche@wdc.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Implement the following approach for blk-mq:
- Either make blk_get_request() wait or make it fail when a
  request queue is not in status RPM_ACTIVE.
- While suspending, suspended or resuming, only process power
  management requests (REQ_PM).

Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
References: "I/O hangs after resuming from suspend-to-ram" (https://marc.info/?l=linux-block&m=150340235201348).
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 20 ++++++++++++++++----
 block/blk-mq.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cd2700c763ed..49a4cd5b255e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3438,10 +3438,6 @@ EXPORT_SYMBOL(blk_finish_plug);
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
-	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
-	if (q->mq_ops)
-		return;
-
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;
 	init_waitqueue_head(&q->rpm_active_wq);
@@ -3478,6 +3474,19 @@ int blk_pre_runtime_suspend(struct request_queue *q)
 	if (!q->dev)
 		return ret;
 
+	if (q->mq_ops) {
+		percpu_ref_switch_to_atomic_nowait(&q->q_usage_counter);
+		if (!percpu_ref_is_zero(&q->q_usage_counter)) {
+			ret = -EBUSY;
+			pm_runtime_mark_last_busy(q->dev);
+		} else {
+			spin_lock_irq(q->queue_lock);
+			q->rpm_status = RPM_SUSPENDING;
+			spin_unlock_irq(q->queue_lock);
+		}
+		return ret;
+	}
+
 	spin_lock_irq(q->queue_lock);
 	if (q->nr_pending) {
 		ret = -EBUSY;
@@ -3561,6 +3570,9 @@ void blk_post_runtime_resume(struct request_queue *q, int err)
 	if (!q->dev)
 		return;
 
+	if (q->mq_ops)
+		percpu_ref_switch_to_percpu(&q->q_usage_counter);
+
 	spin_lock_irq(q->queue_lock);
 	if (!err) {
 		q->rpm_status = RPM_ACTIVE;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f18cff80050..cbd680dc194a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -383,6 +383,29 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 	return rq;
 }
 
+#ifdef CONFIG_PM
+static bool blk_mq_wait_until_active(struct request_queue *q, bool wait)
+{
+	if (!wait)
+		return false;
+	/*
+	 * Note: the q->rpm_status check below races against the changes of
+	 * that variable by the blk_{pre,post}_runtime_{suspend,resume}()
+	 * functions. The worst possible consequence of these races is that a
+	 * small number of requests gets passed to the block driver associated
+	 * with the request queue after rpm_status has been changed into
+	 * RPM_SUSPENDING and before it is changed into RPM_SUSPENDED.
+	 */
+	wait_event(q->rpm_active_wq, q->rpm_status == RPM_ACTIVE);
+	return true;
+}
+#else
+static bool blk_mq_wait_until_active(struct request_queue *q, bool nowait)
+{
+	return true;
+}
+#endif
+
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 		unsigned int flags)
 {
@@ -390,6 +413,17 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
 	struct request *rq;
 	int ret;
 
+	WARN_ON_ONCE((op & REQ_PM) && blk_pm_suspended(q));
+
+	/*
+	 * Wait if the request queue is suspended or in the process of
+	 * suspending/resuming and the request being allocated will not be
+	 * used for power management purposes.
+	 */
+	if (!(op & REQ_PM) &&
+	    !blk_mq_wait_until_active(q, !(op & REQ_NOWAIT)))
+		return ERR_PTR(-EAGAIN);
+
 	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
 	if (ret)
 		return ERR_PTR(ret);
-- 
2.14.1
