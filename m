Return-Path: <BATV+10e0b2ba6b8830823af0+4672+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: keith.busch@intel.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@lightbits.io,
	ming.l@ssi.samsung.com
Subject: [PATCH 02/11] blk-mq: add blk_mq_alloc_request_hctx
Date: Wed,  8 Jun 2016 14:30:57 +0200
Message-Id: <1465389066-19119-3-git-send-email-hch@lst.de>
In-Reply-To: <1465389066-19119-1-git-send-email-hch@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

For some protocols like NVMe over Fabrics we need to be able to send
initialization commands to a specific queue.

Based on an earlier patch from Christoph Hellwig <hch@lst.de>.

Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
[hch: disallow sleeping allocation, req_op fixes]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 13f4603..7aa60c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -267,6 +267,45 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 }
 EXPORT_SYMBOL(blk_mq_alloc_request);
 
+struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
+		unsigned int flags, unsigned int hctx_idx)
+{
+	struct blk_mq_hw_ctx *hctx;
+	struct blk_mq_ctx *ctx;
+	struct request *rq;
+	struct blk_mq_alloc_data alloc_data;
+	int ret;
+
+	/*
+	 * If the tag allocator sleeps we could get an allocation for a
+	 * different hardware context.  No need to complicate the low level
+	 * allocator for this for the rare use case of a command tied to
+	 * a specific queue.
+	 */
+	if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
+		return ERR_PTR(-EINVAL);
+
+	if (hctx_idx >= q->nr_hw_queues)
+		return ERR_PTR(-EIO);
+
+	ret = blk_queue_enter(q, true);
+	if (ret)
+		return ERR_PTR(ret);
+
+	hctx = q->queue_hw_ctx[hctx_idx];
+	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
+
+	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
+	rq = __blk_mq_alloc_request(&alloc_data, rw, 0);
+	if (!rq) {
+		blk_queue_exit(q);
+		return ERR_PTR(-EWOULDBLOCK);
+	}
+
+	return rq;
+}
+EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
+
 static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
 				  struct blk_mq_ctx *ctx, struct request *rq)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index faa7d5c2..e43bbff 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -198,6 +198,8 @@ enum {
 
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		unsigned int flags);
+struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int op,
+		unsigned int flags, unsigned int hctx_idx);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
 struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags);
 
-- 
2.1.4
