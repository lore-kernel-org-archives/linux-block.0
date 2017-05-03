Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757671AbdECT73 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 15:59:29 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/5] blk-mq: use hw tag for scheduling if hw tag space is big enough
Date: Thu,  4 May 2017 03:58:38 +0800
Message-Id: <20170503195839.6539-5-ming.lei@redhat.com>
In-Reply-To: <20170503195839.6539-1-ming.lei@redhat.com>
References: <20170503195839.6539-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When tag space of one device is big enough, we use hw tag
directly for I/O scheduling.

Now the decision is made if hw queue depth is not less than
q->nr_requests and the tag set isn't shared.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 24 +++++++++++++++++-------
 block/blk-mq-sched.h | 22 ++++++++++++++++++++++
 block/blk-mq.c       | 32 ++++++++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 817c97c88942..e25a2837d9f0 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -416,9 +416,9 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 	blk_mq_run_hw_queue(hctx, run_queue_async);
 }
 
-static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
-				   struct blk_mq_hw_ctx *hctx,
-				   unsigned int hctx_idx)
+void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
+			    struct blk_mq_hw_ctx *hctx,
+			    unsigned int hctx_idx)
 {
 	if (hctx->sched_tags) {
 		blk_mq_free_rqs(set, hctx->sched_tags, hctx_idx);
@@ -427,9 +427,9 @@ static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
 	}
 }
 
-static int blk_mq_sched_alloc_tags(struct request_queue *q,
-				   struct blk_mq_hw_ctx *hctx,
-				   unsigned int hctx_idx)
+int blk_mq_sched_alloc_tags(struct request_queue *q,
+			    struct blk_mq_hw_ctx *hctx,
+			    unsigned int hctx_idx)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	int ret;
@@ -455,8 +455,10 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	queue_for_each_hw_ctx(q, hctx, i)
+	queue_for_each_hw_ctx(q, hctx, i) {
+		hctx->flags &= ~BLK_MQ_F_SCHED_USE_HW_TAG;
 		blk_mq_sched_free_tags(set, hctx, i);
+	}
 }
 
 int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
@@ -505,6 +507,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	struct elevator_queue *eq;
 	unsigned int i;
 	int ret;
+	bool auto_hw_tag;
 
 	if (!e) {
 		q->elevator = NULL;
@@ -517,7 +520,14 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	 */
 	q->nr_requests = 2 * BLKDEV_MAX_RQ;
 
+	auto_hw_tag = blk_mq_sched_may_use_hw_tag(q);
+
 	queue_for_each_hw_ctx(q, hctx, i) {
+		if (auto_hw_tag)
+			hctx->flags |= BLK_MQ_F_SCHED_USE_HW_TAG;
+		else
+			hctx->flags &= ~BLK_MQ_F_SCHED_USE_HW_TAG;
+
 		ret = blk_mq_sched_alloc_tags(q, hctx, i);
 		if (ret)
 			goto err;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index edafb5383b7b..241d23c18181 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -35,6 +35,13 @@ void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 
 int blk_mq_sched_init(struct request_queue *q);
 
+void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
+			    struct blk_mq_hw_ctx *hctx,
+			    unsigned int hctx_idx);
+int blk_mq_sched_alloc_tags(struct request_queue *q,
+			    struct blk_mq_hw_ctx *hctx,
+			    unsigned int hctx_idx);
+
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
@@ -129,4 +136,19 @@ static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
 	return test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 }
 
+/*
+ * If this queue has enough hardware tags and doesn't share tags with
+ * other queues, just use hw tag directly for scheduling.
+ */
+static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
+{
+	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
+		return false;
+
+	if (blk_mq_get_queue_depth(q) < q->nr_requests)
+		return false;
+
+	return true;
+}
+
 #endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 681bf33d8de8..0d9433680b2a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2132,6 +2132,31 @@ int blk_mq_get_queue_depth(struct request_queue *q)
 	return tags->bitmap_tags.sb.depth + tags->breserved_tags.sb.depth;
 }
 
+static void blk_mq_update_sched_flag(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	if (!q->elevator)
+		return;
+
+	if (!blk_mq_sched_may_use_hw_tag(q))
+		queue_for_each_hw_ctx(q, hctx, i) {
+			hctx->flags &= ~BLK_MQ_F_SCHED_USE_HW_TAG;
+			if (!hctx->sched_tags) {
+				if (blk_mq_sched_alloc_tags(q, hctx, i))
+					goto force_use_hw_tag;
+			}
+		}
+	else
+ force_use_hw_tag:
+		queue_for_each_hw_ctx(q, hctx, i) {
+			hctx->flags |= BLK_MQ_F_SCHED_USE_HW_TAG;
+			if (hctx->sched_tags)
+				blk_mq_sched_free_tags(q->tag_set, hctx, i);
+		}
+}
+
 static void queue_set_hctx_shared(struct request_queue *q, bool shared)
 {
 	struct blk_mq_hw_ctx *hctx;
@@ -2671,8 +2696,11 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			break;
 	}
 
-	if (!ret && sched)
-		q->nr_requests = nr;
+	if (!ret) {
+		if (sched)
+			q->nr_requests = nr;
+		blk_mq_update_sched_flag(q);
+	}
 
 	blk_mq_unfreeze_queue(q);
 
-- 
2.9.3
