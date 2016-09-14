Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763714AbcINOTg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:36 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] blk-mq: remove ->map_queue
Date: Wed, 14 Sep 2016 16:18:54 +0200
Message-Id: <1473862739-15032-9-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

All drivers use the default, so provide an inline version of it.  If we
ever need other queue mapping we can add an optional method back,
although supporting will also require major changes to the queue setup
code.

This provides better code generation, and better debugability as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c                 |  6 +++---
 block/blk-mq-tag.c                |  5 ++---
 block/blk-mq.c                    | 40 +++++++++++----------------------------
 block/blk-mq.h                    |  6 ++++++
 block/blk.h                       | 11 +++--------
 drivers/block/loop.c              |  1 -
 drivers/block/mtip32xx/mtip32xx.c |  1 -
 drivers/block/null_blk.c          |  1 -
 drivers/block/rbd.c               |  1 -
 drivers/block/virtio_blk.c        |  1 -
 drivers/block/xen-blkfront.c      |  1 -
 drivers/md/dm-rq.c                |  1 -
 drivers/mtd/ubi/block.c           |  1 -
 drivers/nvme/host/pci.c           |  2 --
 drivers/nvme/host/rdma.c          |  2 --
 drivers/nvme/target/loop.c        |  2 --
 drivers/scsi/scsi_lib.c           |  1 -
 include/linux/blk-mq.h            |  7 -------
 18 files changed, 25 insertions(+), 65 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index d308def8..6a14b68 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -232,7 +232,7 @@ static void flush_end_io(struct request *flush_rq, int error)
 
 		/* release the tag's ownership to the req cloned from */
 		spin_lock_irqsave(&fq->mq_flush_lock, flags);
-		hctx = q->mq_ops->map_queue(q, flush_rq->mq_ctx->cpu);
+		hctx = blk_mq_map_queue(q, flush_rq->mq_ctx->cpu);
 		blk_mq_tag_set_rq(hctx, flush_rq->tag, fq->orig_rq);
 		flush_rq->tag = -1;
 	}
@@ -325,7 +325,7 @@ static bool blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 		flush_rq->tag = first_rq->tag;
 		fq->orig_rq = first_rq;
 
-		hctx = q->mq_ops->map_queue(q, first_rq->mq_ctx->cpu);
+		hctx = blk_mq_map_queue(q, first_rq->mq_ctx->cpu);
 		blk_mq_tag_set_rq(hctx, first_rq->tag, flush_rq);
 	}
 
@@ -358,7 +358,7 @@ static void mq_flush_data_end_io(struct request *rq, int error)
 	unsigned long flags;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, ctx);
 
-	hctx = q->mq_ops->map_queue(q, ctx->cpu);
+	hctx = blk_mq_map_queue(q, ctx->cpu);
 
 	/*
 	 * After populating an empty queue, kick it to avoid stall.  Read
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 729bac3..1602813 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -301,8 +301,7 @@ static int bt_get(struct blk_mq_alloc_data *data,
 		io_schedule();
 
 		data->ctx = blk_mq_get_ctx(data->q);
-		data->hctx = data->q->mq_ops->map_queue(data->q,
-				data->ctx->cpu);
+		data->hctx = blk_mq_map_queue(data->q, data->ctx->cpu);
 		if (data->flags & BLK_MQ_REQ_RESERVED) {
 			bt = &data->hctx->tags->breserved_tags;
 		} else {
@@ -726,7 +725,7 @@ u32 blk_mq_unique_tag(struct request *rq)
 	int hwq = 0;
 
 	if (q->mq_ops) {
-		hctx = q->mq_ops->map_queue(q, rq->mq_ctx->cpu);
+		hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
 		hwq = hctx->queue_num;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 15c36c1..434df39 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -244,7 +244,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		return ERR_PTR(ret);
 
 	ctx = blk_mq_get_ctx(q);
-	hctx = q->mq_ops->map_queue(q, ctx->cpu);
+	hctx = blk_mq_map_queue(q, ctx->cpu);
 	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
 
 	rq = __blk_mq_alloc_request(&alloc_data, rw, 0);
@@ -253,7 +253,7 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		blk_mq_put_ctx(ctx);
 
 		ctx = blk_mq_get_ctx(q);
-		hctx = q->mq_ops->map_queue(q, ctx->cpu);
+		hctx = blk_mq_map_queue(q, ctx->cpu);
 		blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
 		rq =  __blk_mq_alloc_request(&alloc_data, rw, 0);
 		ctx = alloc_data.ctx;
@@ -337,11 +337,7 @@ EXPORT_SYMBOL_GPL(blk_mq_free_hctx_request);
 
 void blk_mq_free_request(struct request *rq)
 {
-	struct blk_mq_hw_ctx *hctx;
-	struct request_queue *q = rq->q;
-
-	hctx = q->mq_ops->map_queue(q, rq->mq_ctx->cpu);
-	blk_mq_free_hctx_request(hctx, rq);
+	blk_mq_free_hctx_request(blk_mq_map_queue(rq->q, rq->mq_ctx->cpu), rq);
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
@@ -1064,9 +1060,7 @@ void blk_mq_insert_request(struct request *rq, bool at_head, bool run_queue,
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx;
-
-	hctx = q->mq_ops->map_queue(q, ctx->cpu);
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 
 	spin_lock(&ctx->lock);
 	__blk_mq_insert_request(hctx, rq, at_head);
@@ -1083,12 +1077,10 @@ static void blk_mq_insert_requests(struct request_queue *q,
 				     bool from_schedule)
 
 {
-	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 
 	trace_block_unplug(q, depth, !from_schedule);
 
-	hctx = q->mq_ops->map_queue(q, ctx->cpu);
-
 	/*
 	 * preemption doesn't flush plug list, so it's possible ctx->cpu is
 	 * offline now
@@ -1222,7 +1214,7 @@ static struct request *blk_mq_map_request(struct request_queue *q,
 
 	blk_queue_enter_live(q);
 	ctx = blk_mq_get_ctx(q);
-	hctx = q->mq_ops->map_queue(q, ctx->cpu);
+	hctx = blk_mq_map_queue(q, ctx->cpu);
 
 	if (rw_is_sync(bio_op(bio), bio->bi_opf))
 		op_flags |= REQ_SYNC;
@@ -1236,7 +1228,7 @@ static struct request *blk_mq_map_request(struct request_queue *q,
 		trace_block_sleeprq(q, bio, op);
 
 		ctx = blk_mq_get_ctx(q);
-		hctx = q->mq_ops->map_queue(q, ctx->cpu);
+		hctx = blk_mq_map_queue(q, ctx->cpu);
 		blk_mq_set_alloc_data(&alloc_data, q, 0, ctx, hctx);
 		rq = __blk_mq_alloc_request(&alloc_data, op, op_flags);
 		ctx = alloc_data.ctx;
@@ -1253,8 +1245,7 @@ static int blk_mq_direct_issue_request(struct request *rq, blk_qc_t *cookie)
 {
 	int ret;
 	struct request_queue *q = rq->q;
-	struct blk_mq_hw_ctx *hctx = q->mq_ops->map_queue(q,
-			rq->mq_ctx->cpu);
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
 		.list = NULL,
@@ -1458,15 +1449,6 @@ run_queue:
 	return cookie;
 }
 
-/*
- * Default mapping to a software queue, since we use one per CPU.
- */
-struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q, const int cpu)
-{
-	return q->queue_hw_ctx[q->mq_map[cpu]];
-}
-EXPORT_SYMBOL(blk_mq_map_queue);
-
 static void blk_mq_free_rq_map(struct blk_mq_tag_set *set,
 		struct blk_mq_tags *tags, unsigned int hctx_idx)
 {
@@ -1800,7 +1782,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 		if (!cpu_online(i))
 			continue;
 
-		hctx = q->mq_ops->map_queue(q, i);
+		hctx = blk_mq_map_queue(q, i);
 
 		/*
 		 * Set local node, IFF we have more than one hw queue. If
@@ -1838,7 +1820,7 @@ static void blk_mq_map_swqueue(struct request_queue *q,
 			continue;
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
-		hctx = q->mq_ops->map_queue(q, i);
+		hctx = blk_mq_map_queue(q, i);
 
 		cpumask_set_cpu(i, hctx->cpumask);
 		ctx->index_hw = hctx->nr_ctx;
@@ -2303,7 +2285,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (set->queue_depth < set->reserved_tags + BLK_MQ_TAG_MIN)
 		return -EINVAL;
 
-	if (!set->ops->queue_rq || !set->ops->map_queue)
+	if (!set->ops->queue_rq)
 		return -EINVAL;
 
 	if (set->queue_depth > BLK_MQ_MAX_DEPTH) {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9087b11..ec774bf 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -52,6 +52,12 @@ extern int blk_mq_update_queue_map(unsigned int *map, unsigned int nr_queues,
 				   const struct cpumask *online_mask);
 extern int blk_mq_hw_queue_to_node(unsigned int *map, unsigned int);
 
+static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
+		int cpu)
+{
+	return q->queue_hw_ctx[q->mq_map[cpu]];
+}
+
 /*
  * sysfs helpers
  */
diff --git a/block/blk.h b/block/blk.h
index c37492f..74444c4 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -39,14 +39,9 @@ extern struct ida blk_queue_ida;
 static inline struct blk_flush_queue *blk_get_flush_queue(
 		struct request_queue *q, struct blk_mq_ctx *ctx)
 {
-	struct blk_mq_hw_ctx *hctx;
-
-	if (!q->mq_ops)
-		return q->fq;
-
-	hctx = q->mq_ops->map_queue(q, ctx->cpu);
-
-	return hctx->fq;
+	if (q->mq_ops)
+		return blk_mq_map_queue(q, ctx->cpu)->fq;
+	return q->fq;
 }
 
 static inline void __blk_get_queue(struct request_queue *q)
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c9f2107..cbdb3b1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1703,7 +1703,6 @@ static int loop_init_request(void *data, struct request *rq,
 
 static struct blk_mq_ops loop_mq_ops = {
 	.queue_rq       = loop_queue_rq,
-	.map_queue      = blk_mq_map_queue,
 	.init_request	= loop_init_request,
 };
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 2aca98e..3cc92e9 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3895,7 +3895,6 @@ exit_handler:
 
 static struct blk_mq_ops mtip_mq_ops = {
 	.queue_rq	= mtip_queue_rq,
-	.map_queue	= blk_mq_map_queue,
 	.init_request	= mtip_init_cmd,
 	.exit_request	= mtip_free_cmd,
 	.complete	= mtip_softirq_done_fn,
diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 75a7f88..7d3b7d6 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -393,7 +393,6 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 static struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
-	.map_queue      = blk_mq_map_queue,
 	.init_hctx	= null_init_hctx,
 	.complete	= null_softirq_done_fn,
 };
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 6c6519f..c1f84df 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3621,7 +3621,6 @@ static int rbd_init_request(void *data, struct request *rq,
 
 static struct blk_mq_ops rbd_mq_ops = {
 	.queue_rq	= rbd_queue_rq,
-	.map_queue	= blk_mq_map_queue,
 	.init_request	= rbd_init_request,
 };
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 93b1aaa..2dc5c96 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -542,7 +542,6 @@ static int virtblk_init_request(void *data, struct request *rq,
 
 static struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
-	.map_queue	= blk_mq_map_queue,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
 };
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 88ef6d4..9908597 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -909,7 +909,6 @@ out_busy:
 
 static struct blk_mq_ops blkfront_mq_ops = {
 	.queue_rq = blkif_queue_rq,
-	.map_queue = blk_mq_map_queue,
 };
 
 static void blkif_set_queue_limits(struct blkfront_info *info)
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 1ca7463..d1c3645 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -908,7 +908,6 @@ static int dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static struct blk_mq_ops dm_mq_ops = {
 	.queue_rq = dm_mq_queue_rq,
-	.map_queue = blk_mq_map_queue,
 	.complete = dm_softirq_done,
 	.init_request = dm_mq_init_request,
 };
diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index ebf46ad..d1e6931 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -351,7 +351,6 @@ static int ubiblock_init_request(void *data, struct request *req,
 static struct blk_mq_ops ubiblock_mq_ops = {
 	.queue_rq       = ubiblock_queue_rq,
 	.init_request	= ubiblock_init_request,
-	.map_queue      = blk_mq_map_queue,
 };
 
 static DEFINE_IDR(ubiblock_minor_idr);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8dcf5a9..086fd7e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1131,7 +1131,6 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 static struct blk_mq_ops nvme_mq_admin_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_complete_rq,
-	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
 	.exit_hctx      = nvme_admin_exit_hctx,
 	.init_request	= nvme_admin_init_request,
@@ -1141,7 +1140,6 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.complete	= nvme_complete_rq,
-	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
 	.timeout	= nvme_timeout,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ab545fb..9bbd886 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1531,7 +1531,6 @@ static void nvme_rdma_complete_rq(struct request *rq)
 static struct blk_mq_ops nvme_rdma_mq_ops = {
 	.queue_rq	= nvme_rdma_queue_rq,
 	.complete	= nvme_rdma_complete_rq,
-	.map_queue	= blk_mq_map_queue,
 	.init_request	= nvme_rdma_init_request,
 	.exit_request	= nvme_rdma_exit_request,
 	.reinit_request	= nvme_rdma_reinit_request,
@@ -1543,7 +1542,6 @@ static struct blk_mq_ops nvme_rdma_mq_ops = {
 static struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.queue_rq	= nvme_rdma_queue_rq,
 	.complete	= nvme_rdma_complete_rq,
-	.map_queue	= blk_mq_map_queue,
 	.init_request	= nvme_rdma_init_admin_request,
 	.exit_request	= nvme_rdma_exit_admin_request,
 	.reinit_request	= nvme_rdma_reinit_request,
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 395e60d..d5df77d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -273,7 +273,6 @@ static int nvme_loop_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 static struct blk_mq_ops nvme_loop_mq_ops = {
 	.queue_rq	= nvme_loop_queue_rq,
 	.complete	= nvme_loop_complete_rq,
-	.map_queue	= blk_mq_map_queue,
 	.init_request	= nvme_loop_init_request,
 	.init_hctx	= nvme_loop_init_hctx,
 	.timeout	= nvme_loop_timeout,
@@ -282,7 +281,6 @@ static struct blk_mq_ops nvme_loop_mq_ops = {
 static struct blk_mq_ops nvme_loop_admin_mq_ops = {
 	.queue_rq	= nvme_loop_queue_rq,
 	.complete	= nvme_loop_complete_rq,
-	.map_queue	= blk_mq_map_queue,
 	.init_request	= nvme_loop_init_admin_request,
 	.init_hctx	= nvme_loop_init_admin_hctx,
 	.timeout	= nvme_loop_timeout,
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c71344a..2cca9cf 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2077,7 +2077,6 @@ struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
 }
 
 static struct blk_mq_ops scsi_mq_ops = {
-	.map_queue	= blk_mq_map_queue,
 	.queue_rq	= scsi_queue_rq,
 	.complete	= scsi_softirq_done,
 	.timeout	= scsi_timeout,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a572227..d4d8bc8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -89,7 +89,6 @@ struct blk_mq_queue_data {
 };
 
 typedef int (queue_rq_fn)(struct blk_mq_hw_ctx *, const struct blk_mq_queue_data *);
-typedef struct blk_mq_hw_ctx *(map_queue_fn)(struct request_queue *, const int);
 typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
 typedef int (init_hctx_fn)(struct blk_mq_hw_ctx *, void *, unsigned int);
 typedef void (exit_hctx_fn)(struct blk_mq_hw_ctx *, unsigned int);
@@ -112,11 +111,6 @@ struct blk_mq_ops {
 	queue_rq_fn		*queue_rq;
 
 	/*
-	 * Map to specific hardware queue
-	 */
-	map_queue_fn		*map_queue;
-
-	/*
 	 * Called on request timeout
 	 */
 	timeout_fn		*timeout;
@@ -221,7 +215,6 @@ static inline u16 blk_mq_unique_tag_to_tag(u32 unique_tag)
 	return unique_tag & BLK_MQ_UNIQUE_TAG_MASK;
 }
 
-struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *, const int ctx_index);
 struct blk_mq_hw_ctx *blk_mq_alloc_single_hw_queue(struct blk_mq_tag_set *, unsigned int, int);
 
 int blk_mq_request_started(struct request *rq);
-- 
2.1.4

