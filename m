Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>,
	Arianna Avanzini <avanzini.arianna@gmail.com>
Subject: [PATCH V2 12/22] block, bfq: modify the peak-rate estimator
Date: Mon,  8 Aug 2016 13:15:07 +0200
Message-Id: <1470654917-4280-13-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
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

To filter out spikes, the estimated peak rate is updated only on the
expiration of queues that have been served for a long-enough time.  As
a first step, the estimator computes the device rate, R_meas, during
the service of the queue. After that, if R_est < R_meas, then R_est is
set to R_meas.

Unfortunately, our experiments highlighted the following two
problems. First, because of ZBR, depending on the locality of the
workload, the estimator may easily converge to a value that is
appropriate only for part of a disk. Second, R_est may jump (and
remain forever equal) to a much higher value than the actual device
peak rate, in case of hits in the drive cache, which may let sectors
be transferred in practice at bus rate.

To try to converge to the actual average peak rate over the disk
surface (in case of rotational devices), and to smooth the spikes
caused by the drive cache, this patch changes the estimator as
follows. In the description of the changes, we refer to a queue
containing random requests as 'seeky', according to the terminology
used in the code, and inherited from CFQ.

- First, now R_est may be updated also in case the just-expired queue,
  despite not being detected as seeky, has not been however able to
  consume all of its budget within the maximum time slice T_max. In
  fact, this is an indication that B_max is too large. Since B_max =
  T_max ∗ R_est, R_est is then probably too large, and should be
  reduced.

- Second, to filter the spikes in R_meas, a discrete low-pass filter
  is now used to update R_est instead of just keeping the highest rate
  sampled. The rationale is that the average peak rate of a disk over
  its surface is a relatively stable quantity, hence a low-pass filter
  should converge more or less quickly to the right value.

With the current values of the constants used in the filter, the
latter seems to effectively smooth fluctuations and allow the
estimator to converge to the actual peak rate with all the devices we
tested.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 block/cfq-iosched.c | 131 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 92 insertions(+), 39 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index f9612b8..e7fb5f5 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -3870,48 +3870,83 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
 			bfqq->entity.budget);
 }
 
-static unsigned long bfq_calc_max_budget(u64 peak_rate, u64 timeout)
+static unsigned long bfq_calc_max_budget(struct bfq_data *bfqd)
 {
-	unsigned long max_budget;
-
 	/*
 	 * The max_budget calculated when autotuning is equal to the
 	 * amount of sectors transferred in timeout at the
 	 * estimated peak rate.
 	 */
-	max_budget = (unsigned long)(peak_rate * 1000 *
-				     timeout >> BFQ_RATE_SHIFT);
-
-	return max_budget;
+	return bfqd->peak_rate * 1000 * jiffies_to_msecs(bfqd->bfq_timeout) >>
+		BFQ_RATE_SHIFT;
 }
 
 /*
- * In addition to updating the peak rate, checks whether the process
- * is "slow", and returns 1 if so. This slow flag is used, in addition
- * to the budget timeout, to reduce the amount of service provided to
- * seeky processes, and hence reduce their chances to lower the
- * throughput. See the code for more details.
+ * Update the read peak rate (quantity used for auto-tuning) as a
+ * function of the rate at which bfqq has been served, and check
+ * whether the process associated with bfqq is "slow". Return true if
+ * the process is slow. The slow flag is used, in addition to the
+ * budget timeout, to reduce the amount of service provided to seeky
+ * processes, and hence reduce their chances to lower the
+ * throughput. More details in the body of the function.
+ *
+ * An important observation is in order: with devices with internal
+ * queues, it is hard if ever possible to know when and for how long
+ * an I/O request is processed by the device (apart from the trivial
+ * I/O pattern where a new request is dispatched only after the
+ * previous one has been completed). This makes it hard to evaluate
+ * the real rate at which the I/O requests of each bfq_queue are
+ * served.  In fact, for an I/O scheduler like BFQ, serving a
+ * bfq_queue means just dispatching its requests during its service
+ * slot, i.e., until the budget of the queue is exhausted, or the
+ * queue remains idle, or, finally, a timeout fires. But, during the
+ * service slot of a bfq_queue, the device may be still processing
+ * requests of bfq_queues served in previous service slots. On the
+ * opposite end, the requests of the in-service bfq_queue may be
+ * completed after the service slot of the queue finishes. Anyway,
+ * unless more sophisticated solutions are used (where possible), the
+ * sum of the sizes of the requests dispatched during the service slot
+ * of a bfq_queue is probably the only approximation available for
+ * the service received by the bfq_queue during its service slot. And,
+ * as written above, this sum is the quantity used in this function to
+ * evaluate the peak rate.
  */
 static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct bfq_queue *bfqq,
-				 bool compensate)
+				 bool compensate, enum bfqq_expiration reason,
+				 unsigned long *delta_ms)
 {
-	u64 bw, usecs, expected, timeout;
-	ktime_t delta;
+	u64 expected;
+	u64 bw, bwdiv10, delta_usecs, delta_ms_tmp;
+	ktime_t delta_ktime;
 	int update = 0;
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
 
 	/* Don't trust short/unrealistic values. */
-	if (usecs < 100 || usecs >= LONG_MAX)
-		return false;
+	if (delta_usecs < 1000 || delta_usecs >= LONG_MAX) {
+		if (blk_queue_nonrot(bfqd->queue))
+			*delta_ms = BFQ_MIN_TT; /*
+						 * provide same worst-case
+						 * guarantees as idling for
+						 * seeky
+						 */
+		else /* Charge at least one seek */
+			*delta_ms = jiffies_to_msecs(bfq_slice_idle);
+		return slow;
+	}
+
+	delta_ms_tmp = delta_usecs;
+	do_div(delta_ms_tmp, 1000);
+	*delta_ms = delta_ms_tmp;
 
 	/*
 	 * Calculate the bandwidth for the last slice.  We use a 64 bit
@@ -3920,19 +3955,38 @@ static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * and to avoid overflows.
 	 */
 	bw = (u64)bfqq->entity.service << BFQ_RATE_SHIFT;
-	do_div(bw, (unsigned long)usecs);
-
-	timeout = jiffies_to_msecs(bfqd->bfq_timeout);
+	do_div(bw, (unsigned long)delta_usecs);
 
 	/*
 	 * Use only long (> 20ms) intervals to filter out spikes for
 	 * the peak rate estimation.
 	 */
-	if (usecs > 20000) {
-		if (bw > bfqd->peak_rate) {
-			bfqd->peak_rate = bw;
+	if (delta_usecs > 20000) {
+		bool fully_sequential = bfqq->seek_history == 0;
+		bool consumed_large_budget =
+			reason == BFQ_BFQQ_BUDGET_EXHAUSTED &&
+			bfqq->entity.budget >= bfqd->bfq_max_budget * 2 / 3;
+		bool served_for_long_time =
+			reason == BFQ_BFQQ_BUDGET_TIMEOUT ||
+			consumed_large_budget;
+
+		if (bw > bfqd->peak_rate ||
+		    (bfq_bfqq_sync(bfqq) && fully_sequential &&
+		     served_for_long_time)) {
+			/*
+			 * To smooth oscillations use a low-pass filter with
+			 * alpha=9/10, i.e.,
+			 * new_rate = (9/10) * old_rate + (1/10) * bw
+			 */
+			bwdiv10 = bw;
+			do_div(bwdiv10, 10);
+			if (bwdiv10 == 0)
+				return false; /* bw too low to be used */
+			bfqd->peak_rate *= 9;
+			do_div(bfqd->peak_rate, 10);
+			bfqd->peak_rate += bwdiv10;
 			update = 1;
-			bfq_log(bfqd, "new peak_rate=%llu", bw);
+			bfq_log(bfqd, "new peak_rate=%llu", bfqd->peak_rate);
 		}
 
 		update |= bfqd->peak_rate_samples == BFQ_PEAK_RATE_SAMPLES - 1;
@@ -3942,10 +3996,8 @@ static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 		if (bfqd->peak_rate_samples == BFQ_PEAK_RATE_SAMPLES &&
 		    update && bfqd->bfq_user_max_budget == 0) {
-			bfqd->bfq_max_budget =
-				bfq_calc_max_budget(bfqd->peak_rate,
-						    timeout);
-			bfq_log(bfqd, "new max_budget=%d",
+			bfqd->bfq_max_budget = bfq_calc_max_budget(bfqd);
+			bfq_log(bfqd, "new max_budget = %d",
 				bfqd->bfq_max_budget);
 		}
 	}
@@ -3958,7 +4010,8 @@ static bool bfq_update_peak_rate(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	 * rate that would not be high enough to complete the budget
 	 * before the budget timeout expiration.
 	 */
-	expected = bw * 1000 * timeout >> BFQ_RATE_SHIFT;
+	expected = bw * 1000 * jiffies_to_msecs(bfqd->bfq_timeout)
+		>> BFQ_RATE_SHIFT;
 
 	/*
 	 * Caveat: processes doing IO in the slower disk zones will
@@ -4016,12 +4069,14 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
 			    enum bfqq_expiration reason)
 {
 	bool slow;
+	unsigned long delta = 0;
+	struct bfq_entity *entity = &bfqq->entity;
 
 	/*
 	 * Update device peak rate for autotuning and check whether the
 	 * process is slow (see bfq_update_peak_rate).
 	 */
-	slow = bfq_update_peak_rate(bfqd, bfqq, compensate);
+	slow = bfq_update_peak_rate(bfqd, bfqq, compensate, reason, &delta);
 
 	/*
 	 * As above explained, 'punish' slow (i.e., seeky), timed-out
@@ -4031,7 +4086,7 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
 		bfq_bfqq_charge_full_budget(bfqq);
 
 	if (reason == BFQ_BFQQ_TOO_IDLE &&
-	    bfqq->entity.service <= 2 * bfqq->entity.budget / 10)
+	    entity->service <= 2 * entity->budget / 10)
 		bfq_clear_bfqq_IO_bound(bfqq);
 
 	bfq_log_bfqq(bfqd, bfqq,
@@ -5318,10 +5373,8 @@ static ssize_t bfq_weights_store(struct elevator_queue *e,
 
 static unsigned long bfq_estimated_max_budget(struct bfq_data *bfqd)
 {
-	u64 timeout = jiffies_to_msecs(bfqd->bfq_timeout);
-
 	if (bfqd->peak_rate_samples >= BFQ_PEAK_RATE_SAMPLES)
-		return bfq_calc_max_budget(bfqd->peak_rate, timeout);
+		return bfq_calc_max_budget(bfqd);
 	else
 		return bfq_default_max_budget;
 }
-- 
1.9.1
