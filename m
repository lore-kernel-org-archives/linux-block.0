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
Subject: [PATCH V2 06/16] block, bfq: improve responsiveness
Date: Fri, 31 Mar 2017 14:47:33 +0200
Message-Id: <20170331124743.3530-7-paolo.valente@linaro.org>
In-Reply-To: <20170331124743.3530-1-paolo.valente@linaro.org>
References: <20170331124743.3530-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

This patch introduces a simple heuristic to load applications quickly,
and to perform the I/O requested by interactive applications just as
quickly. To this purpose, both a newly-created queue and a queue
associated with an interactive application (we explain in a moment how
BFQ decides whether the associated application is interactive),
receive the following two special treatments:

1) The weight of the queue is raised.

2) The queue unconditionally enjoys device idling when it empties; in
fact, if the requests of a queue are sync, then performing device
idling for the queue is a necessary condition to guarantee that the
queue receives a fraction of the throughput proportional to its weight
(see [1] for details).

For brevity, we call just weight-raising the combination of these
two preferential treatments. For a newly-created queue,
weight-raising starts immediately and lasts for a time interval that:
1) depends on the device speed and type (rotational or
non-rotational), and 2) is equal to the time needed to load (start up)
a large-size application on that device, with cold caches and with no
additional workload.

Finally, as for guaranteeing a fast execution to interactive,
I/O-related tasks (such as opening a file), consider that any
interactive application blocks and waits for user input both after
starting up and after executing some task. After a while, the user may
trigger new operations, after which the application stops again, and
so on. Accordingly, the low-latency heuristic weight-raises again a
queue in case it becomes backlogged after being idle for a
sufficiently long (configurable) time. The weight-raising then lasts
for the same time as for a just-created queue.

According to our experiments, the combination of this low-latency
heuristic and of the improvements described in the previous patch
allows BFQ to guarantee a high application responsiveness.

[1] P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
    Scheduler", Proceedings of the First Workshop on Mobile System
    Technologies (MST-2015), May 2015.
    http://algogroup.unimore.it/people/paolo/disk_sched/mst-2015.pdf

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
---
 Documentation/block/bfq-iosched.txt |   9 +
 block/bfq-iosched.c                 | 740 ++++++++++++++++++++++++++++++++----
 2 files changed, 675 insertions(+), 74 deletions(-)

diff --git a/Documentation/block/bfq-iosched.txt b/Documentation/block/bfq-iosched.txt
index 461b27f..1b87df6 100644
--- a/Documentation/block/bfq-iosched.txt
+++ b/Documentation/block/bfq-iosched.txt
@@ -375,6 +375,11 @@ default, low latency mode is enabled. If enabled, interactive and soft
 real-time applications are privileged and experience a lower latency,
 as explained in more detail in the description of how BFQ works.
 
+DO NOT enable this mode if you need full control on bandwidth
+distribution. In fact, if it is enabled, then BFQ automatically
+increases the bandwidth share of privileged applications, as the main
+means to guarantee a lower latency to them.
+
 timeout_sync
 ------------
 
@@ -507,6 +512,10 @@ linear mapping between ioprio and weights, described at the beginning
 of the tunable section, is still valid, but all weights higher than
 IOPRIO_BE_NR*10 are mapped to ioprio 0.
 
+Recall that, if low-latency is set, then BFQ automatically raises the
+weight of the queues associated with interactive and soft real-time
+applications. Unset this tunable if you need/want to control weights.
+
 
 [1] P. Valente, A. Avanzini, "Evolution of the BFQ Storage I/O
     Scheduler", Proceedings of the First Workshop on Mobile System
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index ad3151a..1b55386 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -339,6 +339,17 @@ struct bfq_queue {
 
 	/* pid of the process owning the queue, used for logging purposes */
 	pid_t pid;
+
+	/* current maximum weight-raising time for this queue */
+	unsigned long wr_cur_max_time;
+	/*
+	 * Start time of the current weight-raising period if
+	 * the @bfq-queue is being weight-raised, otherwise
+	 * finish time of the last weight-raising period.
+	 */
+	unsigned long last_wr_start_finish;
+	/* factor by which the weight of this queue is multiplied */
+	unsigned int wr_coeff;
 };
 
 /**
@@ -356,6 +367,11 @@ struct bfq_io_cq {
 #endif
 };
 
+enum bfq_device_speed {
+	BFQ_BFQD_FAST,
+	BFQ_BFQD_SLOW,
+};
+
 /**
  * struct bfq_data - per-device data structure.
  *
@@ -487,6 +503,34 @@ struct bfq_data {
 	 */
 	bool strict_guarantees;
 
+	/* if set to true, low-latency heuristics are enabled */
+	bool low_latency;
+	/*
+	 * Maximum factor by which the weight of a weight-raised queue
+	 * is multiplied.
+	 */
+	unsigned int bfq_wr_coeff;
+	/* maximum duration of a weight-raising period (jiffies) */
+	unsigned int bfq_wr_max_time;
+	/*
+	 * Minimum idle period after which weight-raising may be
+	 * reactivated for a queue (in jiffies).
+	 */
+	unsigned int bfq_wr_min_idle_time;
+	/*
+	 * Minimum period between request arrivals after which
+	 * weight-raising may be reactivated for an already busy async
+	 * queue (in jiffies).
+	 */
+	unsigned long bfq_wr_min_inter_arr_async;
+	/*
+	 * Cached value of the product R*T, used for computing the
+	 * maximum duration of weight raising automatically.
+	 */
+	u64 RT_prod;
+	/* device-speed class for the low-latency heuristic */
+	enum bfq_device_speed device_speed;
+
 	/* fallback dummy bfqq for extreme OOM conditions */
 	struct bfq_queue oom_bfqq;
 
@@ -515,7 +559,6 @@ enum bfqq_state_flags {
 	BFQQF_fifo_expire,	/* FIFO checked in this slice */
 	BFQQF_idle_window,	/* slice idling enabled */
 	BFQQF_sync,		/* synchronous queue */
-	BFQQF_budget_new,	/* no completion with this budget */
 	BFQQF_IO_bound,		/*
 				 * bfqq has timed-out at least once
 				 * having consumed at most 2/10 of
@@ -543,7 +586,6 @@ BFQ_BFQQ_FNS(non_blocking_wait_rq);
 BFQ_BFQQ_FNS(fifo_expire);
 BFQ_BFQQ_FNS(idle_window);
 BFQ_BFQQ_FNS(sync);
-BFQ_BFQQ_FNS(budget_new);
 BFQ_BFQQ_FNS(IO_bound);
 #undef BFQ_BFQQ_FNS
 
@@ -637,7 +679,7 @@ struct bfq_group_data {
 	/* must be the first member */
 	struct blkcg_policy_data pd;
 
-	unsigned short weight;
+	unsigned int weight;
 };
 
 /**
@@ -732,6 +774,8 @@ static void bfq_put_queue(struct bfq_queue *bfqq);
 static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 				       struct bio *bio, bool is_sync,
 				       struct bfq_io_cq *bic);
+static void bfq_end_wr_async_queues(struct bfq_data *bfqd,
+				    struct bfq_group *bfqg);
 static void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg);
 static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq);
 
@@ -787,6 +831,56 @@ static struct kmem_cache *bfq_pool;
 /* Shift used for peak rate fixed precision calculations. */
 #define BFQ_RATE_SHIFT		16
 
+/*
+ * By default, BFQ computes the duration of the weight raising for
+ * interactive applications automatically, using the following formula:
+ * duration = (R / r) * T, where r is the peak rate of the device, and
+ * R and T are two reference parameters.
+ * In particular, R is the peak rate of the reference device (see below),
+ * and T is a reference time: given the systems that are likely to be
+ * installed on the reference device according to its speed class, T is
+ * about the maximum time needed, under BFQ and while reading two files in
+ * parallel, to load typical large applications on these systems.
+ * In practice, the slower/faster the device at hand is, the more/less it
+ * takes to load applications with respect to the reference device.
+ * Accordingly, the longer/shorter BFQ grants weight raising to interactive
+ * applications.
+ *
+ * BFQ uses four different reference pairs (R, T), depending on:
+ * . whether the device is rotational or non-rotational;
+ * . whether the device is slow, such as old or portable HDDs, as well as
+ *   SD cards, or fast, such as newer HDDs and SSDs.
+ *
+ * The device's speed class is dynamically (re)detected in
+ * bfq_update_peak_rate() every time the estimated peak rate is updated.
+ *
+ * In the following definitions, R_slow[0]/R_fast[0] and
+ * T_slow[0]/T_fast[0] are the reference values for a slow/fast
+ * rotational device, whereas R_slow[1]/R_fast[1] and
+ * T_slow[1]/T_fast[1] are the reference values for a slow/fast
+ * non-rotational device. Finally, device_speed_thresh are the
+ * thresholds used to switch between speed classes. The reference
+ * rates are not the actual peak rates of the devices used as a
+ * reference, but slightly lower values. The reason for using these
+ * slightly lower values is that the peak-rate estimator tends to
+ * yield slightly lower values than the actual peak rate (it can yield
+ * the actual peak rate only if there is only one process doing I/O,
+ * and the process does sequential I/O).
+ *
+ * Both the reference peak rates and the thresholds are measured in
+ * sectors/usec, left-shifted by BFQ_RATE_SHIFT.
+ */
+static int R_slow[2] = {1000, 10700};
+static int R_fast[2] = {14000, 33000};
+/*
+ * To improve readability, a conversion function is used to initialize the
+ * following arrays, which entails that they can be initialized only in a
+ * function.
+ */
+static int T_slow[2];
+static int T_fast[2];
+static int device_speed_thresh[2];
+
 #define BFQ_SERVICE_TREE_INIT	((struct bfq_service_tree)		\
 				{ RB_ROOT, RB_ROOT, NULL, NULL, 0, 0 })
 
@@ -1486,7 +1580,7 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 
 	if (entity->prio_changed) {
 		struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
-		unsigned short prev_weight, new_weight;
+		unsigned int prev_weight, new_weight;
 		struct bfq_data *bfqd = NULL;
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
 		struct bfq_sched_data *sd;
@@ -1535,7 +1629,8 @@ __bfq_entity_update_weight_prio(struct bfq_service_tree *old_st,
 		new_st = bfq_entity_service_tree(entity);
 
 		prev_weight = entity->weight;
-		new_weight = entity->orig_weight;
+		new_weight = entity->orig_weight *
+			     (bfqq ? bfqq->wr_coeff : 1);
 		entity->weight = new_weight;
 
 		new_st->wsum += entity->weight;
@@ -1630,6 +1725,8 @@ static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
 					struct bfq_service_tree *st,
 					bool backshifted)
 {
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
 	st = __bfq_entity_update_weight_prio(st, entity);
 	bfq_calc_finish(entity, entity->budget);
 
@@ -1659,10 +1756,19 @@ static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
 	 * time. This may introduce a little unfairness among queues
 	 * with backshifted timestamps, but it does not break
 	 * worst-case fairness guarantees.
+	 *
+	 * As a special case, if bfqq is weight-raised, push up
+	 * timestamps much less, to keep very low the probability that
+	 * this push up causes the backshifted finish timestamps of
+	 * weight-raised queues to become higher than the backshifted
+	 * finish timestamps of non weight-raised queues.
 	 */
 	if (backshifted && bfq_gt(st->vtime, entity->finish)) {
 		unsigned long delta = st->vtime - entity->finish;
 
+		if (bfqq)
+			delta /= bfqq->wr_coeff;
+
 		entity->start += delta;
 		entity->finish += delta;
 	}
@@ -3070,6 +3176,18 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 	bfqg_stats_xfer_dead(bfqg);
 }
 
+static void bfq_end_wr_async(struct bfq_data *bfqd)
+{
+	struct blkcg_gq *blkg;
+
+	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
+		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
+
+		bfq_end_wr_async_queues(bfqd, bfqg);
+	}
+	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
+}
+
 static int bfq_io_show_weight(struct seq_file *sf, void *v)
 {
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
@@ -3433,6 +3551,11 @@ static void bfq_init_entity(struct bfq_entity *entity,
 
 static void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio) {}
 
+static void bfq_end_wr_async(struct bfq_data *bfqd)
+{
+	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
+}
+
 static struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 					    struct blkcg *blkcg)
 {
@@ -3613,7 +3736,7 @@ static struct request *bfq_find_next_rq(struct bfq_data *bfqd,
 static unsigned long bfq_serv_to_charge(struct request *rq,
 					struct bfq_queue *bfqq)
 {
-	if (bfq_bfqq_sync(bfqq))
+	if (bfq_bfqq_sync(bfqq) || bfqq->wr_coeff > 1)
 		return blk_rq_sectors(rq);
 
 	return blk_rq_sectors(rq) * bfq_async_charge_factor;
@@ -3700,12 +3823,12 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
  * whether the in-service queue should be expired, by returning
  * true. The purpose of expiring the in-service queue is to give bfqq
  * the chance to possibly preempt the in-service queue, and the reason
- * for preempting the in-service queue is to achieve the following
- * goal: guarantee to bfqq its reserved bandwidth even if bfqq has
- * expired because it has remained idle.
+ * for preempting the in-service queue is to achieve one of the two
+ * goals below.
  *
- * In particular, bfqq may have expired for one of the following two
- * reasons:
+ * 1. Guarantee to bfqq its reserved bandwidth even if bfqq has
+ * expired because it has remained idle. In particular, bfqq may have
+ * expired for one of the following two reasons:
  *
  * - BFQQE_NO_MORE_REQUESTS bfqq did not enjoy any device idling
  *   and did not make it to issue a new request before its last
@@ -3769,10 +3892,36 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
  * above-described special way, and signals that the in-service queue
  * should be expired. Timestamp back-shifting is done later in
  * __bfq_activate_entity.
+ *
+ * 2. Reduce latency. Even if timestamps are not backshifted to let
+ * the process associated with bfqq recover a service hole, bfqq may
+ * however happen to have, after being (re)activated, a lower finish
+ * timestamp than the in-service queue.	 That is, the next budget of
+ * bfqq may have to be completed before the one of the in-service
+ * queue. If this is the case, then preempting the in-service queue
+ * allows this goal to be achieved, apart from the unpreemptible,
+ * outstanding requests mentioned above.
+ *
+ * Unfortunately, regardless of which of the above two goals one wants
+ * to achieve, service trees need first to be updated to know whether
+ * the in-service queue must be preempted. To have service trees
+ * correctly updated, the in-service queue must be expired and
+ * rescheduled, and bfqq must be scheduled too. This is one of the
+ * most costly operations (in future versions, the scheduling
+ * mechanism may be re-designed in such a way to make it possible to
+ * know whether preemption is needed without needing to update service
+ * trees). In addition, queue preemptions almost always cause random
+ * I/O, and thus loss of throughput. Because of these facts, the next
+ * function adopts the following simple scheme to avoid both costly
+ * operations and too frequent preemptions: it requests the expiration
+ * of the in-service queue (unconditionally) only for queues that need
+ * to recover a hole, or that either are weight-raised or deserve to
+ * be weight-raised.
  */
 static bool bfq_bfqq_update_budg_for_activation(struct bfq_data *bfqd,
 						struct bfq_queue *bfqq,
-						bool arrived_in_time)
+						bool arrived_in_time,
+						bool wr_or_deserves_wr)
 {
 	struct bfq_entity *entity = &bfqq->entity;
 
@@ -3807,14 +3956,85 @@ static bool bfq_bfqq_update_budg_for_activation(struct bfq_data *bfqd,
 	entity->budget = max_t(unsigned long, bfqq->max_budget,
 			       bfq_serv_to_charge(bfqq->next_rq, bfqq));
 	bfq_clear_bfqq_non_blocking_wait_rq(bfqq);
-	return false;
+	return wr_or_deserves_wr;
+}
+
+static unsigned int bfq_wr_duration(struct bfq_data *bfqd)
+{
+	u64 dur;
+
+	if (bfqd->bfq_wr_max_time > 0)
+		return bfqd->bfq_wr_max_time;
+
+	dur = bfqd->RT_prod;
+	do_div(dur, bfqd->peak_rate);
+
+	/*
+	 * Limit duration between 3 and 13 seconds. Tests show that
+	 * higher values than 13 seconds often yield the opposite of
+	 * the desired result, i.e., worsen responsiveness by letting
+	 * non-interactive and non-soft-real-time applications
+	 * preserve weight raising for a too long time interval.
+	 *
+	 * On the other end, lower values than 3 seconds make it
+	 * difficult for most interactive tasks to complete their jobs
+	 * before weight-raising finishes.
+	 */
+	if (dur > msecs_to_jiffies(13000))
+		dur = msecs_to_jiffies(13000);
+	else if (dur < msecs_to_jiffies(3000))
+		dur = msecs_to_jiffies(3000);
+
+	return dur;
+}
+
+static void bfq_update_bfqq_wr_on_rq_arrival(struct bfq_data *bfqd,
+					     struct bfq_queue *bfqq,
+					     unsigned int old_wr_coeff,
+					     bool wr_or_deserves_wr,
+					     bool interactive)
+{
+	if (old_wr_coeff == 1 && wr_or_deserves_wr) {
+		/* start a weight-raising period */
+		bfqq->wr_coeff = bfqd->bfq_wr_coeff;
+		/* update wr duration */
+		bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
+
+		/*
+		 * If needed, further reduce budget to make sure it is
+		 * close to bfqq's backlog, so as to reduce the
+		 * scheduling-error component due to a too large
+		 * budget. Do not care about throughput consequences,
+		 * but only about latency. Finally, do not assign a
+		 * too small budget either, to avoid increasing
+		 * latency by causing too frequent expirations.
+		 */
+		bfqq->entity.budget = min_t(unsigned long,
+					    bfqq->entity.budget,
+					    2 * bfq_min_budget(bfqd));
+	} else if (old_wr_coeff > 1) {
+		/* update wr duration */
+		bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
+	}
+}
+
+static bool bfq_bfqq_idle_for_long_time(struct bfq_data *bfqd,
+					struct bfq_queue *bfqq)
+{
+	return bfqq->dispatched == 0 &&
+		time_is_before_jiffies(
+			bfqq->budget_timeout +
+			bfqd->bfq_wr_min_idle_time);
 }
 
 static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq,
-					     struct request *rq)
+					     int old_wr_coeff,
+					     struct request *rq,
+					     bool *interactive)
 {
-	bool bfqq_wants_to_preempt,
+	bool wr_or_deserves_wr,	bfqq_wants_to_preempt,
+		idle_for_long_time = bfq_bfqq_idle_for_long_time(bfqd, bfqq),
 		/*
 		 * See the comments on
 		 * bfq_bfqq_update_budg_for_activation for
@@ -3827,12 +4047,23 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	bfqg_stats_update_io_add(bfqq_group(RQ_BFQQ(rq)), bfqq, rq->cmd_flags);
 
 	/*
-	 * Update budget and check whether bfqq may want to preempt
-	 * the in-service queue.
+	 * bfqq deserves to be weight-raised if:
+	 * - it is sync,
+	 * - it has been idle for enough time.
+	 */
+	*interactive = idle_for_long_time;
+	wr_or_deserves_wr = bfqd->low_latency &&
+		(bfqq->wr_coeff > 1 ||
+		 (bfq_bfqq_sync(bfqq) && *interactive));
+
+	/*
+	 * Using the last flag, update budget and check whether bfqq
+	 * may want to preempt the in-service queue.
 	 */
 	bfqq_wants_to_preempt =
 		bfq_bfqq_update_budg_for_activation(bfqd, bfqq,
-						    arrived_in_time);
+						    arrived_in_time,
+						    wr_or_deserves_wr);
 
 	if (!bfq_bfqq_IO_bound(bfqq)) {
 		if (arrived_in_time) {
@@ -3844,6 +4075,16 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 			bfqq->requests_within_timer = 0;
 	}
 
+	if (bfqd->low_latency) {
+		bfq_update_bfqq_wr_on_rq_arrival(bfqd, bfqq,
+						 old_wr_coeff,
+						 wr_or_deserves_wr,
+						 *interactive);
+
+		if (old_wr_coeff != bfqq->wr_coeff)
+			bfqq->entity.prio_changed = 1;
+	}
+
 	bfq_add_bfqq_busy(bfqd, bfqq);
 
 	/*
@@ -3857,6 +4098,7 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 * function bfq_bfqq_update_budg_for_activation).
 	 */
 	if (bfqd->in_service_queue && bfqq_wants_to_preempt &&
+	    bfqd->in_service_queue->wr_coeff == 1 &&
 	    next_queue_may_preempt(bfqd))
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
@@ -3867,6 +4109,8 @@ static void bfq_add_request(struct request *rq)
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd = bfqq->bfqd;
 	struct request *next_rq, *prev;
+	unsigned int old_wr_coeff = bfqq->wr_coeff;
+	bool interactive = false;
 
 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
 	bfqq->queued[rq_is_sync(rq)]++;
@@ -3882,9 +4126,45 @@ static void bfq_add_request(struct request *rq)
 	bfqq->next_rq = next_rq;
 
 	if (!bfq_bfqq_busy(bfqq)) /* switching to busy ... */
-		bfq_bfqq_handle_idle_busy_switch(bfqd, bfqq, rq);
-	else if (prev != bfqq->next_rq)
-		bfq_updated_next_req(bfqd, bfqq);
+		bfq_bfqq_handle_idle_busy_switch(bfqd, bfqq, old_wr_coeff,
+						 rq, &interactive);
+	else {
+		if (bfqd->low_latency && old_wr_coeff == 1 && !rq_is_sync(rq) &&
+		    time_is_before_jiffies(
+				bfqq->last_wr_start_finish +
+				bfqd->bfq_wr_min_inter_arr_async)) {
+			bfqq->wr_coeff = bfqd->bfq_wr_coeff;
+			bfqq->wr_cur_max_time = bfq_wr_duration(bfqd);
+
+			bfqq->entity.prio_changed = 1;
+		}
+		if (prev != bfqq->next_rq)
+			bfq_updated_next_req(bfqd, bfqq);
+	}
+
+	/*
+	 * Assign jiffies to last_wr_start_finish in the following
+	 * cases:
+	 *
+	 * . if bfqq is not going to be weight-raised, because, for
+	 *   non weight-raised queues, last_wr_start_finish stores the
+	 *   arrival time of the last request; as of now, this piece
+	 *   of information is used only for deciding whether to
+	 *   weight-raise async queues
+	 *
+	 * . if bfqq is not weight-raised, because, if bfqq is now
+	 *   switching to weight-raised, then last_wr_start_finish
+	 *   stores the time when weight-raising starts
+	 *
+	 * . if bfqq is interactive, because, regardless of whether
+	 *   bfqq is currently weight-raised, the weight-raising
+	 *   period must start or restart (this case is considered
+	 *   separately because it is not detected by the above
+	 *   conditions, if bfqq is already weight-raised)
+	 */
+	if (bfqd->low_latency &&
+		(old_wr_coeff == 1 || bfqq->wr_coeff == 1 || interactive))
+		bfqq->last_wr_start_finish = jiffies;
 }
 
 static struct request *bfq_find_rq_fmerge(struct bfq_data *bfqd,
@@ -4087,6 +4367,46 @@ static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
 }
 
+/* Must be called with bfqq != NULL */
+static void bfq_bfqq_end_wr(struct bfq_queue *bfqq)
+{
+	bfqq->wr_coeff = 1;
+	bfqq->wr_cur_max_time = 0;
+	/*
+	 * Trigger a weight change on the next invocation of
+	 * __bfq_entity_update_weight_prio.
+	 */
+	bfqq->entity.prio_changed = 1;
+}
+
+static void bfq_end_wr_async_queues(struct bfq_data *bfqd,
+				    struct bfq_group *bfqg)
+{
+	int i, j;
+
+	for (i = 0; i < 2; i++)
+		for (j = 0; j < IOPRIO_BE_NR; j++)
+			if (bfqg->async_bfqq[i][j])
+				bfq_bfqq_end_wr(bfqg->async_bfqq[i][j]);
+	if (bfqg->async_idle_bfqq)
+		bfq_bfqq_end_wr(bfqg->async_idle_bfqq);
+}
+
+static void bfq_end_wr(struct bfq_data *bfqd)
+{
+	struct bfq_queue *bfqq;
+
+	spin_lock_irq(&bfqd->lock);
+
+	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
+		bfq_bfqq_end_wr(bfqq);
+	list_for_each_entry(bfqq, &bfqd->idle_list, bfqq_list)
+		bfq_bfqq_end_wr(bfqq);
+	bfq_end_wr_async(bfqd);
+
+	spin_unlock_irq(&bfqd->lock);
+}
+
 static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 				struct bio *bio)
 {
@@ -4110,16 +4430,32 @@ static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 	return bfqq == RQ_BFQQ(rq);
 }
 
+/*
+ * Set the maximum time for the in-service queue to consume its
+ * budget. This prevents seeky processes from lowering the throughput.
+ * In practice, a time-slice service scheme is used with seeky
+ * processes.
+ */
+static void bfq_set_budget_timeout(struct bfq_data *bfqd,
+				   struct bfq_queue *bfqq)
+{
+	bfqd->last_budget_start = ktime_get();
+
+	bfqq->budget_timeout = jiffies +
+		bfqd->bfq_timeout *
+		(bfqq->entity.weight / bfqq->entity.orig_weight);
+}
+
 static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
 				       struct bfq_queue *bfqq)
 {
 	if (bfqq) {
 		bfqg_stats_update_avg_queue_size(bfqq_group(bfqq));
-		bfq_mark_bfqq_budget_new(bfqq);
 		bfq_clear_bfqq_fifo_expire(bfqq);
 
 		bfqd->budgets_assigned = (bfqd->budgets_assigned * 7 + 256) / 8;
 
+		bfq_set_budget_timeout(bfqd, bfqq);
 		bfq_log_bfqq(bfqd, bfqq,
 			     "set_in_service_queue, cur-budget = %d",
 			     bfqq->entity.budget);
@@ -4159,9 +4495,13 @@ static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 	 */
 	sl = bfqd->bfq_slice_idle;
 	/*
-	 * Grant only minimum idle time if the queue is seeky.
+	 * Unless the queue is being weight-raised, grant only minimum
+	 * idle time if the queue is seeky. A long idling is preserved
+	 * for a weight-raised queue, because it is needed for
+	 * guaranteeing to the queue its reserved share of the
+	 * throughput.
 	 */
-	if (BFQQ_SEEKY(bfqq))
+	if (BFQQ_SEEKY(bfqq) && bfqq->wr_coeff == 1)
 		sl = min_t(u64, sl, BFQ_MIN_TT);
 
 	bfqd->last_idling_start = ktime_get();
@@ -4171,27 +4511,6 @@ static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 }
 
 /*
- * Set the maximum time for the in-service queue to consume its
- * budget. This prevents seeky processes from lowering the disk
- * throughput (always guaranteed with a time slice scheme as in CFQ).
- */
-static void bfq_set_budget_timeout(struct bfq_data *bfqd)
-{
-	struct bfq_queue *bfqq = bfqd->in_service_queue;
-	unsigned int timeout_coeff = bfqq->entity.weight /
-				     bfqq->entity.orig_weight;
-
-	bfqd->last_budget_start = ktime_get();
-
-	bfq_clear_bfqq_budget_new(bfqq);
-	bfqq->budget_timeout = jiffies +
-		bfqd->bfq_timeout * timeout_coeff;
-
-	bfq_log_bfqq(bfqd, bfqq, "set budget_timeout %u",
-		jiffies_to_msecs(bfqd->bfq_timeout * timeout_coeff));
-}
-
-/*
  * In autotuning mode, max_budget is dynamically recomputed as the
  * amount of sectors transferred in timeout at the estimated peak
  * rate. This enables BFQ to utilize a full timeslice with a full
@@ -4204,6 +4523,42 @@ static unsigned long bfq_calc_max_budget(struct bfq_data *bfqd)
 		jiffies_to_msecs(bfqd->bfq_timeout)>>BFQ_RATE_SHIFT;
 }
 
+/*
+ * Update parameters related to throughput and responsiveness, as a
+ * function of the estimated peak rate. See comments on
+ * bfq_calc_max_budget(), and on T_slow and T_fast arrays.
+ */
+static void update_thr_responsiveness_params(struct bfq_data *bfqd)
+{
+	int dev_type = blk_queue_nonrot(bfqd->queue);
+
+	if (bfqd->bfq_user_max_budget == 0)
+		bfqd->bfq_max_budget =
+			bfq_calc_max_budget(bfqd);
+
+	if (bfqd->device_speed == BFQ_BFQD_FAST &&
+	    bfqd->peak_rate < device_speed_thresh[dev_type]) {
+		bfqd->device_speed = BFQ_BFQD_SLOW;
+		bfqd->RT_prod = R_slow[dev_type] *
+			T_slow[dev_type];
+	} else if (bfqd->device_speed == BFQ_BFQD_SLOW &&
+		   bfqd->peak_rate > device_speed_thresh[dev_type]) {
+		bfqd->device_speed = BFQ_BFQD_FAST;
+		bfqd->RT_prod = R_fast[dev_type] *
+			T_fast[dev_type];
+	}
+
+	bfq_log(bfqd,
+"dev_type %s dev_speed_class = %s (%llu sects/sec), thresh %llu setcs/sec",
+		dev_type == 0 ? "ROT" : "NONROT",
+		bfqd->device_speed == BFQ_BFQD_FAST ? "FAST" : "SLOW",
+		bfqd->device_speed == BFQ_BFQD_FAST ?
+		(USEC_PER_SEC*(u64)R_fast[dev_type])>>BFQ_RATE_SHIFT :
+		(USEC_PER_SEC*(u64)R_slow[dev_type])>>BFQ_RATE_SHIFT,
+		(USEC_PER_SEC*(u64)device_speed_thresh[dev_type])>>
+		BFQ_RATE_SHIFT);
+}
+
 static void bfq_reset_rate_computation(struct bfq_data *bfqd,
 				       struct request *rq)
 {
@@ -4315,9 +4670,7 @@ static void bfq_update_rate_reset(struct bfq_data *bfqd, struct request *rq)
 	rate /= divisor; /* smoothing constant alpha = 1/divisor */
 
 	bfqd->peak_rate += rate;
-	if (bfqd->bfq_user_max_budget == 0)
-		bfqd->bfq_max_budget =
-			bfq_calc_max_budget(bfqd);
+	update_thr_responsiveness_params(bfqd);
 
 reset_computation:
 	bfq_reset_rate_computation(bfqd, rq);
@@ -4439,9 +4792,18 @@ static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 
 static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 {
-	if (RB_EMPTY_ROOT(&bfqq->sort_list))
+	if (RB_EMPTY_ROOT(&bfqq->sort_list)) {
+		if (bfqq->dispatched == 0)
+			/*
+			 * Overloading budget_timeout field to store
+			 * the time at which the queue remains with no
+			 * backlog and no outstanding request; used by
+			 * the weight-raising mechanism.
+			 */
+			bfqq->budget_timeout = jiffies;
+
 		bfq_del_bfqq_busy(bfqd, bfqq, true);
-	else
+	} else
 		bfq_requeue_bfqq(bfqd, bfqq);
 
 	/*
@@ -4468,9 +4830,18 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
 	struct request *next_rq;
 	int budget, min_budget;
 
-	budget = bfqq->max_budget;
 	min_budget = bfq_min_budget(bfqd);
 
+	if (bfqq->wr_coeff == 1)
+		budget = bfqq->max_budget;
+	else /*
+	      * Use a constant, low budget for weight-raised queues,
+	      * to help achieve a low latency. Keep it slightly higher
+	      * than the minimum possible budget, to cause a little
+	      * bit fewer expirations.
+	      */
+		budget = 2 * min_budget;
+
 	bfq_log_bfqq(bfqd, bfqq, "recalc_budg: last budg %d, budg left %d",
 		bfqq->entity.budget, bfq_bfqq_budget_left(bfqq));
 	bfq_log_bfqq(bfqd, bfqq, "recalc_budg: last max_budg %d, min budg %d",
@@ -4478,7 +4849,7 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
 	bfq_log_bfqq(bfqd, bfqq, "recalc_budg: sync %d, seeky %d",
 		bfq_bfqq_sync(bfqq), BFQQ_SEEKY(bfqd->in_service_queue));
 
-	if (bfq_bfqq_sync(bfqq)) {
+	if (bfq_bfqq_sync(bfqq) && bfqq->wr_coeff == 1) {
 		switch (reason) {
 		/*
 		 * Caveat: in all the following cases we trade latency
@@ -4577,7 +4948,7 @@ static void __bfq_bfqq_recalc_budget(struct bfq_data *bfqd,
 		default:
 			return;
 		}
-	} else {
+	} else if (!bfq_bfqq_sync(bfqq)) {
 		/*
 		 * Async queues get always the maximum possible
 		 * budget, as for them we do not care about latency
@@ -4766,15 +5137,19 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
 	 * bandwidth, and not time, distribution with little unlucky
 	 * or quasi-sequential processes.
 	 */
-	if (slow ||
-	    (reason == BFQQE_BUDGET_TIMEOUT &&
-	     bfq_bfqq_budget_left(bfqq) >=  entity->budget / 3))
+	if (bfqq->wr_coeff == 1 &&
+	    (slow ||
+	     (reason == BFQQE_BUDGET_TIMEOUT &&
+	      bfq_bfqq_budget_left(bfqq) >=  entity->budget / 3)))
 		bfq_bfqq_charge_time(bfqd, bfqq, delta);
 
 	if (reason == BFQQE_TOO_IDLE &&
 	    entity->service <= 2 * entity->budget / 10)
 		bfq_clear_bfqq_IO_bound(bfqq);
 
+	if (bfqd->low_latency && bfqq->wr_coeff == 1)
+		bfqq->last_wr_start_finish = jiffies;
+
 	bfq_log_bfqq(bfqd, bfqq,
 		"expire (%d, slow %d, num_disp %d, idle_win %d)", reason,
 		slow, bfqq->dispatched, bfq_bfqq_idle_window(bfqq));
@@ -4801,10 +5176,7 @@ static void bfq_bfqq_expire(struct bfq_data *bfqd,
  */
 static bool bfq_bfqq_budget_timeout(struct bfq_queue *bfqq)
 {
-	if (bfq_bfqq_budget_new(bfqq) ||
-	    time_is_after_jiffies(bfqq->budget_timeout))
-		return false;
-	return true;
+	return time_is_before_eq_jiffies(bfqq->budget_timeout);
 }
 
 /*
@@ -4831,19 +5203,40 @@ static bool bfq_may_expire_for_budg_timeout(struct bfq_queue *bfqq)
 
 /*
  * For a queue that becomes empty, device idling is allowed only if
- * this function returns true for the queue. And this function returns
- * true only if idling is beneficial for throughput.
+ * this function returns true for the queue. As a consequence, since
+ * device idling plays a critical role in both throughput boosting and
+ * service guarantees, the return value of this function plays a
+ * critical role in both these aspects as well.
+ *
+ * In a nutshell, this function returns true only if idling is
+ * beneficial for throughput or, even if detrimental for throughput,
+ * idling is however necessary to preserve service guarantees (low
+ * latency, desired throughput distribution, ...). In particular, on
+ * NCQ-capable devices, this function tries to return false, so as to
+ * help keep the drives' internal queues full, whenever this helps the
+ * device boost the throughput without causing any service-guarantee
+ * issue.
+ *
+ * In more detail, the return value of this function is obtained by,
+ * first, computing a number of boolean variables that take into
+ * account throughput and service-guarantee issues, and, then,
+ * combining these variables in a logical expression. Most of the
+ * issues taken into account are not trivial. We discuss these issues
+ * individually while introducing the variables.
  */
 static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 {
 	struct bfq_data *bfqd = bfqq->bfqd;
-	bool idling_boosts_thr;
+	bool idling_boosts_thr, asymmetric_scenario;
 
 	if (bfqd->strict_guarantees)
 		return true;
 
 	/*
-	 * The value of the next variable is computed considering that
+	 * The next variable takes into account the cases where idling
+	 * boosts the throughput.
+	 *
+	 * The value of the variable is computed considering that
 	 * idling is usually beneficial for the throughput if:
 	 * (a) the device is not NCQ-capable, or
 	 * (b) regardless of the presence of NCQ, the request pattern
@@ -4857,13 +5250,80 @@ static bool bfq_bfqq_may_idle(struct bfq_queue *bfqq)
 	idling_boosts_thr = !bfqd->hw_tag || bfq_bfqq_IO_bound(bfqq);
 
 	/*
-	 * We have now the components we need to compute the return
-	 * value of the function, which is true only if both the
-	 * following conditions hold:
+	 * There is then a case where idling must be performed not for
+	 * throughput concerns, but to preserve service guarantees. To
+	 * introduce it, we can note that allowing the drive to
+	 * enqueue more than one request at a time, and hence
+	 * delegating de facto final scheduling decisions to the
+	 * drive's internal scheduler, causes loss of control on the
+	 * actual request service order. In particular, the critical
+	 * situation is when requests from different processes happens
+	 * to be present, at the same time, in the internal queue(s)
+	 * of the drive. In such a situation, the drive, by deciding
+	 * the service order of the internally-queued requests, does
+	 * determine also the actual throughput distribution among
+	 * these processes. But the drive typically has no notion or
+	 * concern about per-process throughput distribution, and
+	 * makes its decisions only on a per-request basis. Therefore,
+	 * the service distribution enforced by the drive's internal
+	 * scheduler is likely to coincide with the desired
+	 * device-throughput distribution only in a completely
+	 * symmetric scenario where: (i) each of these processes must
+	 * get the same throughput as the others; (ii) all these
+	 * processes have the same I/O pattern (either sequential or
+	 * random).  In fact, in such a scenario, the drive will tend
+	 * to treat the requests of each of these processes in about
+	 * the same way as the requests of the others, and thus to
+	 * provide each of these processes with about the same
+	 * throughput (which is exactly the desired throughput
+	 * distribution). In contrast, in any asymmetric scenario,
+	 * device idling is certainly needed to guarantee that bfqq
+	 * receives its assigned fraction of the device throughput
+	 * (see [1] for details).
+	 *
+	 * As for sub-condition (i), actually we check only whether
+	 * bfqq is being weight-raised. In fact, if bfqq is not being
+	 * weight-raised, we have that:
+	 * - if the process associated with bfqq is not I/O-bound, then
+	 *   it is not either latency- or throughput-critical; therefore
+	 *   idling is not needed for bfqq;
+	 * - if the process asociated with bfqq is I/O-bound, then
+	 *   idling is already granted with bfqq (see the comments on
+	 *   idling_boosts_thr).
+	 *
+	 * We do not check sub-condition (ii) at all, i.e., the next
+	 * variable is true if and only if bfqq is being
+	 * weight-raised. We do not need to control sub-condition (ii)
+	 * for the following reason:
+	 * - if bfqq is being weight-raised, then idling is already
+	 *   guaranteed to bfqq by sub-condition (i);
+	 * - if bfqq is not being weight-raised, then idling is
+	 *   already guaranteed to bfqq (only) if it matters, i.e., if
+	 *   bfqq is associated to a currently I/O-bound process (see
+	 *   the above comment on sub-condition (i)).
+	 *
+	 * As a side note, it is worth considering that the above
+	 * device-idling countermeasures may however fail in the
+	 * following unlucky scenario: if idling is (correctly)
+	 * disabled in a time period during which the symmetry
+	 * sub-condition holds, and hence the device is allowed to
+	 * enqueue many requests, but at some later point in time some
+	 * sub-condition stops to hold, then it may become impossible
+	 * to let requests be served in the desired order until all
+	 * the requests already queued in the device have been served.
+	 */
+	asymmetric_scenario = bfqq->wr_coeff > 1;
+
+	/*
+	 * We have now all the components we need to compute the return
+	 * value of the function, which is true only if both the following
+	 * conditions hold:
 	 * 1) bfqq is sync, because idling make sense only for sync queues;
-	 * 2) idling boosts the throughput.
+	 * 2) idling either boosts the throughput (without issues), or
+	 *    is necessary to preserve service guarantees.
 	 */
-	return bfq_bfqq_sync(bfqq) && idling_boosts_thr;
+	return bfq_bfqq_sync(bfqq) &&
+		(idling_boosts_thr || asymmetric_scenario);
 }
 
 /*
@@ -4986,6 +5446,43 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	return bfqq;
 }
 
+static void bfq_update_wr_data(struct bfq_data *bfqd, struct bfq_queue *bfqq)
+{
+	struct bfq_entity *entity = &bfqq->entity;
+
+	if (bfqq->wr_coeff > 1) { /* queue is being weight-raised */
+		bfq_log_bfqq(bfqd, bfqq,
+			"raising period dur %u/%u msec, old coeff %u, w %d(%d)",
+			jiffies_to_msecs(jiffies - bfqq->last_wr_start_finish),
+			jiffies_to_msecs(bfqq->wr_cur_max_time),
+			bfqq->wr_coeff,
+			bfqq->entity.weight, bfqq->entity.orig_weight);
+
+		if (entity->prio_changed)
+			bfq_log_bfqq(bfqd, bfqq, "WARN: pending prio change");
+
+		/*
+		 * If too much time has elapsed from the beginning of
+		 * this weight-raising period, then end weight
+		 * raising.
+		 */
+		if (time_is_before_jiffies(bfqq->last_wr_start_finish +
+					   bfqq->wr_cur_max_time)) {
+			bfqq->last_wr_start_finish = jiffies;
+			bfq_log_bfqq(bfqd, bfqq,
+				     "wrais ending at %lu, rais_max_time %u",
+				     bfqq->last_wr_start_finish,
+				     jiffies_to_msecs(bfqq->wr_cur_max_time));
+			bfq_bfqq_end_wr(bfqq);
+		}
+	}
+	/* Update weight both if it must be raised and if it must be lowered */
+	if ((entity->weight > entity->orig_weight) != (bfqq->wr_coeff > 1))
+		__bfq_entity_update_weight_prio(
+			bfq_entity_service_tree(entity),
+			entity);
+}
+
 /*
  * Dispatch next request from bfqq.
  */
@@ -5001,6 +5498,19 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 
 	bfq_dispatch_remove(bfqd->queue, rq);
 
+	/*
+	 * If weight raising has to terminate for bfqq, then next
+	 * function causes an immediate update of bfqq's weight,
+	 * without waiting for next activation. As a consequence, on
+	 * expiration, bfqq will be timestamped as if has never been
+	 * weight-raised during this service slot, even if it has
+	 * received part or even most of the service as a
+	 * weight-raised queue. This inflates bfqq's timestamps, which
+	 * is beneficial, as bfqq is then more willing to leave the
+	 * device immediately to possible other weight-raised queues.
+	 */
+	bfq_update_wr_data(bfqd, bfqq);
+
 	if (!bfqd->in_service_bic) {
 		atomic_long_inc(&RQ_BIC(rq)->icq.ioc->refcount);
 		bfqd->in_service_bic = RQ_BIC(rq);
@@ -5306,6 +5816,9 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	bfqq->max_budget = (2 * bfq_max_budget(bfqd)) / 3;
 	bfqq->budget_timeout = bfq_smallest_from_now();
 
+	bfqq->wr_coeff = 1;
+	bfqq->last_wr_start_finish = bfq_smallest_from_now();
+
 	/* first request is almost certainly seeky */
 	bfqq->seek_history = 1;
 }
@@ -5440,7 +5953,8 @@ static void bfq_update_idle_window(struct bfq_data *bfqd,
 		(bfqd->hw_tag && BFQQ_SEEKY(bfqq)))
 		enable_idle = 0;
 	else if (bfq_sample_valid(bfqq->ttime.ttime_samples)) {
-		if (bfqq->ttime.ttime_mean > bfqd->bfq_slice_idle)
+		if (bfqq->ttime.ttime_mean > bfqd->bfq_slice_idle &&
+			bfqq->wr_coeff == 1)
 			enable_idle = 0;
 		else
 			enable_idle = 1;
@@ -5618,6 +6132,16 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 	bfqd->rq_in_driver--;
 	bfqq->dispatched--;
 
+	if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
+		/*
+		 * Set budget_timeout (which we overload to store the
+		 * time at which the queue remains with no backlog and
+		 * no outstanding request; used by the weight-raising
+		 * mechanism).
+		 */
+		bfqq->budget_timeout = jiffies;
+	}
+
 	now_ns = ktime_get_ns();
 
 	bfqq->ttime.last_end_request = now_ns;
@@ -5655,10 +6179,7 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 	 * or if we want to idle in case it has no pending requests.
 	 */
 	if (bfqd->in_service_queue == bfqq) {
-		if (bfq_bfqq_budget_new(bfqq))
-			bfq_set_budget_timeout(bfqd);
-
-		if (bfq_bfqq_must_idle(bfqq)) {
+		if (bfqq->dispatched == 0 && bfq_bfqq_must_idle(bfqq)) {
 			bfq_arm_slice_timer(bfqd);
 			return;
 		} else if (bfq_may_expire_for_budg_timeout(bfqq))
@@ -5966,6 +6487,26 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->bfq_requests_within_timer = 120;
 
+	bfqd->low_latency = true;
+
+	/*
+	 * Trade-off between responsiveness and fairness.
+	 */
+	bfqd->bfq_wr_coeff = 30;
+	bfqd->bfq_wr_max_time = 0;
+	bfqd->bfq_wr_min_idle_time = msecs_to_jiffies(2000);
+	bfqd->bfq_wr_min_inter_arr_async = msecs_to_jiffies(500);
+
+	/*
+	 * Begin by assuming, optimistically, that the device is a
+	 * high-speed one, and that its peak rate is equal to 2/3 of
+	 * the highest reference rate.
+	 */
+	bfqd->RT_prod = R_fast[blk_queue_nonrot(bfqd->queue)] *
+			T_fast[blk_queue_nonrot(bfqd->queue)];
+	bfqd->peak_rate = R_fast[blk_queue_nonrot(bfqd->queue)] * 2 / 3;
+	bfqd->device_speed = BFQ_BFQD_FAST;
+
 	spin_lock_init(&bfqd->lock);
 
 	/*
@@ -6047,6 +6588,7 @@ SHOW_FUNCTION(bfq_slice_idle_show, bfqd->bfq_slice_idle, 2);
 SHOW_FUNCTION(bfq_max_budget_show, bfqd->bfq_user_max_budget, 0);
 SHOW_FUNCTION(bfq_timeout_sync_show, bfqd->bfq_timeout, 1);
 SHOW_FUNCTION(bfq_strict_guarantees_show, bfqd->strict_guarantees, 0);
+SHOW_FUNCTION(bfq_low_latency_show, bfqd->low_latency, 0);
 #undef SHOW_FUNCTION
 
 #define USEC_SHOW_FUNCTION(__FUNC, __VAR)				\
@@ -6167,6 +6709,22 @@ static ssize_t bfq_strict_guarantees_store(struct elevator_queue *e,
 	return ret;
 }
 
+static ssize_t bfq_low_latency_store(struct elevator_queue *e,
+				     const char *page, size_t count)
+{
+	struct bfq_data *bfqd = e->elevator_data;
+	unsigned long uninitialized_var(__data);
+	int ret = bfq_var_store(&__data, (page), count);
+
+	if (__data > 1)
+		__data = 1;
+	if (__data == 0 && bfqd->low_latency != 0)
+		bfq_end_wr(bfqd);
+	bfqd->low_latency = __data;
+
+	return ret;
+}
+
 #define BFQ_ATTR(name) \
 	__ATTR(name, 0644, bfq_##name##_show, bfq_##name##_store)
 
@@ -6180,6 +6738,7 @@ static struct elv_fs_entry bfq_attrs[] = {
 	BFQ_ATTR(max_budget),
 	BFQ_ATTR(timeout_sync),
 	BFQ_ATTR(strict_guarantees),
+	BFQ_ATTR(low_latency),
 	__ATTR_NULL
 };
 
@@ -6242,6 +6801,39 @@ static int __init bfq_init(void)
 	if (bfq_slab_setup())
 		goto err_pol_unreg;
 
+	/*
+	 * Times to load large popular applications for the typical
+	 * systems installed on the reference devices (see the
+	 * comments before the definitions of the next two
+	 * arrays). Actually, we use slightly slower values, as the
+	 * estimated peak rate tends to be smaller than the actual
+	 * peak rate.  The reason for this last fact is that estimates
+	 * are computed over much shorter time intervals than the long
+	 * intervals typically used for benchmarking. Why? First, to
+	 * adapt more quickly to variations. Second, because an I/O
+	 * scheduler cannot rely on a peak-rate-evaluation workload to
+	 * be run for a long time.
+	 */
+	T_slow[0] = msecs_to_jiffies(3500); /* actually 4 sec */
+	T_slow[1] = msecs_to_jiffies(6000); /* actually 6.5 sec */
+	T_fast[0] = msecs_to_jiffies(7000); /* actually 8 sec */
+	T_fast[1] = msecs_to_jiffies(2500); /* actually 3 sec */
+
+	/*
+	 * Thresholds that determine the switch between speed classes
+	 * (see the comments before the definition of the array
+	 * device_speed_thresh). These thresholds are biased towards
+	 * transitions to the fast class. This is safer than the
+	 * opposite bias. In fact, a wrong transition to the slow
+	 * class results in short weight-raising periods, because the
+	 * speed of the device then tends to be higher that the
+	 * reference peak rate. On the opposite end, a wrong
+	 * transition to the fast class tends to increase
+	 * weight-raising periods, because of the opposite reason.
+	 */
+	device_speed_thresh[0] = (4 * R_slow[0]) / 3;
+	device_speed_thresh[1] = (4 * R_slow[1]) / 3;
+
 	ret = elv_register(&iosched_bfq_mq);
 	if (ret)
 		goto err_pol_unreg;
-- 
2.10.0
