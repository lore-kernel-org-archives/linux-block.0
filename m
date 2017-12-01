Return-Path: <prvs=5014e5409=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/7] blk-mq: Make blk_mq_mark_tag_wait() easier to read
Date: Thu, 30 Nov 2017 16:08:44 -0800
Message-Id: <20171201000848.2656-4-bart.vanassche@wdc.com>
In-Reply-To: <20171201000848.2656-1-bart.vanassche@wdc.com>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Reduce the number of return statements from three to one. Reduce the
number of spin_unlock(&this_hctx->lock) calls from two to one. Fix
a misleading comment: since blk-mq-tag.c always uses wake_up_all()
other waiters are woken up whether or not the current hctx is removed
from the wait list. This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 41 +++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7f290a91a612..26fec4dfa40f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1039,6 +1039,11 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
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
@@ -1052,37 +1057,21 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 
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
-		if (!ret) {
-			spin_unlock(&this_hctx->lock);
-			return false;
+		ret = blk_mq_get_driver_tag(rq, hctx, false);
+		/* If we got a tag remove ourselves from the wait queue. */
+		if (ret) {
+			spin_lock_irq(&ws->wait.lock);
+			list_del_init(&wait->entry);
+			spin_unlock_irq(&ws->wait.lock);
 		}
-
-		/*
-		 * We got a tag, remove ourselves from the wait queue to ensure
-		 * someone else gets the wakeup.
-		 */
-		spin_lock_irq(&ws->wait.lock);
-		list_del_init(&wait->entry);
-		spin_unlock_irq(&ws->wait.lock);
 		spin_unlock(&this_hctx->lock);
-		return true;
 	}
+	return ret;
 }
 
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
-- 
2.15.0
