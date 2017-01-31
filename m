Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36508 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdAaWyK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 17:54:10 -0500
Received: by mail-pf0-f181.google.com with SMTP id 189so112770384pfu.3
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 14:54:10 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 4/6] block: use same block debugfs directory for blk-mq and blktrace
Date: Tue, 31 Jan 2017 14:53:20 -0800
Message-Id: <7b58d4b85fbd72a880774ddb745b090a085516aa.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

When I added the blk-mq debugging information to debugfs, I didn't
notice that blktrace also creates a "block" directory in debugfs. Make
them use the same dentry, now created in the core block code. Based on a
patch from Jens.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-core.c        |  9 +++++++++
 block/blk-mq-debugfs.c  | 12 +++---------
 block/blk-mq.c          |  2 --
 block/blk-mq.h          |  5 -----
 block/blk.h             |  4 ++++
 kernel/trace/blktrace.c | 18 +++++-------------
 6 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 02833ce5664e..16d3b06c743c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -33,6 +33,7 @@
 #include <linux/ratelimit.h>
 #include <linux/pm_runtime.h>
 #include <linux/blk-cgroup.h>
+#include <linux/debugfs.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -42,6 +43,10 @@
 #include "blk-mq-sched.h"
 #include "blk-wbt.h"
 
+#ifdef CONFIG_DEBUG_FS
+struct dentry *blk_debugfs_root;
+#endif
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_remap);
 EXPORT_TRACEPOINT_SYMBOL_GPL(block_bio_complete);
@@ -3482,5 +3487,9 @@ int __init blk_dev_init(void)
 	blk_requestq_cachep = kmem_cache_create("request_queue",
 			sizeof(struct request_queue), 0, SLAB_PANIC, NULL);
 
+#ifdef CONFIG_DEBUG_FS
+	blk_debugfs_root = debugfs_create_dir("block", NULL);
+#endif
+
 	return 0;
 }
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5cd2b435a9f5..0cd29b99068c 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -19,6 +19,7 @@
 #include <linux/debugfs.h>
 
 #include <linux/blk-mq.h>
+#include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-tag.h"
 
@@ -28,8 +29,6 @@ struct blk_mq_debugfs_attr {
 	const struct file_operations *fops;
 };
 
-static struct dentry *block_debugfs_root;
-
 static int blk_mq_debugfs_seq_open(struct inode *inode, struct file *file,
 				   const struct seq_operations *ops)
 {
@@ -641,10 +640,10 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 
 int blk_mq_debugfs_register(struct request_queue *q, const char *name)
 {
-	if (!block_debugfs_root)
+	if (!blk_debugfs_root)
 		return -ENOENT;
 
-	q->debugfs_dir = debugfs_create_dir(name, block_debugfs_root);
+	q->debugfs_dir = debugfs_create_dir(name, blk_debugfs_root);
 	if (!q->debugfs_dir)
 		goto err;
 
@@ -749,8 +748,3 @@ void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
 	debugfs_remove_recursive(q->mq_debugfs_dir);
 	q->mq_debugfs_dir = NULL;
 }
-
-void blk_mq_debugfs_init(void)
-{
-	block_debugfs_root = debugfs_create_dir("block", NULL);
-}
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 60dac10228fe..ff70219c5afd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2827,8 +2827,6 @@ void blk_mq_enable_hotplug(void)
 
 static int __init blk_mq_init(void)
 {
-	blk_mq_debugfs_init();
-
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index b52abd62b1b0..24b2256186f3 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -85,16 +85,11 @@ extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
  * debugfs helpers
  */
 #ifdef CONFIG_BLK_DEBUG_FS
-void blk_mq_debugfs_init(void);
 int blk_mq_debugfs_register(struct request_queue *q, const char *name);
 void blk_mq_debugfs_unregister(struct request_queue *q);
 int blk_mq_debugfs_register_hctxs(struct request_queue *q);
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
 #else
-static inline void blk_mq_debugfs_init(void)
-{
-}
-
 static inline int blk_mq_debugfs_register(struct request_queue *q,
 					  const char *name)
 {
diff --git a/block/blk.h b/block/blk.h
index 9a716b5925a4..22283b05fe33 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -14,6 +14,10 @@
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
+#ifdef CONFIG_DEBUG_FS
+extern struct dentry *blk_debugfs_root;
+#endif
+
 struct blk_flush_queue {
 	unsigned int		flush_queue_delayed:1;
 	unsigned int		flush_pending_idx:1;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 83d3b5b58f53..38052f625a0f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -28,6 +28,8 @@
 #include <linux/uaccess.h>
 #include <linux/list.h>
 
+#include "../../block/blk.h"
+
 #include <trace/events/block.h>
 
 #include "trace_output.h"
@@ -292,9 +294,6 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_restore(flags);
 }
 
-static struct dentry *blk_tree_root;
-static DEFINE_MUTEX(blk_tree_mutex);
-
 static void blk_trace_free(struct blk_trace *bt)
 {
 	debugfs_remove(bt->msg_file);
@@ -468,17 +467,10 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = -ENOENT;
 
-	mutex_lock(&blk_tree_mutex);
-	if (!blk_tree_root) {
-		blk_tree_root = debugfs_create_dir("block", NULL);
-		if (!blk_tree_root) {
-			mutex_unlock(&blk_tree_mutex);
-			goto err;
-		}
-	}
-	mutex_unlock(&blk_tree_mutex);
+	if (!blk_debugfs_root)
+		goto err;
 
-	dir = debugfs_create_dir(buts->name, blk_tree_root);
+	dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
 	if (!dir)
 		goto err;
-- 
2.11.0

