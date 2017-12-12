Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	kernel-team@fb.com,
	osandov@fb.com,
	linux-block@vger.kernel.org,
	hch@lst.de,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] blk-mq: remove REQ_ATOM_STARTED
Date: Tue, 12 Dec 2017 11:01:34 -0800
Message-Id: <20171212190134.535941-7-tj@kernel.org>
In-Reply-To: <20171212190134.535941-1-tj@kernel.org>
References: <20171212190134.535941-1-tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>

After the recent updates to use generation number and state based
synchronization, we can easily replace REQ_ATOM_STARTED usages by
adding an extra state to distinguish completed but not yet freed
state.

Add MQ_RQ_COMPLETE and replace REQ_ATOM_STARTED usages with
blk_mq_rq_state() tests.  REQ_ATOM_STARTED no longer has any users
left and is removed.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-mq-debugfs.c |  4 +---
 block/blk-mq.c         | 39 ++++++++-------------------------------
 block/blk-mq.h         |  1 +
 block/blk.h            |  1 -
 4 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b56a4f3..8adc837 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -271,7 +271,6 @@ static const char *const cmd_flag_name[] = {
 #define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
 static const char *const rqf_name[] = {
 	RQF_NAME(SORTED),
-	RQF_NAME(STARTED),
 	RQF_NAME(QUEUED),
 	RQF_NAME(SOFTBARRIER),
 	RQF_NAME(FLUSH_SEQ),
@@ -295,7 +294,6 @@ static const char *const rqf_name[] = {
 #define RQAF_NAME(name) [REQ_ATOM_##name] = #name
 static const char *const rqaf_name[] = {
 	RQAF_NAME(COMPLETE),
-	RQAF_NAME(STARTED),
 	RQAF_NAME(POLL_SLEPT),
 };
 #undef RQAF_NAME
@@ -409,7 +407,7 @@ static void hctx_show_busy_rq(struct request *rq, void *data, bool reserved)
 	const struct show_busy_params *params = data;
 
 	if (blk_mq_map_queue(rq->q, rq->mq_ctx->cpu) == params->hctx &&
-	    test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
+	    blk_mq_rq_state(rq) != MQ_RQ_IDLE)
 		__blk_mq_debugfs_rq_show(params->m,
 					 list_entry_rq(&rq->queuelist));
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7269552..bf53132 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -482,7 +482,7 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
-	clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
+	blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
 	clear_bit(REQ_ATOM_POLL_SLEPT, &rq->atomic_flags);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
@@ -530,7 +530,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	int cpu;
 
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT);
-	blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
+	blk_mq_rq_update_state(rq, MQ_RQ_COMPLETE);
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
@@ -610,7 +610,7 @@ EXPORT_SYMBOL(blk_mq_complete_request);
 
 int blk_mq_request_started(struct request *rq)
 {
-	return test_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
+	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
 }
 EXPORT_SYMBOL_GPL(blk_mq_request_started);
 
@@ -629,7 +629,6 @@ void blk_mq_start_request(struct request *rq)
 	}
 
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
-	WARN_ON_ONCE(test_bit(REQ_ATOM_STARTED, &rq->atomic_flags));
 
 	/*
 	 * Mark @rq in-flight which also advances the generation number,
@@ -647,8 +646,6 @@ void blk_mq_start_request(struct request *rq)
 	blk_add_timer(rq);
 	write_seqcount_end(&rq->gstate_seq);
 
-	set_bit(REQ_ATOM_STARTED, &rq->atomic_flags);
-
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
 		 * Make sure space for the drain appears.  We know we can do
@@ -661,13 +658,9 @@ void blk_mq_start_request(struct request *rq)
 EXPORT_SYMBOL(blk_mq_start_request);
 
 /*
- * When we reach here because queue is busy, REQ_ATOM_COMPLETE
- * flag isn't set yet, so there may be race with timeout handler,
- * but given rq->deadline is just set in .queue_rq() under
- * this situation, the race won't be possible in reality because
- * rq->timeout should be set as big enough to cover the window
- * between blk_mq_start_request() called from .queue_rq() and
- * clearing REQ_ATOM_STARTED here.
+ * When we reach here because queue is busy, it's safe to change the state
+ * to IDLE without checking @rq->aborted_gstate because we should still be
+ * holding the RCU read lock and thus protected against timeout.
  */
 static void __blk_mq_requeue_request(struct request *rq)
 {
@@ -679,7 +672,7 @@ static void __blk_mq_requeue_request(struct request *rq)
 	wbt_requeue(q->rq_wb, &rq->issue_stat);
 	blk_mq_sched_requeue_request(rq);
 
-	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
+	if (blk_mq_rq_state(rq) != MQ_RQ_IDLE) {
 		blk_mq_rq_update_state(rq, MQ_RQ_IDLE);
 		if (q->dma_drain_size && blk_rq_bytes(rq))
 			rq->nr_phys_segments--;
@@ -786,18 +779,6 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 	const struct blk_mq_ops *ops = req->q->mq_ops;
 	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
 
-	/*
-	 * We know that complete is set at this point. If STARTED isn't set
-	 * anymore, then the request isn't active and the "timeout" should
-	 * just be ignored. This can happen due to the bitflag ordering.
-	 * Timeout first checks if STARTED is set, and if it is, assumes
-	 * the request is active. But if we race with completion, then
-	 * both flags will get cleared. So check here again, and ignore
-	 * a timeout event with a request that isn't active.
-	 */
-	if (!test_bit(REQ_ATOM_STARTED, &req->atomic_flags))
-		return;
-
 	if (ops->timeout)
 		ret = ops->timeout(req, reserved);
 
@@ -831,9 +812,6 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	unsigned long gstate, deadline;
 	int start;
 
-	if (!test_bit(REQ_ATOM_STARTED, &rq->atomic_flags))
-		return;
-
 	/* read coherent snapshots of @rq->state_gen and @rq->deadline */
 	do {
 		start = read_seqcount_begin(&rq->gstate_seq);
@@ -2951,8 +2929,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 
 	hrtimer_init_sleeper(&hs, current);
 	do {
-		if (test_bit(REQ_ATOM_STARTED, &rq->atomic_flags) &&
-		    blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
+		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		hrtimer_start_expires(&hs.timer, mode);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 1fa83fa..523cad0 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -34,6 +34,7 @@ struct blk_mq_ctx {
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
 	MQ_RQ_IN_FLIGHT		= 1,
+	MQ_RQ_COMPLETE		= 2,
 
 	MQ_RQ_STATE_BITS	= 2,
 	MQ_RQ_STATE_MASK	= (1 << MQ_RQ_STATE_BITS) - 1,
diff --git a/block/blk.h b/block/blk.h
index 9cb2739..a68dbe3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -124,7 +124,6 @@ void blk_account_io_done(struct request *req);
  */
 enum rq_atomic_flags {
 	REQ_ATOM_COMPLETE = 0,
-	REQ_ATOM_STARTED,
 
 	REQ_ATOM_POLL_SLEPT,
 };
-- 
2.9.5
