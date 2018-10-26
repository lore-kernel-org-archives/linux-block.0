Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
Date: Sat, 27 Oct 2018 00:01:10 +0800
Message-Id: <1540569671-6589-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

It is not necessary to issue request directly with bypass 'true' in
blk_mq_sched_insert_requests and insert the non-issued requests
itself. Just set bypass to 'false' and let blk_mq_try_issue_directly
handle them.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c |  8 +++-----
 block/blk-mq.c       | 10 +---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 29bfe80..23cd97e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -411,12 +411,10 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 		 * busy in case of 'none' scheduler, and this way may save
 		 * us one extra enqueue & dequeue to sw queue.
 		 */
-		if (!hctx->dispatch_busy && !e && !run_queue_async) {
+		if (!hctx->dispatch_busy && !e && !run_queue_async)
 			blk_mq_try_issue_list_directly(hctx, list);
-			if (list_empty(list))
-				return;
-		}
-		blk_mq_insert_requests(hctx, ctx, list);
+		else
+			blk_mq_insert_requests(hctx, ctx, list);
 	}
 
 	blk_mq_run_hw_queue(hctx, run_queue_async);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a81d2ca..71b829c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1802,15 +1802,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq);
-		if (ret != BLK_STS_OK) {
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				list_add(&rq->queuelist, list);
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		}
+		ret = blk_mq_try_issue_directly(hctx, rq, NULL, false);
 	}
 }
 
-- 
2.7.4
