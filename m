Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdFEQCf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jun 2017 12:02:35 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 09/11] blk-mq: don't stop queue for quiescing
Date: Mon,  5 Jun 2017 23:59:23 +0800
Message-Id: <20170605155925.7896-10-ming.lei@redhat.com>
In-Reply-To: <20170605155925.7896-1-ming.lei@redhat.com>
References: <20170605155925.7896-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Queue can be started by other blk-mq APIs and can be used in
different cases, this limits uses of blk_mq_quiesce_queue()
if it is based on stopping queue, and make its usage very
difficult, especially users have to use the stop queue APIs
carefully for avoiding to break blk_mq_quiesce_queue().

We have applied the QUIESCED flag for draining and blocking
dispatch, so it isn't necessary to stop queue any more.

After stopping queue is removed, blk_mq_quiesce_queue() can
be used safely and easily, then users won't worry about queue
restarting during quiescing at all.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 9 +++------
 include/linux/blk-mq.h | 2 --
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2177e8713ec..2788cacdaa1e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -169,11 +169,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	unsigned int i;
 	bool rcu = false;
 
-	__blk_mq_stop_hw_queues(q, true);
-
-	spin_lock_irq(q->queue_lock);
-	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
-	spin_unlock_irq(q->queue_lock);
+	blk_mq_quiesce_queue_nowait(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
@@ -199,7 +195,8 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 	queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
 	spin_unlock_irq(q->queue_lock);
 
-	blk_mq_start_stopped_hw_queues(q, true);
+	/* dispatch requests which are inserted during quiescing */
+	blk_mq_run_hw_queues(q, true);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dc96ce3f5425..105d70630947 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -274,8 +274,6 @@ static inline void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 	spin_lock_irq(q->queue_lock);
 	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
 	spin_unlock_irq(q->queue_lock);
-
-	blk_mq_stop_hw_queues(q);
 }
 
 /*
-- 
2.9.4
