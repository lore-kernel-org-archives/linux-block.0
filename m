Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdFEQBk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jun 2017 12:01:40 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 04/11] blk-mq: introduce blk_mq_unquiesce_queue
Date: Mon,  5 Jun 2017 23:59:18 +0800
Message-Id: <20170605155925.7896-5-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-1-ming.lei@redhat.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
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
 include/linux/blk-mq.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2da2cb8d9ff4..068962789dc4 100644
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
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 13d1196f492f..fc0fc45fc658 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -248,6 +248,7 @@ void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_quiesce_queue(struct request_queue *q);
+void blk_mq_unquiesce_queue(struct request_queue *q);
 void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
-- 
2.9.4
