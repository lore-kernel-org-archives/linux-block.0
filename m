Return-Path: <prvs=541b0d852=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] blk-mq: Rework blk_mq_mark_tag_wait()
Date: Wed, 10 Jan 2018 10:04:28 -0800
Message-Id: <20180110180428.22587-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Use prepare_to_wait() and finish_wait() instead of open-coding these
functions. Reduce the number of if-statements to make
blk_mq_mark_tag_wait() easier to read. Both add_wait_queue() and
blk_mq_dispatch_wake() protect wait queue manipulations with the wait
queue lock. Hence also protect the !list_empty(&wait->entry) test with
the wait queue lock instead of the hctx lock.

Note: a side effect of this patch is that the task state is changed
for shared queues before and after the blk_mq_get_driver_tag().
Since blk_mq_dispatch_wake() ignores the task state these task state
changes do not affect which task gets woken up.

See also commit f906a6a0f426 ("blk-mq: improve tag waiting setup for
non-shared tags").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 49 +++++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 61bdbf45c3be..29f140b4dbf7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1121,50 +1121,35 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	if (!shared_tags) {
 		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
 			set_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state);
+		ret = blk_mq_get_driver_tag(rq, hctx, false);
+		/*
+		 * Don't clear RESTART here, someone else could have set it.
+		 * At most this will cost an extra queue run.
+		 */
 	} else {
 		wait = &this_hctx->dispatch_wait;
 		if (!list_empty_careful(&wait->entry))
 			return false;
 
-		spin_lock(&this_hctx->lock);
-		if (!list_empty(&wait->entry)) {
-			spin_unlock(&this_hctx->lock);
-			return false;
-		}
-
 		ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
-		add_wait_queue(&ws->wait, wait);
-	}
-
-	/*
-	 * It's possible that a tag was freed in the window between the
-	 * allocation failure and adding the hardware queue to the wait
-	 * queue.
-	 */
-	ret = blk_mq_get_driver_tag(rq, hctx, false);
+		prepare_to_wait(&ws->wait, wait, TASK_UNINTERRUPTIBLE);
 
-	if (!shared_tags) {
 		/*
-		 * Don't clear RESTART here, someone else could have set it.
-		 * At most this will cost an extra queue run.
+		 * It's possible that a tag was freed in the window between the
+		 * allocation failure and adding the hardware queue to the wait
+		 * queue.
 		 */
-		return ret;
-	} else {
-		if (!ret) {
-			spin_unlock(&this_hctx->lock);
-			return false;
-		}
-
+		ret = blk_mq_get_driver_tag(rq, hctx, false);
 		/*
-		 * We got a tag, remove ourselves from the wait queue to ensure
-		 * someone else gets the wakeup.
+		 * If we got a tag, remove ourselves from the wait queue to
+		 * ensure someone else gets the wakeup.
 		 */
-		spin_lock_irq(&ws->wait.lock);
-		list_del_init(&wait->entry);
-		spin_unlock_irq(&ws->wait.lock);
-		spin_unlock(&this_hctx->lock);
-		return true;
+		if (ret)
+			finish_wait(&ws->wait, wait);
+		else
+			__set_current_state(TASK_RUNNING);
 	}
+	return ret;
 }
 
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
-- 
2.15.1
