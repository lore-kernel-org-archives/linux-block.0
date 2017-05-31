Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751022AbdEaMir (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 08:38:47 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 8/9] blk-mq: clarify dispatch may not be drained/blocked by stopping queue
Date: Wed, 31 May 2017 20:37:05 +0800
Message-Id: <20170531123706.20885-9-ming.lei@redhat.com>
In-Reply-To: <20170531123706.20885-1-ming.lei@redhat.com>
References: <20170531123706.20885-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

BLK_MQ_S_STOPPED may not be observed in other concurrent I/O paths,
we can't guarantee that dispatching won't happen after returning
from the APIs of stopping queue.

So clarify the fact and avoid potential misuse.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bcff1b184bbb..352aaaf0bcf9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1187,6 +1187,11 @@ static void __blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx, bool sync)
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
+/*
+ * We do not guarantee that dispatch can be drained or blocked
+ * after blk_mq_stop_hw_queue() returns. Please use
+ * blk_mq_quiesce_queue() for that requirement.
+ */
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	__blk_mq_stop_hw_queue(hctx, false);
@@ -1202,6 +1207,11 @@ static void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync)
 		__blk_mq_stop_hw_queue(hctx, sync);
 }
 
+/*
+ * We do not guarantee that dispatch can be drained or blocked
+ * after blk_mq_stop_hw_queues() returns. Please use
+ * blk_mq_quiesce_queue() for that requirement.
+ */
 void blk_mq_stop_hw_queues(struct request_queue *q)
 {
 	__blk_mq_stop_hw_queues(q, false);
-- 
2.9.4
