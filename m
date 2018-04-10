Return-Path: <prvs=63144aee1=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	stable@vger.kernel.org
Subject: [PATCH v4] blk-mq: Fix race conditions in request timeout handling
Date: Mon,  9 Apr 2018 18:34:55 -0700
Message-Id: <20180410013455.7448-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

If a completion occurs after blk_mq_rq_timed_out() has reset
rq->aborted_gstate and the request is again in flight when the timeout
expires then a request will be completed twice: a first time by the
timeout handler and a second time when the regular completion occurs.

Additionally, the blk-mq timeout handling code ignores completions that
occur after blk_mq_check_expired() has been called and before
blk_mq_rq_timed_out() has reset rq->aborted_gstate. If a block driver
timeout handler always returns BLK_EH_RESET_TIMER then the result will
be that the request never terminates.

Since the request state can be updated from two different contexts,
namely regular completion and request timeout, this race cannot be
fixed with RCU synchronization only. Fix this race as follows:
- Split __deadline in two variables, namely lq_deadline for legacy
  request queues and mq_deadline for blk-mq request queues. Use atomic
  operations to update mq_deadline.
- Use the deadline instead of the request generation to detect whether
  or not a request timer fired after reinitialization of a request.
- Store the request state in the lowest two bits of the deadline instead
  of the lowest two bits of 'gstate'.
- Remove all request member variables that became superfluous due to
  this change: gstate, aborted_gstate, gstate_seq and aborted_gstate_sync.
- Remove the request state information that became superfluous due to this
  patch, namely RQF_MQ_TIMEOUT_EXPIRED.
- Remove the hctx member that became superfluous due to these changes,
  namely nr_expired.
- Remove the code that became superfluous due to this change, namely
  the RCU lock and unlock statements in blk_mq_complete_request() and
  also the synchronize_rcu() call in the timeout handler.

This patch fixes the following kernel crashes:

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

This patch also fixes a double completion problem in the NVMeOF
initiator driver. See also http://lists.infradead.org/pipermail/linux-nvme/2018-February/015848.html.

Fixes: 1d9bd5161ba3 ("blk-mq: replace timeout synchronization with a RCU and generation based scheme")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Israel Rukshin <israelr@mellanox.com>,
Cc: Max Gurtovoy <maxg@mellanox.com>
Cc: <stable@vger.kernel.org> # v4.16
---

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

 block/blk-core.c       |   2 -
 block/blk-mq-debugfs.c |   1 -
 block/blk-mq.c         | 166 +++----------------------------------------------
 block/blk-mq.h         |  47 ++++++++------
 block/blk-timeout.c    |  57 ++++++++++++-----
 block/blk.h            |  41 ++++++++++--
 include/linux/blk-mq.h |   1 -
 include/linux/blkdev.h |  32 +++-------
 8 files changed, 122 insertions(+), 225 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 0c48bef8490f..422b79b61bb9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -200,8 +200,6 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->start_time = jiffies;
 	set_start_time_ns(rq);
 	rq->part = NULL;
-	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6f72413b6cab..80c7c585769f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -345,7 +345,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
 	RQF_NAME(ZONE_WRITE_LOCKED),
-	RQF_NAME(MQ_TIMEOUT_EXPIRED),
 	RQF_NAME(MQ_POLL_SLEPT),
 };
 #undef RQF_NAME
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7816d28b7219..337e10a5a30c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -305,7 +305,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->special = NULL;
 	/* tag was already set */
 	rq->extra_len = 0;
-	rq->__deadline = 0;
 
 	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->timeout = 0;
@@ -527,8 +526,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
-	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT);
-	blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE);
+	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
@@ -577,36 +575,6 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
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
@@ -618,27 +586,12 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
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
 
@@ -662,27 +615,8 @@ void blk_mq_start_request(struct request *rq)
 		wbt_issue(q->rq_wb, &rq->issue_stat);
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
+	/* Mark @rq in-flight and set its deadline. */
+	blk_mq_add_timer(rq, MQ_RQ_IDLE, MQ_RQ_IN_FLIGHT);
 
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
@@ -695,11 +629,6 @@ void blk_mq_start_request(struct request *rq)
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
@@ -811,7 +740,6 @@ EXPORT_SYMBOL(blk_mq_tag_to_rq);
 struct blk_mq_timeout_data {
 	unsigned long next;
 	unsigned int next_set;
-	unsigned int nr_expired;
 };
 
 static void blk_mq_rq_timed_out(struct request *req, bool reserved)
@@ -819,8 +747,6 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
 
-	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
-
 	if (ops->timeout)
 		ret = ops->timeout(req, reserved);
 
@@ -829,13 +755,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
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
@@ -849,60 +769,23 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
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
+	unsigned long deadline = blk_mq_rq_deadline(rq);
 
-	/* if in-flight && overdue, mark for abortion */
-	if ((gstate & MQ_RQ_STATE_MASK) == MQ_RQ_IN_FLIGHT &&
-	    time_after_eq(jiffies, deadline)) {
-		blk_mq_rq_update_aborted_gstate(rq, gstate);
-		data->nr_expired++;
-		hctx->nr_expired++;
+	if (time_after_eq(jiffies, deadline) &&
+	    blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE)) {
+		blk_mq_rq_timed_out(rq, reserved);
 	} else if (!data->next_set || time_after(data->next, deadline)) {
 		data->next = deadline;
 		data->next_set = 1;
 	}
-}
 
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
-		blk_mq_rq_timed_out(rq, reserved);
 }
 
 static void blk_mq_timeout_work(struct work_struct *work)
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
 
@@ -925,33 +808,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
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
@@ -2087,8 +1943,6 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			return ret;
 	}
 
-	seqcount_init(&rq->gstate_seq);
-	u64_stats_init(&rq->aborted_gstate_sync);
 	return 0;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 88c558f71819..4f96fd66eb8a 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -27,10 +27,7 @@ struct blk_mq_ctx {
 	struct kobject		kobj;
 } ____cacheline_aligned_in_smp;
 
-/*
- * Bits for request->gstate.  The lower two bits carry MQ_RQ_* state value
- * and the upper bits the generation number.
- */
+/* Lowest two bits of request->mq_deadline. */
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
 	MQ_RQ_IN_FLIGHT		= 1,
@@ -38,7 +35,6 @@ enum mq_rq_state {
 
 	MQ_RQ_STATE_BITS	= 2,
 	MQ_RQ_STATE_MASK	= (1 << MQ_RQ_STATE_BITS) - 1,
-	MQ_RQ_GEN_INC		= 1 << MQ_RQ_STATE_BITS,
 };
 
 void blk_mq_freeze_queue(struct request_queue *q);
@@ -104,9 +100,30 @@ void blk_mq_release(struct request_queue *q);
  * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
  * @rq: target request.
  */
-static inline int blk_mq_rq_state(struct request *rq)
+static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
 {
-	return READ_ONCE(rq->gstate) & MQ_RQ_STATE_MASK;
+	return atomic_long_read(&rq->mq_deadline) & MQ_RQ_STATE_MASK;
+}
+
+/**
+ * blk_mq_change_rq_state - atomically test and set request state
+ * @rq: Request pointer.
+ * @old: Old request state.
+ * @new: New request state.
+ *
+ * Returns %true if and only if the old state was @old and if the state has
+ * been changed into @new.
+ */
+static inline bool blk_mq_change_rq_state(struct request *rq,
+					  enum mq_rq_state old_s,
+					  enum mq_rq_state new_s)
+{
+	unsigned long old_d = (atomic_long_read(&rq->mq_deadline) &
+			       ~(unsigned long)MQ_RQ_STATE_MASK) | old_s;
+	unsigned long new_d = (old_d & ~(unsigned long)MQ_RQ_STATE_MASK) |
+			      new_s;
+
+	return atomic_long_cmpxchg(&rq->mq_deadline, old_d, new_d) == old_d;
 }
 
 /**
@@ -114,23 +131,13 @@ static inline int blk_mq_rq_state(struct request *rq)
  * @rq: target request.
  * @state: new state to set.
  *
- * Set @rq's state to @state.  The caller is responsible for ensuring that
- * there are no other updaters.  A request can transition into IN_FLIGHT
- * only from IDLE and doing so increments the generation number.
+ * Set @rq's state to @state.
  */
 static inline void blk_mq_rq_update_state(struct request *rq,
-					  enum mq_rq_state state)
+					  enum mq_rq_state new_s)
 {
-	u64 old_val = READ_ONCE(rq->gstate);
-	u64 new_val = (old_val & ~MQ_RQ_STATE_MASK) | state;
-
-	if (state == MQ_RQ_IN_FLIGHT) {
-		WARN_ON_ONCE((old_val & MQ_RQ_STATE_MASK) != MQ_RQ_IDLE);
-		new_val += MQ_RQ_GEN_INC;
+	while (!blk_mq_change_rq_state(rq, blk_mq_rq_state(rq), new_s)) {
 	}
-
-	/* avoid exposing interim values */
-	WRITE_ONCE(rq->gstate, new_val);
 }
 
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 50a191720055..3ca829dce2d6 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -165,8 +165,9 @@ void blk_abort_request(struct request *req)
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
@@ -187,15 +188,8 @@ unsigned long blk_rq_timeout(unsigned long timeout)
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
+static void __blk_add_timer(struct request *req, enum mq_rq_state old,
+			    enum mq_rq_state new)
 {
 	struct request_queue *q = req->q;
 	unsigned long expiry;
@@ -216,15 +210,17 @@ void blk_add_timer(struct request *req)
 	if (!req->timeout)
 		req->timeout = q->rq_timeout;
 
-	blk_rq_set_deadline(req, jiffies + req->timeout);
-	req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
-
 	/*
 	 * Only the non-mq case needs to add the request to a protected list.
 	 * For the mq case we simply scan the tag map.
 	 */
-	if (!q->mq_ops)
+	if (!q->mq_ops) {
+		blk_rq_set_deadline(req, jiffies + req->timeout);
 		list_add_tail(&req->timeout_list, &req->q->timeout_list);
+	} else {
+		WARN_ON_ONCE(!blk_mq_rq_set_deadline(req, jiffies +
+						     req->timeout, old, new));
+	}
 
 	/*
 	 * If the timer isn't already pending or this timeout is earlier
@@ -249,3 +245,34 @@ void blk_add_timer(struct request *req)
 	}
 
 }
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
+	return __blk_add_timer(req, MQ_RQ_IDLE/*ignored*/,
+			       MQ_RQ_IDLE/*ignored*/);
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
+	return __blk_add_timer(req, old, new);
+}
diff --git a/block/blk.h b/block/blk.h
index b034fd2460c4..7665d4af777e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -170,6 +170,8 @@ static inline bool bio_integrity_endio(struct bio *bio)
 void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
+void blk_mq_add_timer(struct request *req, enum mq_rq_state old,
+		      enum mq_rq_state new);
 void blk_delete_timer(struct request *);
 
 
@@ -191,21 +193,21 @@ void blk_account_io_done(struct request *req);
 /*
  * EH timer and IO completion will both attempt to 'grab' the request, make
  * sure that only one of them succeeds. Steal the bottom bit of the
- * __deadline field for this.
+ * lq_deadline field for this.
  */
 static inline int blk_mark_rq_complete(struct request *rq)
 {
-	return test_and_set_bit(0, &rq->__deadline);
+	return test_and_set_bit(0, &rq->lq_deadline);
 }
 
 static inline void blk_clear_rq_complete(struct request *rq)
 {
-	clear_bit(0, &rq->__deadline);
+	clear_bit(0, &rq->lq_deadline);
 }
 
 static inline bool blk_rq_is_complete(struct request *rq)
 {
-	return test_bit(0, &rq->__deadline);
+	return test_bit(0, &rq->lq_deadline);
 }
 
 /*
@@ -311,15 +313,42 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
  * Steal a bit from this field for legacy IO path atomic IO marking. Note that
  * setting the deadline clears the bottom bit, potentially clearing the
  * completed bit. The user has to be OK with this (current ones are fine).
+ * Must be called with the request queue lock held.
  */
 static inline void blk_rq_set_deadline(struct request *rq, unsigned long time)
 {
-	rq->__deadline = time & ~0x1UL;
+	rq->lq_deadline = time & ~0x1UL;
 }
 
 static inline unsigned long blk_rq_deadline(struct request *rq)
 {
-	return rq->__deadline & ~0x1UL;
+	return rq->lq_deadline & ~0x1UL;
+}
+
+/*
+ * If the state of request @rq equals @old_s, update deadline and request state
+ * atomically to @time and @new_s. blk-mq only.
+ */
+static inline bool blk_mq_rq_set_deadline(struct request *rq,
+					  unsigned long time,
+					  enum mq_rq_state old_s,
+					  enum mq_rq_state new_s)
+{
+	unsigned long old_d, new_d;
+
+	do {
+		old_d = atomic_long_read(&rq->mq_deadline);
+		if ((old_d & MQ_RQ_STATE_MASK) != old_s)
+			return false;
+		new_d = (time & ~0x3UL) | (new_s & 3UL);
+	} while (atomic_long_cmpxchg(&rq->mq_deadline, old_d, new_d) != old_d);
+
+	return true;
+}
+
+static inline unsigned long blk_mq_rq_deadline(struct request *rq)
+{
+	return atomic_long_read(&rq->mq_deadline) & ~0x3UL;
 }
 
 /*
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8efcf49796a3..13ccbb418e89 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -51,7 +51,6 @@ struct blk_mq_hw_ctx {
 	unsigned int		queue_num;
 
 	atomic_t		nr_active;
-	unsigned int		nr_expired;
 
 	struct hlist_node	cpuhp_dead;
 	struct kobject		kobj;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6075d1a6760c..abf78819014b 100644
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
 
@@ -226,28 +223,15 @@ struct request {
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
+	 * Access through blk_rq_set_deadline(), blk_rq_deadline() and
+	 * blk_mark_rq_complete(), blk_clear_rq_complete() and
+	 * blk_rq_is_complete() for legacy queues or blk_mq_rq_set_deadline(),
+	 * blk_mq_rq_deadline() and blk_mq_rq_state() for blk-mq queues.
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
-	unsigned long __deadline;
+	union {
+		unsigned long lq_deadline;
+		atomic_long_t mq_deadline;
+	};
 
 	struct list_head timeout_list;
 
-- 
2.16.2
