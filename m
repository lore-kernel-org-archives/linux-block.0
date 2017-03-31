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
Subject: [PATCH V2 05/16] block, bfq: add more fairness with writes and slow processes
Date: Fri, 31 Mar 2017 14:47:32 +0200
Message-Id: <20170331124743.3530-6-paolo.valente@linaro.org>
In-Reply-To: <20170331124743.3530-1-paolo.valente@linaro.org>
References: <20170331124743.3530-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This patch deals with two sources of unfairness, which can also cause
high latencies and throughput loss. The first source is related to
write requests. Write requests tend to starve read requests, basically
because, on one side, writes are slower than reads, whereas, on the
other side, storage devices confuse schedulers by deceptively
signaling the completion of write requests immediately after receiving
them. This patch addresses this issue by just throttling writes. In
particular, after a write request is dispatched for a queue, the
budget of the queue is decremented by the number of sectors to write,
multiplied by an (over)charge coefficient. The value of the
coefficient is the result of our tuning with different devices.

The second source of unfairness has to do with slowness detection:
when the in-service queue is expired, BFQ also controls whether the
queue has been "too slow", i.e., has consumed its last-assigned budget
at such a low rate that it would have been impossible to consume all
of this budget within the maximum time slice T_max (Subsec. 3.5 in
[1]). In this case, the queue is always (over)charged the whole
budget, to reduce its utilization of the device. Both this overcharge
and the slowness-detection criterion may cause unfairness.

First, always charging a full budget to a slow queue is too coarse. It
is much more accurate, and this patch lets BFQ do so, to charge an
amount of service 'equivalent' to the amount of time during which the
queue has been in service. As explained in more detail in the comments
on the code, this enables BFQ to provide time fairness among slow
queues.

Secondly, because of ZBR, a queue may be deemed as slow when its
associated process is performing I/O on the slowest zones of a
disk. However, unless the process is truly too slow, not reducing the
disk utilization of the queue is more profitable in terms of disk
throughput than the opposite. A similar problem is caused by logical
block mapping on non-rotational devices. For this reason, this patch
lets a queue be charged time, and not budget, only if the queue has
consumed less than 2/3 of its assigned budget. As an additional,
important benefit, this tolerance allows BFQ to preserve enough
elasticity to still perform bandwidth, and not time, distribution with
little unlucky or quasi-sequential processes.

Finally, for the same reasons as above, this patch makes slowness
detection itself much less harsh: a queue is deemed slow only if it
has consumed its budget at less than half of the peak rate.

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
 block/bfq-iosched.c | 120 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 35 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5b7c4c8..ad3151a 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -753,6 +753,13 @@ static const int bfq_stats_min_budgets = 194;
 /* Default maximum budget values, in sectors and number of requests. */
 static const int bfq_default_max_budget = 16 * 1024;
 
+/*
+ * Async to sync throughput distribution is controlled as follows:
+ * when an async request is served, the entity is charged the number
+ * of sectors of the request, multiplied by the factor below
+ */
+static const int bfq_async_charge_factor = 10;
+
 /* Default timeout values, in jiffies, approximating CFQ defaults. */
 static const int bfq_timeout = HZ / 8;
 
@@ -1571,22 +1578,52 @@ static void bfq_bfqq_served(struct bfq_queue *bfqq, int served)
 }
 
 /**
- * bfq_bfqq_charge_full_budget - set the service to the entity budget.
+ * bfq_bfqq_charge_time - charge an amount of service equivalent to the length
+ *			  of the time interval during which bfqq has been in
+ *			  service.
+ * @bfqd: the device
  * @bfqq: the queue that needs a service update.
+ * @time_ms: the amount of time during which the queue has received service
  *
- * When it's not possible to be fair in the service domain, because
- * a queue is not consuming its budget fast enough (the meaning of
- * fast depends on the timeout parameter), we charge it a full
- * budget.  In this way we should obtain a sort of time-domain
- * fairness among all the seeky/slow queues.
+ * If a queue does not consume its budget fast enough, then providing
+ * the queue with service fairness may impair throughput, more or less
+ * severely. For this reason, queues that consume their budget slowly
+ * are provided with time fairness instead of service fairness. This
+ * goal is achieved through the BFQ scheduling engine, even if such an
+ * engine works in the service, and not in the time domain. The trick
+ * is charging these queues with an inflated amount of service, equal
+ * to the amount of service that they would have received during their
+ * service slot if they had been fast, i.e., if their requests had
+ * been dispatched at a rate equal to the estimated peak rate.
+ *
+ * It is worth noting that time fairness can cause important
+ * distortions in terms of bandwidth distribution, on devices with
+ * internal queueing. The reason is that I/O requests dispatched
+ * during the service slot of a queue may be served after that service
+ * slot is finished, and may have a total processing time loosely
+ * correlated with the duration of the service slot. This is
+ * especially true for short service slots.
  */
-static void bfq_bfqq_charge_full_budget(struct bfq_queue *bfqq)
+static void bfq_bfqq_charge_time(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+				 unsigned long time_ms)
 {
 	struct bfq_entity *entity = &bfqq->entity;
+	int tot_serv_to_charge = entity->service;
+	unsigned int timeout_ms = jiffies_to_msecs(bfq_timeout);
+
+	if (time_ms > 0 && time_ms < timeout_ms)
+		tot_serv_to_charge =
+			(bfqd->bfq_max_budget * time_ms) / timeout_ms;
 
-	bfq_log_bfqq(bfqq->bfqd, bfqq, "charge_full_budget");
+	if (tot_serv_to_charge < entity->service)
+		tot_serv_to_charge = entity->service;
 
-	bfq_bfqq_served(bfqq, entity->budget - entity->service);
+	/* Increase budget to avoid inconsistencies */
+	if (tot_serv_to_charge > entity->budget)
+		entity->budget = tot_serv_to_charge;
+
+	bfq_bfqq_served(bfqq,
+			max_t(int, 0, tot_serv_to_charge - entity->service));
 }
 
 static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
@@ -3572,10 +3609,14 @@ static struct request *bfq_find_next_rq(struct bfq_data *bfqd,
 	return bfq_choose_req(bfqd, next, prev, blk_rq_pos(last));
 }
 
+/* see the definition of bfq_async_charge_factor for details */
 static unsigned long bfq_serv_to_charge(struct request *rq,
 					struct bfq_queue *bfqq)
 {
-	return blk_rq_sectors(rq);
+	if (bfq_bfqq_sync(bfqq))
+		return blk_rq_sectors(rq);
+
+	return blk_rq_sectors(rq) * bfq_async_charge_factor;
 }
 
 /**
@@ -4676,28 +4717,24 @@ static unsigned long bfq_smallest_from_now(void)
  * @compensate: if true, compensate for the time spent idling.
  * @reason: the reason causing the expiration.
  *
+ * If the process associated with bfqq does slow I/O (e.g., because it
+ * issues random requests), we charge bfqq with the time it has been
+ * in service instead of the service it has received (see
+ * bfq_bfqq_charge_time for details on how this goal is achieved). As
+ * a consequence, bfqq will typically get higher timestamps upon
+ * reactivation, and hence it will be rescheduled as if it had
+ * received more service than what it has actually received. In the
+ * end, bfqq receives less service in proportion to how slowly its
+ * associated process consumes its budgets (and hence how seriously it
+ * tends to lower the throughput). In addition, this time-charging
+ * strategy guarantees time fairness among slow processes. In
+ * contrast, if the process associated with bfqq is not slow, we
+ * charge bfqq exactly with the service it has received.
  *
- * If the process associated with the queue is slow (i.e., seeky), or
- * in case of budget timeout, or, finally, if it is async, we
- * artificially charge it an entire budget (independently of the
- * actual service it received). As a consequence, the queue will get
- * higher timestamps than the correct ones upon reactivation, and
- * hence it will be rescheduled as if it had received more service
- * than what it actually received. In the end, this class of processes
- * will receive less service in proportion to how slowly they consume
- * their budgets (and hence how seriously they tend to lower the
- * throughput).
- *
- * In contrast, when a queue expires because it has been idling for
- * too much or because it exhausted its budget, we do not touch the
- * amount of service it has received. Hence when the queue will be
- * reactivated and its timestamps updated, the latter will be in sync
- * with the actual service received by the queue until expiration.
- *
- * Charging a full budget to the first type of queues and the exact
- * service to the others has the effect of using the WF2Q+ policy to
- * schedule the former on a timeslice basis, without violating the
- * service domain guarantees of the latter.
+ * Charging time to the first type of queues and the exact service to
+ * the other has the effect of using the WF2Q+ policy to schedule the
+ * former on a timeslice basis, without violating service domain
+ * guarantees among the latter.
  */
 static void bfq_bfqq_expire(struct bfq_data *bfqd,
 			    struct bfq_queue *bfqq,
@@ -4715,11 +4752,24 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
 	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, reason, &delta);
 
 	/*
-	 * As above explained, 'punish' slow (i.e., seeky), timed-out
-	 * and async queues, to favor sequential sync workloads.
+	 * As above explained, charge slow (typically seeky) and
+	 * timed-out queues with the time and not the service
+	 * received, to favor sequential workloads.
+	 *
+	 * Processes doing I/O in the slower disk zones will tend to
+	 * be slow(er) even if not seeky. Therefore, since the
+	 * estimated peak rate is actually an average over the disk
+	 * surface, these processes may timeout just for bad luck. To
+	 * avoid punishing them, do not charge time to processes that
+	 * succeeded in consuming at least 2/3 of their budget. This
+	 * allows BFQ to preserve enough elasticity to still perform
+	 * bandwidth, and not time, distribution with little unlucky
+	 * or quasi-sequential processes.
 	 */
-	if (slow || reason == BFQQE_BUDGET_TIMEOUT)
-		bfq_bfqq_charge_full_budget(bfqq);
+	if (slow ||
+	    (reason == BFQQE_BUDGET_TIMEOUT &&
+	     bfq_bfqq_budget_left(bfqq) >=  entity->budget / 3))
+		bfq_bfqq_charge_time(bfqd, bfqq, delta);
 
 	if (reason == BFQQE_TOO_IDLE &&
 	    entity->service <= 2 * entity->budget / 10)
-- 
2.10.0
