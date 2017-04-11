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
Subject: [PATCH V3 04/16] block, bfq: modify the peak-rate estimator
Date: Tue, 11 Apr 2017 15:43:03 +0200
Message-Id: <20170411134315.44135-5-paolo.valente@linaro.org>
In-Reply-To: <20170411134315.44135-1-paolo.valente@linaro.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Unless the maximum budget B_max that BFQ can assign to a queue is set
explicitly by the user, BFQ automatically updates B_max. In
particular, BFQ dynamically sets B_max to the number of sectors that
can be read, at the current estimated peak rate, during the maximum
time, T_max, allowed before a budget timeout occurs. In formulas, if
we denote as R_est the estimated peak rate, then B_max = T_max ∗
R_est. Hence, the higher R_est is with respect to the actual device
peak rate, the higher the probability that processes incur budget
timeouts unjustly is. Besides, a too high value of B_max unnecessarily
increases the deviation from an ideal, smooth service.

Unfortunately, it is not trivial to estimate the peak rate correctly:
because of the presence of sw and hw queues between the scheduler and
the device components that finally serve I/O requests, it is hard to
say exactly when a given dispatched request is served inside the
device, and for how long. As a consequence, it is hard to know
precisely at what rate a given set of requests is actually served by
the device.

On the opposite end, the dispatch time of any request is trivially
available, and, from this piece of information, the "dispatch rate"
of requests can be immediately computed. So, the idea in the next
function is to use what is known, namely request dispatch times
(plus, when useful, request completion times), to estimate what is
unknown, namely in-device request service rate.

The main issue is that, because of the above facts, the rate at
which a certain set of requests is dispatched over a certain time
interval can vary greatly with respect to the rate at which the
same requests are then served. But, since the size of any
intermediate queue is limited, and the service scheme is lossless
(no request is silently dropped), the following obvious convergence
property holds: the number of requests dispatched MUST become
closer and closer to the number of requests completed as the
observation interval grows. This is the key property used in
this new version of the peak-rate estimator.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/bfq-iosched.c | 495 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 371 insertions(+), 124 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 553aee1..61d880b 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -407,19 +407,37 @@ struct bfq_data {
 	/* on-disk position of the last served request */
 	sector_t last_position;
 
+	/* time of last request completion (ns) */
+	u64 last_completion;
+
+	/* time of first rq dispatch in current observation interval (ns) */
+	u64 first_dispatch;
+	/* time of last rq dispatch in current observation interval (ns) */
+	u64 last_dispatch;
+
 	/* beginning of the last budget */
 	ktime_t last_budget_start;
 	/* beginning of the last idle slice */
 	ktime_t last_idling_start;
-	/* number of samples used to calculate @peak_rate */
+
+	/* number of samples in current observation interval */
 	int peak_rate_samples;
+	/* num of samples of seq dispatches in current observation interval */
+	u32 sequential_samples;
+	/* total num of sectors transferred in current observation interval */
+	u64 tot_sectors_dispatched;
+	/* max rq size seen during current observation interval (sectors) */
+	u32 last_rq_max_size;
+	/* time elapsed from first dispatch in current observ. interval (us) */
+	u64 delta_from_first;
 	/*
-	 * Peak read/write rate, observed during the service of a
-	 * budget [BFQ_RATE_SHIFT * sectors/usec]. The value is
-	 * left-shifted by BFQ_RATE_SHIFT to increase precision in
+	 * Current estimate of the device peak rate, measured in
+	 * [BFQ_RATE_SHIFT * sectors/usec]. The left-shift by
+	 * BFQ_RATE_SHIFT is performed to increase precision in
 	 * fixed-point calculations.
 	 */
-	u64 peak_rate;
+	u32 peak_rate;
+
 	/* maximum budget allotted to a bfq_queue before rescheduling */
 	int bfq_max_budget;
 
@@ -740,7 +758,7 @@ static const int bfq_timeout = HZ / 8;
 
 static struct kmem_cache *bfq_pool;
 
-/* Below this threshold (in ms), we consider thinktime immediate. */
+/* Below this threshold (in ns), we consider thinktime immediate. */
 #define BFQ_MIN_TT		(2 * NSEC_PER_MSEC)
 
 /* hw_tag detection: parallel requests threshold and min samples needed. */
@@ -752,8 +770,12 @@ static struct kmem_cache *bfq_pool;
 #define BFQQ_CLOSE_THR		(sector_t)(8 * 1024)
 #define BFQQ_SEEKY(bfqq)	(hweight32(bfqq->seek_history) > 32/8)
 
-/* Min samples used for peak rate estimation (for autotuning). */
-#define BFQ_PEAK_RATE_SAMPLES	32
+/* Min number of samples required to perform peak-rate update */
+#define BFQ_RATE_MIN_SAMPLES	32
+/* Min observation time interval required to perform a peak-rate update (ns) */
+#define BFQ_RATE_MIN_INTERVAL	(300*NSEC_PER_MSEC)
+/* Target observation time interval for a peak-rate update (ns) */
+#define BFQ_RATE_REF_INTERVAL	NSEC_PER_SEC
 
 /* Shift used for peak rate fixed precision calculations. */
 #define BFQ_RATE_SHIFT		16
@@ -3837,15 +3859,20 @@ static struct request *bfq_find_rq_fmerge(struct bfq_data *bfqd,
 	return NULL;
 }
 
+static sector_t get_sdist(sector_t last_pos, struct request *rq)
+{
+	if (last_pos)
+		return abs(blk_rq_pos(rq) - last_pos);
+
+	return 0;
+}
+
 #if 0 /* Still not clear if we can do without next two functions */
 static void bfq_activate_request(struct request_queue *q, struct request *rq)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 
 	bfqd->rq_in_driver++;
-	bfqd->last_position = blk_rq_pos(rq) + blk_rq_sectors(rq);
-	bfq_log(bfqd, "activate_request: new bfqd->last_position %llu",
-		(unsigned long long)bfqd->last_position);
 }
 
 static void bfq_deactivate_request(struct request_queue *q, struct request *rq)
@@ -4124,6 +4151,227 @@ static void bfq_set_budget_timeout(struct bfq_data *bfqd)
 }
 
 /*
+ * In autotuning mode, max_budget is dynamically recomputed as the
+ * amount of sectors transferred in timeout at the estimated peak
+ * rate. This enables BFQ to utilize a full timeslice with a full
+ * budget, even if the in-service queue is served at peak rate. And
+ * this maximises throughput with sequential workloads.
+ */
+static unsigned long bfq_calc_max_budget(struct bfq_data *bfqd)
+{
+	return (u64)bfqd->peak_rate * USEC_PER_MSEC *
+		jiffies_to_msecs(bfqd->bfq_timeout)>>BFQ_RATE_SHIFT;
+}
+
+static void bfq_reset_rate_computation(struct bfq_data *bfqd,
+				       struct request *rq)
+{
+	if (rq != NULL) { /* new rq dispatch now, reset accordingly */
+		bfqd->last_dispatch = bfqd->first_dispatch = ktime_get_ns();
+		bfqd->peak_rate_samples = 1;
+		bfqd->sequential_samples = 0;
+		bfqd->tot_sectors_dispatched = bfqd->last_rq_max_size =
+			blk_rq_sectors(rq);
+	} else /* no new rq dispatched, just reset the number of samples */
+		bfqd->peak_rate_samples = 0; /* full re-init on next disp. */
+
+	bfq_log(bfqd,
+		"reset_rate_computation at end, sample %u/%u tot_sects %llu",
+		bfqd->peak_rate_samples, bfqd->sequential_samples,
+		bfqd->tot_sectors_dispatched);
+}
+
+static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
+{
+	u32 rate, weight, divisor;
+
+	/*
+	 * For the convergence property to hold (see comments on
+	 * bfq_update_peak_rate()) and for the assessment to be
+	 * reliable, a minimum number of samples must be present, and
+	 * a minimum amount of time must have elapsed. If not so, do
+	 * not compute new rate. Just reset parameters, to get ready
+	 * for a new evaluation attempt.
+	 */
+	if (bfqd->peak_rate_samples < BFQ_RATE_MIN_SAMPLES ||
+	    bfqd->delta_from_first < BFQ_RATE_MIN_INTERVAL)
+		goto reset_computation;
+
+	/*
+	 * If a new request completion has occurred after last
+	 * dispatch, then, to approximate the rate at which requests
+	 * have been served by the device, it is more precise to
+	 * extend the observation interval to the last completion.
+	 */
+	bfqd->delta_from_first =
+		max_t(u64, bfqd->delta_from_first,
+		      bfqd->last_completion - bfqd->first_dispatch);
+
+	/*
+	 * Rate computed in sects/usec, and not sects/nsec, for
+	 * precision issues.
+	 */
+	rate = div64_ul(bfqd->tot_sectors_dispatched<<BFQ_RATE_SHIFT,
+			div_u64(bfqd->delta_from_first, NSEC_PER_USEC));
+
+	/*
+	 * Peak rate not updated if:
+	 * - the percentage of sequential dispatches is below 3/4 of the
+	 *   total, and rate is below the current estimated peak rate
+	 * - rate is unreasonably high (> 20M sectors/sec)
+	 */
+	if ((bfqd->sequential_samples < (3 * bfqd->peak_rate_samples)>>2 &&
+	     rate <= bfqd->peak_rate) ||
+		rate > 20<<BFQ_RATE_SHIFT)
+		goto reset_computation;
+
+	/*
+	 * We have to update the peak rate, at last! To this purpose,
+	 * we use a low-pass filter. We compute the smoothing constant
+	 * of the filter as a function of the 'weight' of the new
+	 * measured rate.
+	 *
+	 * As can be seen in next formulas, we define this weight as a
+	 * quantity proportional to how sequential the workload is,
+	 * and to how long the observation time interval is.
+	 *
+	 * The weight runs from 0 to 8. The maximum value of the
+	 * weight, 8, yields the minimum value for the smoothing
+	 * constant. At this minimum value for the smoothing constant,
+	 * the measured rate contributes for half of the next value of
+	 * the estimated peak rate.
+	 *
+	 * So, the first step is to compute the weight as a function
+	 * of how sequential the workload is. Note that the weight
+	 * cannot reach 9, because bfqd->sequential_samples cannot
+	 * become equal to bfqd->peak_rate_samples, which, in its
+	 * turn, holds true because bfqd->sequential_samples is not
+	 * incremented for the first sample.
+	 */
+	weight = (9 * bfqd->sequential_samples) / bfqd->peak_rate_samples;
+
+	/*
+	 * Second step: further refine the weight as a function of the
+	 * duration of the observation interval.
+	 */
+	weight = min_t(u32, 8,
+		       div_u64(weight * bfqd->delta_from_first,
+			       BFQ_RATE_REF_INTERVAL));
+
+	/*
+	 * Divisor ranging from 10, for minimum weight, to 2, for
+	 * maximum weight.
+	 */
+	divisor = 10 - weight;
+
+	/*
+	 * Finally, update peak rate:
+	 *
+	 * peak_rate = peak_rate * (divisor-1) / divisor  +  rate / divisor
+	 */
+	bfqd->peak_rate *= divisor-1;
+	bfqd->peak_rate /= divisor;
+	rate /= divisor; /* smoothing constant alpha = 1/divisor */
+
+	bfqd->peak_rate += rate;
+	if (bfqd->bfq_user_max_budget == 0)
+		bfqd->bfq_max_budget =
+			bfq_calc_max_budget(bfqd);
+
+reset_computation:
+	bfq_reset_rate_computation(bfqd, rq);
+}
+
+/*
+ * Update the read/write peak rate (the main quantity used for
+ * auto-tuning, see update_thr_responsiveness_params()).
+ *
+ * It is not trivial to estimate the peak rate (correctly): because of
+ * the presence of sw and hw queues between the scheduler and the
+ * device components that finally serve I/O requests, it is hard to
+ * say exactly when a given dispatched request is served inside the
+ * device, and for how long. As a consequence, it is hard to know
+ * precisely at what rate a given set of requests is actually served
+ * by the device.
+ *
+ * On the opposite end, the dispatch time of any request is trivially
+ * available, and, from this piece of information, the "dispatch rate"
+ * of requests can be immediately computed. So, the idea in the next
+ * function is to use what is known, namely request dispatch times
+ * (plus, when useful, request completion times), to estimate what is
+ * unknown, namely in-device request service rate.
+ *
+ * The main issue is that, because of the above facts, the rate at
+ * which a certain set of requests is dispatched over a certain time
+ * interval can vary greatly with respect to the rate at which the
+ * same requests are then served. But, since the size of any
+ * intermediate queue is limited, and the service scheme is lossless
+ * (no request is silently dropped), the following obvious convergence
+ * property holds: the number of requests dispatched MUST become
+ * closer and closer to the number of requests completed as the
+ * observation interval grows. This is the key property used in
+ * the next function to estimate the peak service rate as a function
+ * of the observed dispatch rate. The function assumes to be invoked
+ * on every request dispatch.
+ */
+static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
+{
+	u64 now_ns = ktime_get_ns();
+
+	if (bfqd->peak_rate_samples == 0) { /* first dispatch */
+		bfq_log(bfqd, "update_peak_rate: goto reset, samples %d",
+			bfqd->peak_rate_samples);
+		bfq_reset_rate_computation(bfqd, rq);
+		goto update_last_values; /* will add one sample */
+	}
+
+	/*
+	 * Device idle for very long: the observation interval lasting
+	 * up to this dispatch cannot be a valid observation interval
+	 * for computing a new peak rate (similarly to the late-
+	 * completion event in bfq_completed_request()). Go to
+	 * update_rate_and_reset to have the following three steps
+	 * taken:
+	 * - close the observation interval at the last (previous)
+	 *   request dispatch or completion
+	 * - compute rate, if possible, for that observation interval
+	 * - start a new observation interval with this dispatch
+	 */
+	if (now_ns - bfqd->last_dispatch > 100*NSEC_PER_MSEC &&
+	    bfqd->rq_in_driver == 0)
+		goto update_rate_and_reset;
+
+	/* Update sampling information */
+	bfqd->peak_rate_samples++;
+
+	if ((bfqd->rq_in_driver > 0 ||
+		now_ns - bfqd->last_completion < BFQ_MIN_TT)
+	     && get_sdist(bfqd->last_position, rq) < BFQQ_SEEK_THR)
+		bfqd->sequential_samples++;
+
+	bfqd->tot_sectors_dispatched += blk_rq_sectors(rq);
+
+	/* Reset max observed rq size every 32 dispatches */
+	if (likely(bfqd->peak_rate_samples % 32))
+		bfqd->last_rq_max_size =
+			max_t(u32, blk_rq_sectors(rq), bfqd->last_rq_max_size);
+	else
+		bfqd->last_rq_max_size = blk_rq_sectors(rq);
+
+	bfqd->delta_from_first = now_ns - bfqd->first_dispatch;
+
+	/* Target observation interval not yet reached, go on sampling */
+	if (bfqd->delta_from_first < BFQ_RATE_REF_INTERVAL)
+		goto update_last_values;
+
+update_rate_and_reset:
+	bfq_update_rate_reset(bfqd, rq);
+update_last_values:
+	bfqd->last_position = blk_rq_pos(rq) + blk_rq_sectors(rq);
+	bfqd->last_dispatch = now_ns;
+}
+
+/*
  * Remove request from internal lists.
  */
 static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
@@ -4143,6 +4391,7 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 	 * happens to be taken into account.
 	 */
 	bfqq->dispatched++;
+	bfq_update_peak_rate(q->elevator->elevator_data, rq);
 
 	bfq_remove_request(q, rq);
 }
@@ -4323,110 +4572,92 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
 			bfqq->entity.budget);
 }
 
-static unsigned long bfq_calc_max_budget(u64 peak_rate, u64 timeout)
-{
-	unsigned long max_budget;
-
-	/*
-	 * The max_budget calculated when autotuning is equal to the
-	 * amount of sectors transferred in timeout at the estimated
-	 * peak rate. To get this value, peak_rate is, first,
-	 * multiplied by 1000, because timeout is measured in ms,
-	 * while peak_rate is measured in sectors/usecs. Then the
-	 * result of this multiplication is right-shifted by
-	 * BFQ_RATE_SHIFT, because peak_rate is equal to the value of
-	 * the peak rate left-shifted by BFQ_RATE_SHIFT.
-	 */
-	max_budget = (unsigned long)(peak_rate * 1000 *
-				     timeout >> BFQ_RATE_SHIFT);
-
-	return max_budget;
-}
-
 /*
- * In addition to updating the peak rate, checks whether the process
- * is "slow", and returns 1 if so. This slow flag is used, in addition
- * to the budget timeout, to reduce the amount of service provided to
- * seeky processes, and hence reduce their chances to lower the
- * throughput. See the code for more details.
+ * Return true if the process associated with bfqq is "slow". The slow
+ * flag is used, in addition to the budget timeout, to reduce the
+ * amount of service provided to seeky processes, and thus reduce
+ * their chances to lower the throughput. More details in the comments
+ * on the function bfq_bfqq_expire().
+ *
+ * An important observation is in order: as discussed in the comments
+ * on the function bfq_update_peak_rate(), with devices with internal
+ * queues, it is hard if ever possible to know when and for how long
+ * an I/O request is processed by the device (apart from the trivial
+ * I/O pattern where a new request is dispatched only after the
+ * previous one has been completed). This makes it hard to evaluate
+ * the real rate at which the I/O requests of each bfq_queue are
+ * served.  In fact, for an I/O scheduler like BFQ, serving a
+ * bfq_queue means just dispatching its requests during its service
+ * slot (i.e., until the budget of the queue is exhausted, or the
+ * queue remains idle, or, finally, a timeout fires). But, during the
+ * service slot of a bfq_queue, around 100 ms at most, the device may
+ * be even still processing requests of bfq_queues served in previous
+ * service slots. On the opposite end, the requests of the in-service
+ * bfq_queue may be completed after the service slot of the queue
+ * finishes.
+ *
+ * Anyway, unless more sophisticated solutions are used
+ * (where possible), the sum of the sizes of the requests dispatched
+ * during the service slot of a bfq_queue is probably the only
+ * approximation available for the service received by the bfq_queue
+ * during its service slot. And this sum is the quantity used in this
+ * function to evaluate the I/O speed of a process.
  */
-static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-				 bool compensate)
+static bool bfq_bfqq_is_slow(struct bfq_data *bfqd, struct bfq_queue *bfqq,
+				 bool compensate, enum bfqq_expiration reason,
+				 unsigned long *delta_ms)
 {
-	u64 bw, usecs, expected, timeout;
-	ktime_t delta;
-	int update = 0;
+	ktime_t delta_ktime;
+	u32 delta_usecs;
+	bool slow = BFQQ_SEEKY(bfqq); /* if delta too short, use seekyness */
 
-	if (!bfq_bfqq_sync(bfqq) || bfq_bfqq_budget_new(bfqq))
+	if (!bfq_bfqq_sync(bfqq))
 		return false;
 
 	if (compensate)
-		delta = bfqd->last_idling_start;
+		delta_ktime = bfqd->last_idling_start;
 	else
-		delta = ktime_get();
-	delta = ktime_sub(delta, bfqd->last_budget_start);
-	usecs = ktime_to_us(delta);
+		delta_ktime = ktime_get();
+	delta_ktime = ktime_sub(delta_ktime, bfqd->last_budget_start);
+	delta_usecs = ktime_to_us(delta_ktime);
 
 	/* don't use too short time intervals */
 	if (delta_usecs < 1000) {
-		return false;
-
-	/*
-	 * Calculate the bandwidth for the last slice.  We use a 64 bit
-	 * value to store the peak rate, in sectors per usec in fixed
-	 * point math.  We do so to have enough precision in the estimate
-	 * and to avoid overflows.
-	 */
-	bw = (u64)bfqq->entity.service << BFQ_RATE_SHIFT;
-	do_div(bw, (unsigned long)usecs);
+		if (blk_queue_nonrot(bfqd->queue))
+			 /*
+			  * give same worst-case guarantees as idling
+			  * for seeky
+			  */
+			*delta_ms = BFQ_MIN_TT / NSEC_PER_MSEC;
+		else /* charge at least one seek */
+			*delta_ms = bfq_slice_idle / NSEC_PER_MSEC;
+
+		return slow;
+	}
 
-	timeout = jiffies_to_msecs(bfqd->bfq_timeout);
+	*delta_ms = delta_usecs / USEC_PER_MSEC;
 
 	/*
-	 * Use only long (> 20ms) intervals to filter out spikes for
-	 * the peak rate estimation.
+	 * Use only long (> 20ms) intervals to filter out excessive
+	 * spikes in service rate estimation.
 	 */
-	if (usecs > 20000) {
-		if (bw > bfqd->peak_rate) {
-			bfqd->peak_rate = bw;
-			update = 1;
-			bfq_log(bfqd, "new peak_rate=%llu", bw);
-		}
-
-		update |= bfqd->peak_rate_samples == BFQ_PEAK_RATE_SAMPLES - 1;
-
-		if (bfqd->peak_rate_samples < BFQ_PEAK_RATE_SAMPLES)
-			bfqd->peak_rate_samples++;
-
-		if (bfqd->peak_rate_samples == BFQ_PEAK_RATE_SAMPLES &&
-		    update && bfqd->bfq_user_max_budget == 0) {
-			bfqd->bfq_max_budget =
-				bfq_calc_max_budget(bfqd->peak_rate,
-						    timeout);
-			bfq_log(bfqd, "new max_budget=%d",
-				bfqd->bfq_max_budget);
-		}
+	if (delta_usecs > 20000) {
+		/*
+		 * Caveat for rotational devices: processes doing I/O
+		 * in the slower disk zones tend to be slow(er) even
+		 * if not seeky. In this respect, the estimated peak
+		 * rate is likely to be an average over the disk
+		 * surface. Accordingly, to not be too harsh with
+		 * unlucky processes, a process is deemed slow only if
+		 * its rate has been lower than half of the estimated
+		 * peak rate.
+		 */
+		slow = bfqq->entity.service < bfqd->bfq_max_budget / 2;
 	}
 
-	/*
-	 * A process is considered ``slow'' (i.e., seeky, so that we
-	 * cannot treat it fairly in the service domain, as it would
-	 * slow down too much the other processes) if, when a slice
-	 * ends for whatever reason, it has received service at a
-	 * rate that would not be high enough to complete the budget
-	 * before the budget timeout expiration.
-	 */
-	expected = bw * 1000 * timeout >> BFQ_RATE_SHIFT;
+	bfq_log_bfqq(bfqd, bfqq, "bfq_bfqq_is_slow: slow %d", slow);
 
-	/*
-	 * Caveat: processes doing IO in the slower disk zones will
-	 * tend to be slow(er) even if not seeky. And the estimated
-	 * peak rate will actually be an average over the disk
-	 * surface. Hence, to not be too harsh with unlucky processes,
-	 * we keep a budget/3 margin of safety before declaring a
-	 * process slow.
-	 */
-	return expected > (4 * bfqq->entity.budget) / 3;
+	return slow;
 }
 
 /*
@@ -4474,13 +4705,14 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
 			    enum bfqq_expiration reason)
 {
 	bool slow;
+	unsigned long delta = 0;
+	struct bfq_entity *entity = &bfqq->entity;
 	int ref;
 
 	/*
-	 * Update device peak rate for autotuning and check whether the
-	 * process is slow (see bfq_update_peak_rate).
+	 * Check whether the process is slow (see bfq_bfqq_is_slow).
 	 */
-	slow = bfq_update_peak_rate(bfqd, bfqq, compensate);
+	slow = bfq_bfqq_is_slow(bfqd, bfqq, compensate, reason, &delta);
 
 	/*
 	 * As above explained, 'punish' slow (i.e., seeky), timed-out
@@ -4490,7 +4722,7 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
 		bfq_bfqq_charge_full_budget(bfqq);
 
 	if (reason == BFQQE_TOO_IDLE &&
-	    bfqq->entity.service <= 2 * bfqq->entity.budget / 10)
+	    entity->service <= 2 * entity->budget / 10)
 		bfq_clear_bfqq_IO_bound(bfqq);
 
 	bfq_log_bfqq(bfqd, bfqq,
@@ -5130,17 +5362,9 @@ static void
 bfq_update_io_seektime(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		       struct request *rq)
 {
-	sector_t sdist = 0;
-
-	if (bfqq->last_request_pos) {
-		if (bfqq->last_request_pos < blk_rq_pos(rq))
-			sdist = blk_rq_pos(rq) - bfqq->last_request_pos;
-		else
-			sdist = bfqq->last_request_pos - blk_rq_pos(rq);
-	}
-
 	bfqq->seek_history <<= 1;
-	bfqq->seek_history |= sdist > BFQQ_SEEK_THR &&
+	bfqq->seek_history |=
+		get_sdist(bfqq->last_request_pos, rq) > BFQQ_SEEK_THR &&
 		(!blk_queue_nonrot(bfqd->queue) ||
 		 blk_rq_sectors(rq) < BFQQ_SECT_THR_NONROT);
 }
@@ -5336,12 +5560,45 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 
 static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 {
+	u64 now_ns;
+	u32 delta_us;
+
 	bfq_update_hw_tag(bfqd);
 
 	bfqd->rq_in_driver--;
 	bfqq->dispatched--;
 
-	bfqq->ttime.last_end_request = ktime_get_ns();
+	now_ns = ktime_get_ns();
+
+	bfqq->ttime.last_end_request = now_ns;
+
+	/*
+	 * Using us instead of ns, to get a reasonable precision in
+	 * computing rate in next check.
+	 */
+	delta_us = div_u64(now_ns - bfqd->last_completion, NSEC_PER_USEC);
+
+	/*
+	 * If the request took rather long to complete, and, according
+	 * to the maximum request size recorded, this completion latency
+	 * implies that the request was certainly served at a very low
+	 * rate (less than 1M sectors/sec), then the whole observation
+	 * interval that lasts up to this time instant cannot be a
+	 * valid time interval for computing a new peak rate.  Invoke
+	 * bfq_update_rate_reset to have the following three steps
+	 * taken:
+	 * - close the observation interval at the last (previous)
+	 *   request dispatch or completion
+	 * - compute rate, if possible, for that observation interval
+	 * - reset to zero samples, which will trigger a proper
+	 *   re-initialization of the observation interval on next
+	 *   dispatch
+	 */
+	if (delta_us > BFQ_MIN_TT/NSEC_PER_USEC &&
+	   (bfqd->last_rq_max_size<<BFQ_RATE_SHIFT)/delta_us <
+			1UL<<(BFQ_RATE_SHIFT - 10))
+		bfq_update_rate_reset(bfqd, NULL);
+	bfqd->last_completion = now_ns;
 
 	/*
 	 * If this is the in-service queue, check if it needs to be expired,
@@ -5799,16 +6056,6 @@ USEC_STORE_FUNCTION(bfq_slice_idle_us_store, &bfqd->bfq_slice_idle, 0,
 		    UINT_MAX);
 #undef USEC_STORE_FUNCTION
 
-static unsigned long bfq_estimated_max_budget(struct bfq_data *bfqd)
-{
-	u64 timeout = jiffies_to_msecs(bfqd->bfq_timeout);
-
-	if (bfqd->peak_rate_samples >= BFQ_PEAK_RATE_SAMPLES)
-		return bfq_calc_max_budget(bfqd->peak_rate, timeout);
-	else
-		return bfq_default_max_budget;
-}
-
 static ssize_t bfq_max_budget_store(struct elevator_queue *e,
 				    const char *page, size_t count)
 {
@@ -5817,7 +6064,7 @@ static ssize_t bfq_max_budget_store(struct elevator_queue *e,
 	int ret = bfq_var_store(&__data, (page), count);
 
 	if (__data == 0)
-		bfqd->bfq_max_budget = bfq_estimated_max_budget(bfqd);
+		bfqd->bfq_max_budget = bfq_calc_max_budget(bfqd);
 	else {
 		if (__data > INT_MAX)
 			__data = INT_MAX;
@@ -5847,7 +6094,7 @@ static ssize_t bfq_timeout_sync_store(struct elevator_queue *e,
 
 	bfqd->bfq_timeout = msecs_to_jiffies(__data);
 	if (bfqd->bfq_user_max_budget == 0)
-		bfqd->bfq_max_budget = bfq_estimated_max_budget(bfqd);
+		bfqd->bfq_max_budget = bfq_calc_max_budget(bfqd);
 
 	return ret;
 }
-- 
2.10.0
