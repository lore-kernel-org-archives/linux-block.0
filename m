Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] blk-mq: fix issue with shared tag queue re-running
Cc: Omar Sandoval <osandov@fb.com>
Message-ID: <98418e6d-2981-0fb7-dcdd-79b635955fcf@kernel.dk>
Date: Wed, 8 Nov 2017 15:48:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This patch attempts to make the case of hctx re-running on driver tag
failure more robust. Without this patch, it's pretty easy to trigger a
stall condition with shared tags. An example is using null_blk like
this:

modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1 submit_queues=1 hw_queue_depth=1

which sets up 4 devices, sharing the same tag set with a depth of 1.
Running a fio job ala:

[global]
bs=4k
rw=randread
norandommap
direct=1
ioengine=libaio
iodepth=4

[nullb0]
filename=/dev/nullb0
[nullb1]
filename=/dev/nullb1
[nullb2]
filename=/dev/nullb2
[nullb3]
filename=/dev/nullb3

will inevitably end with one or more threads being stuck waiting for a
scheduler tag. That IO is then stuck forever, until someone else
triggers a run of the queue.

Ensure that we always re-run the hardware queue, if the driver tag we
were waiting for got freed before we added our leftover request entries
back on the dispatch list.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7f4a1ba532af..bb7f08415203 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -179,7 +179,6 @@ static const char *const hctx_state_name[] = {
 	HCTX_STATE_NAME(STOPPED),
 	HCTX_STATE_NAME(TAG_ACTIVE),
 	HCTX_STATE_NAME(SCHED_RESTART),
-	HCTX_STATE_NAME(TAG_WAITING),
 	HCTX_STATE_NAME(START_ON_RUN),
 };
 #undef HCTX_STATE_NAME
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3d759bb8a5bb..8dc5db40df9d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -998,49 +998,64 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	return rq->tag != -1;
 }
 
-static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
-				void *key)
+static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
+				int flags, void *key)
 {
 	struct blk_mq_hw_ctx *hctx;
 
 	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
 
-	list_del(&wait->entry);
-	clear_bit_unlock(BLK_MQ_S_TAG_WAITING, &hctx->state);
+	list_del_init(&wait->entry);
 	blk_mq_run_hw_queue(hctx, true);
 	return 1;
 }
 
-static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_dispatch_wait_add(struct blk_mq_hw_ctx **hctx,
+				     struct request *rq)
 {
+	struct blk_mq_hw_ctx *this_hctx = *hctx;
+	wait_queue_entry_t *wait = &this_hctx->dispatch_wait;
 	struct sbq_wait_state *ws;
 
+	if (!list_empty_careful(&wait->entry))
+		return false;
+
+	spin_lock(&this_hctx->lock);
+	if (!list_empty(&wait->entry)) {
+		spin_unlock(&this_hctx->lock);
+		return false;
+	}
+
+	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
+	add_wait_queue(&ws->wait, wait);
+
 	/*
-	 * The TAG_WAITING bit serves as a lock protecting hctx->dispatch_wait.
-	 * The thread which wins the race to grab this bit adds the hardware
-	 * queue to the wait queue.
+	 * It's possible that a tag was freed in the window between the
+	 * allocation failure and adding the hardware queue to the wait
+	 * queue.
 	 */
-	if (test_bit(BLK_MQ_S_TAG_WAITING, &hctx->state) ||
-	    test_and_set_bit_lock(BLK_MQ_S_TAG_WAITING, &hctx->state))
+	if (!blk_mq_get_driver_tag(rq, hctx, false)) {
+		spin_unlock(&this_hctx->lock);
 		return false;
-
-	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
-	ws = bt_wait_ptr(&hctx->tags->bitmap_tags, hctx);
+	}
 
 	/*
-	 * As soon as this returns, it's no longer safe to fiddle with
-	 * hctx->dispatch_wait, since a completion can wake up the wait queue
-	 * and unlock the bit.
+	 * We got a tag, remove outselves from the wait queue to ensure
+	 * someone else gets the wakeup.
 	 */
-	add_wait_queue(&ws->wait, &hctx->dispatch_wait);
+	spin_lock_irq(&ws->wait.lock);
+	list_del_init(&wait->entry);
+	spin_unlock_irq(&ws->wait.lock);
+	spin_unlock(&this_hctx->lock);
 	return true;
 }
 
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
-		bool got_budget)
+			     bool got_budget)
 {
 	struct blk_mq_hw_ctx *hctx;
 	struct request *rq, *nxt;
+	bool no_tag = false;
 	int errors, queued;
 
 	if (list_empty(list))
@@ -1060,22 +1075,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
 			/*
 			 * The initial allocation attempt failed, so we need to
-			 * rerun the hardware queue when a tag is freed.
+			 * rerun the hardware queue when a tag is freed. The
+			 * waitqueue takes care of that. If the queue is run
+			 * before we add this entry back on the dispatch list,
+			 * we'll re-run it below.
 			 */
-			if (!blk_mq_dispatch_wait_add(hctx)) {
-				if (got_budget)
-					blk_mq_put_dispatch_budget(hctx);
-				break;
-			}
-
-			/*
-			 * It's possible that a tag was freed in the window
-			 * between the allocation failure and adding the
-			 * hardware queue to the wait queue.
-			 */
-			if (!blk_mq_get_driver_tag(rq, &hctx, false)) {
+			if (!blk_mq_dispatch_wait_add(&hctx, rq)) {
 				if (got_budget)
 					blk_mq_put_dispatch_budget(hctx);
+				no_tag = true;
 				break;
 			}
 		}
@@ -1140,10 +1148,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 * it is no longer set that means that it was cleared by another
 		 * thread and hence that a queue rerun is needed.
 		 *
-		 * If TAG_WAITING is set that means that an I/O scheduler has
-		 * been configured and another thread is waiting for a driver
-		 * tag. To guarantee fairness, do not rerun this hardware queue
-		 * but let the other thread grab the driver tag.
+		 * If 'no_tag' is set, that means that we failed getting
+		 * a driver tag with an I/O scheduler attached. If our dispatch
+		 * waitqueue is no longer active, ensure that we run the queue
+		 * AFTER adding our entries back to the list.
 		 *
 		 * If no I/O scheduler has been configured it is possible that
 		 * the hardware queue got stopped and restarted before requests
@@ -1156,7 +1164,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 *   and dm-rq.
 		 */
 		if (!blk_mq_sched_needs_restart(hctx) &&
-		    !test_bit(BLK_MQ_S_TAG_WAITING, &hctx->state))
+		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
 	}
 
@@ -2020,6 +2028,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
 	hctx->nr_ctx = 0;
 
+	init_waitqueue_func_entry(&hctx->dispatch_wait, blk_mq_dispatch_wake);
+	INIT_LIST_HEAD(&hctx->dispatch_wait.entry);
+
 	if (set->ops->init_hctx &&
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
 		goto free_bitmap;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 674641527da7..4ae987c2352c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -35,7 +35,7 @@ struct blk_mq_hw_ctx {
 	struct blk_mq_ctx	**ctxs;
 	unsigned int		nr_ctx;
 
-	wait_queue_entry_t		dispatch_wait;
+	wait_queue_entry_t	dispatch_wait;
 	atomic_t		wait_index;
 
 	struct blk_mq_tags	*tags;
@@ -181,8 +181,7 @@ enum {
 	BLK_MQ_S_STOPPED	= 0,
 	BLK_MQ_S_TAG_ACTIVE	= 1,
 	BLK_MQ_S_SCHED_RESTART	= 2,
-	BLK_MQ_S_TAG_WAITING	= 3,
-	BLK_MQ_S_START_ON_RUN	= 4,
+	BLK_MQ_S_START_ON_RUN	= 3,
 
 	BLK_MQ_MAX_DEPTH	= 10240,
 
-- 
Jens Axboe
