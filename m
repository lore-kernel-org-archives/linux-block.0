Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Make writeback throttling defaults consistent for SQ devices
Date: Wed, 12 Apr 2017 10:23:37 +0200
Message-Id: <20170412082337.10256-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When CFQ is used as an elevator, it disables writeback throttling
because they don't play well together. Later when a different elevator
is chosen for the device, writeback throttling doesn't get enabled
again as it should. Add support to NOOP and DEADLINE elevators to enable
writeback throttling if user set such defaults.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-sysfs.c        | 19 +------------------
 block/blk-wbt.c          | 24 ++++++++++++++++++++++++
 block/blk-wbt.h          |  4 ++++
 block/deadline-iosched.c |  7 +++++++
 block/noop-iosched.c     |  7 +++++++
 5 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index fc20489f0d2b..f85723332288 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -844,23 +844,6 @@ struct kobj_type blk_queue_ktype = {
 	.release	= blk_release_queue,
 };
 
-static void blk_wb_init(struct request_queue *q)
-{
-#ifndef CONFIG_BLK_WBT_MQ
-	if (q->mq_ops)
-		return;
-#endif
-#ifndef CONFIG_BLK_WBT_SQ
-	if (q->request_fn)
-		return;
-#endif
-
-	/*
-	 * If this fails, we don't get throttling
-	 */
-	wbt_init(q);
-}
-
 int blk_register_queue(struct gendisk *disk)
 {
 	int ret;
@@ -908,7 +891,7 @@ int blk_register_queue(struct gendisk *disk)
 
 	kobject_uevent(&q->kobj, KOBJ_ADD);
 
-	blk_wb_init(q);
+	wbt_enable_default(q);
 
 	blk_throtl_register_queue(q);
 
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index b3b79149d3a0..22fb33cc35f1 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -665,6 +665,30 @@ void wbt_disable_default(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
+/*
+ * Enable wbt if defaults are configured that way
+ */
+void wbt_enable_default(struct request_queue *q)
+{
+	if (q->rq_wb)
+		return;
+
+#ifndef CONFIG_BLK_WBT_MQ
+	if (q->mq_ops)
+		return;
+#endif
+#ifndef CONFIG_BLK_WBT_SQ
+	if (q->request_fn)
+		return;
+#endif
+
+	/*
+	 * If this fails, we don't get throttling
+	 */
+	wbt_init(q);
+}
+EXPORT_SYMBOL_GPL(wbt_enable_default);
+
 u64 wbt_default_latency_nsec(struct request_queue *q)
 {
 	/*
diff --git a/block/blk-wbt.h b/block/blk-wbt.h
index ad6c78507c3a..df6de50c5d59 100644
--- a/block/blk-wbt.h
+++ b/block/blk-wbt.h
@@ -117,6 +117,7 @@ void wbt_update_limits(struct rq_wb *);
 void wbt_requeue(struct rq_wb *, struct blk_issue_stat *);
 void wbt_issue(struct rq_wb *, struct blk_issue_stat *);
 void wbt_disable_default(struct request_queue *);
+void wbt_enable_default(struct request_queue *);
 
 void wbt_set_queue_depth(struct rq_wb *, unsigned int);
 void wbt_set_write_cache(struct rq_wb *, bool);
@@ -155,6 +156,9 @@ static inline void wbt_issue(struct rq_wb *rwb, struct blk_issue_stat *stat)
 static inline void wbt_disable_default(struct request_queue *q)
 {
 }
+static inline void wbt_enable_default(struct request_queue *q)
+{
+}
 static inline void wbt_set_queue_depth(struct rq_wb *rwb, unsigned int depth)
 {
 }
diff --git a/block/deadline-iosched.c b/block/deadline-iosched.c
index c68f6bbc0dcd..71210b66f019 100644
--- a/block/deadline-iosched.c
+++ b/block/deadline-iosched.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/compiler.h>
 #include <linux/rbtree.h>
+#include "blk-wbt.h"
 
 /*
  * See Documentation/block/deadline-iosched.txt
@@ -363,6 +364,11 @@ static int deadline_init_queue(struct request_queue *q, struct elevator_type *e)
 	return 0;
 }
 
+static void deadline_registered_queue(struct request_queue *q)
+{
+	wbt_enable_default(q);
+}
+
 /*
  * sysfs parts below
  */
@@ -445,6 +451,7 @@ static struct elevator_type iosched_deadline = {
 		.elevator_latter_req_fn =	elv_rb_latter_request,
 		.elevator_init_fn =		deadline_init_queue,
 		.elevator_exit_fn =		deadline_exit_queue,
+		.elevator_registered_fn =	deadline_registered_queue,
 	},
 
 	.elevator_attrs = deadline_attrs,
diff --git a/block/noop-iosched.c b/block/noop-iosched.c
index 2d1b15d89b45..92f747d6b9c2 100644
--- a/block/noop-iosched.c
+++ b/block/noop-iosched.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
+#include "blk-wbt.h"
 
 struct noop_data {
 	struct list_head queue;
@@ -91,6 +92,11 @@ static void noop_exit_queue(struct elevator_queue *e)
 	kfree(nd);
 }
 
+static void noop_registered_queue(struct request_queue *q)
+{
+	wbt_enable_default(q);
+}
+
 static struct elevator_type elevator_noop = {
 	.ops.sq = {
 		.elevator_merge_req_fn		= noop_merged_requests,
@@ -100,6 +106,7 @@ static struct elevator_type elevator_noop = {
 		.elevator_latter_req_fn		= noop_latter_request,
 		.elevator_init_fn		= noop_init_queue,
 		.elevator_exit_fn		= noop_exit_queue,
+		.elevator_registered_fn		= noop_registered_queue,
 	},
 	.elevator_name = "noop",
 	.elevator_owner = THIS_MODULE,
-- 
2.12.0
