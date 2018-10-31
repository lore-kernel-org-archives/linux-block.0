Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 30/30] block: get rid of q->softirq_done_fn()
Date: Wed, 31 Oct 2018 11:59:22 -0600
Message-Id: <20181031175922.8849-31-axboe@kernel.dk>
In-Reply-To: <20181031175922.8849-1-axboe@kernel.dk>
References: <20181031175922.8849-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

With the legacy path gone, all we do is funnel it through the
mq_ops->complete() operation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 17 ++++++++---------
 block/blk-settings.c   |  6 ------
 block/blk-softirq.c    |  4 ++--
 include/linux/blk-mq.h |  3 ++-
 include/linux/blkdev.h |  3 ---
 5 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 21e4147c4810..f1f47dd08da7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -546,13 +546,15 @@ EXPORT_SYMBOL(blk_mq_end_request);
 static void __blk_mq_complete_request_remote(void *data)
 {
 	struct request *rq = data;
+	struct request_queue *q = rq->q;
 
-	rq->q->softirq_done_fn(rq);
+	q->mq_ops->complete(rq);
 }
 
 static void __blk_mq_complete_request(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
+	struct request_queue *q = rq->q;
 	bool shared = false;
 	int cpu;
 
@@ -568,18 +570,18 @@ static void __blk_mq_complete_request(struct request *rq)
 	 * So complete IO reqeust in softirq context in case of single queue
 	 * for not degrading IO performance by irqsoff latency.
 	 */
-	if (rq->q->nr_hw_queues == 1) {
+	if (q->nr_hw_queues == 1) {
 		__blk_complete_request(rq);
 		return;
 	}
 
-	if (!test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags)) {
-		rq->q->softirq_done_fn(rq);
+	if (!test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
+		q->mq_ops->complete(rq);
 		return;
 	}
 
 	cpu = get_cpu();
-	if (!test_bit(QUEUE_FLAG_SAME_FORCE, &rq->q->queue_flags))
+	if (!test_bit(QUEUE_FLAG_SAME_FORCE, &q->queue_flags))
 		shared = cpus_share_cache(cpu, ctx->cpu);
 
 	if (cpu != ctx->cpu && !shared && cpu_online(ctx->cpu)) {
@@ -588,7 +590,7 @@ static void __blk_mq_complete_request(struct request *rq)
 		rq->csd.flags = 0;
 		smp_call_function_single_async(ctx->cpu, &rq->csd);
 	} else {
-		rq->q->softirq_done_fn(rq);
+		q->mq_ops->complete(rq);
 	}
 	put_cpu();
 }
@@ -2701,9 +2703,6 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	 */
 	q->poll_nsec = -1;
 
-	if (set->ops->complete)
-		blk_queue_softirq_done(q, set->ops->complete);
-
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_add_queue_tag_set(set, q);
 	blk_mq_map_swqueue(q);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 1895f499bbe5..e111b3e4e96e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -20,12 +20,6 @@ EXPORT_SYMBOL(blk_max_low_pfn);
 
 unsigned long blk_max_pfn;
 
-void blk_queue_softirq_done(struct request_queue *q, softirq_done_fn *fn)
-{
-	q->softirq_done_fn = fn;
-}
-EXPORT_SYMBOL(blk_queue_softirq_done);
-
 void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 {
 	q->rq_timeout = timeout;
diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 8ca0f6caf174..727d64436ec4 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -34,7 +34,7 @@ static __latent_entropy void blk_done_softirq(struct softirq_action *h)
 
 		rq = list_entry(local_list.next, struct request, ipi_list);
 		list_del_init(&rq->ipi_list);
-		rq->q->softirq_done_fn(rq);
+		rq->q->mq_ops->complete(rq);
 	}
 }
 
@@ -102,7 +102,7 @@ void __blk_complete_request(struct request *req)
 	unsigned long flags;
 	bool shared = false;
 
-	BUG_ON(!q->softirq_done_fn);
+	BUG_ON(!q->mq_ops->complete);
 
 	local_irq_save(flags);
 	cpu = smp_processor_id();
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5c8418ebbfd6..9dd574e5436a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -115,6 +115,7 @@ typedef void (busy_tag_iter_fn)(struct request *, void *, bool);
 typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
 typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
 typedef bool (busy_fn)(struct request_queue *);
+typedef void (complete_fn)(struct request *);
 
 
 struct blk_mq_ops {
@@ -142,7 +143,7 @@ struct blk_mq_ops {
 	 */
 	poll_fn			*poll;
 
-	softirq_done_fn		*complete;
+	complete_fn		*complete;
 
 	/*
 	 * Called when the block layer side of a hardware queue has been
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c675e2b5af62..d4104844d6bb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -290,7 +290,6 @@ typedef blk_qc_t (make_request_fn) (struct request_queue *q, struct bio *bio);
 typedef bool (poll_q_fn) (struct request_queue *q, blk_qc_t);
 
 struct bio_vec;
-typedef void (softirq_done_fn)(struct request *);
 typedef int (dma_drain_needed_fn)(struct request *);
 
 enum blk_eh_timer_return {
@@ -407,7 +406,6 @@ struct request_queue {
 
 	make_request_fn		*make_request_fn;
 	poll_q_fn		*poll_fn;
-	softirq_done_fn		*softirq_done_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
 
 	const struct blk_mq_ops	*mq_ops;
@@ -1113,7 +1111,6 @@ extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
-extern void blk_queue_softirq_done(struct request_queue *, softirq_done_fn *);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
-- 
2.17.1
