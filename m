Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbdEaMiX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2017 08:38:23 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v3 6/9] blk-mq: update comments on blk_mq_quiesce_queue()
Date: Wed, 31 May 2017 20:37:03 +0800
Message-Id: <20170531123706.20885-7-ming.lei@redhat.com>
In-Reply-To: <20170531123706.20885-1-ming.lei@redhat.com>
References: <20170531123706.20885-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Actually what we want to get from blk_mq_quiesce_queue()
isn't only to wait for completion of all ongoing .queue_rq().

In the typical context of canceling requests, we need to
make sure that the following is done in the dispatch path
before starting to cancel requests:

	- failed dispatched request is finished
	- busy dispatched request is requeued, and the STARTED
	flag is cleared

So update comment to keep code, doc and our expection consistent.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 56ba7e7a8c60..1faddaf005e2 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -155,12 +155,13 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /**
- * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have finished
+ * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
  * @q: request queue.
  *
  * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Additionally, it is not prevented that
- * new queue_rq() calls occur unless the queue has been stopped first.
+ * callback function is invoked. Once this function is returned, we make
+ * sure no dispatch can happen until the queue is unquiesced via
+ * blk_mq_unquiesce_queue().
  */
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
-- 
2.9.4
