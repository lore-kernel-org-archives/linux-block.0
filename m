Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, tj@kernel.org, kent.overstreet@gmail.com,
        ming.lei@redhat.com, bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] blk-core: rework the queue freeze
Date: Thu, 20 Sep 2018 18:18:22 +0800
Message-Id: <1537438703-25217-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

The previous queue freeze depends on the percpu_ref_kill/reinit.
But the limit is that we have to drain the q_usage_counter when
unfreeze the queue.

To improve this, we implement our own condition checking, namely
queue_gate, instead of depending on the __PERCPU_REF_DEAD. Then
put both the checking on queue_gate and __percpu_ref_get_many
under sched rcu lock. At the same time, switch the percpu ref mode
between atomic and percpu with percpu_ref_switch_to_atomic/percpu.

After this, introduce the BLK_QUEUE_GATE_FROZEN on queue_gate to
implement queue freeze feature. Then we could unfreeze the queue
anytime without drain the queue.

In addition, this fashion will be convinient to implement other
condition checking, such as preempt-only mode.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c        | 28 +++++++++++++++++-----------
 block/blk-mq.c          |  8 ++++++--
 block/blk.h             |  4 ++++
 drivers/scsi/scsi_lib.c |  2 +-
 include/linux/blkdev.h  |  2 ++
 5 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dee56c2..f8b8fe2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -910,6 +910,18 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+static inline bool blk_queue_gate_allow(struct request_queue *q,
+		blk_mq_req_flags_t flags)
+{
+	if (likely(!q->queue_gate))
+		return true;
+
+	if (test_bit(BLK_QUEUE_GATE_FROZEN, &q->queue_gate))
+		return false;
+
+	return true;
+}
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -922,8 +934,9 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	while (true) {
 		bool success = false;
 
-		rcu_read_lock();
-		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
+		rcu_read_lock_sched();
+		if (blk_queue_gate_allow(q, flags)) {
+			__percpu_ref_get_many(&q->q_usage_counter, 1);
 			/*
 			 * The code that sets the PREEMPT_ONLY flag is
 			 * responsible for ensuring that that flag is globally
@@ -935,7 +948,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 				percpu_ref_put(&q->q_usage_counter);
 			}
 		}
-		rcu_read_unlock();
+		rcu_read_unlock_sched();
 
 		if (success)
 			return 0;
@@ -943,17 +956,10 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
-		/*
-		 * read pair of barrier in blk_freeze_queue_start(),
-		 * we need to order reading __PERCPU_REF_DEAD flag of
-		 * .q_usage_counter and reading .mq_freeze_depth or
-		 * queue dying flag, otherwise the following wait may
-		 * never return if the two reads are reordered.
-		 */
 		smp_rmb();
 
 		wait_event(q->mq_freeze_wq,
-			   (atomic_read(&q->mq_freeze_depth) == 0 &&
+			   (blk_queue_gate_allow(q, flags) &&
 			    (preempt || !blk_queue_preempt_only(q))) ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a..fc90ad3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -140,7 +140,9 @@ void blk_freeze_queue_start(struct request_queue *q)
 
 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
 	if (freeze_depth == 1) {
-		percpu_ref_kill(&q->q_usage_counter);
+		set_bit(BLK_QUEUE_GATE_FROZEN, &q->queue_gate);
+		percpu_ref_put(&q->q_usage_counter);
+		percpu_ref_switch_to_atomic(&q->q_usage_counter, NULL);
 		if (q->mq_ops)
 			blk_mq_run_hw_queues(q, false);
 	}
@@ -198,7 +200,9 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 	freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
-		percpu_ref_reinit(&q->q_usage_counter);
+		clear_bit(BLK_QUEUE_GATE_FROZEN, &q->queue_gate);
+		percpu_ref_get(&q->q_usage_counter);
+		percpu_ref_switch_to_percpu(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
 }
diff --git a/block/blk.h b/block/blk.h
index 9db4e38..19d2c00 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -19,6 +19,10 @@
 extern struct dentry *blk_debugfs_root;
 #endif
 
+enum blk_queue_gate_flag_t {
+	BLK_QUEUE_GATE_FROZEN,
+};
+
 struct blk_flush_queue {
 	unsigned int		flush_queue_delayed:1;
 	unsigned int		flush_pending_idx:1;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0adfb3b..1980648 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3066,7 +3066,7 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	 * unfreeze even if the queue was already frozen before this function
 	 * was called. See also https://lwn.net/Articles/573497/.
 	 */
-	synchronize_rcu();
+	synchronize_sched();
 	blk_mq_unfreeze_queue(q);
 
 	mutex_lock(&sdev->state_mutex);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0..9f3f0d7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -647,6 +647,8 @@ struct request_queue {
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
 	struct percpu_ref	q_usage_counter;
+	unsigned long		queue_gate;
+
 	struct list_head	all_q_node;
 
 	struct blk_mq_tag_set	*tag_set;
-- 
2.7.4
