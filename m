Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34747 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751471AbdBFTYv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Feb 2017 14:24:51 -0500
Received: by mail-pf0-f176.google.com with SMTP id e4so26080702pfg.1
        for <linux-block@vger.kernel.org>; Mon, 06 Feb 2017 11:24:51 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2] blk-mq-sched: separate mark hctx and queue restart operations
Date: Mon,  6 Feb 2017 11:24:11 -0800
Message-Id: <0ec9b1167d22966cdf77a1d5140499493ea888a2.1486408944.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In blk_mq_sched_dispatch_requests(), we call blk_mq_sched_mark_restart()
after we dispatch requests left over on our hardware queue dispatch
list. This is so we'll go back and dispatch requests from the scheduler.
In this case, it's only necessary to restart the hardware queue that we
are running; there's no reason to run other hardware queues just because
we are using shared tags.

So, split out blk_mq_sched_mark_restart() into two operations, one for
just the hardware queue and one for the whole request queue. The core
code uses both, and I/O schedulers may also want to use them.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Patch based on block/for-next.

 block/blk-mq-sched.c |  2 +-
 block/blk-mq-sched.h | 25 ++++++++++++++++++-------
 block/blk-mq.c       |  5 ++++-
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index ee455e7cf9d8..7538565359ea 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -201,7 +201,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * needing a restart in that case.
 	 */
 	if (!list_empty(&rq_list)) {
-		blk_mq_sched_mark_restart(hctx);
+		blk_mq_sched_mark_restart_hctx(hctx);
 		blk_mq_dispatch_rq_list(hctx, &rq_list);
 	} else if (!e || !e->type->ops.mq.dispatch_request) {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 5954859c8670..46788ef2b3db 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -121,16 +121,27 @@ static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
 	return false;
 }
 
-static inline void blk_mq_sched_mark_restart(struct blk_mq_hw_ctx *hctx)
+/*
+ * Mark a hardware queue as needing a restart.
+ */
+static inline void blk_mq_sched_mark_restart_hctx(struct blk_mq_hw_ctx *hctx)
 {
-	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
+	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
 		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
-		if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
-			struct request_queue *q = hctx->queue;
+}
+
+/*
+ * Mark a hardware queue and the request queue it belongs to as needing a
+ * restart.
+ */
+static inline void blk_mq_sched_mark_restart_queue(struct blk_mq_hw_ctx *hctx)
+{
+	struct request_queue *q = hctx->queue;
 
-			if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
-				set_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
-		}
+	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
+		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+		if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
+			set_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
 	}
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index be183e6115a1..a494c0b589d5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -937,7 +937,10 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 			 * in case the needed IO completed right before we
 			 * marked the queue as needing a restart.
 			 */
-			blk_mq_sched_mark_restart(hctx);
+			if (hctx->flags & BLK_MQ_F_TAG_SHARED)
+				blk_mq_sched_mark_restart_queue(hctx);
+			else
+				blk_mq_sched_mark_restart_hctx(hctx);
 			if (!blk_mq_get_driver_tag(rq, &hctx, false))
 				break;
 		}
-- 
2.11.1
