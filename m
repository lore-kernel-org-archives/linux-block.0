Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752339AbdE0OW4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 May 2017 10:22:56 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 8/8] Revert "blk-mq: don't use sync workqueue flushing from drivers"
Date: Sat, 27 May 2017 22:21:26 +0800
Message-Id: <20170527142126.26079-9-ming.lei@redhat.com>
In-Reply-To: <20170527142126.26079-1-ming.lei@redhat.com>
References: <20170527142126.26079-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch reverts commit 2719aa217e0d02(blk-mq: don't use
sync workqueue flushing from drivers) because only
blk_mq_quiesce_queue() need the sync flush, and now
we don't need to stop queue any more, so revert it.

Also changes to cancel_delayed_work() in blk_mq_stop_hw_queue().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 73e07bc074a6..f38226bd651d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -42,7 +42,6 @@ static LIST_HEAD(all_q_list);
 
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
-static void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync);
 
 static int blk_mq_poll_stats_bkt(const struct request *rq)
 {
@@ -1230,16 +1229,6 @@ bool blk_mq_queue_stopped(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_mq_queue_stopped);
 
-static void __blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx, bool sync)
-{
-	if (sync)
-		cancel_delayed_work_sync(&hctx->run_work);
-	else
-		cancel_delayed_work(&hctx->run_work);
-
-	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
-}
-
 /*
  * We do not guarantee that dispatch can be drained or blocked
  * after blk_mq_stop_hw_queue() returns. Please use
@@ -1247,18 +1236,11 @@ static void __blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx, bool sync)
  */
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
 {
-	__blk_mq_stop_hw_queue(hctx, false);
-}
-EXPORT_SYMBOL(blk_mq_stop_hw_queue);
+	cancel_delayed_work(&hctx->run_work);
 
-static void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync)
-{
-	struct blk_mq_hw_ctx *hctx;
-	int i;
-
-	queue_for_each_hw_ctx(q, hctx, i)
-		__blk_mq_stop_hw_queue(hctx, sync);
+	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
+EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 
 /*
  * We do not guarantee that dispatch can be drained or blocked
@@ -1267,7 +1249,11 @@ static void __blk_mq_stop_hw_queues(struct request_queue *q, bool sync)
  */
 void blk_mq_stop_hw_queues(struct request_queue *q)
 {
-	__blk_mq_stop_hw_queues(q, false);
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_stop_hw_queue(hctx);
 }
 EXPORT_SYMBOL(blk_mq_stop_hw_queues);
 
-- 
2.9.4
