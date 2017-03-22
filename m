Return-Path: <BATV+90a41d470eb0ea9eda9a+4959+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Bart.VanAssche@sandisk.com,
	linux-block@vger.kernel.org
Subject: [PATCH 2/5] blk-mq: merge mq and sq make_request instances
Date: Wed, 22 Mar 2017 15:01:50 -0400
Message-Id: <20170322190153.12217-3-hch@lst.de>
In-Reply-To: <20170322190153.12217-1-hch@lst.de>
References: <20170322190153.12217-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

They are mostly the same code anyway - this just one small conditional
for the plug case that is different for both variants.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 164 +++++++++++----------------------------------------------
 1 file changed, 31 insertions(+), 133 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 998c041358f2..5a1ff4894285 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1475,11 +1475,6 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 	blk_mq_sched_insert_request(rq, false, true, false, may_sleep);
 }
 
-/*
- * Multiple hardware queue variant. This will not use per-process plugs,
- * but will attempt to bypass the hctx queueing if we can go straight to
- * hardware for SYNC IO.
- */
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -1531,7 +1526,36 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	}
 
 	plug = current->plug;
-	if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
+	if (plug && q->nr_hw_queues == 1) {
+		struct request *last = NULL;
+
+		blk_mq_bio_to_request(rq, bio);
+
+		/*
+		 * @request_count may become stale because of schedule
+		 * out, so check the list again.
+		 */
+		if (list_empty(&plug->mq_list))
+			request_count = 0;
+		else if (blk_queue_nomerges(q))
+			request_count = blk_plug_queued_count(q);
+
+		if (!request_count)
+			trace_block_plug(q);
+		else
+			last = list_entry_rq(plug->mq_list.prev);
+
+		blk_mq_put_ctx(data.ctx);
+
+		if (request_count >= BLK_MAX_REQUEST_COUNT || (last &&
+		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
+			blk_flush_plug_list(plug, false);
+			trace_block_plug(q);
+		}
+
+		list_add_tail(&rq->queuelist, &plug->mq_list);
+		goto done;
+	} else if (((plug && !blk_queue_nomerges(q)) || is_sync)) {
 		struct request *old_rq = NULL;
 
 		blk_mq_bio_to_request(rq, bio);
@@ -1593,119 +1617,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	return cookie;
 }
 
-/*
- * Single hardware queue variant. This will attempt to use any per-process
- * plug for merging and IO deferral.
- */
-static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
-{
-	const int is_sync = op_is_sync(bio->bi_opf);
-	const int is_flush_fua = op_is_flush(bio->bi_opf);
-	struct blk_plug *plug;
-	unsigned int request_count = 0;
-	struct blk_mq_alloc_data data = { .flags = 0 };
-	struct request *rq;
-	blk_qc_t cookie;
-	unsigned int wb_acct;
-
-	blk_queue_bounce(q, &bio);
-
-	if (bio_integrity_enabled(bio) && bio_integrity_prep(bio)) {
-		bio_io_error(bio);
-		return BLK_QC_T_NONE;
-	}
-
-	blk_queue_split(q, &bio, q->bio_split);
-
-	if (!is_flush_fua && !blk_queue_nomerges(q)) {
-		if (blk_attempt_plug_merge(q, bio, &request_count, NULL))
-			return BLK_QC_T_NONE;
-	} else
-		request_count = blk_plug_queued_count(q);
-
-	if (blk_mq_sched_bio_merge(q, bio))
-		return BLK_QC_T_NONE;
-
-	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
-
-	trace_block_getrq(q, bio, bio->bi_opf);
-
-	rq = blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
-	if (unlikely(!rq)) {
-		__wbt_done(q->rq_wb, wb_acct);
-		return BLK_QC_T_NONE;
-	}
-
-	wbt_track(&rq->issue_stat, wb_acct);
-
-	cookie = request_to_qc_t(data.hctx, rq);
-
-	if (unlikely(is_flush_fua)) {
-		if (q->elevator)
-			goto elv_insert;
-		blk_mq_bio_to_request(rq, bio);
-		blk_insert_flush(rq);
-		goto run_queue;
-	}
-
-	/*
-	 * A task plug currently exists. Since this is completely lockless,
-	 * utilize that to temporarily store requests until the task is
-	 * either done or scheduled away.
-	 */
-	plug = current->plug;
-	if (plug) {
-		struct request *last = NULL;
-
-		blk_mq_bio_to_request(rq, bio);
-
-		/*
-		 * @request_count may become stale because of schedule
-		 * out, so check the list again.
-		 */
-		if (list_empty(&plug->mq_list))
-			request_count = 0;
-		if (!request_count)
-			trace_block_plug(q);
-		else
-			last = list_entry_rq(plug->mq_list.prev);
-
-		blk_mq_put_ctx(data.ctx);
-
-		if (request_count >= BLK_MAX_REQUEST_COUNT || (last &&
-		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
-			blk_flush_plug_list(plug, false);
-			trace_block_plug(q);
-		}
-
-		list_add_tail(&rq->queuelist, &plug->mq_list);
-		return cookie;
-	}
-
-	if (q->elevator) {
-elv_insert:
-		blk_mq_put_ctx(data.ctx);
-		blk_mq_bio_to_request(rq, bio);
-		blk_mq_sched_insert_request(rq, false, true,
-						!is_sync || is_flush_fua, true);
-		goto done;
-	}
-	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
-		/*
-		 * For a SYNC request, send it to the hardware immediately. For
-		 * an ASYNC request, just ensure that we run it later on. The
-		 * latter allows for merging opportunities and more efficient
-		 * dispatching.
-		 */
-run_queue:
-		blk_mq_run_hw_queue(data.hctx, !is_sync || is_flush_fua);
-	}
-
-	blk_mq_put_ctx(data.ctx);
-done:
-	return cookie;
-}
-
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
@@ -2370,10 +2281,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->requeue_list);
 	spin_lock_init(&q->requeue_lock);
 
-	if (q->nr_hw_queues > 1)
-		blk_queue_make_request(q, blk_mq_make_request);
-	else
-		blk_queue_make_request(q, blk_sq_make_request);
+	blk_queue_make_request(q, blk_mq_make_request);
 
 	/*
 	 * Do this after blk_queue_make_request() overrides it...
@@ -2719,16 +2627,6 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 	set->nr_hw_queues = nr_hw_queues;
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
-
-		/*
-		 * Manually set the make_request_fn as blk_queue_make_request
-		 * resets a lot of the queue settings.
-		 */
-		if (q->nr_hw_queues > 1)
-			q->make_request_fn = blk_mq_make_request;
-		else
-			q->make_request_fn = blk_sq_make_request;
-
 		blk_mq_queue_reinit(q, cpu_online_mask);
 	}
 
-- 
2.11.0
