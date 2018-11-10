Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/6] blk-mq: embed blk_mq_ops directly in the request queue
Date: Sat, 10 Nov 2018 08:13:14 -0700
Message-Id: <20181110151317.3813-4-axboe@kernel.dk>
In-Reply-To: <20181110151317.3813-1-axboe@kernel.dk>
References: <20181110151317.3813-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

This saves an indirect function call everytime we have to
call one of the strategy functions. We keep it const, and just
hack around that a bit in blk_mq_init_allocated_queue(), which
is where we copy the ops in.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c           |   8 +--
 block/blk-mq-debugfs.c     |   2 +-
 block/blk-mq.c             |  22 ++++----
 block/blk-mq.h             |  12 ++---
 block/blk-softirq.c        |   4 +-
 block/blk-sysfs.c          |   4 +-
 drivers/scsi/scsi_lib.c    |   2 +-
 include/linux/blk-mq-ops.h | 100 +++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h     |  94 +---------------------------------
 include/linux/blkdev.h     |   6 ++-
 10 files changed, 132 insertions(+), 122 deletions(-)
 create mode 100644 include/linux/blk-mq-ops.h

diff --git a/block/blk-core.c b/block/blk-core.c
index ab6675fd3568..88400ab166ac 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -656,8 +656,8 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT));
 
 	req = blk_mq_alloc_request(q, op, flags);
-	if (!IS_ERR(req) && q->mq_ops->initialize_rq_fn)
-		q->mq_ops->initialize_rq_fn(req);
+	if (!IS_ERR(req) && q->mq_ops.initialize_rq_fn)
+		q->mq_ops.initialize_rq_fn(req);
 
 	return req;
 }
@@ -1736,8 +1736,8 @@ EXPORT_SYMBOL_GPL(rq_flush_dcache_pages);
  */
 int blk_lld_busy(struct request_queue *q)
 {
-	if (queue_is_mq(q) && q->mq_ops->busy)
-		return q->mq_ops->busy(q);
+	if (q->mq_ops.busy)
+		return q->mq_ops.busy(q);
 
 	return 0;
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f021f4817b80..efdfb6258e03 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -354,7 +354,7 @@ static const char *blk_mq_rq_state_name(enum mq_rq_state rq_state)
 
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
-	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
+	const struct blk_mq_ops *const mq_ops = &rq->q->mq_ops;
 	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
 
 	seq_printf(m, "%p {.op=", rq);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index eb9b9596d3de..6e0cb6adfc90 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -558,7 +558,7 @@ static void __blk_mq_complete_request_remote(void *data)
 	struct request *rq = data;
 	struct request_queue *q = rq->q;
 
-	q->mq_ops->complete(rq);
+	q->mq_ops.complete(rq);
 }
 
 static void __blk_mq_complete_request(struct request *rq)
@@ -586,7 +586,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	}
 
 	if (!test_bit(QUEUE_FLAG_SAME_COMP, &q->queue_flags)) {
-		q->mq_ops->complete(rq);
+		q->mq_ops.complete(rq);
 		return;
 	}
 
@@ -600,7 +600,7 @@ static void __blk_mq_complete_request(struct request *rq)
 		rq->csd.flags = 0;
 		smp_call_function_single_async(ctx->cpu, &rq->csd);
 	} else {
-		q->mq_ops->complete(rq);
+		q->mq_ops.complete(rq);
 	}
 	put_cpu();
 }
@@ -818,10 +818,10 @@ EXPORT_SYMBOL_GPL(blk_mq_queue_busy);
 static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
 	req->rq_flags |= RQF_TIMED_OUT;
-	if (req->q->mq_ops->timeout) {
+	if (req->q->mq_ops.timeout) {
 		enum blk_eh_timer_return ret;
 
-		ret = req->q->mq_ops->timeout(req, reserved);
+		ret = req->q->mq_ops.timeout(req, reserved);
 		if (ret == BLK_EH_DONE)
 			return;
 		WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
@@ -1221,7 +1221,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			bd.last = !blk_mq_get_driver_tag(nxt);
 		}
 
-		ret = q->mq_ops->queue_rq(hctx, &bd);
+		ret = q->mq_ops.queue_rq(hctx, &bd);
 		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
 			/*
 			 * If an I/O scheduler has been configured and we got a
@@ -1746,7 +1746,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 * Any other error (busy), just add it to our list as we
 	 * previously would have done.
 	 */
-	ret = q->mq_ops->queue_rq(hctx, &bd);
+	ret = q->mq_ops.queue_rq(hctx, &bd);
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
@@ -2723,7 +2723,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
 	/* mark the queue as mq asap */
-	q->mq_ops = set->ops;
+	memcpy((void *) &q->mq_ops, set->ops, sizeof(q->mq_ops));
 
 	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
 					     blk_mq_poll_stats_bkt,
@@ -2765,7 +2765,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	spin_lock_init(&q->requeue_lock);
 
 	blk_queue_make_request(q, blk_mq_make_request);
-	if (q->mq_ops->poll)
+	if (q->mq_ops.poll)
 		q->poll_fn = blk_mq_poll;
 
 	/*
@@ -2797,7 +2797,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 err_percpu:
 	free_percpu(q->queue_ctx);
 err_exit:
-	q->mq_ops = NULL;
+	memset((void *) &q->mq_ops, 0, sizeof(q->mq_ops));
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(blk_mq_init_allocated_queue);
@@ -3328,7 +3328,7 @@ static bool __blk_mq_poll(struct blk_mq_hw_ctx *hctx, struct request *rq)
 
 		hctx->poll_invoked++;
 
-		ret = q->mq_ops->poll(hctx, rq->tag);
+		ret = q->mq_ops.poll(hctx, rq->tag);
 		if (ret > 0) {
 			hctx->poll_success++;
 			set_current_state(TASK_RUNNING);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index facb6e9ddce4..1eb6a3e8af58 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -99,8 +99,8 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 {
 	int hctx_type = 0;
 
-	if (q->mq_ops->rq_flags_to_type)
-		hctx_type = q->mq_ops->rq_flags_to_type(q, flags);
+	if (q->mq_ops.rq_flags_to_type)
+		hctx_type = q->mq_ops.rq_flags_to_type(q, flags);
 
 	return blk_mq_map_queue_type(q, hctx_type, cpu);
 }
@@ -187,16 +187,16 @@ static inline void blk_mq_put_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 
-	if (q->mq_ops->put_budget)
-		q->mq_ops->put_budget(hctx);
+	if (q->mq_ops.put_budget)
+		q->mq_ops.put_budget(hctx);
 }
 
 static inline bool blk_mq_get_dispatch_budget(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 
-	if (q->mq_ops->get_budget)
-		return q->mq_ops->get_budget(hctx);
+	if (q->mq_ops.get_budget)
+		return q->mq_ops.get_budget(hctx);
 	return true;
 }
 
diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 1534066e306e..2f4176668470 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -34,7 +34,7 @@ static __latent_entropy void blk_done_softirq(struct softirq_action *h)
 
 		rq = list_entry(local_list.next, struct request, ipi_list);
 		list_del_init(&rq->ipi_list);
-		rq->q->mq_ops->complete(rq);
+		rq->q->mq_ops.complete(rq);
 	}
 }
 
@@ -102,7 +102,7 @@ void __blk_complete_request(struct request *req)
 	unsigned long flags;
 	bool shared = false;
 
-	BUG_ON(!q->mq_ops->complete);
+	BUG_ON(!q->mq_ops.complete);
 
 	local_irq_save(flags);
 	cpu = smp_processor_id();
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 93635a693314..9661ef5b390f 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -380,7 +380,7 @@ static ssize_t queue_poll_delay_store(struct request_queue *q, const char *page,
 {
 	int err, val;
 
-	if (!q->mq_ops || !q->mq_ops->poll)
+	if (!q->mq_ops.poll)
 		return -EINVAL;
 
 	err = kstrtoint(page, 10, &val);
@@ -406,7 +406,7 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	unsigned long poll_on;
 	ssize_t ret;
 
-	if (!q->mq_ops || !q->mq_ops->poll)
+	if (!q->mq_ops.poll)
 		return -EINVAL;
 
 	ret = queue_var_store(&poll_on, page, count);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5d83a162d03b..61babcb269ab 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1907,7 +1907,7 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 {
 	struct scsi_device *sdev = NULL;
 
-	if (q->mq_ops == &scsi_mq_ops)
+	if (q->mq_ops.queue_rq == scsi_mq_ops.queue_rq)
 		sdev = q->queuedata;
 	if (!sdev || !get_device(&sdev->sdev_gendev))
 		sdev = NULL;
diff --git a/include/linux/blk-mq-ops.h b/include/linux/blk-mq-ops.h
new file mode 100644
index 000000000000..0940c26875ca
--- /dev/null
+++ b/include/linux/blk-mq-ops.h
@@ -0,0 +1,100 @@
+#ifndef BLK_MQ_OPS_H
+#define BLK_MQ_OPS_H
+
+struct blk_mq_queue_data;
+struct blk_mq_hw_ctx;
+struct blk_mq_tag_set;
+
+typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
+		const struct blk_mq_queue_data *);
+/* takes rq->cmd_flags as input, returns a hardware type index */
+typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
+typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
+typedef void (put_budget_fn)(struct blk_mq_hw_ctx *);
+typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
+typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
+typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
+typedef int (init_request_fn)(struct blk_mq_tag_set *set, struct request *,
+		unsigned int, unsigned int);
+typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
+		unsigned int);
+
+typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
+		bool);
+typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
+typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
+typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
+typedef bool (busy_fn)(struct request_queue *);
+typedef void (complete_fn)(struct request *);
+
+struct blk_mq_ops {
+	/*
+	 * Queue request
+	 */
+	queue_rq_fn		*queue_rq;
+
+	/*
+	 * Return a queue map type for the given request/bio flags
+	 */
+	rq_flags_to_type_fn	*rq_flags_to_type;
+
+	/*
+	 * Reserve budget before queue request, once .queue_rq is
+	 * run, it is driver's responsibility to release the
+	 * reserved budget. Also we have to handle failure case
+	 * of .get_budget for avoiding I/O deadlock.
+	 */
+	get_budget_fn		*get_budget;
+	put_budget_fn		*put_budget;
+
+	/*
+	 * Called on request timeout
+	 */
+	timeout_fn		*timeout;
+
+	/*
+	 * Called to poll for completion of a specific tag.
+	 */
+	poll_fn			*poll;
+
+	complete_fn		*complete;
+
+	/*
+	 * Called when the block layer side of a hardware queue has been
+	 * set up, allowing the driver to allocate/init matching structures.
+	 * Ditto for exit/teardown.
+	 */
+	init_hctx_fn		*init_hctx;
+	exit_hctx_fn		*exit_hctx;
+
+	/*
+	 * Called for every command allocated by the block layer to allow
+	 * the driver to set up driver specific data.
+	 *
+	 * Tag greater than or equal to queue_depth is for setting up
+	 * flush request.
+	 *
+	 * Ditto for exit/teardown.
+	 */
+	init_request_fn		*init_request;
+	exit_request_fn		*exit_request;
+	/* Called from inside blk_get_request() */
+	void (*initialize_rq_fn)(struct request *rq);
+
+	/*
+	 * If set, returns whether or not this queue currently is busy
+	 */
+	busy_fn			*busy;
+
+	map_queues_fn		*map_queues;
+
+#ifdef CONFIG_BLK_DEBUG_FS
+	/*
+	 * Used by the debugfs implementation to show driver-specific
+	 * information about a request.
+	 */
+	void (*show_rq)(struct seq_file *m, struct request *rq);
+#endif
+};
+
+#endif
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 929e8abc5535..e32e9293e5a0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -5,6 +5,7 @@
 #include <linux/blkdev.h>
 #include <linux/sbitmap.h>
 #include <linux/srcu.h>
+#include <linux/blk-mq-ops.h>
 
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -115,99 +116,6 @@ struct blk_mq_queue_data {
 	bool last;
 };
 
-typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
-		const struct blk_mq_queue_data *);
-/* takes rq->cmd_flags as input, returns a hardware type index */
-typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
-typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
-typedef void (put_budget_fn)(struct blk_mq_hw_ctx *);
-typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
-typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
-typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
-typedef int (init_request_fn)(struct blk_mq_tag_set *set, struct request *,
-		unsigned int, unsigned int);
-typedef void (exit_request_fn)(struct blk_mq_tag_set *set, struct request *,
-		unsigned int);
-
-typedef bool (busy_iter_fn)(struct blk_mq_hw_ctx *, struct request *, void *,
-		bool);
-typedef bool (busy_tag_iter_fn)(struct request *, void *, bool);
-typedef int (poll_fn)(struct blk_mq_hw_ctx *, unsigned int);
-typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
-typedef bool (busy_fn)(struct request_queue *);
-typedef void (complete_fn)(struct request *);
-
-
-struct blk_mq_ops {
-	/*
-	 * Queue request
-	 */
-	queue_rq_fn		*queue_rq;
-
-	/*
-	 * Return a queue map type for the given request/bio flags
-	 */
-	rq_flags_to_type_fn	*rq_flags_to_type;
-
-	/*
-	 * Reserve budget before queue request, once .queue_rq is
-	 * run, it is driver's responsibility to release the
-	 * reserved budget. Also we have to handle failure case
-	 * of .get_budget for avoiding I/O deadlock.
-	 */
-	get_budget_fn		*get_budget;
-	put_budget_fn		*put_budget;
-
-	/*
-	 * Called on request timeout
-	 */
-	timeout_fn		*timeout;
-
-	/*
-	 * Called to poll for completion of a specific tag.
-	 */
-	poll_fn			*poll;
-
-	complete_fn		*complete;
-
-	/*
-	 * Called when the block layer side of a hardware queue has been
-	 * set up, allowing the driver to allocate/init matching structures.
-	 * Ditto for exit/teardown.
-	 */
-	init_hctx_fn		*init_hctx;
-	exit_hctx_fn		*exit_hctx;
-
-	/*
-	 * Called for every command allocated by the block layer to allow
-	 * the driver to set up driver specific data.
-	 *
-	 * Tag greater than or equal to queue_depth is for setting up
-	 * flush request.
-	 *
-	 * Ditto for exit/teardown.
-	 */
-	init_request_fn		*init_request;
-	exit_request_fn		*exit_request;
-	/* Called from inside blk_get_request() */
-	void (*initialize_rq_fn)(struct request *rq);
-
-	/*
-	 * If set, returns whether or not this queue currently is busy
-	 */
-	busy_fn			*busy;
-
-	map_queues_fn		*map_queues;
-
-#ifdef CONFIG_BLK_DEBUG_FS
-	/*
-	 * Used by the debugfs implementation to show driver-specific
-	 * information about a request.
-	 */
-	void (*show_rq)(struct seq_file *m, struct request *rq);
-#endif
-};
-
 enum {
 	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
 	BLK_MQ_F_TAG_SHARED	= 1 << 1,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3712d1fe48d4..ad8474ec8c58 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -28,6 +28,8 @@
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
 
+#include <linux/blk-mq-ops.h>
+
 struct module;
 struct scsi_ioctl_command;
 
@@ -406,7 +408,7 @@ struct request_queue {
 	poll_q_fn		*poll_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
 
-	const struct blk_mq_ops	*mq_ops;
+	const struct blk_mq_ops	mq_ops;
 
 	/* sw queues */
 	struct blk_mq_ctx __percpu	*queue_ctx;
@@ -673,7 +675,7 @@ static inline bool blk_account_rq(struct request *rq)
 
 static inline bool queue_is_mq(struct request_queue *q)
 {
-	return q->mq_ops;
+	return q->mq_ops.queue_rq != NULL;
 }
 
 /*
-- 
2.17.1
