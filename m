Return-Path: <prvs=1149acddfc=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 6/7] blk-mq-sched: add framework for MQ capable IO schedulers
Date: Wed, 7 Dec 2016 16:10:00 -0700
Message-ID: <1481152201-27461-7-git-send-email-axboe@fb.com>
In-Reply-To: <1481152201-27461-1-git-send-email-axboe@fb.com>
References: <1481152201-27461-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/Makefile           |   2 +-
 block/blk-core.c         |   3 +-
 block/blk-exec.c         |   3 +-
 block/blk-flush.c        |   7 +--
 block/blk-mq-tag.c       |   1 +
 block/blk-mq.c           | 138 +++++++++++++++++++++++++----------------------
 block/blk-mq.h           |  32 +++++------
 block/elevator.c         | 132 ++++++++++++++++++++++++++++++++++-----------
 include/linux/blk-mq.h   |   2 +-
 include/linux/elevator.h |  25 ++++++++-
 10 files changed, 222 insertions(+), 123 deletions(-)

diff --git a/block/Makefile b/block/Makefile
index a827f988c4e6..2eee9e1bb6db 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-tag.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
-			blk-mq-sysfs.o blk-mq-cpumap.o ioctl.o \
+			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
 			genhd.o scsi_ioctl.o partition-generic.o ioprio.o \
 			badblocks.o partitions/
 
diff --git a/block/blk-core.c b/block/blk-core.c
index 4b7ec5958055..a6163d9bb8a6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -39,6 +39,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-sched.h"
 #include "blk-wbt.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
@@ -2173,7 +2174,7 @@ int blk_insert_cloned_request(struct request_queue *q, struct request *rq)
 	if (q->mq_ops) {
 		if (blk_queue_io_stat(q))
 			blk_account_io_start(rq, true);
-		blk_mq_insert_request(rq, false, true, false);
+		blk_mq_sched_insert_request(rq, false, true, false);
 		return 0;
 	}
 
diff --git a/block/blk-exec.c b/block/blk-exec.c
index 3ecb00a6cf45..86656fdfa637 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -9,6 +9,7 @@
 #include <linux/sched/sysctl.h>
 
 #include "blk.h"
+#include "blk-mq-sched.h"
 
 /*
  * for max sense size
@@ -65,7 +66,7 @@ void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
 	 * be reused after dying flag is set
 	 */
 	if (q->mq_ops) {
-		blk_mq_insert_request(rq, at_head, true, false);
+		blk_mq_sched_insert_request(rq, at_head, true, false);
 		return;
 	}
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 27a42dab5a36..63b91697d167 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -74,6 +74,7 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
+#include "blk-mq-sched.h"
 
 /* FLUSH/FUA sequences */
 enum {
@@ -425,9 +426,9 @@ void blk_insert_flush(struct request *rq)
 	 */
 	if ((policy & REQ_FSEQ_DATA) &&
 	    !(policy & (REQ_FSEQ_PREFLUSH | REQ_FSEQ_POSTFLUSH))) {
-		if (q->mq_ops) {
-			blk_mq_insert_request(rq, false, true, false);
-		} else
+		if (q->mq_ops)
+			blk_mq_sched_insert_request(rq, false, true, false);
+		else
 			list_add_tail(&rq->queuelist, &q->queue_head);
 		return;
 	}
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index dcf5ce3ba4bf..bbd494e23d57 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -12,6 +12,7 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
+#include "blk-mq-sched.h"
 
 bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index abbf7cca4d0d..102ef2945dfc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -32,6 +32,7 @@
 #include "blk-mq-tag.h"
 #include "blk-stat.h"
 #include "blk-wbt.h"
+#include "blk-mq-sched.h"
 
 static DEFINE_MUTEX(all_q_mutex);
 static LIST_HEAD(all_q_list);
@@ -41,7 +42,8 @@ static LIST_HEAD(all_q_list);
  */
 static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
-	return sbitmap_any_bit_set(&hctx->ctx_map);
+	return sbitmap_any_bit_set(&hctx->ctx_map) ||
+		blk_mq_sched_has_work(hctx);
 }
 
 /*
@@ -167,8 +169,8 @@ bool blk_mq_can_queue(struct blk_mq_hw_ctx *hctx)
 }
 EXPORT_SYMBOL(blk_mq_can_queue);
 
-static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
-			       struct request *rq, unsigned int op)
+void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
+			struct request *rq, unsigned int op)
 {
 	INIT_LIST_HEAD(&rq->queuelist);
 	/* csd/requeue_work/fifo_time is initialized before use */
@@ -214,8 +216,8 @@ static void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
 	ctx->rq_dispatched[op_is_sync(op)]++;
 }
 
-static struct request *
-__blk_mq_alloc_request(struct blk_mq_alloc_data *data, unsigned int op)
+struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
+				       unsigned int op)
 {
 	struct request *rq;
 	unsigned int tag;
@@ -319,12 +321,14 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
-				  struct blk_mq_ctx *ctx, struct request *rq)
+void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+			   struct request *rq)
 {
 	const int tag = rq->tag;
 	struct request_queue *q = rq->q;
 
+	blk_mq_sched_completed_request(hctx, rq);
+
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		atomic_dec(&hctx->nr_active);
 
@@ -467,6 +471,8 @@ void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
+	blk_mq_sched_started_request(rq);
+
 	trace_block_rq_issue(q, rq);
 
 	rq->resid_len = blk_rq_bytes(rq);
@@ -515,6 +521,7 @@ static void __blk_mq_requeue_request(struct request *rq)
 
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, &rq->issue_stat);
+	blk_mq_sched_requeue_request(rq);
 
 	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
 		if (q->dma_drain_size && blk_rq_bytes(rq))
@@ -549,13 +556,13 @@ static void blk_mq_requeue_work(struct work_struct *work)
 
 		rq->rq_flags &= ~RQF_SOFTBARRIER;
 		list_del_init(&rq->queuelist);
-		blk_mq_insert_request(rq, true, false, false);
+		blk_mq_sched_insert_request(rq, true, false, false);
 	}
 
 	while (!list_empty(&rq_list)) {
 		rq = list_entry(rq_list.next, struct request, queuelist);
 		list_del_init(&rq->queuelist);
-		blk_mq_insert_request(rq, false, false, false);
+		blk_mq_sched_insert_request(rq, false, false, false);
 	}
 
 	blk_mq_run_hw_queues(q, false);
@@ -761,8 +768,16 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 
 		if (!blk_rq_merge_ok(rq, bio))
 			continue;
+		if (!blk_mq_sched_allow_merge(q, rq, bio))
+			break;
 
 		el_ret = blk_try_merge(rq, bio);
+		if (el_ret == ELEVATOR_NO_MERGE)
+			continue;
+
+		if (!blk_mq_sched_allow_merge(q, rq, bio))
+			break;
+
 		if (el_ret == ELEVATOR_BACK_MERGE) {
 			if (bio_attempt_back_merge(q, rq, bio)) {
 				ctx->rq_merged++;
@@ -947,11 +962,17 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		rcu_read_lock();
-		blk_mq_process_rq_list(hctx);
+		if (hctx->queue->elevator)
+			blk_mq_sched_dispatch_requests(hctx);
+		else
+			blk_mq_process_rq_list(hctx);
 		rcu_read_unlock();
 	} else {
 		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
-		blk_mq_process_rq_list(hctx);
+		if (hctx->queue->elevator)
+			blk_mq_sched_dispatch_requests(hctx);
+		else
+			blk_mq_process_rq_list(hctx);
 		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
 	}
 }
@@ -1135,8 +1156,8 @@ static inline void __blk_mq_insert_req_list(struct blk_mq_hw_ctx *hctx,
 		list_add_tail(&rq->queuelist, &ctx->rq_list);
 }
 
-static void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx,
-				    struct request *rq, bool at_head)
+void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+			     bool at_head)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 
@@ -1144,21 +1165,6 @@ static void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx,
 	blk_mq_hctx_mark_pending(hctx, ctx);
 }
 
-void blk_mq_insert_request(struct request *rq, bool at_head, bool run_queue,
-			   bool async)
-{
-	struct blk_mq_ctx *ctx = rq->mq_ctx;
-	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
-
-	spin_lock(&ctx->lock);
-	__blk_mq_insert_request(hctx, rq, at_head);
-	spin_unlock(&ctx->lock);
-
-	if (run_queue)
-		blk_mq_run_hw_queue(hctx, async);
-}
-
 static void blk_mq_insert_requests(struct request_queue *q,
 				     struct blk_mq_ctx *ctx,
 				     struct list_head *list,
@@ -1174,17 +1180,14 @@ static void blk_mq_insert_requests(struct request_queue *q,
 	 * preemption doesn't flush plug list, so it's possible ctx->cpu is
 	 * offline now
 	 */
-	spin_lock(&ctx->lock);
 	while (!list_empty(list)) {
 		struct request *rq;
 
 		rq = list_first_entry(list, struct request, queuelist);
 		BUG_ON(rq->mq_ctx != ctx);
 		list_del_init(&rq->queuelist);
-		__blk_mq_insert_req_list(hctx, rq, false);
+		blk_mq_sched_insert_request(rq, false, false, false);
 	}
-	blk_mq_hctx_mark_pending(hctx, ctx);
-	spin_unlock(&ctx->lock);
 
 	blk_mq_run_hw_queue(hctx, from_schedule);
 }
@@ -1285,41 +1288,27 @@ static inline bool blk_mq_merge_queue_io(struct blk_mq_hw_ctx *hctx,
 	}
 }
 
-static struct request *blk_mq_map_request(struct request_queue *q,
-					  struct bio *bio,
-					  struct blk_mq_alloc_data *data)
-{
-	struct blk_mq_hw_ctx *hctx;
-	struct blk_mq_ctx *ctx;
-	struct request *rq;
-
-	blk_queue_enter_live(q);
-	ctx = blk_mq_get_ctx(q);
-	hctx = blk_mq_map_queue(q, ctx->cpu);
-
-	trace_block_getrq(q, bio, bio->bi_opf);
-	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
-	rq = __blk_mq_alloc_request(data, bio->bi_opf);
-
-	data->hctx->queued++;
-	return rq;
-}
-
 static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
 {
-	int ret;
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
 		.list = NULL,
 		.last = 1
 	};
-	blk_qc_t new_cookie = blk_tag_to_qc_t(rq->tag, hctx->queue_num);
+	struct blk_mq_hw_ctx *hctx;
+	blk_qc_t new_cookie;
+	int ret;
+
+	if (q->elevator)
+		goto insert;
 
+	hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
 	if (blk_mq_hctx_stopped(hctx))
 		goto insert;
 
+	new_cookie = blk_tag_to_qc_t(rq->tag, hctx->queue_num);
+
 	/*
 	 * For OK queue, we are done. For error, kill it. Any other
 	 * error (busy), just add it to our list as we previously
@@ -1341,7 +1330,7 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
 	}
 
 insert:
-	blk_mq_insert_request(rq, false, true, true);
+	blk_mq_sched_insert_request(rq, false, true, true);
 }
 
 /*
@@ -1374,9 +1363,14 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	    blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
 		return BLK_QC_T_NONE;
 
+	if (blk_mq_sched_bio_merge(q, bio))
+		return BLK_QC_T_NONE;
+
 	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
 
-	rq = blk_mq_map_request(q, bio, &data);
+	trace_block_getrq(q, bio, bio->bi_opf);
+
+	rq = blk_mq_sched_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
 		__wbt_done(q->rq_wb, wb_acct);
 		return BLK_QC_T_NONE;
@@ -1438,6 +1432,12 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		goto done;
 	}
 
+	if (q->elevator) {
+		blk_mq_put_ctx(data.ctx);
+		blk_mq_bio_to_request(rq, bio);
+		blk_mq_sched_insert_request(rq, false, true, true);
+		goto done;
+	}
 	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
 		/*
 		 * For a SYNC request, send it to the hardware immediately. For
@@ -1483,9 +1483,14 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	} else
 		request_count = blk_plug_queued_count(q);
 
+	if (blk_mq_sched_bio_merge(q, bio))
+		return BLK_QC_T_NONE;
+
 	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
 
-	rq = blk_mq_map_request(q, bio, &data);
+	trace_block_getrq(q, bio, bio->bi_opf);
+
+	rq = blk_mq_sched_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
 		__wbt_done(q->rq_wb, wb_acct);
 		return BLK_QC_T_NONE;
@@ -1535,6 +1540,12 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 		return cookie;
 	}
 
+	if (q->elevator) {
+		blk_mq_put_ctx(data.ctx);
+		blk_mq_bio_to_request(rq, bio);
+		blk_mq_sched_insert_request(rq, false, true, true);
+		goto done;
+	}
 	if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
 		/*
 		 * For a SYNC request, send it to the hardware immediately. For
@@ -1547,15 +1558,16 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	}
 
 	blk_mq_put_ctx(data.ctx);
+done:
 	return cookie;
 }
 
-static void blk_mq_free_rq_map(struct blk_mq_tag_set *set,
-		struct blk_mq_tags *tags, unsigned int hctx_idx)
+void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+			unsigned int hctx_idx)
 {
 	struct page *page;
 
-	if (tags->rqs && set->ops->exit_request) {
+	if (tags->rqs && set && set->ops->exit_request) {
 		int i;
 
 		for (i = 0; i < tags->nr_tags; i++) {
@@ -1588,8 +1600,8 @@ static size_t order_to_size(unsigned int order)
 	return (size_t)PAGE_SIZE << order;
 }
 
-static struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
-		unsigned int hctx_idx)
+struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
+				       unsigned int hctx_idx)
 {
 	struct blk_mq_tags *tags;
 	unsigned int i, j, entries_per_page, max_order = 4;
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 3a54dd32a6fc..9284b1e0bccb 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -84,26 +84,6 @@ static inline void blk_mq_put_ctx(struct blk_mq_ctx *ctx)
 	put_cpu();
 }
 
-struct blk_mq_alloc_data {
-	/* input parameter */
-	struct request_queue *q;
-	unsigned int flags;
-
-	/* input & output parameter */
-	struct blk_mq_ctx *ctx;
-	struct blk_mq_hw_ctx *hctx;
-};
-
-static inline void blk_mq_set_alloc_data(struct blk_mq_alloc_data *data,
-		struct request_queue *q, unsigned int flags,
-		struct blk_mq_ctx *ctx, struct blk_mq_hw_ctx *hctx)
-{
-	data->q = q;
-	data->flags = flags;
-	data->ctx = ctx;
-	data->hctx = hctx;
-}
-
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
 	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
@@ -114,4 +94,16 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
+void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
+			unsigned int hctx_idx);
+struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
+				       unsigned int hctx_idx);
+void blk_mq_rq_ctx_init(struct request_queue *q, struct blk_mq_ctx *ctx,
+			struct request *rq, unsigned int op);
+void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+			   struct request *rq);
+struct request *__blk_mq_alloc_request(struct blk_mq_alloc_data *data,
+				       unsigned int op);
+void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
+			     bool at_head);
 #endif
diff --git a/block/elevator.c b/block/elevator.c
index 40f0c04e5ad3..d6d0f76bbe51 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -40,6 +40,7 @@
 #include <trace/events/block.h>
 
 #include "blk.h"
+#include "blk-mq-sched.h"
 
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
@@ -58,7 +59,9 @@ static int elv_iosched_allow_bio_merge(struct request *rq, struct bio *bio)
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.elevator_allow_bio_merge_fn)
+	if (e->uses_mq && e->type->mq_ops.allow_merge)
+		return e->type->mq_ops.allow_merge(q, rq, bio);
+	else if (!e->uses_mq && e->type->ops.elevator_allow_bio_merge_fn)
 		return e->type->ops.elevator_allow_bio_merge_fn(q, rq, bio);
 
 	return 1;
@@ -224,7 +227,10 @@ int elevator_init(struct request_queue *q, char *name)
 		}
 	}
 
-	err = e->ops.elevator_init_fn(q, e);
+	if (e->uses_mq)
+		err = e->mq_ops.init_sched(q, e);
+	else
+		err = e->ops.elevator_init_fn(q, e);
 	if (err)
 		elevator_put(e);
 	return err;
@@ -234,7 +240,9 @@ EXPORT_SYMBOL(elevator_init);
 void elevator_exit(struct elevator_queue *e)
 {
 	mutex_lock(&e->sysfs_lock);
-	if (e->type->ops.elevator_exit_fn)
+	if (e->uses_mq && e->type->mq_ops.exit_sched)
+		e->type->mq_ops.exit_sched(e);
+	else if (!e->uses_mq && e->type->ops.elevator_exit_fn)
 		e->type->ops.elevator_exit_fn(e);
 	mutex_unlock(&e->sysfs_lock);
 
@@ -803,7 +811,8 @@ int elv_register_queue(struct request_queue *q)
 		}
 		kobject_uevent(&e->kobj, KOBJ_ADD);
 		e->registered = 1;
-		if (e->type->ops.elevator_registered_fn)
+		e->uses_mq = q->mq_ops != NULL;
+		if (!e->uses_mq && e->type->ops.elevator_registered_fn)
 			e->type->ops.elevator_registered_fn(q);
 	}
 	return error;
@@ -891,9 +900,14 @@ EXPORT_SYMBOL_GPL(elv_unregister);
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
@@ -901,32 +915,54 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	 * using INSERT_BACK.  All requests have SOFTBARRIER set and no
 	 * merge happens either.
 	 */
-	blk_queue_bypass_start(q);
+	if (old) {
+		old_registered = old->registered;
 
-	/* unregister and clear all auxiliary data of the old elevator */
-	if (registered)
-		elv_unregister_queue(q);
+		if (!q->mq_ops)
+			blk_queue_bypass_start(q);
 
-	spin_lock_irq(q->queue_lock);
-	ioc_clear_queue(q);
-	spin_unlock_irq(q->queue_lock);
+		/* unregister and clear all auxiliary data of the old elevator */
+		if (old_registered)
+			elv_unregister_queue(q);
+
+		if (q->queue_lock) {
+			spin_lock_irq(q->queue_lock);
+			ioc_clear_queue(q);
+			spin_unlock_irq(q->queue_lock);
+		}
+	}
 
 	/* allocate, init and register new elevator */
-	err = new_e->ops.elevator_init_fn(q, new_e);
-	if (err)
-		goto fail_init;
+	if (new_e) {
+		if (new_e->uses_mq)
+			err = new_e->mq_ops.init_sched(q, new_e);
+		else
+			err = new_e->ops.elevator_init_fn(q, new_e);
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
+
+	if (q->mq_ops) {
+		blk_mq_unfreeze_queue(q);
+		blk_mq_start_stopped_hw_queues(q, true);
+	}
 
-	blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	if (new_e)
+		blk_add_trace_msg(q, "elv switch: %s", new_e->elevator_name);
+	else
+		blk_add_trace_msg(q, "elv switch: none");
 
 	return 0;
 
@@ -934,9 +970,16 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 	elevator_exit(q->elevator);
 fail_init:
 	/* switch failed, restore and re-register old elevator */
-	q->elevator = old;
-	elv_register_queue(q);
-	blk_queue_bypass_end(q);
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
@@ -949,8 +992,11 @@ static int __elevator_change(struct request_queue *q, const char *name)
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
@@ -959,11 +1005,23 @@ static int __elevator_change(struct request_queue *q, const char *name)
 		return -EINVAL;
 	}
 
-	if (!strcmp(elevator_name, q->elevator->type->elevator_name)) {
+	if (q->elevator &&
+	    !strcmp(elevator_name, q->elevator->type->elevator_name)) {
 		elevator_put(e);
 		return 0;
 	}
 
+	if (!e->uses_mq && q->mq_ops) {
+		printk(KERN_ERR "blk-mq-sched: elv %s does not support mq\n", elevator_name);
+		elevator_put(e);
+		return -EINVAL;
+	}
+	if (e->uses_mq && !q->mq_ops) {
+		printk(KERN_ERR "blk-mq-sched: elv %s is for mq\n", elevator_name);
+		elevator_put(e);
+		return -EINVAL;
+	}
+
 	return elevator_switch(q, e);
 }
 
@@ -985,7 +1043,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 {
 	int ret;
 
-	if (!q->elevator)
+	if (!q->mq_ops || q->request_fn)
 		return count;
 
 	ret = __elevator_change(q, name);
@@ -999,24 +1057,34 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
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
+		if (elv && !strcmp(elv->elevator_name, __e->elevator_name)) {
 			len += sprintf(name+len, "[%s] ", elv->elevator_name);
-		else
+			continue;
+		}
+		if (__e->uses_mq && q->mq_ops)
+			len += sprintf(name+len, "%s ", __e->elevator_name);
+		else if (!__e->uses_mq && !q->mq_ops)
 			len += sprintf(name+len, "%s ", __e->elevator_name);
 	}
 	spin_unlock(&elv_list_lock);
 
+	if (q->mq_ops && q->elevator)
+		len += sprintf(name+len, "none");
+
 	len += sprintf(len+name, "\n");
 	return len;
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 87e404aae267..c86b314dde97 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -22,6 +22,7 @@ struct blk_mq_hw_ctx {
 
 	unsigned long		flags;		/* BLK_MQ_F_* flags */
 
+	void			*sched_data;
 	struct request_queue	*queue;
 	struct blk_flush_queue	*fq;
 
@@ -179,7 +180,6 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
 
-void blk_mq_insert_request(struct request *, bool, bool, bool);
 void blk_mq_free_request(struct request *rq);
 void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *, struct request *rq);
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index b276e9ef0e0b..b270b1f75767 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -77,6 +77,24 @@ struct elevator_ops
 	elevator_registered_fn *elevator_registered_fn;
 };
 
+struct blk_mq_alloc_data;
+struct blk_mq_hw_ctx;
+
+struct elevator_mq_ops {
+	int (*init_sched)(struct request_queue *, struct elevator_type *);
+	void (*exit_sched)(struct elevator_queue *);
+
+	bool (*allow_merge)(struct request_queue *, struct request *, struct bio *);
+	bool (*bio_merge)(struct blk_mq_hw_ctx *, struct bio *);
+	struct request *(*get_request)(struct request_queue *, struct bio *, struct blk_mq_alloc_data *);
+	void (*insert_request)(struct blk_mq_hw_ctx *, struct request *, bool);
+	struct request *(*dispatch_request)(struct blk_mq_hw_ctx *);
+	bool (*has_work)(struct blk_mq_hw_ctx *);
+	void (*completed_request)(struct blk_mq_hw_ctx *, struct request *);
+	void (*started_request)(struct request *);
+	void (*requeue_request)(struct request *);
+};
+
 #define ELV_NAME_MAX	(16)
 
 struct elv_fs_entry {
@@ -94,12 +112,16 @@ struct elevator_type
 	struct kmem_cache *icq_cache;
 
 	/* fields provided by elevator implementation */
-	struct elevator_ops ops;
+	union {
+		struct elevator_ops ops;
+		struct elevator_mq_ops mq_ops;
+	};
 	size_t icq_size;	/* see iocontext.h */
 	size_t icq_align;	/* ditto */
 	struct elv_fs_entry *elevator_attrs;
 	char elevator_name[ELV_NAME_MAX];
 	struct module *elevator_owner;
+	bool uses_mq;
 
 	/* managed by elevator core */
 	char icq_cache_name[ELV_NAME_MAX + 5];	/* elvname + "_io_cq" */
@@ -123,6 +145,7 @@ struct elevator_queue
 	struct kobject kobj;
 	struct mutex sysfs_lock;
 	unsigned int registered:1;
+	unsigned int uses_mq:1;
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
 
-- 
2.7.4
