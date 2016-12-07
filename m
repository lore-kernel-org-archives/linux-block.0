Return-Path: <prvs=1149acddfc=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 5/7] blk-mq-sched: add framework for MQ capable IO schedulers
Date: Wed, 7 Dec 2016 16:09:59 -0700
Message-ID: <1481152201-27461-6-git-send-email-axboe@fb.com>
In-Reply-To: <1481152201-27461-1-git-send-email-axboe@fb.com>
References: <1481152201-27461-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-sched.c | 243 +++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sched.h | 168 +++++++++++++++++++++++++++++++++++
 2 files changed, 411 insertions(+)
 create mode 100644 block/blk-mq-sched.c
 create mode 100644 block/blk-mq-sched.h

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
new file mode 100644
index 000000000000..8317b26990f8
--- /dev/null
+++ b/block/blk-mq-sched.c
@@ -0,0 +1,243 @@
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <linux/blk-mq.h>
+#include "blk.h"
+#include "blk-mq.h"
+#include "blk-mq-sched.h"
+#include "blk-mq-tag.h"
+#include "blk-wbt.h"
+
+/*
+ * Empty set
+ */
+static struct blk_mq_ops mq_sched_tag_ops = {
+	.queue_rq	= NULL,
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
+	return rq;
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_alloc_shadow_request);
+
+void blk_mq_sched_free_shadow_request(struct blk_mq_tags *tags,
+				      struct request *rq)
+{
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
+	wbt_done(sched_rq->q->rq_wb, &sched_rq->issue_stat);
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
+	rq_copy(rq, sched_rq);
+	rq->end_io = sched_rq_end_io;
+	rq->end_io_data = sched_rq;
+
+	return rq;
+}
+EXPORT_SYMBOL_GPL(blk_mq_sched_request_from_shadow);
+
+void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
+{
+	struct elevator_queue *e = hctx->queue->elevator;
+	struct request *rq;
+	LIST_HEAD(rq_list);
+
+	if (unlikely(blk_mq_hctx_stopped(hctx)))
+		return;
+
+	hctx->run++;
+
+	if (!list_empty(&hctx->dispatch)) {
+		spin_lock(&hctx->lock);
+		if (!list_empty(&hctx->dispatch))
+			list_splice_init(&hctx->dispatch, &rq_list);
+		spin_unlock(&hctx->lock);
+	}
+
+	while ((rq = e->type->mq_ops.dispatch_request(hctx)) != NULL)
+		list_add_tail(&rq->queuelist, &rq_list);
+
+	blk_mq_dispatch_rq_list(hctx, &rq_list);
+}
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
new file mode 100644
index 000000000000..125e14e5274a
--- /dev/null
+++ b/block/blk-mq-sched.h
@@ -0,0 +1,168 @@
+#ifndef BLK_MQ_SCHED_H
+#define BLK_MQ_SCHED_H
+
+#include "blk-mq.h"
+
+struct blk_mq_hw_ctx;
+struct blk_mq_ctx;
+struct request_queue;
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
+
+struct blk_mq_alloc_data {
+	/* input parameter */
+	struct request_queue *q;
+	unsigned int flags;
+
+	/* input & output parameter */
+	struct blk_mq_ctx *ctx;
+	struct blk_mq_hw_ctx *hctx;
+};
+
+static inline void blk_mq_set_alloc_data(struct blk_mq_alloc_data *data,
+		struct request_queue *q, unsigned int flags,
+		struct blk_mq_ctx *ctx, struct blk_mq_hw_ctx *hctx)
+{
+	data->q = q;
+	data->flags = flags;
+	data->ctx = ctx;
+	data->hctx = hctx;
+}
+
+void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
+
+static inline bool
+blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (blk_queue_nomerges(q) || !bio_mergeable(bio))
+		return false;
+
+	if (e) {
+		struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
+		struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
+
+		blk_mq_put_ctx(ctx);
+		return e->type->mq_ops.bio_merge(hctx, bio);
+	}
+
+	return false;
+}
+
+static inline struct request *
+blk_mq_sched_get_request(struct request_queue *q, struct bio *bio,
+			 struct blk_mq_alloc_data *data)
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
+	if (e)
+		rq = e->type->mq_ops.get_request(q, bio, data);
+	else
+		rq = __blk_mq_alloc_request(data, bio->bi_opf);
+
+	if (rq)
+		data->hctx->queued++;
+
+	return rq;
+
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
+	if (e)
+		e->type->mq_ops.insert_request(hctx, rq, at_head);
+	else {
+		spin_lock(&ctx->lock);
+		__blk_mq_insert_request(hctx, rq, at_head);
+		spin_unlock(&ctx->lock);
+	}
+
+	if (run_queue)
+		blk_mq_run_hw_queue(hctx, async);
+}
+
+static inline bool
+blk_mq_sched_allow_merge(struct request_queue *q, struct request *rq,
+			 struct bio *bio)
+{
+	struct elevator_queue *e = q->elevator;
+
+	if (e && e->type->mq_ops.allow_merge)
+		return e->type->mq_ops.allow_merge(q, rq, bio);
+
+	return true;
+}
+
+static inline void
+blk_mq_sched_completed_request(struct blk_mq_hw_ctx *hctx, struct request *rq)
+{
+	struct elevator_queue *e = hctx->queue->elevator;
+
+	if (e && e->type->mq_ops.completed_request)
+		e->type->mq_ops.completed_request(hctx, rq);
+}
+
+static inline void blk_mq_sched_started_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+
+	if (e && e->type->mq_ops.started_request)
+		e->type->mq_ops.started_request(rq);
+}
+
+static inline void blk_mq_sched_requeue_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+	struct elevator_queue *e = q->elevator;
+
+	if (e && e->type->mq_ops.requeue_request)
+		e->type->mq_ops.requeue_request(rq);
+}
+
+static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
+{
+	struct elevator_queue *e = hctx->queue->elevator;
+
+	if (e && e->type->mq_ops.has_work)
+		return e->type->mq_ops.has_work(hctx);
+
+	return false;
+}
+
+
+#endif
-- 
2.7.4
