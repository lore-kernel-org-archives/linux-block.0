Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/29] block: kill legacy parts of timeout handling
Date: Mon, 29 Oct 2018 10:34:38 -0600
Message-Id: <20181029163444.9940-24-axboe@kernel.dk>
In-Reply-To: <20181029163444.9940-1-axboe@kernel.dk>
References: <20181029163444.9940-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

The only user of legacy timing now is BSG, which is invoked
from the mq timeout handler. Kill the legacy code, and rename
the q->rq_timed_out_fn to q->bsg_job_timeout_fn.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |  1 -
 block/blk-settings.c   |  7 ---
 block/blk-timeout.c    | 99 +++---------------------------------------
 block/blk.h            |  1 -
 block/bsg-lib.c        |  6 +--
 include/linux/blkdev.h |  4 +-
 6 files changed, 11 insertions(+), 107 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index bffc80052948..fcdb631f0a7a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -653,7 +653,6 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 		    laptop_mode_timer_fn, 0);
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, NULL);
-	INIT_LIST_HEAD(&q->timeout_list);
 	INIT_LIST_HEAD(&q->icq_list);
 #ifdef CONFIG_BLK_CGROUP
 	INIT_LIST_HEAD(&q->blkg_list);
diff --git a/block/blk-settings.c b/block/blk-settings.c
index f284e1600e29..1895f499bbe5 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -32,13 +32,6 @@ void blk_queue_rq_timeout(struct request_queue *q, unsigned int timeout)
 }
 EXPORT_SYMBOL_GPL(blk_queue_rq_timeout);
 
-void blk_queue_rq_timed_out(struct request_queue *q, rq_timed_out_fn *fn)
-{
-	WARN_ON_ONCE(q->mq_ops);
-	q->rq_timed_out_fn = fn;
-}
-EXPORT_SYMBOL_GPL(blk_queue_rq_timed_out);
-
 /**
  * blk_set_default_limits - reset limits to default values
  * @lim:  the queue_limits structure to reset
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index f2cfd56e1606..6428d458072a 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -78,70 +78,6 @@ void blk_delete_timer(struct request *req)
 	list_del_init(&req->timeout_list);
 }
 
-static void blk_rq_timed_out(struct request *req)
-{
-	struct request_queue *q = req->q;
-	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
-
-	if (q->rq_timed_out_fn)
-		ret = q->rq_timed_out_fn(req);
-	switch (ret) {
-	case BLK_EH_RESET_TIMER:
-		blk_add_timer(req);
-		blk_clear_rq_complete(req);
-		break;
-	case BLK_EH_DONE:
-		/*
-		 * LLD handles this for now but in the future
-		 * we can send a request msg to abort the command
-		 * and we can move more of the generic scsi eh code to
-		 * the blk layer.
-		 */
-		break;
-	default:
-		printk(KERN_ERR "block: bad eh return: %d\n", ret);
-		break;
-	}
-}
-
-static void blk_rq_check_expired(struct request *rq, unsigned long *next_timeout,
-			  unsigned int *next_set)
-{
-	const unsigned long deadline = blk_rq_deadline(rq);
-
-	if (time_after_eq(jiffies, deadline)) {
-		list_del_init(&rq->timeout_list);
-
-		/*
-		 * Check if we raced with end io completion
-		 */
-		if (!blk_mark_rq_complete(rq))
-			blk_rq_timed_out(rq);
-	} else if (!*next_set || time_after(*next_timeout, deadline)) {
-		*next_timeout = deadline;
-		*next_set = 1;
-	}
-}
-
-void blk_timeout_work(struct work_struct *work)
-{
-	struct request_queue *q =
-		container_of(work, struct request_queue, timeout_work);
-	unsigned long flags, next = 0;
-	struct request *rq, *tmp;
-	int next_set = 0;
-
-	spin_lock_irqsave(q->queue_lock, flags);
-
-	list_for_each_entry_safe(rq, tmp, &q->timeout_list, timeout_list)
-		blk_rq_check_expired(rq, &next, &next_set);
-
-	if (next_set)
-		mod_timer(&q->timeout, round_jiffies_up(next));
-
-	spin_unlock_irqrestore(q->queue_lock, flags);
-}
-
 /**
  * blk_abort_request -- Request request recovery for the specified command
  * @req:	pointer to the request of interest
@@ -153,20 +89,13 @@ void blk_timeout_work(struct work_struct *work)
  */
 void blk_abort_request(struct request *req)
 {
-	if (req->q->mq_ops) {
-		/*
-		 * All we need to ensure is that timeout scan takes place
-		 * immediately and that scan sees the new timeout value.
-		 * No need for fancy synchronizations.
-		 */
-		blk_rq_set_deadline(req, jiffies);
-		kblockd_schedule_work(&req->q->timeout_work);
-	} else {
-		if (blk_mark_rq_complete(req))
-			return;
-		blk_delete_timer(req);
-		blk_rq_timed_out(req);
-	}
+	/*
+	 * All we need to ensure is that timeout scan takes place
+	 * immediately and that scan sees the new timeout value.
+	 * No need for fancy synchronizations.
+	 */
+	blk_rq_set_deadline(req, jiffies);
+	kblockd_schedule_work(&req->q->timeout_work);
 }
 EXPORT_SYMBOL_GPL(blk_abort_request);
 
@@ -194,13 +123,6 @@ void blk_add_timer(struct request *req)
 	struct request_queue *q = req->q;
 	unsigned long expiry;
 
-	if (!q->mq_ops)
-		lockdep_assert_held(q->queue_lock);
-
-	/* blk-mq has its own handler, so we don't need ->rq_timed_out_fn */
-	if (!q->mq_ops && !q->rq_timed_out_fn)
-		return;
-
 	BUG_ON(!list_empty(&req->timeout_list));
 
 	/*
@@ -213,13 +135,6 @@ void blk_add_timer(struct request *req)
 	req->rq_flags &= ~RQF_TIMED_OUT;
 	blk_rq_set_deadline(req, jiffies + req->timeout);
 
-	/*
-	 * Only the non-mq case needs to add the request to a protected list.
-	 * For the mq case we simply scan the tag map.
-	 */
-	if (!q->mq_ops)
-		list_add_tail(&req->timeout_list, &req->q->timeout_list);
-
 	/*
 	 * If the timer isn't already pending or this timeout is earlier
 	 * than an existing one, modify the timer. Round up to next nearest
diff --git a/block/blk.h b/block/blk.h
index e2604ae7ddfa..4ae6cacb4548 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -224,7 +224,6 @@ static inline bool bio_integrity_endio(struct bio *bio)
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-void blk_timeout_work(struct work_struct *work);
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 void blk_delete_timer(struct request *);
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index faf20f4500c9..f38c7bc272c0 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -307,8 +307,8 @@ static enum blk_eh_timer_return bsg_timeout(struct request *rq, bool reserved)
 	enum blk_eh_timer_return ret = BLK_EH_DONE;
 	struct request_queue *q = rq->q;
 
-	if (q->rq_timed_out_fn)
-		ret = q->rq_timed_out_fn(rq);
+	if (q->bsg_job_timeout_fn)
+		ret = q->bsg_job_timeout_fn(rq);
 
 	return ret;
 }
@@ -357,9 +357,9 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 
 	q->queuedata = dev;
 	q->bsg_job_fn = job_fn;
+	q->bsg_job_timeout_fn = timeout;
 	blk_queue_flag_set(QUEUE_FLAG_BIDI, q);
 	blk_queue_rq_timeout(q, BLK_DEFAULT_SG_TIMEOUT);
-	q->rq_timed_out_fn = timeout;
 
 	ret = bsg_register_queue(q, dev, name, &bsg_transport_ops);
 	if (ret) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c502a7f40e84..0364fc53f5c8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -441,7 +441,6 @@ struct request_queue {
 	make_request_fn		*make_request_fn;
 	poll_q_fn		*poll_fn;
 	softirq_done_fn		*softirq_done_fn;
-	rq_timed_out_fn		*rq_timed_out_fn;
 	dma_drain_needed_fn	*dma_drain_needed;
 	/* Called just after a request is allocated */
 	init_rq_fn		*init_rq_fn;
@@ -541,7 +540,6 @@ struct request_queue {
 
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
-	struct list_head	timeout_list;
 
 	struct list_head	icq_list;
 #ifdef CONFIG_BLK_CGROUP
@@ -601,6 +599,7 @@ struct request_queue {
 
 #if defined(CONFIG_BLK_DEV_BSG)
 	bsg_job_fn		*bsg_job_fn;
+	rq_timed_out_fn		*bsg_job_timeout_fn;
 	struct bsg_class_device bsg_dev;
 #endif
 
@@ -1156,7 +1155,6 @@ extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
 extern void blk_queue_softirq_done(struct request_queue *, softirq_done_fn *);
-extern void blk_queue_rq_timed_out(struct request_queue *, rq_timed_out_fn *);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_flush_queueable(struct request_queue *q, bool queueable);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
-- 
2.17.1
