Return-Path: <prvs=1147fe7fca=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 6/7] blk-mq: test patch to get legacy IO schedulers working
Date: Mon, 5 Dec 2016 11:27:05 -0700
Message-ID: <1480962426-15767-7-git-send-email-axboe@fb.com>
In-Reply-To: <1480962426-15767-1-git-send-email-axboe@fb.com>
References: <1480962426-15767-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

With this applied, a single queue blk-mq manage device can use
any of the legacy IO schedulers. This is exposed through Kconfig,
exposing MQ scheduler choices. Like with the legacy devices,
the IO scheduler can be runtime switched by echoing something else
into:

/sys/block/</dev>/queue/scheduler

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/Kconfig.iosched  |  29 +++++
 block/blk-core.c       |  44 ++++---
 block/blk-merge.c      |   5 +
 block/blk-mq.c         | 330 ++++++++++++++++++++++++++++++++++++++++++++++---
 block/blk-mq.h         |   1 +
 block/blk-sysfs.c      |   2 +-
 block/blk.h            |   4 +
 block/elevator.c       | 120 ++++++++++++------
 include/linux/blkdev.h |   2 +
 9 files changed, 469 insertions(+), 68 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 421bef9c4c48..50de4589f38e 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -63,6 +63,35 @@ config DEFAULT_IOSCHED
 	default "cfq" if DEFAULT_CFQ
 	default "noop" if DEFAULT_NOOP
 
+choice
+	prompt "Default I/O scheduler for MQ devices"
+	default DEFAULT_MQ_SCHED_NONE
+	help
+	  Select the I/O scheduler which will be used by default for all
+	  multiqueue block devices. Note that this only applies for
+	  multiqueue devies that expose a single queue.
+
+	config DEFAULT_MQ_SCHED_NONE
+		bool "None"
+
+	config DEFAULT_MQ_DEADLINE
+		bool "Deadline" if IOSCHED_DEADLINE=y
+
+	config DEFAULT_MQ_CFQ
+		bool "CFQ" if IOSCHED_CFQ=y
+
+	config DEFAULT_MQ_NOOP
+		bool "No-op"
+
+endchoice
+
+config DEFAULT_MQ_IOSCHED
+	string
+	default "deadline" if DEFAULT_MQ_DEADLINE
+	default "cfq" if DEFAULT_MQ_CFQ
+	default "noop" if DEFAULT_MQ_NOOP
+	default "none" if DEFAULT_MQ_SCHED_NONE
+
 endmenu
 
 endif
diff --git a/block/blk-core.c b/block/blk-core.c
index f0aa810a5fe2..8be12ba91f8e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1160,6 +1160,14 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 	rq->cmd_flags = op;
 	rq->rq_flags = rq_flags;
 
+	/*
+	 * If we're allocating a legacy request off the MQ path, mark
+	 * the request as such. This is so that the free path does the
+	 * right thing.
+	 */
+	if (q->mq_ops)
+		rq->rq_flags |= RQF_MQ_RL;
+
 	/* init elvpriv */
 	if (rq_flags & RQF_ELVPRIV) {
 		if (unlikely(et->icq_cache && !icq)) {
@@ -1246,8 +1254,8 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
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
@@ -1430,7 +1438,7 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 	if (unlikely(!q))
 		return;
 
-	if (q->mq_ops) {
+	if (q->mq_ops && !(req->rq_flags & RQF_MQ_RL)) {
 		blk_mq_free_request(req);
 		return;
 	}
@@ -1466,7 +1474,7 @@ void blk_put_request(struct request *req)
 {
 	struct request_queue *q = req->q;
 
-	if (q->mq_ops)
+	if (q->mq_ops && !(req->rq_flags & RQF_MQ_RL))
 		blk_mq_free_request(req);
 	else {
 		unsigned long flags;
@@ -1556,6 +1564,15 @@ bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
 	return true;
 }
 
+struct list_head *blk_get_plug_list(struct request_queue *q,
+				    struct blk_plug *plug)
+{
+	if (!blk_use_sched_path(q))
+		return &plug->mq_list;
+
+	return &plug->list;
+}
+
 /**
  * blk_attempt_plug_merge - try to merge with %current's plugged list
  * @q: request_queue new bio is being queued at
@@ -1592,10 +1609,7 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
 		goto out;
 	*request_count = 0;
 
-	if (q->mq_ops)
-		plug_list = &plug->mq_list;
-	else
-		plug_list = &plug->list;
+	plug_list = blk_get_plug_list(q, plug);
 
 	list_for_each_entry_reverse(rq, plug_list, queuelist) {
 		int el_ret;
@@ -1640,10 +1654,7 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 	if (!plug)
 		goto out;
 
-	if (q->mq_ops)
-		plug_list = &plug->mq_list;
-	else
-		plug_list = &plug->list;
+	plug_list = blk_get_plug_list(q, plug);
 
 	list_for_each_entry(rq, plug_list, queuelist) {
 		if (rq->q == q)
@@ -3198,7 +3209,9 @@ static void queue_unplugged(struct request_queue *q, unsigned int depth,
 {
 	trace_block_unplug(q, depth, !from_schedule);
 
-	if (from_schedule)
+	if (q->mq_ops)
+		blk_mq_run_hw_queues(q, true);
+	else if (from_schedule)
 		blk_run_queue_async(q);
 	else
 		__blk_run_queue(q);
@@ -3294,7 +3307,10 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
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
index 90db5b490df9..b6b6dd9590f6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -821,6 +821,151 @@ static inline unsigned int queued_to_index(unsigned int queued)
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
+	LIST_HEAD(rq_list);
+	int queued = 0, ret;
+
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
+		return;
+
+	flush_busy_ctxs(hctx, &rq_list);
+
+	hctx->run++;
+
+again:
+	rq = NULL;
+	if (!list_empty(&hctx->dispatch) || !list_empty(&rq_list)) {
+		spin_lock_irq(&hctx->lock);
+		if (!list_empty(&rq_list))
+			list_splice_tail_init(&rq_list, &hctx->dispatch);
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
+			goto done;
+		}
+
+		spin_lock_irq(q->queue_lock);
+		sched_rq = blk_fetch_request(q);
+		spin_unlock_irq(q->queue_lock);
+
+		if (!sched_rq) {
+			blk_mq_put_tag(hctx, alloc_data.ctx, rq->tag);
+			goto done;
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
+done:
+	hctx->dispatched[queued_to_index(queued)]++;
+}
+
 /*
  * Run this hardware queue, pulling any software queues mapped to it in.
  * Note that this function currently has various problems around ordering
@@ -938,11 +1083,17 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 
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
@@ -992,18 +1143,27 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
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
@@ -1448,12 +1608,15 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = bio->bi_opf & (REQ_PREFLUSH | REQ_FUA);
+	const bool can_merge = !blk_queue_nomerges(q) && bio_mergeable(bio);
+	const bool use_elevator = READ_ONCE(q->elevator);
 	struct blk_plug *plug;
 	unsigned int request_count = 0;
 	struct blk_mq_alloc_data data;
 	struct request *rq;
 	blk_qc_t cookie;
 	unsigned int wb_acct;
+	int where = ELEVATOR_INSERT_SORT;
 
 	blk_queue_bounce(q, &bio);
 
@@ -1464,18 +1627,71 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 
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
+	if (use_elevator && can_merge) {
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
+	/*
+	 * If we're not using an IO scheduler, just allocate a MQ
+	 * request/tag. If we are using an IO scheduler, use the
+	 * legacy request_list and we'll map this to an MQ request
+	 * at dispatch time.
+	 */
+	if (!use_elevator) {
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
+		data.hctx->queued++;
+		init_request_from_bio(rq, bio);
 	}
 
 	wbt_track(&rq->issue_stat, wb_acct);
@@ -1483,6 +1699,11 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	cookie = blk_tag_to_qc_t(rq->tag, data.hctx->queue_num);
 
 	if (unlikely(is_flush_fua)) {
+		if (use_elevator) {
+			init_request_from_bio(rq, bio);
+			where = ELEVATOR_INSERT_FLUSH;
+			goto elv_insert;
+		}
 		blk_mq_bio_to_request(rq, bio);
 		blk_insert_flush(rq);
 		goto run_queue;
@@ -1495,6 +1716,7 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	 */
 	plug = current->plug;
 	if (plug) {
+		struct list_head *plug_list = blk_get_plug_list(q, plug);
 		struct request *last = NULL;
 
 		blk_mq_bio_to_request(rq, bio);
@@ -1503,14 +1725,15 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
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
@@ -1518,10 +1741,21 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 			trace_block_plug(q);
 		}
 
-		list_add_tail(&rq->queuelist, &plug->mq_list);
+		list_add_tail(&rq->queuelist, plug_list);
 		return cookie;
 	}
 
+	if (use_elevator) {
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
@@ -2085,6 +2319,64 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	blk_mq_sysfs_register(q);
 }
 
+int blk_mq_sched_init(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx = q->queue_hw_ctx[0];
+
+	if (q->nr_hw_queues > 1)
+		return -EINVAL;
+	if (hctx->flags & BLK_MQ_F_NO_SCHED)
+		return -EINVAL;
+	if (q->fq)
+		return 0;
+
+	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, 0);
+	if (!q->fq)
+		goto fail;
+
+	if (blk_init_rl(&q->root_rl, q, GFP_KERNEL))
+		goto fail;
+
+	return 0;
+fail:
+	if (q->fq) {
+		blk_free_flush_queue(q->fq);
+		q->fq = NULL;
+	}
+	return -ENOMEM;
+}
+
+static int blk_sq_sched_init(struct request_queue *q)
+{
+	int ret;
+
+#if defined(CONFIG_DEFAULT_MQ_IOSCHED)
+	if (!strcmp("none", CONFIG_DEFAULT_MQ_IOSCHED))
+		return 0;
+#else
+	return 0;
+#endif
+
+	if (blk_mq_sched_init(q))
+		goto fail;
+
+	mutex_lock(&q->sysfs_lock);
+	ret = elevator_init(q, NULL);
+	mutex_unlock(&q->sysfs_lock);
+
+	if (ret) {
+		blk_exit_rl(&q->root_rl);
+		goto fail;
+	}
+
+	q->queue_lock = &q->queue_hw_ctx[0]->lock;
+	return 0;
+fail:
+	printk(KERN_ERR "blk-mq: sq io scheduler init failed\n");
+	blk_free_flush_queue(q->fq);
+	return 1;
+}
+
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q)
 {
@@ -2124,8 +2416,10 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 
 	if (q->nr_hw_queues > 1)
 		blk_queue_make_request(q, blk_mq_make_request);
-	else
+	else {
 		blk_queue_make_request(q, blk_sq_make_request);
+		blk_sq_sched_init(q);
+	}
 
 	/*
 	 * Do this after blk_queue_make_request() overrides it...
diff --git a/block/blk-mq.h b/block/blk-mq.h
index b444370ae05b..2b8f43fb9583 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -56,6 +56,7 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
+extern int blk_mq_sched_init(struct request_queue *q);
 
 extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
 
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
index 600e22ea62e9..758c4e7bb788 100644
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
index 11d2cfee2bc1..19fb1ea0d0fd 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -180,7 +180,7 @@ static void elevator_release(struct kobject *kobj)
 int elevator_init(struct request_queue *q, char *name)
 {
 	struct elevator_type *e = NULL;
-	int err;
+	int err = 0;
 
 	/*
 	 * q->sysfs_lock must be held to provide mutual exclusion between
@@ -215,18 +215,24 @@ int elevator_init(struct request_queue *q, char *name)
 	}
 
 	if (!e) {
-		e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
+		if (q->mq_ops)
+			e = elevator_get(CONFIG_DEFAULT_MQ_IOSCHED, false);
+		else
+			e = elevator_get(CONFIG_DEFAULT_IOSCHED, false);
 		if (!e) {
 			printk(KERN_ERR
 				"Default I/O scheduler not found. " \
-				"Using noop.\n");
-			e = elevator_get("noop", false);
+				"Using %s.\n", q->mq_ops ? "none" : "noop");
+			if (!q->mq_ops)
+				e = elevator_get("noop", false);
 		}
 	}
 
-	err = e->ops.elevator_init_fn(q, e);
-	if (err)
-		elevator_put(e);
+	if (e) {
+		err = e->ops.elevator_init_fn(q, e);
+		if (err)
+			elevator_put(e);
+	}
 	return err;
 }
 EXPORT_SYMBOL(elevator_init);
@@ -894,9 +900,14 @@ EXPORT_SYMBOL_GPL(elv_unregister);
 static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
 	struct elevator_queue *old = q->elevator;
-	bool registered = old->registered;
+	bool old_registered = false;
 	int err;
 
+	if (q->mq_ops) {
+		blk_mq_freeze_queue(q);
+		blk_mq_quiesce_queue(q);
+	}
+
 	/*
 	 * Turn on BYPASS and drain all requests w/ elevator private data.
 	 * Block layer doesn't call into a quiesced elevator - all requests
@@ -904,32 +915,49 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	 * using INSERT_BACK.  All requests have SOFTBARRIER set and no
 	 * merge happens either.
 	 */
-	blk_queue_bypass_start(q);
+	if (old) {
+		old_registered = old->registered;
+
+		if (!q->mq_ops)
+			blk_queue_bypass_start(q);
 
-	/* unregister and clear all auxiliary data of the old elevator */
-	if (registered)
-		elv_unregister_queue(q);
+		/* unregister and clear all auxiliary data of the old elevator */
+		if (old_registered)
+			elv_unregister_queue(q);
 
-	spin_lock_irq(q->queue_lock);
-	ioc_clear_queue(q);
-	spin_unlock_irq(q->queue_lock);
+		spin_lock_irq(q->queue_lock);
+		ioc_clear_queue(q);
+		spin_unlock_irq(q->queue_lock);
+	}
 
 	/* allocate, init and register new elevator */
-	err = new_e->ops.elevator_init_fn(q, new_e);
-	if (err)
-		goto fail_init;
+	if (new_e) {
+		err = new_e->ops.elevator_init_fn(q, new_e);
+		if (err)
+			goto fail_init;
 
-	if (registered) {
 		err = elv_register_queue(q);
 		if (err)
 			goto fail_register;
-	}
+	} else
+		q->elevator = NULL;
 
 	/* done, kill the old one and finish */
-	elevator_exit(old);
-	blk_queue_bypass_end(q);
+	if (old) {
+		elevator_exit(old);
+		if (!q->mq_ops)
+			blk_queue_bypass_end(q);
+	}
 
-	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	if (q->mq_ops) {
+		blk_mq_unfreeze_queue(q);
+		blk_mq_start_stopped_hw_queues(q, true);
+	}
+
+	if (new_e)
+		blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	else
+		blk_add_trace_msg(q, "elv switch: none");
 
 	return 0;
 
@@ -937,10 +965,16 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	elevator_exit(q->elevator);
 fail_init:
 	/* switch failed, restore and re-register old elevator */
-	q->elevator = old;
-	elv_register_queue(q);
-	blk_queue_bypass_end(q);
-
+	if (old) {
+		q->elevator = old;
+		elv_register_queue(q);
+		if (!q->mq_ops)
+			blk_queue_bypass_end(q);
+	}
+	if (q->mq_ops) {
+		blk_mq_unfreeze_queue(q);
+		blk_mq_start_stopped_hw_queues(q, true);
+	}
 	return err;
 }
 
@@ -952,8 +986,11 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	char elevator_name[ELV_NAME_MAX];
 	struct elevator_type *e;
 
-	if (!q->elevator)
-		return -ENXIO;
+	/*
+	 * Special case for mq, turn off scheduling
+	 */
+	if (q->mq_ops && !strncmp(name, "none", 4))
+		return elevator_switch(q, NULL);
 
 	strlcpy(elevator_name, name, sizeof(elevator_name));
 	e = elevator_get(strstrip(elevator_name), true);
@@ -962,7 +999,8 @@ static int __elevator_change(struct request_queue *q, const char *name)
 		return -EINVAL;
 	}
 
-	if (!strcmp(elevator_name, q->elevator->type->elevator_name)) {
+	if (q->elevator &&
+	    !strcmp(elevator_name, q->elevator->type->elevator_name)) {
 		elevator_put(e);
 		return 0;
 	}
@@ -988,9 +1026,15 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 {
 	int ret;
 
-	if (!q->elevator)
+	if (!q->mq_ops || q->request_fn)
 		return count;
 
+	if (q->mq_ops && !q->elevator) {
+		ret = blk_mq_sched_init(q);
+		if (ret)
+			return ret;
+	}
+
 	ret = __elevator_change(q, name);
 	if (!ret)
 		return count;
@@ -1002,24 +1046,30 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
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
 	}
 	spin_unlock(&elv_list_lock);
 
+	if (q->mq_ops && q->elevator)
+		len += sprintf(name+len, "none");
+
 	len += sprintf(len+name, "\n");
 	return len;
 }
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
