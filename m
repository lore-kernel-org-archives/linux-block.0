Return-Path: <prvs=1149acddfc=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <paolo.valente@linaro.org>, <osandov@fb.com>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 1/7] blk-mq: add blk_mq_start_stopped_hw_queue()
Date: Wed, 7 Dec 2016 16:09:55 -0700
Message-ID: <1481152201-27461-2-git-send-email-axboe@fb.com>
In-Reply-To: <1481152201-27461-1-git-send-email-axboe@fb.com>
References: <1481152201-27461-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

We have a variant for all hardware queues, but not one for a single
hardware queue.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq.c         | 18 +++++++++++-------
 include/linux/blk-mq.h |  1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 90db5b490df9..b216746be9d3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1064,18 +1064,22 @@ void blk_mq_start_hw_queues(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_mq_start_hw_queues);
 
+void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
+{
+	if (!blk_mq_hctx_stopped(hctx))
+		return;
+
+	clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	blk_mq_run_hw_queue(hctx, async);
+}
+
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	queue_for_each_hw_ctx(q, hctx, i) {
-		if (!blk_mq_hctx_stopped(hctx))
-			continue;
-
-		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
-		blk_mq_run_hw_queue(hctx, async);
-	}
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_start_stopped_hw_queue(hctx, async);
 }
 EXPORT_SYMBOL(blk_mq_start_stopped_hw_queues);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 35a0af5ede6d..87e404aae267 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -231,6 +231,7 @@ void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_stop_hw_queues(struct request_queue *q);
 void blk_mq_start_hw_queues(struct request_queue *q);
+void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
 void blk_mq_run_hw_queues(struct request_queue *q, bool async);
 void blk_mq_delay_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
-- 
2.7.4
