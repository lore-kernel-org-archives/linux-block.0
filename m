Return-Path: <prvs=541b0d852=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 2/2] blk-mq: Fix a race condition in blk_mq_mark_tag_wait()
Date: Wed, 10 Jan 2018 13:41:22 -0800
Message-Id: <20180110214122.15452-3-bart.vanassche@wdc.com>
In-Reply-To: <20180110214122.15452-1-bart.vanassche@wdc.com>
References: <20180110214122.15452-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Both add_wait_queue() and blk_mq_dispatch_wake() protect wait queue
manipulations with the wait queue lock. Hence also protect the
!list_empty(&wait->entry) test with the wait queue lock.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f27bcb6f6751..bbadbd5c8003 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1183,7 +1183,7 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	struct blk_mq_hw_ctx *this_hctx = *hctx;
 	struct sbq_wait_state *ws;
 	wait_queue_entry_t *wait;
-	bool ret;
+	bool on_wait_list, ret;
 
 	if (!(this_hctx->flags & BLK_MQ_F_TAG_SHARED)) {
 		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
@@ -1204,13 +1204,15 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	if (!list_empty_careful(&wait->entry))
 		return false;
 
-	spin_lock(&this_hctx->lock);
-	if (!list_empty(&wait->entry)) {
-		spin_unlock(&this_hctx->lock);
+	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
+
+	spin_lock_irq(&ws->wait.lock);
+	on_wait_list = !list_empty(&wait->entry);
+	spin_unlock_irq(&ws->wait.lock);
+
+	if (on_wait_list)
 		return false;
-	}
 
-	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
 	add_wait_queue(&ws->wait, wait);
 
 	/*
@@ -1219,10 +1221,8 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	 * queue.
 	 */
 	ret = blk_mq_get_driver_tag(rq, hctx, false);
-	if (!ret) {
-		spin_unlock(&this_hctx->lock);
+	if (!ret)
 		return false;
-	}
 
 	/*
 	 * We got a tag, remove ourselves from the wait queue to ensure
@@ -1231,7 +1231,6 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	spin_lock_irq(&ws->wait.lock);
 	list_del_init(&wait->entry);
 	spin_unlock_irq(&ws->wait.lock);
-	spin_unlock(&this_hctx->lock);
 
 	return true;
 }
-- 
2.15.1
