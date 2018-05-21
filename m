Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Date: Mon, 21 May 2018 17:11:31 -0600
Message-Id: <20180521231131.6685-4-keith.busch@intel.com>
In-Reply-To: <20180521231131.6685-1-keith.busch@intel.com>
References: <20180521231131.6685-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This patch simplifies the timeout handling by relying on the request
reference counting to ensure the iterator is operating on an inflight
and truly timed out request. Since the reference counting prevents the
tag from being reallocated, the block layer no longer needs to prevent
drivers from completing their requests while the timeout handler is
operating on it: a driver completing a request is allowed to proceed to
the next state without additional syncronization with the block layer.

This also removes any need for generation sequence numbers since the
request lifetime is prevented from being reallocated as a new sequence
while timeout handling is operating on it.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-core.c       |   6 --
 block/blk-mq-debugfs.c |   1 -
 block/blk-mq.c         | 259 ++++++++++---------------------------------------
 block/blk-mq.h         |  20 +---
 block/blk-timeout.c    |   1 -
 include/linux/blkdev.h |  26 +----
 6 files changed, 58 insertions(+), 255 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 43370faee935..cee03cad99f2 100644
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
index 66e5c768803f..4858876fd364 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -589,56 +589,6 @@ static void __blk_mq_complete_request(struct request *rq)
 	put_cpu();
 }
 
-static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
-	__releases(hctx->srcu)
-{
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
-		rcu_read_unlock();
-	else
-		srcu_read_unlock(hctx->srcu, srcu_idx);
-}
-
-static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
-	__acquires(hctx->srcu)
-{
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		/* shut up gcc false positive */
-		*srcu_idx = 0;
-		rcu_read_lock();
-	} else
-		*srcu_idx = srcu_read_lock(hctx->srcu);
-}
-
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
@@ -650,27 +600,10 @@ static u64 blk_mq_rq_aborted_gstate(struct request *rq)
 void blk_mq_complete_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
-	int srcu_idx;
 
 	if (unlikely(blk_should_fake_timeout(q)))
 		return;
-
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
+	__blk_mq_complete_request(rq);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
@@ -699,26 +632,9 @@ void blk_mq_start_request(struct request *rq)
 
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
 
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
 	blk_add_timer(rq);
 	blk_mq_rq_update_state(rq, MQ_RQ_IN_FLIGHT);
 
-	write_seqcount_end(&rq->gstate_seq);
-	preempt_enable();
-
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
 		 * Make sure space for the drain appears.  We know we can do
@@ -730,11 +646,6 @@ void blk_mq_start_request(struct request *rq)
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
@@ -843,33 +754,24 @@ struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 }
 EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
-struct blk_mq_timeout_data {
-	unsigned long next;
-	unsigned int next_set;
-	unsigned int nr_expired;
-};
-
 static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
 
-	req->rq_flags |= RQF_MQ_TIMEOUT_EXPIRED;
-
 	if (ops->timeout)
 		ret = ops->timeout(req, reserved);
 
 	switch (ret) {
 	case BLK_EH_HANDLED:
-		__blk_mq_complete_request(req);
-		break;
-	case BLK_EH_RESET_TIMER:
 		/*
-		 * As nothing prevents from completion happening while
-		 * ->aborted_gstate is set, this may lead to ignored
-		 * completions and further spurious timeouts.
+		 * If the request is still in flight, the driver is requesting
+		 * blk-mq complete it.
 		 */
-		blk_mq_rq_update_aborted_gstate(req, 0);
+		if (blk_mq_rq_state(req) == MQ_RQ_IN_FLIGHT)
+			__blk_mq_complete_request(req);
+		break;
+	case BLK_EH_RESET_TIMER:
 		blk_add_timer(req);
 		break;
 	case BLK_EH_NOT_HANDLED:
@@ -880,64 +782,64 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 	}
 }
 
-static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, void *priv, bool reserved)
+static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 {
-	struct blk_mq_timeout_data *data = priv;
-	unsigned long gstate, deadline;
-	int start;
+	unsigned long deadline;
 
-	might_sleep();
-
-	if (rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED)
-		return;
+	if (blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
+		return false;
 
-	/* read coherent snapshots of @rq->state_gen and @rq->deadline */
-	while (true) {
-		start = read_seqcount_begin(&rq->gstate_seq);
-		gstate = READ_ONCE(rq->gstate);
-		deadline = blk_rq_deadline(rq);
-		if (!read_seqcount_retry(&rq->gstate_seq, start))
-			break;
-		cond_resched();
-	}
+	deadline = blk_rq_deadline(rq);
+	if (time_after_eq(jiffies, deadline))
+		return true;
 
-	/* if in-flight && overdue, mark for abortion */
-	if ((gstate & MQ_RQ_STATE_MASK) == MQ_RQ_IN_FLIGHT &&
-	    time_after_eq(jiffies, deadline)) {
-		blk_mq_rq_update_aborted_gstate(rq, gstate);
-		data->nr_expired++;
-		hctx->nr_expired++;
-	} else if (!data->next_set || time_after(data->next, deadline)) {
-		data->next = deadline;
-		data->next_set = 1;
-	}
+	if (*next == 0)
+		*next = deadline;
+	else if (time_after(*next, deadline))
+		*next = deadline;
+	return false;
 }
 
-static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
+static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
+	unsigned long *next = priv;
+
 	/*
-	 * We marked @rq->aborted_gstate and waited for RCU.  If there were
-	 * completions that we lost to, they would have finished and
-	 * updated @rq->gstate by now; otherwise, the completion path is
-	 * now guaranteed to see @rq->aborted_gstate and yield.  If
-	 * @rq->aborted_gstate still matches @rq->gstate, @rq is ours.
+	 * Just do a quick check if it is expired before locking the request in
+	 * so we're not unnecessarilly synchronizing across CPUs.
 	 */
-	if (!(rq->rq_flags & RQF_MQ_TIMEOUT_EXPIRED) &&
-	    READ_ONCE(rq->gstate) == rq->aborted_gstate)
+	if (!blk_mq_req_expired(rq, next))
+		return;
+
+	/*
+	 * We have reason to believe the request may be expired. Take a
+	 * reference on the request to lock this request lifetime into its
+	 * currently allocated context to prevent it from being reallocated in
+	 * the event the completion by-passes this timeout handler.
+	 * 
+	 * If the reference was already released, then the driver beat the
+	 * timeout handler to posting a natural completion.
+	 */
+	if (!kref_get_unless_zero(&rq->ref))
+		return;
+
+	/*
+	 * The request is now locked and cannot be reallocated underneath the
+	 * timeout handler's processing. Re-verify this exact request is truly
+	 * expired; if it is not expired, then the request was completed and
+	 * reallocated as a new request.
+	 */
+	if (blk_mq_req_expired(rq, next))
 		blk_mq_rq_timed_out(rq, reserved);
+	blk_mq_put_request(rq);
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
+	unsigned long next = 0;
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
@@ -957,39 +859,10 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	/* scan for the expired ones and set their ->aborted_gstate */
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
 
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
-	if (data.next_set) {
-		data.next = blk_rq_timeout(round_jiffies_up(data.next));
-		mod_timer(&q->timeout, data.next);
+	if (next != 0) {
+		mod_timer(&q->timeout, next);
 	} else {
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If
@@ -1334,8 +1207,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
-	int srcu_idx;
-
 	/*
 	 * We should be running this queue from one of the CPUs that
 	 * are mapped to it.
@@ -1369,9 +1240,7 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-	hctx_lock(hctx, &srcu_idx);
 	blk_mq_sched_dispatch_requests(hctx);
-	hctx_unlock(hctx, srcu_idx);
 }
 
 static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
@@ -1458,7 +1327,6 @@ EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
 
 bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
-	int srcu_idx;
 	bool need_run;
 
 	/*
@@ -1469,10 +1337,8 @@ bool blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
 	 * quiesced.
 	 */
-	hctx_lock(hctx, &srcu_idx);
 	need_run = !blk_queue_quiesced(hctx->queue) &&
 		blk_mq_hctx_has_pending(hctx);
-	hctx_unlock(hctx, srcu_idx);
 
 	if (need_run) {
 		__blk_mq_delay_run_hw_queue(hctx, async, 0);
@@ -1828,34 +1694,23 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, blk_qc_t *cookie)
 {
 	blk_status_t ret;
-	int srcu_idx;
 
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
 
-	hctx_lock(hctx, &srcu_idx);
-
 	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
 		blk_mq_sched_insert_request(rq, false, true, false);
 	else if (ret != BLK_STS_OK)
 		blk_mq_end_request(rq, ret);
-
-	hctx_unlock(hctx, srcu_idx);
 }
 
 blk_status_t blk_mq_request_issue_directly(struct request *rq)
 {
-	blk_status_t ret;
-	int srcu_idx;
 	blk_qc_t unused_cookie;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, ctx->cpu);
 
-	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
-	hctx_unlock(hctx, srcu_idx);
-
-	return ret;
+	return __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
 }
 
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
@@ -2065,15 +1920,7 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
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
+	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	return 0;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e1bb420dc5d6..53452df16343 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -31,17 +31,12 @@ struct blk_mq_ctx {
 } ____cacheline_aligned_in_smp;
 
 /*
- * Bits for request->gstate.  The lower two bits carry MQ_RQ_* state value
- * and the upper bits the generation number.
+ * Request state.
  */
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
@@ -109,7 +104,7 @@ void blk_mq_release(struct request_queue *q);
  */
 static inline int blk_mq_rq_state(struct request *rq)
 {
-	return READ_ONCE(rq->gstate) & MQ_RQ_STATE_MASK;
+	return READ_ONCE(rq->state);
 }
 
 /**
@@ -124,16 +119,7 @@ static inline int blk_mq_rq_state(struct request *rq)
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
-
-	/* avoid exposing interim values */
-	WRITE_ONCE(rq->gstate, new_val);
+	WRITE_ONCE(rq->state, state);
 }
 
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 652d4d4d3e97..f95d6e6cbc96 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -214,7 +214,6 @@ void blk_add_timer(struct request *req)
 		req->timeout = q->rq_timeout;
 
 	blk_rq_set_deadline(req, jiffies + req->timeout);
-	req->rq_flags &= ~RQF_MQ_TIMEOUT_EXPIRED;
 
 	/*
 	 * Only the non-mq case needs to add the request to a protected list.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 26bf2c1e3502..8812a7e3c0a3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -125,10 +125,8 @@ typedef __u32 __bitwise req_flags_t;
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
@@ -236,27 +234,7 @@ struct request {
 
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
-	/*
-	 * ->aborted_gstate is used by the timeout to claim a specific
-	 * recycle instance of this request.  See blk_mq_timeout_work().
-	 */
-	struct u64_stats_sync aborted_gstate_sync;
-	u64 aborted_gstate;
-
+	u64 state;
 	struct kref ref;
 
 	/* access through blk_rq_set_deadline, blk_rq_deadline */
-- 
2.14.3
