Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdD1PQ7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2017 11:16:59 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] blk-mq: use hw tag for scheduling if hw tag space is big enough
Date: Fri, 28 Apr 2017 23:15:38 +0800
Message-Id: <20170428151539.25514-4-ming.lei@redhat.com>
In-Reply-To: <20170428151539.25514-1-ming.lei@redhat.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When tag space of one device is big enough, we use hw tag
directly for I/O scheduling.

Now the decision is made if hw queue depth is not less than
q->nr_requests and the tag set isn't shared.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c |  8 ++++++++
 block/blk-mq-sched.h | 15 +++++++++++++++
 block/blk-mq.c       | 18 +++++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 45a675f07b8b..4681e27c127e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -507,6 +507,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	struct elevator_queue *eq;
 	unsigned int i;
 	int ret;
+	bool auto_hw_tag;
 
 	if (!e) {
 		q->elevator = NULL;
@@ -519,7 +520,14 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
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
index edafb5383b7b..22a19c118044 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -129,4 +129,19 @@ static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
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
index 04761fb76ab4..b0bd1fb4b0f8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2649,6 +2649,19 @@ int blk_mq_get_queue_depth(struct request_queue *q)
 	return tags->bitmap_tags.sb.depth;
 }
 
+static void blk_mq_update_sched_flag(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	if (!blk_mq_sched_may_use_hw_tag(q))
+		queue_for_each_hw_ctx(q, hctx, i)
+			hctx->flags &= ~BLK_MQ_F_SCHED_USE_HW_TAG;
+	else
+		queue_for_each_hw_ctx(q, hctx, i)
+			hctx->flags |= BLK_MQ_F_SCHED_USE_HW_TAG;
+}
+
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
@@ -2681,9 +2694,12 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 			break;
 	}
 
-	if (!ret)
+	if (!ret) {
 		q->nr_requests = nr;
 
+		blk_mq_update_sched_flag(q);
+	}
+
 	blk_mq_unfreeze_queue(q);
 	blk_mq_start_stopped_hw_queues(q, true);
 
-- 
2.9.3
