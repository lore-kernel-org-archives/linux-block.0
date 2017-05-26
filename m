Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47117 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967705AbdEZLxu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 May 2017 07:53:50 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 2/2] blk-mq: make per-sw-queue bio merge as default .bio_merge
Date: Fri, 26 May 2017 19:53:20 +0800
Message-Id: <20170526115320.13612-3-ming.lei@redhat.com>
In-Reply-To: <20170526115320.13612-1-ming.lei@redhat.com>
References: <20170526115320.13612-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Because what the per-sw-queue bio merge does is basically same with
scheduler's .bio_merge(), this patch makes per-sw-queue bio merge
as the default .bio_merge if no scheduler is used or io scheduler
doesn't provide .bio_merge().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
Hi Christoph,

Given blk_mq_attempt_merge() is only called in __blk_mq_sched_bio_merge(),
and it isn't good to move __blk_mq_sched_bio_merge() into blk-mq.c because
of the stuff of 'e && e->type->ops.mq.bio_merge' in this function, I keep
this patch as before.

Thanks,


 block/blk-mq-sched.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++----
 block/blk-mq-sched.h |  4 +---
 block/blk-mq.c       | 64 ----------------------------------------------------
 3 files changed, 58 insertions(+), 72 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 1f5b692526ae..c4e2afb9d12d 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -221,19 +221,71 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
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
 	}
 
-	return false;
+	if (hctx->flags & BLK_MQ_F_SHOULD_MERGE) {
+		/* default per sw-queue merge */
+		spin_lock(&ctx->lock);
+		ret = blk_mq_attempt_merge(q, ctx, bio);
+		spin_unlock(&ctx->lock);
+	}
+
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
index 5b95205075f0..9aec650aea2a 100644
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
@@ -1446,23 +1402,6 @@ static inline bool hctx_allow_merges(struct blk_mq_hw_ctx *hctx)
 		!blk_queue_nomerges(hctx->queue);
 }
 
-/* attempt to merge bio into current sw queue */
-static inline bool blk_mq_merge_bio(struct request_queue *q, struct bio *bio)
-{
-	bool ret = false;
-	struct blk_mq_ctx *ctx = blk_mq_get_ctx(q);
-	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
-
-	if (hctx_allow_merges(hctx) && bio_mergeable(bio)) {
-		spin_lock(&ctx->lock);
-		ret = blk_mq_attempt_merge(q, ctx, bio);
-		spin_unlock(&ctx->lock);
-	}
-
-	blk_mq_put_ctx(ctx);
-	return ret;
-}
-
 static inline void blk_mq_queue_io(struct blk_mq_hw_ctx *hctx,
 				   struct blk_mq_ctx *ctx,
 				   struct request *rq)
@@ -1568,9 +1507,6 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 	if (blk_mq_sched_bio_merge(q, bio))
 		return BLK_QC_T_NONE;
 
-	if (blk_mq_merge_bio(q, bio))
-		return BLK_QC_T_NONE;
-
 	wb_acct = wbt_wait(q->rq_wb, bio, NULL);
 
 	trace_block_getrq(q, bio, bio->bi_opf);
-- 
2.9.4
