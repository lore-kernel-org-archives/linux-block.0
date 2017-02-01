Return-Path: <tahsin@google.com>
Return-Path: <tahsin@google.com>
From: Tahsin Erdogan <tahsin@google.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Tahsin Erdogan <tahsin@google.com>
Subject: [PATCH] block: queue lock must be acquired when iterating over rls
Date: Tue, 31 Jan 2017 22:36:50 -0800
Message-Id: <20170201063650.15060-1-tahsin@google.com>
List-ID: <linux-block@vger.kernel.org>

blk_set_queue_dying() does not acquire queue lock before it calls
blk_queue_for_each_rl(). This allows a racing blkg_destroy() to
remove blkg->q_node from the linked list and have
blk_queue_for_each_rl() loop infitely over the removed blkg->q_node
list node.

Signed-off-by: Tahsin Erdogan <tahsin@google.com>
---
 block/blk-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 61ba08c58b64..0488a2b55bf0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -525,12 +525,14 @@ void blk_set_queue_dying(struct request_queue *q)
 	else {
 		struct request_list *rl;
 
+		spin_lock_irq(q->queue_lock);
 		blk_queue_for_each_rl(rl, q) {
 			if (rl->rq_pool) {
 				wake_up(&rl->wait[BLK_RW_SYNC]);
 				wake_up(&rl->wait[BLK_RW_ASYNC]);
 			}
 		}
+		spin_unlock_irq(q->queue_lock);
 	}
 }
 EXPORT_SYMBOL_GPL(blk_set_queue_dying);
-- 
2.11.0.483.g087da7b7c-goog
