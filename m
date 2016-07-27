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
Subject: [PATCH RFC V8 07/22] block, cfq: get rid of workload type
Date: Wed, 27 Jul 2016 18:13:23 +0200
Message-Id: <1469636018-31247-8-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
References: <2D83ACA0-2513-4019-9A0D-3166FDDE7485@linaro.org>
 <1469636018-31247-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

From: Arianna Avanzini <avanzini.arianna@gmail.com>

CFQ selects the queue to serve also according to the type of workload
it is part of. This kind of heuristic has no match in BFQ, where a
high throughput, and, at the same time, provable service guarantees
are provided through a unified overall scheduling policy.

Signed-off-by: Arianna Avanzini <avanzini.arianna@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/cfq-iosched.c | 131 +++++++++++-----------------------------------------
 1 file changed, 26 insertions(+), 105 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 174dc94..df8fb826 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -155,15 +155,6 @@ enum wl_class_t {
 	CFQ_PRIO_NR,
 };
 
-/*
- * Second index in the service_trees.
- */
-enum wl_type_t {
-	ASYNC_WORKLOAD = 0,
-	SYNC_NOIDLE_WORKLOAD = 1,
-	SYNC_WORKLOAD = 2
-};
-
 struct cfq_io_cq {
 	struct io_cq		icq;		/* must be the first member */
 	struct cfq_queue	*cfqq[2];
@@ -179,20 +170,16 @@ struct cfq_data {
 
 	/*
 	 * rr lists of queues with requests. We maintain service trees for
-	 * RT and BE classes. These trees are subdivided in subclasses
-	 * of SYNC, SYNC_NOIDLE and ASYNC based on workload type. For IDLE
-	 * class there is no subclassification and all the cfq queues go on
-	 * a single tree service_tree_idle.
+	 * RT and BE classes.
 	 * Counts are embedded in the cfq_rb_root
 	 */
-	struct cfq_rb_root service_trees[2][3];
+	struct cfq_rb_root service_trees[2];
 	struct cfq_rb_root service_tree_idle;
 
 	/*
 	 * The priority currently being served
 	 */
 	enum wl_class_t serving_wl_class;
-	enum wl_type_t serving_wl_type;
 	unsigned long workload_expires;
 
 	unsigned int busy_queues;
@@ -291,9 +278,8 @@ CFQ_CFQQ_FNS(wait_busy);
 #undef CFQ_CFQQ_FNS
 
 #define cfq_log_cfqq(cfqd, cfqq, fmt, args...)	\
-	blk_add_trace_msg((cfqd)->queue, "cfq%d%c%c " fmt, (cfqq)->pid,	\
+	blk_add_trace_msg((cfqd)->queue, "cfq%d%c " fmt, (cfqq)->pid,	\
 			cfq_cfqq_sync((cfqq)) ? 'S' : 'A',		\
-			cfqq_type((cfqq)) == SYNC_NOIDLE_WORKLOAD ? 'N' : ' ',\
 				##args)
 #define cfq_log(cfqd, fmt, args...)	\
 	blk_add_trace_msg((cfqd)->queue, "cfq " fmt, ##args)
@@ -301,12 +287,12 @@ CFQ_CFQQ_FNS(wait_busy);
 /* Traverses through cfq service trees */
 #define for_each_st(cfqd, i, j, st) \
 	for (i = 0; i <= IDLE_WORKLOAD; i++) \
-		for (j = 0, st = i < IDLE_WORKLOAD ? &cfqd->service_trees[i][j]\
+		for (j = 0, st = i < IDLE_WORKLOAD ? &cfqd->service_trees[i]\
 			: &cfqd->service_tree_idle; \
-			(i < IDLE_WORKLOAD && j <= SYNC_WORKLOAD) || \
-			(i == IDLE_WORKLOAD && j == 0); \
-			j++, st = i < IDLE_WORKLOAD ? \
-			&cfqd->service_trees[i][j] : NULL) \
+			(i < IDLE_WORKLOAD) || \
+			(i == IDLE_WORKLOAD); \
+			st = i < IDLE_WORKLOAD ? \
+			&cfqd->service_trees[i] : NULL) \
 
 static inline bool cfq_io_thinktime_big(struct cfq_data *cfqd,
 	struct cfq_ttime *ttime)
@@ -327,33 +313,6 @@ static inline enum wl_class_t cfqq_class(struct cfq_queue *cfqq)
 	return BE_WORKLOAD;
 }
 
-
-static enum wl_type_t cfqq_type(struct cfq_queue *cfqq)
-{
-	if (!cfq_cfqq_sync(cfqq))
-		return ASYNC_WORKLOAD;
-	if (!cfq_cfqq_idle_window(cfqq))
-		return SYNC_NOIDLE_WORKLOAD;
-	return SYNC_WORKLOAD;
-}
-
-static inline int cfq_busy_queues_wl(enum wl_class_t wl_class,
-					struct cfq_data *cfqd)
-{
-	if (wl_class == IDLE_WORKLOAD)
-		return cfqd->service_tree_idle.count;
-
-	return cfqd->service_trees[wl_class][ASYNC_WORKLOAD].count +
-		cfqd->service_trees[wl_class][SYNC_NOIDLE_WORKLOAD].count +
-		cfqd->service_trees[wl_class][SYNC_WORKLOAD].count;
-}
-
-static inline int cfq_busy_async_queues(struct cfq_data *cfqd)
-{
-	return cfqd->service_trees[RT_WORKLOAD][ASYNC_WORKLOAD].count +
-		cfqd->service_trees[BE_WORKLOAD][ASYNC_WORKLOAD].count;
-}
-
 static void cfq_dispatch_insert(struct request_queue *, struct request *);
 static struct cfq_queue *cfq_get_queue(struct cfq_data *cfqd, bool is_sync,
 				       struct cfq_io_cq *cic, struct bio *bio);
@@ -677,7 +636,7 @@ static void cfq_service_tree_add(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	int left;
 	int new_cfqq = 1;
 
-	st = &cfqd->service_trees[cfqq_class(cfqq)][cfqq_type(cfqq)];
+	st = &cfqd->service_trees[cfqq_class(cfqq)];
 	if (cfq_class_idle(cfqq)) {
 		rb_key = CFQ_IDLE_DELAY;
 		parent = rb_last(&st->rb);
@@ -999,8 +958,8 @@ static void __cfq_set_active_queue(struct cfq_data *cfqd,
 				   struct cfq_queue *cfqq)
 {
 	if (cfqq) {
-		cfq_log_cfqq(cfqd, cfqq, "set_active wl_class:%d wl_type:%d",
-				cfqd->serving_wl_class, cfqd->serving_wl_type);
+		cfq_log_cfqq(cfqd, cfqq, "set_active wl_class:%d",
+				cfqd->serving_wl_class);
 		cfqq->slice_start = 0;
 		cfqq->dispatch_start = jiffies;
 		cfqq->allocated_slice = 0;
@@ -1073,9 +1032,7 @@ static inline void cfq_slice_expired(struct cfq_data *cfqd, bool timed_out)
  */
 static struct cfq_queue *cfq_get_next_queue(struct cfq_data *cfqd)
 {
-	struct cfq_rb_root *st =
-		&cfqd->service_trees[cfqd->serving_wl_class]
-				    [cfqd->serving_wl_type];
+	struct cfq_rb_root *st = &cfqd->service_trees[cfqd->serving_wl_class];
 
 	if (!cfqd->rq_queued)
 		return NULL;
@@ -1201,6 +1158,15 @@ static void cfq_arm_slice_timer(struct cfq_data *cfqd)
 	cfq_log_cfqq(cfqd, cfqq, "arm_idle: %lu", sl);
 }
 
+static inline int cfq_busy_queues_wl(enum wl_class_t wl_class,
+				     struct cfq_data *cfqd)
+{
+	if (wl_class == IDLE_WORKLOAD)
+		return cfqd->service_tree_idle.count;
+
+	return cfqd->service_trees[wl_class].count;
+}
+
 /*
  * Move request from internal lists to the request queue dispatch list.
  */
@@ -1253,29 +1219,6 @@ cfq_prio_to_maxrq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 	return 2 * base_rq * (IOPRIO_BE_NR - cfqq->ioprio);
 }
 
-static enum wl_type_t cfq_choose_wl_type(struct cfq_data *cfqd,
-			enum wl_class_t wl_class)
-{
-	struct cfq_queue *queue;
-	int i;
-	bool key_valid = false;
-	unsigned long lowest_key = 0;
-	enum wl_type_t cur_best = SYNC_NOIDLE_WORKLOAD;
-
-	for (i = 0; i <= SYNC_WORKLOAD; ++i) {
-		/* select the one with lowest rb_key */
-		queue = cfq_rb_first(&cfqd->service_trees[wl_class][i]);
-		if (queue &&
-		    (!key_valid || time_before(queue->rb_key, lowest_key))) {
-			lowest_key = queue->rb_key;
-			cur_best = i;
-			key_valid = true;
-		}
-	}
-
-	return cur_best;
-}
-
 static void
 choose_wl_class_and_type(struct cfq_data *cfqd)
 {
@@ -1298,13 +1241,7 @@ choose_wl_class_and_type(struct cfq_data *cfqd)
 	if (original_class != cfqd->serving_wl_class)
 		goto new_workload;
 
-	/*
-	 * For RT and BE, we have to choose also the type
-	 * (SYNC, SYNC_NOIDLE, ASYNC), and to compute a workload
-	 * expiration time
-	 */
-	st = &cfqd->service_trees[cfqd->serving_wl_class]
-				 [cfqd->serving_wl_type];
+	st = &cfqd->service_trees[cfqd->serving_wl_class];
 	count = st->count;
 
 	/*
@@ -1314,26 +1251,11 @@ choose_wl_class_and_type(struct cfq_data *cfqd)
 		return;
 
 new_workload:
-	/* otherwise select new workload type */
-	cfqd->serving_wl_type = cfq_choose_wl_type(cfqd,
-					cfqd->serving_wl_class);
-	st = &cfqd->service_trees[cfqd->serving_wl_class]
-				 [cfqd->serving_wl_type];
+	st = &cfqd->service_trees[cfqd->serving_wl_class];
 	count = st->count;
 
-	if (cfqd->serving_wl_type == ASYNC_WORKLOAD) {
-		slice = cfqd->cfq_target_latency *
-			cfq_busy_async_queues(cfqd);
-		slice = slice/cfqd->busy_queues;
-
-		/* async workload slice is scaled down according to
-		 * the sync/async slice ratio. */
-		slice = slice * cfqd->cfq_slice[0] / cfqd->cfq_slice[1];
-	} else
-		/* sync workload slice is 2 * cfq_slice_idle */
-		slice = 2 * cfqd->cfq_slice_idle;
-
-	slice = max_t(unsigned, slice, CFQ_MIN_TT);
+	/* sync workload slice is 2 * cfq_slice_idle */
+	slice = max_t(unsigned int, 2 * cfqd->cfq_slice_idle, CFQ_MIN_TT);
 	cfq_log(cfqd, "workload slice:%d", slice);
 	cfqd->workload_expires = jiffies + slice;
 }
@@ -2078,8 +2000,7 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 		if (cfq_cfqq_on_rr(cfqq))
 			st = cfqq->service_tree;
 		else
-			st = &cfqd->service_trees[cfqq_class(cfqq)]
-						 [cfqq_type(cfqq)];
+			st = &cfqd->service_trees[cfqq_class(cfqq)];
 
 		st->ttime.last_end_request = now;
 		if (!time_after(rq->start_time + cfqd->cfq_fifo_expire[1], now))
-- 
1.9.1
