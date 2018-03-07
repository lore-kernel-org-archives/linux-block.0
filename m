Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:40299 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753996AbeCGDYC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Mar 2018 22:24:02 -0500
From: Chengguang Xu <cgxu519@gmx.com>
To: mlyle@lyle.org, tang.junhui@zte.com.cn, kent.overstreet@gmail.com
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2] bcache: move closure debug file into debug direcotry
Date: Wed,  7 Mar 2018 11:23:21 +0800
Message-Id: <1520393001-157614-1-git-send-email-cgxu519@gmx.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In current code closure debug file is outside of debug directory
and when unloading module there is lack of removing operation
for closure debug file, so it will cause creating error when trying
to reload  module.

This patch move closure debug file into "bcache" debug direcory
so that the file can get deleted properly.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
Changes since v1:
- Rename dentry name of debug directory to "bcache_debug" from "debug" to
avoid compile error.

 drivers/md/bcache/closure.c |  9 +++++----
 drivers/md/bcache/closure.h |  5 +++--
 drivers/md/bcache/debug.c   | 14 +++++++-------
 drivers/md/bcache/super.c   |  3 +--
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 7f12920..c0949c9 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -157,7 +157,7 @@ void closure_debug_destroy(struct closure *cl)
 }
 EXPORT_SYMBOL(closure_debug_destroy);
 
-static struct dentry *debug;
+static struct dentry *closure_debug;
 
 static int debug_seq_show(struct seq_file *f, void *data)
 {
@@ -199,11 +199,12 @@ static int debug_seq_open(struct inode *inode, struct file *file)
 	.release	= single_release
 };
 
-void __init closure_debug_init(void)
+int __init closure_debug_init(void)
 {
-	debug = debugfs_create_file("closures", 0400, NULL, NULL, &debug_ops);
+	closure_debug = debugfs_create_file("closures",
+				0400, bcache_debug, NULL, &debug_ops);
+	return IS_ERR_OR_NULL(closure_debug);
 }
-
 #endif
 
 MODULE_AUTHOR("Kent Overstreet <koverstreet@google.com>");
diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index 3b9dfc9..71427eb 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -105,6 +105,7 @@
 struct closure;
 struct closure_syncer;
 typedef void (closure_fn) (struct closure *);
+extern struct dentry *bcache_debug;
 
 struct closure_waitlist {
 	struct llist_head	list;
@@ -185,13 +186,13 @@ static inline void closure_sync(struct closure *cl)
 
 #ifdef CONFIG_BCACHE_CLOSURES_DEBUG
 
-void closure_debug_init(void);
+int closure_debug_init(void);
 void closure_debug_create(struct closure *cl);
 void closure_debug_destroy(struct closure *cl);
 
 #else
 
-static inline void closure_debug_init(void) {}
+static inline int closure_debug_init(void) { return 0; }
 static inline void closure_debug_create(struct closure *cl) {}
 static inline void closure_debug_destroy(struct closure *cl) {}
 
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index af89408..028f7b3 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -17,7 +17,7 @@
 #include <linux/random.h>
 #include <linux/seq_file.h>
 
-static struct dentry *debug;
+struct dentry *bcache_debug;
 
 #ifdef CONFIG_BCACHE_DEBUG
 
@@ -232,11 +232,11 @@ static int bch_dump_release(struct inode *inode, struct file *file)
 
 void bch_debug_init_cache_set(struct cache_set *c)
 {
-	if (!IS_ERR_OR_NULL(debug)) {
+	if (!IS_ERR_OR_NULL(bcache_debug)) {
 		char name[50];
 		snprintf(name, 50, "bcache-%pU", c->sb.set_uuid);
 
-		c->debug = debugfs_create_file(name, 0400, debug, c,
+		c->debug = debugfs_create_file(name, 0400, bcache_debug, c,
 					       &cache_set_debug_ops);
 	}
 }
@@ -245,13 +245,13 @@ void bch_debug_init_cache_set(struct cache_set *c)
 
 void bch_debug_exit(void)
 {
-	if (!IS_ERR_OR_NULL(debug))
-		debugfs_remove_recursive(debug);
+	if (!IS_ERR_OR_NULL(bcache_debug))
+		debugfs_remove_recursive(bcache_debug);
 }
 
 int __init bch_debug_init(struct kobject *kobj)
 {
-	debug = debugfs_create_dir("bcache", NULL);
+	bcache_debug = debugfs_create_dir("bcache", NULL);
 
-	return IS_ERR_OR_NULL(debug);
+	return IS_ERR_OR_NULL(bcache_debug);
 }
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 1a9fdab..b784292 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2133,7 +2133,6 @@ static int __init bcache_init(void)
 	mutex_init(&bch_register_lock);
 	init_waitqueue_head(&unregister_wait);
 	register_reboot_notifier(&reboot);
-	closure_debug_init();
 
 	bcache_major = register_blkdev(0, "bcache");
 	if (bcache_major < 0) {
@@ -2145,7 +2144,7 @@ static int __init bcache_init(void)
 	if (!(bcache_wq = alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0)) ||
 	    !(bcache_kobj = kobject_create_and_add("bcache", fs_kobj)) ||
 	    bch_request_init() ||
-	    bch_debug_init(bcache_kobj) ||
+	    bch_debug_init(bcache_kobj) || closure_debug_init() ||
 	    sysfs_create_files(bcache_kobj, files))
 		goto err;
 
-- 
1.8.3.1
