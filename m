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
Subject: [PATCH RFC 07/14] block, bfq: reduce I/O latency for soft real-time applications
Date: Sat,  4 Mar 2017 17:01:24 +0100
Message-Id: <20170304160131.57366-8-paolo.valente@linaro.org>
In-Reply-To: <20170304160131.57366-1-paolo.valente@linaro.org>
References: <20170304160131.57366-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

To guarantee a low latency also to the I/O requests issued by soft
real-time applications, this patch introduces a further heuristic,
which weight-raises (in the sense explained in the previous patch)
also the queues associated to applications deemed as soft real-time.

To be deemed as soft real-time, an application must meet two
requirements.  First, the application must not require an average
bandwidth higher than the approximate bandwidth required to playback
or record a compressed high-definition video. Second, the request
pattern of the application must be isochronous, i.e., after issuing a
request or a batch of requests, the application must stop issuing new
requests until all its pending requests have been completed. After
that, the application may issue a new batch, and so on.

As for the second requirement, it is critical to require also that,
after all the pending requests of the application have been completed,
an adequate minimum amount of time elapses before the application
starts issuing new requests. This prevents also greedy (i.e.,
I/O-bound) applications from being incorrectly deemed, occasionally,
as soft real-time. In fact, if *any amount of time* is fine, then even
a greedy application may, paradoxically, meet both the above
requirements, if: (1) the application performs random I/O and/or the
device is slow, and (2) the CPU load is high. The reason is the
following.  First, if condition (1) is true, then, during the service
of the application, the throughput may be low enough to let the
application meet the bandwidth requirement.  Second, if condition (2)
is true as well, then the application may occasionally behave in an
apparently isochronous way, because it may simply stop issuing
requests while the CPUs are busy serving other processes.

To address this issue, the heuristic leverages the simple fact that
greedy applications issue *all* their requests as quickly as they can,
whereas soft real-time applications spend some time processing data
after each batch of requests is completed. In particular, the
heuristic works as follows. First, according to the above isochrony
requirement, the heuristic checks whether an application may be soft
real-time, thereby giving to the application the opportunity to be
deemed as such, only when both the following two conditions happen to
hold: 1) the queue associated with the application has expired and is
empty, 2) there is no outstanding request of the application.

Suppose that both conditions hold at time, say, t_c and that the
application issues its next request at time, say, t_i. At time t_c the
heuristic computes the next time instant, called soft_rt_next_start in
the code, such that, only if t_i >= soft_rt_next_start, then both the
next conditions will hold when the application issues its next
request: 1) the application will meet the above bandwidth requirement,
2) a given minimum time interval, say Delta, will have elapsed from
time t_c (so as to filter out greedy application).

The current value of Delta is a little bit higher than the value that
we have found, experimentally, to be adequate on a real,
general-purpose machine. In particular we had to increase Delta to
make the filter quite precise also in slower, embedded systems, and in
KVM/QEMU virtual machines (details in the comments on the code).

If the application actually issues its next request after time
soft_rt_next_start, then its associated queue will be weight-raised
for a relatively short time interval. If, during this time interval,
the application proves again to meet the bandwidth and isochrony
requirements, then the end of the weight-raising period for the queue
is moved forward, and so on. Note that an application whose associated
queue never happens to be empty when it expires will never have the
opportunity to be deemed as soft real-time.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/bfq-iosched.c | 352 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 332 insertions(+), 20 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 98f0ddf..bc47591 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -111,6 +111,13 @@
 #define BFQ_DEFAULT_GRP_IOPRIO	0
 #define BFQ_DEFAULT_GRP_CLASS	IOPRIO_CLASS_BE
 
+/*
+ * Soft real-time applications are extremely more latency sensitive
+ * than interactive ones. Over-raise the weight of the former to
+ * privilege them against the latter.
+ */
+#define BFQ_SOFTRT_WEIGHT_FACTOR	100
+
 struct bfq_entity;
 
 /**
@@ -324,6 +331,14 @@ struct bfq_queue {
 	/* current maximum weight-raising time for this queue */
 	unsigned long wr_cur_max_time;
 	/*
+	 * Minimum time instant such that, only if a new request is
+	 * enqueued after this time instant in an idle @bfq_queue with
+	 * no outstanding requests, then the task associated with the
+	 * queue it is deemed as soft real-time (see the comments on
+	 * the function bfq_bfqq_softrt_next_start())
+	 */
+	unsigned long soft_rt_next_start;
+	/*
 	 * Start time of the current weight-raising period if
 	 * the @bfq-queue is being weight-raised, otherwise
 	 * finish time of the last weight-raising period.
@@ -331,6 +346,20 @@ struct bfq_queue {
 	unsigned long last_wr_start_finish;
 	/* factor by which the weight of this queue is multiplied */
 	unsigned int wr_coeff;
+	/*
+	 * Time of the last transition of the @bfq_queue from idle to
+	 * backlogged.
+	 */
+	unsigned long last_idle_bklogged;
+	/*
+	 * Cumulative service received from the @bfq_queue since the
+	 * last transition from idle to backlogged.
+	 */
+	unsigned long service_from_backlogged;
+	/*
+	 * Value of wr start time when switching to soft rt
+	 */
+	unsigned long wr_start_at_switch_to_srt;
 };
 
 /**
@@ -488,6 +517,9 @@ struct bfq_data {
 	unsigned int bfq_wr_coeff;
 	/* maximum duration of a weight-raising period (jiffies) */
 	unsigned int bfq_wr_max_time;
+
+	/* Maximum weight-raising duration for soft real-time processes */
+	unsigned int bfq_wr_rt_max_time;
 	/*
 	 * Minimum idle period after which weight-raising may be
 	 * reactivated for a queue (in jiffies).
@@ -499,6 +531,9 @@ struct bfq_data {
 	 * queue (in jiffies).
 	 */
 	unsigned long bfq_wr_min_inter_arr_async;
+
+	/* Max service-rate for a soft real-time queue, in sectors/sec */
+	unsigned int bfq_wr_max_softrt_rate;
 	/*
 	 * Cached value of the product R*T, used for computing the
 	 * maximum duration of weight raising automatically.
@@ -540,6 +575,10 @@ enum bfqq_state_flags {
 					 * having consumed at most 2/10 of
 					 * its budget
 					 */
+	BFQ_BFQQ_FLAG_softrt_update,	/*
+					 * may need softrt-next-start
+					 * update
+					 */
 };
 
 #define BFQ_BFQQ_FNS(name)						\
@@ -563,6 +602,7 @@ BFQ_BFQQ_FNS(fifo_expire);
 BFQ_BFQQ_FNS(idle_window);
 BFQ_BFQQ_FNS(sync);
 BFQ_BFQQ_FNS(IO_bound);
+BFQ_BFQQ_FNS(softrt_update);
 #undef BFQ_BFQQ_FNS
 
 /* Logging facilities. */
@@ -3938,13 +3978,21 @@ static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq,
 					     unsigned int old_wr_coeff,
 					     bool wr_or_deserves_wr,
-					     bool interactive)
+					     bool interactive,
+					     bool soft_rt)
 {
 	if (old_wr_coeff == 1 && wr_or_deserves_wr) {
 		/* start a weight-raising period */
-		bfqq->wr_coeff = bfqd->bfq_wr_coeff;
-		/* update wr duration */
-		bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
+		if (interactive) {
+			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
+			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
+		} else {
+			bfqq->wr_start_at_switch_to_srt = jiffies;
+			bfqq->wr_coeff = bfqd->bfq_wr_coeff *
+				BFQ_SOFTRT_WEIGHT_FACTOR;
+			bfqq->wr_cur_max_time =
+				bfqd->bfq_wr_rt_max_time;
+		}
 
 		/*
 		 * If needed, further reduce budget to make sure it is
@@ -3959,8 +4007,51 @@ static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
 					    bfqq->entity.budget,
 					    2 * bfq_min_budget(bfqd));
 	} else if (old_wr_coeff > 1) {
-		/* update wr duration */
-		bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
+		if (interactive) { /* update wr coeff and duration */
+			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
+			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
+		} else if (soft_rt) {
+			/*
+			 * The application is now or still meeting the
+			 * requirements for being deemed soft rt.  We
+			 * can then correctly and safely (re)charge
+			 * the weight-raising duration for the
+			 * application with the weight-raising
+			 * duration for soft rt applications.
+			 *
+			 * In particular, doing this recharge now, i.e.,
+			 * before the weight-raising period for the
+			 * application finishes, reduces the probability
+			 * of the following negative scenario:
+			 * 1) the weight of a soft rt application is
+			 *    raised at startup (as for any newly
+			 *    created application),
+			 * 2) since the application is not interactive,
+			 *    at a certain time weight-raising is
+			 *    stopped for the application,
+			 * 3) at that time the application happens to
+			 *    still have pending requests, and hence
+			 *    is destined to not have a chance to be
+			 *    deemed soft rt before these requests are
+			 *    completed (see the comments to the
+			 *    function bfq_bfqq_softrt_next_start()
+			 *    for details on soft rt detection),
+			 * 4) these pending requests experience a high
+			 *    latency because the application is not
+			 *    weight-raised while they are pending.
+			 */
+			if (bfqq->wr_cur_max_time !=
+				bfqd->bfq_wr_rt_max_time) {
+				bfqq->wr_start_at_switch_to_srt =
+					bfqq->last_wr_start_finish;
+
+				bfqq->wr_cur_max_time =
+					bfqd->bfq_wr_rt_max_time;
+				bfqq->wr_coeff = bfqd->bfq_wr_coeff *
+					BFQ_SOFTRT_WEIGHT_FACTOR;
+			}
+			bfqq->last_wr_start_finish = jiffies;
+		}
 	}
 }
 
@@ -3979,7 +4070,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 					     struct request *rq,
 					     bool *interactive)
 {
-	bool wr_or_deserves_wr,	bfqq_wants_to_preempt,
+	bool soft_rt, wr_or_deserves_wr, bfqq_wants_to_preempt,
 		idle_for_long_time = bfq_bfqq_idle_for_long_time(bfqd, bfqq),
 		/*
 		 * See the comments on
@@ -3995,12 +4086,14 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	/*
 	 * bfqq deserves to be weight-raised if:
 	 * - it is sync,
-	 * - it has been idle for enough time.
+	 * - it has been idle for enough time or is soft real-time.
 	 */
+	soft_rt = bfqd->bfq_wr_max_softrt_rate > 0 &&
+		time_is_before_jiffies(bfqq->soft_rt_next_start);
 	*interactive = idle_for_long_time;
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
-		 (bfq_bfqq_sync(bfqq) && *interactive));
+		 (bfq_bfqq_sync(bfqq) && (*interactive || soft_rt)));
 
 	/*
 	 * Using the last flag, update budget and check whether bfqq
@@ -4025,12 +4118,17 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 		bfq_update_bfqq_wr_on_rq_arrival(bfqd, bfqq,
 						 old_wr_coeff,
 						 wr_or_deserves_wr,
-						 *interactive);
+						 *interactive,
+						 soft_rt);
 
 		if (old_wr_coeff != bfqq->wr_coeff)
 			bfqq->entity.prio_changed = 1;
 	}
 
+	bfqq->last_idle_bklogged = jiffies;
+	bfqq->service_from_backlogged = 0;
+	bfq_clear_bfqq_softrt_update(bfqq);
+
 	bfq_add_bfqq_busy(bfqd, bfqq);
 
 	/*
@@ -4044,7 +4142,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 * function bfq_bfqq_update_budg_for_activation).
 	 */
 	if (bfqd->in_service_queue && bfqq_wants_to_preempt &&
-	    bfqd->in_service_queue->wr_coeff == 1 &&
+	    bfqd->in_service_queue->wr_coeff < bfqq->wr_coeff &&
 	    next_queue_may_preempt(bfqd))
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQ_BFQQ_PREEMPTED);
@@ -4107,6 +4205,12 @@ static void bfq_add_request(struct request *rq)
 	 *   period must start or restart (this case is considered
 	 *   separately because it is not detected by the above
 	 *   conditions, if bfqq is already weight-raised)
+	 *
+	 * last_wr_start_finish has to be updated also if bfqq is soft
+	 * real-time, because the weight-raising period is constantly
+	 * restarted on idle-to-busy transitions for these queues, but
+	 * this is already done in bfq_bfqq_handle_idle_busy_switch if
+	 * needed.
 	 */
 	if (bfqd->low_latency &&
 		(old_wr_coeff == 1 || bfqq->wr_coeff == 1 || interactive))
@@ -4326,6 +4430,7 @@ static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
 {
 	bfqq->wr_coeff = 1;
 	bfqq->wr_cur_max_time = 0;
+	bfqq->last_wr_start_finish = jiffies;
 	/*
 	 * Trigger a weight change on the next invocation of
 	 * __bfq_entity_update_weight_prio.
@@ -4393,11 +4498,17 @@ static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 static void bfq_set_budget_timeout(struct bfq_data *bfqd,
 				   struct bfq_queue *bfqq)
 {
+	unsigned int timeout_coeff;
+
+	if (bfqq->wr_cur_max_time == bfqd->bfq_wr_rt_max_time)
+		timeout_coeff = 1;
+	else
+		timeout_coeff = bfqq->entity.weight / bfqq->entity.orig_weight;
+
 	bfqd->last_budget_start = ktime_get();
 
 	bfqq->budget_timeout = jiffies +
-		bfqd->bfq_timeout *
-		(bfqq->entity.weight / bfqq->entity.orig_weight);
+		bfqd->bfq_timeout * timeout_coeff;
 }
 
 static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
@@ -4409,6 +4520,42 @@ static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
 
 		bfqd->budgets_assigned = (bfqd->budgets_assigned*7 + 256) / 8;
 
+		if (time_is_before_jiffies(bfqq->last_wr_start_finish) &&
+		    bfqq->wr_coeff > 1 &&
+		    bfqq->wr_cur_max_time == bfqd->bfq_wr_rt_max_time &&
+		    time_is_before_jiffies(bfqq->budget_timeout)) {
+			/*
+			 * For soft real-time queues, move the start
+			 * of the weight-raising period forward by the
+			 * time the queue has not received any
+			 * service. Otherwise, a relatively long
+			 * service delay is likely to cause the
+			 * weight-raising period of the queue to end,
+			 * because of the short duration of the
+			 * weight-raising period of a soft real-time
+			 * queue.  It is worth noting that this move
+			 * is not so dangerous for the other queues,
+			 * because soft real-time queues are not
+			 * greedy.
+			 *
+			 * To not add a further variable, we use the
+			 * overloaded field budget_timeout to
+			 * determine for how long the queue has not
+			 * received service, i.e., how much time has
+			 * elapsed since the queue expired. However,
+			 * this is a little imprecise, because
+			 * budget_timeout is set to jiffies if bfqq
+			 * not only expires, but also remains with no
+			 * request.
+			 */
+			if (time_after(bfqq->budget_timeout,
+				       bfqq->last_wr_start_finish))
+				bfqq->last_wr_start_finish +=
+					jiffies - bfqq->budget_timeout;
+			else
+				bfqq->last_wr_start_finish = jiffies;
+		}
+
 		bfq_set_budget_timeout(bfqd, bfqq);
 		bfq_log_bfqq(bfqd, bfqq,
 			     "set_in_service_queue, cur-budget = %d",
@@ -5026,6 +5173,76 @@ static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 }
 
 /*
+ * To be deemed as soft real-time, an application must meet two
+ * requirements. First, the application must not require an average
+ * bandwidth higher than the approximate bandwidth required to playback or
+ * record a compressed high-definition video.
+ * The next function is invoked on the completion of the last request of a
+ * batch, to compute the next-start time instant, soft_rt_next_start, such
+ * that, if the next request of the application does not arrive before
+ * soft_rt_next_start, then the above requirement on the bandwidth is met.
+ *
+ * The second requirement is that the request pattern of the application is
+ * isochronous, i.e., that, after issuing a request or a batch of requests,
+ * the application stops issuing new requests until all its pending requests
+ * have been completed. After that, the application may issue a new batch,
+ * and so on.
+ * For this reason the next function is invoked to compute
+ * soft_rt_next_start only for applications that meet this requirement,
+ * whereas soft_rt_next_start is set to infinity for applications that do
+ * not.
+ *
+ * Unfortunately, even a greedy application may happen to behave in an
+ * isochronous way if the CPU load is high. In fact, the application may
+ * stop issuing requests while the CPUs are busy serving other processes,
+ * then restart, then stop again for a while, and so on. In addition, if
+ * the disk achieves a low enough throughput with the request pattern
+ * issued by the application (e.g., because the request pattern is random
+ * and/or the device is slow), then the application may meet the above
+ * bandwidth requirement too. To prevent such a greedy application to be
+ * deemed as soft real-time, a further rule is used in the computation of
+ * soft_rt_next_start: soft_rt_next_start must be higher than the current
+ * time plus the maximum time for which the arrival of a request is waited
+ * for when a sync queue becomes idle, namely bfqd->bfq_slice_idle.
+ * This filters out greedy applications, as the latter issue instead their
+ * next request as soon as possible after the last one has been completed
+ * (in contrast, when a batch of requests is completed, a soft real-time
+ * application spends some time processing data).
+ *
+ * Unfortunately, the last filter may easily generate false positives if
+ * only bfqd->bfq_slice_idle is used as a reference time interval and one
+ * or both the following cases occur:
+ * 1) HZ is so low that the duration of a jiffy is comparable to or higher
+ *    than bfqd->bfq_slice_idle. This happens, e.g., on slow devices with
+ *    HZ=100.
+ * 2) jiffies, instead of increasing at a constant rate, may stop increasing
+ *    for a while, then suddenly 'jump' by several units to recover the lost
+ *    increments. This seems to happen, e.g., inside virtual machines.
+ * To address this issue, we do not use as a reference time interval just
+ * bfqd->bfq_slice_idle, but bfqd->bfq_slice_idle plus a few jiffies. In
+ * particular we add the minimum number of jiffies for which the filter
+ * seems to be quite precise also in embedded systems and KVM/QEMU virtual
+ * machines.
+ */
+static unsigned long bfq_bfqq_softrt_next_start(struct bfq_data *bfqd,
+						struct bfq_queue *bfqq)
+{
+	return max(bfqq->last_idle_bklogged +
+		   HZ * bfqq->service_from_backlogged /
+		   bfqd->bfq_wr_max_softrt_rate,
+		   jiffies + nsecs_to_jiffies(bfqq->bfqd->bfq_slice_idle) + 4);
+}
+
+/*
+ * Return the farthest future time instant according to jiffies
+ * macros.
+ */
+static unsigned long bfq_greatest_from_now(void)
+{
+	return jiffies + MAX_JIFFY_OFFSET;
+}
+
+/*
  * Return the farthest past time instant according to jiffies
  * macros.
  */
@@ -5075,6 +5292,17 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
 	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, reason, &delta);
 
 	/*
+	 * Increase service_from_backlogged before next statement,
+	 * because the possible next invocation of
+	 * bfq_bfqq_charge_time would likely inflate
+	 * entity->service. In contrast, service_from_backlogged must
+	 * contain real service, to enable the soft real-time
+	 * heuristic to correctly compute the bandwidth consumed by
+	 * bfqq.
+	 */
+	bfqq->service_from_backlogged += entity->service;
+
+	/*
 	 * As above explained, charge slow (typically seeky) and
 	 * timed-out queues with the time and not the service
 	 * received, to favor sequential workloads.
@@ -5102,6 +5330,48 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
 	if (bfqd->low_latency && bfqq->wr_coeff == 1)
 		bfqq->last_wr_start_finish = jiffies;
 
+	if (bfqd->low_latency && bfqd->bfq_wr_max_softrt_rate > 0 &&
+	    RB_EMPTY_ROOT(&bfqq->sort_list)) {
+		/*
+		 * If we get here, and there are no outstanding
+		 * requests, then the request pattern is isochronous
+		 * (see the comments on the function
+		 * bfq_bfqq_softrt_next_start()). Thus we can compute
+		 * soft_rt_next_start. If, instead, the queue still
+		 * has outstanding requests, then we have to wait for
+		 * the completion of all the outstanding requests to
+		 * discover whether the request pattern is actually
+		 * isochronous.
+		 */
+		if (bfqq->dispatched == 0)
+			bfqq->soft_rt_next_start =
+				bfq_bfqq_softrt_next_start(bfqd, bfqq);
+		else {
+			/*
+			 * The application is still waiting for the
+			 * completion of one or more requests:
+			 * prevent it from possibly being incorrectly
+			 * deemed as soft real-time by setting its
+			 * soft_rt_next_start to infinity. In fact,
+			 * without this assignment, the application
+			 * would be incorrectly deemed as soft
+			 * real-time if:
+			 * 1) it issued a new request before the
+			 *    completion of all its in-flight
+			 *    requests, and
+			 * 2) at that time, its soft_rt_next_start
+			 *    happened to be in the past.
+			 */
+			bfqq->soft_rt_next_start =
+				bfq_greatest_from_now();
+			/*
+			 * Schedule an update of soft_rt_next_start to when
+			 * the task may be discovered to be isochronous.
+			 */
+			bfq_mark_bfqq_softrt_update(bfqq);
+		}
+	}
+
 	bfq_log_bfqq(bfqd, bfqq,
 		"expire (%d, slow %d, num_disp %d, idle_win %d)", reason,
 		slow, bfqq->dispatched, bfq_bfqq_idle_window(bfqq));
@@ -5418,12 +5688,18 @@ static void bfq_update_wr_data(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		 */
 		if (time_is_before_jiffies(bfqq->last_wr_start_finish +
 					   bfqq->wr_cur_max_time)) {
-			bfqq->last_wr_start_finish = jiffies;
-			bfq_log_bfqq(bfqd, bfqq,
-				     "wrais ending at %lu, rais_max_time %u",
-				     bfqq->last_wr_start_finish,
-				     jiffies_to_msecs(bfqq->wr_cur_max_time));
-			bfq_bfqq_end_wr(bfqq);
+			if (bfqq->wr_cur_max_time != bfqd->bfq_wr_rt_max_time ||
+			time_is_before_jiffies(bfqq->wr_start_at_switch_to_srt +
+						   bfq_wr_duration(bfqd)))
+				bfq_bfqq_end_wr(bfqq);
+			else {
+				/* switch back to interactive wr */
+				bfqq->wr_coeff = bfqd->bfq_wr_coeff;
+				bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
+				bfqq->last_wr_start_finish =
+					bfqq->wr_start_at_switch_to_srt;
+				bfqq->entity.prio_changed = 1;
+			}
 		}
 	}
 	/* Update weight both if it must be raised and if it must be lowered */
@@ -5765,6 +6041,13 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	bfqq->wr_coeff = 1;
 	bfqq->last_wr_start_finish = bfq_smallest_from_now();
+	bfqq->wr_start_at_switch_to_srt = bfq_smallest_from_now();
+
+	/*
+	 * Set to the value for which bfqq will not be deemed as
+	 * soft rt when it becomes backlogged.
+	 */
+	bfqq->soft_rt_next_start = bfq_greatest_from_now();
 
 	/* first request is almost certainly seeky */
 	bfqq->seek_history = 1;
@@ -6122,6 +6405,20 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 	bfqd->last_completion = now_ns;
 
 	/*
+	 * If we are waiting to discover whether the request pattern
+	 * of the task associated with the queue is actually
+	 * isochronous, and both requisites for this condition to hold
+	 * are now satisfied, then compute soft_rt_next_start (see the
+	 * comments on the function bfq_bfqq_softrt_next_start()). We
+	 * schedule this delayed check when bfqq expires, if it still
+	 * has in-flight requests.
+	 */
+	if (bfq_bfqq_softrt_update(bfqq) && bfqq->dispatched == 0 &&
+	    RB_EMPTY_ROOT(&bfqq->sort_list))
+		bfqq->soft_rt_next_start =
+			bfq_bfqq_softrt_next_start(bfqd, bfqq);
+
+	/*
 	 * If this is the in-service queue, check if it needs to be expired,
 	 * or if we want to idle in case it has no pending requests.
 	 */
@@ -6440,9 +6737,16 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	 * Trade-off between responsiveness and fairness.
 	 */
 	bfqd->bfq_wr_coeff = 30;
+	bfqd->bfq_wr_rt_max_time = msecs_to_jiffies(300);
 	bfqd->bfq_wr_max_time = 0;
 	bfqd->bfq_wr_min_idle_time = msecs_to_jiffies(2000);
 	bfqd->bfq_wr_min_inter_arr_async = msecs_to_jiffies(500);
+	bfqd->bfq_wr_max_softrt_rate = 7000; /*
+					      * Approximate rate required
+					      * to playback or record a
+					      * high-definition compressed
+					      * video.
+					      */
 
 	/*
 	 * Begin by assuming, optimistically, that the device is a
@@ -6590,9 +6894,11 @@ SHOW_FUNCTION(bfq_timeout_sync_show, bfqd->bfq_timeout, 1);
 SHOW_FUNCTION(bfq_strict_guarantees_show, bfqd->strict_guarantees, 0);
 SHOW_FUNCTION(bfq_low_latency_show, bfqd->low_latency, 0);
 SHOW_FUNCTION(bfq_wr_coeff_show, bfqd->bfq_wr_coeff, 0);
+SHOW_FUNCTION(bfq_wr_rt_max_time_show, bfqd->bfq_wr_rt_max_time, 1);
 SHOW_FUNCTION(bfq_wr_min_idle_time_show, bfqd->bfq_wr_min_idle_time, 1);
 SHOW_FUNCTION(bfq_wr_min_inter_arr_async_show, bfqd->bfq_wr_min_inter_arr_async,
 	1);
+SHOW_FUNCTION(bfq_wr_max_softrt_rate_show, bfqd->bfq_wr_max_softrt_rate, 0);
 #undef SHOW_FUNCTION
 
 #define USEC_SHOW_FUNCTION(__FUNC, __VAR)				\
@@ -6635,10 +6941,14 @@ STORE_FUNCTION(bfq_back_seek_penalty_store, &bfqd->bfq_back_penalty, 1,
 STORE_FUNCTION(bfq_slice_idle_store, &bfqd->bfq_slice_idle, 0, INT_MAX, 2);
 STORE_FUNCTION(bfq_wr_coeff_store, &bfqd->bfq_wr_coeff, 1, INT_MAX, 0);
 STORE_FUNCTION(bfq_wr_max_time_store, &bfqd->bfq_wr_max_time, 0, INT_MAX, 1);
+STORE_FUNCTION(bfq_wr_rt_max_time_store, &bfqd->bfq_wr_rt_max_time, 0, INT_MAX,
+		1);
 STORE_FUNCTION(bfq_wr_min_idle_time_store, &bfqd->bfq_wr_min_idle_time, 0,
 		INT_MAX, 1);
 STORE_FUNCTION(bfq_wr_min_inter_arr_async_store,
 		&bfqd->bfq_wr_min_inter_arr_async, 0, INT_MAX, 1);
+STORE_FUNCTION(bfq_wr_max_softrt_rate_store, &bfqd->bfq_wr_max_softrt_rate, 0,
+		INT_MAX, 0);
 #undef STORE_FUNCTION
 
 #define USEC_STORE_FUNCTION(__FUNC, __PTR, MIN, MAX)			\
@@ -6758,8 +7068,10 @@ static struct elv_fs_entry bfq_attrs[] = {
 	BFQ_ATTR(low_latency),
 	BFQ_ATTR(wr_coeff),
 	BFQ_ATTR(wr_max_time),
+	BFQ_ATTR(wr_rt_max_time),
 	BFQ_ATTR(wr_min_idle_time),
 	BFQ_ATTR(wr_min_inter_arr_async),
+	BFQ_ATTR(wr_max_softrt_rate),
 	BFQ_ATTR(weights),
 	__ATTR_NULL
 };
@@ -6812,7 +7124,7 @@ static struct blkcg_policy blkcg_policy_bfq = {
 static int __init bfq_init(void)
 {
 	int ret;
-	char msg[50] = "BFQ I/O-scheduler: v1";
+	char msg[50] = "BFQ I/O-scheduler: v2";
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 	ret = blkcg_policy_register(&blkcg_policy_bfq);
-- 
2.10.0
