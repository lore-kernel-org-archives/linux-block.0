Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933418AbdKBPZI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Nov 2017 11:25:08 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>, linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: [PATCH V3 1/7] blk-mq: put the driver tag of nxt rq before first one is requeued
Date: Thu,  2 Nov 2017 23:24:32 +0800
Message-Id: <20171102152438.25324-2-ming.lei@redhat.com>
In-Reply-To: <20171102152438.25324-1-ming.lei@redhat.com>
References: <20171102152438.25324-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Jianchao Wang <jianchao.w.wang@oracle.com>

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
index e4d2490f4e7e..fe14b28760eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1091,7 +1091,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		bool got_budget)
 {
 	struct blk_mq_hw_ctx *hctx;
-	struct request *rq;
+	struct request *rq, *nxt;
 	int errors, queued;
 
 	if (list_empty(list))
@@ -1153,14 +1153,20 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
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
@@ -1184,13 +1190,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
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
2.9.5
