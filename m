Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33145 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756422AbdECTTQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:19:16 -0400
Received: by mail-pg0-f44.google.com with SMTP id y4so77854170pge.0
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:19:16 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 6/9] blk-mq: untangle debugfs and sysfs
Date: Wed,  3 May 2017 12:18:59 -0700
Message-Id: <200fadcbef7395ed2b27d972018e052cdef9b2e9.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Originally, I tied debugfs registration/unregistration together with
sysfs. There's no reason to do this, and it's getting in the way of
letting schedulers define their own debugfs attributes. Instead, tie the
debugfs registration to the lifetime of the structures themselves.

The saner lifetimes mean we can also get rid of the extra mq directory
and move everything one level up. I.e., nvme0n1/mq/0/tags is now just
nvme0n1/0/tags.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c       |   9 +---
 block/blk-mq-debugfs.c | 110 ++++++++++++++++++++++++++++---------------------
 block/blk-mq-debugfs.h |  21 ++++++++--
 block/blk-mq-sysfs.c   |  11 -----
 block/blk-mq.c         |   7 ++++
 block/blk-sysfs.c      |   2 +
 include/linux/blk-mq.h |   4 ++
 include/linux/blkdev.h |   1 -
 8 files changed, 94 insertions(+), 71 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index acdca6536562..c580b0138a7f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -40,7 +40,6 @@
 
 #include "blk.h"
 #include "blk-mq.h"
-#include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-wbt.h"
 
@@ -562,13 +561,9 @@ void blk_cleanup_queue(struct request_queue *q)
 	 * prevent that q->request_fn() gets invoked after draining finished.
 	 */
 	blk_freeze_queue(q);
-	if (!q->mq_ops) {
-		spin_lock_irq(lock);
+	spin_lock_irq(lock);
+	if (!q->mq_ops)
 		__blk_drain_queue(q, true);
-	} else {
-		blk_mq_debugfs_unregister_mq(q);
-		spin_lock_irq(lock);
-	}
 	queue_flag_set(QUEUE_FLAG_DEAD, q);
 	spin_unlock_irq(lock);
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 6f98eb15e4f6..5c9e870a2866 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -682,19 +682,46 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{},
 };
 
+static bool debugfs_create_files(struct dentry *parent, void *data,
+				 const struct blk_mq_debugfs_attr *attr)
+{
+	d_inode(parent)->i_private = data;
+
+	for (; attr->name; attr++) {
+		if (!debugfs_create_file(attr->name, attr->mode, parent,
+					 (void *)attr, &blk_mq_debugfs_fops))
+			return false;
+	}
+	return true;
+}
+
 int blk_mq_debugfs_register(struct request_queue *q)
 {
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
 	if (!blk_debugfs_root)
 		return -ENOENT;
 
 	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
 					    blk_debugfs_root);
 	if (!q->debugfs_dir)
-		goto err;
+		return -ENOMEM;
 
-	if (blk_mq_debugfs_register_mq(q))
+	if (!debugfs_create_files(q->debugfs_dir, q,
+				  blk_mq_debugfs_queue_attrs))
 		goto err;
 
+	/*
+	 * blk_mq_init_hctx() attempted to do this already, but q->debugfs_dir
+	 * didn't exist yet (because we don't know what to name the directory
+	 * until the queue is registered to a gendisk).
+	 */
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (!hctx->debugfs_dir && blk_mq_debugfs_register_hctx(q, hctx))
+			goto err;
+	}
+
 	return 0;
 
 err:
@@ -705,32 +732,17 @@ int blk_mq_debugfs_register(struct request_queue *q)
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 	debugfs_remove_recursive(q->debugfs_dir);
-	q->mq_debugfs_dir = NULL;
 	q->debugfs_dir = NULL;
 }
 
-static bool debugfs_create_files(struct dentry *parent, void *data,
-				 const struct blk_mq_debugfs_attr *attr)
-{
-	d_inode(parent)->i_private = data;
-
-	for (; attr->name; attr++) {
-		if (!debugfs_create_file(attr->name, attr->mode, parent,
-					 (void *)attr, &blk_mq_debugfs_fops))
-			return false;
-	}
-	return true;
-}
-
-static int blk_mq_debugfs_register_ctx(struct request_queue *q,
-				       struct blk_mq_ctx *ctx,
-				       struct dentry *hctx_dir)
+static int blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
+				       struct blk_mq_ctx *ctx)
 {
 	struct dentry *ctx_dir;
 	char name[20];
 
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
-	ctx_dir = debugfs_create_dir(name, hctx_dir);
+	ctx_dir = debugfs_create_dir(name, hctx->debugfs_dir);
 	if (!ctx_dir)
 		return -ENOMEM;
 
@@ -740,59 +752,61 @@ static int blk_mq_debugfs_register_ctx(struct request_queue *q,
 	return 0;
 }
 
-static int blk_mq_debugfs_register_hctx(struct request_queue *q,
-					struct blk_mq_hw_ctx *hctx)
+int blk_mq_debugfs_register_hctx(struct request_queue *q,
+				 struct blk_mq_hw_ctx *hctx)
 {
 	struct blk_mq_ctx *ctx;
-	struct dentry *hctx_dir;
 	char name[20];
 	int i;
 
+	if (!q->debugfs_dir)
+		return -ENOENT;
+
 	snprintf(name, sizeof(name), "%u", hctx->queue_num);
-	hctx_dir = debugfs_create_dir(name, q->mq_debugfs_dir);
-	if (!hctx_dir)
+	hctx->debugfs_dir = debugfs_create_dir(name, q->debugfs_dir);
+	if (!hctx->debugfs_dir)
 		return -ENOMEM;
 
-	if (!debugfs_create_files(hctx_dir, hctx, blk_mq_debugfs_hctx_attrs))
-		return -ENOMEM;
+	if (!debugfs_create_files(hctx->debugfs_dir, hctx,
+				  blk_mq_debugfs_hctx_attrs))
+		goto err;
 
 	hctx_for_each_ctx(hctx, ctx, i) {
-		if (blk_mq_debugfs_register_ctx(q, ctx, hctx_dir))
-			return -ENOMEM;
+		if (blk_mq_debugfs_register_ctx(hctx, ctx))
+			goto err;
 	}
 
 	return 0;
+
+err:
+	blk_mq_debugfs_unregister_hctx(hctx);
+	return -ENOMEM;
+}
+
+void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
+{
+	debugfs_remove_recursive(hctx->debugfs_dir);
+	hctx->debugfs_dir = NULL;
 }
 
-int blk_mq_debugfs_register_mq(struct request_queue *q)
+int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	if (!q->debugfs_dir)
-		return -ENOENT;
-
-	q->mq_debugfs_dir = debugfs_create_dir("mq", q->debugfs_dir);
-	if (!q->mq_debugfs_dir)
-		goto err;
-
-	if (!debugfs_create_files(q->mq_debugfs_dir, q, blk_mq_debugfs_queue_attrs))
-		goto err;
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_debugfs_register_hctx(q, hctx))
-			goto err;
+			return -ENOMEM;
 	}
 
 	return 0;
-
-err:
-	blk_mq_debugfs_unregister_mq(q);
-	return -ENOMEM;
 }
 
-void blk_mq_debugfs_unregister_mq(struct request_queue *q)
+void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
-	debugfs_remove_recursive(q->mq_debugfs_dir);
-	q->mq_debugfs_dir = NULL;
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	queue_for_each_hw_ctx(q, hctx, i)
+		blk_mq_debugfs_unregister_hctx(hctx);
 }
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 00b0f71d0ae9..596e9b16d3d1 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -4,8 +4,11 @@
 #ifdef CONFIG_BLK_DEBUG_FS
 int blk_mq_debugfs_register(struct request_queue *q);
 void blk_mq_debugfs_unregister(struct request_queue *q);
-int blk_mq_debugfs_register_mq(struct request_queue *q);
-void blk_mq_debugfs_unregister_mq(struct request_queue *q);
+int blk_mq_debugfs_register_hctx(struct request_queue *q,
+				 struct blk_mq_hw_ctx *hctx);
+void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
+int blk_mq_debugfs_register_hctxs(struct request_queue *q);
+void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
 #else
 static inline int blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -16,12 +19,22 @@ static inline void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 }
 
-static inline int blk_mq_debugfs_register_mq(struct request_queue *q)
+static inline int blk_mq_debugfs_register_hctx(struct request_queue *q,
+					       struct blk_mq_hw_ctx *hctx)
 {
 	return 0;
 }
 
-static inline void blk_mq_debugfs_unregister_mq(struct request_queue *q)
+static inline void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
+{
+}
+
+static inline int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+{
+	return 0;
+}
+
+static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 }
 #endif
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 71a237a90d43..79969c3c234f 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -11,7 +11,6 @@
 
 #include <linux/blk-mq.h>
 #include "blk-mq.h"
-#include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 
 static void blk_mq_sysfs_release(struct kobject *kobj)
@@ -259,8 +258,6 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
-	blk_mq_debugfs_unregister_mq(q);
-
 	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(&q->mq_kobj);
 	kobject_put(&dev->kobj);
@@ -319,8 +316,6 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(&q->mq_kobj, KOBJ_ADD);
 
-	blk_mq_debugfs_register(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
@@ -336,8 +331,6 @@ int __blk_mq_register_dev(struct device *dev, struct request_queue *q)
 	while (--i >= 0)
 		blk_mq_unregister_hctx(q->queue_hw_ctx[i]);
 
-	blk_mq_debugfs_unregister_mq(q);
-
 	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(&q->mq_kobj);
 	kobject_put(&dev->kobj);
@@ -365,8 +358,6 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 	if (!q->mq_sysfs_init_done)
 		goto unlock;
 
-	blk_mq_debugfs_unregister_mq(q);
-
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 
@@ -383,8 +374,6 @@ int blk_mq_sysfs_register(struct request_queue *q)
 	if (!q->mq_sysfs_init_done)
 		goto unlock;
 
-	blk_mq_debugfs_register_mq(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index bf90684a007a..f54467a84d9a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -31,6 +31,7 @@
 #include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 #include "blk-stat.h"
 #include "blk-wbt.h"
@@ -1851,6 +1852,8 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 {
 	unsigned flush_start_tag = set->queue_depth;
 
+	blk_mq_debugfs_unregister_hctx(hctx);
+
 	blk_mq_tag_idle(hctx);
 
 	if (set->ops->exit_request)
@@ -1941,6 +1944,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(&hctx->queue_rq_srcu);
 
+	blk_mq_debugfs_register_hctx(q, hctx);
+
 	return 0;
 
  free_fq:
@@ -2378,6 +2383,7 @@ static void blk_mq_queue_reinit(struct request_queue *q,
 {
 	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
 
+	blk_mq_debugfs_unregister_hctxs(q);
 	blk_mq_sysfs_unregister(q);
 
 	/*
@@ -2389,6 +2395,7 @@ static void blk_mq_queue_reinit(struct request_queue *q,
 	blk_mq_map_swqueue(q, online_mask);
 
 	blk_mq_sysfs_register(q);
+	blk_mq_debugfs_register_hctxs(q);
 }
 
 /*
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 9995355121d7..504fee940052 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -890,6 +890,8 @@ int blk_register_queue(struct gendisk *disk)
 	if (q->mq_ops)
 		__blk_mq_register_dev(dev, q);
 
+	blk_mq_debugfs_register(q);
+
 	kobject_uevent(&q->kobj, KOBJ_ADD);
 
 	wbt_enable_default(q);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f3e5e1de1bdb..7c2fc881fe09 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -57,6 +57,10 @@ struct blk_mq_hw_ctx {
 	unsigned long		poll_considered;
 	unsigned long		poll_invoked;
 	unsigned long		poll_success;
+
+#ifdef CONFIG_BLK_DEBUG_FS
+	struct dentry		*debugfs_dir;
+#endif
 };
 
 struct blk_mq_tag_set {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 83d28623645f..b49a79a29e58 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,7 +579,6 @@ struct request_queue {
 
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
-	struct dentry		*mq_debugfs_dir;
 #endif
 
 	bool			mq_sysfs_init_done;
-- 
2.12.2
