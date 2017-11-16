Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755811AbdKPAJA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Nov 2017 19:09:00 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: wake up all tasks blocked in get_request()
Date: Thu, 16 Nov 2017 08:08:44 +0800
Message-Id: <20171116000844.22159-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Once blk_set_queue_dying() is done in blk_cleanup_queue(), we call
blk_freeze_queue() and wait for q->q_usage_counter becoming zero. But if
there are tasks blocked in get_request(), q->q_usage_counter can never
become zero. So we have to wake up all these tasks in blk_set_queue_dying()
first.

Fixes: 3ef28e83ab157997(block: generic request_queue reference counting)
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7c54c195e79e..1038706edd87 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -637,8 +637,8 @@ void blk_set_queue_dying(struct request_queue *q)
 		spin_lock_irq(q->queue_lock);
 		blk_queue_for_each_rl(rl, q) {
 			if (rl->rq_pool) {
-				wake_up(&rl->wait[BLK_RW_SYNC]);
-				wake_up(&rl->wait[BLK_RW_ASYNC]);
+				wake_up_all(&rl->wait[BLK_RW_SYNC]);
+				wake_up_all(&rl->wait[BLK_RW_ASYNC]);
 			}
 		}
 		spin_unlock_irq(q->queue_lock);
-- 
2.9.5
