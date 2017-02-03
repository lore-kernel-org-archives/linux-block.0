Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35061 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdBCTgh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Feb 2017 14:36:37 -0500
Received: by mail-pg0-f42.google.com with SMTP id 194so8980479pgd.2
        for <linux-block@vger.kernel.org>; Fri, 03 Feb 2017 11:36:37 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH] blk-mq-sched: separate mark hctx and queue restart operations
Date: Fri,  3 Feb 2017 11:35:58 -0800
Message-Id: <0e041bc5f968fd15d86f1a89789c30ea82dd96ab.1486150202.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In blk_mq_sched_dispatch_requests(), we call blk_mq_sched_mark_restart()
after we dispatch requests left over on our hardware queue dispatch
list. This is so we'll go back and dispatch requests from the scheduler.
In this case, it's only necessary to restart the hardware queue that we
are running; there's no reason to run other hardware queues just because
we are using shared tags.

So, split out blk_mq_sched_mark_restart() into two operations: the "all"
variant is for when we really need to mark the request queue as needing
a restart, and we'll keep the original for just the hardware queue.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Based on block/for-next. There might be a better name for this.

 block/blk-mq-sched.h | 15 +++++++++++++++
 block/blk-mq.c       |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 5954859c8670..2b42042bf6ea 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -121,8 +121,23 @@ static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
 	return false;
 }
 
+/*
+ * Mark a hardware queue as needing a restart.
+ */
 static inline void blk_mq_sched_mark_restart(struct blk_mq_hw_ctx *hctx)
 {
+	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+}
+
+/*
+ * Mark a hardware queue as needing a restart. If the hardware queue uses shared
+ * driver tags, also mark the request queue as needing a restart. Use this
+ * instead of blk_mq_sched_mark_restart() if a restart is required because we
+ * failed to allocate a driver tag.
+ */
+static inline void blk_mq_sched_mark_restart_all(struct blk_mq_hw_ctx *hctx)
+{
 	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
 		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 		if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index be183e6115a1..199a6ee470e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -937,7 +937,7 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list)
 			 * in case the needed IO completed right before we
 			 * marked the queue as needing a restart.
 			 */
-			blk_mq_sched_mark_restart(hctx);
+			blk_mq_sched_mark_restart_all(hctx);
 			if (!blk_mq_get_driver_tag(rq, &hctx, false))
 				break;
 		}
-- 
2.11.0
