Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937011AbdEZDIu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 23:08:50 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 6/6] blk-mq: clarify dispatching may not be drained/blocked by stopping queue
Date: Fri, 26 May 2017 11:07:39 +0800
Message-Id: <20170526030740.26959-7-ming.lei@redhat.com>
In-Reply-To: <20170526030740.26959-1-ming.lei@redhat.com>
References: <20170526030740.26959-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

BLK_MQ_S_STOPPED may be not observed in other concurrent I/O paths,
we can't guarantee that dispatching won't happen after queue
is stopped.

So clarify the fact and avoid potential misuse.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 900eb91e0ece..32bed5bac7da 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1240,6 +1240,11 @@ static void __blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx, bool sync)
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
+/*
+ * Do not expect that dispatching or .queue_rq() can be blocked
+ * after blk_mq_stop_hw_queue() returns. Please use
+ * blk_mq_quiesce_queue() for that requirement.
+ */
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
 	__blk_mq_stop_hw_queue(hctx, false);
@@ -1255,6 +1260,11 @@ static void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync)
 		__blk_mq_stop_hw_queue(hctx, sync);
 }
 
+/*
+ * Do not expect that dispatching or .queue_rq() can be blocked
+ * after blk_mq_stop_hw_queues() returns. Please use
+ * blk_mq_quiesce_queue() for that requirement.
+ */
 void blk_mq_stop_hw_queues(struct request_queue *q)
 {
 	__blk_mq_stop_hw_queues(q, false);
-- 
2.9.4
