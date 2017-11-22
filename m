Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750959AbdKVFMB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Nov 2017 00:12:01 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Ming Lei <ming.lei@redhat.com>, Wen Xiong <wenxiong@us.ibm.com>
Subject: [PATCH] block: drain queue before waiting for q_usage_counter becoming zero
Date: Wed, 22 Nov 2017 13:11:43 +0800
Message-Id: <20171122051143.31943-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now we track legacy requests with .q_usage_counter in commit 055f6e18e08f
("block: Make q_usage_counter also track legacy requests"), but that
commit never runs and drains legacy queue before waiting for this counter
becoming zero, then IO hang is caused in the test of pulling disk during IO.

This patch fixes the issue by draining requests before waiting for
q_usage_counter becoming zero.

Fixes: 055f6e18e08f("block: Make q_usage_counter also track legacy requests")
Cc: Wen Xiong <wenxiong@us.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 9 +++++++--
 block/blk-mq.c   | 2 ++
 block/blk.h      | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 1038706edd87..5ae5ea0dca4c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -562,6 +562,13 @@ static void __blk_drain_queue(struct request_queue *q, bool drain_all)
 	}
 }
 
+void blk_drain_queue(struct request_queue *q)
+{
+	spin_lock_irq(q->queue_lock);
+	__blk_drain_queue(q, true);
+	spin_unlock_irq(q->queue_lock);
+}
+
 /**
  * blk_queue_bypass_start - enter queue bypass mode
  * @q: queue of interest
@@ -689,8 +696,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	blk_freeze_queue(q);
 	spin_lock_irq(lock);
-	if (!q->mq_ops)
-		__blk_drain_queue(q, true);
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 11097477eeab..3d3797327491 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -161,6 +161,8 @@ void blk_freeze_queue(struct request_queue *q)
 	 * exported to drivers as the only user for unfreeze is blk_mq.
 	 */
 	blk_freeze_queue_start(q);
+	if (!q->mq_ops)
+		blk_drain_queue(q);
 	blk_mq_freeze_queue_wait(q);
 }
 
diff --git a/block/blk.h b/block/blk.h
index 3f1446937aec..442098aa9463 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -330,4 +330,6 @@ static inline void blk_queue_bounce(struct request_queue *q, struct bio **bio)
 }
 #endif /* CONFIG_BOUNCE */
 
+extern void blk_drain_queue(struct request_queue *q);
+
 #endif /* BLK_INTERNAL_H */
-- 
2.9.5
