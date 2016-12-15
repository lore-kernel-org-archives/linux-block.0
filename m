Return-Path: <prvs=1157cbc043=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO schedulers
Date: Wed, 14 Dec 2016 22:26:06 -0700
Message-ID: <1481779568-10642-6-git-send-email-axboe@fb.com>
In-Reply-To: <1481779568-10642-1-git-send-email-axboe@fb.com>
References: <1481779568-10642-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/Makefile           |   2 +-
 block/blk-core.c         |   7 +-
 block/blk-exec.c         |   3 +-
 block/blk-flush.c        |   7 +-
 block/blk-mq-sched.c     | 375 +++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.h     | 190 ++++++++++++++++++++++++
 block/blk-mq-tag.c       |   1 +
 block/blk-mq.c           | 192 ++++++++++--------------
 block/blk-mq.h           |   3 +
 block/elevator.c         | 186 +++++++++++++++++------
 include/linux/blk-mq.h   |   3 +-
 include/linux/elevator.h |  29 ++++
 12 files changed, 833 insertions(+), 165 deletions(-)
 create mode 100644 block/blk-mq-sched.c
 create mode 100644 block/blk-mq-sched.h

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
index 92baea07acbc..cb1e864cb23d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -39,6 +39,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-sched.h"
 #include "blk-wbt.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
@@ -1413,7 +1414,7 @@ void __blk_put_request(struct request_queue *q, struct request *req)
 		return;
 
 	if (q->mq_ops) {
-		blk_mq_free_request(req);
+		blk_mq_sched_put_request(req);
 		return;
 	}
 
@@ -1449,7 +1450,7 @@ void blk_put_request(struct request *req)
 	struct request_queue *q = req->q;
 
 	if (q->mq_ops)
-		blk_mq_free_request(req);
+		blk_mq_sched_put_request(req);
 	else {
 		unsigned long flags;
 
@@ -2127,7 +2128,7 @@ int blk_insert_cloned_request(struct request_queue *q, struct request *rq)
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
index 20b7c7a02f1c..6a7c29d2eb3c 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -74,6 +74,7 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
+#include "blk-mq-sched.h"
 
 /* FLUSH/FUA sequences */
 enum {
@@ -453,9 +454,9 @@ void blk_insert_flush(struct request *rq)
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
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
new file mode 100644
index 000000000000..02ad17258666
--- /dev/null
+++ b/block/blk-mq-sched.c
@@ -0,0 +1,375 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/blk-mq.h>
+
+#include <trace/events/block.h>
+
+#include "blk.h"
+#include "blk-mq.h"
+#include "blk-mq-sched.h"
+#include "blk-mq-tag.h"
+#include "blk-wbt.h"
+
+/*
+ * Empty set
+ */
+static const struct blk_mq_ops mq_sched_tag_ops = {
+};
+
+void blk_mq_sched_free_requests(struct blk_mq_tags *tags)
+{
+	blk_mq_free_rq_map(NULL, tags, 0);
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_free_requests);
+
+struct blk_mq_tags *blk_mq_sched_alloc_requests(unsigned int depth,
+						unsigned int numa_node)
+{
+	struct blk_mq_tag_set set = {
+		.ops		= &mq_sched_tag_ops,
+		.nr_hw_queues	= 1,
+		.queue_depth	= depth,
+		.numa_node	= numa_node,
+	};
+
+	return blk_mq_init_rq_map(&set, 0);
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_alloc_requests);
+
+void blk_mq_sched_free_hctx_data(struct request_queue *q,
+				 void (*exit)(struct blk_mq_hw_ctx *))
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (exit)
+			exit(hctx);
+		kfree(hctx->sched_data);
+		hctx->sched_data = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);
+
+int blk_mq_sched_init_hctx_data(struct request_queue *q, size_t size,
+				void (*init)(struct blk_mq_hw_ctx *))
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		hctx->sched_data = kmalloc_node(size, GFP_KERNEL, hctx->numa_node);
+		if (!hctx->sched_data)
+			goto error;
+
+		if (init)
+			init(hctx);
+	}
+
+	return 0;
+error:
+	blk_mq_sched_free_hctx_data(q, NULL);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_init_hctx_data);
+
+struct request *blk_mq_sched_alloc_shadow_request(struct request_queue *q,
+						  struct blk_mq_alloc_data *data,
+						  struct blk_mq_tags *tags,
+						  atomic_t *wait_index)
+{
+	struct sbq_wait_state *ws;
+	DEFINE_WAIT(wait);
+	struct request *rq;
+	int tag;
+
+	tag = __sbitmap_queue_get(&tags->bitmap_tags);
+	if (tag != -1)
+		goto done;
+
+	if (data->flags & BLK_MQ_REQ_NOWAIT)
+		return NULL;
+
+	ws = sbq_wait_ptr(&tags->bitmap_tags, wait_index);
+	do {
+		prepare_to_wait(&ws->wait, &wait, TASK_UNINTERRUPTIBLE);
+
+		tag = __sbitmap_queue_get(&tags->bitmap_tags);
+		if (tag != -1)
+			break;
+
+		blk_mq_run_hw_queue(data->hctx, false);
+
+		tag = __sbitmap_queue_get(&tags->bitmap_tags);
+		if (tag != -1)
+			break;
+
+		blk_mq_put_ctx(data->ctx);
+		io_schedule();
+
+		data->ctx = blk_mq_get_ctx(data->q);
+		data->hctx = blk_mq_map_queue(data->q, data->ctx->cpu);
+		finish_wait(&ws->wait, &wait);
+		ws = sbq_wait_ptr(&tags->bitmap_tags, wait_index);
+	} while (1);
+
+	finish_wait(&ws->wait, &wait);
+done:
+	rq = tags->rqs[tag];
+	rq->tag = tag;
+	rq->rq_flags |= RQF_ALLOCED;
+	return rq;
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_alloc_shadow_request);
+
+void blk_mq_sched_free_shadow_request(struct blk_mq_tags *tags,
+				      struct request *rq)
+{
+	WARN_ON_ONCE(!(rq->rq_flags & RQF_ALLOCED));
+	sbitmap_queue_clear(&tags->bitmap_tags, rq->tag, rq->mq_ctx->cpu);
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_free_shadow_request);
+
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
+	FIELD_COPY(rq, src, issue_stat);
+	src->issue_stat.time = 0;
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
+
+	FIELD_COPY(sched_rq, rq, resid_len);
+	FIELD_COPY(sched_rq, rq, extra_len);
+	FIELD_COPY(sched_rq, rq, sense_len);
+	FIELD_COPY(sched_rq, rq, errors);
+	FIELD_COPY(sched_rq, rq, retries);
+
+	blk_account_io_completion(sched_rq, blk_rq_bytes(sched_rq));
+	blk_account_io_done(sched_rq);
+
+	if (sched_rq->end_io)
+		sched_rq->end_io(sched_rq, error);
+
+	blk_mq_free_request(rq);
+}
+
+struct request *
+blk_mq_sched_request_from_shadow(struct blk_mq_hw_ctx *hctx,
+				 struct request *(*get_sched_rq)(struct blk_mq_hw_ctx *))
+{
+	struct blk_mq_alloc_data data;
+	struct request *sched_rq, *rq;
+
+	data.q = hctx->queue;
+	data.flags = BLK_MQ_REQ_NOWAIT;
+	data.ctx = blk_mq_get_ctx(hctx->queue);
+	data.hctx = hctx;
+
+	rq = __blk_mq_alloc_request(&data, 0);
+	blk_mq_put_ctx(data.ctx);
+
+	if (!rq) {
+		blk_mq_stop_hw_queue(hctx);
+		return NULL;
+	}
+
+	sched_rq = get_sched_rq(hctx);
+
+	if (!sched_rq) {
+		blk_queue_enter_live(hctx->queue);
+		__blk_mq_free_request(hctx, data.ctx, rq);
+		return NULL;
+	}
+
+	WARN_ON_ONCE(!(sched_rq->rq_flags & RQF_ALLOCED));
+	rq_copy(rq, sched_rq);
+	rq->end_io = sched_rq_end_io;
+	rq->end_io_data = sched_rq;
+
+	return rq;
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_request_from_shadow);
+
+static void blk_mq_sched_assign_ioc(struct request_queue *q,
+				    struct request *rq, struct bio *bio)
+{
+	struct io_context *ioc = rq_ioc(bio);
+	struct io_cq *icq;
+
+	if (!ioc)
+		return;
+
+	spin_lock_irq(q->queue_lock);
+	icq = ioc_lookup_icq(ioc, q);
+	spin_unlock_irq(q->queue_lock);
+
+	if (!icq) {
+		if (ioc)
+			icq = ioc_create_icq(ioc, q, GFP_ATOMIC);
+		if (!icq) {
+fail:
+			printk_ratelimited("failed icq alloc\n");
+			return;
+		}
+	}
+
+	rq->elv.icq = icq;
+	if (blk_mq_sched_get_rq_priv(q, rq))
+		goto fail;
+
+	if (icq)
+		get_io_context(icq->ioc);
+}
+
+struct request *blk_mq_sched_get_request(struct request_queue *q,
+					 struct bio *bio,
+					 unsigned int op,
+					 struct blk_mq_alloc_data *data)
+{
+	struct elevator_queue *e = q->elevator;
+	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_ctx *ctx;
+	struct request *rq;
+
+	blk_queue_enter_live(q);
+	ctx = blk_mq_get_ctx(q);
+	hctx = blk_mq_map_queue(q, ctx->cpu);
+
+	blk_mq_set_alloc_data(data, q, 0, ctx, hctx);
+
+	if (e && e->type->ops.mq.get_request)
+		rq = e->type->ops.mq.get_request(q, op, data);
+	else
+		rq = __blk_mq_alloc_request(data, op);
+
+	if (rq) {
+		rq->elv.icq = NULL;
+		if (e && e->type->icq_cache)
+			blk_mq_sched_assign_ioc(q, rq, bio);
+		data->hctx->queued++;
+		return rq;
+	}
+
+	blk_queue_exit(q);
+	return NULL;
+}
+
+void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+{
+	struct elevator_queue *e = hctx->queue->elevator;
+	LIST_HEAD(rq_list);
+
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
+		return;
+
+	hctx->run++;
+
+	/*
+	 * If we have previous entries on our dispatch list, grab them first for
+	 * more fair dispatch.
+	 */
+	if (!list_empty_careful(&hctx->dispatch)) {
+		spin_lock(&hctx->lock);
+		if (!list_empty(&hctx->dispatch))
+			list_splice_init(&hctx->dispatch, &rq_list);
+		spin_unlock(&hctx->lock);
+	}
+
+	/*
+	 * Only ask the scheduler for requests, if we didn't have residual
+	 * requests from the dispatch list. This is to avoid the case where
+	 * we only ever dispatch a fraction of the requests available because
+	 * of low device queue depth. Once we pull requests out of the IO
+	 * scheduler, we can no longer merge or sort them. So it's best to
+	 * leave them there for as long as we can. Mark the hw queue as
+	 * needing a restart in that case.
+	 */
+	if (list_empty(&rq_list)) {
+		if (e && e->type->ops.mq.dispatch_requests)
+			e->type->ops.mq.dispatch_requests(hctx, &rq_list);
+		else
+			blk_mq_flush_busy_ctxs(hctx, &rq_list);
+	} else
+		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+
+	blk_mq_dispatch_rq_list(hctx, &rq_list);
+}
+
+bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio)
+{
+	struct request *rq;
+	int ret;
+
+	ret = elv_merge(q, &rq, bio);
+	if (ret == ELEVATOR_BACK_MERGE) {
+		if (bio_attempt_back_merge(q, rq, bio)) {
+			if (!attempt_back_merge(q, rq))
+				elv_merged_request(q, rq, ret);
+			goto done;
+		}
+		ret = ELEVATOR_NO_MERGE;
+	} else if (ret == ELEVATOR_FRONT_MERGE) {
+		if (bio_attempt_front_merge(q, rq, bio)) {
+			if (!attempt_front_merge(q, rq))
+				elv_merged_request(q, rq, ret);
+			goto done;
+		}
+		ret = ELEVATOR_NO_MERGE;
+	}
+done:
+	return ret != ELEVATOR_NO_MERGE;
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
+
+bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (e->type->ops.mq.bio_merge) {
+		struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
+		struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
+
+		blk_mq_put_ctx(ctx);
+		return e->type->ops.mq.bio_merge(hctx, bio);
+	}
+
+	return false;
+}
+
+void blk_mq_sched_request_inserted(struct request *rq)
+{
+	trace_block_rq_insert(rq->q, rq);
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
new file mode 100644
index 000000000000..b68dccc0190e
--- /dev/null
+++ b/block/blk-mq-sched.h
@@ -0,0 +1,190 @@
+#ifndef BLK_MQ_SCHED_H
+#define BLK_MQ_SCHED_H
+
+#include "blk-mq.h"
+
+struct blk_mq_tags *blk_mq_sched_alloc_requests(unsigned int depth, unsigned int numa_node);
+void blk_mq_sched_free_requests(struct blk_mq_tags *tags);
+
+int blk_mq_sched_init_hctx_data(struct request_queue *q, size_t size,
+				void (*init)(struct blk_mq_hw_ctx *));
+void blk_mq_sched_free_hctx_data(struct request_queue *q,
+				 void (*exit)(struct blk_mq_hw_ctx *));
+
+void blk_mq_sched_free_shadow_request(struct blk_mq_tags *tags,
+				      struct request *rq);
+struct request *blk_mq_sched_alloc_shadow_request(struct request_queue *q,
+						  struct blk_mq_alloc_data *data,
+						  struct blk_mq_tags *tags,
+						  atomic_t *wait_index);
+struct request *
+blk_mq_sched_request_from_shadow(struct blk_mq_hw_ctx *hctx,
+				 struct request *(*get_sched_rq)(struct blk_mq_hw_ctx *));
+
+struct request *blk_mq_sched_get_request(struct request_queue *q, struct bio *bio, unsigned int op, struct blk_mq_alloc_data *data);
+
+void __blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
+void blk_mq_sched_request_inserted(struct request *rq);
+bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio);
+bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
+
+void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
+
+static inline bool
+blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (!e || blk_queue_nomerges(q) || !bio_mergeable(bio))
+		return false;
+
+	return __blk_mq_sched_bio_merge(q, bio);
+}
+
+static inline int blk_mq_sched_get_rq_priv(struct request_queue *q,
+					   struct request *rq)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (e && e->type->ops.mq.get_rq_priv)
+		return e->type->ops.mq.get_rq_priv(q, rq);
+
+	return 0;
+}
+
+static inline void blk_mq_sched_put_rq_priv(struct request_queue *q,
+					    struct request *rq)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (e && e->type->ops.mq.put_rq_priv)
+		e->type->ops.mq.put_rq_priv(q, rq);
+}
+
+static inline void blk_mq_sched_put_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+	bool do_free = true;
+
+	if (rq->rq_flags & RQF_ELVPRIV) {
+		blk_mq_sched_put_rq_priv(rq->q, rq);
+		if (rq->elv.icq)
+			put_io_context(rq->elv.icq->ioc);
+	}
+
+	if (e && e->type->ops.mq.put_request)
+		do_free = !e->type->ops.mq.put_request(rq);
+	if (do_free)
+		blk_mq_free_request(rq);
+}
+
+static inline void
+blk_mq_sched_insert_request(struct request *rq, bool at_head, bool run_queue,
+			    bool async)
+{
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+	struct blk_mq_ctx *ctx = rq->mq_ctx;
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
+
+	if (e && e->type->ops.mq.insert_requests) {
+		LIST_HEAD(list);
+
+		list_add(&rq->queuelist, &list);
+		e->type->ops.mq.insert_requests(hctx, &list, at_head);
+	} else {
+		spin_lock(&ctx->lock);
+		__blk_mq_insert_request(hctx, rq, at_head);
+		spin_unlock(&ctx->lock);
+	}
+
+	if (run_queue)
+		blk_mq_run_hw_queue(hctx, async);
+}
+
+static inline void
+blk_mq_sched_insert_requests(struct request_queue *q, struct blk_mq_ctx *ctx,
+			     struct list_head *list, bool run_queue_async)
+{
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
+	struct elevator_queue *e = hctx->queue->elevator;
+
+	if (e && e->type->ops.mq.insert_requests)
+		e->type->ops.mq.insert_requests(hctx, list, false);
+	else
+		blk_mq_insert_requests(hctx, ctx, list);
+
+	blk_mq_run_hw_queue(hctx, run_queue_async);
+}
+
+static inline void
+blk_mq_sched_dispatch_shadow_requests(struct blk_mq_hw_ctx *hctx,
+				      struct list_head *rq_list,
+				      struct request *(*get_sched_rq)(struct blk_mq_hw_ctx *))
+{
+	do {
+		struct request *rq;
+
+		rq = blk_mq_sched_request_from_shadow(hctx, get_sched_rq);
+		if (!rq)
+			break;
+
+		list_add_tail(&rq->queuelist, rq_list);
+	} while (1);
+}
+
+static inline bool
+blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
+			 struct bio *bio)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (e && e->type->ops.mq.allow_merge)
+		return e->type->ops.mq.allow_merge(q, rq, bio);
+
+	return true;
+}
+
+static inline void
+blk_mq_sched_completed_request(struct blk_mq_hw_ctx *hctx, struct request *rq)
+{
+	struct elevator_queue *e = hctx->queue->elevator;
+
+	if (e && e->type->ops.mq.completed_request)
+		e->type->ops.mq.completed_request(hctx, rq);
+
+	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
+		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+		blk_mq_run_hw_queue(hctx, true);
+	}
+}
+
+static inline void blk_mq_sched_started_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+
+	if (e && e->type->ops.mq.started_request)
+		e->type->ops.mq.started_request(rq);
+}
+
+static inline void blk_mq_sched_requeue_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+
+	if (e && e->type->ops.mq.requeue_request)
+		e->type->ops.mq.requeue_request(rq);
+}
+
+static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
+{
+	struct elevator_queue *e = hctx->queue->elevator;
+
+	if (e && e->type->ops.mq.has_work)
+		return e->type->ops.mq.has_work(hctx);
+
+	return false;
+}
+#endif
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
index 8d1cec8e25d1..d10a246a3bc7 100644
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
@@ -242,26 +244,21 @@ EXPORT_SYMBOL_GPL(__blk_mq_alloc_request);
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		unsigned int flags)
 {
-	struct blk_mq_ctx *ctx;
-	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
 	struct blk_mq_alloc_data alloc_data;
+	struct request *rq;
 	int ret;
 
 	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
 	if (ret)
 		return ERR_PTR(ret);
 
-	ctx = blk_mq_get_ctx(q);
-	hctx = blk_mq_map_queue(q, ctx->cpu);
-	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
-	rq = __blk_mq_alloc_request(&alloc_data, rw);
-	blk_mq_put_ctx(ctx);
+	rq = blk_mq_sched_get_request(q, NULL, rw, &alloc_data);
 
-	if (!rq) {
-		blk_queue_exit(q);
+	blk_mq_put_ctx(alloc_data.ctx);
+	blk_queue_exit(q);
+
+	if (!rq)
 		return ERR_PTR(-EWOULDBLOCK);
-	}
 
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
@@ -327,6 +324,8 @@ void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 	const int tag = rq->tag;
 	struct request_queue *q = rq->q;
 
+	blk_mq_sched_completed_request(hctx, rq);
+
 	if (rq->rq_flags & RQF_MQ_INFLIGHT)
 		atomic_dec(&hctx->nr_active);
 
@@ -364,8 +363,8 @@ inline void __blk_mq_end_request(struct request *rq, int error)
 		rq->end_io(rq, error);
 	} else {
 		if (unlikely(blk_bidi_rq(rq)))
-			blk_mq_free_request(rq->next_rq);
-		blk_mq_free_request(rq);
+			blk_mq_sched_put_request(rq->next_rq);
+		blk_mq_sched_put_request(rq);
 	}
 }
 EXPORT_SYMBOL(__blk_mq_end_request);
@@ -469,6 +468,8 @@ void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
+	blk_mq_sched_started_request(rq);
+
 	trace_block_rq_issue(q, rq);
 
 	rq->resid_len = blk_rq_bytes(rq);
@@ -517,6 +518,7 @@ static void __blk_mq_requeue_request(struct request *rq)
 
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, &rq->issue_stat);
+	blk_mq_sched_requeue_request(rq);
 
 	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
 		if (q->dma_drain_size && blk_rq_bytes(rq))
@@ -551,13 +553,13 @@ static void blk_mq_requeue_work(struct work_struct *work)
 
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
@@ -763,8 +765,16 @@ static bool blk_mq_attempt_merge(struct request_queue *q,
 
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
@@ -906,41 +916,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 	return ret != BLK_MQ_RQ_QUEUE_BUSY;
 }
 
-/*
- * Run this hardware queue, pulling any software queues mapped to it in.
- * Note that this function currently has various problems around ordering
- * of IO. In particular, we'd like FIFO behaviour on handling existing
- * items on the hctx->dispatch list. Ignore that for now.
- */
-static void blk_mq_process_rq_list(struct blk_mq_hw_ctx *hctx)
-{
-	LIST_HEAD(rq_list);
-	LIST_HEAD(driver_list);
-
-	if (unlikely(blk_mq_hctx_stopped(hctx)))
-		return;
-
-	hctx->run++;
-
-	/*
-	 * Touch any software queue that has pending entries.
-	 */
-	blk_mq_flush_busy_ctxs(hctx, &rq_list);
-
-	/*
-	 * If we have previous entries on our dispatch list, grab them
-	 * and stuff them at the front for more fair dispatch.
-	 */
-	if (!list_empty_careful(&hctx->dispatch)) {
-		spin_lock(&hctx->lock);
-		if (!list_empty(&hctx->dispatch))
-			list_splice_init(&hctx->dispatch, &rq_list);
-		spin_unlock(&hctx->lock);
-	}
-
-	blk_mq_dispatch_rq_list(hctx, &rq_list);
-}
-
 static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	int srcu_idx;
@@ -950,11 +925,11 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 
 	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
 		rcu_read_lock();
-		blk_mq_process_rq_list(hctx);
+		blk_mq_sched_dispatch_requests(hctx);
 		rcu_read_unlock();
 	} else {
 		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
-		blk_mq_process_rq_list(hctx);
+		blk_mq_sched_dispatch_requests(hctx);
 		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
 	}
 }
@@ -1148,32 +1123,10 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
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
-static void blk_mq_insert_requests(struct request_queue *q,
-				     struct blk_mq_ctx *ctx,
-				     struct list_head *list,
-				     int depth,
-				     bool from_schedule)
+void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+			    struct list_head *list)
 
 {
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
-
-	trace_block_unplug(q, depth, !from_schedule);
-
 	/*
 	 * preemption doesn't flush plug list, so it's possible ctx->cpu is
 	 * offline now
@@ -1189,8 +1142,6 @@ static void blk_mq_insert_requests(struct request_queue *q,
 	}
 	blk_mq_hctx_mark_pending(hctx, ctx);
 	spin_unlock(&ctx->lock);
-
-	blk_mq_run_hw_queue(hctx, from_schedule);
 }
 
 static int plug_ctx_cmp(void *priv, struct list_head *a, struct list_head *b)
@@ -1226,9 +1177,10 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		BUG_ON(!rq->q);
 		if (rq->mq_ctx != this_ctx) {
 			if (this_ctx) {
-				blk_mq_insert_requests(this_q, this_ctx,
-							&ctx_list, depth,
-							from_schedule);
+				trace_block_unplug(this_q, depth, from_schedule);
+				blk_mq_sched_insert_requests(this_q, this_ctx,
+								&ctx_list,
+								from_schedule);
 			}
 
 			this_ctx = rq->mq_ctx;
@@ -1245,8 +1197,9 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	 * on 'ctx_list'. Do those.
 	 */
 	if (this_ctx) {
-		blk_mq_insert_requests(this_q, this_ctx, &ctx_list, depth,
-				       from_schedule);
+		trace_block_unplug(this_q, depth, from_schedule);
+		blk_mq_sched_insert_requests(this_q, this_ctx, &ctx_list,
+						from_schedule);
 	}
 }
 
@@ -1289,41 +1242,27 @@ static inline bool blk_mq_merge_queue_io(struct blk_mq_hw_ctx *hctx,
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
@@ -1345,7 +1284,7 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
 	}
 
 insert:
-	blk_mq_insert_request(rq, false, true, true);
+	blk_mq_sched_insert_request(rq, false, true, true);
 }
 
 /*
@@ -1378,9 +1317,14 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	    blk_attempt_plug_merge(q, bio, &request_count, &same_queue_rq))
 		return BLK_QC_T_NONE;
 
+	if (blk_mq_sched_bio_merge(q, bio))
+		return BLK_QC_T_NONE;
+
 	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
 
-	rq = blk_mq_map_request(q, bio, &data);
+	trace_block_getrq(q, bio, bio->bi_opf);
+
+	rq = blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
 	if (unlikely(!rq)) {
 		__wbt_done(q->rq_wb, wb_acct);
 		return BLK_QC_T_NONE;
@@ -1442,6 +1386,12 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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
@@ -1487,9 +1437,14 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	} else
 		request_count = blk_plug_queued_count(q);
 
+	if (blk_mq_sched_bio_merge(q, bio))
+		return BLK_QC_T_NONE;
+
 	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
 
-	rq = blk_mq_map_request(q, bio, &data);
+	trace_block_getrq(q, bio, bio->bi_opf);
+
+	rq = blk_mq_sched_get_request(q, bio, bio->bi_opf, &data);
 	if (unlikely(!rq)) {
 		__wbt_done(q->rq_wb, wb_acct);
 		return BLK_QC_T_NONE;
@@ -1539,6 +1494,12 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
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
@@ -1551,6 +1512,7 @@ static blk_qc_t blk_sq_make_request(struct request_queue *q, struct bio *bio)
 	}
 
 	blk_mq_put_ctx(data.ctx);
+done:
 	return cookie;
 }
 
@@ -1559,7 +1521,7 @@ void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 {
 	struct page *page;
 
-	if (tags->rqs && set->ops->exit_request) {
+	if (tags->rqs && set && set->ops->exit_request) {
 		int i;
 
 		for (i = 0; i < tags->nr_tags; i++) {
@@ -2267,10 +2229,10 @@ static int blk_mq_queue_reinit_dead(unsigned int cpu)
  * Now CPU1 is just onlined and a request is inserted into ctx1->rq_list
  * and set bit0 in pending bitmap as ctx1->index_hw is still zero.
  *
- * And then while running hw queue, flush_busy_ctxs() finds bit0 is set in
- * pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
- * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list
- * is ignored.
+ * And then while running hw queue, blk_mq_flush_busy_ctxs() finds bit0 is set
+ * in pending bitmap and tries to retrieve requests in hctx->ctxs[0]->rq_list.
+ * But htx->ctxs[0] is a pointer to ctx0, so the request in ctx1->rq_list is
+ * ignored.
  */
 static int blk_mq_queue_reinit_prepare(unsigned int cpu)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e59f5ca520a2..a5ddc860b220 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -47,6 +47,9 @@ struct blk_mq_tags *blk_mq_init_rq_map(struct blk_mq_tag_set *set,
  */
 void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 				bool at_head);
+void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
+				struct list_head *list);
+void blk_mq_process_sw_list(struct blk_mq_hw_ctx *hctx);
 
 /*
  * CPU hotplug helpers
diff --git a/block/elevator.c b/block/elevator.c
index 022a26830297..6d39197768c1 100644
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
 
-	if (e->type->ops.sq.elevator_allow_bio_merge_fn)
+	if (e->uses_mq && e->type->ops.mq.allow_merge)
+		return e->type->ops.mq.allow_merge(q, rq, bio);
+	else if (!e->uses_mq && e->type->ops.sq.elevator_allow_bio_merge_fn)
 		return e->type->ops.sq.elevator_allow_bio_merge_fn(q, rq, bio);
 
 	return 1;
@@ -163,6 +166,7 @@ struct elevator_queue *elevator_alloc(struct request_queue *q,
 	kobject_init(&eq->kobj, &elv_ktype);
 	mutex_init(&eq->sysfs_lock);
 	hash_init(eq->hash);
+	eq->uses_mq = e->uses_mq;
 
 	return eq;
 }
@@ -219,12 +223,19 @@ int elevator_init(struct request_queue *q, char *name)
 		if (!e) {
 			printk(KERN_ERR
 				"Default I/O scheduler not found. " \
-				"Using noop.\n");
+				"Using noop/none.\n");
+			if (q->mq_ops) {
+				elevator_put(e);
+				return 0;
+			}
 			e = elevator_get("noop", false);
 		}
 	}
 
-	err = e->ops.sq.elevator_init_fn(q, e);
+	if (e->uses_mq)
+		err = e->ops.mq.init_sched(q, e);
+	else
+		err = e->ops.sq.elevator_init_fn(q, e);
 	if (err)
 		elevator_put(e);
 	return err;
@@ -234,7 +245,9 @@ EXPORT_SYMBOL(elevator_init);
 void elevator_exit(struct elevator_queue *e)
 {
 	mutex_lock(&e->sysfs_lock);
-	if (e->type->ops.sq.elevator_exit_fn)
+	if (e->uses_mq && e->type->ops.mq.exit_sched)
+		e->type->ops.mq.exit_sched(e);
+	else if (!e->uses_mq && e->type->ops.sq.elevator_exit_fn)
 		e->type->ops.sq.elevator_exit_fn(e);
 	mutex_unlock(&e->sysfs_lock);
 
@@ -253,6 +266,7 @@ void elv_rqhash_del(struct request_queue *q, struct request *rq)
 	if (ELV_ON_HASH(rq))
 		__elv_rqhash_del(rq);
 }
+EXPORT_SYMBOL_GPL(elv_rqhash_del);
 
 void elv_rqhash_add(struct request_queue *q, struct request *rq)
 {
@@ -262,6 +276,7 @@ void elv_rqhash_add(struct request_queue *q, struct request *rq)
 	hash_add(e->hash, &rq->hash, rq_hash_key(rq));
 	rq->rq_flags |= RQF_HASHED;
 }
+EXPORT_SYMBOL_GPL(elv_rqhash_add);
 
 void elv_rqhash_reposition(struct request_queue *q, struct request *rq)
 {
@@ -443,7 +458,9 @@ int elv_merge(struct request_queue *q, struct request **req, struct bio *bio)
 		return ELEVATOR_BACK_MERGE;
 	}
 
-	if (e->type->ops.sq.elevator_merge_fn)
+	if (e->uses_mq && e->type->ops.mq.request_merge)
+		return e->type->ops.mq.request_merge(q, req, bio);
+	else if (!e->uses_mq && e->type->ops.sq.elevator_merge_fn)
 		return e->type->ops.sq.elevator_merge_fn(q, req, bio);
 
 	return ELEVATOR_NO_MERGE;
@@ -462,6 +479,9 @@ static bool elv_attempt_insert_merge(struct request_queue *q,
 	struct request *__rq;
 	bool ret;
 
+	if (WARN_ON_ONCE(q->elevator && q->elevator->uses_mq))
+		return false;
+
 	if (blk_queue_nomerges(q))
 		return false;
 
@@ -495,7 +515,9 @@ void elv_merged_request(struct request_queue *q, struct request *rq, int type)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.sq.elevator_merged_fn)
+	if (e->uses_mq && e->type->ops.mq.request_merged)
+		e->type->ops.mq.request_merged(q, rq, type);
+	else if (!e->uses_mq && e->type->ops.sq.elevator_merged_fn)
 		e->type->ops.sq.elevator_merged_fn(q, rq, type);
 
 	if (type == ELEVATOR_BACK_MERGE)
@@ -508,10 +530,15 @@ void elv_merge_requests(struct request_queue *q, struct request *rq,
 			     struct request *next)
 {
 	struct elevator_queue *e = q->elevator;
-	const int next_sorted = next->rq_flags & RQF_SORTED;
-
-	if (next_sorted && e->type->ops.sq.elevator_merge_req_fn)
-		e->type->ops.sq.elevator_merge_req_fn(q, rq, next);
+	bool next_sorted = false;
+
+	if (e->uses_mq && e->type->ops.mq.requests_merged)
+		e->type->ops.mq.requests_merged(q, rq, next);
+	else if (e->type->ops.sq.elevator_merge_req_fn) {
+		next_sorted = next->rq_flags & RQF_SORTED;
+		if (next_sorted)
+			e->type->ops.sq.elevator_merge_req_fn(q, rq, next);
+	}
 
 	elv_rqhash_reposition(q, rq);
 
@@ -528,6 +555,9 @@ void elv_bio_merged(struct request_queue *q, struct request *rq,
 {
 	struct elevator_queue *e = q->elevator;
 
+	if (WARN_ON_ONCE(e->uses_mq))
+		return;
+
 	if (e->type->ops.sq.elevator_bio_merged_fn)
 		e->type->ops.sq.elevator_bio_merged_fn(q, rq, bio);
 }
@@ -682,8 +712,11 @@ struct request *elv_latter_request(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.sq.elevator_latter_req_fn)
+	if (e->uses_mq && e->type->ops.mq.next_request)
+		return e->type->ops.mq.next_request(q, rq);
+	else if (!e->uses_mq && e->type->ops.sq.elevator_latter_req_fn)
 		return e->type->ops.sq.elevator_latter_req_fn(q, rq);
+
 	return NULL;
 }
 
@@ -691,7 +724,9 @@ struct request *elv_former_request(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
-	if (e->type->ops.sq.elevator_former_req_fn)
+	if (e->uses_mq && e->type->ops.mq.former_request)
+		return e->type->ops.mq.former_request(q, rq);
+	if (!e->uses_mq && e->type->ops.sq.elevator_former_req_fn)
 		return e->type->ops.sq.elevator_former_req_fn(q, rq);
 	return NULL;
 }
@@ -701,6 +736,9 @@ int elv_set_request(struct request_queue *q, struct request *rq,
 {
 	struct elevator_queue *e = q->elevator;
 
+	if (WARN_ON_ONCE(e->uses_mq))
+		return 0;
+
 	if (e->type->ops.sq.elevator_set_req_fn)
 		return e->type->ops.sq.elevator_set_req_fn(q, rq, bio, gfp_mask);
 	return 0;
@@ -710,6 +748,9 @@ void elv_put_request(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
+	if (WARN_ON_ONCE(e->uses_mq))
+		return;
+
 	if (e->type->ops.sq.elevator_put_req_fn)
 		e->type->ops.sq.elevator_put_req_fn(rq);
 }
@@ -718,6 +759,9 @@ int elv_may_queue(struct request_queue *q, unsigned int op)
 {
 	struct elevator_queue *e = q->elevator;
 
+	if (WARN_ON_ONCE(e->uses_mq))
+		return 0;
+
 	if (e->type->ops.sq.elevator_may_queue_fn)
 		return e->type->ops.sq.elevator_may_queue_fn(q, op);
 
@@ -728,6 +772,9 @@ void elv_completed_request(struct request_queue *q, struct request *rq)
 {
 	struct elevator_queue *e = q->elevator;
 
+	if (WARN_ON_ONCE(e->uses_mq))
+		return;
+
 	/*
 	 * request is released from the driver, io must be done
 	 */
@@ -803,7 +850,7 @@ int elv_register_queue(struct request_queue *q)
 		}
 		kobject_uevent(&e->kobj, KOBJ_ADD);
 		e->registered = 1;
-		if (e->type->ops.sq.elevator_registered_fn)
+		if (!e->uses_mq && e->type->ops.sq.elevator_registered_fn)
 			e->type->ops.sq.elevator_registered_fn(q);
 	}
 	return error;
@@ -891,9 +938,14 @@ EXPORT_SYMBOL_GPL(elv_unregister);
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
@@ -901,32 +953,52 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
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
+		spin_lock_irq(q->queue_lock);
+		ioc_clear_queue(q);
+		spin_unlock_irq(q->queue_lock);
+	}
 
 	/* allocate, init and register new elevator */
-	err = new_e->ops.sq.elevator_init_fn(q, new_e);
-	if (err)
-		goto fail_init;
+	if (new_e) {
+		if (new_e->uses_mq)
+			err = new_e->ops.mq.init_sched(q, new_e);
+		else
+			err = new_e->ops.sq.elevator_init_fn(q, new_e);
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
 
@@ -934,9 +1006,16 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
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
@@ -949,8 +1028,11 @@ static int __elevator_change(struct request_queue *q, const char *name)
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
@@ -959,11 +1041,23 @@ static int __elevator_change(struct request_queue *q, const char *name)
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
 
@@ -985,7 +1079,7 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 {
 	int ret;
 
-	if (!q->elevator)
+	if (!q->mq_ops || q->request_fn)
 		return count;
 
 	ret = __elevator_change(q, name);
@@ -999,24 +1093,34 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
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
index afc81d77e471..73b58b5be6e0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -22,6 +22,7 @@ struct blk_mq_hw_ctx {
 
 	unsigned long		flags;		/* BLK_MQ_F_* flags */
 
+	void			*sched_data;
 	struct request_queue	*queue;
 	struct blk_flush_queue	*fq;
 
@@ -156,6 +157,7 @@ enum {
 
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
+	BLK_MQ_S_SCHED_RESTART	= 2,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
@@ -179,7 +181,6 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
 
-void blk_mq_insert_request(struct request *, bool, bool, bool);
 void blk_mq_free_request(struct request *rq);
 void blk_mq_free_hctx_request(struct blk_mq_hw_ctx *, struct request *rq);
 bool blk_mq_can_queue(struct blk_mq_hw_ctx *);
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 2a9e966eed03..0cbf30a00186 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -77,6 +77,32 @@ struct elevator_ops
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
+	int (*request_merge)(struct request_queue *q, struct request **, struct bio *);
+	void (*request_merged)(struct request_queue *, struct request *, int);
+	void (*requests_merged)(struct request_queue *, struct request *, struct request *);
+	struct request *(*get_request)(struct request_queue *, unsigned int, struct blk_mq_alloc_data *);
+	bool (*put_request)(struct request *);
+	void (*insert_requests)(struct blk_mq_hw_ctx *, struct list_head *, bool);
+	void (*dispatch_requests)(struct blk_mq_hw_ctx *, struct list_head *);
+	bool (*has_work)(struct blk_mq_hw_ctx *);
+	void (*completed_request)(struct blk_mq_hw_ctx *, struct request *);
+	void (*started_request)(struct request *);
+	void (*requeue_request)(struct request *);
+	struct request *(*former_request)(struct request_queue *, struct request *);
+	struct request *(*next_request)(struct request_queue *, struct request *);
+	int (*get_rq_priv)(struct request_queue *, struct request *);
+	void (*put_rq_priv)(struct request_queue *, struct request *);
+};
+
 #define ELV_NAME_MAX	(16)
 
 struct elv_fs_entry {
@@ -96,12 +122,14 @@ struct elevator_type
 	/* fields provided by elevator implementation */
 	union {
 		struct elevator_ops sq;
+		struct elevator_mq_ops mq;
 	} ops;
 	size_t icq_size;	/* see iocontext.h */
 	size_t icq_align;	/* ditto */
 	struct elv_fs_entry *elevator_attrs;
 	char elevator_name[ELV_NAME_MAX];
 	struct module *elevator_owner;
+	bool uses_mq;
 
 	/* managed by elevator core */
 	char icq_cache_name[ELV_NAME_MAX + 5];	/* elvname + "_io_cq" */
@@ -125,6 +153,7 @@ struct elevator_queue
 	struct kobject kobj;
 	struct mutex sysfs_lock;
 	unsigned int registered:1;
+	unsigned int uses_mq:1;
 	DECLARE_HASHTABLE(hash, ELV_HASH_BITS);
 };
 
-- 
2.7.4
