Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29752 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388708AbeG1AUZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 20:20:25 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 5/5] blk-mq: Rework blk-mq timeout handling again
Date: Fri, 27 Jul 2018 15:56:20 -0700
Message-Id: <20180727225620.17855-6-bart.vanassche@wdc.com>
In-Reply-To: <20180727225620.17855-1-bart.vanassche@wdc.com>
References: <20180727225620.17855-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Recently the blk-mq timeout handling code was reworked to avoid that
completions that occur while a timeout handler is in progress get
ignored. That rework moved the protection against completions that occur
while a timeout handler is in progress from the block layer into the
SCSI core. Move that protection back into the block layer core by
introducing two new request states, namely MQ_RQ_COMPLETION_DELAYED and
MQ_RQ_TIMED_OUT.

Other changes in this patch are:
- If blk_mq_complete_request() is called from inside the request timed
  out function, complete the request immediately. Otherwise delay
  request completion until the request timeout handler has finished.
- Reintroduce the request generation number to avoid that request
  timeout handling happens after a request has already completed.
- Reintroduce deadline_seq to make reads and updates of the request
  deadline possible without having to use atomic instructions.
- Remove the request state information that became superfluous due to
  this patch, namely the RQF_TIMED_OUT flag and the ref member.
- Atomic instructions are only used to update the request state if
  a concurrent request state change could be in progress.

This patch reverts the following two commits:
* 0fc09f920983 ("blk-mq: export setting request completion state")
* 065990bd198e ("scsi: set timed out out mq requests to complete")

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          |   3 +
 block/blk-mq-debugfs.c    |   8 +-
 block/blk-mq.c            | 329 ++++++++++++++++++++++++++++----------
 block/blk-mq.h            |  10 +-
 block/blk-timeout.c       |  28 +++-
 drivers/scsi/scsi_error.c |  14 --
 include/linux/blk-mq.h    |  14 --
 include/linux/blkdev.h    |  56 ++++++-
 8 files changed, 332 insertions(+), 130 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 03a4ea93a5f3..3c63e410ede4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -198,6 +198,9 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->internal_tag = -1;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
+#ifndef CONFIG_64BIT
+	seqcount_init(&rq->deadline_seq);
+#endif
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cb1e6cf7ac48..99732f6ec592 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -334,9 +334,11 @@ static const char *const rqf_name[] = {
 #undef RQF_NAME
 
 static const char *const blk_mq_rq_state_name_array[] = {
-	[MQ_RQ_IDLE]		= "idle",
-	[MQ_RQ_IN_FLIGHT]	= "in_flight",
-	[MQ_RQ_COMPLETE]	= "complete",
+	[MQ_RQ_IDLE]			= "idle",
+	[MQ_RQ_IN_FLIGHT]		= "in flight",
+	[MQ_RQ_COMPLETE]		= "complete",
+	[MQ_RQ_COMPLETION_DELAYED]	= "completion delayed",
+	[MQ_RQ_TIMED_OUT]		= "timed out",
 };
 
 static const char *blk_mq_rq_state_name(enum mq_rq_state rq_state)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 670f8960b88a..3fd654655610 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -6,6 +6,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/atomic.h>	/* cmpxchg() */
 #include <linux/backing-dev.h>
 #include <linux/bio.h>
 #include <linux/blkdev.h>
@@ -322,6 +323,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 
 	INIT_LIST_HEAD(&rq->timeout_list);
 	rq->timeout = 0;
+	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
 
 	rq->end_io = NULL;
 	rq->end_io_data = NULL;
@@ -332,7 +334,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 #endif
 
 	data->ctx->rq_dispatched[op_is_sync(op)]++;
-	refcount_set(&rq->ref, 1);
 	return rq;
 }
 
@@ -466,19 +467,43 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-static void __blk_mq_free_request(struct request *rq)
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
 {
-	struct request_queue *q = rq->q;
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
-	const int sched_tag = rq->internal_tag;
+	union blk_generation_and_state old_val = READ_ONCE(rq->gstate);
+	union blk_generation_and_state new_val = old_val;
 
-	if (rq->tag != -1)
-		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
-	if (sched_tag != -1)
-		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
-	blk_mq_sched_restart(hctx);
-	blk_queue_exit(q);
+	old_val.state = old_state;
+	new_val.state = new_state;
+	if (new_state == MQ_RQ_IN_FLIGHT)
+		new_val.generation++;
+	/*
+	 * For transitions from state in-flight or timed out to another state
+	 * cmpxchg() must be used. For other state transitions it is safe to
+	 * use WRITE_ONCE().
+	 */
+	switch (old_state) {
+	case MQ_RQ_IN_FLIGHT:
+	case MQ_RQ_TIMED_OUT:
+		return blk_mq_set_rq_state(rq, old_val, new_val);
+	case MQ_RQ_IDLE:
+	case MQ_RQ_COMPLETE:
+	case MQ_RQ_COMPLETION_DELAYED:
+		WRITE_ONCE(rq->gstate.val, new_val.val);
+		return true;
+	}
+	WARN(true, "Invalid request state %d\n", old_state);
+	return false;
 }
 
 void blk_mq_free_request(struct request *rq)
@@ -487,6 +512,7 @@ void blk_mq_free_request(struct request *rq)
 	struct elevator_queue *e = q->elevator;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
+	const int sched_tag = rq->internal_tag;
 
 	if (rq->rq_flags & RQF_ELVPRIV) {
 		if (e && e->type->ops.mq.finish_request)
@@ -509,9 +535,14 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
-	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
-	if (refcount_dec_and_test(&rq->ref))
-		__blk_mq_free_request(rq);
+	if (!blk_mq_change_rq_state(rq, blk_mq_rq_state(rq), MQ_RQ_IDLE))
+		WARN_ON_ONCE(true);
+	if (rq->tag != -1)
+		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
+	if (sched_tag != -1)
+		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
+	blk_mq_sched_restart(hctx);
+	blk_queue_exit(q);
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
@@ -558,8 +589,8 @@ static void __blk_mq_complete_request(struct request *rq)
 	bool shared = false;
 	int cpu;
 
-	if (!blk_mq_mark_complete(rq))
-		return;
+	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
+
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
 
@@ -613,9 +644,47 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
  **/
 void blk_mq_complete_request(struct request *rq)
 {
-	if (unlikely(blk_should_fake_timeout(rq->q)))
+	struct request_queue *q = rq->q;
+
+	if (unlikely(blk_should_fake_timeout(q)))
 		return;
-	__blk_mq_complete_request(rq);
+again:
+	if (blk_mq_change_rq_state(rq, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE)) {
+		__blk_mq_complete_request(rq);
+		return;
+	}
+	if (blk_mq_change_rq_state(rq, MQ_RQ_TIMED_OUT,
+				   MQ_RQ_COMPLETION_DELAYED)) {
+		/*
+		 * If blk_mq_complete_request() is called from inside the
+		 * request timed out function, complete the request now to
+		 * avoid that a deadlock occurs if another function is called
+		 * from the same context that waits for request completion.
+		 * Otherwise delay request completion until the request
+		 * timeout function has returned.
+		 */
+		if (READ_ONCE(q->timeout_context) == current) {
+			WARN_ON_ONCE(!blk_mq_change_rq_state(rq,
+						MQ_RQ_COMPLETION_DELAYED,
+						MQ_RQ_COMPLETE));
+			__blk_mq_complete_request(rq);
+		}
+		return;
+	}
+	switch (blk_mq_rq_state(rq)) {
+	case MQ_RQ_IDLE:
+	case MQ_RQ_COMPLETE:
+	case MQ_RQ_COMPLETION_DELAYED:
+		WARN_ON_ONCE(true);
+		return;
+	case MQ_RQ_IN_FLIGHT:
+	case MQ_RQ_TIMED_OUT:
+		/*
+		 * In the unlikely case of a race with the timeout code,
+		 * retry.
+		 */
+		goto again;
+	}
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
@@ -645,7 +714,7 @@ void blk_mq_start_request(struct request *rq)
 	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
 
 	blk_mq_add_timer(rq);
-	WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
+	WARN_ON_ONCE(!blk_mq_change_rq_state(rq, MQ_RQ_IDLE, MQ_RQ_IN_FLIGHT));
 
 	if (q->dma_drain_size && blk_rq_bytes(rq)) {
 		/*
@@ -658,23 +727,46 @@ void blk_mq_start_request(struct request *rq)
 }
 EXPORT_SYMBOL(blk_mq_start_request);
 
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
+ */
 static void __blk_mq_requeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
+	enum mq_rq_state old_state = blk_mq_rq_state(rq);
 
 	blk_mq_put_driver_tag(rq);
 
 	trace_block_rq_requeue(q, rq);
 	rq_qos_requeue(q, rq);
 
-	if (blk_mq_request_started(rq)) {
-		WRITE_ONCE(rq->state, MQ_RQ_IDLE);
-		rq->rq_flags &= ~RQF_TIMED_OUT;
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
@@ -767,88 +859,126 @@ struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag)
 }
 EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
+struct blk_mq_timeout_data {
+	unsigned long next;
+	unsigned int next_set;
+	unsigned int nr_expired;
+};
+
 static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
-	req->rq_flags |= RQF_TIMED_OUT;
-	if (req->q->mq_ops->timeout) {
-		enum blk_eh_timer_return ret;
+	enum blk_eh_timer_return ret;
 
-		ret = req->q->mq_ops->timeout(req, reserved);
-		switch (ret) {
-		case BLK_EH_DONE:
-		case BLK_EH_DONT_COMPLETE:
-			return;
-		case BLK_EH_RESET_TIMER:
-			break;
-		default:
-			WARN_ON_ONCE(true);
-		}
+	if (!req->q->mq_ops->timeout) {
+		blk_mq_add_timer(req);
+		return;
 	}
 
-	blk_mq_add_timer(req);
+	ret = req->q->mq_ops->timeout(req, reserved);
+	switch (ret) {
+	case BLK_EH_DONE:
+		WARN_ON_ONCE(blk_mq_rq_state(req) == MQ_RQ_TIMED_OUT);
+		break;
+	case BLK_EH_DONT_COMPLETE:
+		return;
+	case BLK_EH_RESET_TIMER:
+		blk_mq_add_timer(req);
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return;
+	}
+again:
+	if (blk_mq_change_rq_state(req, MQ_RQ_TIMED_OUT, MQ_RQ_IN_FLIGHT))
+		return;
+	if (blk_mq_change_rq_state(req, MQ_RQ_COMPLETION_DELAYED,
+				   MQ_RQ_COMPLETE)) {
+		__blk_mq_complete_request(req);
+		return;
+	}
+	switch (blk_mq_rq_state(req)) {
+	case MQ_RQ_IDLE:
+	case MQ_RQ_IN_FLIGHT:
+	case MQ_RQ_COMPLETE:
+		WARN_ON_ONCE(true);
+		return;
+	case MQ_RQ_TIMED_OUT:
+	case MQ_RQ_COMPLETION_DELAYED:
+		/*
+		 * In the unlikely case of a race with the request completion
+		 * code, retry.
+		 */
+		goto again;
+	}
 }
 
-static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
+static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx, struct request *rq,
+				 void *priv, bool reserved)
 {
+	struct blk_mq_timeout_data *data = priv;
+	union blk_generation_and_state gstate = READ_ONCE(rq->gstate);
 	unsigned long deadline;
 
-	if (blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)
-		return false;
-	if (rq->rq_flags & RQF_TIMED_OUT)
-		return false;
+	might_sleep();
 
-	deadline = blk_rq_deadline(rq);
-	if (time_after_eq(jiffies, deadline))
-		return true;
+#ifdef CONFIG_64BIT
+	deadline = rq->__deadline;
+#else
+	while (true) {
+		int start;
 
-	if (*next == 0)
-		*next = deadline;
-	else if (time_after(*next, deadline))
-		*next = deadline;
-	return false;
+		start = read_seqcount_begin(&rq->deadline_seq);
+		deadline = rq->__deadline;
+		if (!read_seqcount_retry(&rq->deadline_seq, start))
+			break;
+		cond_resched();
+	}
+#endif
+
+	/*
+	 * Make sure that rq->aborted_gstate != rq->gstate if a request gets
+	 * recycled before blk_mq_terminate_expired() is called.
+	 */
+	rq->aborted_gstate = gstate;
+	rq->aborted_gstate.generation ^= (1UL << 28);
+	if (gstate.state == MQ_RQ_IN_FLIGHT &&
+	    time_after_eq(jiffies, deadline)) {
+		/* request timed out */
+		rq->aborted_gstate = gstate;
+		data->nr_expired++;
+		hctx->nr_expired++;
+	} else if (!data->next_set || time_after(data->next, deadline)) {
+		data->next = deadline;
+		data->next_set = 1;
+	}
 }
 
-static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
+static void blk_mq_terminate_expired(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, void *priv, bool reserved)
 {
-	unsigned long *next = priv;
+	union blk_generation_and_state old_val = rq->aborted_gstate;
+	union blk_generation_and_state new_val = old_val;
 
-	/*
-	 * Just do a quick check if it is expired before locking the request in
-	 * so we're not unnecessarilly synchronizing across CPUs.
-	 */
-	if (!blk_mq_req_expired(rq, next))
-		return;
+	new_val.state = MQ_RQ_TIMED_OUT;
 
 	/*
-	 * We have reason to believe the request may be expired. Take a
-	 * reference on the request to lock this request lifetime into its
-	 * currently allocated context to prevent it from being reallocated in
-	 * the event the completion by-passes this timeout handler.
-	 *
-	 * If the reference was already released, then the driver beat the
-	 * timeout handler to posting a natural completion.
-	 */
-	if (!refcount_inc_not_zero(&rq->ref))
-		return;
-
-	/*
-	 * The request is now locked and cannot be reallocated underneath the
-	 * timeout handler's processing. Re-verify this exact request is truly
-	 * expired; if it is not expired, then the request was completed and
-	 * reallocated as a new request.
+	 * We marked @rq->aborted_gstate and waited for ongoing .queue_rq()
+	 * calls. If rq->gstate has not changed that means that it
+	 * is now safe to change the request state and to handle the timeout.
 	 */
-	if (blk_mq_req_expired(rq, next))
+	if (blk_mq_set_rq_state(rq, old_val, new_val))
 		blk_mq_rq_timed_out(rq, reserved);
-	if (refcount_dec_and_test(&rq->ref))
-		__blk_mq_free_request(rq);
 }
 
 static void blk_mq_timeout_work(struct work_struct *work)
 {
 	struct request_queue *q =
 		container_of(work, struct request_queue, timeout_work);
-	unsigned long next = 0;
+	struct blk_mq_timeout_data data = {
+		.next		= 0,
+		.next_set	= 0,
+		.nr_expired	= 0,
+	};
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
@@ -868,10 +998,43 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
+	/* scan for the expired ones and set their ->aborted_gstate */
+	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &data);
 
-	if (next != 0) {
-		mod_timer(&q->timeout, next);
+	if (data.nr_expired) {
+		bool has_rcu = false;
+
+		/*
+		 * For very short timeouts it can happen that
+		 * blk_mq_check_expired() modifies the state of a request
+		 * while .queue_rq() is still in progress. Hence wait until
+		 * these .queue_rq() calls have finished. This is also
+		 * necessary to avoid races with blk_mq_requeue_request() for
+		 * requests that have already been started.
+		 */
+		queue_for_each_hw_ctx(q, hctx, i) {
+			if (!hctx->nr_expired)
+				continue;
+
+			if (!(hctx->flags & BLK_MQ_F_BLOCKING))
+				has_rcu = true;
+			else
+				synchronize_srcu(hctx->srcu);
+
+			hctx->nr_expired = 0;
+		}
+		if (has_rcu)
+			synchronize_rcu();
+
+		/* terminate the ones we won */
+		WRITE_ONCE(q->timeout_context, current);
+		blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_expired, NULL);
+		WRITE_ONCE(q->timeout_context, NULL);
+	}
+
+	if (data.next_set) {
+		data.next = blk_rq_timeout(round_jiffies_up(data.next));
+		mod_timer(&q->timeout, data.next);
 	} else {
 		/*
 		 * Request timeouts are handled as a forward rolling timer. If
@@ -2015,7 +2178,9 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 			return ret;
 	}
 
-	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
+#ifndef CONFIG_64BIT
+	seqcount_init(&rq->deadline_seq);
+#endif
 	return 0;
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9497b47e2526..de92cddc147f 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -90,13 +90,21 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_release(struct request_queue *q);
 
+static inline bool blk_mq_set_rq_state(struct request *rq,
+				       union blk_generation_and_state old_val,
+				       union blk_generation_and_state new_val)
+{
+	return cmpxchg(&rq->gstate.val, old_val.val, new_val.val) ==
+		old_val.val;
+}
+
 /**
  * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
  * @rq: target request.
  */
 static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
 {
-	return READ_ONCE(rq->state);
+	return READ_ONCE(rq->gstate).state;
 }
 
 static inline struct blk_mq_ctx *__blk_mq_get_ctx(struct request_queue *q,
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 8e6661031bc0..793592560159 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -149,6 +149,22 @@ void blk_timeout_work(struct work_struct *work)
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
@@ -162,11 +178,10 @@ void blk_abort_request(struct request *req)
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
@@ -235,7 +250,6 @@ void blk_add_timer(struct request *req)
 	if (!req->timeout)
 		req->timeout = q->rq_timeout;
 
-	req->rq_flags &= ~RQF_TIMED_OUT;
 	deadline = jiffies + req->timeout;
 	blk_rq_set_deadline(req, deadline);
 	list_add_tail(&req->timeout_list, &req->q->timeout_list);
@@ -257,9 +271,7 @@ void blk_mq_add_timer(struct request *req)
 
 	if (!req->timeout)
 		req->timeout = q->rq_timeout;
-
-	req->rq_flags &= ~RQF_TIMED_OUT;
 	deadline = jiffies + req->timeout;
-	blk_rq_set_deadline(req, deadline);
+	blk_mq_rq_set_deadline(req, deadline);
 	__blk_add_timer(req, deadline);
 }
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index a885f4f23591..963ad28257cc 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -296,20 +296,6 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
 		rtn = host->hostt->eh_timed_out(scmd);
 
 	if (rtn == BLK_EH_DONT_COMPLETE) {
-		/*
-		 * For blk-mq, we must set the request state to complete now
-		 * before sending the request to the scsi error handler. This
-		 * will prevent a use-after-free in the event the LLD manages
-		 * to complete the request before the error handler finishes
-		 * processing this timed out request.
-		 *
-		 * If the request was already completed, then the LLD beat the
-		 * time out handler from transferring the request to the scsi
-		 * error handler. In that case we can return immediately as no
-		 * further action is required.
-		 */
-		if (req->q->mq_ops && !blk_mq_mark_complete(req))
-			return rtn;
 		if (scsi_abort_command(scmd) != SUCCESS) {
 			set_host_byte(scmd, DID_TIME_OUT);
 			scsi_eh_scmd_add(scmd);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..d710e92874cc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -289,20 +289,6 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
-/**
- * blk_mq_mark_complete() - Set request state to complete
- * @rq: request to set to complete state
- *
- * Returns true if request state was successfully set to complete. If
- * successful, the caller is responsibile for seeing this request is ended, as
- * blk_mq_complete_request will not work again.
- */
-static inline bool blk_mq_mark_complete(struct request *rq)
-{
-	return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
-			MQ_RQ_IN_FLIGHT;
-}
-
 /*
  * Driver command data is immediately after the request. So subtract request
  * size to get back to the original request, add request size to get the PDU.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9aeda7e982c4..5915f7208cc6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -126,20 +126,44 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_ZONE_WRITE_LOCKED	((__force req_flags_t)(1 << 19))
 /* already slept for hybrid poll */
 #define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
-/* ->timeout has been called, don't expire again */
-#define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
 	(RQF_STARTED | RQF_SOFTBARRIER | RQF_FLUSH_SEQ | RQF_SPECIAL_PAYLOAD)
 
-/*
- * Request state for blk-mq.
+union blk_generation_and_state {
+	struct {
+		uint32_t generation:29;
+		uint32_t state:3;
+	};
+	uint32_t val;
+};
+
+/**
+ * enum mq_rq_state - blk-mq request state
+ *
+ * The legal state transitions are:
+ * - idle      -> in flight: blk_mq_start_request()
+ * - in flight -> complete:  blk_mq_complete_request()
+ * - in flight -> timed out: request times out
+ * - timed out -> complete:  blk_mq_complete_request() called from inside
+ *			     the timeout handler
+ * - timed out -> cmpltn dlyd: blk_mq_complete_request() called from outside
+ *			     the timeout handler
+ * - cmpltn dlyd -> complete: blk_mq_rq_timed_out() completes request
+ * - complete  -> idle:      blk_mq_requeue_request() or blk_mq_free_request()
+ * - in flight -> idle:      blk_mq_requeue_request() or blk_mq_free_request()
+ * - timed out -> idle:      blk_mq_requeue_request() or blk_mq_free_request()
+ * - timed out -> in flight: request restart due to BLK_EH_RESET_TIMER
+ *
+ * See also blk_generation_and_state.state.
  */
 enum mq_rq_state {
 	MQ_RQ_IDLE		= 0,
 	MQ_RQ_IN_FLIGHT		= 1,
 	MQ_RQ_COMPLETE		= 2,
+	MQ_RQ_COMPLETION_DELAYED= 3,
+	MQ_RQ_TIMED_OUT		= 4,
 };
 
 /*
@@ -242,12 +266,26 @@ struct request {
 
 	unsigned int extra_len;	/* length of alignment and padding */
 
-	enum mq_rq_state state;
-	refcount_t ref;
-
 	unsigned int timeout;
 
-	/* access through blk_rq_set_deadline, blk_rq_deadline */
+	/*
+	 * ->aborted_gstate is used by the timeout to claim a specific
+	 * recycle instance of this request.  See blk_mq_timeout_work().
+	 */
+	union blk_generation_and_state aborted_gstate;
+
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
@@ -581,6 +619,8 @@ struct request_queue {
 	struct work_struct	timeout_work;
 	struct list_head	timeout_list;
 
+	struct task_struct	*timeout_context;
+
 	struct list_head	icq_list;
 #ifdef CONFIG_BLK_CGROUP
 	DECLARE_BITMAP		(blkcg_pols, BLKCG_MAX_POLS);
-- 
2.18.0
