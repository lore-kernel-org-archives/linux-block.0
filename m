Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:49714 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933843AbcJTNMg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 09:12:36 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 6/7] block: better op and flags encoding
Date: Thu, 20 Oct 2016 15:12:14 +0200
Message-Id: <1476969135-32732-7-git-send-email-hch@lst.de>
In-Reply-To: <1476969135-32732-1-git-send-email-hch@lst.de>
References: <1476969135-32732-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now that we don't need the common flags to overflow outside the range
of a 32-bit type we can encode them the same way for both the bio and
request fields.  This in addition allows us to place the operation
first (and make some room for more ops while we're at it) and to
stop having to shift around the operation values.

In addition this allows passing around only one value in the block layer
instead of two (and eventuall also in the file systems, but we can do
that later) and thus clean up a lot of code.

Last but not least this allows decreasing the size of the cmd_flags
field in struct request to 32-bits.  Various functions passing this
value could also be updated, but I'd like to avoid the churn for now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/biodoc.txt |  4 +-
 block/blk-core.c               | 60 ++++++++++--------------------
 block/blk-flush.c              |  2 +-
 block/blk-lib.c                |  2 +-
 block/blk-map.c                |  2 +
 block/blk-mq.c                 | 28 ++++++--------
 block/cfq-iosched.c            | 66 ++++++++++++++++-----------------
 block/elevator.c               |  4 +-
 drivers/md/dm-crypt.c          |  2 +-
 drivers/scsi/sd.c              |  3 +-
 fs/btrfs/inode.c               |  5 +--
 fs/buffer.c                    |  2 +-
 fs/f2fs/f2fs.h                 |  2 +-
 fs/gfs2/lops.c                 |  2 +-
 include/linux/blk-cgroup.h     | 11 +++---
 include/linux/blk_types.h      | 83 +++++++++++++++++++-----------------------
 include/linux/blkdev.h         | 26 +------------
 include/linux/blktrace_api.h   |  2 +-
 include/linux/dm-io.h          |  2 +-
 include/linux/elevator.h       |  4 +-
 include/trace/events/bcache.h  | 12 ++----
 include/trace/events/block.h   | 31 ++++++----------
 kernel/trace/blktrace.c        | 14 +++----
 23 files changed, 148 insertions(+), 221 deletions(-)

diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index 6acea16..01ddeaf 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -553,8 +553,8 @@ struct request {
 	struct request_list *rl;
 }
 	
-See the rq_flag_bits definitions for an explanation of the various flags
-available. Some bits are used by the block layer or i/o scheduler.
+See the req_ops and req_flag_bits definitions for an explanation of the various
+flags available. Some bits are used by the block layer or i/o scheduler.
 	
 The behaviour of the various sector counts are almost the same as before,
 except that since we have multi-segment bios, current_nr_sectors refers
diff --git a/block/blk-core.c b/block/blk-core.c
index fd41665..0bfaa54 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1056,8 +1056,7 @@ static struct io_context *rq_ioc(struct bio *bio)
 /**
  * __get_request - get a free request
  * @rl: request list to allocate from
- * @op: REQ_OP_READ/REQ_OP_WRITE
- * @op_flags: rq_flag_bits
+ * @op: operation and flags
  * @bio: bio to allocate request for (can be %NULL)
  * @gfp_mask: allocation mask
  *
@@ -1068,23 +1067,22 @@ static struct io_context *rq_ioc(struct bio *bio)
  * Returns ERR_PTR on failure, with @q->queue_lock held.
  * Returns request pointer on success, with @q->queue_lock *not held*.
  */
-static struct request *__get_request(struct request_list *rl, int op,
-				     int op_flags, struct bio *bio,
-				     gfp_t gfp_mask)
+static struct request *__get_request(struct request_list *rl, unsigned int op,
+		struct bio *bio, gfp_t gfp_mask)
 {
 	struct request_queue *q = rl->q;
 	struct request *rq;
 	struct elevator_type *et = q->elevator->type;
 	struct io_context *ioc = rq_ioc(bio);
 	struct io_cq *icq = NULL;
-	const bool is_sync = rw_is_sync(op, op_flags) != 0;
+	const bool is_sync = op_is_sync(op);
 	int may_queue;
 	req_flags_t rq_flags = RQF_ALLOCED;
 
 	if (unlikely(blk_queue_dying(q)))
 		return ERR_PTR(-ENODEV);
 
-	may_queue = elv_may_queue(q, op, op_flags);
+	may_queue = elv_may_queue(q, op);
 	if (may_queue == ELV_MQUEUE_NO)
 		goto rq_starved;
 
@@ -1154,7 +1152,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 
 	blk_rq_init(q, rq);
 	blk_rq_set_rl(rq, rl);
-	req_set_op_attrs(rq, op, op_flags);
+	rq->cmd_flags = op;
 	rq->rq_flags = rq_flags;
 
 	/* init elvpriv */
@@ -1232,8 +1230,7 @@ static struct request *__get_request(struct request_list *rl, int op,
 /**
  * get_request - get a free request
  * @q: request_queue to allocate request from
- * @op: REQ_OP_READ/REQ_OP_WRITE
- * @op_flags: rq_flag_bits
+ * @op: operation and flags
  * @bio: bio to allocate request for (can be %NULL)
  * @gfp_mask: allocation mask
  *
@@ -1244,18 +1241,17 @@ static struct request *__get_request(struct request_list *rl, int op,
  * Returns ERR_PTR on failure, with @q->queue_lock held.
  * Returns request pointer on success, with @q->queue_lock *not held*.
  */
-static struct request *get_request(struct request_queue *q, int op,
-				   int op_flags, struct bio *bio,
-				   gfp_t gfp_mask)
+static struct request *get_request(struct request_queue *q, unsigned int op,
+		struct bio *bio, gfp_t gfp_mask)
 {
-	const bool is_sync = rw_is_sync(op, op_flags) != 0;
+	const bool is_sync = op_is_sync(op);
 	DEFINE_WAIT(wait);
 	struct request_list *rl;
 	struct request *rq;
 
 	rl = blk_get_rl(q, bio);	/* transferred to @rq on success */
 retry:
-	rq = __get_request(rl, op, op_flags, bio, gfp_mask);
+	rq = __get_request(rl, op, bio, gfp_mask);
 	if (!IS_ERR(rq))
 		return rq;
 
@@ -1297,7 +1293,7 @@ static struct request *blk_old_get_request(struct request_queue *q, int rw,
 	create_io_context(gfp_mask, q->node);
 
 	spin_lock_irq(q->queue_lock);
-	rq = get_request(q, rw, 0, NULL, gfp_mask);
+	rq = get_request(q, rw, NULL, gfp_mask);
 	if (IS_ERR(rq)) {
 		spin_unlock_irq(q->queue_lock);
 		return rq;
@@ -1446,7 +1442,7 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 	 */
 	if (rq_flags & RQF_ALLOCED) {
 		struct request_list *rl = blk_rq_rl(req);
-		bool sync = rw_is_sync(req_op(req), req->cmd_flags);
+		bool sync = op_is_sync(req->cmd_flags);
 
 		BUG_ON(!list_empty(&req->queuelist));
 		BUG_ON(ELV_ON_HASH(req));
@@ -1652,8 +1648,6 @@ unsigned int blk_plug_queued_count(struct request_queue *q)
 void init_request_from_bio(struct request *req, struct bio *bio)
 {
 	req->cmd_type = REQ_TYPE_FS;
-
-	req->cmd_flags |= bio->bi_opf & REQ_COMMON_MASK;
 	if (bio->bi_opf & REQ_RAHEAD)
 		req->cmd_flags |= REQ_FAILFAST_MASK;
 
@@ -1665,9 +1659,8 @@ void init_request_from_bio(struct request *req, struct bio *bio)
 
 static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 {
-	const bool sync = !!(bio->bi_opf & REQ_SYNC);
 	struct blk_plug *plug;
-	int el_ret, rw_flags = 0, where = ELEVATOR_INSERT_SORT;
+	int el_ret, where = ELEVATOR_INSERT_SORT;
 	struct request *req;
 	unsigned int request_count = 0;
 
@@ -1723,23 +1716,10 @@ static blk_qc_t blk_queue_bio(struct request_queue *q, struct bio *bio)
 
 get_rq:
 	/*
-	 * This sync check and mask will be re-done in init_request_from_bio(),
-	 * but we need to set it earlier to expose the sync flag to the
-	 * rq allocator and io schedulers.
-	 */
-	if (sync)
-		rw_flags |= REQ_SYNC;
-
-	/*
-	 * Add in META/PRIO flags, if set, before we get to the IO scheduler
-	 */
-	rw_flags |= (bio->bi_opf & (REQ_META | REQ_PRIO));
-
-	/*
 	 * Grab a free request. This is might sleep but can not fail.
 	 * Returns with the queue unlocked.
 	 */
-	req = get_request(q, bio_data_dir(bio), rw_flags, bio, GFP_NOIO);
+	req = get_request(q, bio->bi_opf, bio, GFP_NOIO);
 	if (IS_ERR(req)) {
 		bio->bi_error = PTR_ERR(req);
 		bio_endio(bio);
@@ -2946,8 +2926,6 @@ EXPORT_SYMBOL_GPL(__blk_end_request_err);
 void blk_rq_bio_prep(struct request_queue *q, struct request *rq,
 		     struct bio *bio)
 {
-	req_set_op(rq, bio_op(bio));
-
 	if (bio_has_data(bio))
 		rq->nr_phys_segments = bio_phys_segments(q, bio);
 
@@ -3031,8 +3009,7 @@ EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
 static void __blk_rq_prep_clone(struct request *dst, struct request *src)
 {
 	dst->cpu = src->cpu;
-	req_set_op_attrs(dst, req_op(src),
-			 (src->cmd_flags & REQ_CLONE_MASK) | REQ_NOMERGE);
+	dst->cmd_flags = src->cmd_flags | REQ_NOMERGE;
 	dst->cmd_type = src->cmd_type;
 	dst->__sector = blk_rq_pos(src);
 	dst->__data_len = blk_rq_bytes(src);
@@ -3537,8 +3514,11 @@ EXPORT_SYMBOL(blk_set_runtime_active);
 
 int __init blk_dev_init(void)
 {
-	BUILD_BUG_ON(__REQ_NR_BITS > 8 *
+	BUILD_BUG_ON(REQ_OP_LAST >= (1 << REQ_OP_BITS));
+	BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
 			FIELD_SIZEOF(struct request, cmd_flags));
+	BUILD_BUG_ON(REQ_OP_BITS + REQ_FLAG_BITS > 8 *
+			FIELD_SIZEOF(struct bio, bi_opf));
 
 	/* used for unplugging and affects IO latency/throughput - HIGHPRI */
 	kblockd_workqueue = alloc_workqueue("kblockd",
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3990b9c..95f1d4d 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -330,7 +330,7 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 	}
 
 	flush_rq->cmd_type = REQ_TYPE_FS;
-	req_set_op_attrs(flush_rq, REQ_OP_FLUSH, WRITE_FLUSH);
+	flush_rq->cmd_flags = REQ_OP_FLUSH | WRITE_FLUSH;
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->rq_disk = first_rq->rq_disk;
 	flush_rq->end_io = flush_end_io;
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 46fe924..18abda8 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -29,7 +29,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
 	unsigned int granularity;
-	enum req_op op;
+	unsigned int op;
 	int alignment;
 	sector_t bs_mask;
 
diff --git a/block/blk-map.c b/block/blk-map.c
index 2c5ae5f..0173a72 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -16,6 +16,8 @@
 int blk_rq_append_bio(struct request *rq, struct bio *bio)
 {
 	if (!rq->bio) {
+		rq->cmd_flags &= REQ_OP_MASK;
+		rq->cmd_flags |= (bio->bi_opf & REQ_OP_MASK);
 		blk_rq_bio_prep(rq->q, rq, bio);
 	} else {
 		if (!ll_back_merge_fn(rq->q, rq, bio))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 297646d..271beb3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -139,14 +139,13 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 EXPORT_SYMBOL(blk_mq_can_queue);
 
 static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
-			       struct request *rq, int op,
-			       unsigned int op_flags)
+			       struct request *rq, unsigned int op)
 {
 	INIT_LIST_HEAD(&rq->queuelist);
 	/* csd/requeue_work/fifo_time is initialized before use */
 	rq->q = q;
 	rq->mq_ctx = ctx;
-	req_set_op_attrs(rq, op, op_flags);
+	rq->cmd_flags = op;
 	if (blk_queue_io_stat(q))
 		rq->rq_flags |= RQF_IO_STAT;
 	/* do not touch atomic flags, it needs atomic ops against the timer */
@@ -183,11 +182,11 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	rq->end_io_data = NULL;
 	rq->next_rq = NULL;
 
-	ctx->rq_dispatched[rw_is_sync(op, op_flags)]++;
+	ctx->rq_dispatched[op_is_sync(op)]++;
 }
 
 static struct request *
-__blk_mq_alloc_request(struct blk_mq_alloc_data *data, int op, int op_flags)
+__blk_mq_alloc_request(struct blk_mq_alloc_data *data, unsigned int op)
 {
 	struct request *rq;
 	unsigned int tag;
@@ -202,7 +201,7 @@ __blk_mq_alloc_request(struct blk_mq_alloc_data *data, int op, int op_flags)
 		}
 
 		rq->tag = tag;
-		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op, op_flags);
+		blk_mq_rq_ctx_init(data->q, data->ctx, rq, op);
 		return rq;
 	}
 
@@ -225,7 +224,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 	ctx = blk_mq_get_ctx(q);
 	hctx = blk_mq_map_queue(q, ctx->cpu);
 	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
-	rq = __blk_mq_alloc_request(&alloc_data, rw, 0);
+	rq = __blk_mq_alloc_request(&alloc_data, rw);
 	blk_mq_put_ctx(ctx);
 
 	if (!rq) {
@@ -277,7 +276,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
 
 	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
-	rq = __blk_mq_alloc_request(&alloc_data, rw, 0);
+	rq = __blk_mq_alloc_request(&alloc_data, rw);
 	if (!rq) {
 		ret = -EWOULDBLOCK;
 		goto out_queue_exit;
@@ -1201,20 +1200,15 @@ static struct request *blk_mq_map_request(struct request_queue *q,
 	struct blk_mq_hw_ctx *hctx;
 	struct blk_mq_ctx *ctx;
 	struct request *rq;
-	int op = bio_data_dir(bio);
-	int op_flags = 0;
 	struct blk_mq_alloc_data alloc_data;
 
 	blk_queue_enter_live(q);
 	ctx = blk_mq_get_ctx(q);
 	hctx = blk_mq_map_queue(q, ctx->cpu);
 
-	if (rw_is_sync(bio_op(bio), bio->bi_opf))
-		op_flags |= REQ_SYNC;
-
-	trace_block_getrq(q, bio, op);
+	trace_block_getrq(q, bio, bio->bi_opf);
 	blk_mq_set_alloc_data(&alloc_data, q, 0, ctx, hctx);
-	rq = __blk_mq_alloc_request(&alloc_data, op, op_flags);
+	rq = __blk_mq_alloc_request(&alloc_data, bio->bi_opf);
 
 	hctx->queued++;
 	data->hctx = hctx;
@@ -1264,7 +1258,7 @@ static int blk_mq_direct_issue_request(struct request *rq, blk_qc_t *cookie)
  */
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
-	const int is_sync = rw_is_sync(bio_op(bio), bio->bi_opf);
+	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = bio->bi_opf & (REQ_PREFLUSH | REQ_FUA);
 	struct blk_map_ctx data;
 	struct request *rq;
@@ -1358,7 +1352,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
  */
 static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 {
-	const int is_sync = rw_is_sync(bio_op(bio), bio->bi_opf);
+	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = bio->bi_opf & (REQ_PREFLUSH | REQ_FUA);
 	struct blk_plug *plug;
 	unsigned int request_count = 0;
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 5e24d88..c96186a 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -667,10 +667,10 @@ static inline void cfqg_put(struct cfq_group *cfqg)
 } while (0)
 
 static inline void cfqg_stats_update_io_add(struct cfq_group *cfqg,
-					    struct cfq_group *curr_cfqg, int op,
-					    int op_flags)
+					    struct cfq_group *curr_cfqg,
+					    unsigned int op)
 {
-	blkg_rwstat_add(&cfqg->stats.queued, op, op_flags, 1);
+	blkg_rwstat_add(&cfqg->stats.queued, op, 1);
 	cfqg_stats_end_empty_time(&cfqg->stats);
 	cfqg_stats_set_start_group_wait_time(cfqg, curr_cfqg);
 }
@@ -684,30 +684,29 @@ static inline void cfqg_stats_update_timeslice_used(struct cfq_group *cfqg,
 #endif
 }
 
-static inline void cfqg_stats_update_io_remove(struct cfq_group *cfqg, int op,
-					       int op_flags)
+static inline void cfqg_stats_update_io_remove(struct cfq_group *cfqg,
+					       unsigned int op)
 {
-	blkg_rwstat_add(&cfqg->stats.queued, op, op_flags, -1);
+	blkg_rwstat_add(&cfqg->stats.queued, op, -1);
 }
 
-static inline void cfqg_stats_update_io_merged(struct cfq_group *cfqg, int op,
-					       int op_flags)
+static inline void cfqg_stats_update_io_merged(struct cfq_group *cfqg,
+					       unsigned int op)
 {
-	blkg_rwstat_add(&cfqg->stats.merged, op, op_flags, 1);
+	blkg_rwstat_add(&cfqg->stats.merged, op, 1);
 }
 
 static inline void cfqg_stats_update_completion(struct cfq_group *cfqg,
-			uint64_t start_time, uint64_t io_start_time, int op,
-			int op_flags)
+			uint64_t start_time, uint64_t io_start_time,
+			unsigned int op)
 {
 	struct cfqg_stats *stats = &cfqg->stats;
 	unsigned long long now = sched_clock();
 
 	if (time_after64(now, io_start_time))
-		blkg_rwstat_add(&stats->service_time, op, op_flags,
-				now - io_start_time);
+		blkg_rwstat_add(&stats->service_time, op, now - io_start_time);
 	if (time_after64(io_start_time, start_time))
-		blkg_rwstat_add(&stats->wait_time, op, op_flags,
+		blkg_rwstat_add(&stats->wait_time, op,
 				io_start_time - start_time);
 }
 
@@ -786,16 +785,16 @@ static inline void cfqg_put(struct cfq_group *cfqg) { }
 #define cfq_log_cfqg(cfqd, cfqg, fmt, args...)		do {} while (0)
 
 static inline void cfqg_stats_update_io_add(struct cfq_group *cfqg,
-			struct cfq_group *curr_cfqg, int op, int op_flags) { }
+			struct cfq_group *curr_cfqg, unsigned int op) { }
 static inline void cfqg_stats_update_timeslice_used(struct cfq_group *cfqg,
 			uint64_t time, unsigned long unaccounted_time) { }
-static inline void cfqg_stats_update_io_remove(struct cfq_group *cfqg, int op,
-			int op_flags) { }
-static inline void cfqg_stats_update_io_merged(struct cfq_group *cfqg, int op,
-			int op_flags) { }
+static inline void cfqg_stats_update_io_remove(struct cfq_group *cfqg,
+			unsigned int op) { }
+static inline void cfqg_stats_update_io_merged(struct cfq_group *cfqg,
+			unsigned int op) { }
 static inline void cfqg_stats_update_completion(struct cfq_group *cfqg,
-			uint64_t start_time, uint64_t io_start_time, int op,
-			int op_flags) { }
+			uint64_t start_time, uint64_t io_start_time,
+			unsigned int op) { }
 
 #endif	/* CONFIG_CFQ_GROUP_IOSCHED */
 
@@ -2474,10 +2473,10 @@ static void cfq_reposition_rq_rb(struct cfq_queue *cfqq, struct request *rq)
 {
 	elv_rb_del(&cfqq->sort_list, rq);
 	cfqq->queued[rq_is_sync(rq)]--;
-	cfqg_stats_update_io_remove(RQ_CFQG(rq), req_op(rq), rq->cmd_flags);
+	cfqg_stats_update_io_remove(RQ_CFQG(rq), rq->cmd_flags);
 	cfq_add_rq_rb(rq);
 	cfqg_stats_update_io_add(RQ_CFQG(rq), cfqq->cfqd->serving_group,
-				 req_op(rq), rq->cmd_flags);
+				 rq->cmd_flags);
 }
 
 static struct request *
@@ -2530,7 +2529,7 @@ static void cfq_remove_request(struct request *rq)
 	cfq_del_rq_rb(rq);
 
 	cfqq->cfqd->rq_queued--;
-	cfqg_stats_update_io_remove(RQ_CFQG(rq), req_op(rq), rq->cmd_flags);
+	cfqg_stats_update_io_remove(RQ_CFQG(rq), rq->cmd_flags);
 	if (rq->cmd_flags & REQ_PRIO) {
 		WARN_ON(!cfqq->prio_pending);
 		cfqq->prio_pending--;
@@ -2565,7 +2564,7 @@ static void cfq_merged_request(struct request_queue *q, struct request *req,
 static void cfq_bio_merged(struct request_queue *q, struct request *req,
 				struct bio *bio)
 {
-	cfqg_stats_update_io_merged(RQ_CFQG(req), bio_op(bio), bio->bi_opf);
+	cfqg_stats_update_io_merged(RQ_CFQG(req), bio->bi_opf);
 }
 
 static void
@@ -2588,7 +2587,7 @@ cfq_merged_requests(struct request_queue *q, struct request *rq,
 	if (cfqq->next_rq == next)
 		cfqq->next_rq = rq;
 	cfq_remove_request(next);
-	cfqg_stats_update_io_merged(RQ_CFQG(rq), req_op(next), next->cmd_flags);
+	cfqg_stats_update_io_merged(RQ_CFQG(rq), next->cmd_flags);
 
 	cfqq = RQ_CFQQ(next);
 	/*
@@ -4142,7 +4141,7 @@ static void cfq_insert_request(struct request_queue *q, struct request *rq)
 	rq->fifo_time = ktime_get_ns() + cfqd->cfq_fifo_expire[rq_is_sync(rq)];
 	list_add_tail(&rq->queuelist, &cfqq->fifo);
 	cfq_add_rq_rb(rq);
-	cfqg_stats_update_io_add(RQ_CFQG(rq), cfqd->serving_group, req_op(rq),
+	cfqg_stats_update_io_add(RQ_CFQG(rq), cfqd->serving_group,
 				 rq->cmd_flags);
 	cfq_rq_enqueued(cfqd, cfqq, rq);
 }
@@ -4240,8 +4239,7 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 	cfqq->dispatched--;
 	(RQ_CFQG(rq))->dispatched--;
 	cfqg_stats_update_completion(cfqq->cfqg, rq_start_time_ns(rq),
-				     rq_io_start_time_ns(rq), req_op(rq),
-				     rq->cmd_flags);
+				     rq_io_start_time_ns(rq), rq->cmd_flags);
 
 	cfqd->rq_in_flight[cfq_cfqq_sync(cfqq)]--;
 
@@ -4319,14 +4317,14 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 		cfq_schedule_dispatch(cfqd);
 }
 
-static void cfqq_boost_on_prio(struct cfq_queue *cfqq, int op_flags)
+static void cfqq_boost_on_prio(struct cfq_queue *cfqq, unsigned int op)
 {
 	/*
 	 * If REQ_PRIO is set, boost class and prio level, if it's below
 	 * BE/NORM. If prio is not set, restore the potentially boosted
 	 * class/prio level.
 	 */
-	if (!(op_flags & REQ_PRIO)) {
+	if (!(op & REQ_PRIO)) {
 		cfqq->ioprio_class = cfqq->org_ioprio_class;
 		cfqq->ioprio = cfqq->org_ioprio;
 	} else {
@@ -4347,7 +4345,7 @@ static inline int __cfq_may_queue(struct cfq_queue *cfqq)
 	return ELV_MQUEUE_MAY;
 }
 
-static int cfq_may_queue(struct request_queue *q, int op, int op_flags)
+static int cfq_may_queue(struct request_queue *q, unsigned int op)
 {
 	struct cfq_data *cfqd = q->elevator->elevator_data;
 	struct task_struct *tsk = current;
@@ -4364,10 +4362,10 @@ static int cfq_may_queue(struct request_queue *q, int op, int op_flags)
 	if (!cic)
 		return ELV_MQUEUE_MAY;
 
-	cfqq = cic_to_cfqq(cic, rw_is_sync(op, op_flags));
+	cfqq = cic_to_cfqq(cic, op_is_sync(op));
 	if (cfqq) {
 		cfq_init_prio_data(cfqq, cic);
-		cfqq_boost_on_prio(cfqq, op_flags);
+		cfqq_boost_on_prio(cfqq, op);
 
 		return __cfq_may_queue(cfqq);
 	}
diff --git a/block/elevator.c b/block/elevator.c
index ac80f89..a18a5db 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -714,12 +714,12 @@ void elv_put_request(struct request_queue *q, struct request *rq)
 		e->type->ops.elevator_put_req_fn(rq);
 }
 
-int elv_may_queue(struct request_queue *q, int op, int op_flags)
+int elv_may_queue(struct request_queue *q, unsigned int op)
 {
 	struct elevator_queue *e = q->elevator;
 
 	if (e->type->ops.elevator_may_queue_fn)
-		return e->type->ops.elevator_may_queue_fn(q, op, op_flags);
+		return e->type->ops.elevator_may_queue_fn(q, op);
 
 	return ELV_MQUEUE_MAY;
 }
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index a276883..68a9eb4 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1135,7 +1135,7 @@ static void clone_init(struct dm_crypt_io *io, struct bio *clone)
 	clone->bi_private = io;
 	clone->bi_end_io  = crypt_endio;
 	clone->bi_bdev    = cc->dev->bdev;
-	bio_set_op_attrs(clone, bio_op(io->base_bio), bio_flags(io->base_bio));
+	clone->bi_opf	  = io->base_bio->bi_opf;
 }
 
 static int kcryptd_io_read(struct dm_crypt_io *io, gfp_t gfp)
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cef1f78..65738b0 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1031,8 +1031,7 @@ static int sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 	} else if (rq_data_dir(rq) == READ) {
 		SCpnt->cmnd[0] = READ_6;
 	} else {
-		scmd_printk(KERN_ERR, SCpnt, "Unknown command %llu,%llx\n",
-			    req_op(rq), (unsigned long long) rq->cmd_flags);
+		scmd_printk(KERN_ERR, SCpnt, "Unknown command %d\n", req_op(rq));
 		goto out;
 	}
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2b790bd..9a37707 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8427,7 +8427,7 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip,
 	if (!bio)
 		return -ENOMEM;
 
-	bio_set_op_attrs(bio, bio_op(orig_bio), bio_flags(orig_bio));
+	bio->bi_opf = orig_bio->bi_opf;
 	bio->bi_private = dip;
 	bio->bi_end_io = btrfs_end_dio_bio;
 	btrfs_io_bio(bio)->logical = file_offset;
@@ -8465,8 +8465,7 @@ static int btrfs_submit_direct_hook(struct btrfs_dio_private *dip,
 						  start_sector, GFP_NOFS);
 			if (!bio)
 				goto out_err;
-			bio_set_op_attrs(bio, bio_op(orig_bio),
-					 bio_flags(orig_bio));
+			bio->bi_opf = orig_bio->bi_opf;
 			bio->bi_private = dip;
 			bio->bi_end_io = btrfs_end_dio_bio;
 			btrfs_io_bio(bio)->logical = file_offset;
diff --git a/fs/buffer.c b/fs/buffer.c
index b205a62..a293358 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3118,7 +3118,7 @@ EXPORT_SYMBOL(submit_bh);
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
  * @op: whether to %READ or %WRITE
- * @op_flags: rq_flag_bits
+ * @op_flags: req_flag_bits
  * @nr: number of &struct buffer_heads in the array
  * @bhs: array of pointers to &struct buffer_head
  *
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9e8de18..2cf4f7f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -688,7 +688,7 @@ struct f2fs_io_info {
 	struct f2fs_sb_info *sbi;	/* f2fs_sb_info pointer */
 	enum page_type type;	/* contains DATA/NODE/META/META_FLUSH */
 	int op;			/* contains REQ_OP_ */
-	int op_flags;		/* rq_flag_bits */
+	int op_flags;		/* req_flag_bits */
 	block_t new_blkaddr;	/* new block address to be written */
 	block_t old_blkaddr;	/* old block address before Cow */
 	struct page *page;	/* page to be written */
diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 49d5a1b..b1f9144 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -231,7 +231,7 @@ static void gfs2_end_log_write(struct bio *bio)
  * gfs2_log_flush_bio - Submit any pending log bio
  * @sdp: The superblock
  * @op: REQ_OP
- * @op_flags: rq_flag_bits
+ * @op_flags: req_flag_bits
  *
  * Submit any pending part-built or full bio to the block device. If
  * there is no pending bio, then this is a no-op.
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 3bf5d33..ddaf28d 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -581,15 +581,14 @@ static inline void blkg_rwstat_exit(struct blkg_rwstat *rwstat)
 /**
  * blkg_rwstat_add - add a value to a blkg_rwstat
  * @rwstat: target blkg_rwstat
- * @op: REQ_OP
- * @op_flags: rq_flag_bits
+ * @op: REQ_OP and flags
  * @val: value to add
  *
  * Add @val to @rwstat.  The counters are chosen according to @rw.  The
  * caller is responsible for synchronizing calls to this function.
  */
 static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
-				   int op, int op_flags, uint64_t val)
+				   unsigned int op, uint64_t val)
 {
 	struct percpu_counter *cnt;
 
@@ -600,7 +599,7 @@ static inline void blkg_rwstat_add(struct blkg_rwstat *rwstat,
 
 	__percpu_counter_add(cnt, val, BLKG_STAT_CPU_BATCH);
 
-	if (op_flags & REQ_SYNC)
+	if (op & REQ_SYNC)
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_SYNC];
 	else
 		cnt = &rwstat->cpu_cnt[BLKG_RWSTAT_ASYNC];
@@ -705,9 +704,9 @@ static inline bool blkcg_bio_issue_check(struct request_queue *q,
 
 	if (!throtl) {
 		blkg = blkg ?: q->root_blkg;
-		blkg_rwstat_add(&blkg->stat_bytes, bio_op(bio), bio->bi_opf,
+		blkg_rwstat_add(&blkg->stat_bytes, bio->bi_opf,
 				bio->bi_iter.bi_size);
-		blkg_rwstat_add(&blkg->stat_ios, bio_op(bio), bio->bi_opf, 1);
+		blkg_rwstat_add(&blkg->stat_ios, bio->bi_opf, 1);
 	}
 
 	rcu_read_unlock();
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ec69a8f..dca972d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -88,24 +88,6 @@ struct bio {
 	struct bio_vec		bi_inline_vecs[0];
 };
 
-#define BIO_OP_SHIFT	(8 * FIELD_SIZEOF(struct bio, bi_opf) - REQ_OP_BITS)
-#define bio_flags(bio)	((bio)->bi_opf & ((1 << BIO_OP_SHIFT) - 1))
-#define bio_op(bio)	((bio)->bi_opf >> BIO_OP_SHIFT)
-
-#define bio_set_op_attrs(bio, op, op_flags) do {			\
-	if (__builtin_constant_p(op))					\
-		BUILD_BUG_ON((op) + 0U >= (1U << REQ_OP_BITS));		\
-	else								\
-		WARN_ON_ONCE((op) + 0U >= (1U << REQ_OP_BITS));		\
-	if (__builtin_constant_p(op_flags))				\
-		BUILD_BUG_ON((op_flags) + 0U >= (1U << BIO_OP_SHIFT));	\
-	else								\
-		WARN_ON_ONCE((op_flags) + 0U >= (1U << BIO_OP_SHIFT));	\
-	(bio)->bi_opf = bio_flags(bio);					\
-	(bio)->bi_opf |= (((op) + 0U) << BIO_OP_SHIFT);			\
-	(bio)->bi_opf |= (op_flags);					\
-} while (0)
-
 #define BIO_RESET_BYTES		offsetof(struct bio, bi_max_vecs)
 
 /*
@@ -147,26 +129,40 @@ struct bio {
 #endif /* CONFIG_BLOCK */
 
 /*
- * Request flags.  For use in the cmd_flags field of struct request, and in
- * bi_opf of struct bio.  Note that some flags are only valid in either one.
+ * Operations and flags common to the bio and request structures.
+ * We use 8 bits for encoding the operation, and the remaining 24 for flags.
  */
-enum rq_flag_bits {
-	/* common flags */
-	__REQ_FAILFAST_DEV,	/* no driver retries of device errors */
+#define REQ_OP_BITS	8
+#define REQ_OP_MASK	((1 << REQ_OP_BITS) - 1)
+#define REQ_FLAG_BITS	24
+
+enum req_opf {
+	REQ_OP_READ,
+	REQ_OP_WRITE,
+	REQ_OP_DISCARD,		/* request to discard sectors */
+	REQ_OP_SECURE_ERASE,	/* request to securely erase sectors */
+	REQ_OP_WRITE_SAME,	/* write same block many times */
+	REQ_OP_FLUSH,		/* request for cache flush */
+	REQ_OP_ZONE_REPORT,	/* Get zone information */
+	REQ_OP_ZONE_RESET,	/* Reset a zone write pointer */
+
+	REQ_OP_LAST,
+};
+
+enum req_flag_bits {
+	__REQ_FAILFAST_DEV =	/* no driver retries of device errors */
+		REQ_OP_BITS,
 	__REQ_FAILFAST_TRANSPORT, /* no driver retries of transport errors */
 	__REQ_FAILFAST_DRIVER,	/* no driver retries of driver errors */
-
 	__REQ_SYNC,		/* request is sync (sync write or read) */
 	__REQ_META,		/* metadata io request */
 	__REQ_PRIO,		/* boost priority in cfq */
-
 	__REQ_NOMERGE,		/* don't touch this for merging */
 	__REQ_NOIDLE,		/* don't anticipate more IO after this one */
 	__REQ_INTEGRITY,	/* I/O includes block integrity payload */
 	__REQ_FUA,		/* forced unit access */
 	__REQ_PREFLUSH,		/* request for cache flush */
 	__REQ_RAHEAD,		/* read ahead, can fail anytime */
-
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -176,37 +172,32 @@ enum rq_flag_bits {
 #define REQ_SYNC		(1ULL << __REQ_SYNC)
 #define REQ_META		(1ULL << __REQ_META)
 #define REQ_PRIO		(1ULL << __REQ_PRIO)
+#define REQ_NOMERGE		(1ULL << __REQ_NOMERGE)
 #define REQ_NOIDLE		(1ULL << __REQ_NOIDLE)
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
+#define REQ_FUA			(1ULL << __REQ_FUA)
+#define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
+#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
-#define REQ_COMMON_MASK \
-	(REQ_FAILFAST_MASK | REQ_SYNC | REQ_META | REQ_PRIO | REQ_NOIDLE | \
-	 REQ_PREFLUSH | REQ_FUA | REQ_INTEGRITY | REQ_NOMERGE | REQ_RAHEAD)
-#define REQ_CLONE_MASK		REQ_COMMON_MASK
 
-/* This mask is used for both bio and request merge checking */
 #define REQ_NOMERGE_FLAGS \
 	(REQ_NOMERGE | REQ_PREFLUSH | REQ_FUA)
 
-#define REQ_RAHEAD		(1ULL << __REQ_RAHEAD)
-#define REQ_FUA			(1ULL << __REQ_FUA)
-#define REQ_NOMERGE		(1ULL << __REQ_NOMERGE)
-#define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
+#define bio_op(bio) \
+	((bio)->bi_opf & REQ_OP_MASK)
+#define req_op(req) \
+	((req)->cmd_flags & REQ_OP_MASK)
 
-enum req_op {
-	REQ_OP_READ,
-	REQ_OP_WRITE,
-	REQ_OP_DISCARD,		/* request to discard sectors */
-	REQ_OP_SECURE_ERASE,	/* request to securely erase sectors */
-	REQ_OP_WRITE_SAME,	/* write same block many times */
-	REQ_OP_FLUSH,		/* request for cache flush */
-	REQ_OP_ZONE_REPORT,	/* Get zone information */
-	REQ_OP_ZONE_RESET,	/* Reset a zone write pointer */
-};
+/* obsolete, don't use in new code */
+#define bio_set_op_attrs(bio, op, op_flags) \
+	((bio)->bi_opf |= (op | op_flags))
 
-#define REQ_OP_BITS 3
+static inline bool op_is_sync(unsigned int op)
+{
+	return (op & REQ_OP_MASK) == REQ_OP_READ || (op & REQ_SYNC);
+}
 
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE	-1U
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b4415fe..8396da2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -142,7 +142,7 @@ struct request {
 
 	int cpu;
 	unsigned cmd_type;
-	u64 cmd_flags;
+	unsigned int cmd_flags;		/* op and common flags */
 	req_flags_t rq_flags;
 	unsigned long atomic_flags;
 
@@ -244,20 +244,6 @@ struct request {
 	struct request *next_rq;
 };
 
-#define REQ_OP_SHIFT (8 * sizeof(u64) - REQ_OP_BITS)
-#define req_op(req)  ((req)->cmd_flags >> REQ_OP_SHIFT)
-
-#define req_set_op(req, op) do {				\
-	WARN_ON(op >= (1 << REQ_OP_BITS));			\
-	(req)->cmd_flags &= ((1ULL << REQ_OP_SHIFT) - 1);	\
-	(req)->cmd_flags |= ((u64) (op) << REQ_OP_SHIFT);	\
-} while (0)
-
-#define req_set_op_attrs(req, op, flags) do {	\
-	req_set_op(req, op);			\
-	(req)->cmd_flags |= flags;		\
-} while (0)
-
 static inline unsigned short req_get_ioprio(struct request *req)
 {
 	return req->ioprio;
@@ -741,17 +727,9 @@ static inline unsigned int blk_queue_zone_size(struct request_queue *q)
 	return blk_queue_is_zoned(q) ? q->limits.chunk_sectors : 0;
 }
 
-/*
- * We regard a request as sync, if either a read or a sync write
- */
-static inline bool rw_is_sync(int op, unsigned int rw_flags)
-{
-	return op == REQ_OP_READ || (rw_flags & REQ_SYNC);
-}
-
 static inline bool rq_is_sync(struct request *rq)
 {
-	return rw_is_sync(req_op(rq), rq->cmd_flags);
+	return op_is_sync(rq->cmd_flags);
 }
 
 static inline bool blk_rl_full(struct request_list *rl, bool sync)
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index cceb72f..e417f08 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -118,7 +118,7 @@ static inline int blk_cmd_buf_len(struct request *rq)
 }
 
 extern void blk_dump_cmd(char *buf, struct request *rq);
-extern void blk_fill_rwbs(char *rwbs, int op, u32 rw, int bytes);
+extern void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes);
 
 #endif /* CONFIG_EVENT_TRACING && CONFIG_BLOCK */
 
diff --git a/include/linux/dm-io.h b/include/linux/dm-io.h
index b91b023..a52c658 100644
--- a/include/linux/dm-io.h
+++ b/include/linux/dm-io.h
@@ -58,7 +58,7 @@ struct dm_io_notify {
 struct dm_io_client;
 struct dm_io_request {
 	int bi_op;			/* REQ_OP */
-	int bi_op_flags;		/* rq_flag_bits */
+	int bi_op_flags;		/* req_flag_bits */
 	struct dm_io_memory mem;	/* Memory to use for io */
 	struct dm_io_notify notify;	/* Synchronous if notify.fn is NULL */
 	struct dm_io_client *client;	/* Client memory handler */
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index e7f358d..f219c9a 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -30,7 +30,7 @@ typedef int (elevator_dispatch_fn) (struct request_queue *, int);
 typedef void (elevator_add_req_fn) (struct request_queue *, struct request *);
 typedef struct request *(elevator_request_list_fn) (struct request_queue *, struct request *);
 typedef void (elevator_completed_req_fn) (struct request_queue *, struct request *);
-typedef int (elevator_may_queue_fn) (struct request_queue *, int, int);
+typedef int (elevator_may_queue_fn) (struct request_queue *, unsigned int);
 
 typedef void (elevator_init_icq_fn) (struct io_cq *);
 typedef void (elevator_exit_icq_fn) (struct io_cq *);
@@ -139,7 +139,7 @@ extern struct request *elv_former_request(struct request_queue *, struct request
 extern struct request *elv_latter_request(struct request_queue *, struct request *);
 extern int elv_register_queue(struct request_queue *q);
 extern void elv_unregister_queue(struct request_queue *q);
-extern int elv_may_queue(struct request_queue *, int, int);
+extern int elv_may_queue(struct request_queue *, unsigned int);
 extern void elv_completed_request(struct request_queue *, struct request *);
 extern int elv_set_request(struct request_queue *q, struct request *rq,
 			   struct bio *bio, gfp_t gfp_mask);
diff --git a/include/trace/events/bcache.h b/include/trace/events/bcache.h
index d336b89..df3e9ae 100644
--- a/include/trace/events/bcache.h
+++ b/include/trace/events/bcache.h
@@ -27,8 +27,7 @@ DECLARE_EVENT_CLASS(bcache_request,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->orig_sector	= bio->bi_iter.bi_sector - 16;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 	),
 
 	TP_printk("%d,%d %s %llu + %u (from %d,%d @ %llu)",
@@ -102,8 +101,7 @@ DECLARE_EVENT_CLASS(bcache_bio,
 		__entry->dev		= bio->bi_bdev->bd_dev;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 	),
 
 	TP_printk("%d,%d  %s %llu + %u",
@@ -138,8 +136,7 @@ TRACE_EVENT(bcache_read,
 		__entry->dev		= bio->bi_bdev->bd_dev;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 		__entry->cache_hit = hit;
 		__entry->bypass = bypass;
 	),
@@ -170,8 +167,7 @@ TRACE_EVENT(bcache_write,
 		__entry->inode		= inode;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio->bi_iter.bi_size >> 9;
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 		__entry->writeback = writeback;
 		__entry->bypass = bypass;
 	),
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 8f3a163..3e02e3a 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -84,8 +84,7 @@ DECLARE_EVENT_CLASS(block_rq_with_error,
 					0 : blk_rq_sectors(rq);
 		__entry->errors    = rq->errors;
 
-		blk_fill_rwbs(__entry->rwbs, req_op(rq), rq->cmd_flags,
-			      blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
 		blk_dump_cmd(__get_str(cmd), rq);
 	),
 
@@ -163,7 +162,7 @@ TRACE_EVENT(block_rq_complete,
 		__entry->nr_sector = nr_bytes >> 9;
 		__entry->errors    = rq->errors;
 
-		blk_fill_rwbs(__entry->rwbs, req_op(rq), rq->cmd_flags, nr_bytes);
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, nr_bytes);
 		blk_dump_cmd(__get_str(cmd), rq);
 	),
 
@@ -199,8 +198,7 @@ DECLARE_EVENT_CLASS(block_rq,
 		__entry->bytes     = (rq->cmd_type == REQ_TYPE_BLOCK_PC) ?
 					blk_rq_bytes(rq) : 0;
 
-		blk_fill_rwbs(__entry->rwbs, req_op(rq), rq->cmd_flags,
-			      blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
 		blk_dump_cmd(__get_str(cmd), rq);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
@@ -274,8 +272,7 @@ TRACE_EVENT(block_bio_bounce,
 					  bio->bi_bdev->bd_dev : 0;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -313,8 +310,7 @@ TRACE_EVENT(block_bio_complete,
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->error		= error;
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 	),
 
 	TP_printk("%d,%d %s %llu + %u [%d]",
@@ -341,8 +337,7 @@ DECLARE_EVENT_CLASS(block_bio_merge,
 		__entry->dev		= bio->bi_bdev->bd_dev;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -409,8 +404,7 @@ TRACE_EVENT(block_bio_queue,
 		__entry->dev		= bio->bi_bdev->bd_dev;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -438,7 +432,7 @@ DECLARE_EVENT_CLASS(block_get_rq,
 		__entry->dev		= bio ? bio->bi_bdev->bd_dev : 0;
 		__entry->sector		= bio ? bio->bi_iter.bi_sector : 0;
 		__entry->nr_sector	= bio ? bio_sectors(bio) : 0;
-		blk_fill_rwbs(__entry->rwbs, bio ? bio_op(bio) : 0,
+		blk_fill_rwbs(__entry->rwbs,
 			      bio ? bio->bi_opf : 0, __entry->nr_sector);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
         ),
@@ -573,8 +567,7 @@ TRACE_EVENT(block_split,
 		__entry->dev		= bio->bi_bdev->bd_dev;
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->new_sector	= new_sector;
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
@@ -617,8 +610,7 @@ TRACE_EVENT(block_bio_remap,
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
-		blk_fill_rwbs(__entry->rwbs, bio_op(bio), bio->bi_opf,
-			      bio->bi_iter.bi_size);
+		blk_fill_rwbs(__entry->rwbs, bio->bi_opf, bio->bi_iter.bi_size);
 	),
 
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",
@@ -664,8 +656,7 @@ TRACE_EVENT(block_rq_remap,
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
 		__entry->nr_bios	= blk_rq_count_bios(rq);
-		blk_fill_rwbs(__entry->rwbs, req_op(rq), rq->cmd_flags,
-			      blk_rq_bytes(rq));
+		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags, blk_rq_bytes(rq));
 	),
 
 	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %u",
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index dbafc5d..95cecbf 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1777,14 +1777,14 @@ void blk_dump_cmd(char *buf, struct request *rq)
 	}
 }
 
-void blk_fill_rwbs(char *rwbs, int op, u32 rw, int bytes)
+void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes)
 {
 	int i = 0;
 
-	if (rw & REQ_PREFLUSH)
+	if (op & REQ_PREFLUSH)
 		rwbs[i++] = 'F';
 
-	switch (op) {
+	switch (op & REQ_OP_MASK) {
 	case REQ_OP_WRITE:
 	case REQ_OP_WRITE_SAME:
 		rwbs[i++] = 'W';
@@ -1806,13 +1806,13 @@ void blk_fill_rwbs(char *rwbs, int op, u32 rw, int bytes)
 		rwbs[i++] = 'N';
 	}
 
-	if (rw & REQ_FUA)
+	if (op & REQ_FUA)
 		rwbs[i++] = 'F';
-	if (rw & REQ_RAHEAD)
+	if (op & REQ_RAHEAD)
 		rwbs[i++] = 'A';
-	if (rw & REQ_SYNC)
+	if (op & REQ_SYNC)
 		rwbs[i++] = 'S';
-	if (rw & REQ_META)
+	if (op & REQ_META)
 		rwbs[i++] = 'M';
 
 	rwbs[i] = '\0';
-- 
2.1.4

