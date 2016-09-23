Return-Path: <BATV+2ec0b7ee621439cf862d+4779+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: skip unmapped queues in blk_mq_alloc_request_hctx
Date: Fri, 23 Sep 2016 09:26:58 -0700
Message-Id: <1474648018-3920-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This provides the caller a feedback that a given hctx is not mapped and thus
no command can be sent on it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Steve Wise <swise@opengridcomputing.com>
---
 block/blk-mq.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9b8007..7b430ab 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -266,17 +266,29 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
 	if (ret)
 		return ERR_PTR(ret);
 
+	/*
+	 * Check if the hardware context is actually mapped to anything.
+	 * If not tell the caller that it should skip this queue.
+	 */
 	hctx = q->queue_hw_ctx[hctx_idx];
+	if (!blk_mq_hw_queue_mapped(hctx)) {
+		ret = -EXDEV;
+		goto out_queue_exit;
+	}
 	ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
 
 	blk_mq_set_alloc_data(&alloc_data, q, flags, ctx, hctx);
 	rq = __blk_mq_alloc_request(&alloc_data, rw, 0);
 	if (!rq) {
-		blk_queue_exit(q);
-		return ERR_PTR(-EWOULDBLOCK);
+		ret = -EWOULDBLOCK;
+		goto out_queue_exit;
 	}
 
 	return rq;
+
+out_queue_exit:
+	blk_queue_exit(q);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
-- 
2.1.4
