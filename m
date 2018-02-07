Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:2105 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754189AbeBGBLe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Feb 2018 20:11:34 -0500
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH v2] blk-mq: Fix race between resetting the timer and completion handling
Date: Tue,  6 Feb 2018 17:11:33 -0800
Message-Id: <20180207011133.25957-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The following race can occur between the code that resets the timer
and completion handling:
- The code that handles BLK_EH_RESET_TIMER resets aborted_gstate.
- A completion occurs and blk_mq_complete_request() calls
  __blk_mq_complete_request().
- The timeout code calls blk_add_timer() and that function sets the
  request deadline and adjusts the timer.
- __blk_mq_complete_request() frees the request tag.
- The timer fires and the timeout handler gets called for a freed
  request.

Since I have not found any approach to fix this race that does not
require the use of atomic instructions to manipulate the request state,
fix this race as follows:
- Introduce a spinlock to protecte request state and deadline changes.
- Use the deadline instead of the request generation to detect whether
  or not a request timer got fired after reinitialization of a request.
- Store the request state in the lowest two bits of the deadline instead
  of the lowest to bits of 'gstate'.
- Remove all request member variables that became superfluous due to
  this change: gstate, aborted_gstate, gstate_seq and aborted_gstate_sync.
- Remove the state information that became superfluous due to this patch,
  namely RQF_MQ_TIMEOUT_EXPIRED.
- Remove the code that became superfluous due to this change, namely
  the RCU lock and unlock statements in blk_mq_complete_request() and
  also the synchronize_rcu() call in the timeout handler.

This patch fixes the following kernel crash:

BUG: unable to handle kernel NULL pointer dereference at           (null)
Oops: 0000 [#1] PREEMPT SMP
CPU: 2 PID: 151 Comm: kworker/2:1H Tainted: G        W        4.15.0-dbg+ #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:scsi_times_out+0x17/0x2c0 [scsi_mod]
Call Trace:
blk_mq_terminate_expired+0x42/0x80
bt_iter+0x3d/0x50
blk_mq_queue_tag_busy_iter+0xe9/0x200
blk_mq_timeout_work+0x181/0x2e0
process_one_work+0x21c/0x6d0
worker_thread+0x35/0x380
kthread+0x117/0x130
ret_from_fork+0x24/0x30

Fixes: 1d9bd5161ba3 ("blk-mq: replace timeout synchronization with a RCU and generation based scheme")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-core.c       |   3 +-
 block/blk-mq-debugfs.c |   1 -
 block/blk-mq.c         | 178 +++++++++++--------------------------------------
 block/blk-mq.h         |  25 ++-----
 block/blk-timeout.c    |   1 -
 block/blk.h            |   4 +-
 include/linux/blkdev.h |  28 ++------
 7 files changed, 53 insertions(+), 187 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0d104268f1a..2e3cf04f12a8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -126,8 +126,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->start_time = jiffies;
 	set_start_time_ns(rq);
 	rq->part = NULL;
-	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
+	spin_lock_init(&rq->state_lock);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 21cbc1f071c6..43084d64aa41 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -290,7 +290,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
 	RQF_NAME(ZONE_WRITE_LOCKED),
-	RQF_NAME(MQ_TIMEOUT_EXPIRED),
 	RQF_NAME(MQ_POLL_SLEPT),
 };
 #undef RQF_NAME
diff --git a/block/blk-mq.c b/block/blk-mq.c
index df93102e2149..e17a2536ac50 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -309,7 +309,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
-	rq->__deadline = 0;
 
 	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->timeout = 0;
@@ -531,8 +530,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
-	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT);
-	blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE);
+	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
@@ -581,34 +579,26 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
 		*srcu_idx = srcu_read_lock(hctx->srcu);
 }
 
-static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
+/**
+ * blk_mq_change_rq_state - atomically test and set request state
+ * @rq: Request pointer.
+ * @old: Old request state.
+ * @new: New request state.
+ */
+static bool blk_mq_change_rq_state(struct request *rq, enum mq_rq_state old,
+				   enum mq_rq_state new)
 {
 	unsigned long flags;
+	bool changed_state = false;
 
-	/*
-	 * blk_mq_rq_aborted_gstate() is used from the completion path and
-	 * can thus be called from irq context.  u64_stats_fetch in the
-	 * middle of update on the same CPU leads to lockup.  Disable irq
-	 * while updating.
-	 */
-	local_irq_save(flags);
-	u64_stats_update_begin(&rq->aborted_gstate_sync);
-	rq->aborted_gstate = gstate;
-	u64_stats_update_end(&rq->aborted_gstate_sync);
-	local_irq_restore(flags);
-}
-
-static u64 blk_mq_rq_aborted_gstate(struct request *rq)
-{
-	unsigned int start;
-	u64 aborted_gstate;
-
-	do {
-		start = u64_stats_fetch_begin(&rq->aborted_gstate_sync);
-		aborted_gstate = rq->aborted_gstate;
-	} while (u64_stats_fetch_retry(&rq->aborted_gstate_sync, start));
+	spin_lock_irqsave(&rq->state_lock, flags);
+	if (blk_mq_rq_state(rq) == old) {
+		blk_mq_rq_update_state(rq, new);
+		changed_state = true;
+	}
+	spin_unlock_irqrestore(&rq->state_lock, flags);
 
-	return aborted_gstate;
+	return changed_state;
 }
 
 /**
@@ -622,27 +612,12 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
 void blk_mq_complete_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
-	int srcu_idx;
 
 	if (unlikely(blk_should_fake_timeout(q)))
 		return;
 
-	/*
-	 * If @rq->aborted_gstate equals the current instance, timeout is
-	 * claiming @rq and we lost.  This is synchronized through
-	 * hctx_lock().  See blk_mq_timeout_work() for details.
-	 *
-	 * Completion path never blocks and we can directly use RCU here
-	 * instead of hctx_lock() which can be either RCU or SRCU.
-	 * However, that would complicate paths which want to synchronize
-	 * against us.  Let stay in sync with the issue path so that
-	 * hctx_lock() covers both issue and completion paths.
-	 */
-	hctx_lock(hctx, &srcu_idx);
-	if (blk_mq_rq_aborted_gstate(rq) != rq->gstate)
+	if (blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE))
 		__blk_mq_complete_request(rq);
-	hctx_unlock(hctx, srcu_idx);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
@@ -669,24 +644,14 @@ void blk_mq_start_request(struct request *rq)
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
 
 	/*
-	 * Mark @rq in-flight which also advances the generation number,
-	 * and register for timeout.  Protect with a seqcount to allow the
-	 * timeout path to read both @rq->gstate and @rq->deadline
-	 * coherently.
-	 *
-	 * This is the only place where a request is marked in-flight.  If
-	 * the timeout path reads an in-flight @rq->gstate, the
-	 * @rq->deadline it reads together under @rq->gstate_seq is
-	 * guaranteed to be the matching one.
+	 * Mark @rq in-flight and register for timeout. Because blk_add_timer()
+	 * updates the deadline, if a timer set by a previous incarnation of
+	 * this request fires this request will be skipped by the timeout code.
 	 */
-	preempt_disable();
-	write_seqcount_begin(&rq->gstate_seq);
-
+	spin_lock_irq(&rq->state_lock);
 	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
 	blk_add_timer(rq);
-
-	write_seqcount_end(&rq->gstate_seq);
-	preempt_enable();
+	spin_unlock_irq(&rq->state_lock);
 
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
@@ -699,11 +664,6 @@ void blk_mq_start_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
-/*
- * When we reach here because queue is busy, it's safe to change the state
- * to IDLE without checking @rq->aborted_gstate because we should still be
- * holding the RCU read lock and thus protected against timeout.
- */
 static void __blk_mq_requeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -813,15 +773,13 @@ EXPORT_SYMBOL(blk_mq_tag_to_rq);
 struct blk_mq_timeout_data {
 	unsigned long next;
 	unsigned int next_set;
-	unsigned int nr_expired;
 };
 
 static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
-
-	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
+	unsigned long flags;
 
 	if (ops->timeout)
 		ret = ops->timeout(req, reserved);
@@ -831,13 +789,10 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
-		/*
-		 * As nothing prevents from completion happening while
-		 * ->aborted_gstate is set, this may lead to ignored
-		 * completions and further spurious timeouts.
-		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
+		spin_lock_irqsave(&req->state_lock, flags);
 		blk_add_timer(req);
+		blk_mq_rq_update_state(req, MQ_RQ_IN_FLIGHT);
+		spin_unlock_irqrestore(&req->state_lock, flags);
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
@@ -851,48 +806,23 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
 	struct blk_mq_timeout_data *data = priv;
-	unsigned long gstate, deadline;
-	int start;
-
-	might_sleep();
-
-	if (rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED)
-		return;
-
-	/* read coherent snapshots of @rq->state_gen and @rq->deadline */
-	while (true) {
-		start = read_seqcount_begin(&rq->gstate_seq);
-		gstate = READ_ONCE(rq->gstate);
-		deadline = blk_rq_deadline(rq);
-		if (!read_seqcount_retry(&rq->gstate_seq, start))
-			break;
-		cond_resched();
-	}
+	unsigned long deadline;
+	bool timed_out = false;
 
-	/* if in-flight && overdue, mark for abortion */
-	if ((gstate & MQ_RQ_STATE_MASK) == MQ_RQ_IN_FLIGHT &&
+	spin_lock_irq(&rq->state_lock);
+	deadline = blk_rq_deadline(rq);
+	if (blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT &&
 	    time_after_eq(jiffies, deadline)) {
-		blk_mq_rq_update_aborted_gstate(rq, gstate);
-		data->nr_expired++;
+		blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE);
+		timed_out = true;
 		hctx->nr_expired++;
 	} else if (!data->next_set || time_after(data->next, deadline)) {
 		data->next = deadline;
 		data->next_set = 1;
 	}
-}
+	spin_unlock_irq(&rq->state_lock);
 
-static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, void *priv, bool reserved)
-{
-	/*
-	 * We marked @rq->aborted_gstate and waited for RCU.  If there were
-	 * completions that we lost to, they would have finished and
-	 * updated @rq->gstate by now; otherwise, the completion path is
-	 * now guaranteed to see @rq->aborted_gstate and yield.  If
-	 * @rq->aborted_gstate still matches @rq->gstate, @rq is ours.
-	 */
-	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
-	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
+	if (timed_out)
 		blk_mq_rq_timed_out(rq, reserved);
 }
 
@@ -900,11 +830,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 {
 	struct request_queue *q =
 		container_of(work, struct request_queue, timeout_work);
-	struct blk_mq_timeout_data data = {
-		.next		= 0,
-		.next_set	= 0,
-		.nr_expired	= 0,
-	};
+	struct blk_mq_timeout_data data = { };
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
@@ -927,33 +853,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	/* scan for the expired ones and set their ->aborted_gstate */
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
-	if (data.nr_expired) {
-		bool has_rcu = false;
-
-		/*
-		 * Wait till everyone sees ->aborted_gstate.  The
-		 * sequential waits for SRCUs aren't ideal.  If this ever
-		 * becomes a problem, we can add per-hw_ctx rcu_head and
-		 * wait in parallel.
-		 */
-		queue_for_each_hw_ctx(q, hctx, i) {
-			if (!hctx->nr_expired)
-				continue;
-
-			if (!(hctx->flags & BLK_MQ_F_BLOCKING))
-				has_rcu = true;
-			else
-				synchronize_srcu(hctx->srcu);
-
-			hctx->nr_expired = 0;
-		}
-		if (has_rcu)
-			synchronize_rcu();
-
-		/* terminate the ones we won */
-		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired, NULL);
-	}
-
 	if (data.next_set) {
 		data.next = blk_rq_timeout(round_jiffies_up(data.next));
 		mod_timer(&q->timeout, data.next);
@@ -2073,8 +1972,7 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			return ret;
 	}
 
-	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
+	spin_lock_init(&rq->state_lock);
 	return 0;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 88c558f71819..d4d72f95d5a9 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -27,10 +27,7 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
-/*
- * Bits for request->gstate.  The lower two bits carry MQ_RQ_* state value
- * and the upper bits the generation number.
- */
+/* Lowest two bits of request->__deadline. */
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
 	MQ_RQ_IN_FLIGHT		= 1,
@@ -38,7 +35,6 @@ enum mq_rq_state {
 
 	MQ_RQ_STATE_BITS	= 2,
 	MQ_RQ_STATE_MASK	= (1 << MQ_RQ_STATE_BITS) - 1,
-	MQ_RQ_GEN_INC		= 1 << MQ_RQ_STATE_BITS,
 };
 
 void blk_mq_freeze_queue(struct request_queue *q);
@@ -104,9 +100,9 @@ void blk_mq_release(struct request_queue *q);
  * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
  * @rq: target request.
  */
-static inline int blk_mq_rq_state(struct request *rq)
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
 {
-	return READ_ONCE(rq->gstate) & MQ_RQ_STATE_MASK;
+	return rq->__deadline & MQ_RQ_STATE_MASK;
 }
 
 /**
@@ -115,22 +111,15 @@ static inline int blk_mq_rq_state(struct request *rq)
  * @state: new state to set.
  *
  * Set @rq's state to @state.  The caller is responsible for ensuring that
- * there are no other updaters.  A request can transition into IN_FLIGHT
- * only from IDLE and doing so increments the generation number.
+ * there are no other updaters.
  */
 static inline void blk_mq_rq_update_state(struct request *rq,
 					  enum mq_rq_state state)
 {
-	u64 old_val = READ_ONCE(rq->gstate);
-	u64 new_val = (old_val & ~MQ_RQ_STATE_MASK) | state;
-
-	if (state == MQ_RQ_IN_FLIGHT) {
-		WARN_ON_ONCE((old_val & MQ_RQ_STATE_MASK) != MQ_RQ_IDLE);
-		new_val += MQ_RQ_GEN_INC;
-	}
+	unsigned long d = rq->__deadline;
 
-	/* avoid exposing interim values */
-	WRITE_ONCE(rq->gstate, new_val);
+	d &= ~(unsigned long)MQ_RQ_STATE_MASK;
+	rq->__deadline = d | state;
 }
 
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index a05e3676d24a..81bf1ff1b4d8 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -216,7 +216,6 @@ void blk_add_timer(struct request *req)
 		req->timeout = q->rq_timeout;
 
 	blk_rq_set_deadline(req, jiffies + req->timeout);
-	req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
 
 	/*
 	 * Only the non-mq case needs to add the request to a protected list.
diff --git a/block/blk.h b/block/blk.h
index 46db5dc83dcb..56391f201d5e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -245,12 +245,12 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
  */
 static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
 {
-	rq->__deadline = time & ~0x1UL;
+	rq->__deadline = (time & ~0x3UL) | (rq->__deadline & 3UL);
 }
 
 static inline unsigned long blk_rq_deadline(struct request *rq)
 {
-	return rq->__deadline & ~0x1UL;
+	return rq->__deadline & ~0x3UL;
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4f3df807cf8f..61438dd09598 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,7 +27,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/seqlock.h>
 #include <linux/u64_stats_sync.h>
 
 struct module;
@@ -125,8 +124,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
 /* The per-zone write lock is held for this request */
 #define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
-/* timeout is expired */
-#define RQF_MQ_TIMEOUT_EXPIRED	((__force req_flags_t)(1 << 20))
 /* already slept for hybrid poll */
 #define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 21))
 
@@ -141,6 +138,7 @@ typedef __u32 __bitwise req_flags_t;
  * especially blk_mq_rq_ctx_init() to take care of the added fields.
  */
 struct request {
+	spinlock_t state_lock;		/* protects __deadline for blk-mq */
 	struct request_queue *q;
 	struct blk_mq_ctx *mq_ctx;
 
@@ -226,27 +224,11 @@ struct request {
 	unsigned int extra_len;	/* length of alignment and padding */
 
 	/*
-	 * On blk-mq, the lower bits of ->gstate (generation number and
-	 * state) carry the MQ_RQ_* state value and the upper bits the
-	 * generation number which is monotonically incremented and used to
-	 * distinguish the reuse instances.
-	 *
-	 * ->gstate_seq allows updates to ->gstate and other fields
-	 * (currently ->deadline) during request start to be read
-	 * atomically from the timeout path, so that it can operate on a
-	 * coherent set of information.
+	 * access through blk_rq_set_deadline(), blk_rq_deadline() and
+	 * blk_mark_rq_complete(), blk_clear_rq_complete() and
+	 * blk_rq_is_complete() for legacy queues or blk_mq_rq_state() for
+	 * blk-mq queues.
 	 */
-	seqcount_t gstate_seq;
-	u64 gstate;
-
-	/*
-	 * ->aborted_gstate is used by the timeout to claim a specific
-	 * recycle instance of this request.  See blk_mq_timeout_work().
-	 */
-	struct u64_stats_sync aborted_gstate_sync;
-	u64 aborted_gstate;
-
-	/* access through blk_rq_set_deadline, blk_rq_deadline */
 	unsigned long __deadline;
 
 	struct list_head timeout_list;
-- 
2.16.1
