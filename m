Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33926 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdAWTAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 14:00:20 -0500
Received: by mail-pf0-f172.google.com with SMTP id e4so43113884pfg.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 11:00:20 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 01/10] blk-mq: create debugfs directory tree
Date: Mon, 23 Jan 2017 10:59:38 -0800
Message-Id: <047e034aa00fe3e642ba38e1988361867b69fc07.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

In preparation for putting blk-mq debugging information in debugfs,
create a directory tree mirroring the one in sysfs:

    # tree -d /sys/kernel/debug/block
    /sys/kernel/debug/block
    |-- nvme0n1
    |   `-- mq
    |       |-- 0
    |       |   `-- cpu0
    |       |-- 1
    |       |   `-- cpu1
    |       |-- 2
    |       |   `-- cpu2
    |       `-- 3
    |           `-- cpu3
    `-- vda
        `-- mq
            `-- 0
                |-- cpu0
                |-- cpu1
                |-- cpu2
                `-- cpu3

Also add the scaffolding for the actual files that will go in here,
either under the hardware queue or software queue directories.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/Makefile         |   1 +
 block/blk-mq-debugfs.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sysfs.c   |   8 +++
 block/blk-mq.c         |   2 +
 block/blk-mq.h         |  33 +++++++++++
 include/linux/blkdev.h |   5 ++
 6 files changed, 201 insertions(+)
 create mode 100644 block/blk-mq-debugfs.c

diff --git a/block/Makefile b/block/Makefile
index 3ee0abd7205a..6cabe6bd2882 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
+obj-$(CONFIG_DEBUG_FS)		+= blk-mq-debugfs.o
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
new file mode 100644
index 000000000000..01711bbf5ade
--- /dev/null
+++ b/block/blk-mq-debugfs.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 2017 Facebook
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/debugfs.h>
+
+#include <linux/blk-mq.h>
+#include "blk-mq.h"
+
+struct blk_mq_debugfs_attr {
+	const char *name;
+	umode_t mode;
+	const struct file_operations *fops;
+};
+
+static struct dentry *block_debugfs_root;
+
+static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
+};
+
+static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
+};
+
+int blk_mq_debugfs_register(struct request_queue *q, const char *name)
+{
+	if (!block_debugfs_root)
+		return -ENOENT;
+
+	q->debugfs_dir = debugfs_create_dir(name, block_debugfs_root);
+	if (!q->debugfs_dir)
+		goto err;
+
+	if (blk_mq_debugfs_register_hctxs(q))
+		goto err;
+
+	return 0;
+
+err:
+	blk_mq_debugfs_unregister(q);
+	return -ENOMEM;
+}
+
+void blk_mq_debugfs_unregister(struct request_queue *q)
+{
+	debugfs_remove_recursive(q->debugfs_dir);
+	q->mq_debugfs_dir = NULL;
+	q->debugfs_dir = NULL;
+}
+
+static int blk_mq_debugfs_register_ctx(struct request_queue *q,
+				       struct blk_mq_ctx *ctx,
+				       struct dentry *hctx_dir)
+{
+	struct dentry *ctx_dir;
+	char name[20];
+	int i;
+
+	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
+	ctx_dir = debugfs_create_dir(name, hctx_dir);
+	if (!ctx_dir)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(blk_mq_debugfs_ctx_attrs); i++) {
+		const struct blk_mq_debugfs_attr *attr;
+
+		attr = &blk_mq_debugfs_ctx_attrs[i];
+		if (!debugfs_create_file(attr->name, attr->mode, ctx_dir, ctx,
+					 attr->fops))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int blk_mq_debugfs_register_hctx(struct request_queue *q,
+					struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_ctx *ctx;
+	struct dentry *hctx_dir;
+	char name[20];
+	int i;
+
+	snprintf(name, sizeof(name), "%u", hctx->queue_num);
+	hctx_dir = debugfs_create_dir(name, q->mq_debugfs_dir);
+	if (!hctx_dir)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(blk_mq_debugfs_hctx_attrs); i++) {
+		const struct blk_mq_debugfs_attr *attr;
+
+		attr = &blk_mq_debugfs_hctx_attrs[i];
+		if (!debugfs_create_file(attr->name, attr->mode, hctx_dir, hctx,
+					 attr->fops))
+			return -ENOMEM;
+	}
+
+	hctx_for_each_ctx(hctx, ctx, i) {
+		if (blk_mq_debugfs_register_ctx(q, ctx, hctx_dir))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int i;
+
+	if (!q->debugfs_dir)
+		return -ENOENT;
+
+	q->mq_debugfs_dir = debugfs_create_dir("mq", q->debugfs_dir);
+	if (!q->mq_debugfs_dir)
+		goto err;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (blk_mq_debugfs_register_hctx(q, hctx))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	blk_mq_debugfs_unregister_hctxs(q);
+	return -ENOMEM;
+}
+
+void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
+{
+	debugfs_remove_recursive(q->mq_debugfs_dir);
+	q->mq_debugfs_dir = NULL;
+}
+
+void blk_mq_debugfs_init(void)
+{
+	block_debugfs_root = debugfs_create_dir("block", NULL);
+}
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 2caecaa98e40..91b93ca1c1e0 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -468,6 +468,8 @@ static void __blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 		kobject_put(&hctx->kobj);
 	}
 
+	blk_mq_debugfs_unregister(q);
+
 	kobject_uevent(&q->mq_kobj, KOBJ_REMOVE);
 	kobject_del(&q->mq_kobj);
 	kobject_put(&q->mq_kobj);
@@ -517,6 +519,8 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 
 	kobject_uevent(&q->mq_kobj, KOBJ_ADD);
 
+	blk_mq_debugfs_register(q, kobject_name(&dev->kobj));
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
@@ -542,6 +546,8 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 	if (!q->mq_sysfs_init_done)
 		return;
 
+	blk_mq_debugfs_unregister_hctxs(q);
+
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
 }
@@ -554,6 +560,8 @@ int blk_mq_sysfs_register(struct request_queue *q)
 	if (!q->mq_sysfs_init_done)
 		return ret;
 
+	blk_mq_debugfs_register_hctxs(q);
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
 		if (ret)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ee69e5e89769..d9668d192722 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2796,6 +2796,8 @@ void blk_mq_enable_hotplug(void)
 
 static int __init blk_mq_init(void)
 {
+	blk_mq_debugfs_init();
+
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 0c7c034d9ddd..6c24b901acd7 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -78,6 +78,39 @@ extern int blk_mq_sysfs_register(struct request_queue *q);
 extern void blk_mq_sysfs_unregister(struct request_queue *q);
 extern void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx);
 
+/*
+ * debugfs helpers
+ */
+#ifdef CONFIG_DEBUG_FS
+void blk_mq_debugfs_init(void);
+int blk_mq_debugfs_register(struct request_queue *q, const char *name);
+void blk_mq_debugfs_unregister(struct request_queue *q);
+int blk_mq_debugfs_register_hctxs(struct request_queue *q);
+void blk_mq_debugfs_unregister_hctxs(struct request_queue *q);
+#else
+static inline void blk_mq_debugfs_init(void)
+{
+}
+
+int blk_mq_debugfs_register(struct request_queue *q, const char *name);
+{
+	return 0;
+}
+
+void blk_mq_debugfs_unregister(struct request_queue *q)
+{
+}
+
+int blk_mq_debugfs_register_hctxs(struct request_queue *q)
+{
+	return 0;
+}
+
+void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
+{
+}
+#endif
+
 extern void blk_mq_rq_timed_out(struct request *req, bool reserved);
 
 void blk_mq_release(struct request_queue *q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 25564857f5f8..0ee283f3cffe 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -571,6 +571,11 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		*bio_split;
 
+#ifdef CONFIG_DEBUG_FS
+	struct dentry		*debugfs_dir;
+	struct dentry		*mq_debugfs_dir;
+#endif
+
 	bool			mq_sysfs_init_done;
 };
 
-- 
2.11.0

