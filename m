Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH, RESEND] blk-mq: Remove blk_mq_queue_data.list
Date: Wed, 5 Apr 2017 08:39:18 -0700
Message-ID: <20170405153918.22350-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

The block layer core sets blk_mq_queue_data.list but no block
drivers read that member. Hence remove it and also the code that
is used to set this member.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq.c         | 17 -----------------
 include/linux/blk-mq.h |  1 -
 2 files changed, 18 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 061fc2cc88d3..f7cd3208bcdf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -984,17 +984,9 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 {
 	struct request_queue *q = hctx->queue;
 	struct request *rq;
-	LIST_HEAD(driver_list);
-	struct list_head *dptr;
 	int errors, queued, ret = BLK_MQ_RQ_QUEUE_OK;
 
 	/*
-	 * Start off with dptr being NULL, so we start the first request
-	 * immediately, even if we have more pending.
-	 */
-	dptr = NULL;
-
-	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
 	errors = queued = 0;
@@ -1026,7 +1018,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 		list_del_init(&rq->queuelist);
 
 		bd.rq = rq;
-		bd.list = dptr;
 
 		/*
 		 * Flag last if we have no more requests, or if we have more
@@ -1062,13 +1053,6 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 
 		if (ret == BLK_MQ_RQ_QUEUE_BUSY)
 			break;
-
-		/*
-		 * We've done the first request. If we have more than 1
-		 * left in the list, set dptr to defer issue.
-		 */
-		if (!dptr && list->next != list->prev)
-			dptr = &driver_list;
 	}
 
 	hctx->dispatched[queued_to_index(queued)]++;
@@ -1451,7 +1435,6 @@ static void __blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
 	struct request_queue *q = rq->q;
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
-		.list = NULL,
 		.last = 1
 	};
 	struct blk_mq_hw_ctx *hctx;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ea2e9dcd3aef..bdea90d75274 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -81,7 +81,6 @@ struct blk_mq_tag_set {
 
 struct blk_mq_queue_data {
 	struct request *rq;
-	struct list_head *list;
 	bool last;
 };
 
-- 
2.12.0
