Return-Path: <prvs=541b0d852=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 1/2] blk-mq: Reduce the number of if-statements in blk_mq_mark_tag_wait()
Date: Wed, 10 Jan 2018 11:39:18 -0800
Message-Id: <20180110193919.6886-2-bart.vanassche@wdc.com>
In-Reply-To: <20180110193919.6886-1-bart.vanassche@wdc.com>
References: <20180110193919.6886-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch does not change any functionality but makes the
blk_mq_mark_tag_wait() code slightly easier to read.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1d705e25852e..e770e8814f60 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1189,6 +1189,16 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	if (!shared_tags) {
 		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
 			set_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state);
+		/*
+		 * It's possible that a tag was freed in the window between the
+		 * allocation failure and adding the hardware queue to the wait
+		 * queue.
+		 */
+		ret = blk_mq_get_driver_tag(rq, hctx, false);
+		/*
+		 * Don't clear RESTART here, someone else could have set it.
+		 * At most this will cost an extra queue run.
+		 */
 	} else {
 		wait = &this_hctx->dispatch_wait;
 		if (!list_empty_careful(&wait->entry))
@@ -1202,22 +1212,12 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 
 		ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
 		add_wait_queue(&ws->wait, wait);
-	}
-
-	/*
-	 * It's possible that a tag was freed in the window between the
-	 * allocation failure and adding the hardware queue to the wait
-	 * queue.
-	 */
-	ret = blk_mq_get_driver_tag(rq, hctx, false);
-
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
+		ret = blk_mq_get_driver_tag(rq, hctx, false);
 		if (!ret) {
 			spin_unlock(&this_hctx->lock);
 			return false;
@@ -1231,8 +1231,8 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 		list_del_init(&wait->entry);
 		spin_unlock_irq(&ws->wait.lock);
 		spin_unlock(&this_hctx->lock);
-		return true;
 	}
+	return ret;
 }
 
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
-- 
2.15.1
