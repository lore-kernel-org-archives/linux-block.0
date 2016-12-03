Return-Path: <prvs=11458901a0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 5/7] blk-mq: test patch to get legacy IO schedulers working
Date: Fri, 2 Dec 2016 20:15:19 -0700
Message-ID: <1480734921-23701-6-git-send-email-axboe@fb.com>
In-Reply-To: <1480734921-23701-1-git-send-email-axboe@fb.com>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

With this applied, a single queue blk-mq manage device can use
any of the legacy IO schedulers. The driver has to set
BLK_MQ_F_SQ_SCHED for now, and we default to 'deadline'.

The scheduler defaults to deadline for now. Can be runtime switched,
like the non-mq devices, by echoing something else into
/sys/block/</dev>/queue/scheduler

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-core.c       |  38 ++++---
 block/blk-merge.c      |   5 +
 block/blk-mq.c         | 290 ++++++++++++++++++++++++++++++++++++++++++++++---
 block/blk-sysfs.c      |   2 +-
 block/blk.h            |   4 +
 block/elevator.c       |  11 +-
 include/linux/blk-mq.h |   1 +
 include/linux/blkdev.h |   2 +
 8 files changed, 316 insertions(+), 37 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3591f5419509..6c1063aab1a0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1159,6 +1159,8 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 	blk_rq_set_rl(rq, rl);
 	rq->cmd_flags = op;
 	rq->rq_flags = rq_flags;
+	if (q->mq_ops)
+		rq->rq_flags |= RQF_MQ_RL;
 
 	/* init elvpriv */
 	if (rq_flags & RQF_ELVPRIV) {
@@ -1246,8 +1248,8 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
  * Returns ERR_PTR on failure, with @q->queue_lock held.
  * Returns request pointer on success, with @q->queue_lock *not held*.
  */
-static struct request *get_request(struct request_queue *q, unsigned int op,
-		struct bio *bio, gfp_t gfp_mask)
+struct request *get_request(struct request_queue *q, unsigned int op,
+			    struct bio *bio, gfp_t gfp_mask)
 {
 	const bool is_sync = op_is_sync(op);
 	DEFINE_WAIT(wait);
@@ -1430,7 +1432,7 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 	if (unlikely(!q))
 		return;
 
-	if (q->mq_ops) {
+	if (q->mq_ops && !(req->rq_flags & RQF_MQ_RL)) {
 		blk_mq_free_request(req);
 		return;
 	}
@@ -1466,7 +1468,7 @@ void blk_put_request(struct request *req)
 {
 	struct request_queue *q = req->q;
 
-	if (q->mq_ops)
+	if (q->mq_ops && !(req->rq_flags & RQF_MQ_RL))
 		blk_mq_free_request(req);
 	else {
 		unsigned long flags;
@@ -1556,6 +1558,15 @@ bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
 	return true;
 }
 
+struct list_head *blk_get_plug_list(struct request_queue *q,
+				    struct blk_plug *plug)
+{
+	if (!q->mq_ops || q->elevator)
+		return &plug->list;
+
+	return &plug->mq_list;
+}
+
 /**
  * blk_attempt_plug_merge - try to merge with %current's plugged list
  * @q: request_queue new bio is being queued at
@@ -1592,10 +1603,7 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		goto out;
 	*request_count = 0;
 
-	if (q->mq_ops)
-		plug_list = &plug->mq_list;
-	else
-		plug_list = &plug->list;
+	plug_list = blk_get_plug_list(q, plug);
 
 	list_for_each_entry_reverse(rq, plug_list, queuelist) {
 		int el_ret;
@@ -1640,10 +1648,7 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 	if (!plug)
 		goto out;
 
-	if (q->mq_ops)
-		plug_list = &plug->mq_list;
-	else
-		plug_list = &plug->list;
+	plug_list = blk_get_plug_list(q, plug);
 
 	list_for_each_entry(rq, plug_list, queuelist) {
 		if (rq->q == q)
@@ -3197,7 +3202,9 @@ static void queue_unplugged(struct request_queue *q, unsigned int depth,
 {
 	trace_block_unplug(q, depth, !from_schedule);
 
-	if (from_schedule)
+	if (q->mq_ops)
+		blk_mq_run_hw_queues(q, true);
+	else if (from_schedule)
 		blk_run_queue_async(q);
 	else
 		__blk_run_queue(q);
@@ -3293,7 +3300,10 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		 * Short-circuit if @q is dead
 		 */
 		if (unlikely(blk_queue_dying(q))) {
-			__blk_end_request_all(rq, -ENODEV);
+			if (q->mq_ops)
+				blk_mq_end_request(rq, -ENODEV);
+			else
+				__blk_end_request_all(rq, -ENODEV);
 			continue;
 		}
 
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 1002afdfee99..0952e0503aa4 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -754,6 +754,11 @@ static int attempt_merge(struct request_queue *q, struct request *req,
 	/* owner-ship of bio passed from next to req */
 	next->bio = NULL;
 	__blk_put_request(q, next);
+
+	/* FIXME: MQ+sched holds a reference */
+	if (q->mq_ops && q->elevator)
+		blk_queue_exit(q);
+
 	return 1;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 90db5b490df9..335c37787ac7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -821,6 +821,146 @@ static inline unsigned int queued_to_index(unsigned int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
 
+static void rq_copy(struct request *rq, struct request *src)
+{
+#define FIELD_COPY(dst, src, name)	((dst)->name = (src)->name)
+	FIELD_COPY(rq, src, cpu);
+	FIELD_COPY(rq, src, cmd_type);
+	FIELD_COPY(rq, src, cmd_flags);
+	rq->rq_flags |= (src->rq_flags & (RQF_PREEMPT | RQF_QUIET | RQF_PM | RQF_DONTPREP));
+	rq->rq_flags &= ~RQF_IO_STAT;
+	FIELD_COPY(rq, src, __data_len);
+	FIELD_COPY(rq, src, __sector);
+	FIELD_COPY(rq, src, bio);
+	FIELD_COPY(rq, src, biotail);
+	FIELD_COPY(rq, src, rq_disk);
+	FIELD_COPY(rq, src, part);
+	FIELD_COPY(rq, src, nr_phys_segments);
+#if defined(CONFIG_BLK_DEV_INTEGRITY)
+	FIELD_COPY(rq, src, nr_integrity_segments);
+#endif
+	FIELD_COPY(rq, src, ioprio);
+	FIELD_COPY(rq, src, timeout);
+
+	if (src->cmd_type == REQ_TYPE_BLOCK_PC) {
+		FIELD_COPY(rq, src, cmd);
+		FIELD_COPY(rq, src, cmd_len);
+		FIELD_COPY(rq, src, extra_len);
+		FIELD_COPY(rq, src, sense_len);
+		FIELD_COPY(rq, src, resid_len);
+		FIELD_COPY(rq, src, sense);
+		FIELD_COPY(rq, src, retries);
+	}
+
+	src->bio = src->biotail = NULL;
+}
+
+static void sched_rq_end_io(struct request *rq, int error)
+{
+	struct request *sched_rq = rq->end_io_data;
+	struct request_queue *q = rq->q;
+	unsigned long flags;
+
+	FIELD_COPY(sched_rq, rq, resid_len);
+	FIELD_COPY(sched_rq, rq, extra_len);
+	FIELD_COPY(sched_rq, rq, sense_len);
+	FIELD_COPY(sched_rq, rq, errors);
+	FIELD_COPY(sched_rq, rq, retries);
+
+	spin_lock_irqsave(q->queue_lock, flags);
+	blk_finish_request(sched_rq, error);
+	spin_unlock_irqrestore(q->queue_lock, flags);
+
+	blk_mq_free_request(rq);
+	blk_mq_start_stopped_hw_queues(q, true);
+}
+
+/*
+ * Pull off the elevator dispatch list and send it to the driver. Note that
+ * we have to transform the fake requests into real requests
+ */
+static void blk_mq_sched_dispatch(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
+	struct request *rq, *sched_rq;
+	struct blk_mq_alloc_data alloc_data;
+	struct blk_mq_queue_data bd;
+	int queued = 0, ret;
+
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
+		return;
+
+	hctx->run++;
+
+again:
+	rq = NULL;
+	if (!list_empty(&hctx->dispatch)) {
+		spin_lock_irq(&hctx->lock);
+		if (!list_empty(&hctx->dispatch)) {
+			rq = list_first_entry(&hctx->dispatch, struct request, queuelist);
+			list_del_init(&rq->queuelist);
+		}
+		spin_unlock_irq(&hctx->lock);
+	}
+
+	if (!rq) {
+		alloc_data.q = q;
+		alloc_data.flags = BLK_MQ_REQ_NOWAIT;
+		alloc_data.ctx = blk_mq_get_ctx(q);
+		alloc_data.hctx = hctx;
+
+		rq = __blk_mq_alloc_request(&alloc_data, 0);
+		blk_mq_put_ctx(alloc_data.ctx);
+
+		if (!rq) {
+			blk_mq_stop_hw_queue(hctx);
+			return;
+		}
+
+		spin_lock_irq(q->queue_lock);
+		sched_rq = blk_fetch_request(q);
+		spin_unlock_irq(q->queue_lock);
+
+		if (!sched_rq) {
+			blk_queue_enter_live(q);
+			__blk_mq_free_request(hctx, alloc_data.ctx, rq);
+			return;
+		}
+
+		rq_copy(rq, sched_rq);
+		rq->end_io = sched_rq_end_io;
+		rq->end_io_data = sched_rq;
+	}
+
+	bd.rq = rq;
+	bd.list = NULL;
+	bd.last = true;
+
+	ret = q->mq_ops->queue_rq(hctx, &bd);
+	switch (ret) {
+	case BLK_MQ_RQ_QUEUE_OK:
+		queued++;
+		break;
+	case BLK_MQ_RQ_QUEUE_BUSY:
+		spin_lock_irq(&hctx->lock);
+		list_add_tail(&rq->queuelist, &hctx->dispatch);
+		spin_unlock_irq(&hctx->lock);
+		blk_mq_stop_hw_queue(hctx);
+		break;
+	default:
+		pr_err("blk-mq: bad return on queue: %d\n", ret);
+	case BLK_MQ_RQ_QUEUE_ERROR:
+		rq->errors = -EIO;
+		blk_mq_end_request(rq, rq->errors);
+		break;
+	}
+
+	if (ret != BLK_MQ_RQ_QUEUE_BUSY)
+		goto again;
+
+	hctx->dispatched[queued_to_index(queued)]++;
+}
+
 /*
  * Run this hardware queue, pulling any software queues mapped to it in.
  * Note that this function currently has various problems around ordering
@@ -938,11 +1078,17 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		rcu_read_lock();
-		blk_mq_process_rq_list(hctx);
+		if (!hctx->queue->elevator)
+			blk_mq_process_rq_list(hctx);
+		else
+			blk_mq_sched_dispatch(hctx);
 		rcu_read_unlock();
 	} else {
 		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
-		blk_mq_process_rq_list(hctx);
+		if (!hctx->queue->elevator)
+			blk_mq_process_rq_list(hctx);
+		else
+			blk_mq_sched_dispatch(hctx);
 		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
 	}
 }
@@ -992,18 +1138,27 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 	kblockd_schedule_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work);
 }
 
+static inline bool hctx_pending_io(struct request_queue *q,
+				   struct blk_mq_hw_ctx *hctx)
+{
+	/*
+	 * For the pure MQ case, we have pending IO if any of the software
+	 * queues are loaded, or we have residual dispatch. If we have
+	 * an IO scheduler attached, we don't know for sure. So just say
+	 * yes, to ensure the queue runs.
+	 */
+	return blk_mq_hctx_has_pending(hctx) ||
+		!list_empty_careful(&hctx->dispatch) || q->elevator;
+}
+
 void blk_mq_run_hw_queues(struct request_queue *q, bool async)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
-		if ((!blk_mq_hctx_has_pending(hctx) &&
-		    list_empty_careful(&hctx->dispatch)) ||
-		    blk_mq_hctx_stopped(hctx))
-			continue;
-
-		blk_mq_run_hw_queue(hctx, async);
+		if (hctx_pending_io(q, hctx))
+			blk_mq_run_hw_queue(hctx, async);
 	}
 }
 EXPORT_SYMBOL(blk_mq_run_hw_queues);
@@ -1448,12 +1603,14 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = bio->bi_opf & (REQ_PREFLUSH | REQ_FUA);
+	const bool can_merge = !blk_queue_nomerges(q) && bio_mergeable(bio);
 	struct blk_plug *plug;
 	unsigned int request_count = 0;
 	struct blk_mq_alloc_data data;
 	struct request *rq;
 	blk_qc_t cookie;
 	unsigned int wb_acct;
+	int where = ELEVATOR_INSERT_SORT;
 
 	blk_queue_bounce(q, &bio);
 
@@ -1464,18 +1621,64 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 
 	blk_queue_split(q, &bio, q->bio_split);
 
-	if (!is_flush_fua && !blk_queue_nomerges(q)) {
+	if (!is_flush_fua && can_merge) {
 		if (blk_attempt_plug_merge(q, bio, &request_count, NULL))
 			return BLK_QC_T_NONE;
 	} else
 		request_count = blk_plug_queued_count(q);
 
+	/*
+	 * Set some defaults - we have just one hardware queue, so
+	 * we don't have to explicitly map it.
+	 */
+	data.hctx = q->queue_hw_ctx[0];
+	data.ctx = NULL;
+
+	if (q->elevator && can_merge) {
+		int el_ret;
+
+		spin_lock_irq(q->queue_lock);
+
+		el_ret = elv_merge(q, &rq, bio);
+		if (el_ret == ELEVATOR_BACK_MERGE) {
+			if (bio_attempt_back_merge(q, rq, bio)) {
+				elv_bio_merged(q, rq, bio);
+				if (!attempt_back_merge(q, rq))
+					elv_merged_request(q, rq, el_ret);
+				goto elv_unlock;
+			}
+		} else if (el_ret == ELEVATOR_FRONT_MERGE) {
+			if (bio_attempt_front_merge(q, rq, bio)) {
+				elv_bio_merged(q, rq, bio);
+				if (!attempt_front_merge(q, rq))
+					elv_merged_request(q, rq, el_ret);
+				goto elv_unlock;
+			}
+		}
+
+		spin_unlock_irq(q->queue_lock);
+	}
+
 	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
 
-	rq = blk_mq_map_request(q, bio, &data);
-	if (unlikely(!rq)) {
-		__wbt_done(q->rq_wb, wb_acct);
-		return BLK_QC_T_NONE;
+	if (!q->elevator) {
+		rq = blk_mq_map_request(q, bio, &data);
+		if (unlikely(!rq)) {
+			__wbt_done(q->rq_wb, wb_acct);
+			return BLK_QC_T_NONE;
+		}
+	} else {
+		blk_queue_enter_live(q);
+		spin_lock_irq(q->queue_lock);
+		rq = get_request(q, bio->bi_opf, bio, GFP_NOIO);
+		if (IS_ERR(rq)) {
+			spin_unlock_irq(q->queue_lock);
+			blk_queue_exit(q);
+			__wbt_done(q->rq_wb, wb_acct);
+			goto elv_unlock;
+		}
+
+		init_request_from_bio(rq, bio);
 	}
 
 	wbt_track(&rq->issue_stat, wb_acct);
@@ -1483,6 +1686,11 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	cookie = blk_tag_to_qc_t(rq->tag, data.hctx->queue_num);
 
 	if (unlikely(is_flush_fua)) {
+		if (q->elevator) {
+			init_request_from_bio(rq, bio);
+			where = ELEVATOR_INSERT_FLUSH;
+			goto elv_insert;
+		}
 		blk_mq_bio_to_request(rq, bio);
 		blk_insert_flush(rq);
 		goto run_queue;
@@ -1495,6 +1703,7 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	 */
 	plug = current->plug;
 	if (plug) {
+		struct list_head *plug_list = blk_get_plug_list(q, plug);
 		struct request *last = NULL;
 
 		blk_mq_bio_to_request(rq, bio);
@@ -1503,14 +1712,15 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 		 * @request_count may become stale because of schedule
 		 * out, so check the list again.
 		 */
-		if (list_empty(&plug->mq_list))
+		if (list_empty(plug_list))
 			request_count = 0;
 		if (!request_count)
 			trace_block_plug(q);
 		else
-			last = list_entry_rq(plug->mq_list.prev);
+			last = list_entry_rq(plug_list->prev);
 
-		blk_mq_put_ctx(data.ctx);
+		if (data.ctx)
+			blk_mq_put_ctx(data.ctx);
 
 		if (request_count >= BLK_MAX_REQUEST_COUNT || (last &&
 		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
@@ -1518,10 +1728,21 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 			trace_block_plug(q);
 		}
 
-		list_add_tail(&rq->queuelist, &plug->mq_list);
+		list_add_tail(&rq->queuelist, plug_list);
 		return cookie;
 	}
 
+	if (q->elevator) {
+elv_insert:
+		blk_account_io_start(rq, true);
+		spin_lock_irq(q->queue_lock);
+		__elv_add_request(q, rq, where);
+elv_unlock:
+		spin_unlock_irq(q->queue_lock);
+		blk_mq_run_hw_queue(data.hctx, !is_sync || is_flush_fua);
+		return BLK_QC_T_NONE;
+	}
+
 	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
 		/*
 		 * For a SYNC request, send it to the hardware immediately. For
@@ -2085,6 +2306,35 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	blk_mq_sysfs_register(q);
 }
 
+static int blk_sq_sched_init(struct request_queue *q)
+{
+	int ret;
+
+	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, 0);
+	if (!q->fq)
+		goto fail;
+
+	if (blk_init_rl(&q->root_rl, q, GFP_KERNEL))
+		goto fail;
+
+	mutex_lock(&q->sysfs_lock);
+	ret = elevator_init(q, "deadline");
+	mutex_unlock(&q->sysfs_lock);
+
+	if (ret) {
+		blk_exit_rl(&q->root_rl);
+		goto fail;
+	}
+
+	q->queue_lock = &q->queue_hw_ctx[0]->lock;
+	printk(KERN_ERR "blk-mq: sq sched init success\n");
+	return 0;
+fail:
+	printk(KERN_ERR "blk-mq: sq sched init failed\n");
+	blk_free_flush_queue(q->fq);
+	return 1;
+}
+
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
@@ -2124,9 +2374,13 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	if (q->nr_hw_queues > 1)
 		blk_queue_make_request(q, blk_mq_make_request);
-	else
+	else {
 		blk_queue_make_request(q, blk_sq_make_request);
 
+		if (set->flags & BLK_MQ_F_SQ_SCHED)
+			blk_sq_sched_init(q);
+	}
+
 	/*
 	 * Do this after blk_queue_make_request() overrides it...
 	 */
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 706b27bd73a1..f3a11d4de4e6 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -896,7 +896,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_wb_init(q);
 
-	if (!q->request_fn)
+	if (!q->elevator)
 		return 0;
 
 	ret = elv_register_queue(q);
diff --git a/block/blk.h b/block/blk.h
index 094fc10429c3..3137ff09725e 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -77,6 +77,9 @@ bool __blk_end_bidi_request(struct request *rq, int error,
 			    unsigned int nr_bytes, unsigned int bidi_bytes);
 void blk_freeze_queue(struct request_queue *q);
 
+struct request *get_request(struct request_queue *, unsigned int, struct bio *,
+				gfp_t);
+
 static inline void blk_queue_enter_live(struct request_queue *q)
 {
 	/*
@@ -110,6 +113,7 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 			    unsigned int *request_count,
 			    struct request **same_queue_rq);
 unsigned int blk_plug_queued_count(struct request_queue *q);
+struct list_head *blk_get_plug_list(struct request_queue *, struct blk_plug *);
 
 void blk_account_io_start(struct request *req, bool new_io);
 void blk_account_io_completion(struct request *req, unsigned int bytes);
diff --git a/block/elevator.c b/block/elevator.c
index 11d2cfee2bc1..c62974ef1052 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1002,18 +1002,21 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 ssize_t elv_iosched_show(struct request_queue *q, char *name)
 {
 	struct elevator_queue *e = q->elevator;
-	struct elevator_type *elv;
+	struct elevator_type *elv = NULL;
 	struct elevator_type *__e;
 	int len = 0;
 
-	if (!q->elevator || !blk_queue_stackable(q))
+	if (!blk_queue_stackable(q))
 		return sprintf(name, "none\n");
 
-	elv = e->type;
+	if (!q->elevator)
+		len += sprintf(name+len, "[none] ");
+	else
+		elv = e->type;
 
 	spin_lock(&elv_list_lock);
 	list_for_each_entry(__e, &elv_list, list) {
-		if (!strcmp(elv->elevator_name, __e->elevator_name))
+		if (elv && !strcmp(elv->elevator_name, __e->elevator_name))
 			len += sprintf(name+len, "[%s] ", elv->elevator_name);
 		else
 			len += sprintf(name+len, "%s ", __e->elevator_name);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 35a0af5ede6d..485d922b3fe6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -151,6 +151,7 @@ enum {
 	BLK_MQ_F_SG_MERGE	= 1 << 2,
 	BLK_MQ_F_DEFER_ISSUE	= 1 << 4,
 	BLK_MQ_F_BLOCKING	= 1 << 5,
+	BLK_MQ_F_SQ_SCHED	= 1 << 6,
 	BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
 	BLK_MQ_F_ALLOC_POLICY_BITS = 1,
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ebeef2b79c5a..a8c580f806cc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -120,6 +120,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_HASHED		((__force req_flags_t)(1 << 16))
 /* IO stats tracking on */
 #define RQF_STATS		((__force req_flags_t)(1 << 17))
+/* rl based request on MQ queue */
+#define RQF_MQ_RL		((__force req_flags_t)(1 << 18))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.7.4
