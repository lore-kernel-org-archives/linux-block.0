Return-Path: <paolo.valente@linaro.org>
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
Subject: [PATCH V3 15/16] block, bfq: remove all get and put of I/O contexts
Date: Tue, 11 Apr 2017 15:43:14 +0200
Message-Id: <20170411134315.44135-16-paolo.valente@linaro.org>
In-Reply-To: <20170411134315.44135-1-paolo.valente@linaro.org>
References: <20170411134315.44135-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

When a bfq queue is set in service and when it is merged, a reference
to the I/O context associated with the queue is taken. This reference
is then released when the queue is deselected from service or
split. More precisely, the release of the reference is postponed to
when the scheduler lock is released, to avoid nesting between the
scheduler and the I/O-context lock. In fact, such nesting would lead
to deadlocks, because of other code paths that take the same locks in
the opposite order. This postponing of I/O-context releases does
complicate code.

This commit addresses these issue by modifying involved operations in
such a way to not need to get the above I/O-context references any
more. Then it also removes any get and release of these references.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 143 +++++++++-------------------------------------------
 1 file changed, 23 insertions(+), 120 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index b7e3c86..30bb8f9 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -538,8 +538,6 @@ struct bfq_data {
 
 	/* bfq_queue in service */
 	struct bfq_queue *in_service_queue;
-	/* bfq_io_cq (bic) associated with the @in_service_queue */
-	struct bfq_io_cq *in_service_bic;
 
 	/* on-disk position of the last served request */
 	sector_t last_position;
@@ -704,15 +702,6 @@ struct bfq_data {
 	struct bfq_io_cq *bio_bic;
 	/* bfqq associated with the task issuing current bio for merging */
 	struct bfq_queue *bio_bfqq;
-
-	/*
-	 * io context to put right after bfqd->lock is released. This
-	 * filed is used to perform put_io_context, when needed, to
-	 * after the scheduler lock has been released, and thus
-	 * prevent an ioc->lock from being possibly taken while the
-	 * scheduler lock is being held.
-	 */
-	struct io_context *ioc_to_put;
 };
 
 enum bfqq_state_flags {
@@ -1148,34 +1137,6 @@ static void bfq_schedule_dispatch(struct bfq_data *bfqd)
 	}
 }
 
-/*
- * Next two functions release bfqd->lock and put the io context
- * pointed by bfqd->ioc_to_put. This delayed put is used to not risk
- * to take an ioc->lock while the scheduler lock is being held.
- */
-static void bfq_unlock_put_ioc(struct bfq_data *bfqd)
-{
-	struct io_context *ioc_to_put = bfqd->ioc_to_put;
-
-	bfqd->ioc_to_put = NULL;
-	spin_unlock_irq(&bfqd->lock);
-
-	if (ioc_to_put)
-		put_io_context(ioc_to_put);
-}
-
-static void bfq_unlock_put_ioc_restore(struct bfq_data *bfqd,
-				       unsigned long flags)
-{
-	struct io_context *ioc_to_put = bfqd->ioc_to_put;
-
-	bfqd->ioc_to_put = NULL;
-	spin_unlock_irqrestore(&bfqd->lock, flags);
-
-	if (ioc_to_put)
-		put_io_context(ioc_to_put);
-}
-
 /**
  * bfq_gt - compare two timestamps.
  * @a: first ts.
@@ -2684,18 +2645,6 @@ static void __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
 	struct bfq_entity *entity = in_serv_entity;
 
-	if (bfqd->in_service_bic) {
-		/*
-		 * Schedule the release of a reference to
-		 * bfqd->in_service_bic->icq.ioc to right after the
-		 * scheduler lock is released. This ioc is not
-		 * released immediately, to not risk to possibly take
-		 * an ioc->lock while holding the scheduler lock.
-		 */
-		bfqd->ioc_to_put = bfqd->in_service_bic->icq.ioc;
-		bfqd->in_service_bic = NULL;
-	}
-
 	bfq_clear_bfqq_wait_request(in_serv_bfqq);
 	hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
 	bfqd->in_service_queue = NULL;
@@ -3495,7 +3444,7 @@ static void bfq_pd_offline(struct blkg_policy_data *pd)
 	__bfq_deactivate_entity(entity, false);
 	bfq_put_async_queues(bfqd, bfqg);
 
-	bfq_unlock_put_ioc_restore(bfqd, flags);
+	spin_unlock_irqrestore(&bfqd->lock, flags);
 	/*
 	 * @blkg is going offline and will be ignored by
 	 * blkg_[rw]stat_recursive_sum().  Transfer stats to the parent so
@@ -5472,20 +5421,18 @@ bfq_setup_merge(struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
 	 * first time that the requests of some process are redirected to
 	 * it.
 	 *
-	 * We redirect bfqq to new_bfqq and not the opposite, because we
-	 * are in the context of the process owning bfqq, hence we have
-	 * the io_cq of this process. So we can immediately configure this
-	 * io_cq to redirect the requests of the process to new_bfqq.
+	 * We redirect bfqq to new_bfqq and not the opposite, because
+	 * we are in the context of the process owning bfqq, thus we
+	 * have the io_cq of this process. So we can immediately
+	 * configure this io_cq to redirect the requests of the
+	 * process to new_bfqq. In contrast, the io_cq of new_bfqq is
+	 * not available any more (new_bfqq->bic == NULL).
 	 *
-	 * NOTE, even if new_bfqq coincides with the in-service queue, the
-	 * io_cq of new_bfqq is not available, because, if the in-service
-	 * queue is shared, bfqd->in_service_bic may not point to the
-	 * io_cq of the in-service queue.
-	 * Redirecting the requests of the process owning bfqq to the
-	 * currently in-service queue is in any case the best option, as
-	 * we feed the in-service queue with new requests close to the
-	 * last request served and, by doing so, hopefully increase the
-	 * throughput.
+	 * Anyway, even in case new_bfqq coincides with the in-service
+	 * queue, redirecting requests the in-service queue is the
+	 * best option, as we feed the in-service queue with new
+	 * requests close to the last request served and, by doing so,
+	 * are likely to increase the throughput.
 	 */
 	bfqq->new_bfqq = new_bfqq;
 	new_bfqq->ref += process_refs;
@@ -5577,8 +5524,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	in_service_bfqq = bfqd->in_service_queue;
 
-	if (!in_service_bfqq || in_service_bfqq == bfqq ||
-	    !bfqd->in_service_bic || wr_from_too_long(in_service_bfqq) ||
+	if (!in_service_bfqq || in_service_bfqq == bfqq
+	    || wr_from_too_long(in_service_bfqq) ||
 	    unlikely(in_service_bfqq == &bfqd->oom_bfqq))
 		goto check_scheduled;
 
@@ -5629,16 +5576,6 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
 	bic->saved_wr_cur_max_time = bfqq->wr_cur_max_time;
 }
 
-static void bfq_get_bic_reference(struct bfq_queue *bfqq)
-{
-	/*
-	 * If bfqq->bic has a non-NULL value, the bic to which it belongs
-	 * is about to begin using a shared bfq_queue.
-	 */
-	if (bfqq->bic)
-		atomic_long_inc(&bfqq->bic->icq.ioc->refcount);
-}
-
 static void
 bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 		struct bfq_queue *bfqq, struct bfq_queue *new_bfqq)
@@ -5683,12 +5620,6 @@ bfq_merge_bfqqs(struct bfq_data *bfqd, struct bfq_io_cq *bic,
 		     bfqd->wr_busy_queues);
 
 	/*
-	 * Grab a reference to the bic, to prevent it from being destroyed
-	 * before being possibly touched by a bfq_split_bfqq().
-	 */
-	bfq_get_bic_reference(bfqq);
-	bfq_get_bic_reference(new_bfqq);
-	/*
 	 * Merge queues (that is, let bic redirect its requests to new_bfqq)
 	 */
 	bic_set_bfqq(bic, new_bfqq, 1);
@@ -5853,14 +5784,8 @@ static struct bfq_queue *bfq_set_in_service_queue(struct bfq_data *bfqd)
 static void bfq_arm_slice_timer(struct bfq_data *bfqd)
 {
 	struct bfq_queue *bfqq = bfqd->in_service_queue;
-	struct bfq_io_cq *bic;
 	u32 sl;
 
-	/* Processes have exited, don't wait. */
-	bic = bfqd->in_service_bic;
-	if (!bic || atomic_read(&bic->icq.ioc->active_ref) == 0)
-		return;
-
 	bfq_mark_bfqq_wait_request(bfqq);
 
 	/*
@@ -7147,11 +7072,6 @@ static struct request *bfq_dispatch_rq_from_bfqq(struct bfq_data *bfqd,
 	 */
 	bfq_update_wr_data(bfqd, bfqq);
 
-	if (!bfqd->in_service_bic) {
-		atomic_long_inc(&RQ_BIC(rq)->icq.ioc->refcount);
-		bfqd->in_service_bic = RQ_BIC(rq);
-	}
-
 	/*
 	 * Expire bfqq, pretending that its budget expired, if bfqq
 	 * belongs to CLASS_IDLE and other queues are waiting for
@@ -7272,7 +7192,7 @@ static struct request *bfq_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	spin_lock_irq(&bfqd->lock);
 
 	rq = __bfq_dispatch_request(hctx);
-	bfq_unlock_put_ioc(bfqd);
+	spin_unlock_irq(&bfqd->lock);
 
 	return rq;
 }
@@ -7360,20 +7280,9 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
 		unsigned long flags;
 
 		spin_lock_irqsave(&bfqd->lock, flags);
-		/*
-		 * If the bic is using a shared queue, put the
-		 * reference taken on the io_context when the bic
-		 * started using a shared bfq_queue. This put cannot
-		 * make ioc->ref_count reach 0, then no ioc->lock
-		 * risks to be taken (leading to possible deadlock
-		 * scenarios).
-		 */
-		if (is_sync && bfq_bfqq_coop(bfqq))
-			put_io_context(bic->icq.ioc);
-
 		bfq_exit_bfqq(bfqd, bfqq);
 		bic_set_bfqq(bic, NULL, is_sync);
-		bfq_unlock_put_ioc_restore(bfqd, flags);
+		spin_unlock_irqrestore(&bfqd->lock, flags);
 	}
 }
 
@@ -7808,7 +7717,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		}
 	}
 
-	bfq_unlock_put_ioc(bfqd);
+	spin_unlock_irq(&bfqd->lock);
 }
 
 static void bfq_insert_requests(struct blk_mq_hw_ctx *hctx,
@@ -7962,7 +7871,7 @@ static void bfq_put_rq_private(struct request_queue *q, struct request *rq)
 		bfq_completed_request(bfqq, bfqd);
 		bfq_put_rq_priv_body(bfqq);
 
-		bfq_unlock_put_ioc_restore(bfqd, flags);
+		spin_unlock_irqrestore(&bfqd->lock, flags);
 	} else {
 		/*
 		 * Request rq may be still/already in the scheduler,
@@ -8055,6 +7964,7 @@ static int bfq_get_rq_private(struct request_queue *q, struct request *rq,
 	const int is_sync = rq_is_sync(rq);
 	struct bfq_queue *bfqq;
 	bool new_queue = false;
+	bool split = false;
 
 	spin_lock_irq(&bfqd->lock);
 
@@ -8078,14 +7988,7 @@ static int bfq_get_rq_private(struct request_queue *q, struct request *rq,
 				bic->saved_in_large_burst = true;
 
 			bfqq = bfq_split_bfqq(bic, bfqq);
-			/*
-			 * A reference to bic->icq.ioc needs to be
-			 * released after a queue split. Do not do it
-			 * immediately, to not risk to possibly take
-			 * an ioc->lock while holding the scheduler
-			 * lock.
-			 */
-			bfqd->ioc_to_put = bic->icq.ioc;
+			split = true;
 
 			if (!bfqq)
 				bfqq = bfq_get_bfqq_handle_split(bfqd, bic, bio,
@@ -8110,7 +8013,7 @@ static int bfq_get_rq_private(struct request_queue *q, struct request *rq,
 	 */
 	if (likely(bfqq != &bfqd->oom_bfqq) && bfqq_process_refs(bfqq) == 1) {
 		bfqq->bic = bic;
-		if (bfqd->ioc_to_put) { /* if true, there has been a split */
+		if (split) {
 			/*
 			 * The queue has just been split from a shared
 			 * queue: restore the idle window and the
@@ -8123,7 +8026,7 @@ static int bfq_get_rq_private(struct request_queue *q, struct request *rq,
 	if (unlikely(bfq_bfqq_just_created(bfqq)))
 		bfq_handle_burst(bfqd, bfqq);
 
-	bfq_unlock_put_ioc(bfqd);
+	spin_unlock_irq(&bfqd->lock);
 
 	return 0;
 
@@ -8168,7 +8071,7 @@ static void bfq_idle_slice_timer_body(struct bfq_queue *bfqq)
 	bfq_bfqq_expire(bfqd, bfqq, true, reason);
 
 schedule_dispatch:
-	bfq_unlock_put_ioc_restore(bfqd, flags);
+	spin_unlock_irqrestore(&bfqd->lock, flags);
 	bfq_schedule_dispatch(bfqd);
 }
 
-- 
2.10.0
