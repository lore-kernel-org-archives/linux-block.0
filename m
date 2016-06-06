Return-Path: <BATV+65f7e0ff3112b2479d70+4670+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	keith.busch@intel.com
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lin <ming.l@ssi.samsung.com>
Subject: [PATCH 1/8] blk-mq: add blk_mq_alloc_request_hctx
Date: Mon,  6 Jun 2016 23:21:52 +0200
Message-Id: <1465248119-17875-2-git-send-email-hch@lst.de>
In-Reply-To: <1465248119-17875-1-git-send-email-hch@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

For some protocols like NVMe over Fabrics we need to be able to send
initialization commands to a specific queue.

Based on an earlier patch from Christoph Hellwig <hch@lst.de>.

Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 33 +++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 29cbc1b..7bb45ed 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -266,6 +266,39 @@ struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
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
+	ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
+	if (ret)
+		return ERR_PTR(ret);
+
+	hctx = q->queue_hw_ctx[hctx_idx];
+	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
+
+	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
+
+	rq = __blk_mq_alloc_request(&alloc_data, rw);
+	if (!rq && !(flags & BLK_MQ_REQ_NOWAIT)) {
+		__blk_mq_run_hw_queue(hctx);
+
+		rq =  __blk_mq_alloc_request(&alloc_data, rw);
+	}
+	if (!rq) {
+		blk_queue_exit(q);
+		return ERR_PTR(-EWOULDBLOCK);
+	}
+
+	return rq;
+}
+EXPORT_SYMBOL(blk_mq_alloc_request_hctx);
+
 static void __blk_mq_free_request(struct blk_mq_hw_ctx *hctx,
 				  struct blk_mq_ctx *ctx, struct request *rq)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2498fdf..6bf8735 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -196,6 +196,8 @@ enum {
 
 struct request *blk_mq_alloc_request(struct request_queue *q, int rw,
 		unsigned int flags);
+struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
+		unsigned int flags, unsigned int hctx_idx);
 struct request *blk_mq_tag_to_rq(struct blk_mq_tags *tags, unsigned int tag);
 struct cpumask *blk_mq_tags_cpumask(struct blk_mq_tags *tags);
 
-- 
2.1.4
