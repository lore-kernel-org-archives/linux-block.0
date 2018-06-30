Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH] blk-mq: code clean-up by adding an API to clear set->mq_map
Date: Sun,  1 Jul 2018 01:21:39 +0900
Message-Id: <1530375699-20461-1-git-send-email-minwoo.im.dev@gmail.com>
List-ID: <linux-block@vger.kernel.org>

set->mq_map is now currently cleared if something goes wrong when
establishing a queue map in blk-mq-pci.c.  It's also cleared before
updating a queue map in blk_mq_update_queue_map().

This patch provides an API to clear set->mq_map to make it clear.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/blk-mq-pci.c     |  3 +--
 block/blk-mq.c         | 13 ++++++++++---
 include/linux/blk-mq.h |  1 +
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index e233996..ccb9d7e 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -48,8 +48,7 @@ int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
 
 fallback:
 	WARN_ON_ONCE(set->nr_hw_queues > 1);
-	for_each_possible_cpu(cpu)
-		set->mq_map[cpu] = 0;
+	blk_mq_clear_mq_map(set);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d51..c5f9ee1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2672,10 +2672,18 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	return 0;
 }
 
+void blk_mq_clear_mq_map(struct blk_mq_tag_set *set)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		set->mq_map[cpu] = 0;
+}
+EXPORT_SYMBOL(blk_mq_clear_mq_map);
+
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
 	if (set->ops->map_queues) {
-		int cpu;
 		/*
 		 * transport .map_queues is usually done in the following
 		 * way:
@@ -2690,8 +2698,7 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		 * killing stale mapping since one CPU may not be mapped
 		 * to any hw queue.
 		 */
-		for_each_possible_cpu(cpu)
-			set->mq_map[cpu] = 0;
+		blk_mq_clear_mq_map(set);
 
 		return set->ops->map_queues(set);
 	} else
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb..18390dc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -204,6 +204,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 int blk_mq_register_dev(struct device *, struct request_queue *);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
+void blk_mq_clear_mq_map(struct blk_mq_tag_set *set);
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
-- 
2.7.4
