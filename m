Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Merlin <marc@merlins.org>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/6] blk-mq: Fix queue freeze deadlock
Date: Wed,  4 Jan 2017 17:41:10 -0500
Message-Id: <1483569671-1462-6-git-send-email-keith.busch@intel.com>
In-Reply-To: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

If hardware queues are stopped for some event, like the device has been
suspended by power management, requests allocated on that hardware queue
are indefinitely stuck causing a queue freeze to wait forever.

This patch abandons requests on stopped queues after syncing with the
all queue_rq events when we need to rebalance the queues. While we
would prefer not to end the requests error if it's possible to submit
them on a different context, there's no good way to unwind a request to
submit on a valid context once it enters a stopped context for removal.
Ending IO with EAGAIN is a better alternative than deadlocking.

Reported-by: Marc Merlin <marc@merlins.org>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 67 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9b7ed03..0c9a2a3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -117,22 +117,12 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
-/**
- * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have finished
- * @q: request queue.
- *
- * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Additionally, it is not prevented that
- * new queue_rq() calls occur unless the queue has been stopped first.
- */
-void blk_mq_quiesce_queue(struct request_queue *q)
+static void blk_mq_sync_queue(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 	bool rcu = false;
 
-	blk_mq_stop_hw_queues(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
 			synchronize_srcu(&hctx->queue_rq_srcu);
@@ -142,6 +132,20 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	if (rcu)
 		synchronize_rcu();
 }
+
+/**
+ * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have finished
+ * @q: request queue.
+ *
+ * Note: this function does not prevent that the struct request end_io()
+ * callback function is invoked. Additionally, it is not prevented that
+ * new queue_rq() calls occur unless the queue has been stopped first.
+ */
+void blk_mq_quiesce_queue(struct request_queue *q)
+{
+	blk_mq_stop_hw_queues(q);
+	blk_mq_sync_queue(q);
+}
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
 void blk_mq_wake_waiters(struct request_queue *q)
@@ -2228,6 +2232,51 @@ static void blk_mq_queue_reinit(struct request_queue *q,
 	blk_mq_sysfs_register(q);
 }
 
+static void blk_mq_abandon_stopped_requests(struct request_queue *q)
+{
+	int i;
+	struct request *rq, *next;
+	struct blk_mq_hw_ctx *hctx;
+	LIST_HEAD(rq_list);
+
+	blk_mq_sync_queue(q);
+
+	spin_lock(&q->requeue_lock);
+	list_for_each_entry_safe(rq, next, &q->requeue_list, queuelist) {
+		struct blk_mq_ctx *ctx;
+
+		ctx = rq->mq_ctx;
+		hctx = blk_mq_map_queue(q, ctx->cpu);
+		if (blk_mq_hctx_stopped(hctx)) {
+			list_del_init(&rq->queuelist);
+
+			spin_lock(&hctx->lock);
+			list_add_tail(&rq->queuelist, &rq_list);
+			spin_unlock(&hctx->lock);
+		}
+	}
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (!blk_mq_hctx_stopped(hctx))
+			continue;
+
+		flush_busy_ctxs(hctx, &rq_list);
+
+		spin_lock(&hctx->lock);
+		if (!list_empty(&hctx->dispatch))
+			list_splice_init(&hctx->dispatch, &rq_list);
+		spin_unlock(&hctx->lock);
+	}
+	spin_unlock(&q->requeue_lock);
+
+	while (!list_empty(&rq_list)) {
+		rq = list_first_entry(&rq_list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		rq->errors = -EAGAIN;
+		blk_mq_end_request(rq, rq->errors);
+	}
+}
+
 /*
  * New online cpumask which is going to be set in this hotplug event.
  * Declare this cpumasks as global as cpu-hotplug operation is invoked
@@ -2250,6 +2299,8 @@ static void blk_mq_queue_reinit_work(void)
 	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_freeze_queue_start(q);
 	list_for_each_entry(q, &all_q_list, all_q_node)
+		blk_mq_abandon_stopped_requests(q);
+	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_freeze_queue_wait(q);
 
 	list_for_each_entry(q, &all_q_list, all_q_node)
@@ -2477,7 +2528,11 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 		return;
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
-		blk_mq_freeze_queue(q);
+		blk_mq_freeze_queue_start(q);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_abandon_stopped_requests(q);
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_freeze_queue_wait(q);
 
 	set->nr_hw_queues = nr_hw_queues;
 	if (set->ops->map_queues)
-- 
2.5.5
