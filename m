Return-Path: <prvs=6660f83ed=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH v9 2/2] blk-mq: Rework blk-mq timeout handling again
Date: Tue, 15 May 2018 15:51:24 -0700
Message-Id: <20180515225124.20428-6-bart.vanassche@wdc.com>
In-Reply-To: <20180515225124.20428-1-bart.vanassche@wdc.com>
References: <20180515225124.20428-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Recently the blk-mq timeout handling code was reworked. See also Tejun
Heo, "[PATCHSET v4] blk-mq: reimplement timeout handling", 08 Jan 2018
(https://www.mail-archive.com/linux-block@vger.kernel.org/msg16985.html).
This patch reworks the blk-mq timeout handling code again. The timeout
handling code is simplified by introducing a state machine per request.
This change avoids that the blk-mq timeout handling code ignores
completions that occur after blk_mq_check_expired() has been called and
before blk_mq_rq_timed_out() has reset rq->aborted_gstate. If a block
driver timeout handler always returns BLK_EH_RESET_TIMER then the result
will be that the request never terminates.

Fix this race as follows:
- Replace the __deadline member of struct request by a new member
  called das that contains the generation number, state and deadline.
  Only 32 bits are used for the deadline field such that all three
  fields occupy only 64 bits. This change reduces the maximum supported
  request timeout value from (2**63/HZ) to (2**31/HZ).
- Remove all request member variables that became superfluous due to
  this change: gstate, gstate_seq and aborted_gstate_sync.
- Remove the request state information that became superfluous due to
  this patch, namely RQF_MQ_TIMEOUT_EXPIRED.
- Remove the code that became superfluous due to this change, namely
  the RCU lock and unlock statements in blk_mq_complete_request() and
  also the synchronize_rcu() call in the timeout handler.

Notes:
- A spinlock is used to protect atomic changes of rq->das on those
  architectures that do not provide a cmpxchg64() implementation.
- Atomic instructions are only used to update the request state if
  a concurrent request state change could be in progress.
- blk_add_timer() has been split into two functions - one for the
  legacy block layer and one for blk-mq.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Israel Rukshin <israelr@mellanox.com>,
Cc: Max Gurtovoy <maxg@mellanox.com>
---
 block/blk-core.c       |   6 --
 block/blk-mq-debugfs.c |   1 -
 block/blk-mq.c         | 183 ++++++++++++++-----------------------------------
 block/blk-mq.h         | 117 +++++++++++++++++++++++--------
 block/blk-timeout.c    |  95 ++++++++++++++-----------
 block/blk.h            |  14 ++--
 include/linux/blkdev.h |  47 ++++++-------
 7 files changed, 230 insertions(+), 233 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 341501c5e239..a7301fcda734 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -198,12 +198,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->internal_tag = -1;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
-	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
-	/*
-	 * See comment of blk_mq_init_request
-	 */
-	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3080e18cb859..ffa622366922 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -344,7 +344,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
 	RQF_NAME(ZONE_WRITE_LOCKED),
-	RQF_NAME(MQ_TIMEOUT_EXPIRED),
 	RQF_NAME(MQ_POLL_SLEPT),
 };
 #undef RQF_NAME
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 64630caaf27e..40c9aa085613 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -318,7 +318,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
-	rq->__deadline = 0;
+	WARN_ON_ONCE(rq->das.state != MQ_RQ_IDLE);
 
 	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->timeout = 0;
@@ -494,7 +494,8 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
-	blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
+	if (!blk_mq_change_rq_state(rq, blk_mq_rq_state(rq), MQ_RQ_IDLE))
+		WARN_ON_ONCE(true);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -547,8 +548,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
-	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT);
-	blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE);
+	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
@@ -593,36 +593,6 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
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
@@ -634,27 +604,12 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
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
 
@@ -681,27 +636,7 @@ void blk_mq_start_request(struct request *rq)
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
+	blk_mq_add_timer(rq, MQ_RQ_IDLE, MQ_RQ_IN_FLIGHT);
 
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
@@ -714,22 +649,19 @@ void blk_mq_start_request(struct request *rq)
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
@@ -838,8 +770,6 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
 
-	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
-
 	if (ops->timeout)
 		ret = ops->timeout(req, reserved);
 
@@ -848,13 +778,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		__blk_mq_complete_request(req);
 		break;
 	case BLK_EH_RESET_TIMER:
-		/*
-		 * As nothing prevents from completion happening while
-		 * ->aborted_gstate is set, this may lead to ignored
-		 * completions and further spurious timeouts.
-		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
-		blk_add_timer(req);
+		blk_mq_add_timer(req, MQ_RQ_COMPLETE, MQ_RQ_IN_FLIGHT);
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
@@ -868,48 +792,50 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
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
+	union blk_deadline_and_state das = READ_ONCE(rq->das);
+	unsigned long now = jiffies;
+	int32_t diff_jiffies = das.deadline - now;
+	int32_t diff_next = das.deadline - data->next;
+	enum mq_rq_state rq_state = das.state;
 
-	/* read coherent snapshots of @rq->state_gen and @rq->deadline */
-	while (true) {
-		start = read_seqcount_begin(&rq->gstate_seq);
-		gstate = READ_ONCE(rq->gstate);
-		deadline = blk_rq_deadline(rq);
-		if (!read_seqcount_retry(&rq->gstate_seq, start))
-			break;
-		cond_resched();
-	}
-
-	/* if in-flight && overdue, mark for abortion */
-	if ((gstate & MQ_RQ_STATE_MASK) == MQ_RQ_IN_FLIGHT &&
-	    time_after_eq(jiffies, deadline)) {
-		blk_mq_rq_update_aborted_gstate(rq, gstate);
+	/*
+	 * Make sure that rq->aborted_gstate != rq->das if rq->deadline has not
+	 * yet been reached even if a request gets recycled before
+	 * blk_mq_terminate_expired() is called and the value of rq->deadline
+	 * is not modified due to the request recycling.
+	 */
+	rq->aborted_gstate = das;
+	rq->aborted_gstate.generation ^= (1UL << 29);
+	if (diff_jiffies <= 0 && rq_state == MQ_RQ_IN_FLIGHT) {
+		/* request timed out */
+		rq->aborted_gstate = das;
 		data->nr_expired++;
 		hctx->nr_expired++;
-	} else if (!data->next_set || time_after(data->next, deadline)) {
-		data->next = deadline;
+	} else if (!data->next_set) {
+		/* data->next is not yet set; set it to deadline. */
+		data->next = now + diff_jiffies;
 		data->next_set = 1;
+	} else if (diff_next < 0) {
+		/* data->next is later than deadline; reduce data->next. */
+		data->next += diff_next;
 	}
+
 }
 
 static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
+	union blk_deadline_and_state old_val = rq->aborted_gstate;
+	union blk_deadline_and_state new_val = old_val;
+
+	new_val.state = MQ_RQ_COMPLETE;
+
 	/*
-	 * We marked @rq->aborted_gstate and waited for RCU.  If there were
-	 * completions that we lost to, they would have finished and
-	 * updated @rq->gstate by now; otherwise, the completion path is
-	 * now guaranteed to see @rq->aborted_gstate and yield.  If
-	 * @rq->aborted_gstate still matches @rq->gstate, @rq is ours.
+	 * We marked @rq->aborted_gstate and waited for ongoing .queue_rq()
+	 * calls. If rq->das has not changed that means that it
+	 * is now safe to change the request state and to handle the timeout.
 	 */
-	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
-	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
+	if (blk_mq_set_rq_state(rq, old_val, new_val))
 		blk_mq_rq_timed_out(rq, reserved);
 }
 
@@ -948,10 +874,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		bool has_rcu = false;
 
 		/*
-		 * Wait till everyone sees ->aborted_gstate.  The
-		 * sequential waits for SRCUs aren't ideal.  If this ever
-		 * becomes a problem, we can add per-hw_ctx rcu_head and
-		 * wait in parallel.
+		 * For very short timeouts it can happen that
+		 * blk_mq_check_expired() modifies the state of a request
+		 * while .queue_rq() is still in progress. Hence wait until
+		 * these .queue_rq() calls have finished.
 		 */
 		queue_for_each_hw_ctx(q, hctx, i) {
 			if (!hctx->nr_expired)
@@ -967,7 +893,7 @@ static void blk_mq_timeout_work(struct work_struct *work)
 		if (has_rcu)
 			synchronize_rcu();
 
-		/* terminate the ones we won */
+		/* Terminate the requests marked by blk_mq_check_expired(). */
 		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired, NULL);
 	}
 
@@ -2057,21 +1983,16 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 {
 	int ret;
 
+#ifndef CONFIG_ARCH_HAVE_CMPXCHG64
+	spin_lock_init(&rq->das_lock);
+#endif
+
 	if (set->ops->init_request) {
 		ret = set->ops->init_request(set, rq, hctx_idx, node);
 		if (ret)
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
-
 	return 0;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e1bb420dc5d6..42320011d264 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -2,6 +2,7 @@
 #ifndef INT_BLK_MQ_H
 #define INT_BLK_MQ_H
 
+#include <asm/cmpxchg.h>
 #include "blk-stat.h"
 #include "blk-mq-tag.h"
 
@@ -30,18 +31,11 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
-/*
- * Bits for request->gstate.  The lower two bits carry MQ_RQ_* state value
- * and the upper bits the generation number.
- */
+/* See also blk_deadline_and_state.state. */
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
 	MQ_RQ_IN_FLIGHT		= 1,
 	MQ_RQ_COMPLETE		= 2,
-
-	MQ_RQ_STATE_BITS	= 2,
-	MQ_RQ_STATE_MASK	= (1 << MQ_RQ_STATE_BITS) - 1,
-	MQ_RQ_GEN_INC		= 1 << MQ_RQ_STATE_BITS,
 };
 
 void blk_mq_freeze_queue(struct request_queue *q);
@@ -103,37 +97,106 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
+static inline bool blk_mq_set_rq_state(struct request *rq,
+				       union blk_deadline_and_state old_val,
+				       union blk_deadline_and_state new_val)
+{
+#ifdef CONFIG_ARCH_HAVE_CMPXCHG64
+	return cmpxchg64(&rq->das.das, old_val.das, new_val.das) == old_val.das;
+#else
+	unsigned long flags;
+	bool res = false;
+
+	spin_lock_irqsave(&rq->das_lock, flags);
+	if (rq->das.das == old_val.das) {
+		rq->das = new_val;
+		res = true;
+	}
+	spin_unlock_irqrestore(&rq->das_lock, flags);
+
+	return res;
+#endif
+}
+
+/*
+ * If the state of request @rq equals @old_state, update deadline and request
+ * state atomically to @time and @new_state. blk-mq only. cmpxchg64() is only
+ * used if there could be a concurrent update attempt from another context.
+ */
+static inline bool blk_mq_rq_set_deadline(struct request *rq,
+					  unsigned long new_time,
+					  enum mq_rq_state old_state,
+					  enum mq_rq_state new_state)
+{
+	union blk_deadline_and_state old_val, new_val;
+
+	if (old_state != MQ_RQ_IN_FLIGHT) {
+		old_val = READ_ONCE(rq->das);
+		if (old_val.state != old_state)
+			return false;
+		new_val = old_val;
+		new_val.deadline = new_time;
+		new_val.state = new_state;
+		if (new_state == MQ_RQ_IN_FLIGHT)
+			new_val.generation++;
+		WRITE_ONCE(rq->das.das, new_val.das);
+		return true;
+	}
+
+	do {
+		old_val = READ_ONCE(rq->das);
+		if (old_val.state != old_state)
+			return false;
+		new_val = old_val;
+		new_val.deadline = new_time;
+		new_val.state = new_state;
+		if (new_state == MQ_RQ_IN_FLIGHT)
+			new_val.generation++;
+	} while (!blk_mq_set_rq_state(rq, old_val, new_val));
+
+	return true;
+}
+
 /**
  * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
  * @rq: target request.
  */
-static inline int blk_mq_rq_state(struct request *rq)
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
 {
-	return READ_ONCE(rq->gstate) & MQ_RQ_STATE_MASK;
+	return rq->das.state;
 }
 
 /**
- * blk_mq_rq_update_state() - set the current MQ_RQ_* state of a request
- * @rq: target request.
- * @state: new state to set.
+ * blk_mq_change_rq_state - atomically test and set request state
+ * @rq: Request pointer.
+ * @old_state: Old request state.
+ * @new_state: New request state.
  *
- * Set @rq's state to @state.  The caller is responsible for ensuring that
- * there are no other updaters.  A request can transition into IN_FLIGHT
- * only from IDLE and doing so increments the generation number.
+ * Returns %true if and only if the old state was @old and if the state has
+ * been changed into @new.
  */
-static inline void blk_mq_rq_update_state(struct request *rq,
-					  enum mq_rq_state state)
+static inline bool blk_mq_change_rq_state(struct request *rq,
+					  enum mq_rq_state old_state,
+					  enum mq_rq_state new_state)
 {
-	u64 old_val = READ_ONCE(rq->gstate);
-	u64 new_val = (old_val & ~MQ_RQ_STATE_MASK) | state;
-
-	if (state == MQ_RQ_IN_FLIGHT) {
-		WARN_ON_ONCE((old_val & MQ_RQ_STATE_MASK) != MQ_RQ_IDLE);
-		new_val += MQ_RQ_GEN_INC;
+	union blk_deadline_and_state das = READ_ONCE(rq->das);
+	union blk_deadline_and_state old_val = das;
+	union blk_deadline_and_state new_val = das;
+
+	old_val.state = old_state;
+	new_val.state = new_state;
+	if (new_state == MQ_RQ_IN_FLIGHT)
+		new_val.generation++;
+	/*
+	 * For transitions from state in-flight to another state cmpxchg64()
+	 * must be used. For other state transitions it is safe to use
+	 * WRITE_ONCE().
+	 */
+	if (old_state != MQ_RQ_IN_FLIGHT) {
+		WRITE_ONCE(rq->das.das, new_val.das);
+		return true;
 	}
-
-	/* avoid exposing interim values */
-	WRITE_ONCE(rq->gstate, new_val);
+	return blk_mq_set_rq_state(rq, old_val, new_val);
 }
 
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 652d4d4d3e97..549dfda7190c 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -162,8 +162,9 @@ void blk_abort_request(struct request *req)
 		 * immediately and that scan sees the new timeout value.
 		 * No need for fancy synchronizations.
 		 */
-		blk_rq_set_deadline(req, jiffies);
-		kblockd_schedule_work(&req->q->timeout_work);
+		if (blk_mq_rq_set_deadline(req, jiffies, MQ_RQ_IN_FLIGHT,
+					   MQ_RQ_IN_FLIGHT))
+			kblockd_schedule_work(&req->q->timeout_work);
 	} else {
 		if (blk_mark_rq_complete(req))
 			return;
@@ -184,52 +185,17 @@ unsigned long blk_rq_timeout(unsigned long timeout)
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
@@ -244,5 +210,56 @@ void blk_add_timer(struct request *req)
 		if (!timer_pending(&q->timeout) || (diff >= HZ / 2))
 			mod_timer(&q->timeout, expiry);
 	}
+}
+
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
+ * @old:	current request state.
+ * @new:	new request state.
+ *
+ * Sets the deadline of a request if and only if it has state @old and
+ * at the same time changes the request state from @old into @new. The caller
+ * must guarantee that the request state won't be modified while this function
+ * is in progress.
+ */
+void blk_mq_add_timer(struct request *req, enum mq_rq_state old,
+		      enum mq_rq_state new)
+{
+	struct request_queue *q = req->q;
+	unsigned long deadline;
+
+	if (!req->timeout)
+		req->timeout = q->rq_timeout;
+	deadline = jiffies + req->timeout;
+	if (!blk_mq_rq_set_deadline(req, deadline, old, new))
+		WARN_ON_ONCE(true);
+	return __blk_add_timer(req, deadline);
 }
diff --git a/block/blk.h b/block/blk.h
index eaf1a8e87d11..984367308b11 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -170,6 +170,8 @@ static inline bool bio_integrity_endio(struct bio *bio)
 void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
+void blk_mq_add_timer(struct request *req, enum mq_rq_state old,
+		      enum mq_rq_state new);
 void blk_delete_timer(struct request *);
 
 
@@ -191,21 +193,21 @@ void blk_account_io_done(struct request *req, u64 now);
 /*
  * EH timer and IO completion will both attempt to 'grab' the request, make
  * sure that only one of them succeeds. Steal the bottom bit of the
- * __deadline field for this.
+ * das field for this.
  */
 static inline int blk_mark_rq_complete(struct request *rq)
 {
-	return test_and_set_bit(0, &rq->__deadline);
+	return test_and_set_bit(0, &rq->das.legacy_deadline);
 }
 
 static inline void blk_clear_rq_complete(struct request *rq)
 {
-	clear_bit(0, &rq->__deadline);
+	clear_bit(0, &rq->das.legacy_deadline);
 }
 
 static inline bool blk_rq_is_complete(struct request *rq)
 {
-	return test_bit(0, &rq->__deadline);
+	return test_bit(0, &rq->das.legacy_deadline);
 }
 
 /*
@@ -314,12 +316,12 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
  */
 static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
 {
-	rq->__deadline = time & ~0x1UL;
+	rq->das.legacy_deadline = time & ~0x1UL;
 }
 
 static inline unsigned long blk_rq_deadline(struct request *rq)
 {
-	return rq->__deadline & ~0x1UL;
+	return rq->das.legacy_deadline & ~0x1UL;
 }
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f3999719f828..771dbdc8758c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,8 +27,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/seqlock.h>
-#include <linux/u64_stats_sync.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -125,15 +123,23 @@ typedef __u32 __bitwise req_flags_t;
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
 
+union blk_deadline_and_state {
+	struct {
+		uint32_t generation:30;
+		uint32_t state:2;
+		uint32_t deadline;
+	};
+	unsigned long legacy_deadline;
+	uint64_t das;
+};
+
 /*
  * Try to put the fields that are referenced together in the same cacheline.
  *
@@ -236,29 +242,24 @@ struct request {
 
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
+	union blk_deadline_and_state aborted_gstate;
+
+#ifndef CONFIG_ARCH_HAVE_CMPXCHG64
+	spinlock_t das_lock;
+#endif
 
-	/* access through blk_rq_set_deadline, blk_rq_deadline */
-	unsigned long __deadline;
+	/*
+	 * Access through blk_rq_deadline() and blk_rq_set_deadline(),
+	 * blk_mark_rq_complete(), blk_clear_rq_complete() and
+	 * blk_rq_is_complete() for legacy queues or blk_mq_rq_state(),
+	 * blk_mq_change_rq_state() and blk_mq_rq_set_deadline() for
+	 * blk-mq queues.
+	 */
+	union blk_deadline_and_state das;
 
 	struct list_head timeout_list;
 
-- 
2.16.3
