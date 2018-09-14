Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V3 00/17] SCSI: introduce per-host admin queue & enable
 runtime PM
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20180913121546.5710-1-ming.lei@redhat.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f9ba3c11-21ac-d963-3f24-cb83744014e1@oracle.com>
Date: Fri, 14 Sep 2018 15:27:44 +0800
MIME-Version: 1.0
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 09/13/2018 08:15 PM, Ming Lei wrote:
> This patchset introduces per-host admin request queue for submitting
> admin request only, and uses this approach to implement both SCSI
> quiesce and runtime PM in one very simply way. Also runtime PM deadlock
> can be avoided in case that request pool is used up, such as when too
> many IO requests are allocated before resuming device

To be honest, after look in to the SCSI part of this patchset, I really
suspect whether it is worth to introduce this per scsi-host adminq.
Too much complexity is introduced into SCSI. Compared with this, the current
preempt-only feature look much simpler.

If you just don't like the preempt-only checking in the hot path, we may introduce
a new interface similar with blk_queue_enter for the non hot path.

With your patch percpu-refcount: relax limit on percpu_ref_reinit()

(totally no test)
diff --git a/block/blk-core.c b/block/blk-core.c
index 4dbc93f..dd7f007 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -427,14 +427,24 @@ EXPORT_SYMBOL(blk_sync_queue);
  * Returns the previous value of the PREEMPT_ONLY flag - 0 if the flag was not
  * set and 1 if the flag was already set.
  */
-int blk_set_preempt_only(struct request_queue *q)
+int blk_set_preempt_only(struct request_queue *q, bool drain)
 {
-    return blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
+    if (blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q))
+        return 1;
+    percpu_ref_kill(&q->q_usage_counter);
+    synchronize_sched();
+
+    if (drain)
+        wait_event(q->mq_freeze_wq,
+                percpu_ref_is_zero(&q->q_usage_counter));
+
+    return 0;
 }
 EXPORT_SYMBOL_GPL(blk_set_preempt_only);
 
 void blk_clear_preempt_only(struct request_queue *q)
 {
+    percpu_ref_reinit(&q->q_usage_counter);
     blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
     wake_up_all(&q->mq_freeze_wq);
 }
@@ -913,31 +923,13 @@ EXPORT_SYMBOL(blk_alloc_queue);
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
- * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PREEMPT
+ * @flags: BLK_MQ_REQ_NOWAIT
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-    const bool preempt = flags & BLK_MQ_REQ_PREEMPT;
-
     while (true) {
-        bool success = false;
-
-        rcu_read_lock();
-        if (percpu_ref_tryget_live(&q->q_usage_counter)) {
-            /*
-             * The code that sets the PREEMPT_ONLY flag is
-             * responsible for ensuring that that flag is globally
-             * visible before the queue is unfrozen.
-             */
-            if (preempt || !blk_queue_preempt_only(q)) {
-                success = true;
-            } else {
-                percpu_ref_put(&q->q_usage_counter);
-            }
-        }
-        rcu_read_unlock();
 
-        if (success)
+        if (percpu_ref_tryget_live(&q->q_usage_counter))
             return 0;
 
         if (flags & BLK_MQ_REQ_NOWAIT)
@@ -954,7 +946,44 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 
         wait_event(q->mq_freeze_wq,
                (atomic_read(&q->mq_freeze_depth) == 0 &&
-                (preempt || !blk_queue_preempt_only(q))) ||
+               !blk_queue_preempt_only(q)) ||
+               blk_queue_dying(q));
+        if (blk_queue_dying(q))
+            return -ENODEV;
+    }
+}
+
+/*
+ * When set PREEMPT_ONLY mode, q->q_usage_counter is killed.
+ * If only PREEMPT_ONLY mode, go on.
+ * If queue frozen, wait.
+ */
+int blk_queue_preempt_enter(struct request_queue *q,
+    blk_mq_req_flags_t flags)
+{
+    while (true) {
+
+        if (percpu_ref_tryget_live(&q->q_usage_counter))
+            return 0;
+
+        smp_rmb();
+
+        /*
+         * If queue is only in PREEMPT_ONLY mode, get the ref
+         * directly. The one who set PREEMPT_ONLY mode is responsible
+         * to wake up the waiters on mq_freeze_wq.
+         */
+        if (!atomic_read(&q->mq_freeze_depth) &&
+                blk_queue_preempt_only(q)) {
+            percpu_ref_get_many(&q->q_usage_counter, 1);
+            return 0;
+        }
+
+        if (flags & BLK_MQ_REQ_NOWAIT)
+            return -EBUSY;
+
+        wait_event(q->mq_freeze_wq,
+               (atomic_read(&q->mq_freeze_depth) == 0 ||
                blk_queue_dying(q));
         if (blk_queue_dying(q))
             return -ENODEV;
@@ -1587,7 +1616,7 @@ static struct request *blk_old_get_request(struct request_queue *q,
     /* create ioc upfront */
     create_io_context(gfp_mask, q->node);
 
-    ret = blk_queue_enter(q, flags);
+    ret = blk_queue_preempt_enter(q, flags);
     if (ret)
         return ERR_PTR(ret);
     spin_lock_irq(q->queue_lock);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a..3aea78f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -403,7 +403,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
     struct request *rq;
     int ret;
 
-    ret = blk_queue_enter(q, flags);
+    ret = blk_queue_preempt_enter(q, flags);
     if (ret)
         return ERR_PTR(ret);
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index eb97d2d..c338c3a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3046,17 +3046,7 @@ scsi_device_quiesce(struct scsi_device *sdev)
      */
     WARN_ON_ONCE(sdev->quiesced_by && sdev->quiesced_by != current);
 
-    blk_set_preempt_only(q);
-
-    blk_mq_freeze_queue(q);
-    /*
-     * Ensure that the effect of blk_set_preempt_only() will be visible
-     * for percpu_ref_tryget() callers that occur after the queue
-     * unfreeze even if the queue was already frozen before this function
-     * was called. See also https://lwn.net/Articles/573497/.
-     */
-    synchronize_rcu();
-    blk_mq_unfreeze_queue(q);
+    blk_set_preempt_only(q, true);
 
     mutex_lock(&sdev->state_mutex);
     err = scsi_device_set_state(sdev, SDEV_QUIESCE);
