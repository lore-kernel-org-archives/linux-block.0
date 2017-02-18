Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33556 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbdBRBF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 20:05:59 -0500
Received: by mail-pg0-f43.google.com with SMTP id y6so16009208pgy.0
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2017 17:05:58 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 1/2] blk-mq: use sbq wait queues instead of restart for driver tags
Date: Fri, 17 Feb 2017 17:05:06 -0800
Message-Id: <d91d1df06ad9292459400637118bca8d09c88dcf.1487379857.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit 50e1dab86aa2 ("blk-mq-sched: fix starvation for multiple hardware
queues and shared tags") fixed one starvation issue for shared tags.
However, we can still get into a situation where we fail to allocate a
tag because all tags are allocated but we don't have any pending
requests on any hardware queue.

One solution for this would be to restart all queues that share a tag
map, but that really sucks. Ideally, we could just block and wait for a
tag, but that isn't always possible from blk_mq_dispatch_rq_list().

However, we can still use the struct sbitmap_queue wait queues with a
custom callback instead of blocking. This has a few benefits:

1. It avoids iterating over all hardware queues when completing an I/O,
   which the current restart code has to do.
2. It benefits from the existing rolling wakeup code.
3. It avoids punting to another thread just to have it block.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++------
 include/linux/blk-mq.h |  2 ++
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5564a9d103ca..0dacb743d4d7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -904,6 +904,44 @@ static bool reorder_tags_to_front(struct list_head *list)
 	return first != NULL;
 }
 
+static int blk_mq_dispatch_wake(wait_queue_t *wait, unsigned mode, int flags,
+				void *key)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
+
+	list_del(&wait->task_list);
+	clear_bit_unlock(BLK_MQ_S_TAG_WAITING, &hctx->state);
+	blk_mq_run_hw_queue(hctx, true);
+	return 1;
+}
+
+static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
+{
+	struct sbq_wait_state *ws;
+
+	/*
+	 * The TAG_WAITING bit serves as a lock protecting hctx->dispatch_wait.
+	 * The thread which wins the race to grab this bit adds the hardware
+	 * queue to the wait queue.
+	 */
+	if (test_bit(BLK_MQ_S_TAG_WAITING, &hctx->state) ||
+	    test_and_set_bit_lock(BLK_MQ_S_TAG_WAITING, &hctx->state))
+		return false;
+
+	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
+	ws = bt_wait_ptr(&hctx->tags->bitmap_tags, hctx);
+
+	/*
+	 * As soon as this returns, it's no longer safe to fiddle with
+	 * hctx->dispatch_wait, since a completion can wake up the wait queue
+	 * and unlock the bit.
+	 */
+	add_wait_queue(&ws->wait, &hctx->dispatch_wait);
+	return true;
+}
+
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 {
 	struct request_queue *q = hctx->queue;
@@ -926,20 +964,27 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 		struct blk_mq_queue_data bd;
 
 		rq = list_first_entry(list, struct request, queuelist);
-		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
+		if (!blk_mq_get_driver_tag(rq, NULL, false)) {
 			if (!queued && reorder_tags_to_front(list))
 				continue;
 
 			/*
-			 * We failed getting a driver tag. Mark the queue(s)
-			 * as needing a restart. Retry getting a tag again,
-			 * in case the needed IO completed right before we
-			 * marked the queue as needing a restart.
+			 * The initial allocation attempt failed, so we need to
+			 * rerun the hardware queue when a tag is freed.
 			 */
-			blk_mq_sched_mark_restart(hctx);
-			if (!blk_mq_get_driver_tag(rq, &hctx, false))
+			if (blk_mq_dispatch_wait_add(hctx)) {
+				/*
+				 * It's possible that a tag was freed in the
+				 * window between the allocation failure and
+				 * adding the hardware queue to the wait queue.
+				 */
+				if (!blk_mq_get_driver_tag(rq, NULL, false))
+					break;
+			} else {
 				break;
+			}
 		}
+
 		list_del_init(&rq->queuelist);
 
 		bd.rq = rq;
@@ -1051,6 +1096,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
 {
 	if (unlikely(blk_mq_hctx_stopped(hctx) ||
+		     test_bit(BLK_MQ_S_TAG_WAITING, &hctx->state) ||
 		     !blk_mq_hw_queue_mapped(hctx)))
 		return;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8e4df3d6c8cd..001d30d727c5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -33,6 +33,7 @@ struct blk_mq_hw_ctx {
 	struct blk_mq_ctx	**ctxs;
 	unsigned int		nr_ctx;
 
+	wait_queue_t		dispatch_wait;
 	atomic_t		wait_index;
 
 	struct blk_mq_tags	*tags;
@@ -160,6 +161,7 @@ enum {
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
+	BLK_MQ_S_TAG_WAITING	= 3,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
-- 
2.11.1
