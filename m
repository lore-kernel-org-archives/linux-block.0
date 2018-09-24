Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:25515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbeIYDLa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Sep 2018 23:11:30 -0400
From: Keith Busch <keith.busch@intel.com>
To: Linux Block <linux-block@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Subject: [PATCH] blk-mq: Allow blocking queue tag iter callbacks
Date: Mon, 24 Sep 2018 15:09:19 -0600
Message-Id: <20180924210919.9995-1-keith.busch@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A recent commit had tag iterator callbacks run under the rcu read
lock. Existing callbacks exist that do not satisy the rcu non-blocking
requirement.

The commit intended to prevent an iterator from accessing a queue that's
being modified. This patch fixes the original issue by taking a queue
reference if the queue is not frozen instead of a rcu read lock.

Fixes: f5bbbbe4d6357 ("blk-mq: sync the update nr_hw_queues with blk_mq_queue_tag_busy_iter")
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 block/blk-mq-tag.c | 30 +++++++++++++++++-------------
 block/blk-mq-tag.h |  2 +-
 block/blk-mq.c     | 22 +---------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 94e1ed667b6e..63542642a017 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -314,24 +314,27 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+bool blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	/*
-	 * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
-	 * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
-	 * to avoid race with it. __blk_mq_update_nr_hw_queues will users
-	 * synchronize_rcu to ensure all of the users go out of the critical
-	 * section below and see zeroed q_usage_counter.
+	/* A deadlock might occur if a request is stuck requiring a
+	 * timeout at the same time a queue freeze is waiting
+	 * completion, since the timeout code would not be able to
+	 * acquire the queue reference here.
+	 *
+	 * That's why we don't use blk_queue_enter here; instead, we use
+	 * percpu_ref_tryget directly, because we need to be able to
+	 * obtain a reference even in the short window between the queue
+	 * starting to freeze, by dropping the first reference in
+	 * blk_freeze_queue_start, and the moment the last request is
+	 * consumed, marked by the instant q_usage_counter reaches
+	 * zero.
 	 */
-	rcu_read_lock();
-	if (percpu_ref_is_zero(&q->q_usage_counter)) {
-		rcu_read_unlock();
-		return;
-	}
+	if (!percpu_ref_tryget(&q->q_usage_counter))
+		return false;
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		struct blk_mq_tags *tags = hctx->tags;
@@ -347,7 +350,8 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
 		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
 	}
-	rcu_read_unlock();
+	blk_queue_exit(q);
+	return true;
 }
 
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 61deab0b5a5a..36b3bc90e867 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -33,7 +33,7 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
-void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
+bool blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 		void *priv);
 
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *bt,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..019f9b169887 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -848,24 +848,9 @@ static void blk_mq_timeout_work(struct work_struct *work)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	/* A deadlock might occur if a request is stuck requiring a
-	 * timeout at the same time a queue freeze is waiting
-	 * completion, since the timeout code would not be able to
-	 * acquire the queue reference here.
-	 *
-	 * That's why we don't use blk_queue_enter here; instead, we use
-	 * percpu_ref_tryget directly, because we need to be able to
-	 * obtain a reference even in the short window between the queue
-	 * starting to freeze, by dropping the first reference in
-	 * blk_freeze_queue_start, and the moment the last request is
-	 * consumed, marked by the instant q_usage_counter reaches
-	 * zero.
-	 */
-	if (!percpu_ref_tryget(&q->q_usage_counter))
+	if (!blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next))
 		return;
 
-	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
-
 	if (next != 0) {
 		mod_timer(&q->timeout, next);
 	} else {
@@ -881,7 +866,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
 				blk_mq_tag_idle(hctx);
 		}
 	}
-	blk_queue_exit(q);
 }
 
 struct flush_busy_ctx_data {
@@ -2974,10 +2958,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
-	/*
-	 * Sync with blk_mq_queue_tag_busy_iter.
-	 */
-	synchronize_rcu();
 	/*
 	 * Switch IO scheduler to 'none', cleaning up the data associated
 	 * with the previous scheduler. We will switch back once we are done
-- 
2.14.4
