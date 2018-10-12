Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues
Date: Fri, 12 Oct 2018 18:07:25 +0800
Message-Id: <1539338848-1789-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

blk-mq debugfs and sysfs entries need to be removed before updating
queue map, otherwise, we get get wrong result there. This patch fixes
it and remove the redundant debugfs and sysfs register/unregister
operations during __blk_mq_update_nr_hw_queues.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c39ea..32be432 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2137,8 +2137,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
-	blk_mq_debugfs_unregister_hctx(hctx);
-
 	if (blk_mq_hw_queue_mapped(hctx))
 		blk_mq_tag_idle(hctx);
 
@@ -2165,6 +2163,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (i == nr_queue)
 			break;
+		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
 	}
 }
@@ -2222,8 +2221,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
 
-	blk_mq_debugfs_register_hctx(q, hctx);
-
 	return 0;
 
  free_fq:
@@ -2512,8 +2509,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	int i, j;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
-	blk_mq_sysfs_unregister(q);
-
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
@@ -2561,7 +2556,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	}
 	q->nr_hw_queues = i;
 	mutex_unlock(&q->sysfs_lock);
-	blk_mq_sysfs_register(q);
 }
 
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
@@ -2659,25 +2653,6 @@ void blk_mq_free_queue(struct request_queue *q)
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
 }
 
-/* Basically redo blk_mq_init_queue with queue frozen */
-static void blk_mq_queue_reinit(struct request_queue *q)
-{
-	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
-
-	blk_mq_debugfs_unregister_hctxs(q);
-	blk_mq_sysfs_unregister(q);
-
-	/*
-	 * redo blk_mq_init_cpu_queues and blk_mq_init_hw_queues. FIXME: maybe
-	 * we should change hctx numa_node according to the new topology (this
-	 * involves freeing and re-allocating memory, worth doing?)
-	 */
-	blk_mq_map_swqueue(q);
-
-	blk_mq_sysfs_register(q);
-	blk_mq_debugfs_register_hctxs(q);
-}
-
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
@@ -2987,11 +2962,21 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (!blk_mq_elv_switch_none(&head, q))
 			goto switch_back;
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_debugfs_unregister_hctxs(q);
+		blk_mq_sysfs_unregister(q);
+	}
+
 	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
-		blk_mq_queue_reinit(q);
+		blk_mq_map_swqueue(q);
+	}
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_sysfs_register(q);
+		blk_mq_debugfs_register_hctxs(q);
 	}
 
 switch_back:
-- 
2.7.4
