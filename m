Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52058 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757739AbdECT7j (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 May 2017 15:59:39 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/5] blk-mq: allow to use hw tag for shared tags
Date: Thu,  4 May 2017 03:58:39 +0800
Message-Id: <20170503195839.6539-6-ming.lei@redhat.com>
In-Reply-To: <20170503195839.6539-1-ming.lei@redhat.com>
References: <20170503195839.6539-1-ming.lei@redhat.com>
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
 block/blk-mq-sched.h | 10 ++++++----
 block/blk-mq.c       |  1 +
 block/blk-mq.h       | 11 +++++++++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 241d23c18181..b0c124b59e17 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -137,15 +137,17 @@ static inline bool blk_mq_sched_needs_restart(struct blk_mq_hw_ctx *hctx)
 }
 
 /*
- * If this queue has enough hardware tags and doesn't share tags with
- * other queues, just use hw tag directly for scheduling.
+ * If this queue has enough hardware tags, just use hw tag directly
+ * for scheduling.
  */
 static inline bool blk_mq_sched_may_use_hw_tag(struct request_queue *q)
 {
+	int nr_shared = 1;
+
 	if (q->tag_set->flags & BLK_MQ_F_TAG_SHARED)
-		return false;
+		nr_shared = blk_mq_get_shared_queues(q);
 
-	if (blk_mq_get_queue_depth(q) < q->nr_requests)
+	if ((blk_mq_get_queue_depth(q) / nr_shared) < q->nr_requests)
 		return false;
 
 	return true;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0d9433680b2a..c4ca4336fa69 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2179,6 +2179,7 @@ static void blk_mq_update_tag_set_depth(struct blk_mq_tag_set *set, bool shared)
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_freeze_queue(q);
 		queue_set_hctx_shared(q, shared);
+		blk_mq_update_sched_flag(q);
 		blk_mq_unfreeze_queue(q);
 	}
 }
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 8085d5989cf5..351f266ec3a7 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -178,4 +178,15 @@ static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
 	return hctx->nr_ctx && hctx->tags;
 }
 
+/* return how many queues shared tag set with me */
+static inline int blk_mq_get_shared_queues(struct request_queue *q)
+{
+	struct blk_mq_tag_set *set = q->tag_set;
+	int nr = 0;
+
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list)
+		nr++;
+	return nr;
+}
+
 #endif
-- 
2.9.3
