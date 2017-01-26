Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:41300 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753437AbdAZTsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 14:48:36 -0500
From: Jens Axboe <axboe@fb.com>
To: <linux-block@vger.kernel.org>
CC: <bart.vanassche@sandisk.com>, <hch@lst.de>, <osandov@fb.com>,
        <paolo.valente@linaro.org>, <hare@suse.com>,
        Jens Axboe <axboe@fb.com>
Subject: [PATCH 4/5] blk-mq-sched: fix starvation for multiple hardware queues and shared tags
Date: Thu, 26 Jan 2017 12:48:17 -0700
Message-ID: <1485460098-16608-5-git-send-email-axboe@fb.com>
In-Reply-To: <1485460098-16608-1-git-send-email-axboe@fb.com>
References: <1485460098-16608-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If we have both multiple hardware queues and shared tag map between
devices, we need to ensure that we propagate the hardware queue
restart bit higher up. This is because we can get into a situation
where we don't have any IO pending on a hardware queue, yet we fail
getting a tag to start new IO. If that happens, it's not enough to
mark the hardware queue as needing a restart, we need to bubble
that up to the higher level queue as well.

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 block/blk-mq-sched.c   | 28 ++++++++++++++++++++++++++++
 block/blk-mq-sched.h   | 15 +++++++++------
 block/blk-mq.c         |  3 ++-
 block/blk-mq.h         |  1 +
 include/linux/blkdev.h |  1 +
 5 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 56b92db944ae..69502ff89f3a 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -300,6 +300,34 @@ bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx, struct request *rq)
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_bypass_insert);
 
+static void blk_mq_sched_restart_hctx(struct blk_mq_hw_ctx *hctx)
+{
+	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
+		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+		if (blk_mq_hctx_has_pending(hctx))
+			blk_mq_run_hw_queue(hctx, true);
+	}
+}
+
+void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx)
+{
+	unsigned int i;
+
+	if (!(hctx->flags & BLK_MQ_F_TAG_SHARED))
+		blk_mq_sched_restart_hctx(hctx);
+	else {
+		struct request_queue *q = hctx->queue;
+
+		if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
+			return;
+
+		clear_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
+
+		queue_for_each_hw_ctx(q, hctx, i)
+			blk_mq_sched_restart_hctx(hctx);
+	}
+}
+
 static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
 				   struct blk_mq_hw_ctx *hctx,
 				   unsigned int hctx_idx)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 6b465bc7014c..becbc7840364 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -19,6 +19,7 @@ bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx, struct request *rq);
 bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio);
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio);
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq);
+void blk_mq_sched_restart_queues(struct blk_mq_hw_ctx *hctx);
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 void blk_mq_sched_move_to_dispatch(struct blk_mq_hw_ctx *hctx,
@@ -123,11 +124,6 @@ blk_mq_sched_completed_request(struct blk_mq_hw_ctx *hctx, struct request *rq)
 	BUG_ON(rq->internal_tag == -1);
 
 	blk_mq_put_tag(hctx, hctx->sched_tags, rq->mq_ctx, rq->internal_tag);
-
-	if (test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
-		clear_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
-		blk_mq_run_hw_queue(hctx, true);
-	}
 }
 
 static inline void blk_mq_sched_started_request(struct request *rq)
@@ -160,8 +156,15 @@ static inline bool blk_mq_sched_has_work(struct blk_mq_hw_ctx *hctx)
 
 static inline void blk_mq_sched_mark_restart(struct blk_mq_hw_ctx *hctx)
 {
-	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state))
+	if (!test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state)) {
 		set_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
+		if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
+			struct request_queue *q = hctx->queue;
+
+			if (!test_bit(QUEUE_FLAG_RESTART, &q->queue_flags))
+				set_bit(QUEUE_FLAG_RESTART, &q->queue_flags);
+		}
+	}
 }
 
 static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 089b2eedca4f..fcb5f9f445f7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,7 +40,7 @@ static LIST_HEAD(all_q_list);
 /*
  * Check if any of the ctx's have pending work in this hardware queue
  */
-static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
 	return sbitmap_any_bit_set(&hctx->ctx_map) ||
 			!list_empty_careful(&hctx->dispatch) ||
@@ -345,6 +345,7 @@ void __blk_mq_finish_request(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
 		blk_mq_sched_completed_request(hctx, rq);
+	blk_mq_sched_restart_queues(hctx);
 	blk_queue_exit(q);
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 0c7c034d9ddd..d19b0e75a129 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -33,6 +33,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
 bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *, struct list_head *);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
 
 /*
  * Internal helpers for allocating/freeing the request map
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 25564857f5f8..73bcd201a9b7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -602,6 +602,7 @@ struct request_queue {
 #define QUEUE_FLAG_FLUSH_NQ    25	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         26	/* device supports DAX */
 #define QUEUE_FLAG_STATS       27	/* track rq completion times */
+#define QUEUE_FLAG_RESTART     28
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_STACKABLE)	|	\
-- 
2.7.4

