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
Subject: [PATCH V2 07/22] block, cfq: get rid of workload type
Date: Mon,  8 Aug 2016 13:15:02 +0200
Message-Id: <1470654917-4280-8-git-send-email-paolo.valente@linaro.org>
In-Reply-To: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org>
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
index 5e0daaf..329ed2b 100644
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
 	u64 workload_expires;
 
 	unsigned int busy_queues;
@@ -292,9 +279,8 @@ CFQ_CFQQ_FNS(wait_busy);
 #undef CFQ_CFQQ_FNS
 
 #define cfq_log_cfqq(cfqd, cfqq, fmt, args...)	\
-	blk_add_trace_msg((cfqd)->queue, "cfq%d%c%c " fmt, (cfqq)->pid,	\
+	blk_add_trace_msg((cfqd)->queue, "cfq%d%c " fmt, (cfqq)->pid,	\
 			cfq_cfqq_sync((cfqq)) ? 'S' : 'A',		\
-			cfqq_type((cfqq)) == SYNC_NOIDLE_WORKLOAD ? 'N' : ' ',\
 				##args)
 
 #define cfq_log(cfqd, fmt, args...)	\
@@ -303,12 +289,12 @@ CFQ_CFQQ_FNS(wait_busy);
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
@@ -329,33 +315,6 @@ static inline enum wl_class_t cfqq_class(struct cfq_queue *cfqq)
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
@@ -689,7 +648,7 @@ static void cfq_service_tree_add(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	int new_cfqq = 1;
 	u64 now = ktime_get_ns();
 
-	st = &cfqd->service_trees[cfqq_class(cfqq)][cfqq_type(cfqq)];
+	st = &cfqd->service_trees[cfqq_class(cfqq)];
 	if (cfq_class_idle(cfqq)) {
 		rb_key = CFQ_IDLE_DELAY;
 		parent = rb_last(&st->rb);
@@ -1017,8 +976,8 @@ static void __cfq_set_active_queue(struct cfq_data *cfqd,
 				   struct cfq_queue *cfqq)
 {
 	if (cfqq) {
-		cfq_log_cfqq(cfqd, cfqq, "set_active wl_class:%d wl_type:%d",
-				cfqd->serving_wl_class, cfqd->serving_wl_type);
+		cfq_log_cfqq(cfqd, cfqq, "set_active wl_class:%d",
+				cfqd->serving_wl_class);
 		cfqq->slice_start = 0;
 		cfqq->dispatch_start = ktime_get_ns();
 		cfqq->allocated_slice = 0;
@@ -1091,9 +1050,7 @@ static inline void cfq_slice_expired(struct cfq_data *cfqd, bool timed_out)
  */
 static struct cfq_queue *cfq_get_next_queue(struct cfq_data *cfqd)
 {
-	struct cfq_rb_root *st =
-		&cfqd->service_trees[cfqd->serving_wl_class]
-				    [cfqd->serving_wl_type];
+	struct cfq_rb_root *st = &cfqd->service_trees[cfqd->serving_wl_class];
 
 	if (!cfqd->rq_queued)
 		return NULL;
@@ -1221,6 +1178,15 @@ static void cfq_arm_slice_timer(struct cfq_data *cfqd)
 	cfq_log_cfqq(cfqd, cfqq, "arm_idle: %llu", sl);
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
@@ -1273,29 +1239,6 @@ cfq_prio_to_maxrq(struct cfq_data *cfqd, struct cfq_queue *cfqq)
 	return 2 * base_rq * (IOPRIO_BE_NR - cfqq->ioprio);
 }
 
-static enum wl_type_t cfq_choose_wl_type(struct cfq_data *cfqd,
-			enum wl_class_t wl_class)
-{
-	struct cfq_queue *queue;
-	int i;
-	bool key_valid = false;
-	u64 lowest_key = 0;
-	enum wl_type_t cur_best = SYNC_NOIDLE_WORKLOAD;
-
-	for (i = 0; i <= SYNC_WORKLOAD; ++i) {
-		/* select the one with lowest rb_key */
-		queue = cfq_rb_first(&cfqd->service_trees[wl_class][i]);
-		if (queue &&
-		    (!key_valid || queue->rb_key < lowest_key)) {
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
@@ -1319,13 +1262,7 @@ choose_wl_class_and_type(struct cfq_data *cfqd)
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
@@ -1335,26 +1272,11 @@ choose_wl_class_and_type(struct cfq_data *cfqd)
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
-		slice = div_u64(slice, cfqd->busy_queues);
-
-		/* async workload slice is scaled down according to
-		 * the sync/async slice ratio. */
-		slice = div64_u64(slice*cfqd->cfq_slice[0], cfqd->cfq_slice[1]);
-	} else
-		/* sync workload slice is 2 * cfq_slice_idle */
-		slice = 2 * cfqd->cfq_slice_idle;
-
-	slice = max_t(u64, slice, CFQ_MIN_TT);
+	/* sync workload slice is at least 2 * cfq_slice_idle */
+	slice = max_t(u64, 2 * cfqd->cfq_slice_idle, CFQ_MIN_TT);
 	cfq_log(cfqd, "workload slice:%llu", slice);
 	cfqd->workload_expires = now + slice;
 }
@@ -2102,8 +2024,7 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 		if (cfq_cfqq_on_rr(cfqq))
 			st = cfqq->service_tree;
 		else
-			st = &cfqd->service_trees[cfqq_class(cfqq)]
-						 [cfqq_type(cfqq)];
+			st = &cfqd->service_trees[cfqq_class(cfqq)];
 
 		st->ttime.last_end_request = now;
 		/*
-- 
1.9.1
