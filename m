Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S941653AbdEYEWP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2017 00:22:15 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: [PATCH 7/7] blk-mq: update comments on blk_mq_quiesce_queue()
Date: Thu, 25 May 2017 12:21:31 +0800
Message-Id: <20170525042131.13172-8-ming.lei@redhat.com>
In-Reply-To: <20170525042131.13172-1-ming.lei@redhat.com>
References: <20170525042131.13172-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Actually what we want to get from blk_mq_quiesce_queue()
isn't only to wait for completion of all ongooing .queue_rq().

In the typical context of canceling requests, we need to
make sure that the following is done in the dispatch path
before starting to cancel requests:
	- failed dispatched request is freeed
	- busy dispatched request is requeued, and the STARTED
	flag is cleared

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6316efb42e04..a8f185f7e133 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -155,12 +155,12 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
 
 /**
- * blk_mq_quiesce_queue() - wait until all ongoing queue_rq calls have finished
+ * blk_mq_quiesce_queue() - wait until all ongoing dispatching have finished
  * @q: request queue.
  *
  * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Additionally, it is not prevented that
- * new queue_rq() calls occur unless the queue has been stopped first.
+ * callback function is invoked. Once this function is returned, we make
+ * sure no dispatching can happen.
  */
 void blk_mq_quiesce_queue(struct request_queue *q)
 {
-- 
2.9.4
