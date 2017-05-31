Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdEaMhd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 08:37:33 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 1/9] blk-mq: introduce blk_mq_unquiesce_queue
Date: Wed, 31 May 2017 20:36:58 +0800
Message-Id: <20170531123706.20885-2-ming.lei@redhat.com>
In-Reply-To: <20170531123706.20885-1-ming.lei@redhat.com>
References: <20170531123706.20885-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blk_mq_start_stopped_hw_queues() is used implictely
as counterpart of blk_mq_quiesce_queue() for unquiescing queue,
so we introduce blk_mq_unquiesce_queue() and make it
as counterpart of blk_mq_quiesce_queue() explicitely.

This function is for improving the current quiescing mechanism
in the following patches.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 13 +++++++++++++
 include/linux/blkdev.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 22438d5036a3..2f0d80bad7be 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -181,6 +181,19 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
+/*
+ * blk_mq_unquiesce_queue() - counterpart of blk_mq_quiesce_queue()
+ * @q: request queue.
+ *
+ * This function recovers queue into the state before quiescing
+ * which is done by blk_mq_quiesce_queue.
+ */
+void blk_mq_unquiesce_queue(struct request_queue *q)
+{
+	blk_mq_start_stopped_hw_queues(q, true);
+}
+EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
+
 void blk_mq_wake_waiters(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ab92c4ea138b..41291be82ac4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -964,6 +964,7 @@ extern void __blk_run_queue_uncond(struct request_queue *q);
 extern void blk_run_queue(struct request_queue *);
 extern void blk_run_queue_async(struct request_queue *q);
 extern void blk_mq_quiesce_queue(struct request_queue *q);
+extern void blk_mq_unquiesce_queue(struct request_queue *q);
 extern int blk_rq_map_user(struct request_queue *, struct request *,
 			   struct rq_map_data *, void __user *, unsigned long,
 			   gfp_t);
-- 
2.9.4
