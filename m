Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4701 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036479AbdEYSno (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 14:43:44 -0400
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Bart Van Assche" <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        "Omar Sandoval" <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 16/19] block: Document what queue type each function is intended for
Date: Thu, 25 May 2017 11:43:24 -0700
Message-ID: <20170525184327.23570-17-bart.vanassche@sandisk.com>
In-Reply-To: <20170525184327.23570-1-bart.vanassche@sandisk.com>
References: <20170525184327.23570-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Some functions in block/blk-core.c must only be used on blk-sq queues
while others are safe to use against any queue type. Document which
functions are intended for blk-sq queues and issue a warning if the
blk-sq API is misused.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 418236b68fb6..82e0dbfc593b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -185,6 +185,7 @@ static void blk_delay_work(struct work_struct *work)
 void blk_delay_queue(struct request_queue *q, unsigned long msecs)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (likely(!blk_queue_dead(q)))
 		queue_delayed_work(kblockd_workqueue, &q->delay_work,
@@ -204,6 +205,7 @@ EXPORT_SYMBOL(blk_delay_queue);
 void blk_start_queue_async(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
 	blk_run_queue_async(q);
@@ -223,6 +225,7 @@ void blk_start_queue(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
 	WARN_ON(!irqs_disabled());
+	WARN_ON_ONCE(q->mq_ops);
 
 	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
 	__blk_run_queue(q);
@@ -246,6 +249,7 @@ EXPORT_SYMBOL(blk_start_queue);
 void blk_stop_queue(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	cancel_delayed_work(&q->delay_work);
 	queue_flag_set(QUEUE_FLAG_STOPPED, q);
@@ -300,6 +304,7 @@ EXPORT_SYMBOL(blk_sync_queue);
 inline void __blk_run_queue_uncond(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (unlikely(blk_queue_dead(q)))
 		return;
@@ -327,6 +332,7 @@ EXPORT_SYMBOL_GPL(__blk_run_queue_uncond);
 void __blk_run_queue(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (unlikely(blk_queue_stopped(q)))
 		return;
@@ -351,6 +357,7 @@ EXPORT_SYMBOL(__blk_run_queue);
 void blk_run_queue_async(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	if (likely(!blk_queue_stopped(q) && !blk_queue_dead(q)))
 		mod_delayed_work(kblockd_workqueue, &q->delay_work, 0);
@@ -369,6 +376,8 @@ void blk_run_queue(struct request_queue *q)
 {
 	unsigned long flags;
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	spin_lock_irqsave(q->queue_lock, flags);
 	__blk_run_queue(q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
@@ -397,6 +406,7 @@ static void __blk_drain_queue(struct request_queue *q, bool drain_all)
 	int i;
 
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	while (true) {
 		bool drain = false;
@@ -475,6 +485,8 @@ static void __blk_drain_queue(struct request_queue *q, bool drain_all)
  */
 void blk_queue_bypass_start(struct request_queue *q)
 {
+	WARN_ON_ONCE(q->mq_ops);
+
 	spin_lock_irq(q->queue_lock);
 	q->bypass_depth++;
 	queue_flag_set(QUEUE_FLAG_BYPASS, q);
@@ -504,6 +516,8 @@ EXPORT_SYMBOL_GPL(blk_queue_bypass_start);
  */
 void blk_queue_bypass_end(struct request_queue *q)
 {
+	WARN_ON_ONCE(q->mq_ops);
+
 	spin_lock_irq(q->queue_lock);
 	if (!--q->bypass_depth)
 		queue_flag_clear(QUEUE_FLAG_BYPASS, q);
@@ -898,6 +912,8 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio);
 
 int blk_init_allocated_queue(struct request_queue *q)
 {
+	WARN_ON_ONCE(q->mq_ops);
+
 	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size);
 	if (!q->fq)
 		return -ENOMEM;
@@ -1035,6 +1051,8 @@ int blk_update_nr_requests(struct request_queue *q, unsigned int nr)
 	struct request_list *rl;
 	int on_thresh, off_thresh;
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	spin_lock_irq(q->queue_lock);
 	q->nr_requests = nr;
 	blk_queue_congestion_threshold(q);
@@ -1273,6 +1291,7 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	struct request *rq;
 
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	rl = blk_get_rl(q, bio);	/* transferred to @rq on success */
 retry:
@@ -1312,6 +1331,8 @@ static struct request *blk_old_get_request(struct request_queue *q, int rw,
 {
 	struct request *rq;
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	/* create ioc upfront */
 	create_io_context(gfp_mask, q->node);
 
@@ -1353,6 +1374,7 @@ EXPORT_SYMBOL(blk_get_request);
 void blk_requeue_request(struct request_queue *q, struct request *rq)
 {
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	blk_delete_timer(rq);
 	blk_clear_rq_complete(rq);
@@ -2409,6 +2431,7 @@ struct request *blk_peek_request(struct request_queue *q)
 	int ret;
 
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	while ((rq = __elv_next_request(q)) != NULL) {
 
@@ -2530,6 +2553,7 @@ void blk_dequeue_request(struct request *rq)
 void blk_start_request(struct request *req)
 {
 	lockdep_assert_held(req->q->queue_lock);
+	WARN_ON_ONCE(req->q->mq_ops);
 
 	blk_dequeue_request(req);
 
@@ -2561,6 +2585,7 @@ struct request *blk_fetch_request(struct request_queue *q)
 	struct request *rq;
 
 	lockdep_assert_held(q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 
 	rq = blk_peek_request(q);
 	if (rq)
@@ -2742,6 +2767,7 @@ void blk_finish_request(struct request *req, int error)
 	struct request_queue *q = req->q;
 
 	lockdep_assert_held(req->q->queue_lock);
+	WARN_ON_ONCE(q->mq_ops);
 	
 	if (req->rq_flags & RQF_STATS)
 		blk_stat_add(req);
@@ -2796,6 +2822,8 @@ static bool blk_end_bidi_request(struct request *rq, int error,
 	struct request_queue *q = rq->q;
 	unsigned long flags;
 
+	WARN_ON_ONCE(q->mq_ops);
+
 	if (blk_update_bidi_request(rq, error, nr_bytes, bidi_bytes))
 		return true;
 
@@ -2825,6 +2853,7 @@ static bool __blk_end_bidi_request(struct request *rq, int error,
 				   unsigned int nr_bytes, unsigned int bidi_bytes)
 {
 	lockdep_assert_held(rq->q->queue_lock);
+	WARN_ON_ONCE(rq->q->mq_ops);
 
 	if (blk_update_bidi_request(rq, error, nr_bytes, bidi_bytes))
 		return true;
@@ -2850,6 +2879,7 @@ static bool __blk_end_bidi_request(struct request *rq, int error,
  **/
 bool blk_end_request(struct request *rq, int error, unsigned int nr_bytes)
 {
+	WARN_ON_ONCE(rq->q->mq_ops);
 	return blk_end_bidi_request(rq, error, nr_bytes, 0);
 }
 EXPORT_SYMBOL(blk_end_request);
@@ -2891,6 +2921,7 @@ EXPORT_SYMBOL(blk_end_request_all);
 bool __blk_end_request(struct request *rq, int error, unsigned int nr_bytes)
 {
 	lockdep_assert_held(rq->q->queue_lock);
+	WARN_ON_ONCE(rq->q->mq_ops);
 
 	return __blk_end_bidi_request(rq, error, nr_bytes, 0);
 }
@@ -2910,6 +2941,7 @@ void __blk_end_request_all(struct request *rq, int error)
 	unsigned int bidi_bytes = 0;
 
 	lockdep_assert_held(rq->q->queue_lock);
+	WARN_ON_ONCE(rq->q->mq_ops);
 
 	if (unlikely(blk_bidi_rq(rq)))
 		bidi_bytes = blk_rq_bytes(rq->next_rq);
-- 
2.12.2
