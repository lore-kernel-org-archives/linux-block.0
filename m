Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V2 06/22] block, cfq: get rid of queue preemption
Date: Mon,  8 Aug 2016 13:15:01 +0200
Message-Id: <1470654917-4280-7-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Arianna Avanzini <avanzini.arianna@gmail.com>

CFQ implements a request-triggered queue preemption, based on the
priority class of the queues, and aimed at reducing latencies. There
is no such preemption in BFQ, where a low latency is guaranteed only
by the overall request-scheduling policy.

Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/cfq-iosched.c | 99 +----------------------------------------------------
 1 file changed, 1 insertion(+), 98 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index afe42fc..5e0daaf 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -1087,8 +1087,7 @@ static inline void cfq_slice_expired(struct cfq_data *cfqd, bool timed_out)
 }
 
 /*
- * Get next queue for service. Unless we have a queue preemption,
- * we'll simply select the first cfqq in the service tree.
+ * Get next queue for service.
  */
 static struct cfq_queue *cfq_get_next_queue(struct cfq_data *cfqd)
 {
@@ -1953,93 +1952,6 @@ cfq_update_idle_window(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 }
 
 /*
- * Check if new_cfqq should preempt the currently active queue. Return 0 for
- * no or if we aren't sure, a 1 will cause a preempt.
- */
-static bool
-cfq_should_preempt(struct cfq_data *cfqd, struct cfq_queue *new_cfqq,
-		   struct request *rq)
-{
-	struct cfq_queue *cfqq;
-
-	cfqq = cfqd->active_queue;
-	if (!cfqq)
-		return false;
-
-	if (cfq_class_idle(new_cfqq))
-		return false;
-
-	if (cfq_class_idle(cfqq))
-		return true;
-
-	/*
-	 * Don't allow a non-RT request to preempt an ongoing RT cfqq timeslice.
-	 */
-	if (cfq_class_rt(cfqq) && !cfq_class_rt(new_cfqq))
-		return false;
-
-	/*
-	 * if the new request is sync, but the currently running queue is
-	 * not, let the sync request have priority.
-	 */
-	if (rq_is_sync(rq) && !cfq_cfqq_sync(cfqq))
-		return true;
-
-	if (cfq_slice_used(cfqq))
-		return true;
-
-	/*
-	 * Allow an RT request to pre-empt an ongoing non-RT cfqq timeslice.
-	 */
-	if (cfq_class_rt(new_cfqq) && !cfq_class_rt(cfqq))
-		return true;
-
-	WARN_ON_ONCE(cfqq->ioprio_class != new_cfqq->ioprio_class);
-	/* Allow preemption only if we are idling on sync-noidle tree */
-	if (cfqd->serving_wl_type == SYNC_NOIDLE_WORKLOAD &&
-	    cfqq_type(new_cfqq) == SYNC_NOIDLE_WORKLOAD &&
-	    RB_EMPTY_ROOT(&cfqq->sort_list))
-		return true;
-
-	/*
-	 * So both queues are sync. Let the new request get disk time if
-	 * it's a metadata request and the current queue is doing regular IO.
-	 */
-	if ((rq->cmd_flags & REQ_PRIO) && !cfqq->prio_pending)
-		return true;
-
-	/* An idle queue should not be idle now for some reason */
-	if (RB_EMPTY_ROOT(&cfqq->sort_list) && !cfq_should_idle(cfqd, cfqq))
-		return true;
-
-	if (!cfqd->active_cic || !cfq_cfqq_wait_request(cfqq))
-		return false;
-
-	return false;
-}
-
-/*
- * cfqq preempts the active queue. if we allowed preempt with no slice left,
- * let it have half of its nominal slice.
- */
-static void cfq_preempt_queue(struct cfq_data *cfqd, struct cfq_queue *cfqq)
-{
-	cfq_log_cfqq(cfqd, cfqq, "preempt");
-	cfq_slice_expired(cfqd, 1);
-
-	/*
-	 * Put the new queue at the front of the of the current list,
-	 * so we know that it will be selected next.
-	 */
-	BUG_ON(!cfq_cfqq_on_rr(cfqq));
-
-	cfq_service_tree_add(cfqd, cfqq, 1);
-
-	cfqq->slice_end = 0;
-	cfq_mark_cfqq_slice_new(cfqq);
-}
-
-/*
  * Called when a new fs request (rq) is added (to cfqq). Check if there's
  * something we should do about it
  */
@@ -2079,15 +1991,6 @@ cfq_rq_enqueued(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 			} else
 				cfq_mark_cfqq_must_dispatch(cfqq);
 		}
-	} else if (cfq_should_preempt(cfqd, cfqq, rq)) {
-		/*
-		 * not the active queue - expire current slice if it is
-		 * idle and has expired it's mean thinktime or this new queue
-		 * has some old slice time left and is of higher priority or
-		 * this new queue is RT and the current one is BE
-		 */
-		cfq_preempt_queue(cfqd, cfqq);
-		__blk_run_queue(cfqd->queue);
 	}
 }
 
-- 
1.9.1
