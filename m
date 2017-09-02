Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752660AbdIBPTF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 2 Sep 2017 11:19:05 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 08/14] blk-mq-sched: use q->queue_depth as hint for q->nr_requests
Date: Sat,  2 Sep 2017 23:17:23 +0800
Message-Id: <20170902151729.6162-9-ming.lei@redhat.com>
In-Reply-To: <20170902151729.6162-1-ming.lei@redhat.com>
References: <20170902151729.6162-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

SCSI sets q->queue_depth from shost->cmd_per_lun, and
q->queue_depth is per request_queue and more related to
scheduler queue compared with hw queue depth, which can be
shared by queues, such as TAG_SHARED.

This patch tries to use q->queue_depth as hint for computing
q->nr_requests, which should be more effective than
current way.

Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-sched.h | 18 +++++++++++++++---
 block/blk-mq.c       | 27 +++++++++++++++++++++++++--
 block/blk-mq.h       |  1 +
 block/blk-settings.c |  2 ++
 4 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 1d47f3fda1d0..906b10c54f78 100644
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
+	 * of scheduler queue as 128 which is the default setting of
+	 * block legacy code.
+	 */
+	return max_t(unsigned, q_depth, BLKDEV_MAX_RQ);
 }
 
 #endif
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6af56a71c1cd..fc3d26bbfc1a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2650,7 +2650,9 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_free_tag_set);
 
-int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
+static int __blk_mq_update_nr_requests(struct request_queue *q,
+				       bool sched_only,
+				       unsigned int nr)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 	struct blk_mq_hw_ctx *hctx;
@@ -2669,7 +2671,7 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 		 * If we're using an MQ scheduler, just update the scheduler
 		 * queue depth. This is similar to what the old code would do.
 		 */
-		if (!hctx->sched_tags) {
+		if (!sched_only && !hctx->sched_tags) {
 			ret = blk_mq_tag_update_depth(hctx, &hctx->tags,
 							min(nr, set->queue_depth),
 							false);
@@ -2689,6 +2691,27 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
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
index e42748bfb959..0277f9771fab 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -37,6 +37,7 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 				bool wait);
 struct request *blk_mq_dispatch_rq_from_ctx(struct blk_mq_hw_ctx *hctx,
 					    struct blk_mq_ctx *start);
+int blk_mq_update_sched_queue_depth(struct request_queue *q);
 
 /*
  * Internal helpers for allocating/freeing the request map
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8559e9563c52..c2db38d2ec2b 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -878,6 +878,8 @@ void blk_set_queue_depth(struct request_queue *q, unsigned int depth)
 {
 	q->queue_depth = depth;
 	wbt_set_queue_depth(q->rq_wb, depth);
+
+	WARN_ON(blk_mq_update_sched_queue_depth(q));
 }
 EXPORT_SYMBOL(blk_set_queue_depth);
 
-- 
2.9.5
