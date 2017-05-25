Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941653AbdEYEWI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 00:22:08 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 6/7] blk-mq: quiesce queue via percpu_ref
Date: Thu, 25 May 2017 12:21:30 +0800
Message-Id: <20170525042131.13172-7-ming.lei@redhat.com>
In-Reply-To: <20170525042131.13172-1-ming.lei@redhat.com>
References: <20170525042131.13172-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

One big problem of blk_mq_quiesce_queue() is that it
can't prevent .queue_rq() in direct issue path from
being run even though hw queues are stopped.

It is observed that request double-free/use-after-free
can be triggered easily when canceling NVMe requests via
blk_mq_tagset_busy_iter(...nvme_cancel_request) in nvme_dev_disable().
The reason is that blk_mq_quiesce_queue() doesn't prevent
dispatch from being run.

Actually other drivers(mtip32xx, nbd) need to quiesce
queue first before canceling dispatched requests via
blk_mq_tagset_busy_iter(), otherwise use-after-free
can be caused.

This patch implements queue quiescing via percpu_ref,
and fixes the above issue, also has the following benefits:

- rcu & srcu are used for non-blocking and blocking respectively,
code becomes much clean after we unify both via percpu_ref

- the fat 'srcu_struct' can be removed from 'blk_mq_hw_ctx'

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 112 +++++++++++++++++++++++++++++++------------------
 include/linux/blk-mq.h |   2 -
 include/linux/blkdev.h |   5 +++
 3 files changed, 77 insertions(+), 42 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26fee3fb389..6316efb42e04 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -164,20 +164,23 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
  */
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
-	struct blk_mq_hw_ctx *hctx;
-	unsigned int i;
-	bool rcu = false;
+	bool old;
 
 	__blk_mq_stop_hw_queues(q, true);
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (hctx->flags & BLK_MQ_F_BLOCKING)
-			synchronize_srcu(&hctx->queue_rq_srcu);
-		else
-			rcu = true;
-	}
-	if (rcu)
-		synchronize_rcu();
+	mutex_lock(&q->quiesce_mutex);
+
+	spin_lock_irq(q->queue_lock);
+	old = queue_flag_test_and_set(QUEUE_FLAG_QUIESCED, q);
+	spin_unlock_irq(q->queue_lock);
+
+	if (old)
+		goto exit;
+
+	percpu_ref_kill(&q->q_dispatch_counter);
+	wait_event(q->quiesce_wq, percpu_ref_is_zero(&q->q_dispatch_counter));
+ exit:
+	mutex_unlock(&q->quiesce_mutex);
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
@@ -190,6 +193,21 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
  */
 void blk_mq_unquiesce_queue(struct request_queue *q)
 {
+	bool old;
+
+	mutex_lock(&q->quiesce_mutex);
+
+	spin_lock_irq(q->queue_lock);
+	old = queue_flag_test_and_clear(QUEUE_FLAG_QUIESCED, q);
+	spin_unlock_irq(q->queue_lock);
+
+	if (!old)
+		goto exit;
+
+	percpu_ref_reinit(&q->q_dispatch_counter);
+ exit:
+	mutex_unlock(&q->quiesce_mutex);
+
 	blk_mq_start_stopped_hw_queues(q, true);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
@@ -209,6 +227,9 @@ void blk_mq_wake_waiters(struct request_queue *q)
 	 * the queue are notified as well.
 	 */
 	wake_up_all(&q->mq_freeze_wq);
+
+	/* Forcibly unquiesce the queue to avoid having stuck requests */
+	blk_mq_unquiesce_queue(q);
 }
 
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
@@ -1099,24 +1120,28 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 	return (queued + errors) != 0;
 }
 
-static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
+static inline bool blk_mq_dispatch_start(struct request_queue *q)
+{
+	return percpu_ref_tryget_live(&q->q_dispatch_counter);
+}
+
+static inline void blk_mq_dispatch_end(struct request_queue *q)
 {
-	int srcu_idx;
+	percpu_ref_put(&q->q_dispatch_counter);
+}
 
+static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
+{
 	WARN_ON(!cpumask_test_cpu(raw_smp_processor_id(), hctx->cpumask) &&
 		cpu_online(hctx->next_cpu));
 
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		rcu_read_lock();
-		blk_mq_sched_dispatch_requests(hctx);
-		rcu_read_unlock();
-	} else {
-		might_sleep();
+	if (!blk_mq_dispatch_start(hctx->queue))
+		return;
 
-		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
-		blk_mq_sched_dispatch_requests(hctx);
-		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
-	}
+	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
+	blk_mq_sched_dispatch_requests(hctx);
+
+	blk_mq_dispatch_end(hctx->queue);
 }
 
 /*
@@ -1519,18 +1544,14 @@ static void __blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq, blk_qc_t *cookie)
 {
-	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
-		rcu_read_lock();
-		__blk_mq_try_issue_directly(rq, cookie, false);
-		rcu_read_unlock();
-	} else {
-		unsigned int srcu_idx;
-
-		might_sleep();
+	bool blocking = hctx->flags & BLK_MQ_F_BLOCKING;
 
-		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
-		__blk_mq_try_issue_directly(rq, cookie, true);
-		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
+	if (blk_mq_dispatch_start(hctx->queue)) {
+		might_sleep_if(blocking);
+		__blk_mq_try_issue_directly(rq, cookie, blocking);
+		blk_mq_dispatch_end(hctx->queue);
+	} else {
+		blk_mq_sched_insert_request(rq, false, false, false, blocking);
 	}
 }
 
@@ -1869,9 +1890,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		cleanup_srcu_struct(&hctx->queue_rq_srcu);
-
 	blk_mq_remove_cpuhp(hctx);
 	blk_free_flush_queue(hctx->fq);
 	sbitmap_free(&hctx->ctx_map);
@@ -1942,9 +1960,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 				   node))
 		goto free_fq;
 
-	if (hctx->flags & BLK_MQ_F_BLOCKING)
-		init_srcu_struct(&hctx->queue_rq_srcu);
-
 	blk_mq_debugfs_register_hctx(q, hctx);
 
 	return 0;
@@ -2272,12 +2287,27 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	blk_mq_sysfs_register(q);
 }
 
+static void blk_queue_dispatch_counter_release(struct percpu_ref *ref)
+{
+	struct request_queue *q =
+		container_of(ref, struct request_queue, q_dispatch_counter);
+
+	wake_up_all(&q->quiesce_wq);
+}
+
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
+	init_waitqueue_head(&q->quiesce_wq);
+	mutex_init(&q->quiesce_mutex);
+	if (percpu_ref_init(&q->q_dispatch_counter,
+			    blk_queue_dispatch_counter_release,
+			    0, GFP_KERNEL))
+		goto err_ref;
+
 	q->poll_cb = blk_stat_alloc_callback(blk_mq_poll_stats_fn,
 					     blk_mq_poll_stats_bkt,
 					     BLK_MQ_POLL_STATS_BKTS, q);
@@ -2360,6 +2390,8 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 err_percpu:
 	free_percpu(q->queue_ctx);
 err_exit:
+	percpu_ref_exit(&q->q_dispatch_counter);
+err_ref:
 	q->mq_ops = NULL;
 	return ERR_PTR(-ENOMEM);
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index fcd641032f8d..6da015e6d38a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -39,8 +39,6 @@ struct blk_mq_hw_ctx {
 	struct blk_mq_tags	*tags;
 	struct blk_mq_tags	*sched_tags;
 
-	struct srcu_struct	queue_rq_srcu;
-
 	unsigned long		queued;
 	unsigned long		run;
 #define BLK_MQ_MAX_DISPATCH_ORDER	7
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 60967797f4f6..a85841e9113d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -586,6 +586,11 @@ struct request_queue {
 
 	size_t			cmd_size;
 	void			*rq_alloc_data;
+
+	/* for blk_mq_quiesce_queue() */
+	wait_queue_head_t	quiesce_wq;
+	struct percpu_ref	q_dispatch_counter;
+	struct mutex		quiesce_mutex;
 };
 
 #define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
-- 
2.9.4
