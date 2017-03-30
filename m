Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: fix schedule-under-preempt for blocking drivers
Message-ID: <b298fcf4-47bc-b2e1-7c8f-b4affe347501@kernel.dk>
Date: Thu, 30 Mar 2017 12:00:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Commit a4d907b6a33b unified the single and multi queue request handlers,
but in the process, it also screwed up the locking balance and calls
blk_mq_try_issue_directly() with the ctx preempt lock held. This is a
problem for drivers that have set BLK_MQ_F_BLOCKING, since now they
can't reliably sleep.

While in there, protect against similar issues in the future, by adding
a might_sleep() trigger in the BLOCKING path for direct issue or queue
run.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Tested-by: Josef Bacik <josef@toxicpanda.com>
Fixes: a4d907b6a33b ("blk-mq: streamline blk_mq_make_request")
Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e6ac774b0e41..d4d6ed4e7250 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1122,6 +1122,8 @@ static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
 		blk_mq_sched_dispatch_requests(hctx);
 		rcu_read_unlock();
 	} else {
+		might_sleep();
+
 		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
 		blk_mq_sched_dispatch_requests(hctx);
 		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
@@ -1496,7 +1498,11 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		__blk_mq_try_issue_directly(rq, cookie, false);
 		rcu_read_unlock();
 	} else {
-		unsigned int srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
+		unsigned int srcu_idx;
+
+		might_sleep();
+
+		srcu_idx = srcu_read_lock(&hctx->queue_rq_srcu);
 		__blk_mq_try_issue_directly(rq, cookie, true);
 		srcu_read_unlock(&hctx->queue_rq_srcu, srcu_idx);
 	}
@@ -1596,18 +1602,23 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			list_del_init(&same_queue_rq->queuelist);
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 
+		blk_mq_put_ctx(data.ctx);
+
 		if (same_queue_rq)
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
 					&cookie);
+
+		return cookie;
 	} else if (q->nr_hw_queues > 1 && is_sync) {
+		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+		return cookie;
 	} else if (q->elevator) {
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_sched_insert_request(rq, false, true, true, true);
-	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
+	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio))
 		blk_mq_run_hw_queue(data.hctx, true);
-	}
 
 	blk_mq_put_ctx(data.ctx);
 	return cookie;
