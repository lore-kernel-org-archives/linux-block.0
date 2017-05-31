Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdEaMih (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 08:38:37 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 7/9] blk-mq: don't stop queue for quiescing
Date: Wed, 31 May 2017 20:37:04 +0800
Message-Id: <20170531123706.20885-8-ming.lei@redhat.com>
In-Reply-To: <20170531123706.20885-1-ming.lei@redhat.com>
References: <20170531123706.20885-1-ming.lei@redhat.com>
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
 block/blk-mq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1faddaf005e2..bcff1b184bbb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -169,8 +169,6 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	unsigned int i;
 	bool rcu = false;
 
-	__blk_mq_stop_hw_queues(q, true);
-
 	spin_lock_irq(q->queue_lock);
 	queue_flag_set(QUEUE_FLAG_QUIESCED, q);
 	spin_unlock_irq(q->queue_lock);
@@ -199,8 +197,6 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
 	queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
 	spin_unlock_irq(q->queue_lock);
 
-	blk_mq_start_stopped_hw_queues(q, true);
-
 	wake_up_all(&q->quiesce_wq);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
-- 
2.9.4
