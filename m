Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753916AbdELKbn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2017 06:31:43 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 3/4] blk-mq: use hw tag for scheduling if hw tag space is big enough
Date: Fri, 12 May 2017 18:31:02 +0800
Message-Id: <20170512103103.24485-4-ming.lei@redhat.com>
In-Reply-To: <20170512103103.24485-1-ming.lei@redhat.com>
References: <20170512103103.24485-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When tag space of one device is big enough, we use hw tag
directly for I/O scheduling.

Now the decision is made if hw queue depth is not less than
q->nr_requests and the tag set isn't shared.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c   | 71 +++++++++++++++++++++++++++++++++++++++++++++-----
 block/blk-mq-sched.h   | 17 ++++++++++++
 block/blk-mq.c         | 35 +++++++++++++++++++++++--
 include/linux/blkdev.h |  8 ++++++
 4 files changed, 122 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 2c5981ff9e04..c62590b98d67 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -417,9 +417,9 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
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
@@ -428,9 +428,9 @@ static void blk_mq_sched_free_tags(struct blk_mq_tag_set *set,
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
@@ -450,14 +450,43 @@ static int blk_mq_sched_alloc_tags(struct request_queue *q,
 	return ret;
 }
 
+static int blk_mq_set_queues_depth(struct request_queue *q,
+				   unsigned int nr)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i, j, ret;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		ret = blk_mq_set_queue_depth(hctx, nr);
+		if (ret)
+			goto recovery;
+	}
+	return 0;
+
+ recovery:
+	queue_for_each_hw_ctx(q, hctx, j) {
+		if (j >= i)
+			break;
+		blk_mq_tag_update_depth(hctx, &hctx->tags,
+					q->act_hw_queue_depth,
+					false);
+	}
+	return ret;
+}
+
 static void blk_mq_sched_tags_teardown(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	queue_for_each_hw_ctx(q, hctx, i)
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG) {
+			blk_mq_set_queue_depth(hctx, q->act_hw_queue_depth);
+			hctx->flags &= ~BLK_MQ_F_SCHED_USE_HW_TAG;
+		}
 		blk_mq_sched_free_tags(set, hctx, i);
+	}
 }
 
 int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
@@ -504,12 +533,28 @@ void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 	blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
 }
 
+/*
+ * If this queue has enough hardware tags and doesn't share tags with
+ * other queues, just use hw tag directly for scheduling.
+ */
+bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
+{
+	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
+		return false;
+
+	if (q->act_hw_queue_depth < q->nr_requests)
+		return false;
+
+	return true;
+}
+
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	struct blk_mq_hw_ctx *hctx;
 	struct elevator_queue *eq;
 	unsigned int i;
 	int ret;
+	bool auto_hw_tag;
 
 	if (!e) {
 		q->elevator = NULL;
@@ -522,7 +567,19 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	 */
 	q->nr_requests = 2 * BLKDEV_MAX_RQ;
 
+	auto_hw_tag = blk_mq_sched_may_use_hw_tag(q);
+	if (auto_hw_tag) {
+		q->act_hw_queue_depth = blk_mq_get_queue_depth(q);
+		if (blk_mq_set_queues_depth(q, q->nr_requests))
+			auto_hw_tag = false;
+	}
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
index edafb5383b7b..1e738599fbd6 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -25,6 +25,7 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
+bool blk_mq_sched_may_use_hw_tag(struct request_queue *q);
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 
@@ -35,6 +36,13 @@ void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 
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
@@ -129,4 +137,13 @@ static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
 	return test_bit(BLK_MQ_S_SCHED_RESTART, &hctx->state);
 }
 
+static inline int blk_mq_set_queue_depth(struct blk_mq_hw_ctx *hctx,
+					 unsigned int nr)
+{
+	if (!hctx->tags)
+		return -EINVAL;
+
+	return blk_mq_tag_update_depth(hctx, &hctx->tags, nr, false);
+}
+
 #endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 389d53a6c1d6..1c52556ab7f6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2154,6 +2154,34 @@ int blk_mq_get_queue_depth(struct request_queue *q)
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
+			if (hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG) {
+				blk_mq_set_queue_depth(hctx, q->act_hw_queue_depth);
+				hctx->flags &= ~BLK_MQ_F_SCHED_USE_HW_TAG;
+			}
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
@@ -2370,7 +2398,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	/*
 	 * Do this after blk_queue_make_request() overrides it...
 	 */
-	q->nr_requests = set->queue_depth;
+	q->act_hw_queue_depth = q->nr_requests = set->queue_depth;
 
 	/*
 	 * Default to classic polling
@@ -2693,8 +2721,11 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			break;
 	}
 
-	if (!ret)
+	if (!ret) {
 		q->nr_requests = nr;
+		q->act_hw_queue_depth = blk_mq_get_queue_depth(q);
+		blk_mq_update_sched_flag(q);
+	}
 
 	blk_mq_unfreeze_queue(q);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b5d1e27631ee..7389e388d583 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -428,6 +428,14 @@ struct request_queue {
 	unsigned int		nr_hw_queues;
 
 	/*
+	 * save active hw queue depth before using hw tag for scheduling,
+	 * this need to revisit if per hw queue depth is supported.
+	 *
+	 * Only used by blk-mq-sched.
+	 */
+	unsigned int		act_hw_queue_depth;
+
+	/*
 	 * Dispatch queue sorting
 	 */
 	sector_t		end_sector;
-- 
2.9.3
