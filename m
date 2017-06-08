Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>, "Omar
 Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 09/12] block: Document what queue type each function is intended for
Date: Thu, 8 Jun 2017 10:33:52 -0700
Message-ID: <20170608173355.25898-10-bart.vanassche@sandisk.com>
In-Reply-To: <20170608173355.25898-1-bart.vanassche@sandisk.com>
References: <20170608173355.25898-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Some functions in block/blk-core.c must only be used on blk-sq queues
while others are safe to use against any queue type. Document which
functions are intended for blk-sq queues and issue a warning if the
blk-sq API is misused. This does not only help block driver authors
but will also make it easier to remove the blk-sq code once that code
is declared obsolete.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 33 +++++++++++++++++++++++++++++++++
 block/blk.h      |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6bbdce8b8b6f..ab4cb509c170 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -182,6 +182,7 @@ static void blk_delay_work(struct work_struct *work)
 void blk_delay_queue(struct request_queue *q, unsigned long msecs)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (likely(!blk_queue_dead(q)))
 		queue_delayed_work(kblockd_workqueue, &q->delay_work,
@@ -201,6 +202,7 @@ EXPORT_SYMBOL(blk_delay_queue);
 void blk_start_queue_async(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
 	blk_run_queue_async(q);
@@ -220,6 +222,7 @@ void blk_start_queue(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
 	WARN_ON(!irqs_disabled());
+	WARN_ON_ONCE(q->mq_ops);
 
 	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
 	__blk_run_queue(q);
@@ -243,6 +246,7 @@ EXPORT_SYMBOL(blk_start_queue);
 void blk_stop_queue(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	cancel_delayed_work(&q->delay_work);
 	queue_flag_set(QUEUE_FLAG_STOPPED, q);
@@ -297,6 +301,7 @@ EXPORT_SYMBOL(blk_sync_queue);
 inline void __blk_run_queue_uncond(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (unlikely(blk_queue_dead(q)))
 		return;
@@ -324,6 +329,7 @@ EXPORT_SYMBOL_GPL(__blk_run_queue_uncond);
 void __blk_run_queue(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (unlikely(blk_queue_stopped(q)))
 		return;
@@ -348,6 +354,7 @@ EXPORT_SYMBOL(__blk_run_queue);
 void blk_run_queue_async(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (likely(!blk_queue_stopped(q) && !blk_queue_dead(q)))
 		mod_delayed_work(kblockd_workqueue, &q->delay_work, 0);
@@ -366,6 +373,8 @@ void blk_run_queue(struct request_queue *q)
 {
 	unsigned long flags;
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	spin_lock_irqsave(q->queue_lock, flags);
 	__blk_run_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
@@ -394,6 +403,7 @@ static void __blk_drain_queue(struct request_queue *q, bool drain_all)
 	int i;
 
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	while (true) {
 		bool drain = false;
@@ -472,6 +482,8 @@ static void __blk_drain_queue(struct request_queue *q, bool drain_all)
  */
 void blk_queue_bypass_start(struct request_queue *q)
 {
+	WARN_ON_ONCE(q->mq_ops);
+
 	spin_lock_irq(q->queue_lock);
 	q->bypass_depth++;
 	queue_flag_set(QUEUE_FLAG_BYPASS, q);
@@ -498,6 +510,9 @@ EXPORT_SYMBOL_GPL(blk_queue_bypass_start);
  * @q: queue of interest
  *
  * Leave bypass mode and restore the normal queueing behavior.
+ *
+ * Note: although blk_queue_bypass_start() is only called for blk-sq queues,
+ * this function is called for both blk-sq and blk-mq queues.
  */
 void blk_queue_bypass_end(struct request_queue *q)
 {
@@ -895,6 +910,8 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio);
 
 int blk_init_allocated_queue(struct request_queue *q)
 {
+	WARN_ON_ONCE(q->mq_ops);
+
 	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size);
 	if (!q->fq)
 		return -ENOMEM;
@@ -1032,6 +1049,8 @@ int blk_update_nr_requests(struct request_queue *q, unsigned int nr)
 	struct request_list *rl;
 	int on_thresh, off_thresh;
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	spin_lock_irq(q->queue_lock);
 	q->nr_requests = nr;
 	blk_queue_congestion_threshold(q);
@@ -1270,6 +1289,7 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	struct request *rq;
 
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	rl = blk_get_rl(q, bio);	/* transferred to @rq on success */
 retry:
@@ -1309,6 +1329,8 @@ static struct request *blk_old_get_request(struct request_queue *q,
 {
 	struct request *rq;
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	/* create ioc upfront */
 	create_io_context(gfp_mask, q->node);
 
@@ -1364,6 +1386,7 @@ EXPORT_SYMBOL(blk_get_request);
 void blk_requeue_request(struct request_queue *q, struct request *rq)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	blk_delete_timer(rq);
 	blk_clear_rq_complete(rq);
@@ -2420,6 +2443,7 @@ struct request *blk_peek_request(struct request_queue *q)
 	int ret;
 
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	while ((rq = __elv_next_request(q)) != NULL) {
 
@@ -2541,6 +2565,7 @@ void blk_dequeue_request(struct request *rq)
 void blk_start_request(struct request *req)
 {
 	lockdep_assert_held(req->q->queue_lock);
+	WARN_ON_ONCE(req->q->mq_ops);
 
 	blk_dequeue_request(req);
 
@@ -2572,6 +2597,7 @@ struct request *blk_fetch_request(struct request_queue *q)
 	struct request *rq;
 
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	rq = blk_peek_request(q);
 	if (rq)
@@ -2753,6 +2779,7 @@ void blk_finish_request(struct request *req, int error)
 	struct request_queue *q = req->q;
 
 	lockdep_assert_held(req->q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (req->rq_flags & RQF_STATS)
 		blk_stat_add(req);
@@ -2807,6 +2834,8 @@ static bool blk_end_bidi_request(struct request *rq, int error,
 	struct request_queue *q = rq->q;
 	unsigned long flags;
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	if (blk_update_bidi_request(rq, error, nr_bytes, bidi_bytes))
 		return true;
 
@@ -2836,6 +2865,7 @@ static bool __blk_end_bidi_request(struct request *rq, int error,
 				   unsigned int nr_bytes, unsigned int bidi_bytes)
 {
 	lockdep_assert_held(rq->q->queue_lock);
+	WARN_ON_ONCE(rq->q->mq_ops);
 
 	if (blk_update_bidi_request(rq, error, nr_bytes, bidi_bytes))
 		return true;
@@ -2861,6 +2891,7 @@ static bool __blk_end_bidi_request(struct request *rq, int error,
  **/
 bool blk_end_request(struct request *rq, int error, unsigned int nr_bytes)
 {
+	WARN_ON_ONCE(rq->q->mq_ops);
 	return blk_end_bidi_request(rq, error, nr_bytes, 0);
 }
 EXPORT_SYMBOL(blk_end_request);
@@ -2902,6 +2933,7 @@ EXPORT_SYMBOL(blk_end_request_all);
 bool __blk_end_request(struct request *rq, int error, unsigned int nr_bytes)
 {
 	lockdep_assert_held(rq->q->queue_lock);
+	WARN_ON_ONCE(rq->q->mq_ops);
 
 	return __blk_end_bidi_request(rq, error, nr_bytes, 0);
 }
@@ -2921,6 +2953,7 @@ void __blk_end_request_all(struct request *rq, int error)
 	unsigned int bidi_bytes = 0;
 
 	lockdep_assert_held(rq->q->queue_lock);
+	WARN_ON_ONCE(rq->q->mq_ops);
 
 	if (unlikely(blk_bidi_rq(rq)))
 		bidi_bytes = blk_rq_bytes(rq->next_rq);
diff --git a/block/blk.h b/block/blk.h
index 83c8e1100525..798691a5e5e9 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -143,6 +143,8 @@ static inline struct request *__elv_next_request(struct request_queue *q)
 	struct request *rq;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, NULL);
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	while (1) {
 		if (!list_empty(&q->queue_head)) {
 			rq = list_entry_rq(q->queue_head.next);
-- 
2.12.2
