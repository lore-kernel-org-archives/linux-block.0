Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V3 03/16] block, bfq: improve throughput boosting
Date: Tue, 11 Apr 2017 15:43:02 +0200
Message-Id: <20170411134315.44135-4-paolo.valente@linaro.org>
In-Reply-To: <20170411134315.44135-1-paolo.valente@linaro.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

The feedback-loop algorithm used by BFQ to compute queue (process)
budgets is basically a set of three update rules, one for each of the
main reasons why a queue may be expired. If many processes suddenly
switch from sporadic I/O to greedy and sequential I/O, then these
rules are quite slow to assign large budgets to these processes, and
hence to achieve a high throughput. On the opposite side, BFQ assigns
the maximum possible budget B_max to a just-created queue. This allows
a high throughput to be achieved immediately if the associated process
is I/O-bound and performs sequential I/O from the beginning. But it
also increases the worst-case latency experienced by the first
requests issued by the process, because the larger the budget of a
queue waiting for service is, the later the queue will be served by
B-WF2Q+ (Subsec 3.3 in [1]). This is detrimental for an interactive or
soft real-time application.

To tackle these throughput and latency problems, on one hand this
patch changes the initial budget value to B_max/2. On the other hand,
it re-tunes the three rules, adopting a more aggressive,
multiplicative increase/linear decrease scheme. This scheme trades
latency for throughput more than before, and tends to assign large
budgets quickly to processes that are or become I/O-bound. For two of
the expiration reasons, the new version of the rules also contains
some more little improvements, briefly described below.

*No more backlog.* In this case, the budget was larger than the number
of sectors actually read/written by the process before it stopped
doing I/O. Hence, to reduce latency for the possible future I/O
requests of the process, the old rule simply set the next budget to
the number of sectors actually consumed by the process. However, if
there are still outstanding requests, then the process may have not
yet issued its next request just because it is still waiting for the
completion of some of the still outstanding ones. If this sub-case
holds true, then the new rule, instead of decreasing the budget,
doubles it, proactively, in the hope that: 1) a larger budget will fit
the actual needs of the process, and 2) the process is sequential and
hence a higher throughput will be achieved by serving the process
longer after granting it access to the device.

*Budget timeout*. The original rule set the new budget to the maximum
value B_max, to maximize throughput and let all processes experiencing
budget timeouts receive the same share of the device time. In our
experiments we verified that this sudden jump to B_max did not provide
sensible benefits; rather it increased the latency of processes
performing sporadic and short I/O. The new rule only doubles the
budget.

[1] P. Valente and M. Andreolini, "Improving Application
    Responsiveness with the BFQ Disk I/O Scheduler", Proceedings of
    the 5th Annual International Systems and Storage Conference
    (SYSTOR '12), June 2012.
    Slightly extended version:
    http://algogroup.unimore.it/people/paolo/disk_sched/bfq-v1-suite-
							results.pdf

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/bfq-iosched.c | 87 +++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 46 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 800048fa..553aee1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -752,9 +752,6 @@ static struct kmem_cache *bfq_pool;
 #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
 #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 32/8)
 
-/* Budget feedback step. */
-#define BFQ_BUDGET_STEP         128
-
 /* Min samples used for peak rate estimation (for autotuning). */
 #define BFQ_PEAK_RATE_SAMPLES	32
 
@@ -4074,40 +4071,6 @@ static struct bfq_queue *bfq_set_in_service_queue(struct bfq_data *bfqd)
 	return bfqq;
 }
 
-/*
- * bfq_default_budget - return the default budget for @bfqq on @bfqd.
- * @bfqd: the device descriptor.
- * @bfqq: the queue to consider.
- *
- * We use 3/4 of the @bfqd maximum budget as the default value
- * for the max_budget field of the queues.  This lets the feedback
- * mechanism to start from some middle ground, then the behavior
- * of the process will drive the heuristics towards high values, if
- * it behaves as a greedy sequential reader, or towards small values
- * if it shows a more intermittent behavior.
- */
-static unsigned long bfq_default_budget(struct bfq_data *bfqd,
-					struct bfq_queue *bfqq)
-{
-	unsigned long budget;
-
-	/*
-	 * When we need an estimate of the peak rate we need to avoid
-	 * to give budgets that are too short due to previous
-	 * measurements.  So, in the first 10 assignments use a
-	 * ``safe'' budget value. For such first assignment the value
-	 * of bfqd->budgets_assigned happens to be lower than 194.
-	 * See __bfq_set_in_service_queue for the formula by which
-	 * this field is computed.
-	 */
-	if (bfqd->budgets_assigned < 194 && bfqd->bfq_user_max_budget == 0)
-		budget = bfq_default_max_budget;
-	else
-		budget = bfqd->bfq_max_budget;
-
-	return budget - budget / 4;
-}
-
 static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq = bfqd->in_service_queue;
@@ -4232,13 +4195,47 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
 		 * for throughput.
 		 */
 		case BFQQE_TOO_IDLE:
-			if (budget > min_budget + BFQ_BUDGET_STEP)
-				budget -= BFQ_BUDGET_STEP;
-			else
-				budget = min_budget;
+			/*
+			 * This is the only case where we may reduce
+			 * the budget: if there is no request of the
+			 * process still waiting for completion, then
+			 * we assume (tentatively) that the timer has
+			 * expired because the batch of requests of
+			 * the process could have been served with a
+			 * smaller budget.  Hence, betting that
+			 * process will behave in the same way when it
+			 * becomes backlogged again, we reduce its
+			 * next budget.  As long as we guess right,
+			 * this budget cut reduces the latency
+			 * experienced by the process.
+			 *
+			 * However, if there are still outstanding
+			 * requests, then the process may have not yet
+			 * issued its next request just because it is
+			 * still waiting for the completion of some of
+			 * the still outstanding ones.  So in this
+			 * subcase we do not reduce its budget, on the
+			 * contrary we increase it to possibly boost
+			 * the throughput, as discussed in the
+			 * comments to the BUDGET_TIMEOUT case.
+			 */
+			if (bfqq->dispatched > 0) /* still outstanding reqs */
+				budget = min(budget * 2, bfqd->bfq_max_budget);
+			else {
+				if (budget > 5 * min_budget)
+					budget -= 4 * min_budget;
+				else
+					budget = min_budget;
+			}
 			break;
 		case BFQQE_BUDGET_TIMEOUT:
-			budget = bfq_default_budget(bfqd, bfqq);
+			/*
+			 * We double the budget here because it gives
+			 * the chance to boost the throughput if this
+			 * is not a seeky process (and has bumped into
+			 * this timeout because of, e.g., ZBR).
+			 */
+			budget = min(budget * 2, bfqd->bfq_max_budget);
 			break;
 		case BFQQE_BUDGET_EXHAUSTED:
 			/*
@@ -4250,8 +4247,7 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
 			 * definitely increase the budget of this good
 			 * candidate to boost the disk throughput.
 			 */
-			budget = min(budget + 8 * BFQ_BUDGET_STEP,
-				     bfqd->bfq_max_budget);
+			budget = min(budget * 4, bfqd->bfq_max_budget);
 			break;
 		case BFQQE_NO_MORE_REQUESTS:
 			/*
@@ -5025,9 +5021,8 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	bfqq->pid = pid;
 
 	/* Tentative initial value to trade off between thr and lat */
-	bfqq->max_budget = bfq_default_budget(bfqd, bfqq);
+	bfqq->max_budget = (2 * bfq_max_budget(bfqd)) / 3;
 	bfqq->budget_timeout = bfq_smallest_from_now();
-	bfqq->pid = pid;
 
 	/* first request is almost certainly seeky */
 	bfqq->seek_history = 1;
-- 
2.10.0
