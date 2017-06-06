Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751281AbdFFPYj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Jun 2017 11:24:39 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v5 11/12] blk-mq: clarify dispatch may not be drained/blocked by stopping queue
Date: Tue,  6 Jun 2017 23:22:09 +0800
Message-Id: <20170606152210.22806-12-ming.lei@redhat.com>
In-Reply-To: <20170606152210.22806-1-ming.lei@redhat.com>
References: <20170606152210.22806-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

BLK_MQ_S_STOPPED may not be observed in other concurrent I/O paths,
we can't guarantee that dispatching won't happen after returning
from the APIs of stopping queue.

So clarify the fact and avoid potential misuse.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4eb849bf1d85..7b584bf7d310 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1186,6 +1186,15 @@ static void __blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx, bool sync)
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
+/*
+ * This function is often used for pausing .queue_rq() by driver when
+ * there isn't enough resource or some conditions aren't satisfied, and
+ * BLK_MQ_RQ_QUEUE_BUSY is usually returned.
+ *
+ * We do not guarantee that dispatch can be drained or blocked
+ * after blk_mq_stop_hw_queue() returns. Please use
+ * blk_mq_quiesce_queue() for that requirement.
+ */
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	__blk_mq_stop_hw_queue(hctx, false);
@@ -1201,6 +1210,15 @@ static void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync)
 		__blk_mq_stop_hw_queue(hctx, sync);
 }
 
+/*
+ * This function is often used for pausing .queue_rq() by driver when
+ * there isn't enough resource or some conditions aren't satisfied, and
+ * BLK_MQ_RQ_QUEUE_BUSY is usually returned.
+ *
+ * We do not guarantee that dispatch can be drained or blocked
+ * after blk_mq_stop_hw_queues() returns. Please use
+ * blk_mq_quiesce_queue() for that requirement.
+ */
 void blk_mq_stop_hw_queues(struct request_queue *q)
 {
 	__blk_mq_stop_hw_queues(q, false);
-- 
2.9.4
