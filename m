Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Andrew Jones <drjones@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Omar Sandoval <osandov@fb.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 2/5] blk-mq: don't pass **hctx to blk_mq_mark_tag_wait()
Date: Mon, 25 Jun 2018 19:31:46 +0800
Message-Id: <20180625113149.29449-3-ming.lei@redhat.com>
In-Reply-To: <20180625113149.29449-1-ming.lei@redhat.com>
References: <20180625113149.29449-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

'hctx' won't be changed at all, so not necessary to pass
'**hctx' to blk_mq_mark_tag_wait().

Cc: Andrew Jones <drjones@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 62e153eb720c..db2814eb050f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1009,17 +1009,16 @@ static int blk_mq_dispatch_wake(wait_queue_entry_t *wait, unsigned mode,
  * restart. For both cases, take care to check the condition again after
  * marking us as waiting.
  */
-static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
+static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx *hctx,
 				 struct request *rq)
 {
-	struct blk_mq_hw_ctx *this_hctx = *hctx;
 	struct sbq_wait_state *ws;
 	wait_queue_entry_t *wait;
 	bool ret;
 
-	if (!(this_hctx->flags & BLK_MQ_F_TAG_SHARED)) {
-		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
-			set_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state);
+	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED)) {
+		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+			set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 
 		/*
 		 * It's possible that a tag was freed in the window between the
@@ -1032,17 +1031,17 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 		return blk_mq_get_driver_tag(rq);
 	}
 
-	wait = &this_hctx->dispatch_wait;
+	wait = &hctx->dispatch_wait;
 	if (!list_empty_careful(&wait->entry))
 		return false;
 
-	spin_lock(&this_hctx->lock);
+	spin_lock(&hctx->lock);
 	if (!list_empty(&wait->entry)) {
-		spin_unlock(&this_hctx->lock);
+		spin_unlock(&hctx->lock);
 		return false;
 	}
 
-	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
+	ws = bt_wait_ptr(&hctx->tags->bitmap_tags, hctx);
 	add_wait_queue(&ws->wait, wait);
 
 	/*
@@ -1052,7 +1051,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	 */
 	ret = blk_mq_get_driver_tag(rq);
 	if (!ret) {
-		spin_unlock(&this_hctx->lock);
+		spin_unlock(&hctx->lock);
 		return false;
 	}
 
@@ -1063,7 +1062,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	spin_lock_irq(&ws->wait.lock);
 	list_del_init(&wait->entry);
 	spin_unlock_irq(&ws->wait.lock);
-	spin_unlock(&this_hctx->lock);
+	spin_unlock(&hctx->lock);
 
 	return true;
 }
@@ -1105,7 +1104,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			 * before we add this entry back on the dispatch list,
 			 * we'll re-run it below.
 			 */
-			if (!blk_mq_mark_tag_wait(&hctx, rq)) {
+			if (!blk_mq_mark_tag_wait(hctx, rq)) {
 				blk_mq_put_dispatch_budget(hctx);
 				/*
 				 * For non-shared tags, the RESTART check
-- 
2.9.5
