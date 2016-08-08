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
Subject: [PATCH V2 03/22] block, cfq: remove deep seek queues logic
Date: Mon,  8 Aug 2016 13:14:58 +0200
Message-Id: <1470654917-4280-4-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Arianna Avanzini <avanzini.arianna@gmail.com>

CFQ implements a heuristic to identify seeky queues experiencing large
queue depths (>= 4), and let them idle despite their seekiness.  This
mechanism has no match in BFQ, where idling decisions are taken
according to a unified global strategy. In this strategy, all actions
are aimed at boosting the throughput, except for when
throughput-boosting actions would jeopardize throughput-distribution
and latency guarantees. Full details in the commits turning CFQ into
BFQ.

Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/cfq-iosched.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 1ab8898..04d2298 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -411,7 +411,6 @@ enum cfqq_state_flags {
 	CFQ_CFQQ_FLAG_prio_changed,	/* task priority has changed */
 	CFQ_CFQQ_FLAG_slice_new,	/* no requests dispatched in slice */
 	CFQ_CFQQ_FLAG_sync,		/* synchronous queue */
-	CFQ_CFQQ_FLAG_deep,		/* sync cfqq experienced large depth */
 	CFQ_CFQQ_FLAG_wait_busy,	/* Waiting for next request */
 };
 
@@ -438,7 +437,6 @@ CFQ_CFQQ_FNS(idle_window);
 CFQ_CFQQ_FNS(prio_changed);
 CFQ_CFQQ_FNS(slice_new);
 CFQ_CFQQ_FNS(sync);
-CFQ_CFQQ_FNS(deep);
 CFQ_CFQQ_FNS(wait_busy);
 #undef CFQ_CFQQ_FNS
 
@@ -3060,15 +3058,12 @@ static struct cfq_queue *cfq_select_queue(struct cfq_data *cfqd)
 	}
 
 	/*
-	 * This is a deep seek queue, but the device is much faster than
-	 * the queue can deliver, don't idle
+	 * The device is much faster than the queue can deliver: don't idle
 	 **/
 	if (CFQQ_SEEKY(cfqq) && cfq_cfqq_idle_window(cfqq) &&
 	    (cfq_cfqq_slice_new(cfqq) ||
-	    (cfqq->slice_end - now > now - cfqq->slice_start))) {
-		cfq_clear_cfqq_deep(cfqq);
+	     (cfqq->slice_end - now > now - cfqq->slice_start)))
 		cfq_clear_cfqq_idle_window(cfqq);
-	}
 
 	if (cfqq->dispatched && cfq_should_idle(cfqd, cfqq)) {
 		cfqq = NULL;
@@ -3649,14 +3644,10 @@ cfq_update_idle_window(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 
 	enable_idle = old_idle = cfq_cfqq_idle_window(cfqq);
 
-	if (cfqq->queued[0] + cfqq->queued[1] >= 4)
-		cfq_mark_cfqq_deep(cfqq);
-
 	if (cfqq->next_rq && (cfqq->next_rq->cmd_flags & REQ_NOIDLE))
 		enable_idle = 0;
 	else if (!atomic_read(&cic->icq.ioc->active_ref) ||
-		 !cfqd->cfq_slice_idle ||
-		 (!cfq_cfqq_deep(cfqq) && CFQQ_SEEKY(cfqq)))
+		 !cfqd->cfq_slice_idle || CFQQ_SEEKY(cfqq))
 		enable_idle = 0;
 	else if (sample_valid(cic->ttime.ttime_samples)) {
 		if (cic->ttime.ttime_mean > cfqd->cfq_slice_idle)
@@ -4185,11 +4176,6 @@ static enum hrtimer_restart cfq_idle_slice_timer(struct hrtimer *timer)
 		 */
 		if (!RB_EMPTY_ROOT(&cfqq->sort_list))
 			goto out_kick;
-
-		/*
-		 * Queue depth flag is reset only when the idle didn't succeed
-		 */
-		cfq_clear_cfqq_deep(cfqq);
 	}
 expire:
 	cfq_slice_expired(cfqd, timed_out);
-- 
1.9.1
