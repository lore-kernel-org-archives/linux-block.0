Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Make writeback throttling defaults consistent for SQ devices
Date: Wed, 19 Apr 2017 11:33:27 +0200
Message-Id: <20170419093327.14986-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

When CFQ is used as an elevator, it disables writeback throttling
because they don't play well together. Later when a different elevator
is chosen for the device, writeback throttling doesn't get enabled
again as it should. Make sure CFQ enables writeback throttling (if it
should be enabled by default) when we switch from it to another IO
scheduler.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-sysfs.c | 19 +------------------
 block/blk-wbt.c   | 19 +++++++++++++++++++
 block/blk-wbt.h   |  4 ++++
 block/elevator.c  |  3 +++
 4 files changed, 27 insertions(+), 18 deletions(-)

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
index b3b79149d3a0..26e1bb617877 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -665,6 +665,25 @@ void wbt_disable_default(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(wbt_disable_default);
 
+/*
+ * Enable wbt if defaults are configured that way
+ */
+void wbt_enable_default(struct request_queue *q)
+{
+	/* Throttling already enabled? */
+	if (q->rq_wb)
+		return;
+
+	/* Queue not registered? Maybe shutting down... */
+	if (!test_bit(QUEUE_FLAG_REGISTERED, &q->queue_flags))
+		return;
+
+	if ((q->mq_ops && IS_ENABLED(CONFIG_BLK_WBT_MQ)) ||
+	    (q->request_fn && IS_ENABLED(CONFIG_BLK_WBT_SQ)))
+		wbt_init(q);
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
diff --git a/block/elevator.c b/block/elevator.c
index dbeecf7be719..fb50416b5aae 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -41,6 +41,7 @@
 
 #include "blk.h"
 #include "blk-mq-sched.h"
+#include "blk-wbt.h"
 
 static DEFINE_SPINLOCK(elv_list_lock);
 static LIST_HEAD(elv_list);
@@ -877,6 +878,8 @@ void elv_unregister_queue(struct request_queue *q)
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
 		kobject_del(&e->kobj);
 		e->registered = 0;
+		/* Re-enable throttling in case elevator disabled it */
+		wbt_enable_default(q);
 	}
 }
 EXPORT_SYMBOL(elv_unregister_queue);
-- 
2.12.0
