Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V2 3/3] blk-mq: dequeue request one by one from sw queue iff hctx is busy
Date: Fri, 29 Jun 2018 16:12:52 +0800
Message-Id: <20180629081252.13836-4-ming.lei@redhat.com>
In-Reply-To: <20180629081252.13836-1-ming.lei@redhat.com>
References: <20180629081252.13836-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

It won't be efficient to dequeue request one by one from sw queue,
but we have to do that when queue is busy for better merge performance.

This patch takes EWMA to figure out if queue is busy, then only dequeue
request one by one from sw queue when queue is busy.

Kashyap verified that this patch basically brings back rand IO perf
on megasas_raid in case of none io scheduler. Meantime I tried this
patch on HDD, and not see obvious performance loss on sequential IO
test too.

Fixes: b347689ffbca ("blk-mq-sched: improve dispatching from sw queue")
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Reported-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c   | 11 ++---------
 block/blk-mq.c         | 24 +++++++++++++++++++++++-
 include/linux/blk-mq.h |  1 +
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index f5745acc2d98..8fbf3db32666 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -219,15 +219,8 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 		}
 	} else if (has_sched_dispatch) {
 		blk_mq_do_dispatch_sched(hctx);
-	} else if (q->mq_ops->get_budget) {
-		/*
-		 * If we need to get budget before queuing request, we
-		 * dequeue request one by one from sw queue for avoiding
-		 * to mess up I/O merge when dispatch runs out of resource.
-		 *
-		 * TODO: get more budgets, and dequeue more requests in
-		 * one time.
-		 */
+	} else if (READ_ONCE(hctx->busy)) {
+		/* dequeue request one by one from sw queue if queue is busy */
 		blk_mq_do_dispatch_ctx(hctx);
 	} else {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 359382b59d40..a1a188000d44 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1074,6 +1074,25 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	return true;
 }
 
+/* update queue busy with EWMA (7/8 * ewma(t)  + 1/8 * busy(t + 1)) */
+static void blk_mq_update_hctx_busy(struct blk_mq_hw_ctx *hctx, unsigned int busy)
+{
+	const unsigned weight = 8;
+	const unsigned factor = 4;
+	unsigned int ewma;
+
+	if (hctx->queue->elevator)
+		return;
+
+	ewma = READ_ONCE(hctx->busy);
+
+	ewma *= weight - 1;
+	ewma += busy << factor;
+	ewma /= weight;
+
+	WRITE_ONCE(hctx->busy, ewma);
+}
+
 #define BLK_MQ_RESOURCE_DELAY	3		/* ms units */
 
 /*
@@ -1210,8 +1229,11 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		else if (needs_restart && (ret == BLK_STS_RESOURCE))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
+		blk_mq_update_hctx_busy(hctx, 1);
+
 		return false;
-	}
+	} else
+		blk_mq_update_hctx_busy(hctx, 0);
 
 	/*
 	 * If the host/device is unable to accept more work, inform the
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb74222..a5113e22d720 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -34,6 +34,7 @@ struct blk_mq_hw_ctx {
 
 	struct sbitmap		ctx_map;
 
+	unsigned int		busy;
 	struct blk_mq_ctx	*dispatch_from;
 
 	struct blk_mq_ctx	**ctxs;
-- 
2.9.5
