Return-Path: <minwoo.im.dev@gmail.com>
Return-Path: <minwoo.im.dev@gmail.com>
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH V3] blk-mq: code clean-up by adding an API to clear set->mq_map
Date: Mon,  2 Jul 2018 23:46:43 +0900
Message-Id: <1530542803-25212-1-git-send-email-minwoo.im.dev@gmail.com>
List-ID: <linux-block@vger.kernel.org>

set->mq_map is now currently cleared if something goes wrong when
establishing a queue map in blk-mq-pci.c.  It's also cleared before
updating a queue map in blk_mq_update_queue_map().

This patch provides an API to clear set->mq_map to make it clear.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/blk-mq-pci.c | 5 +++--
 block/blk-mq.c     | 4 +---
 block/blk-mq.h     | 8 ++++++++
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index e233996..db644ec 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -17,6 +17,8 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 
+#include "blk-mq.h"
+
 /**
  * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
  * @set:	tagset to provide the mapping for
@@ -48,8 +50,7 @@ int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
 
 fallback:
 	WARN_ON_ONCE(set->nr_hw_queues > 1);
-	for_each_possible_cpu(cpu)
-		set->mq_map[cpu] = 0;
+	blk_mq_clear_mq_map(set);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b429d51..c6bab3f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2675,7 +2675,6 @@ static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 {
 	if (set->ops->map_queues) {
-		int cpu;
 		/*
 		 * transport .map_queues is usually done in the following
 		 * way:
@@ -2690,8 +2689,7 @@ static int blk_mq_update_queue_map(struct blk_mq_tag_set *set)
 		 * killing stale mapping since one CPU may not be mapped
 		 * to any hw queue.
 		 */
-		for_each_possible_cpu(cpu)
-			set->mq_map[cpu] = 0;
+		blk_mq_clear_mq_map(set);
 
 		return set->ops->map_queues(set);
 	} else
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 89231e4..1fefa11 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -203,4 +203,12 @@ static inline void blk_mq_put_driver_tag(struct request *rq)
 	__blk_mq_put_driver_tag(hctx, rq);
 }
 
+static inline void blk_mq_clear_mq_map(struct blk_mq_tag_set *set)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		set->mq_map[cpu] = 0;
+}
+
 #endif
-- 
2.7.4
