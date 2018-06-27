Return-Path: <prvs=70988ebf6=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2] blk-mq: Fix a race condition in blk_mq_mark_tag_wait()
Date: Wed, 27 Jun 2018 13:02:12 -0700
Message-Id: <20180627200212.14435-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Because the hctx lock is not held around the only
blk_mq_tag_wakeup_all() call in the block layer, the wait queue
entry removal in blk_mq_dispatch_wake() is protected by the wait
queue lock only. Since the hctx->dispatch_wait entry can occur on
any of the SBQ_WAIT_QUEUES, the wait queue presence check, adding
.dispatch_wait to a wait queue and removing the wait queue entry
must all be protected by both the hctx lock and the wait queue
lock.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---

Changes compared to v1: made sure that the hctx lock is also held around the
   list_del() call in blk_mq_dispatch_wake().

 block/blk-mq-debugfs.c |  4 ++--
 block/blk-mq-sched.c   |  8 +++----
 block/blk-mq.c         | 48 ++++++++++++++++++++++++------------------
 3 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1c4532e92938..05fd98fad820 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -399,7 +399,7 @@ static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 
-	spin_lock(&hctx->lock);
+	spin_lock_irq(&hctx->lock);
 	return seq_list_start(&hctx->dispatch, *pos);
 }
 
@@ -415,7 +415,7 @@ static void hctx_dispatch_stop(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 
-	spin_unlock(&hctx->lock);
+	spin_unlock_irq(&hctx->lock);
 }
 
 static const struct seq_operations hctx_dispatch_seq_ops = {
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 56c493c6cd90..07dd6fe9f134 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -190,10 +190,10 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * more fair dispatch.
 	 */
 	if (!list_empty_careful(&hctx->dispatch)) {
-		spin_lock(&hctx->lock);
+		spin_lock_irq(&hctx->lock);
 		if (!list_empty(&hctx->dispatch))
 			list_splice_init(&hctx->dispatch, &rq_list);
-		spin_unlock(&hctx->lock);
+		spin_unlock_irq(&hctx->lock);
 	}
 
 	/*
@@ -368,9 +368,9 @@ static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,
 {
 	/* dispatch flush rq directly */
 	if (rq->rq_flags & RQF_FLUSH_SEQ) {
-		spin_lock(&hctx->lock);
+		spin_lock_irq(&hctx->lock);
 		list_add(&rq->queuelist, &hctx->dispatch);
-		spin_unlock(&hctx->lock);
+		spin_unlock_irq(&hctx->lock);
 		return true;
 	}
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b6888ff556cf..e04321e91116 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1003,7 +1003,10 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
 
 	hctx = container_of(wait, struct blk_mq_hw_ctx, dispatch_wait);
 
+	spin_lock_irq(&hctx->lock);
 	list_del_init(&wait->entry);
+	spin_unlock_irq(&hctx->lock);
+
 	blk_mq_run_hw_queue(hctx, true);
 	return 1;
 }
@@ -1020,7 +1023,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	struct blk_mq_hw_ctx *this_hctx = *hctx;
 	struct sbq_wait_state *ws;
 	wait_queue_entry_t *wait;
-	bool ret;
+	bool ret = false;
 
 	if (!(this_hctx->flags & BLK_MQ_F_TAG_SHARED)) {
 		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
@@ -1041,14 +1044,20 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	if (!list_empty_careful(&wait->entry))
 		return false;
 
+	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
+
+	/*
+	 * Since hctx->dispatch_wait can already be on any of the
+	 * SBQ_WAIT_QUEUES number of wait queues, serialize the check and
+	 * add_wait_queue() calls below with this_hctx->lock.
+	 */
+	spin_lock_irq(&ws->wait.lock);
 	spin_lock(&this_hctx->lock);
-	if (!list_empty(&wait->entry)) {
-		spin_unlock(&this_hctx->lock);
-		return false;
-	}
+	if (!list_empty(&wait->entry))
+		goto unlock;
 
-	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
-	add_wait_queue(&ws->wait, wait);
+	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue(&ws->wait, wait);
 
 	/*
 	 * It's possible that a tag was freed in the window between the
@@ -1056,21 +1065,20 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	 * queue.
 	 */
 	ret = blk_mq_get_driver_tag(rq, hctx, false);
-	if (!ret) {
-		spin_unlock(&this_hctx->lock);
-		return false;
-	}
+	if (!ret)
+		goto unlock;
 
 	/*
 	 * We got a tag, remove ourselves from the wait queue to ensure
 	 * someone else gets the wakeup.
 	 */
-	spin_lock_irq(&ws->wait.lock);
 	list_del_init(&wait->entry);
-	spin_unlock_irq(&ws->wait.lock);
+
+unlock:
 	spin_unlock(&this_hctx->lock);
+	spin_unlock_irq(&ws->wait.lock);
 
-	return true;
+	return ret;
 }
 
 #define BLK_MQ_RESOURCE_DELAY	3		/* ms units */
@@ -1171,9 +1179,9 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	if (!list_empty(list)) {
 		bool needs_restart;
 
-		spin_lock(&hctx->lock);
+		spin_lock_irq(&hctx->lock);
 		list_splice_init(list, &hctx->dispatch);
-		spin_unlock(&hctx->lock);
+		spin_unlock_irq(&hctx->lock);
 
 		/*
 		 * If SCHED_RESTART was set by the caller of this function and
@@ -1520,9 +1528,9 @@ void blk_mq_request_bypass_insert(struct request *rq, bool run_queue)
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, ctx->cpu);
 
-	spin_lock(&hctx->lock);
+	spin_lock_irq(&hctx->lock);
 	list_add_tail(&rq->queuelist, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+	spin_unlock_irq(&hctx->lock);
 
 	if (run_queue)
 		blk_mq_run_hw_queue(hctx, false);
@@ -2048,9 +2056,9 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	if (list_empty(&tmp))
 		return 0;
 
-	spin_lock(&hctx->lock);
+	spin_lock_irq(&hctx->lock);
 	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+	spin_unlock_irq(&hctx->lock);
 
 	blk_mq_run_hw_queue(hctx, true);
 	return 0;
-- 
2.17.1
