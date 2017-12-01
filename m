Return-Path: <prvs=5014e5409=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 7/7] blk-mq: Fix another queue stall
Date: Thu, 30 Nov 2017 16:08:48 -0800
Message-Id: <20171201000848.2656-8-bart.vanassche@wdc.com>
In-Reply-To: <20171201000848.2656-1-bart.vanassche@wdc.com>
References: <20171201000848.2656-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

The following code at the end of blk_mq_dispatch_rq_list() detects
whether or not wake_up(&hctx->dispatch_wait) has been called
concurrently with pushing back requests onto the dispatch list:

    list_empty_careful(&hctx->dispatch_wait.entry)

Since blk_mq_dispatch_wake() is protected by another lock than the
dispatch list and since blk_mq_run_hw_queue() does not acquire any
lock if it notices that no requests are pending,
blk_mq_dispatch_wake() is not ordered against the code that pushes
back requests onto the dispatch list. Avoid that the dispatch_wait
empty check fails due to load/store reordering by serializing it
against the dispatch_wait queue wakeup. This patch fixes a queue
stall I ran into while testing a SCSI initiator driver with the
maximum target depth set to one.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-mq.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b4225f606737..a11767a4d95c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1074,6 +1074,20 @@ static bool blk_mq_mark_tag_wait(struct blk_mq_hw_ctx **hctx,
 	return ret;
 }
 
+static bool blk_mq_dispatch_list_empty(struct blk_mq_hw_ctx *hctx)
+{
+	struct sbq_wait_state *ws = bt_wait_ptr(&hctx->tags->bitmap_tags, hctx);
+	struct wait_queue_head *wq_head = &ws->wait;
+	unsigned long flags;
+	bool result;
+
+	spin_lock_irqsave(&wq_head->lock, flags);
+	result = list_empty(&hctx->dispatch_wait.entry);
+	spin_unlock_irqrestore(&wq_head->lock, flags);
+
+	return result;
+}
+
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 			     bool got_budget)
 {
@@ -1197,7 +1211,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 */
 		if (restart ||
 		    !blk_mq_sched_needs_restart(hctx) ||
-		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
+		    (no_tag && blk_mq_dispatch_list_empty(hctx)))
 			blk_mq_run_hw_queue(hctx, true);
 	}
 
-- 
2.15.0
