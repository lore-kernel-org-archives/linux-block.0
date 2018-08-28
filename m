Return-Path: <ianwmorrison@gmail.com>
Return-Path: <ianwmorrison@gmail.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kashyap.desai@broadcom.com,
	loberman@redhat.com,
	osandov@fb.com,
	hch@lst.de,
	bart.vanassche@wdc.com,
	hare@suse.de,
	ming.lei@redhat.com,
	ianwmorrison@gmail.com
Subject: [PATCH] Revert "blk-mq: issue directly if hw queue isn't busy in case of 'none'"
Date: Wed, 29 Aug 2018 01:47:27 +1000
Message-Id: <20180828154727.3589-1-ianwmorrison@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Kernel oops when booting on Bay and Cherry Trail devices
such as Intel Compute Stick. Bisected as:

commit 6ce3dd6eec11 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")

This patch reverts the above commit.

Signed-off-by: Ian W MORRISON <ianwmorrison@gmail.com>
---
 block/blk-mq-sched.c | 13 +------------
 block/blk-mq.c       | 27 +--------------------------
 block/blk-mq.h       |  2 --
 3 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 29bfe8017a2d..3204c39cb39f 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -405,19 +405,8 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 
 	if (e && e->type->ops.mq.insert_requests)
 		e->type->ops.mq.insert_requests(hctx, list, false);
-	else {
-		/*
-		 * try to issue requests directly if the hw queue isn't
-		 * busy in case of 'none' scheduler, and this way may save
-		 * us one extra enqueue & dequeue to sw queue.
-		 */
-		if (!hctx->dispatch_busy && !e && !run_queue_async) {
-			blk_mq_try_issue_list_directly(hctx, list);
-			if (list_empty(list))
-				return;
-		}
+	else
 		blk_mq_insert_requests(hctx, ctx, list);
-	}
 
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..09e4611d330d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1693,16 +1693,13 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	ret = q->mq_ops->queue_rq(hctx, &bd);
 	switch (ret) {
 	case BLK_STS_OK:
-		blk_mq_update_dispatch_busy(hctx, false);
 		*cookie = new_cookie;
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
-		blk_mq_update_dispatch_busy(hctx, true);
 		__blk_mq_requeue_request(rq);
 		break;
 	default:
-		blk_mq_update_dispatch_busy(hctx, false);
 		*cookie = BLK_QC_T_NONE;
 		break;
 	}
@@ -1785,27 +1782,6 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 	return ret;
 }
 
-void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
-		struct list_head *list)
-{
-	while (!list_empty(list)) {
-		blk_status_t ret;
-		struct request *rq = list_first_entry(list, struct request,
-				queuelist);
-
-		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq);
-		if (ret != BLK_STS_OK) {
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				list_add(&rq->queuelist, list);
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		}
-	}
-}
-
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -1906,8 +1882,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
 		}
-	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
-			!data.hctx->dispatch_busy)) {
+	} else if (q->nr_hw_queues > 1 && is_sync) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9497b47e2526..bc2b24735ed4 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -64,8 +64,6 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 
 /* Used by blk_insert_cloned_request() to issue request directly */
 blk_status_t blk_mq_request_issue_directly(struct request *rq);
-void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
-				    struct list_head *list);
 
 /*
  * CPU -> queue mappings
-- 
2.17.1
