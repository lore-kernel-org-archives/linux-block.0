Return-Path: <prvs=673874c89=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Keith Busch <keith.busch@intel.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v13] blk-mq: Rework blk-mq timeout handling again
Date: Tue, 22 May 2018 09:25:15 -0700
Message-Id: <20180522162515.20650-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Recently the blk-mq timeout handling code was reworked. See also Tejun
Heo, "[PATCHSET v4] blk-mq: reimplement timeout handling", 08 Jan 2018
(https://www.mail-archive.com/linux-block@vger.kernel.org/msg16985.html).
This patch reworks the blk-mq timeout handling code again. The timeout
handling code is simplified by introducing a state machine per request.
This change avoids that the blk-mq timeout handling code ignores
completions that occur after blk_mq_check_expired() has been called and
before blk_mq_rq_timed_out() has been called.

Fix this race as follows:
- Reduce the gstate field from 64 to 32 bits such that cmpxchg() can
  be used to update it. Introduce deadline_seq for updating the deadline
  on 32-bit systems.
- Remove the request member variables that became superfluous due to
  this change, namely gstate_seq and aborted_gstate_sync.
- Remove the request state information that became superfluous due to
  this patch, namely RQF_MQ_TIMEOUT_EXPIRED.
- Remove the code that became superfluous due to this change, namely
  the RCU lock and unlock statements in blk_mq_complete_request() and
  also the synchronize_rcu() call in the timeout handler.

Notes:
- Atomic instructions are only used to update the request state if
  a concurrent request state change could be in progress.
- blk_add_timer() has been split into two functions - one for the
  legacy block layer and one for blk-mq.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Israel Rukshin <israelr@mellanox.com>,
Cc: Max Gurtovoy <maxg@mellanox.com>
---

Changes compared to v12:
- Switched from cmpxchg64() to cmpxchg(). This became possible because the
  deadline is now updated before the request state.
- Introduced a new request state to ensure that completions that occur while
  the timeout function is in progress are not lost.
- Left out the ARM cmpxchg64() patch.

Changes compared to v11:
- Reworked patch 1/2: instead of introducing CONFIG_ARCH_HAVE_CMPXCHG64, make
  sure that cmpxchg64() is only defined if it can be used.

Changes compared to v10:
- In patch 1/2, added "default y if 64BIT" to the "config ARCH_HAVE_CMPXCHG64"
  entry in arch/Kconfig. Left out the "select ARCH_HAVE_CMPXCHG64" statements
  that became superfluous due to this change (alpha, arm64, powerpc and s390).
- Also in patch 1/2, only select ARCH_HAVE_CMPXCHG64 if X86_CMPXCHG64 has been
  selected.
- In patch 2/2, moved blk_mq_change_rq_state() from blk-mq.h to blk-mq.c.
- Added a comment header above __blk_mq_requeue_request() and
  blk_mq_requeue_request().
- Documented the MQ_RQ_* state transitions in block/blk-mq.h.
- Left out the fourth argument of blk_mq_rq_set_deadline().

Changes compared to v9:
- Addressed multiple comments related to patch 1/2: added
  CONFIG_ARCH_HAVE_CMPXCHG64 for riscv, modified
  features/locking/cmpxchg64/arch-support.txt as requested and made the
  order of the symbols in the arch/*/Kconfig alphabetical where possible.

Changes compared to v8:
- Split into two patches.
- Moved the spin_lock_init() call from blk_mq_rq_ctx_init() into
  blk_mq_init_request().
- Fixed the deadline set by blk_add_timer().
- Surrounded the das_lock member with #ifndef CONFIG_ARCH_HAVE_CMPXCHG64 /
  #endif.

Changes compared to v7:
- Fixed the generation number mechanism. Note: with this patch applied the
  behavior of the block layer does not depend on the generation number.
- Added more 32-bit architectures to the list of architectures on which
  cmpxchg64() should not be used.

Changes compared to v6:
- Used a union instead of bit manipulations to store multiple values into
  a single 64-bit field.
- Reduced the size of the timeout field from 64 to 32 bits.
- Made sure that the block layer still builds with this patch applied
  for the sh and mips architectures.
- Fixed two sparse warnings that were introduced by this patch in the
  WRITE_ONCE() calls.

Changes compared to v5:
- Restored the synchronize_rcu() call between marking a request for timeout
  handling and the actual timeout handling to avoid that timeout handling
  starts while .queue_rq() is still in progress if the timeout is very short.
- Only use cmpxchg() if another context could attempt to change the request
  state concurrently. Use WRITE_ONCE() otherwise.

Changes compared to v4:
- Addressed multiple review comments from Christoph. The most important are
  that atomic_long_cmpxchg() has been changed into cmpxchg() and also that
  there is now a nice and clean split between the legacy and blk-mq versions
  of blk_add_timer().
- Changed the patch name and modified the patch description because there is
  disagreement about whether or not the v4.16 blk-mq core can complete a
  single request twice. Kept the "Cc: stable" tag because of
  https://bugzilla.kernel.org/show_bug.cgi?id=199077.

Changes compared to v3 (see also https://www.mail-archive.com/linux-block@vger.kernel.org/msg20073.html):
- Removed the spinlock again that was introduced to protect the request state.
  v4 uses atomic_long_cmpxchg() instead.
- Split __deadline into two variables - one for the legacy block layer and one
  for blk-mq.

Changes compared to v2 (https://www.mail-archive.com/linux-block@vger.kernel.org/msg18338.html):
- Rebased and retested on top of kernel v4.16.

Changes compared to v1 (https://www.mail-archive.com/linux-block@vger.kernel.org/msg18089.html):
- Removed the gstate and aborted_gstate members of struct request and used
  the __deadline member to encode both the generation and state information.


 block/blk-core.c       |   9 +-
 block/blk-mq-debugfs.c |   4 +-
 block/blk-mq.c         | 250 ++++++++++++++++++++++++++-----------------------
 block/blk-mq.h         |  54 +++++------
 block/blk-timeout.c    | 107 +++++++++++++--------
 block/blk.h            |   1 +
 include/linux/blkdev.h |  44 ++++-----
 7 files changed, 250 insertions(+), 219 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 341501c5e239..42b055292cdc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -198,12 +198,9 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->internal_tag = -1;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
-	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
-	/*
-	 * See comment of blk_mq_init_request
-	 */
-	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
+#ifndef CONFIG_64BIT
+	seqcount_init(&rq->deadline_seq);
+#endif
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3080e18cb859..9c539ab2c0dc 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -344,15 +344,15 @@ static const char *const rqf_name[] = {
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
 	RQF_NAME(ZONE_WRITE_LOCKED),
-	RQF_NAME(MQ_TIMEOUT_EXPIRED),
 	RQF_NAME(MQ_POLL_SLEPT),
 };
 #undef RQF_NAME
 
 static const char *const blk_mq_rq_state_name_array[] = {
 	[MQ_RQ_IDLE]		= "idle",
-	[MQ_RQ_IN_FLIGHT]	= "in_flight",
+	[MQ_RQ_IN_FLIGHT]	= "in flight",
 	[MQ_RQ_COMPLETE]	= "complete",
+	[MQ_RQ_TIMED_OUT]	= "timed out",
 };
 
 static const char *blk_mq_rq_state_name(enum mq_rq_state rq_state)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 64630caaf27e..6bfc7679a5df 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -319,6 +319,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	/* tag was already set */
 	rq->extra_len = 0;
 	rq->__deadline = 0;
+	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
 
 	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->timeout = 0;
@@ -465,6 +466,39 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+/**
+ * blk_mq_change_rq_state - atomically test and set request state
+ * @rq: Request pointer.
+ * @old_state: Old request state.
+ * @new_state: New request state.
+ *
+ * Returns %true if and only if the old state was @old and if the state has
+ * been changed into @new.
+ */
+static bool blk_mq_change_rq_state(struct request *rq,
+				   enum mq_rq_state old_state,
+				   enum mq_rq_state new_state)
+{
+	union blk_generation_and_state gstate = READ_ONCE(rq->gstate);
+	union blk_generation_and_state old_val = gstate;
+	union blk_generation_and_state new_val = gstate;
+
+	old_val.state = old_state;
+	new_val.state = new_state;
+	if (new_state == MQ_RQ_IN_FLIGHT)
+		new_val.generation++;
+	/*
+	 * For transitions from state in-flight to another state cmpxchg()
+	 * must be used. For other state transitions it is safe to use
+	 * WRITE_ONCE().
+	 */
+	if (old_state != MQ_RQ_IN_FLIGHT) {
+		WRITE_ONCE(rq->gstate.val, new_val.val);
+		return true;
+	}
+	return blk_mq_set_rq_state(rq, old_val, new_val);
+}
+
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -494,7 +528,8 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
-	blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
+	if (!blk_mq_change_rq_state(rq, blk_mq_rq_state(rq), MQ_RQ_IDLE))
+		WARN_ON_ONCE(true);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -547,8 +582,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
-	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT);
-	blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE);
+	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
@@ -593,36 +627,6 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
 		*srcu_idx = srcu_read_lock(hctx->srcu);
 }
 
-static void blk_mq_rq_update_aborted_gstate(struct request *rq, u64 gstate)
-{
-	unsigned long flags;
-
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
-
-	return aborted_gstate;
-}
-
 /**
  * blk_mq_complete_request - end I/O on a request
  * @rq:		the request being processed
@@ -634,27 +638,20 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
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
-		__blk_mq_complete_request(rq);
-	hctx_unlock(hctx, srcu_idx);
+	/* The loop is for the unlikely case of a race with the timeout code. */
+	while (true) {
+		if (blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT,
+					   MQ_RQ_COMPLETE)) {
+			__blk_mq_complete_request(rq);
+			break;
+		}
+		if (blk_mq_change_rq_state(rq, MQ_RQ_TIMED_OUT, MQ_RQ_COMPLETE))
+			break;
+	}
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
@@ -681,27 +678,8 @@ void blk_mq_start_request(struct request *rq)
 		wbt_issue(q->rq_wb, rq);
 	}
 
-	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
-
-	/*
-	 * Mark @rq in-flight which also advances the generation number,
-	 * and register for timeout.  Protect with a seqcount to allow the
-	 * timeout path to read both @rq->gstate and @rq->deadline
-	 * coherently.
-	 *
-	 * This is the only place where a request is marked in-flight.  If
-	 * the timeout path reads an in-flight @rq->gstate, the
-	 * @rq->deadline it reads together under @rq->gstate_seq is
-	 * guaranteed to be the matching one.
-	 */
-	preempt_disable();
-	write_seqcount_begin(&rq->gstate_seq);
-
-	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
-	blk_add_timer(rq);
-
-	write_seqcount_end(&rq->gstate_seq);
-	preempt_enable();
+	blk_mq_add_timer(rq);
+	blk_mq_change_rq_state(rq, MQ_RQ_IDLE, MQ_RQ_IN_FLIGHT);
 
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
@@ -714,27 +692,46 @@ void blk_mq_start_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
-/*
- * When we reach here because queue is busy, it's safe to change the state
- * to IDLE without checking @rq->aborted_gstate because we should still be
- * holding the RCU read lock and thus protected against timeout.
+/**
+ * __blk_mq_requeue_request - requeue a request
+ * @rq: request to be requeued
+ *
+ * This function is either called by blk_mq_requeue_request() or by the block
+ * layer core if .queue_rq() returned BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE.
+ * If the request state is MQ_RQ_IN_FLIGHT and if this function is called from
+ * inside .queue_rq() then it is guaranteed that the timeout code won't try to
+ * modify the request state while this function is in progress because an RCU
+ * read lock is held around .queue_rq() and because the timeout code calls
+ * synchronize_rcu() after having marked requests and before processing
+ * time-outs.
  */
 static void __blk_mq_requeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
+	enum mq_rq_state old_state = blk_mq_rq_state(rq);
 
 	blk_mq_put_driver_tag(rq);
 
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, rq);
 
-	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
-		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
+	if (old_state != MQ_RQ_IDLE) {
+		if (!blk_mq_change_rq_state(rq, old_state, MQ_RQ_IDLE))
+			WARN_ON_ONCE(true);
 		if (q->dma_drain_size && blk_rq_bytes(rq))
 			rq->nr_phys_segments--;
 	}
 }
 
+/**
+ * blk_mq_requeue_request - requeue a request
+ * @rq: request to be requeued
+ * @kick_requeue_list: whether or not to kick the requeue_list
+ *
+ * This function is called after a request has completed, after a request has
+ * timed out or from inside .queue_rq(). In the latter case the request may
+ * already have been started.
+ */
 void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 {
 	__blk_mq_requeue_request(rq);
@@ -838,8 +835,6 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
 
-	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
-
 	if (ops->timeout)
 		ret = ops->timeout(req, reserved);
 
@@ -848,13 +843,22 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
+		blk_mq_add_timer(req);
 		/*
-		 * As nothing prevents from completion happening while
-		 * ->aborted_gstate is set, this may lead to ignored
-		 * completions and further spurious timeouts.
+		 * The loop is for the unlikely case of a race with the
+		 * completion code. There is no need to reset the deadline
+		 * if the transition to the in-flight state fails because
+		 * the deadline only matters in the in-flight state.
 		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
-		blk_add_timer(req);
+		while (true) {
+			if (blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT,
+						   MQ_RQ_IN_FLIGHT))
+				break;
+			if (blk_mq_rq_state(req) == MQ_RQ_COMPLETE) {
+				__blk_mq_complete_request(req);
+				break;
+			}
+		}
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
@@ -868,48 +872,60 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
 	struct blk_mq_timeout_data *data = priv;
-	unsigned long gstate, deadline;
-	int start;
+	union blk_generation_and_state gstate = READ_ONCE(rq->gstate);
+	unsigned long deadline;
 
 	might_sleep();
 
-	if (rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED)
-		return;
-
-	/* read coherent snapshots of @rq->state_gen and @rq->deadline */
+#ifdef CONFIG_64BIT
+	deadline = rq->__deadline;
+#else
 	while (true) {
-		start = read_seqcount_begin(&rq->gstate_seq);
-		gstate = READ_ONCE(rq->gstate);
-		deadline = blk_rq_deadline(rq);
-		if (!read_seqcount_retry(&rq->gstate_seq, start))
+		int start;
+
+		start = read_seqcount_begin(&rq->deadline_seq);
+		deadline = rq->__deadline;
+		if (!read_seqcount_retry(&rq->deadline_seq, start))
 			break;
 		cond_resched();
 	}
+#endif
 
-	/* if in-flight && overdue, mark for abortion */
-	if ((gstate & MQ_RQ_STATE_MASK) == MQ_RQ_IN_FLIGHT &&
+	/*
+	 * Make sure that rq->aborted_gstate != rq->gstate if rq->deadline has
+	 * not yet been reached even if a request gets recycled before
+	 * blk_mq_terminate_expired() is called and the value of rq->deadline
+	 * is not modified due to the request recycling.
+	 */
+	rq->aborted_gstate = gstate;
+	rq->aborted_gstate.generation ^= (1UL << 29);
+	if (gstate.state == MQ_RQ_IN_FLIGHT &&
 	    time_after_eq(jiffies, deadline)) {
-		blk_mq_rq_update_aborted_gstate(rq, gstate);
+		/* request timed out */
+		rq->aborted_gstate = gstate;
 		data->nr_expired++;
 		hctx->nr_expired++;
 	} else if (!data->next_set || time_after(data->next, deadline)) {
 		data->next = deadline;
 		data->next_set = 1;
 	}
+
 }
 
 static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
+	union blk_generation_and_state old_val = rq->aborted_gstate;
+	union blk_generation_and_state new_val = old_val;
+
+	new_val.state = MQ_RQ_TIMED_OUT;
+
 	/*
-	 * We marked @rq->aborted_gstate and waited for RCU.  If there were
-	 * completions that we lost to, they would have finished and
-	 * updated @rq->gstate by now; otherwise, the completion path is
-	 * now guaranteed to see @rq->aborted_gstate and yield.  If
-	 * @rq->aborted_gstate still matches @rq->gstate, @rq is ours.
+	 * We marked @rq->aborted_gstate and waited for ongoing .queue_rq()
+	 * calls. If rq->gstate has not changed that means that it
+	 * is now safe to change the request state and to handle the timeout.
 	 */
-	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
-	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
+	if (blk_mq_set_rq_state(rq, old_val, new_val))
 		blk_mq_rq_timed_out(rq, reserved);
 }
 
@@ -948,10 +964,12 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		bool has_rcu = false;
 
 		/*
-		 * Wait till everyone sees ->aborted_gstate.  The
-		 * sequential waits for SRCUs aren't ideal.  If this ever
-		 * becomes a problem, we can add per-hw_ctx rcu_head and
-		 * wait in parallel.
+		 * For very short timeouts it can happen that
+		 * blk_mq_check_expired() modifies the state of a request
+		 * while .queue_rq() is still in progress. Hence wait until
+		 * these .queue_rq() calls have finished. This is also
+		 * necessary to avoid races with blk_mq_requeue_request() for
+		 * requests that have already been started.
 		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			if (!hctx->nr_expired)
@@ -967,7 +985,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		if (has_rcu)
 			synchronize_rcu();
 
-		/* terminate the ones we won */
+		/* Terminate the requests marked by blk_mq_check_expired(). */
 		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired, NULL);
 	}
 
@@ -2063,14 +2081,9 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			return ret;
 	}
 
-	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
-	/*
-	 * start gstate with gen 1 instead of 0, otherwise it will be equal
-	 * to aborted_gstate, and be identified timed out by
-	 * blk_mq_terminate_expired.
-	 */
-	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
+#ifndef CONFIG_64BIT
+	seqcount_init(&rq->deadline_seq);
+#endif
 
 	return 0;
 }
@@ -3105,7 +3118,8 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 
 	hrtimer_init_sleeper(&hs, current);
 	do {
-		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
+		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE ||
+		    blk_mq_rq_state(rq) == MQ_RQ_TIMED_OUT)
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		hrtimer_start_expires(&hs.timer, mode);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e1bb420dc5d6..7b810c934732 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -2,6 +2,7 @@
 #ifndef INT_BLK_MQ_H
 #define INT_BLK_MQ_H
 
+#include <asm/cmpxchg.h>
 #include "blk-stat.h"
 #include "blk-mq-tag.h"
 
@@ -30,18 +31,25 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
-/*
- * Bits for request->gstate.  The lower two bits carry MQ_RQ_* state value
- * and the upper bits the generation number.
+/**
+ * enum mq_rq_state - blk-mq request state
+ *
+ * The legal state transitions are:
+ * - idle      -> in-flight: blk_mq_start_request()
+ * - in-flight -> complete:  blk_mq_complete_request()
+ * - timed out -> complete:  blk_mq_complete_request()
+ * - in-flight -> timed out: request times out
+ * - complete/tmo -> idle:   blk_mq_requeue_request() or blk_mq_free_request()
+ * - in-flight -> idle:      blk_mq_requeue_request() or blk_mq_free_request()
+ * - timed out -> in-flight: request restart due to BLK_EH_RESET_TIMER
+ *
+ * See also blk_generation_and_state.state.
  */
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
 	MQ_RQ_IN_FLIGHT		= 1,
 	MQ_RQ_COMPLETE		= 2,
-
-	MQ_RQ_STATE_BITS	= 2,
-	MQ_RQ_STATE_MASK	= (1 << MQ_RQ_STATE_BITS) - 1,
-	MQ_RQ_GEN_INC		= 1 << MQ_RQ_STATE_BITS,
+	MQ_RQ_TIMED_OUT		= 3,
 };
 
 void blk_mq_freeze_queue(struct request_queue *q);
@@ -103,37 +111,21 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
-/**
- * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
- * @rq: target request.
- */
-static inline int blk_mq_rq_state(struct request *rq)
+static inline bool blk_mq_set_rq_state(struct request *rq,
+				       union blk_generation_and_state old_val,
+				       union blk_generation_and_state new_val)
 {
-	return READ_ONCE(rq->gstate) & MQ_RQ_STATE_MASK;
+	return cmpxchg(&rq->gstate.val, old_val.val, new_val.val) ==
+		old_val.val;
 }
 
 /**
- * blk_mq_rq_update_state() - set the current MQ_RQ_* state of a request
+ * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
  * @rq: target request.
- * @state: new state to set.
- *
- * Set @rq's state to @state.  The caller is responsible for ensuring that
- * there are no other updaters.  A request can transition into IN_FLIGHT
- * only from IDLE and doing so increments the generation number.
  */
-static inline void blk_mq_rq_update_state(struct request *rq,
-					  enum mq_rq_state state)
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
 {
-	u64 old_val = READ_ONCE(rq->gstate);
-	u64 new_val = (old_val & ~MQ_RQ_STATE_MASK) | state;
-
-	if (state == MQ_RQ_IN_FLIGHT) {
-		WARN_ON_ONCE((old_val & MQ_RQ_STATE_MASK) != MQ_RQ_IDLE);
-		new_val += MQ_RQ_GEN_INC;
-	}
-
-	/* avoid exposing interim values */
-	WRITE_ONCE(rq->gstate, new_val);
+	return READ_ONCE(rq->gstate).state;
 }
 
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 652d4d4d3e97..3abbaa332a91 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -145,6 +145,22 @@ void blk_timeout_work(struct work_struct *work)
 	spin_unlock_irqrestore(q->queue_lock, flags);
 }
 
+/* Update deadline to @time. May be called from interrupt context. */
+static void blk_mq_rq_set_deadline(struct request *rq, unsigned long new_time)
+{
+#ifdef CONFIG_64BIT
+	rq->__deadline = new_time;
+#else
+	unsigned long flags;
+
+	local_irq_save(flags);
+	write_seqcount_begin(&rq->deadline_seq);
+	rq->__deadline = new_time;
+	write_seqcount_end(&rq->deadline_seq);
+	local_irq_restore(flags);
+#endif
+}
+
 /**
  * blk_abort_request -- Request request recovery for the specified command
  * @req:	pointer to the request of interest
@@ -158,11 +174,10 @@ void blk_abort_request(struct request *req)
 {
 	if (req->q->mq_ops) {
 		/*
-		 * All we need to ensure is that timeout scan takes place
-		 * immediately and that scan sees the new timeout value.
-		 * No need for fancy synchronizations.
+		 * Ensure that a timeout scan takes place immediately and that
+		 * that scan sees the new timeout value.
 		 */
-		blk_rq_set_deadline(req, jiffies);
+		blk_mq_rq_set_deadline(req, jiffies);
 		kblockd_schedule_work(&req->q->timeout_work);
 	} else {
 		if (blk_mark_rq_complete(req))
@@ -184,52 +199,17 @@ unsigned long blk_rq_timeout(unsigned long timeout)
 	return timeout;
 }
 
-/**
- * blk_add_timer - Start timeout timer for a single request
- * @req:	request that is about to start running.
- *
- * Notes:
- *    Each request has its own timer, and as it is added to the queue, we
- *    set up the timer. When the request completes, we cancel the timer.
- */
-void blk_add_timer(struct request *req)
+static void __blk_add_timer(struct request *req, unsigned long deadline)
 {
 	struct request_queue *q = req->q;
 	unsigned long expiry;
 
-	if (!q->mq_ops)
-		lockdep_assert_held(q->queue_lock);
-
-	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
-	if (!q->mq_ops && !q->rq_timed_out_fn)
-		return;
-
-	BUG_ON(!list_empty(&req->timeout_list));
-
-	/*
-	 * Some LLDs, like scsi, peek at the timeout to prevent a
-	 * command from being retried forever.
-	 */
-	if (!req->timeout)
-		req->timeout = q->rq_timeout;
-
-	blk_rq_set_deadline(req, jiffies + req->timeout);
-	req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
-
-	/*
-	 * Only the non-mq case needs to add the request to a protected list.
-	 * For the mq case we simply scan the tag map.
-	 */
-	if (!q->mq_ops)
-		list_add_tail(&req->timeout_list, &req->q->timeout_list);
-
 	/*
 	 * If the timer isn't already pending or this timeout is earlier
 	 * than an existing one, modify the timer. Round up to next nearest
 	 * second.
 	 */
-	expiry = blk_rq_timeout(round_jiffies_up(blk_rq_deadline(req)));
-
+	expiry = blk_rq_timeout(round_jiffies_up(deadline));
 	if (!timer_pending(&q->timeout) ||
 	    time_before(expiry, q->timeout.expires)) {
 		unsigned long diff = q->timeout.expires - expiry;
@@ -244,5 +224,50 @@ void blk_add_timer(struct request *req)
 		if (!timer_pending(&q->timeout) || (diff >= HZ / 2))
 			mod_timer(&q->timeout, expiry);
 	}
+}
 
+/**
+ * blk_add_timer - Start timeout timer for a single request
+ * @req:	request that is about to start running.
+ *
+ * Notes:
+ *    Each request has its own timer, and as it is added to the queue, we
+ *    set up the timer. When the request completes, we cancel the timer.
+ */
+void blk_add_timer(struct request *req)
+{
+	struct request_queue *q = req->q;
+	unsigned long deadline;
+
+	lockdep_assert_held(q->queue_lock);
+
+	if (!q->rq_timed_out_fn)
+		return;
+	if (!req->timeout)
+		req->timeout = q->rq_timeout;
+
+	deadline = jiffies + req->timeout;
+	blk_rq_set_deadline(req, deadline);
+	list_add_tail(&req->timeout_list, &req->q->timeout_list);
+
+	return __blk_add_timer(req, deadline);
+}
+
+/**
+ * blk_mq_add_timer - set the deadline for a single request
+ * @req:	request for which to set the deadline.
+ *
+ * Sets the deadline of a request. The caller must guarantee that the request
+ * state won't be modified while this function is in progress.
+ */
+void blk_mq_add_timer(struct request *req)
+{
+	struct request_queue *q = req->q;
+	unsigned long deadline;
+
+	if (!req->timeout)
+		req->timeout = q->rq_timeout;
+	deadline = jiffies + req->timeout;
+	blk_mq_rq_set_deadline(req, deadline);
+	return __blk_add_timer(req, deadline);
 }
diff --git a/block/blk.h b/block/blk.h
index eaf1a8e87d11..ffd44cbf3095 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -170,6 +170,7 @@ static inline bool bio_integrity_endio(struct bio *bio)
 void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
+void blk_mq_add_timer(struct request *req);
 void blk_delete_timer(struct request *);
 
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f3999719f828..acc08806a6e5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -7,6 +7,7 @@
 
 #ifdef CONFIG_BLOCK
 
+#include <linux/atomic.h>	/* cmpxchg() */
 #include <linux/major.h>
 #include <linux/genhd.h>
 #include <linux/list.h>
@@ -28,7 +29,6 @@
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
 #include <linux/seqlock.h>
-#include <linux/u64_stats_sync.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -125,15 +125,21 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
 /* The per-zone write lock is held for this request */
 #define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
-/* timeout is expired */
-#define RQF_MQ_TIMEOUT_EXPIRED	((__force req_flags_t)(1 << 20))
 /* already slept for hybrid poll */
-#define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 21))
+#define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
 	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
 
+union blk_generation_and_state {
+	struct {
+		uint32_t generation:30;
+		uint32_t state:2;
+	};
+	uint32_t val;
+};
+
 /*
  * Try to put the fields that are referenced together in the same cacheline.
  *
@@ -236,28 +242,24 @@ struct request {
 
 	unsigned int extra_len;	/* length of alignment and padding */
 
-	/*
-	 * On blk-mq, the lower bits of ->gstate (generation number and
-	 * state) carry the MQ_RQ_* state value and the upper bits the
-	 * generation number which is monotonically incremented and used to
-	 * distinguish the reuse instances.
-	 *
-	 * ->gstate_seq allows updates to ->gstate and other fields
-	 * (currently ->deadline) during request start to be read
-	 * atomically from the timeout path, so that it can operate on a
-	 * coherent set of information.
-	 */
-	seqcount_t gstate_seq;
-	u64 gstate;
-
 	/*
 	 * ->aborted_gstate is used by the timeout to claim a specific
 	 * recycle instance of this request.  See blk_mq_timeout_work().
 	 */
-	struct u64_stats_sync aborted_gstate_sync;
-	u64 aborted_gstate;
+	union blk_generation_and_state aborted_gstate;
 
-	/* access through blk_rq_set_deadline, blk_rq_deadline */
+	/*
+	 * Access through blk_rq_deadline() and blk_rq_set_deadline(),
+	 * blk_mark_rq_complete(), blk_clear_rq_complete() and
+	 * blk_rq_is_complete() for legacy queues or blk_mq_rq_state(),
+	 * blk_mq_change_rq_state() and blk_mq_rq_set_deadline() for
+	 * blk-mq queues. deadline_seq protects __deadline in blk-mq mode
+	 * only.
+	 */
+	union blk_generation_and_state gstate;
+#ifndef CONFIG_64BIT
+	seqcount_t deadline_seq;
+#endif
 	unsigned long __deadline;
 
 	struct list_head timeout_list;
-- 
2.16.3
