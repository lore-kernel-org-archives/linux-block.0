Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756345AbdGKSWO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 14:22:14 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
Date: Wed, 12 Jul 2017 02:21:01 +0800
Message-Id: <20170711182103.11461-5-ming.lei@redhat.com>
In-Reply-To: <20170711182103.11461-1-ming.lei@redhat.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When .queue_rq() returns BLK_STS_RESOURCE(BUSY), we can
consider that there is congestion in either low level
driver or hardware.

This patch uses EWMA to estimate this congestion threshold,
then this threshold can be used to detect/avoid congestion.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 14 ++++++++++++++
 block/blk-mq.h         |  9 +++++++++
 include/linux/blk-mq.h |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6e0fc80aa151..da50c187c508 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -976,6 +976,18 @@ static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
 	return true;
 }
 
+static void blk_mq_update_req_dispatch_busy(struct blk_mq_hw_ctx *hctx)
+{
+	struct sbitmap_queue *sbq;
+	unsigned depth;
+
+	sbq = &hctx->tags->bitmap_tags;
+	depth = sbitmap_weight(&sbq->sb);
+
+	/* use EWMA to estimate a threshold for detecting congestion */
+	ewma_add(hctx->avg_busy_threshold, depth, 8, 0);
+}
+
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 {
 	struct blk_mq_hw_ctx *hctx;
@@ -1064,6 +1076,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 
 		spin_lock(&hctx->lock);
 		list_splice_init(list, &hctx->dispatch);
+		blk_mq_update_req_dispatch_busy(hctx);
 		spin_unlock(&hctx->lock);
 
 		/*
@@ -1468,6 +1481,7 @@ static void blk_mq_direct_dispatch(struct blk_mq_hw_ctx *hctx,
 {
 	spin_lock(&hctx->lock);
 	list_add(&rq->queuelist, &hctx->dispatch);
+	blk_mq_update_req_dispatch_busy(hctx);
 	spin_unlock(&hctx->lock);
 
 	blk_mq_run_hw_queue(hctx, false);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 60b01c0309bc..c4516d2a2d2c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -133,4 +133,13 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
+/* borrowed from bcache */
+#define ewma_add(ewma, val, weight, factor)                             \
+({                                                                      \
+        (ewma) *= (weight) - 1;                                         \
+        (ewma) += (val) << factor;                                      \
+        (ewma) /= (weight);                                             \
+        (ewma) >> factor;                                               \
+})
+
 #endif
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 14542308d25b..8694fb39cd80 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -22,6 +22,8 @@ struct blk_mq_hw_ctx {
 
 	unsigned long		flags;		/* BLK_MQ_F_* flags */
 
+	unsigned long		avg_busy_threshold;
+
 	void			*sched_data;
 	struct request_queue	*queue;
 	struct blk_flush_queue	*fq;
-- 
2.9.4
