Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751260AbdGQIjq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jul 2017 04:39:46 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/2] blk-mq-sched: use q->queue_depth as hint for q->nr_requests
Date: Mon, 17 Jul 2017 16:39:23 +0800
Message-Id: <20170717083923.22014-3-ming.lei@redhat.com>
In-Reply-To: <20170717083923.22014-1-ming.lei@redhat.com>
References: <20170717083923.22014-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

SCSI sets q->queue_depth from shost->cmd_per_lun, and
q->queue_depth is per request_queue and more related to
scheduler queue compared with hw queue depth, which can be
shared by queues, such as TAG_SHARED.

This patch trys to use q->queue_depth as hint for computing
q->nr_requests, which should be more effective than
current way.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.h | 18 +++++++++++++++---
 block/blk-mq.c       | 27 +++++++++++++++++++++++++--
 block/blk-mq.h       |  1 +
 block/blk-settings.c |  2 ++
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1d47f3fda1d0..bb772e680e01 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -99,12 +99,24 @@ static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
 static inline unsigned blk_mq_sched_queue_depth(struct request_queue *q)
 {
 	/*
-	 * Default to double of smaller one between hw queue_depth and 128,
+	 * q->queue_depth is more close to scheduler queue, so use it
+	 * as hint for computing scheduler queue depth if it is valid
+	 */
+	unsigned q_depth = q->queue_depth ?: q->tag_set->queue_depth;
+
+	/*
+	 * Default to double of smaller one between queue depth and 128,
 	 * since we don't split into sync/async like the old code did.
 	 * Additionally, this is a per-hw queue depth.
 	 */
-	return 2 * min_t(unsigned int, q->tag_set->queue_depth,
-				   BLKDEV_MAX_RQ);
+	q_depth = 2 * min_t(unsigned int, q_depth, BLKDEV_MAX_RQ);
+
+	/*
+	 * when queue depth of driver is too small, we set queue depth
+	 * of scheduler queue as 32 so that small queue device still
+	 * can benefit from IO merging.
+	 */
+	return max_t(unsigned, q_depth, 32);
 }
 
 #endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 041f7b7fa0d6..cbb005834a94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2558,7 +2558,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
-int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
+static int __blk_mq_update_nr_requests(struct request_queue *q,
+				       bool sched_only,
+				       unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
@@ -2577,7 +2579,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		 * If we're using an MQ scheduler, just update the scheduler
 		 * queue depth. This is similar to what the old code would do.
 		 */
-		if (!hctx->sched_tags) {
+		if (!sched_only && !hctx->sched_tags) {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
 							min(nr, set->queue_depth),
 							false);
@@ -2597,6 +2599,27 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
+int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
+{
+	return __blk_mq_update_nr_requests(q, false, nr);
+}
+
+/*
+ * When drivers update q->queue_depth, this API is called so that
+ * we can use this queue depth as hint for adjusting scheduler
+ * queue depth.
+ */
+int blk_mq_update_sched_queue_depth(struct request_queue *q)
+{
+	unsigned nr;
+
+	if (!q->mq_ops || !q->elevator)
+		return 0;
+
+	nr = blk_mq_sched_queue_depth(q);
+	return __blk_mq_update_nr_requests(q, true, nr);
+}
+
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 							int nr_hw_queues)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 60b01c0309bc..c2c1a2a82999 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -35,6 +35,7 @@ void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head *list);
 bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
 bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 				bool wait);
+int blk_mq_update_sched_queue_depth(struct request_queue *q);
 
 /*
  * Internal helpers for allocating/freeing the request map
diff --git a/block/blk-settings.c b/block/blk-settings.c
index be1f115b538b..94a349601545 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -877,6 +877,8 @@ void blk_set_queue_depth(struct request_queue *q, unsigned int depth)
 {
 	q->queue_depth = depth;
 	wbt_set_queue_depth(q->rq_wb, depth);
+
+	WARN_ON(blk_mq_update_sched_queue_depth(q));
 }
 EXPORT_SYMBOL(blk_set_queue_depth);
 
-- 
2.9.4
