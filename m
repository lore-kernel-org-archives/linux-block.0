Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40216 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932963AbdELQVJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2017 12:21:09 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] blk-mq: provide a default .bio_merge
Date: Sat, 13 May 2017 00:20:54 +0800
Message-Id: <20170512162054.25517-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Before blk-mq is introduced, I/O is merged before putting into
plug queue, but blk-mq changed the order and makes merging
basically impossible until mq-deadline is introduced. Then it
is observed that throughput of sequential I/O is degraded about
10%~20% on virtio-blk in the test[1] if IO schedluer isn't used.

This patch provides a default per-sw-queue bio merging if there
isn't scheduler enabled or the scheduler hasn't implement .bio_merge(),
and this way actually moves merging before plugging just
like what blk_queue_bio() does, then the performance regression
is fixed.

[1]. test script:
sudo fio --direct=1 --size=128G --bsrange=4k-4k --runtime=40 --numjobs=16 --ioengine=libaio --iodepth=64 --group_reporting=1 --filename=/dev/vdb --name=virtio_blk-test-$RW --rw=$RW --output-format=json

RW=read or write

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 61 +++++++++++++++++++++++++++++++++----
 block/blk-mq-sched.h |  4 +--
 block/blk-mq.c       | 85 +++++++---------------------------------------------
 3 files changed, 66 insertions(+), 84 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 1f5b692526ae..ad1754e370d1 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -221,19 +221,68 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_merge);
 
+/*
+ * Reverse check our software queue for entries that we could potentially
+ * merge with. Currently includes a hand-wavy stop count of 8, to not spend
+ * too much time checking for merges.
+ */
+static bool blk_mq_attempt_merge(struct request_queue *q,
+				 struct blk_mq_ctx *ctx, struct bio *bio)
+{
+	struct request *rq;
+	int checked = 8;
+
+	list_for_each_entry_reverse(rq, &ctx->rq_list, queuelist) {
+		bool merged = false;
+
+		if (!checked--)
+			break;
+
+		if (!blk_rq_merge_ok(rq, bio))
+			continue;
+
+		switch (blk_try_merge(rq, bio)) {
+		case ELEVATOR_BACK_MERGE:
+			if (blk_mq_sched_allow_merge(q, rq, bio))
+				merged = bio_attempt_back_merge(q, rq, bio);
+			break;
+		case ELEVATOR_FRONT_MERGE:
+			if (blk_mq_sched_allow_merge(q, rq, bio))
+				merged = bio_attempt_front_merge(q, rq, bio);
+			break;
+		case ELEVATOR_DISCARD_MERGE:
+			merged = bio_attempt_discard_merge(q, rq, bio);
+			break;
+		default:
+			continue;
+		}
+
+		if (merged)
+			ctx->rq_merged++;
+		return merged;
+	}
+
+	return false;
+}
+
 bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
 	struct elevator_queue *e = q->elevator;
+	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
+	bool ret = false;
 
-	if (e->type->ops.mq.bio_merge) {
-		struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
-		struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
-
+	if (e && e->type->ops.mq.bio_merge) {
 		blk_mq_put_ctx(ctx);
 		return e->type->ops.mq.bio_merge(hctx, bio);
+	} else if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
+		/* default per sw-queue merge */
+		spin_lock(&ctx->lock);
+		ret = blk_mq_attempt_merge(q, ctx, bio);
+		spin_unlock(&ctx->lock);
 	}
-
-	return false;
+	blk_mq_put_ctx(ctx);
+	return ret;
 }
 
 bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq)
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index edafb5383b7b..b87e5be5db8c 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -38,9 +38,7 @@ int blk_mq_sched_init(struct request_queue *q);
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
-	struct elevator_queue *e = q->elevator;
-
-	if (!e || blk_queue_nomerges(q) || !bio_mergeable(bio))
+	if (blk_queue_nomerges(q) || !bio_mergeable(bio))
 		return false;
 
 	return __blk_mq_sched_bio_merge(q, bio);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a69ad122ed66..6cfce2076583 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -772,50 +772,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	blk_queue_exit(q);
 }
 
-/*
- * Reverse check our software queue for entries that we could potentially
- * merge with. Currently includes a hand-wavy stop count of 8, to not spend
- * too much time checking for merges.
- */
-static bool blk_mq_attempt_merge(struct request_queue *q,
-				 struct blk_mq_ctx *ctx, struct bio *bio)
-{
-	struct request *rq;
-	int checked = 8;
-
-	list_for_each_entry_reverse(rq, &ctx->rq_list, queuelist) {
-		bool merged = false;
-
-		if (!checked--)
-			break;
-
-		if (!blk_rq_merge_ok(rq, bio))
-			continue;
-
-		switch (blk_try_merge(rq, bio)) {
-		case ELEVATOR_BACK_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_back_merge(q, rq, bio);
-			break;
-		case ELEVATOR_FRONT_MERGE:
-			if (blk_mq_sched_allow_merge(q, rq, bio))
-				merged = bio_attempt_front_merge(q, rq, bio);
-			break;
-		case ELEVATOR_DISCARD_MERGE:
-			merged = bio_attempt_discard_merge(q, rq, bio);
-			break;
-		default:
-			continue;
-		}
-
-		if (merged)
-			ctx->rq_merged++;
-		return merged;
-	}
-
-	return false;
-}
-
 struct flush_busy_ctx_data {
 	struct blk_mq_hw_ctx *hctx;
 	struct list_head *list;
@@ -1440,36 +1396,15 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio)
 	blk_account_io_start(rq, true);
 }
 
-static inline bool hctx_allow_merges(struct blk_mq_hw_ctx *hctx)
+static inline void blk_mq_queue_io(struct blk_mq_hw_ctx *hctx,
+				   struct blk_mq_ctx *ctx,
+				   struct request *rq, struct bio *bio)
 {
-	return (hctx->flags & BLK_MQ_F_SHOULD_MERGE) &&
-		!blk_queue_nomerges(hctx->queue);
-}
-
-static inline bool blk_mq_merge_queue_io(struct blk_mq_hw_ctx *hctx,
-					 struct blk_mq_ctx *ctx,
-					 struct request *rq, struct bio *bio)
-{
-	if (!hctx_allow_merges(hctx) || !bio_mergeable(bio)) {
-		blk_mq_bio_to_request(rq, bio);
-		spin_lock(&ctx->lock);
-insert_rq:
-		__blk_mq_insert_request(hctx, rq, false);
-		spin_unlock(&ctx->lock);
-		return false;
-	} else {
-		struct request_queue *q = hctx->queue;
+	blk_mq_bio_to_request(rq, bio);
 
-		spin_lock(&ctx->lock);
-		if (!blk_mq_attempt_merge(q, ctx, bio)) {
-			blk_mq_bio_to_request(rq, bio);
-			goto insert_rq;
-		}
-
-		spin_unlock(&ctx->lock);
-		__blk_mq_finish_request(hctx, ctx, rq);
-		return true;
-	}
+	spin_lock(&ctx->lock);
+	__blk_mq_insert_request(hctx, rq, false);
+	spin_unlock(&ctx->lock);
 }
 
 static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
@@ -1649,11 +1584,11 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
 		blk_mq_sched_insert_request(rq, false, true, true, true);
-	} else if (!blk_mq_merge_queue_io(data.hctx, data.ctx, rq, bio)) {
+	} else {
+		blk_mq_queue_io(data.hctx, data.ctx, rq, bio);
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_run_hw_queue(data.hctx, true);
-	} else
-		blk_mq_put_ctx(data.ctx);
+	}
 
 	return cookie;
 }
-- 
2.9.3
