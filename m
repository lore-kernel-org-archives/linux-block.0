Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33693 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752597AbdEDHbx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 03:31:53 -0400
Received: by mail-pg0-f46.google.com with SMTP id y4so4152385pge.0
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 00:31:52 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH v2 10/12] blk-mq-debugfs: allow schedulers to register debugfs attributes
Date: Thu,  4 May 2017 00:31:32 -0700
Message-Id: <006e6393f62e9ac84d7ee76634b80cb4fe49b66e.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This provides the infrastructure for schedulers to expose their internal
state through debugfs. We add a list of queue attributes and a list of
hctx attributes to struct elevator_type and wire them up when switching
schedulers.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c   | 74 ++++++++++++++++++++++++++++++++++++++++++------
 block/blk-mq-debugfs.h   | 34 ++++++++++++++++++++++
 block/blk-mq-sched.c     | 24 ++++++++++------
 include/linux/blk-mq.h   |  1 +
 include/linux/blkdev.h   |  1 +
 include/linux/elevator.h |  7 +++++
 6 files changed, 124 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 260cf76e0705..a3b887109310 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -24,15 +24,6 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 
-struct blk_mq_debugfs_attr {
-	const char *name;
-	umode_t mode;
-	int (*show)(void *, struct seq_file *);
-	ssize_t (*write)(void *, const char __user *, size_t, loff_t *);
-	/* Set either .show or .seq_ops. */
-	const struct seq_operations *seq_ops;
-};
-
 static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 			  const char *const *flag_name, int flag_name_count)
 {
@@ -725,6 +716,9 @@ int blk_mq_debugfs_register(struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (!hctx->debugfs_dir && blk_mq_debugfs_register_hctx(q, hctx))
 			goto err;
+		if (q->elevator && !hctx->sched_debugfs_dir &&
+		    blk_mq_debugfs_register_sched_hctx(q, hctx))
+			goto err;
 	}
 
 	return 0;
@@ -737,6 +731,7 @@ int blk_mq_debugfs_register(struct request_queue *q)
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
 	debugfs_remove_recursive(q->debugfs_dir);
+	q->sched_debugfs_dir = NULL;
 	q->debugfs_dir = NULL;
 }
 
@@ -791,6 +786,7 @@ int blk_mq_debugfs_register_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	debugfs_remove_recursive(hctx->debugfs_dir);
+	hctx->sched_debugfs_dir = NULL;
 	hctx->debugfs_dir = NULL;
 }
 
@@ -815,3 +811,63 @@ void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_unregister_hctx(hctx);
 }
+
+int blk_mq_debugfs_register_sched(struct request_queue *q)
+{
+	struct elevator_type *e = q->elevator->type;
+
+	if (!q->debugfs_dir)
+		return -ENOENT;
+
+	if (!e->queue_debugfs_attrs)
+		return 0;
+
+	q->sched_debugfs_dir = debugfs_create_dir("sched", q->debugfs_dir);
+	if (!q->sched_debugfs_dir)
+		return -ENOMEM;
+
+	if (!debugfs_create_files(q->sched_debugfs_dir, q,
+				  e->queue_debugfs_attrs))
+		goto err;
+
+	return 0;
+
+err:
+	blk_mq_debugfs_unregister_sched(q);
+	return -ENOMEM;
+}
+
+void blk_mq_debugfs_unregister_sched(struct request_queue *q)
+{
+	debugfs_remove_recursive(q->sched_debugfs_dir);
+	q->sched_debugfs_dir = NULL;
+}
+
+int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+				       struct blk_mq_hw_ctx *hctx)
+{
+	struct elevator_type *e = q->elevator->type;
+
+	if (!hctx->debugfs_dir)
+		return -ENOENT;
+
+	if (!e->hctx_debugfs_attrs)
+		return 0;
+
+	hctx->sched_debugfs_dir = debugfs_create_dir("sched",
+						     hctx->debugfs_dir);
+	if (!hctx->sched_debugfs_dir)
+		return -ENOMEM;
+
+	if (!debugfs_create_files(hctx->sched_debugfs_dir, hctx,
+				  e->hctx_debugfs_attrs))
+		return -ENOMEM;
+
+	return 0;
+}
+
+void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
+{
+	debugfs_remove_recursive(hctx->sched_debugfs_dir);
+	hctx->sched_debugfs_dir = NULL;
+}
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 596e9b16d3d1..29ecb43aa412 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -2,6 +2,15 @@
 #define INT_BLK_MQ_DEBUGFS_H
 
 #ifdef CONFIG_BLK_DEBUG_FS
+struct blk_mq_debugfs_attr {
+	const char *name;
+	umode_t mode;
+	int (*show)(void *, struct seq_file *);
+	ssize_t (*write)(void *, const char __user *, size_t, loff_t *);
+	/* Set either .show or .seq_ops. */
+	const struct seq_operations *seq_ops;
+};
+
 int blk_mq_debugfs_register(struct request_queue *q);
 void blk_mq_debugfs_unregister(struct request_queue *q);
 int blk_mq_debugfs_register_hctx(struct request_queue *q,
@@ -9,6 +18,12 @@ int blk_mq_debugfs_register_hctx(struct request_queue *q,
 void blk_mq_debugfs_unregister_hctx(struct blk_mq_hw_ctx *hctx);
 int blk_mq_debugfs_register_hctxs(struct request_queue *q);
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
+
+int blk_mq_debugfs_register_sched(struct request_queue *q);
+void blk_mq_debugfs_unregister_sched(struct request_queue *q);
+int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+				       struct blk_mq_hw_ctx *hctx);
+void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx);
 #else
 static inline int blk_mq_debugfs_register(struct request_queue *q)
 {
@@ -37,6 +52,25 @@ static inline int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 static inline void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 {
 }
+
+static inline int blk_mq_debugfs_register_sched(struct request_queue *q)
+{
+	return 0;
+}
+
+static inline void blk_mq_debugfs_unregister_sched(struct request_queue *q)
+{
+}
+
+static inline int blk_mq_debugfs_register_sched_hctx(struct request_queue *q,
+						     struct blk_mq_hw_ctx *hctx)
+{
+	return 0;
+}
+
+static inline void blk_mq_debugfs_unregister_sched_hctx(struct blk_mq_hw_ctx *hctx)
+{
+}
 #endif
 
 #endif
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 8b361e192e8a..4a8f569f1d21 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -11,6 +11,7 @@
 
 #include "blk.h"
 #include "blk-mq.h"
+#include "blk-mq-debugfs.h"
 #include "blk-mq-sched.h"
 #include "blk-mq-tag.h"
 #include "blk-wbt.h"
@@ -476,6 +477,8 @@ int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 		}
 	}
 
+	blk_mq_debugfs_register_sched_hctx(q, hctx);
+
 	return 0;
 }
 
@@ -487,6 +490,8 @@ void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 	if (!e)
 		return;
 
+	blk_mq_debugfs_unregister_sched_hctx(hctx);
+
 	if (e->type->ops.mq.exit_hctx && hctx->sched_data) {
 		e->type->ops.mq.exit_hctx(hctx, hctx_idx);
 		hctx->sched_data = NULL;
@@ -523,8 +528,10 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 	if (ret)
 		goto err;
 
-	if (e->ops.mq.init_hctx) {
-		queue_for_each_hw_ctx(q, hctx, i) {
+	blk_mq_debugfs_register_sched(q);
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (e->ops.mq.init_hctx) {
 			ret = e->ops.mq.init_hctx(hctx, i);
 			if (ret) {
 				eq = q->elevator;
@@ -533,6 +540,7 @@ int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 				return ret;
 			}
 		}
+		blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
 
 	return 0;
@@ -548,14 +556,14 @@ void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 
-	if (e->type->ops.mq.exit_hctx) {
-		queue_for_each_hw_ctx(q, hctx, i) {
-			if (hctx->sched_data) {
-				e->type->ops.mq.exit_hctx(hctx, i);
-				hctx->sched_data = NULL;
-			}
+	queue_for_each_hw_ctx(q, hctx, i) {
+		blk_mq_debugfs_unregister_sched_hctx(hctx);
+		if (e->type->ops.mq.exit_hctx && hctx->sched_data) {
+			e->type->ops.mq.exit_hctx(hctx, i);
+			hctx->sched_data = NULL;
 		}
 	}
+	blk_mq_debugfs_unregister_sched(q);
 	if (e->type->ops.mq.exit_sched)
 		e->type->ops.mq.exit_sched(e);
 	blk_mq_sched_tags_teardown(q);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7c2fc881fe09..863409266eb7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -60,6 +60,7 @@ struct blk_mq_hw_ctx {
 
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
+	struct dentry		*sched_debugfs_dir;
 #endif
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b49a79a29e58..80ae958717a1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -579,6 +579,7 @@ struct request_queue {
 
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
+	struct dentry		*sched_debugfs_dir;
 #endif
 
 	bool			mq_sysfs_init_done;
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 3a216318ae73..baaa12cd4dd9 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -8,6 +8,9 @@
 
 struct io_cq;
 struct elevator_type;
+#ifdef CONFIG_BLK_DEBUG_FS
+struct blk_mq_debugfs_attr;
+#endif
 
 /*
  * Return values from elevator merger
@@ -144,6 +147,10 @@ struct elevator_type
 	char elevator_name[ELV_NAME_MAX];
 	struct module *elevator_owner;
 	bool uses_mq;
+#ifdef CONFIG_BLK_DEBUG_FS
+	const struct blk_mq_debugfs_attr *queue_debugfs_attrs;
+	const struct blk_mq_debugfs_attr *hctx_debugfs_attrs;
+#endif
 
 	/* managed by elevator core */
 	char icq_cache_name[ELV_NAME_MAX + 5];	/* elvname + "_io_cq" */
-- 
2.12.2
