Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: [PATCH] blk-mq: put the driver tag of nxt rq before first one is requeued
Date: Wed, 13 Sep 2017 01:14:35 +0800
Message-Id: <1505236475-9209-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

When free the driver tag of the next rq with I/O scheduler
configured, it get the first entry of the list, however, at the
moment, the failed rq has been requeued at the head of the list.
The rq it gets is the failed rq not the next rq.
Free the driver tag of next rq before the failed one is requeued
in the failure branch of queue_rq callback and it is just needed
there.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4603b11..19f848e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -983,7 +983,7 @@ static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 {
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
+	struct request *rq, *nxt;
 	int errors, queued;
 
 	if (list_empty(list))
@@ -1029,14 +1029,20 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 		if (list_empty(list))
 			bd.last = true;
 		else {
-			struct request *nxt;
-
 			nxt = list_first_entry(list, struct request, queuelist);
 			bd.last = !blk_mq_get_driver_tag(nxt, NULL, false);
 		}
 
 		ret = q->mq_ops->queue_rq(hctx, &bd);
 		if (ret == BLK_STS_RESOURCE) {
+			/*
+			 * If an I/O scheduler has been configured and we got a
+			 * driver tag for the next request already, free it again.
+			 */
+			if (!list_empty(list)) {
+				nxt = list_first_entry(list, struct request, queuelist);
+				blk_mq_put_driver_tag(nxt);
+			}
 			blk_mq_put_driver_tag_hctx(hctx, rq);
 			list_add(&rq->queuelist, list);
 			__blk_mq_requeue_request(rq);
@@ -1059,13 +1065,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 	 * that is where we will continue on next queue run.
 	 */
 	if (!list_empty(list)) {
-		/*
-		 * If an I/O scheduler has been configured and we got a driver
-		 * tag for the next request already, free it again.
-		 */
-		rq = list_first_entry(list, struct request, queuelist);
-		blk_mq_put_driver_tag(rq);
-
 		spin_lock(&hctx->lock);
 		list_splice_init(list, &hctx->dispatch);
 		spin_unlock(&hctx->lock);
-- 
2.7.4
