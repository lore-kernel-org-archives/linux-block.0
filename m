Return-Path: <hch@lst.de>
Date: Wed, 8 Jun 2016 13:56:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lin <mlin@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	keith.busch@intel.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_alloc_request_hctx
Message-ID: <20160608115633.GB30912@lst.de>
References: <1465248119-17875-1-git-send-email-hch@lst.de> <1465248119-17875-2-git-send-email-hch@lst.de> <5757A3D2.1030003@kernel.dk> <1465363236.10841.13.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465363236.10841.13.camel@kernel.org>
List-ID: <linux-block@vger.kernel.org>

What we really nee to do is to always set the NOWAIT flag (we have a
reserved tag for connect anyway), and thus never trigger the code
deep down in bt_get that might switch to a different hctx.

Below is the version that I've tested together with the NVMe change
to use the NOWAIT flag:

---
>From 2346a4fdcc57c70a671e1329f7550d91d4e9d8a8 Mon Sep 17 00:00:00 2001
From: Ming Lin <ming.l@ssi.samsung.com>
Date: Mon, 30 Nov 2015 19:45:48 +0100
Subject: blk-mq: add blk_mq_alloc_request_hctx

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
