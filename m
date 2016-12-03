Return-Path: <prvs=11458901a0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 6/7] block: drop irq+lock when flushing queue plugs
Date: Fri, 2 Dec 2016 20:15:20 -0700
Message-ID: <1480734921-23701-7-git-send-email-axboe@fb.com>
In-Reply-To: <1480734921-23701-1-git-send-email-axboe@fb.com>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Not convinced this is a faster approach, and it does look IRQs off
longer than otherwise. With mq+scheduling, it's a problem since
it forces us to offload the queue running. If we get rid of it,
we can run the queue without the queue lock held.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-core.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6c1063aab1a0..80b5259080a9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3197,18 +3197,21 @@ static int plug_rq_cmp(void *priv, struct list_head *a, struct list_head *b)
  * plugger did not intend it.
  */
 static void queue_unplugged(struct request_queue *q, unsigned int depth,
-			    bool from_schedule)
+			    bool from_schedule, unsigned long flags)
 	__releases(q->queue_lock)
 {
 	trace_block_unplug(q, depth, !from_schedule);
 
-	if (q->mq_ops)
-		blk_mq_run_hw_queues(q, true);
-	else if (from_schedule)
-		blk_run_queue_async(q);
-	else
-		__blk_run_queue(q);
-	spin_unlock(q->queue_lock);
+	if (q->mq_ops) {
+		spin_unlock_irqrestore(q->queue_lock, flags);
+		blk_mq_run_hw_queues(q, from_schedule);
+	} else {
+		if (from_schedule)
+			blk_run_queue_async(q);
+		else
+			__blk_run_queue(q);
+		spin_unlock_irqrestore(q->queue_lock, flags);
+	}
 }
 
 static void flush_plug_callbacks(struct blk_plug *plug, bool from_schedule)
@@ -3276,11 +3279,6 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	q = NULL;
 	depth = 0;
 
-	/*
-	 * Save and disable interrupts here, to avoid doing it for every
-	 * queue lock we have to take.
-	 */
-	local_irq_save(flags);
 	while (!list_empty(&list)) {
 		rq = list_entry_rq(list.next);
 		list_del_init(&rq->queuelist);
@@ -3290,10 +3288,10 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 			 * This drops the queue lock
 			 */
 			if (q)
-				queue_unplugged(q, depth, from_schedule);
+				queue_unplugged(q, depth, from_schedule, flags);
 			q = rq->q;
 			depth = 0;
-			spin_lock(q->queue_lock);
+			spin_lock_irqsave(q->queue_lock, flags);
 		}
 
 		/*
@@ -3322,9 +3320,7 @@ void blk_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	 * This drops the queue lock
 	 */
 	if (q)
-		queue_unplugged(q, depth, from_schedule);
-
-	local_irq_restore(flags);
+		queue_unplugged(q, depth, from_schedule, flags);
 }
 
 void blk_finish_plug(struct blk_plug *plug)
-- 
2.7.4
