Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754530AbdELKby (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2017 06:31:54 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v4 4/4] blk-mq: allow to use hw tag for shared tags
Date: Fri, 12 May 2017 18:31:03 +0800
Message-Id: <20170512103103.24485-5-ming.lei@redhat.com>
In-Reply-To: <20170512103103.24485-1-ming.lei@redhat.com>
References: <20170512103103.24485-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In case of shared tags, hctx_may_queue() limits that
the maximum number of requests allocated to one hw
queue is .queue_depth / active_queues.

So we try to allow to use hw tag for this case
if .queue_depth/shared_queues is not less than
q->nr_requests.

This can cover some scsi devices too, such as virtio-scsi
in default configuration.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.c | 17 ++++++++++-------
 block/blk-mq-sched.h |  1 +
 block/blk-mq.c       | 25 ++++++++++++++++++++++---
 block/blk-mq.h       | 23 +++++++++++++++++++++++
 4 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index c62590b98d67..d5f8f5b8e801 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -450,8 +450,7 @@ int blk_mq_sched_alloc_tags(struct request_queue *q,
 	return ret;
 }
 
-static int blk_mq_set_queues_depth(struct request_queue *q,
-				   unsigned int nr)
+int blk_mq_set_queues_depth(struct request_queue *q, unsigned int nr)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i, j, ret;
@@ -534,15 +533,17 @@ void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 }
 
 /*
- * If this queue has enough hardware tags and doesn't share tags with
- * other queues, just use hw tag directly for scheduling.
+ * If this queue has enough hardware tags, just use hw tag directly
+ * for scheduling.
  */
 bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
 {
+	int nr_shared = 1;
+
 	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
-		return false;
+		nr_shared = blk_mq_get_shared_queues(q);
 
-	if (q->act_hw_queue_depth < q->nr_requests)
+	if ((q->act_hw_queue_depth / nr_shared) < q->nr_requests)
 		return false;
 
 	return true;
@@ -569,8 +570,10 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 
 	auto_hw_tag = blk_mq_sched_may_use_hw_tag(q);
 	if (auto_hw_tag) {
+		unsigned int nr_shared = blk_mq_get_shared_queues(q);
+
 		q->act_hw_queue_depth = blk_mq_get_queue_depth(q);
-		if (blk_mq_set_queues_depth(q, q->nr_requests))
+		if (blk_mq_set_queues_depth(q, q->nr_requests * nr_shared))
 			auto_hw_tag = false;
 	}
 
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1e738599fbd6..06979786e381 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -26,6 +26,7 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 
 bool blk_mq_sched_may_use_hw_tag(struct request_queue *q);
+int blk_mq_set_queues_depth(struct request_queue *q, unsigned int nr);
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1c52556ab7f6..5225a7358087 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2154,15 +2154,17 @@ int blk_mq_get_queue_depth(struct request_queue *q)
 	return tags->bitmap_tags.sb.depth + tags->breserved_tags.sb.depth;
 }
 
-static void blk_mq_update_sched_flag(struct request_queue *q)
+static bool blk_mq_update_sched_flag(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
+	bool use_hw_tag;
 
 	if (!q->elevator)
-		return;
+		return false;
 
-	if (!blk_mq_sched_may_use_hw_tag(q))
+	use_hw_tag = blk_mq_sched_may_use_hw_tag(q);
+	if (!use_hw_tag)
 		queue_for_each_hw_ctx(q, hctx, i) {
 			if (hctx->flags & BLK_MQ_F_SCHED_USE_HW_TAG) {
 				blk_mq_set_queue_depth(hctx, q->act_hw_queue_depth);
@@ -2180,6 +2182,18 @@ static void blk_mq_update_sched_flag(struct request_queue *q)
 			if (hctx->sched_tags)
 				blk_mq_sched_free_tags(q->tag_set, hctx, i);
 		}
+	return use_hw_tag;
+}
+
+static void blk_mq_update_for_sched(struct request_queue *q)
+{
+	if (!blk_mq_update_sched_flag(q))
+		return;
+
+	blk_mq_freeze_queue(q);
+	blk_mq_set_queues_depth(q, q->nr_requests *
+				__blk_mq_get_shared_queues(q));
+	blk_mq_unfreeze_queue(q);
 }
 
 static void queue_set_hctx_shared(struct request_queue *q, bool shared)
@@ -2221,6 +2235,9 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		/* update existing queue */
 		blk_mq_update_tag_set_depth(set, false);
 	}
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_update_for_sched(q);
 	mutex_unlock(&set->tag_list_lock);
 
 	synchronize_rcu();
@@ -2243,6 +2260,8 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 		queue_set_hctx_shared(q, true);
 	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_update_for_sched(q);
 	mutex_unlock(&set->tag_list_lock);
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index d49d46de2923..3fd869bee744 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -150,4 +150,27 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
+/* return how many queues shared tag set with me */
+static inline int __blk_mq_get_shared_queues(struct request_queue *q)
+{
+	struct blk_mq_tag_set *set = q->tag_set;
+	int nr = 0;
+
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list)
+		nr++;
+	return nr;
+}
+
+static inline int blk_mq_get_shared_queues(struct request_queue *q)
+{
+	int nr = 0;
+	struct blk_mq_tag_set *set = q->tag_set;
+
+	mutex_lock(&set->tag_list_lock);
+	nr = __blk_mq_get_shared_queues(q);
+	mutex_unlock(&set->tag_list_lock);
+
+	return nr;
+}
+
 #endif
-- 
2.9.3
