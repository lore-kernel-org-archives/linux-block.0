Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo Valente <paolo.valente@linaro.org>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	linus.walleij@linaro.org,
	broonie@kernel.org,
	Paolo Valente <paolo.valente@linaro.org>
Subject: [WIP PATCHSET 4/4] Modify interface and operation to comply with blk-mq-sched
Date: Tue,  7 Feb 2017 18:24:46 +0100
Message-Id: <20170207172446.4528-5-paolo.valente@linaro.org>
In-Reply-To: <20170207172446.4528-1-paolo.valente@linaro.org>
References: <20170207172446.4528-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

As for modifications of the operation, the major changes are the introduction
of a scheduler lock, and the moving to deferred work of the body of the hook
exit_icq. The latter change has been made to avoid deadlocks caused by the
combination of the following facts: 1) such a body  takes the scheduler lock,
and, if not deferred, 2) it does so from inside the exit_icq hook, which is
invoked with the queue lock held, and 3) there is at least one code path,
namely that starting from bfq_bio_merge, which takes these locks in the
opposite order.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c     |   4 -
 block/bfq-mq-iosched.c | 791 ++++++++++++++++++++++++++++++-------------------
 block/bfq-mq.h         |  37 +--
 3 files changed, 496 insertions(+), 336 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 36b68ec..7ecce47 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -472,8 +472,6 @@ static struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 	struct bfq_group *bfqg, *parent;
 	struct bfq_entity *entity;
 
-	assert_spin_locked(bfqd->queue->queue_lock);
-
 	bfqg = bfq_lookup_bfqg(bfqd, blkcg);
 
 	if (unlikely(!bfqg))
@@ -602,8 +600,6 @@ static struct bfq_group *__bfq_bic_change_cgroup(struct bfq_data *bfqd,
 	struct bfq_group *bfqg;
 	struct bfq_entity *entity;
 
-	lockdep_assert_held(bfqd->queue->queue_lock);
-
 	bfqg = bfq_find_set_group(bfqd, blkcg);
 
 	if (unlikely(!bfqg))
diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
index a8679de..05a12b6 100644
--- a/block/bfq-mq-iosched.c
+++ b/block/bfq-mq-iosched.c
@@ -76,9 +76,14 @@
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/ioprio.h>
-#undef CONFIG_BFQ_GROUP_IOSCHED /* cgroups support not yet functional */
-#include "bfq.h"
+#include <linux/sbitmap.h>
+#include <linux/delay.h>
+
 #include "blk.h"
+#include "blk-mq.h"
+#include "blk-mq-tag.h"
+#include "blk-mq-sched.h"
+#include "bfq-mq.h"
 
 /* Expiration time of sync (0) and async (1) requests, in ns. */
 static const u64 bfq_fifo_expire[2] = { NSEC_PER_SEC / 4, NSEC_PER_SEC / 8 };
@@ -188,8 +193,6 @@ static int device_speed_thresh[2];
 #define RQ_BIC(rq)		((struct bfq_io_cq *) (rq)->elv.priv[0])
 #define RQ_BFQQ(rq)		((rq)->elv.priv[1])
 
-static void bfq_schedule_dispatch(struct bfq_data *bfqd);
-
 /**
  * icq_to_bic - convert iocontext queue structure to bfq_io_cq.
  * @icq: the iocontext queue.
@@ -211,11 +214,12 @@ static struct bfq_io_cq *bfq_bic_lookup(struct bfq_data *bfqd,
 					struct request_queue *q)
 {
 	if (ioc) {
+		unsigned long flags;
 		struct bfq_io_cq *icq;
 
-		spin_lock_irq(q->queue_lock);
+		spin_lock_irqsave(q->queue_lock, flags);
 		icq = icq_to_bic(ioc_lookup_icq(ioc, q));
-		spin_unlock_irq(q->queue_lock);
+		spin_unlock_irqrestore(q->queue_lock, flags);
 
 		return icq;
 	}
@@ -239,7 +243,7 @@ static void bfq_schedule_dispatch(struct bfq_data *bfqd)
 {
 	if (bfqd->queued != 0) {
 		bfq_log(bfqd, "schedule dispatch");
-		kblockd_schedule_work(&bfqd->unplug_work);
+		blk_mq_run_hw_queues(bfqd->queue, true);
 	}
 }
 
@@ -728,9 +732,9 @@ static int bfqq_process_refs(struct bfq_queue *bfqq)
 {
 	int process_refs, io_refs;
 
-	lockdep_assert_held(bfqq->bfqd->queue->queue_lock);
+	lockdep_assert_held(&bfqq->bfqd->lock);
 
-	io_refs = bfqq->allocated[READ] + bfqq->allocated[WRITE];
+	io_refs = bfqq->allocated;
 	process_refs = bfqq->ref - io_refs - bfqq->entity.on_st;
 	BUG_ON(process_refs < 0);
 	return process_refs;
@@ -1441,6 +1445,8 @@ static void bfq_add_request(struct request *rq)
 	bfqq->queued[rq_is_sync(rq)]++;
 	bfqd->queued++;
 
+	BUG_ON(!RQ_BFQQ(rq));
+	BUG_ON(RQ_BFQQ(rq) != bfqq);
 	elv_rb_add(&bfqq->sort_list, rq);
 
 	/*
@@ -1449,6 +1455,8 @@ static void bfq_add_request(struct request *rq)
 	prev = bfqq->next_rq;
 	next_rq = bfq_choose_req(bfqd, bfqq->next_rq, rq, bfqd->last_position);
 	BUG_ON(!next_rq);
+	BUG_ON(!RQ_BFQQ(next_rq));
+	BUG_ON(RQ_BFQQ(next_rq) != bfqq);
 	bfqq->next_rq = next_rq;
 
 	/*
@@ -1544,6 +1552,7 @@ static sector_t get_sdist(sector_t last_pos, struct request *rq)
 	return sdist;
 }
 
+#if 0 /* Still not clear if we can do without next two functions */
 static void bfq_activate_request(struct request_queue *q, struct request *rq)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
@@ -1557,8 +1566,10 @@ static void bfq_deactivate_request(struct request_queue *q, struct request *rq)
 	BUG_ON(bfqd->rq_in_driver == 0);
 	bfqd->rq_in_driver--;
 }
+#endif
 
-static void bfq_remove_request(struct request *rq)
+static void bfq_remove_request(struct request_queue *q,
+			       struct request *rq)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd = bfqq->bfqd;
@@ -1569,6 +1580,19 @@ static void bfq_remove_request(struct request *rq)
 
 	if (bfqq->next_rq == rq) {
 		bfqq->next_rq = bfq_find_next_rq(bfqd, bfqq, rq);
+		if (bfqq->next_rq && !RQ_BFQQ(bfqq->next_rq)) {
+			pr_crit("no bfqq! for next rq %p bfqq %p\n",
+				bfqq->next_rq, bfqq);
+		}
+
+		BUG_ON(bfqq->next_rq && !RQ_BFQQ(bfqq->next_rq));
+		if (bfqq->next_rq && RQ_BFQQ(bfqq->next_rq) != bfqq) {
+			pr_crit(
+			"wrong bfqq! for next rq %p, rq_bfqq %p bfqq %p\n",
+			bfqq->next_rq, RQ_BFQQ(bfqq->next_rq), bfqq);
+		}
+		BUG_ON(bfqq->next_rq && RQ_BFQQ(bfqq->next_rq) != bfqq);
+
 		bfq_updated_next_req(bfqd, bfqq);
 	}
 
@@ -1579,6 +1603,10 @@ static void bfq_remove_request(struct request *rq)
 	bfqd->queued--;
 	elv_rb_del(&bfqq->sort_list, rq);
 
+	elv_rqhash_del(q, rq);
+	if (q->last_merge == rq)
+		q->last_merge = NULL;
+
 	if (RB_EMPTY_ROOT(&bfqq->sort_list)) {
 		bfqq->next_rq = NULL;
 
@@ -1616,22 +1644,47 @@ static void bfq_remove_request(struct request *rq)
 	bfqg_stats_update_io_remove(bfqq_group(bfqq), rq->cmd_flags);
 }
 
-static int bfq_merge(struct request_queue *q, struct request **req,
-		     struct bio *bio)
+static bool bfq_bio_merge(struct blk_mq_hw_ctx *hctx, struct bio *bio)
+{
+	struct request_queue *q = hctx->queue;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
+	struct request *free = NULL;
+	bool ret;
+
+	spin_lock_irq(&bfqd->lock);
+	ret = blk_mq_sched_try_merge(q, bio, &free);
+
+	/*
+	 * XXX Not yet freeing without lock held, to avoid an
+	 * inconsistency with respect to the lock-protected invocation
+	 * of blk_mq_sched_try_insert_merge in bfq_bio_merge. Waiting
+	 * for clarifications from Jens.
+	 */
+	if (free)
+		blk_mq_free_request(free);
+	spin_unlock_irq(&bfqd->lock);
+
+	return ret;
+}
+
+static int bfq_request_merge(struct request_queue *q, struct request **req,
+			     struct bio *bio)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct request *__rq;
 
-	__rq = bfq_find_rq_fmerge(bfqd, bio);
+	__rq = bfq_find_rq_fmerge(bfqd, bio, q);
 	if (__rq && elv_bio_merge_ok(__rq, bio)) {
 		*req = __rq;
+		bfq_log(bfqd, "request_merge: req %p", __rq);
+
 		return ELEVATOR_FRONT_MERGE;
 	}
 
 	return ELEVATOR_NO_MERGE;
 }
 
-static void bfq_merged_request(struct request_queue *q, struct request *req,
+static void bfq_request_merged(struct request_queue *q, struct request *req,
 			       int type)
 {
 	if (type == ELEVATOR_FRONT_MERGE &&
@@ -1645,13 +1698,23 @@ static void bfq_merged_request(struct request_queue *q, struct request *req,
 
 		/* Reposition request in its sort_list */
 		elv_rb_del(&bfqq->sort_list, req);
+		BUG_ON(!RQ_BFQQ(req));
+		BUG_ON(RQ_BFQQ(req) != bfqq);
 		elv_rb_add(&bfqq->sort_list, req);
+
+		spin_lock_irq(&bfqd->lock);
 		/* Choose next request to be served for bfqq */
 		prev = bfqq->next_rq;
 		next_rq = bfq_choose_req(bfqd, bfqq->next_rq, req,
 					 bfqd->last_position);
 		BUG_ON(!next_rq);
+
 		bfqq->next_rq = next_rq;
+
+		bfq_log_bfqq(bfqd, bfqq,
+			"requests_merged: req %p prev %p next_rq %p bfqq %p",
+			     req, prev, next_rq, bfqq);
+
 		/*
 		 * If next_rq changes, update both the queue's budget to
 		 * fit the new request and the queue's position in its
@@ -1661,22 +1724,27 @@ static void bfq_merged_request(struct request_queue *q, struct request *req,
 			bfq_updated_next_req(bfqd, bfqq);
 			bfq_pos_tree_add_move(bfqd, bfqq);
 		}
+		spin_unlock_irq(&bfqd->lock);
 	}
 }
 
-#ifdef BFQ_GROUP_IOSCHED_ENABLED
-static void bfq_bio_merged(struct request_queue *q, struct request *req,
-			   struct bio *bio)
-{
-	bfqg_stats_update_io_merged(bfqq_group(RQ_BFQQ(req)), bio->bi_opf);
-}
-#endif
-
-static void bfq_merged_requests(struct request_queue *q, struct request *rq,
+static void bfq_requests_merged(struct request_queue *q, struct request *rq,
 				struct request *next)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq), *next_bfqq = RQ_BFQQ(next);
 
+	BUG_ON(!RQ_BFQQ(rq));
+	BUG_ON(!RQ_BFQQ(next));
+
+	if (!RB_EMPTY_NODE(&rq->rb_node))
+		goto end;
+
+	bfq_log_bfqq(bfqq->bfqd, bfqq,
+		     "requests_merged: rq %p next %p bfqq %p next_bfqq %p",
+		     rq, next, bfqq, next_bfqq);
+
+	spin_lock_irq(&bfqq->bfqd->lock);
+
 	/*
 	 * If next and rq belong to the same bfq_queue and next is older
 	 * than rq, then reposition rq in the fifo (by substituting next
@@ -1697,7 +1765,10 @@ static void bfq_merged_requests(struct request_queue *q, struct request *rq,
 	if (bfqq->next_rq == next)
 		bfqq->next_rq = rq;
 
-	bfq_remove_request(next);
+	bfq_remove_request(q, next);
+
+	spin_unlock_irq(&bfqq->bfqd->lock);
+end:
 	bfqg_stats_update_io_merged(bfqq_group(bfqq), next->cmd_flags);
 }
 
@@ -1741,7 +1812,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq;
 
-	spin_lock_irq(bfqd->queue->queue_lock);
+	spin_lock_irq(&bfqd->lock);
 
 	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list)
 		bfq_bfqq_end_wr(bfqq);
@@ -1749,7 +1820,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 		bfq_bfqq_end_wr(bfqq);
 	bfq_end_wr_async(bfqd);
 
-	spin_unlock_irq(bfqd->queue->queue_lock);
+	spin_unlock_irq(&bfqd->lock);
 }
 
 static sector_t bfq_io_struct_pos(void *io_struct, bool request)
@@ -2131,8 +2202,8 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 	bfq_put_queue(bfqq);
 }
 
-static int bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
-			       struct bio *bio)
+static bool bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
+				struct bio *bio)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	bool is_sync = op_is_sync(bio->bi_opf);
@@ -2150,7 +2221,7 @@ static int bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 	 * merge only if rq is queued there.
 	 * Queue lock is held here.
 	 */
-	bic = bfq_bic_lookup(bfqd, current->io_context);
+	bic = bfq_bic_lookup(bfqd, current->io_context, q);
 	if (!bic)
 		return false;
 
@@ -2175,12 +2246,6 @@ static int bfq_allow_bio_merge(struct request_queue *q, struct request *rq,
 	return bfqq == RQ_BFQQ(rq);
 }
 
-static int bfq_allow_rq_merge(struct request_queue *q, struct request *rq,
-			      struct request *next)
-{
-	return RQ_BFQQ(rq) == RQ_BFQQ(next);
-}
-
 /*
  * Set the maximum time for the in-service queue to consume its
  * budget. This prevents seeky processes from lowering the throughput.
@@ -2211,7 +2276,6 @@ static void __bfq_set_in_service_queue(struct bfq_data *bfqd,
 {
 	if (bfqq) {
 		bfqg_stats_update_avg_queue_size(bfqq_group(bfqq));
-		bfq_mark_bfqq_must_alloc(bfqq);
 		bfq_clear_bfqq_fifo_expire(bfqq);
 
 		bfqd->budgets_assigned = (bfqd->budgets_assigned*7 + 256) / 8;
@@ -2650,27 +2714,28 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 }
 
 /*
- * Move request from internal lists to the dispatch list of the request queue
+ * Remove request from internal lists.
  */
-static void bfq_dispatch_insert(struct request_queue *q, struct request *rq)
+static void bfq_dispatch_remove(struct request_queue *q, struct request *rq)
 {
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 
 	/*
-	 * For consistency, the next instruction should have been executed
-	 * after removing the request from the queue and dispatching it.
-	 * We execute instead this instruction before bfq_remove_request()
-	 * (and hence introduce a temporary inconsistency), for efficiency.
-	 * In fact, in a forced_dispatch, this prevents two counters related
-	 * to bfqq->dispatched to risk to be uselessly decremented if bfqq
-	 * is not in service, and then to be incremented again after
-	 * incrementing bfqq->dispatched.
+	 * For consistency, the next instruction should have been
+	 * executed after removing the request from the queue and
+	 * dispatching it.  We execute instead this instruction before
+	 * bfq_remove_request() (and hence introduce a temporary
+	 * inconsistency), for efficiency.  In fact, should this
+	 * dispatch occur for a non in-service bfqq, this anticipated
+	 * increment prevents two counters related to bfqq->dispatched
+	 * from risking to be, first, uselessly decremented, and then
+	 * incremented again when the (new) value of bfqq->dispatched
+	 * happens to be taken into account.
 	 */
 	bfqq->dispatched++;
 	bfq_update_peak_rate(q->elevator->elevator_data, rq);
 
-	bfq_remove_request(rq);
-	elv_dispatch_sort(q, rq);
+	bfq_remove_request(q, rq);
 }
 
 static void __bfq_bfqq_expire(struct bfq_data *bfqd, struct bfq_queue *bfqq)
@@ -3534,7 +3599,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	bfq_log_bfqq(bfqd, bfqq, "select_queue: already in-service queue");
 
 	if (bfq_may_expire_for_budg_timeout(bfqq) &&
-	    !hrtimer_active(&bfqd->idle_slice_timer) &&
+	    !bfq_bfqq_wait_request(bfqq) &&
 	    !bfq_bfqq_must_idle(bfqq))
 		goto expire;
 
@@ -3570,7 +3635,6 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			 * arrives.
 			 */
 			if (bfq_bfqq_wait_request(bfqq)) {
-				BUG_ON(!hrtimer_active(&bfqd->idle_slice_timer));
 				/*
 				 * If we get here: 1) at least a new request
 				 * has arrived but we have not disabled the
@@ -3597,7 +3661,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 	 * for a new request, or has requests waiting for a completion and
 	 * may idle after their completion, then keep it anyway.
 	 */
-	if (hrtimer_active(&bfqd->idle_slice_timer) ||
+	if (bfq_bfqq_wait_request(bfqq) ||
 	    (bfqq->dispatched != 0 && bfq_bfqq_may_idle(bfqq))) {
 		bfqq = NULL;
 		goto keep_queue;
@@ -3676,13 +3740,11 @@ static void bfq_update_wr_data(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 }
 
 /*
- * Dispatch one request from bfqq, moving it to the request queue
- * dispatch list.
+ * Dispatch next request from bfqq.
  */
-static int bfq_dispatch_request(struct bfq_data *bfqd,
-				struct bfq_queue *bfqq)
+static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
+						 struct bfq_queue *bfqq)
 {
-	int dispatched = 0;
 	struct request *rq = bfqq->next_rq;
 	unsigned long service_to_charge;
 
@@ -3698,7 +3760,7 @@ static int bfq_dispatch_request(struct bfq_data *bfqd,
 
 	BUG_ON(bfqq->entity.budget < bfqq->entity.service);
 
-	bfq_dispatch_insert(bfqd->queue, rq);
+	bfq_dispatch_remove(bfqd->queue, rq);
 
 	/*
 	 * If weight raising has to terminate for bfqq, then next
@@ -3714,86 +3776,66 @@ static int bfq_dispatch_request(struct bfq_data *bfqd,
 	bfq_update_wr_data(bfqd, bfqq);
 
 	bfq_log_bfqq(bfqd, bfqq,
-			"dispatched %u sec req (%llu), budg left %d",
+	     "dispatched %u sec req (%llu), budg left %d, new disp_nr %d",
 			blk_rq_sectors(rq),
 			(unsigned long long) blk_rq_pos(rq),
-			bfq_bfqq_budget_left(bfqq));
-
-	dispatched++;
+		     bfq_bfqq_budget_left(bfqq),
+		     bfqq->dispatched);
 
 	if (!bfqd->in_service_bic) {
 		atomic_long_inc(&RQ_BIC(rq)->icq.ioc->refcount);
 		bfqd->in_service_bic = RQ_BIC(rq);
 	}
 
+	/*
+	 * Expire bfqq, pretending that its budget expired, if bfqq
+	 * belongs to CLASS_IDLE and other queues are waiting for
+	 * service.
+	 */
 	if (bfqd->busy_queues > 1 && bfq_class_idle(bfqq))
 		goto expire;
 
-	return dispatched;
+	return rq;
 
 expire:
 	bfq_bfqq_expire(bfqd, bfqq, false, BFQ_BFQQ_BUDGET_EXHAUSTED);
-	return dispatched;
-}
-
-static int __bfq_forced_dispatch_bfqq(struct bfq_queue *bfqq)
-{
-	int dispatched = 0;
-
-	while (bfqq->next_rq) {
-		bfq_dispatch_insert(bfqq->bfqd->queue, bfqq->next_rq);
-		dispatched++;
-	}
-
-	BUG_ON(!list_empty(&bfqq->fifo));
-	return dispatched;
+	return rq;
 }
 
-/*
- * Drain our current requests.
- * Used for barriers and when switching io schedulers on-the-fly.
- */
-static int bfq_forced_dispatch(struct bfq_data *bfqd)
+static bool bfq_has_work(struct blk_mq_hw_ctx *hctx)
 {
-	struct bfq_queue *bfqq, *n;
-	struct bfq_service_tree *st;
-	int dispatched = 0;
+	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
 
-	bfqq = bfqd->in_service_queue;
-	if (bfqq)
-		__bfq_bfqq_expire(bfqd, bfqq);
+	bfq_log(bfqd, "has_work, dispatch_non_empty %d busy_queues %d",
+		!list_empty_careful(&bfqd->dispatch), bfqd->busy_queues > 0);
 
 	/*
-	 * Loop through classes, and be careful to leave the scheduler
-	 * in a consistent state, as feedback mechanisms and vtime
-	 * updates cannot be disabled during the process.
+	 * Avoiding lock: a race on bfqd->busy_queues should cause at
+	 * most a call to dispatch for nothing
 	 */
-	list_for_each_entry_safe(bfqq, n, &bfqd->active_list, bfqq_list) {
-		st = bfq_entity_service_tree(&bfqq->entity);
-
-		dispatched += __bfq_forced_dispatch_bfqq(bfqq);
-
-		bfqq->max_budget = bfq_max_budget(bfqd);
-		bfq_forget_idle(st);
-	}
-
-	BUG_ON(bfqd->busy_queues != 0);
-
-	return dispatched;
+	return !list_empty_careful(&bfqd->dispatch) ||
+		bfqd->busy_queues > 0;
 }
 
-static int bfq_dispatch_requests(struct request_queue *q, int force)
+static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 {
-	struct bfq_data *bfqd = q->elevator->elevator_data;
-	struct bfq_queue *bfqq;
+	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
+	struct request *rq = NULL;
+	struct bfq_queue *bfqq = NULL;
+
+	if (!list_empty(&bfqd->dispatch)) {
+		rq = list_first_entry(&bfqd->dispatch, struct request,
+				      queuelist);
+		list_del_init(&rq->queuelist);
+		bfq_log(bfqd,
+			"dispatch requests: picked %p from dispatch list", rq);
+		goto exit;
+	}
 
 	bfq_log(bfqd, "dispatch requests: %d busy queues", bfqd->busy_queues);
 
 	if (bfqd->busy_queues == 0)
-		return 0;
-
-	if (unlikely(force))
-		return bfq_forced_dispatch(bfqd);
+		goto exit;
 
 	/*
 	 * Force device to serve one request at a time if
@@ -3808,25 +3850,53 @@ static int bfq_dispatch_requests(struct request_queue *q, int force)
 	 * throughput.
 	 */
 	if (bfqd->strict_guarantees && bfqd->rq_in_driver > 0)
-		return 0;
+		goto exit;
 
 	bfqq = bfq_select_queue(bfqd);
 	if (!bfqq)
-		return 0;
+		goto exit;
 
 	BUG_ON(bfqq->entity.budget < bfqq->entity.service);
 
 	BUG_ON(bfq_bfqq_wait_request(bfqq));
 
-	if (!bfq_dispatch_request(bfqd, bfqq))
-		return 0;
-
-	bfq_log_bfqq(bfqd, bfqq, "dispatched %s request",
-			bfq_bfqq_sync(bfqq) ? "sync" : "async");
+	rq = bfq_dispatch_rq_from_bfqq(bfqd, bfqq);
 
 	BUG_ON(bfqq->next_rq == NULL &&
 	       bfqq->entity.budget < bfqq->entity.service);
-	return 1;
+exit:
+	if (rq) {
+		rq->rq_flags |= RQF_STARTED;
+		bfqd->rq_in_driver++;
+		if (bfqq)
+			bfq_log_bfqq(bfqd, bfqq,
+				"dispatched %s request %p, rq_in_driver %d",
+				     bfq_bfqq_sync(bfqq) ? "sync" : "async",
+				     rq,
+				     bfqd->rq_in_driver);
+		else
+			bfq_log(bfqd,
+		"dispatched request %p from dispatch list, rq_in_driver %d",
+				rq, bfqd->rq_in_driver);
+	} else
+		bfq_log(bfqd,
+		"returned NULL request, rq_in_driver %d",
+			bfqd->rq_in_driver);
+
+	return rq;
+}
+
+
+static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
+{
+	struct bfq_data *bfqd = hctx->queue->elevator->elevator_data;
+	struct request *rq;
+
+	spin_lock_irq(&bfqd->lock);
+	rq = __bfq_dispatch_request(hctx);
+	spin_unlock_irq(&bfqd->lock);
+
+	return rq;
 }
 
 /*
@@ -3843,13 +3913,15 @@ static void bfq_put_queue(struct bfq_queue *bfqq)
 
 	BUG_ON(bfqq->ref <= 0);
 
-	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq, bfqq->ref);
+	if (bfqq->bfqd)
+		bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d", bfqq, bfqq->ref);
+
 	bfqq->ref--;
 	if (bfqq->ref)
 		return;
 
 	BUG_ON(rb_first(&bfqq->sort_list));
-	BUG_ON(bfqq->allocated[READ] + bfqq->allocated[WRITE] != 0);
+	BUG_ON(bfqq->allocated != 0);
 	BUG_ON(bfqq->entity.tree);
 	BUG_ON(bfq_bfqq_busy(bfqq));
 
@@ -3864,7 +3936,8 @@ static void bfq_put_queue(struct bfq_queue *bfqq)
 		 */
 		hlist_del_init(&bfqq->burst_list_node);
 
-	bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p freed", bfqq);
+	if (bfqq->bfqd)
+		bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p freed", bfqq);
 
 	kmem_cache_free(bfq_pool, bfqq);
 #ifdef BFQ_GROUP_IOSCHED_ENABLED
@@ -3905,29 +3978,53 @@ static void bfq_exit_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 	bfq_put_queue(bfqq);
 }
 
-static void bfq_exit_icq(struct io_cq *icq)
+static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
 {
-	struct bfq_io_cq *bic = icq_to_bic(icq);
-	struct bfq_data *bfqd = bic_to_bfqd(bic);
+	struct bfq_queue *bfqq = bic_to_bfqq(bic, is_sync);
+	struct bfq_data *bfqd;
 
-	if (bic_to_bfqq(bic, false)) {
-		bfq_exit_bfqq(bfqd, bic_to_bfqq(bic, false));
-		bic_set_bfqq(bic, NULL, false);
-	}
+	if (bfqq)
+		bfqd = bfqq->bfqd; /* NULL if scheduler already exited */
 
-	if (bic_to_bfqq(bic, true)) {
+	if (bfqq && bfqd) {
+		spin_lock_irq(&bfqd->lock);
 		/*
 		 * If the bic is using a shared queue, put the reference
 		 * taken on the io_context when the bic started using a
 		 * shared bfq_queue.
 		 */
-		if (bfq_bfqq_coop(bic_to_bfqq(bic, true)))
-			put_io_context(icq->ioc);
-		bfq_exit_bfqq(bfqd, bic_to_bfqq(bic, true));
-		bic_set_bfqq(bic, NULL, true);
+		if (is_sync && bfq_bfqq_coop(bfqq))
+			put_io_context(bic->icq.ioc);
+		bfq_exit_bfqq(bfqd, bfqq);
+		bic_set_bfqq(bic, NULL, is_sync);
+		spin_unlock_irq(&bfqd->lock);
 	}
 }
 
+static void bfq_exit_icq_body(struct work_struct *work)
+{
+	struct bfq_io_cq *bic =
+		container_of(work, struct bfq_io_cq, exit_icq_work);
+
+	bfq_exit_icq_bfqq(bic, true);
+	bfq_exit_icq_bfqq(bic, false);
+}
+
+static void bfq_init_icq(struct io_cq *icq)
+{
+	struct bfq_io_cq *bic = icq_to_bic(icq);
+
+	INIT_WORK(&bic->exit_icq_work, bfq_exit_icq_body);
+}
+
+static void bfq_exit_icq(struct io_cq *icq)
+{
+	struct bfq_io_cq *bic = icq_to_bic(icq);
+
+	BUG_ON(!bic);
+	kblockd_schedule_work(&bic->exit_icq_work);
+}
+
 /*
  * Update the entity prio values; note that the new values will not
  * be used until the next (re)activation.
@@ -3937,6 +4034,11 @@ static void bfq_set_next_ioprio_data(struct bfq_queue *bfqq,
 {
 	struct task_struct *tsk = current;
 	int ioprio_class;
+	struct bfq_data *bfqd = bfqq->bfqd;
+
+	WARN_ON(!bfqd);
+	if (!bfqd)
+		return;
 
 	ioprio_class = IOPRIO_PRIO_CLASS(bic->ioprio);
 	switch (ioprio_class) {
@@ -4017,6 +4119,8 @@ static void bfq_init_bfqq(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	INIT_HLIST_NODE(&bfqq->burst_list_node);
 	BUG_ON(!hlist_unhashed(&bfqq->burst_list_node));
 
+	spin_lock_init(&bfqq->lock);
+
 	bfqq->ref = 0;
 	bfqq->bfqd = bfqd;
 
@@ -4273,21 +4377,17 @@ static void bfq_rq_enqueued(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		if (budget_timeout)
 			bfq_bfqq_expire(bfqd, bfqq, false,
 					BFQ_BFQQ_BUDGET_TIMEOUT);
-
-		/*
-		 * Let the request rip immediately, or let a new queue be
-		 * selected if bfqq has just been expired.
-		 */
-		__blk_run_queue(bfqd->queue);
 	}
 }
 
-static void bfq_insert_request(struct request_queue *q, struct request *rq)
+
+static void __bfq_insert_request(struct bfq_data *bfqd, struct request *rq)
 {
-	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct bfq_queue *bfqq = RQ_BFQQ(rq), *new_bfqq;
 
-	assert_spin_locked(bfqd->queue->queue_lock);
+	assert_spin_locked(&bfqd->lock);
+
+	bfq_log_bfqq(bfqd, bfqq, "__insert_req: rq %p bfqq %p", rq, bfqq);
 
 	/*
 	 * An unplug may trigger a requeue of a request from the device
@@ -4303,8 +4403,14 @@ static void bfq_insert_request(struct request_queue *q, struct request *rq)
 			 * Release the request's reference to the old bfqq
 			 * and make sure one is taken to the shared queue.
 			 */
-			new_bfqq->allocated[rq_data_dir(rq)]++;
-			bfqq->allocated[rq_data_dir(rq)]--;
+			new_bfqq->allocated++;
+			bfqq->allocated--;
+			bfq_log_bfqq(bfqd, bfqq,
+		     "insert_request: new allocated %d", bfqq->allocated);
+			bfq_log_bfqq(bfqd, new_bfqq,
+		     "insert_request: new_bfqq new allocated %d",
+				     bfqq->allocated);
+
 			new_bfqq->ref++;
 			bfq_clear_bfqq_just_created(bfqq);
 			bfq_put_queue(bfqq);
@@ -4324,6 +4430,55 @@ static void bfq_insert_request(struct request_queue *q, struct request *rq)
 	bfq_rq_enqueued(bfqd, bfqq, rq);
 }
 
+static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+			      bool at_head)
+{
+	struct request_queue *q = hctx->queue;
+	struct bfq_data *bfqd = q->elevator->elevator_data;
+
+	spin_lock_irq(&bfqd->lock);
+	if (blk_mq_sched_try_insert_merge(q, rq))
+		goto done;
+	spin_unlock_irq(&bfqd->lock);
+
+	blk_mq_sched_request_inserted(rq);
+
+	spin_lock_irq(&bfqd->lock);
+	if (at_head || blk_rq_is_passthrough(rq)) {
+		struct bfq_queue *bfqq = RQ_BFQQ(rq);
+
+		if (at_head)
+			list_add(&rq->queuelist, &bfqd->dispatch);
+		else
+			list_add_tail(&rq->queuelist, &bfqd->dispatch);
+
+		if (bfqq)
+			bfqq->dispatched++;
+	} else {
+		__bfq_insert_request(bfqd, rq);
+
+		if (rq_mergeable(rq)) {
+			elv_rqhash_add(q, rq);
+			if (!q->last_merge)
+				q->last_merge = rq;
+		}
+	}
+done:
+	spin_unlock_irq(&bfqd->lock);
+}
+
+static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
+				struct list_head *list, bool at_head)
+{
+	while (!list_empty(list)) {
+		struct request *rq;
+
+		rq = list_first_entry(list, struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		bfq_insert_request(hctx, rq, at_head);
+	}
+}
+
 static void bfq_update_hw_tag(struct bfq_data *bfqd)
 {
 	bfqd->max_rq_in_driver = max_t(int, bfqd->max_rq_in_driver,
@@ -4349,27 +4504,21 @@ static void bfq_update_hw_tag(struct bfq_data *bfqd)
 	bfqd->hw_tag_samples = 0;
 }
 
-static void bfq_completed_request(struct request_queue *q, struct request *rq)
+static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 {
-	struct bfq_queue *bfqq = RQ_BFQQ(rq);
-	struct bfq_data *bfqd = bfqq->bfqd;
 	u64 now_ns;
 	u32 delta_us;
 
-	bfq_log_bfqq(bfqd, bfqq, "completed one req with %u sects left",
-		     blk_rq_sectors(rq));
-
-	assert_spin_locked(bfqd->queue->queue_lock);
 	bfq_update_hw_tag(bfqd);
 
 	BUG_ON(!bfqd->rq_in_driver);
 	BUG_ON(!bfqq->dispatched);
 	bfqd->rq_in_driver--;
 	bfqq->dispatched--;
-	bfqg_stats_update_completion(bfqq_group(bfqq),
-				     rq_start_time_ns(rq),
-				     rq_io_start_time_ns(rq),
-				     rq->cmd_flags);
+
+	bfq_log_bfqq(bfqd, bfqq,
+		     "completed_requests: new disp %d, new rq_in_driver %d",
+		     bfqq->dispatched, bfqd->rq_in_driver);
 
 	if (!bfqq->dispatched && !bfq_bfqq_busy(bfqq)) {
 		BUG_ON(!RB_EMPTY_ROOT(&bfqq->sort_list));
@@ -4395,7 +4544,8 @@ static void bfq_completed_request(struct request_queue *q, struct request *rq)
 	 */
 	delta_us = div_u64(now_ns - bfqd->last_completion, NSEC_PER_USEC);
 
-	bfq_log(bfqd, "rq_completed: delta %uus/%luus max_size %u rate %llu/%llu",
+	bfq_log_bfqq(bfqd, bfqq,
+		"rq_completed: delta %uus/%luus max_size %u rate %llu/%llu",
 		delta_us, BFQ_MIN_TT/NSEC_PER_USEC, bfqd->last_rq_max_size,
 		(USEC_PER_SEC*
 		(u64)((bfqd->last_rq_max_size<<BFQ_RATE_SHIFT)/delta_us))
@@ -4445,7 +4595,7 @@ static void bfq_completed_request(struct request_queue *q, struct request *rq)
 	if (bfqd->in_service_queue == bfqq) {
 		if (bfqq->dispatched == 0 && bfq_bfqq_must_idle(bfqq)) {
 			bfq_arm_slice_timer(bfqd);
-			goto out;
+			return;
 		} else if (bfq_may_expire_for_budg_timeout(bfqq))
 			bfq_bfqq_expire(bfqd, bfqq, false,
 					BFQ_BFQQ_BUDGET_TIMEOUT);
@@ -4455,68 +4605,81 @@ static void bfq_completed_request(struct request_queue *q, struct request *rq)
 			bfq_bfqq_expire(bfqd, bfqq, false,
 					BFQ_BFQQ_NO_MORE_REQUESTS);
 	}
-
-	if (!bfqd->rq_in_driver)
-		bfq_schedule_dispatch(bfqd);
-
-out:
-	return;
 }
 
-static int __bfq_may_queue(struct bfq_queue *bfqq)
+static void bfq_put_rq_priv_body(struct bfq_queue *bfqq)
 {
-	if (bfq_bfqq_wait_request(bfqq) && bfq_bfqq_must_alloc(bfqq)) {
-		bfq_clear_bfqq_must_alloc(bfqq);
-		return ELV_MQUEUE_MUST;
-	}
+	bfq_log_bfqq(bfqq->bfqd, bfqq,
+		     "put_request_body: allocated %d", bfqq->allocated);
+	BUG_ON(!bfqq->allocated);
+	bfqq->allocated--;
 
-	return ELV_MQUEUE_MAY;
+	bfq_put_queue(bfqq);
 }
 
-static int bfq_may_queue(struct request_queue *q, unsigned int op)
+static void bfq_put_rq_private(struct request_queue *q, struct request *rq)
 {
-	struct bfq_data *bfqd = q->elevator->elevator_data;
-	struct task_struct *tsk = current;
-	struct bfq_io_cq *bic;
 	struct bfq_queue *bfqq;
+	struct bfq_data *bfqd;
+	struct bfq_io_cq *bic;
 
-	/*
-	 * Don't force setup of a queue from here, as a call to may_queue
-	 * does not necessarily imply that a request actually will be
-	 * queued. So just lookup a possibly existing queue, or return
-	 * 'may queue' if that fails.
-	 */
-	bic = bfq_bic_lookup(bfqd, tsk->io_context);
-	if (!bic)
-		return ELV_MQUEUE_MAY;
+	BUG_ON(!rq);
+	bfqq = RQ_BFQQ(rq);
+	BUG_ON(!bfqq);
 
-	bfqq = bic_to_bfqq(bic, op_is_sync(op));
-	if (bfqq)
-		return __bfq_may_queue(bfqq);
+	bic = RQ_BIC(rq);
+	BUG_ON(!bic);
 
-	return ELV_MQUEUE_MAY;
-}
+	bfqd = bfqq->bfqd;
+	BUG_ON(!bfqd);
 
-/*
- * Queue lock held here.
- */
-static void bfq_put_request(struct request *rq)
-{
-	struct bfq_queue *bfqq = RQ_BFQQ(rq);
+	BUG_ON(rq->rq_flags & RQF_QUEUED);
+	BUG_ON(!(rq->rq_flags & RQF_ELVPRIV));
 
-	if (bfqq) {
-		const int rw = rq_data_dir(rq);
+	bfq_log_bfqq(bfqd, bfqq,
+		     "putting rq %p with %u sects left, STARTED %d",
+		     rq, blk_rq_sectors(rq),
+		     rq->rq_flags & RQF_STARTED);
 
-		BUG_ON(!bfqq->allocated[rw]);
-		bfqq->allocated[rw]--;
+	if (rq->rq_flags & RQF_STARTED)
+		bfqg_stats_update_completion(bfqq_group(bfqq),
+					     rq_start_time_ns(rq),
+					     rq_io_start_time_ns(rq),
+					     rq->cmd_flags);
 
-		rq->elv.priv[0] = NULL;
-		rq->elv.priv[1] = NULL;
+	BUG_ON(blk_rq_sectors(rq) == 0 && !(rq->rq_flags & RQF_STARTED));
 
-		bfq_log_bfqq(bfqq->bfqd, bfqq, "put_request %p, %d",
-			     bfqq, bfqq->ref);
-		bfq_put_queue(bfqq);
+	if (likely(rq->rq_flags & RQF_STARTED)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&bfqd->lock, flags);
+
+		bfq_completed_request(bfqq, bfqd);
+		bfq_put_rq_priv_body(bfqq);
+
+		spin_unlock_irqrestore(&bfqd->lock, flags);
+	} else {
+		/*
+		 * Request rq may be still/already in the scheduler,
+		 * in which case we need to remove it. And we cannot
+		 * defer such a check and removal, to avoid
+		 * inconsistencies in the time interval from the end
+		 * of this function to the start of the deferred work.
+		 * Fortunately, this situation occurs only in process
+		 * context, so taking the scheduler lock does not
+		 * cause any deadlock, even if other locks are already
+		 * (correctly) held by this process.
+		 */
+		BUG_ON(in_interrupt());
+
+		assert_spin_locked(&bfqd->lock);
+		if (!RB_EMPTY_NODE(&rq->rb_node))
+			bfq_remove_request(q, rq);
+		bfq_put_rq_priv_body(bfqq);
 	}
+
+	rq->elv.priv[0] = NULL;
+	rq->elv.priv[1] = NULL;
 }
 
 /*
@@ -4548,18 +4711,17 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
 /*
  * Allocate bfq data structures associated with this request.
  */
-static int bfq_set_request(struct request_queue *q, struct request *rq,
-			   struct bio *bio, gfp_t gfp_mask)
+static int bfq_get_rq_private(struct request_queue *q, struct request *rq,
+			      struct bio *bio)
 {
 	struct bfq_data *bfqd = q->elevator->elevator_data;
 	struct bfq_io_cq *bic = icq_to_bic(rq->elv.icq);
-	const int rw = rq_data_dir(rq);
 	const int is_sync = rq_is_sync(rq);
 	struct bfq_queue *bfqq;
-	unsigned long flags;
 	bool split = false;
 
-	spin_lock_irqsave(q->queue_lock, flags);
+	spin_lock_irq(&bfqd->lock);
+
 	bfq_check_ioprio_change(bic, bio);
 
 	if (!bic)
@@ -4578,7 +4740,7 @@ static int bfq_set_request(struct request_queue *q, struct request *rq,
 		bic_set_bfqq(bic, bfqq, is_sync);
 		if (split && is_sync) {
 			bfq_log_bfqq(bfqd, bfqq,
-				     "set_request: was_in_list %d "
+				     "get_request: was_in_list %d "
 				     "was_in_large_burst %d "
 				     "large burst in progress %d",
 				     bic->was_in_burst_list,
@@ -4588,12 +4750,12 @@ static int bfq_set_request(struct request_queue *q, struct request *rq,
 			if ((bic->was_in_burst_list && bfqd->large_burst) ||
 			    bic->saved_in_large_burst) {
 				bfq_log_bfqq(bfqd, bfqq,
-					     "set_request: marking in "
+					     "get_request: marking in "
 					     "large burst");
 				bfq_mark_bfqq_in_large_burst(bfqq);
 			} else {
 				bfq_log_bfqq(bfqd, bfqq,
-					     "set_request: clearing in "
+					     "get_request: clearing in "
 					     "large burst");
 				bfq_clear_bfqq_in_large_burst(bfqq);
 				if (bic->was_in_burst_list)
@@ -4618,9 +4780,12 @@ static int bfq_set_request(struct request_queue *q, struct request *rq,
 		}
 	}
 
-	bfqq->allocated[rw]++;
+	bfqq->allocated++;
+	bfq_log_bfqq(bfqq->bfqd, bfqq,
+		     "get_request: new allocated %d", bfqq->allocated);
+
 	bfqq->ref++;
-	bfq_log_bfqq(bfqd, bfqq, "set_request: bfqq %p, %d", bfqq, bfqq->ref);
+	bfq_log_bfqq(bfqd, bfqq, "get_request: bfqq %p, %d", bfqq, bfqq->ref);
 
 	rq->elv.priv[0] = bic;
 	rq->elv.priv[1] = bfqq;
@@ -4647,26 +4812,55 @@ static int bfq_set_request(struct request_queue *q, struct request *rq,
 	if (unlikely(bfq_bfqq_just_created(bfqq)))
 		bfq_handle_burst(bfqd, bfqq);
 
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irq(&bfqd->lock);
 
 	return 0;
 
 queue_fail:
-	bfq_schedule_dispatch(bfqd);
-	spin_unlock_irqrestore(q->queue_lock, flags);
+	spin_unlock_irq(&bfqd->lock);
 
 	return 1;
 }
 
-static void bfq_kick_queue(struct work_struct *work)
+static void bfq_idle_slice_timer_body(struct bfq_queue *bfqq)
 {
-	struct bfq_data *bfqd =
-		container_of(work, struct bfq_data, unplug_work);
-	struct request_queue *q = bfqd->queue;
+	struct bfq_data *bfqd = bfqq->bfqd;
+	enum bfqq_expiration reason;
+	unsigned long flags;
+
+	BUG_ON(!bfqd);
+	spin_lock_irqsave(&bfqd->lock, flags);
+	bfq_log_bfqq(bfqd, bfqq, "handling slice_timer expiration");
+	bfq_clear_bfqq_wait_request(bfqq);
 
-	spin_lock_irq(q->queue_lock);
-	__blk_run_queue(q);
-	spin_unlock_irq(q->queue_lock);
+	if (bfqq != bfqd->in_service_queue) {
+		spin_unlock_irqrestore(&bfqd->lock, flags);
+		return;
+	}
+
+	if (bfq_bfqq_budget_timeout(bfqq))
+		/*
+		 * Also here the queue can be safely expired
+		 * for budget timeout without wasting
+		 * guarantees
+		 */
+		reason = BFQ_BFQQ_BUDGET_TIMEOUT;
+	else if (bfqq->queued[0] == 0 && bfqq->queued[1] == 0)
+		/*
+		 * The queue may not be empty upon timer expiration,
+		 * because we may not disable the timer when the
+		 * first request of the in-service queue arrives
+		 * during disk idling.
+		 */
+		reason = BFQ_BFQQ_TOO_IDLE;
+	else
+		goto schedule_dispatch;
+
+	bfq_bfqq_expire(bfqd, bfqq, true, reason);
+
+schedule_dispatch:
+	spin_unlock_irqrestore(&bfqd->lock, flags);
+	bfq_schedule_dispatch(bfqd);
 }
 
 /*
@@ -4677,59 +4871,24 @@ static enum hrtimer_restart bfq_idle_slice_timer(struct hrtimer *timer)
 {
 	struct bfq_data *bfqd = container_of(timer, struct bfq_data,
 					     idle_slice_timer);
-	struct bfq_queue *bfqq;
-	unsigned long flags;
-	enum bfqq_expiration reason;
+	struct bfq_queue *bfqq = bfqd->in_service_queue;
 
-	spin_lock_irqsave(bfqd->queue->queue_lock, flags);
+	bfq_log(bfqd, "slice_timer expired");
 
-	bfqq = bfqd->in_service_queue;
 	/*
 	 * Theoretical race here: the in-service queue can be NULL or
-	 * different from the queue that was idling if the timer handler
-	 * spins on the queue_lock and a new request arrives for the
-	 * current queue and there is a full dispatch cycle that changes
-	 * the in-service queue.  This can hardly happen, but in the worst
-	 * case we just expire a queue too early.
+	 * different from the queue that was idling if a new request
+	 * arrives for the current queue and there is a full dispatch
+	 * cycle that changes the in-service queue.  This can hardly
+	 * happen, but in the worst case we just expire a queue too
+	 * early.
 	 */
-	if (bfqq) {
-		bfq_log_bfqq(bfqd, bfqq, "slice_timer expired");
-		bfq_clear_bfqq_wait_request(bfqq);
-
-		if (bfq_bfqq_budget_timeout(bfqq))
-			/*
-			 * Also here the queue can be safely expired
-			 * for budget timeout without wasting
-			 * guarantees
-			 */
-			reason = BFQ_BFQQ_BUDGET_TIMEOUT;
-		else if (bfqq->queued[0] == 0 && bfqq->queued[1] == 0)
-			/*
-			 * The queue may not be empty upon timer expiration,
-			 * because we may not disable the timer when the
-			 * first request of the in-service queue arrives
-			 * during disk idling.
-			 */
-			reason = BFQ_BFQQ_TOO_IDLE;
-		else
-			goto schedule_dispatch;
-
-		bfq_bfqq_expire(bfqd, bfqq, true, reason);
-	}
-
-schedule_dispatch:
-	bfq_schedule_dispatch(bfqd);
+	if (bfqq)
+		bfq_idle_slice_timer_body(bfqq);
 
-	spin_unlock_irqrestore(bfqd->queue->queue_lock, flags);
 	return HRTIMER_NORESTART;
 }
 
-static void bfq_shutdown_timer_wq(struct bfq_data *bfqd)
-{
-	hrtimer_cancel(&bfqd->idle_slice_timer);
-	cancel_work_sync(&bfqd->unplug_work);
-}
-
 static void __bfq_put_async_bfqq(struct bfq_data *bfqd,
 					struct bfq_queue **bfqq_ptr)
 {
@@ -4766,30 +4925,44 @@ static void bfq_put_async_queues(struct bfq_data *bfqd, struct bfq_group *bfqg)
 static void bfq_exit_queue(struct elevator_queue *e)
 {
 	struct bfq_data *bfqd = e->elevator_data;
-	struct request_queue *q = bfqd->queue;
 	struct bfq_queue *bfqq, *n;
 
-	bfq_shutdown_timer_wq(bfqd);
+	bfq_log(bfqd, "exit_queue: starting ...");
 
-	spin_lock_irq(q->queue_lock);
+	hrtimer_cancel(&bfqd->idle_slice_timer);
 
 	BUG_ON(bfqd->in_service_queue);
-	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list)
-		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
+	BUG_ON(!list_empty(&bfqd->active_list));
 
-	spin_unlock_irq(q->queue_lock);
+	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list) {
+		if (bfqq->bic) /* bfqqs without bic are handled below */
+			cancel_work_sync(&bfqq->bic->exit_icq_work);
+	}
 
-	bfq_shutdown_timer_wq(bfqd);
+	spin_lock_irq(&bfqd->lock);
+	list_for_each_entry_safe(bfqq, n, &bfqd->idle_list, bfqq_list) {
+		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
+		/*
+		 * Make sure that deferred exit_icq_work completes
+		 * without errors for bfq_queues without bic
+		 */
+		if (!bfqq->bic)
+			bfqq->bfqd = NULL;
+	}
+	spin_unlock_irq(&bfqd->lock);
+
+	hrtimer_cancel(&bfqd->idle_slice_timer);
 
 	BUG_ON(hrtimer_active(&bfqd->idle_slice_timer));
 
 #ifdef BFQ_GROUP_IOSCHED_ENABLED
-	blkcg_deactivate_policy(q, &blkcg_policy_bfq);
+	blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
 #else
 	bfq_put_async_queues(bfqd, bfqd->root_group);
 	kfree(bfqd->root_group);
 #endif
 
+	bfq_log(bfqd, "exit_queue: finished ...");
 	kfree(bfqd);
 }
 
@@ -4848,10 +5021,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 
 	bfqd->queue = q;
 
-	spin_lock_irq(q->queue_lock);
-	q->elevator = eq;
-	spin_unlock_irq(q->queue_lock);
-
 	bfqd->root_group = bfq_create_group_hierarchy(bfqd, q->node);
 	if (!bfqd->root_group)
 		goto out_free;
@@ -4865,8 +5034,6 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->queue_weights_tree = RB_ROOT;
 	bfqd->group_weights_tree = RB_ROOT;
 
-	INIT_WORK(&bfqd->unplug_work, bfq_kick_queue);
-
 	INIT_LIST_HEAD(&bfqd->active_list);
 	INIT_LIST_HEAD(&bfqd->idle_list);
 	INIT_HLIST_HEAD(&bfqd->burst_list);
@@ -4915,6 +5082,11 @@ static int bfq_init_queue(struct request_queue *q, struct elevator_type *e)
 	bfqd->peak_rate = R_fast[blk_queue_nonrot(bfqd->queue)] * 2 / 3;
 	bfqd->device_speed = BFQ_BFQD_FAST;
 
+	spin_lock_init(&bfqd->lock);
+	INIT_LIST_HEAD(&bfqd->dispatch);
+
+	q->elevator = eq;
+
 	return 0;
 
 out_free:
@@ -4971,7 +5143,7 @@ static ssize_t bfq_weights_show(struct elevator_queue *e, char *page)
 	num_char += sprintf(page + num_char, "Tot reqs queued %d\n\n",
 			    bfqd->queued);
 
-	spin_lock_irq(bfqd->queue->queue_lock);
+	spin_lock_irq(&bfqd->lock);
 
 	num_char += sprintf(page + num_char, "Active:\n");
 	list_for_each_entry(bfqq, &bfqd->active_list, bfqq_list) {
@@ -5000,7 +5172,7 @@ static ssize_t bfq_weights_show(struct elevator_queue *e, char *page)
 				    jiffies_to_msecs(bfqq->wr_cur_max_time));
 	}
 
-	spin_unlock_irq(bfqd->queue->queue_lock);
+	spin_unlock_irq(&bfqd->lock);
 
 	return num_char;
 }
@@ -5208,35 +5380,31 @@ static struct elv_fs_entry bfq_attrs[] = {
 	__ATTR_NULL
 };
 
-static struct elevator_type iosched_bfq = {
-	.ops.sq = {
-		.elevator_merge_fn =		bfq_merge,
-		.elevator_merged_fn =		bfq_merged_request,
-		.elevator_merge_req_fn =	bfq_merged_requests,
-#ifdef BFQ_GROUP_IOSCHED_ENABLED
-		.elevator_bio_merged_fn =	bfq_bio_merged,
-#endif
-		.elevator_allow_bio_merge_fn =	bfq_allow_bio_merge,
-		.elevator_allow_rq_merge_fn =	bfq_allow_rq_merge,
-		.elevator_dispatch_fn =		bfq_dispatch_requests,
-		.elevator_add_req_fn =		bfq_insert_request,
-		.elevator_activate_req_fn =	bfq_activate_request,
-		.elevator_deactivate_req_fn =	bfq_deactivate_request,
-		.elevator_completed_req_fn =	bfq_completed_request,
-		.elevator_former_req_fn =	elv_rb_former_request,
-		.elevator_latter_req_fn =	elv_rb_latter_request,
-		.elevator_init_icq_fn =		bfq_init_icq,
-		.elevator_exit_icq_fn =		bfq_exit_icq,
-		.elevator_set_req_fn =		bfq_set_request,
-		.elevator_put_req_fn =		bfq_put_request,
-		.elevator_may_queue_fn =	bfq_may_queue,
-		.elevator_init_fn =		bfq_init_queue,
-		.elevator_exit_fn =		bfq_exit_queue,
+static struct elevator_type iosched_bfq_mq = {
+	.ops.mq = {
+		.get_rq_priv		= bfq_get_rq_private,
+		.put_rq_priv		= bfq_put_rq_private,
+		.init_icq		= bfq_init_icq,
+		.exit_icq		= bfq_exit_icq,
+		.insert_requests	= bfq_insert_requests,
+		.dispatch_request	= bfq_dispatch_request,
+		.next_request		= elv_rb_latter_request,
+		.former_request		= elv_rb_former_request,
+		.allow_merge		= bfq_allow_bio_merge,
+		.bio_merge		= bfq_bio_merge,
+		.request_merge		= bfq_request_merge,
+		.requests_merged	= bfq_requests_merged,
+		.request_merged		= bfq_request_merged,
+		.has_work		= bfq_has_work,
+		.init_sched		= bfq_init_queue,
+		.exit_sched		= bfq_exit_queue,
 	},
+
+	.uses_mq = 		true,
 	.icq_size =		sizeof(struct bfq_io_cq),
 	.icq_align =		__alignof__(struct bfq_io_cq),
 	.elevator_attrs =	bfq_attrs,
-	.elevator_name =	"bfq",
+	.elevator_name =	"bfq-mq",
 	.elevator_owner =	THIS_MODULE,
 };
 
@@ -5261,7 +5429,7 @@ static struct blkcg_policy blkcg_policy_bfq = {
 static int __init bfq_init(void)
 {
 	int ret;
-	char msg[60] = "BFQ I/O-scheduler: v8r8-rc2";
+	char msg[60] = "BFQ-MQ I/O-scheduler: v8r8-rc2";
 
 #ifdef BFQ_GROUP_IOSCHED_ENABLED
 	ret = blkcg_policy_register(&blkcg_policy_bfq);
@@ -5306,7 +5474,7 @@ static int __init bfq_init(void)
 	device_speed_thresh[0] = (4 * R_slow[0]) / 3;
 	device_speed_thresh[1] = (4 * R_slow[1]) / 3;
 
-	ret = elv_register(&iosched_bfq);
+	ret = elv_register(&iosched_bfq_mq);
 	if (ret)
 		goto err_pol_unreg;
 
@@ -5326,8 +5494,8 @@ static int __init bfq_init(void)
 
 static void __exit bfq_exit(void)
 {
-	elv_unregister(&iosched_bfq);
-#ifdef BFQ_GROUP_IOSCHED_ENABLED
+	elv_unregister(&iosched_bfq_mq);
+#ifdef CONFIG_BFQ_GROUP_ENABLED
 	blkcg_policy_unregister(&blkcg_policy_bfq);
 #endif
 	bfq_slab_kill();
@@ -5336,5 +5504,6 @@ static void __exit bfq_exit(void)
 module_init(bfq_init);
 module_exit(bfq_exit);
 
-MODULE_AUTHOR("Arianna Avanzini, Fabio Checconi, Paolo Valente");
+MODULE_AUTHOR("Paolo Valente");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MQ Budget Fair IO scheduler");
diff --git a/block/bfq-mq.h b/block/bfq-mq.h
index c6acee2..6e1c0d8 100644
--- a/block/bfq-mq.h
+++ b/block/bfq-mq.h
@@ -1,5 +1,5 @@
 /*
- * BFQ v8r8-rc2 for 4.10.0: data structures and common functions prototypes.
+ * BFQ-MQ v8r8-rc2 for 4.10.0: data structures and common functions prototypes.
  *
  * Based on ideas and code from CFQ:
  * Copyright (C) 2003 Jens Axboe <axboe@kernel.dk>
@@ -21,15 +21,8 @@
 #include <linux/rbtree.h>
 #include <linux/blk-cgroup.h>
 
-/*
- * Define an alternative macro to compile cgroups support. This is one
- * of the steps needed to let bfq-mq share the files bfq-sched.c and
- * bfq-cgroup.c with bfq. For bfq-mq, the macro
- * BFQ_GROUP_IOSCHED_ENABLED will be defined as a function of whether
- * the configuration option CONFIG_BFQ_MQ_GROUP_IOSCHED, and not
- * CONFIG_BFQ_GROUP_IOSCHED, is defined.
- */
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
+/* see comments on CONFIG_BFQ_GROUP_IOSCHED in bfq.h */
+#ifdef CONFIG_BFQ_MQ_GROUP_IOSCHED
 #define BFQ_GROUP_IOSCHED_ENABLED
 #endif
 
@@ -248,8 +241,8 @@ struct bfq_queue {
 	struct request *next_rq;
 	/* number of sync and async requests queued */
 	int queued[2];
-	/* number of sync and async requests currently allocated */
-	int allocated[2];
+	/* number of requests currently allocated */
+	int allocated;
 	/* number of pending metadata requests */
 	int meta_pending;
 	/* fifo list of requests in sort_list */
@@ -334,6 +327,8 @@ struct bfq_queue {
 	unsigned long wr_start_at_switch_to_srt;
 
 	unsigned long split_time; /* time of last split */
+
+	spinlock_t lock;
 };
 
 /**
@@ -350,6 +345,9 @@ struct bfq_io_cq {
 	uint64_t blkcg_serial_nr; /* the current blkcg serial */
 #endif
 
+	/* delayed work to exec the body of the the exit_icq handler */
+	struct work_struct exit_icq_work;
+
 	/*
 	 * Snapshot of the idle window before merging; taken to
 	 * remember this value while the queue is merged, so as to be
@@ -391,11 +389,13 @@ enum bfq_device_speed {
 /**
  * struct bfq_data - per-device data structure.
  *
- * All the fields are protected by the @queue lock.
+ * All the fields are protected by @lock.
  */
 struct bfq_data {
-	/* request queue for the device */
+	/* device request queue */
 	struct request_queue *queue;
+	/* dispatch queue */
+	struct list_head dispatch;
 
 	/* root bfq_group for the device */
 	struct bfq_group *root_group;
@@ -449,8 +449,6 @@ struct bfq_data {
 	 * the queue in service.
 	 */
 	struct hrtimer idle_slice_timer;
-	/* delayed work to restart dispatching on the request queue */
-	struct work_struct unplug_work;
 
 	/* bfq_queue in service */
 	struct bfq_queue *in_service_queue;
@@ -603,6 +601,8 @@ struct bfq_data {
 
 	/* fallback dummy bfqq for extreme OOM conditions */
 	struct bfq_queue oom_bfqq;
+
+	spinlock_t lock;
 };
 
 enum bfqq_state_flags {
@@ -613,7 +613,6 @@ enum bfqq_state_flags {
 					     * waiting for a request
 					     * without idling the device
 					     */
-	BFQ_BFQQ_FLAG_must_alloc,	/* must be allowed rq alloc */
 	BFQ_BFQQ_FLAG_fifo_expire,	/* FIFO checked in this slice */
 	BFQ_BFQQ_FLAG_idle_window,	/* slice idling enabled */
 	BFQ_BFQQ_FLAG_sync,		/* synchronous queue */
@@ -652,7 +651,6 @@ BFQ_BFQQ_FNS(just_created);
 BFQ_BFQQ_FNS(busy);
 BFQ_BFQQ_FNS(wait_request);
 BFQ_BFQQ_FNS(non_blocking_wait_rq);
-BFQ_BFQQ_FNS(must_alloc);
 BFQ_BFQQ_FNS(fifo_expire);
 BFQ_BFQQ_FNS(idle_window);
 BFQ_BFQQ_FNS(sync);
@@ -672,7 +670,6 @@ static struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
 	char __pbuf[128];						\
 									\
-	assert_spin_locked((bfqd)->queue->queue_lock);			\
 	blkg_path(bfqg_to_blkg(bfqq_group(bfqq)), __pbuf, sizeof(__pbuf)); \
 	pr_crit("bfq%d%c %s " fmt "\n", 			\
 		(bfqq)->pid,						\
@@ -708,7 +705,6 @@ static struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 #define bfq_log_bfqq(bfqd, bfqq, fmt, args...)	do {			\
 	char __pbuf[128];						\
 									\
-	assert_spin_locked((bfqd)->queue->queue_lock);			\
 	blkg_path(bfqg_to_blkg(bfqq_group(bfqq)), __pbuf, sizeof(__pbuf)); \
 	blk_add_trace_msg((bfqd)->queue, "bfq%d%c %s " fmt, \
 			  (bfqq)->pid,			  \
@@ -935,7 +931,6 @@ static struct bfq_group *bfq_bfqq_to_bfqg(struct bfq_queue *bfqq)
 
 static void bfq_check_ioprio_change(struct bfq_io_cq *bic, struct bio *bio);
 static void bfq_put_queue(struct bfq_queue *bfqq);
-static void bfq_dispatch_insert(struct request_queue *q, struct request *rq);
 static struct bfq_queue *bfq_get_queue(struct bfq_data *bfqd,
 				       struct bio *bio, bool is_sync,
 				       struct bfq_io_cq *bic);
-- 
2.10.0
