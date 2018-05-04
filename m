Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-block@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/3] block: Remove redundant WARN_ON()
Date: Fri,  4 May 2018 16:32:46 +0200
Message-Id: <20180504143247.5240-2-bigeasy@linutronix.de>
In-Reply-To: <20180504143247.5240-1-bigeasy@linutronix.de>
References: <20180504143247.5240-1-bigeasy@linutronix.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Anna-Maria Gleixner <anna-maria@linutronix.de>

Commit 2fff8a924d4c ("block: Check locking assumptions at runtime") added a
lockdep_assert_held(q->queue_lock) which makes the WARN_ON() redundant
because lockdep will detect and warn about context violations.

The unconditional WARN_ON() does not provide real additional value, so it
can be removed.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 block/blk-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 85909b431eb0..a3caccaa7d1f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -360,7 +360,6 @@ EXPORT_SYMBOL(blk_start_queue_async);
 void blk_start_queue(struct request_queue *q)
 {
 	lockdep_assert_held(q->queue_lock);
-	WARN_ON(!in_interrupt() && !irqs_disabled());
 	WARN_ON_ONCE(q->mq_ops);
=20
 	queue_flag_clear(QUEUE_FLAG_STOPPED, q);
--=20
2.17.0
