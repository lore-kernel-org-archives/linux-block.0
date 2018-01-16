Return-Path: <prvs=547e67762=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] blk-mq: Fix a race condition in blk_mq_mark_tag_wait()
Date: Tue, 16 Jan 2018 10:30:24 -0800
Message-Id: <20180116183024.29225-1-bart.vanassche@wdc.com>
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
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index edb1291a42c5..6ca85052e63b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1109,7 +1109,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	struct blk_mq_hw_ctx *this_hctx = *hctx;
 	struct sbq_wait_state *ws;
 	wait_queue_entry_t *wait;
-	bool ret;
+	bool ret = false;
 
 	if (!(this_hctx->flags & BLK_MQ_F_TAG_SHARED)) {
 		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
@@ -1130,14 +1130,20 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	if (!list_empty_careful(&wait->entry))
 		return false;
 
+	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
+
+	/*
+	 * Since hctx->dispatch_wait can already be on any of the
+	 * SBQ_WAIT_QUEUES number of wait queues, serialize the check and
+	 * add_wait_queue() calls below with this_hctx->lock.
+	 */
 	spin_lock(&this_hctx->lock);
-	if (!list_empty(&wait->entry)) {
-		spin_unlock(&this_hctx->lock);
-		return false;
-	}
+	spin_lock_irq(&ws->wait.lock);
+	if (!list_empty(&wait->entry))
+		goto unlock;
 
-	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
-	add_wait_queue(&ws->wait, wait);
+	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
+	__add_wait_queue(&ws->wait, wait);
 
 	/*
 	 * It's possible that a tag was freed in the window between the
@@ -1145,21 +1151,20 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
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
+
+unlock:
 	spin_unlock_irq(&ws->wait.lock);
 	spin_unlock(&this_hctx->lock);
 
-	return true;
+	return ret;
 }
 
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
-- 
2.15.1
