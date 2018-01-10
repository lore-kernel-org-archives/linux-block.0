Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/2] blk-mq: Reduce the number of if-statements in
 blk_mq_mark_tag_wait()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <jthumshirn@suse.de>
References: <20180110193919.6886-1-bart.vanassche@wdc.com>
 <20180110193919.6886-2-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <8557bbde-0923-e6d3-b1d3-54e429aadb9f@kernel.dk>
Date: Wed, 10 Jan 2018 13:30:07 -0700
MIME-Version: 1.0
In-Reply-To: <20180110193919.6886-2-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 12:39 PM, Bart Van Assche wrote:
> This patch does not change any functionality but makes the
> blk_mq_mark_tag_wait() code slightly easier to read.

I agree it could do with a cleanup, but how about something like the
below? I think that's easier to read.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8000ba6db07d..afccd0848d6f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1104,58 +1104,59 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 				 struct request *rq)
 {
 	struct blk_mq_hw_ctx *this_hctx = *hctx;
-	bool shared_tags = (this_hctx->flags & BLK_MQ_F_TAG_SHARED) != 0;
 	struct sbq_wait_state *ws;
 	wait_queue_entry_t *wait;
 	bool ret;
 
-	if (!shared_tags) {
+	if (!(this_hctx->flags & BLK_MQ_F_TAG_SHARED)) {
 		if (!test_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state))
 			set_bit(BLK_MQ_S_SCHED_RESTART, &this_hctx->state);
-	} else {
-		wait = &this_hctx->dispatch_wait;
-		if (!list_empty_careful(&wait->entry))
-			return false;
 
-		spin_lock(&this_hctx->lock);
-		if (!list_empty(&wait->entry)) {
-			spin_unlock(&this_hctx->lock);
-			return false;
-		}
+		/*
+		 * It's possible that a tag was freed in the window between the
+		 * allocation failure and adding the hardware queue to the wait
+		 * queue.
+		 *
+		 * Don't clear RESTART here, someone else could have set it.
+		 * At most this will cost an extra queue run.
+		 */
+		return blk_mq_get_driver_tag(rq, hctx, false);
+	}
+
+	wait = &this_hctx->dispatch_wait;
+	if (!list_empty_careful(&wait->entry))
+		return false;
 
-		ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
-		add_wait_queue(&ws->wait, wait);
+	spin_lock(&this_hctx->lock);
+	if (!list_empty(&wait->entry)) {
+		spin_unlock(&this_hctx->lock);
+		return false;
 	}
 
+	ws = bt_wait_ptr(&this_hctx->tags->bitmap_tags, this_hctx);
+	add_wait_queue(&ws->wait, wait);
+
 	/*
 	 * It's possible that a tag was freed in the window between the
 	 * allocation failure and adding the hardware queue to the wait
 	 * queue.
 	 */
 	ret = blk_mq_get_driver_tag(rq, hctx, false);
-
-	if (!shared_tags) {
-		/*
-		 * Don't clear RESTART here, someone else could have set it.
-		 * At most this will cost an extra queue run.
-		 */
-		return ret;
-	} else {
-		if (!ret) {
-			spin_unlock(&this_hctx->lock);
-			return false;
-		}
-
-		/*
-		 * We got a tag, remove ourselves from the wait queue to ensure
-		 * someone else gets the wakeup.
-		 */
-		spin_lock_irq(&ws->wait.lock);
-		list_del_init(&wait->entry);
-		spin_unlock_irq(&ws->wait.lock);
+	if (!ret) {
 		spin_unlock(&this_hctx->lock);
-		return true;
+		return false;
 	}
+
+	/*
+	 * We got a tag, remove ourselves from the wait queue to ensure
+	 * someone else gets the wakeup.
+	 */
+	spin_lock_irq(&ws->wait.lock);
+	list_del_init(&wait->entry);
+	spin_unlock_irq(&ws->wait.lock);
+	spin_unlock(&this_hctx->lock);
+
+	return true;
 }
 
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,

-- 
Jens Axboe
