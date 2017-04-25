Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>
Subject: [PATCH v5 03/10] blk-mq-debugfs: Rename functions for registering and unregistering the mq directory
Date: Tue, 25 Apr 2017 13:37:38 -0700
Message-ID: <20170425203745.19946-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170425203745.19946-1-bart.vanassche@sandisk.com>
References: <20170425203745.19946-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Since the blk_mq_debugfs_*register_hctxs() functions register and
unregister all attributes under the "mq" directory, rename these
into blk_mq_debugfs_*register_mq().

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 8 ++++----
 block/blk-mq-sysfs.c   | 6 +++---
 block/blk-mq.h         | 8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index e9282b945f6b..d99064e9e76a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -795,7 +795,7 @@ int blk_mq_debugfs_register(struct request_queue *q)
 	if (!q->debugfs_dir)
 		goto err;
 
-	if (blk_mq_debugfs_register_hctxs(q))
+	if (blk_mq_debugfs_register_mq(q))
 		goto err;
 
 	return 0;
@@ -865,7 +865,7 @@ static int blk_mq_debugfs_register_hctx(struct request_queue *q,
 	return 0;
 }
 
-int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+int blk_mq_debugfs_register_mq(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
@@ -891,11 +891,11 @@ int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 	return 0;
 
 err:
-	blk_mq_debugfs_unregister_hctxs(q);
+	blk_mq_debugfs_unregister_mq(q);
 	return -ENOMEM;
 }
 
-void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
+void blk_mq_debugfs_unregister_mq(struct request_queue *q)
 {
 	debugfs_remove_recursive(q->mq_debugfs_dir);
 	q->mq_debugfs_dir = NULL;
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index afb3451cf8a5..c2cac20d981d 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -258,7 +258,7 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
-	blk_mq_debugfs_unregister_hctxs(q);
+	blk_mq_debugfs_unregister_mq(q);
 
 	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(&q->mq_kobj);
@@ -356,7 +356,7 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 	if (!q->mq_sysfs_init_done)
 		goto unlock;
 
-	blk_mq_debugfs_unregister_hctxs(q);
+	blk_mq_debugfs_unregister_mq(q);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
@@ -374,7 +374,7 @@ int blk_mq_sysfs_register(struct request_queue *q)
 	if (!q->mq_sysfs_init_done)
 		goto unlock;
 
-	blk_mq_debugfs_register_hctxs(q);
+	blk_mq_debugfs_register_mq(q);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9049c0f11505..2814a14e529c 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -89,8 +89,8 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 #ifdef CONFIG_BLK_DEBUG_FS
 int blk_mq_debugfs_register(struct request_queue *q);
 void blk_mq_debugfs_unregister(struct request_queue *q);
-int blk_mq_debugfs_register_hctxs(struct request_queue *q);
-void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
+int blk_mq_debugfs_register_mq(struct request_queue *q);
+void blk_mq_debugfs_unregister_mq(struct request_queue *q);
 #else
 static inline int blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -101,12 +101,12 @@ static inline void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 }
 
-static inline int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+static inline int blk_mq_debugfs_register_mq(struct request_queue *q)
 {
 	return 0;
 }
 
-static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
+static inline void blk_mq_debugfs_unregister_mq(struct request_queue *q)
 {
 }
 #endif
-- 
2.12.2
