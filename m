Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35823 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933076AbdBVS7T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2017 13:59:19 -0500
Received: by mail-pg0-f52.google.com with SMTP id b129so4371651pgc.2
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2017 10:59:19 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v3 2/2] blk-mq-sched: separate mark hctx and queue restart operations
Date: Wed, 22 Feb 2017 10:58:30 -0800
Message-Id: <2ef9f8450d7b15ac3af143583f1e6ae61938f5e0.1487789478.git.osandov@fb.com>
In-Reply-To: <ff44cc50b198ea38b4040fd66e8301249d6be69b.1487789478.git.osandov@fb.com>
References: <ff44cc50b198ea38b4040fd66e8301249d6be69b.1487789478.git.osandov@fb.com>
In-Reply-To: <ff44cc50b198ea38b4040fd66e8301249d6be69b.1487789478.git.osandov@fb.com>
References: <ff44cc50b198ea38b4040fd66e8301249d6be69b.1487789478.git.osandov@fb.com>
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
code only needs the hctx variant, but I/O schedulers will want to use
both.

This also requires adjusting blk_mq_sched_restart_queues() to always
check the queue restart flag, not just when using shared tags.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-sched.c | 20 ++++++++------------
 block/blk-mq-sched.h | 26 ++++++++++++++++++--------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 9e8d6795a8c1..16df0a5e7046 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -205,7 +205,7 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx)
 	 * needing a restart in that case.
 	 */
 	if (!list_empty(&rq_list)) {
-		blk_mq_sched_mark_restart(hctx);
+		blk_mq_sched_mark_restart_hctx(hctx);
 		did_work = blk_mq_dispatch_rq_list(hctx, &rq_list);
 	} else if (!has_sched_dispatch) {
 		blk_mq_flush_busy_ctxs(hctx, &rq_list);
@@ -331,20 +331,16 @@ static void blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
 
 void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx)
 {
+	struct request_queue *q = hctx->queue;
 	unsigned int i;
 
-	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED))
+	if (test_bit(QUEUE_FLAG_RESTART, &q->queue_flags)) {
+		if (test_and_clear_bit(QUEUE_FLAG_RESTART, &q->queue_flags)) {
+			queue_for_each_hw_ctx(q, hctx, i)
+				blk_mq_sched_restart_hctx(hctx);
+		}
+	} else {
 		blk_mq_sched_restart_hctx(hctx);
-	else {
-		struct request_queue *q = hctx->queue;
-
-		if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
-			return;
-
-		clear_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
-
-		queue_for_each_hw_ctx(q, hctx, i)
-			blk_mq_sched_restart_hctx(hctx);
 	}
 }
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 7b5f3b95c78e..a75b16b123f7 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -122,17 +122,27 @@ static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
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
-	}
+	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+	if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
+		set_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
 }
 
 static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
-- 
2.11.1
