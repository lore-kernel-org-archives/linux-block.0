Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34197 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbdDETCv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2017 15:02:51 -0400
Received: by mail-pg0-f47.google.com with SMTP id 21so12953131pgg.1
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2017 12:02:50 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v3 1/8] blk-mq: use the right hctx when getting a driver tag fails
Date: Wed,  5 Apr 2017 12:01:29 -0700
Message-Id: <d1b5da71a5cba1f17d4eaafb207547a4651f81a9.1491418411.git.osandov@fb.com>
In-Reply-To: <cover.1491418411.git.osandov@fb.com>
References: <cover.1491418411.git.osandov@fb.com>
In-Reply-To: <cover.1491418411.git.osandov@fb.com>
References: <cover.1491418411.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

While dispatching requests, if we fail to get a driver tag, we mark the
hardware queue as waiting for a tag and put the requests on a
hctx->dispatch list to be run later when a driver tag is freed. However,
blk_mq_dispatch_rq_list() may dispatch requests from multiple hardware
queues if using a single-queue scheduler with a multiqueue device. If
blk_mq_get_driver_tag() fails, it doesn't update the hardware queue we
are processing. This means we end up using the hardware queue of the
previous request, which may or may not be the same as that of the
current request. If it isn't, the wrong hardware queue will end up
waiting for a tag, and the requests will be on the wrong dispatch list,
leading to a hang.

The fix is twofold:

1. Make sure we save which hardware queue we were trying to get a
   request for in blk_mq_get_driver_tag() regardless of whether it
   succeeds or not.
2. Make blk_mq_dispatch_rq_list() take a request_queue instead of a
   blk_mq_hw_queue to make it clear that it must handle multiple
   hardware queues, since I've already messed this up on a couple of
   occasions.

This didn't appear in testing with nvme and mq-deadline because nvme has
more driver tags than the default number of scheduler tags. However,
with the blk_mq_update_nr_hw_queues() fix, it showed up with nbd.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-sched.c |  9 +++++----
 block/blk-mq.c       | 25 +++++++++++++------------
 block/blk-mq.h       |  2 +-
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 09af8ff18719..fc00f00898d3 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -171,7 +171,8 @@ void blk_mq_sched_put_request(struct request *rq)
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 {
-	struct elevator_queue *e = hctx->queue->elevator;
+	struct request_queue *q = hctx->queue;
+	struct elevator_queue *e = q->elevator;
 	const bool has_sched_dispatch = e && e->type->ops.mq.dispatch_request;
 	bool did_work = false;
 	LIST_HEAD(rq_list);
@@ -203,10 +204,10 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 */
 	if (!list_empty(&rq_list)) {
 		blk_mq_sched_mark_restart_hctx(hctx);
-		did_work = blk_mq_dispatch_rq_list(hctx, &rq_list);
+		did_work = blk_mq_dispatch_rq_list(q, &rq_list);
 	} else if (!has_sched_dispatch) {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
-		blk_mq_dispatch_rq_list(hctx, &rq_list);
+		blk_mq_dispatch_rq_list(q, &rq_list);
 	}
 
 	/*
@@ -222,7 +223,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 			if (!rq)
 				break;
 			list_add(&rq->queuelist, &rq_list);
-		} while (blk_mq_dispatch_rq_list(hctx, &rq_list));
+		} while (blk_mq_dispatch_rq_list(q, &rq_list));
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f7cd3208bcdf..09cff6d1ba76 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -863,12 +863,8 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 		.flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
 	};
 
-	if (rq->tag != -1) {
-done:
-		if (hctx)
-			*hctx = data.hctx;
-		return true;
-	}
+	if (rq->tag != -1)
+		goto done;
 
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
 		data.flags |= BLK_MQ_REQ_RESERVED;
@@ -880,10 +876,12 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 			atomic_inc(&data.hctx->nr_active);
 		}
 		data.hctx->tags->rqs[rq->tag] = rq;
-		goto done;
 	}
 
-	return false;
+done:
+	if (hctx)
+		*hctx = data.hctx;
+	return rq->tag != -1;
 }
 
 static void __blk_mq_put_driver_tag(struct blk_mq_hw_ctx *hctx,
@@ -980,17 +978,20 @@ static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
 	return true;
 }
 
-bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
+bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
 {
-	struct request_queue *q = hctx->queue;
+	struct blk_mq_hw_ctx *hctx;
 	struct request *rq;
 	int errors, queued, ret = BLK_MQ_RQ_QUEUE_OK;
 
+	if (list_empty(list))
+		return false;
+
 	/*
 	 * Now process all the entries, sending them to the driver.
 	 */
 	errors = queued = 0;
-	while (!list_empty(list)) {
+	do {
 		struct blk_mq_queue_data bd;
 
 		rq = list_first_entry(list, struct request, queuelist);
@@ -1053,7 +1054,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 
 		if (ret == BLK_MQ_RQ_QUEUE_BUSY)
 			break;
-	}
+	} while (!list_empty(list));
 
 	hctx->dispatched[queued_to_index(queued)]++;
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8d49c06fc520..7e6f2e467696 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -30,7 +30,7 @@ void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_free_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
-bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *, struct list_head *);
+bool blk_mq_dispatch_rq_list(struct request_queue *, struct list_head *);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
 bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
-- 
2.12.2
