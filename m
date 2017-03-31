Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:35459 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbdCaTAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Mar 2017 15:00:25 -0400
Received: by mail-pg0-f53.google.com with SMTP id 81so79212204pgh.2
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2017 12:00:24 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com
Subject: [PATCH] blk-mq: remap queues when adding/removing hardware queues
Date: Fri, 31 Mar 2017 11:59:24 -0700
Message-Id: <52fb0623a8496808622c718f0f6372d37574dbe1.1490986618.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

blk_mq_update_nr_hw_queues() used to remap hardware queues, which is the
behavior that drivers expect. However, commit 4e68a011428a changed
blk_mq_queue_reinit() to not remap queues for the case of CPU
hotplugging, inadvertently making blk_mq_update_nr_hw_queues() not remap
queues as well. This breaks, for example, NBD's multi-connection mode,
leaving the added hardware queues unused. Fix it by making
blk_mq_queue_reinit() optionally remap queues, which we do when updating
the number of hardware queues but not when hotplugging.

Fixes: 4e68a011428a ("blk-mq: don't redistribute hardware queues on a CPU hotplug event")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
The only callers of blk_mq_update_nr_hw_queues() are nbd and nbd. I *think*
nbd_dev_add() also wants this remap behavior.

 block/blk-mq.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 061fc2cc88d3..1abbf7c83193 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2343,14 +2343,27 @@ void blk_mq_free_queue(struct request_queue *q)
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
 }
 
+static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
+{
+	if (set->ops->map_queues)
+		return set->ops->map_queues(set);
+	else
+		return blk_mq_map_queues(set);
+}
+
+
 /* Basically redo blk_mq_init_queue with queue frozen */
 static void blk_mq_queue_reinit(struct request_queue *q,
-				const struct cpumask *online_mask)
+				const struct cpumask *online_mask,
+				bool remap_queues)
 {
 	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
 
 	blk_mq_sysfs_unregister(q);
 
+	if (remap_queues)
+		blk_mq_update_queue_map(q->tag_set);
+
 	/*
 	 * redo blk_mq_init_cpu_queues and blk_mq_init_hw_queues. FIXME: maybe
 	 * we should change hctx numa_node according to new topology (this
@@ -2387,7 +2400,7 @@ static void blk_mq_queue_reinit_work(void)
 		blk_mq_freeze_queue_wait(q);
 
 	list_for_each_entry(q, &all_q_list, all_q_node)
-		blk_mq_queue_reinit(q, &cpuhp_online_new);
+		blk_mq_queue_reinit(q, &cpuhp_online_new, false);
 
 	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_unfreeze_queue(q);
@@ -2532,10 +2545,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (!set->mq_map)
 		goto out_free_tags;
 
-	if (set->ops->map_queues)
-		ret = set->ops->map_queues(set);
-	else
-		ret = blk_mq_map_queues(set);
+	ret = blk_mq_update_queue_map(set);
 	if (ret)
 		goto out_free_mq_map;
 
@@ -2629,11 +2639,12 @@ void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues)
 	set->nr_hw_queues = nr_hw_queues;
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
-		blk_mq_queue_reinit(q, cpu_online_mask);
+		blk_mq_queue_reinit(q, cpu_online_mask, true);
 	}
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
+
 }
 EXPORT_SYMBOL_GPL(blk_mq_update_nr_hw_queues);
 
-- 
2.12.1
