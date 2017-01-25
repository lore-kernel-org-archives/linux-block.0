Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35966 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdAYQH2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 11:07:28 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so59281335pfu.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 08:07:27 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 07/10] blk-mq: move tags and sched_tags info from sysfs to debugfs
Date: Wed, 25 Jan 2017 08:06:46 -0800
Message-Id: <86d3e6ab6c43a23c4a51a2f595d3f50b3df6d7a7.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These are very tied to the blk-mq tag implementation, so exposing them
to sysfs isn't a great idea. Move the debugging information to debugfs
and add basic entries for the number of tags and the number of reserved
tags to sysfs.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sysfs.c   | 33 ++++++++++++------------
 block/blk-mq-tag.c     | 27 -------------------
 block/blk-mq-tag.h     |  1 -
 4 files changed, 86 insertions(+), 45 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 857bdadc6b1f..9f811007cf4f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -20,6 +20,7 @@
 
 #include <linux/blk-mq.h>
 #include "blk-mq.h"
+#include "blk-mq-tag.h"
 
 struct blk_mq_debugfs_attr {
 	const char *name;
@@ -154,6 +155,73 @@ static const struct file_operations hctx_ctx_map_fops = {
 	.release	= single_release,
 };
 
+static void blk_mq_debugfs_tags_show(struct seq_file *m,
+				     struct blk_mq_tags *tags)
+{
+	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
+	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
+	seq_printf(m, "active_queues=%d\n",
+		   atomic_read(&tags->active_queues));
+
+	seq_puts(m, "\nbitmap_tags:\n");
+	sbitmap_queue_show(&tags->bitmap_tags, m);
+
+	if (tags->nr_reserved_tags) {
+		seq_puts(m, "\nbreserved_tags:\n");
+		sbitmap_queue_show(&tags->breserved_tags, m);
+	}
+}
+
+static int hctx_tags_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct request_queue *q = hctx->queue;
+
+	mutex_lock(&q->sysfs_lock);
+	if (hctx->tags)
+		blk_mq_debugfs_tags_show(m, hctx->tags);
+	mutex_unlock(&q->sysfs_lock);
+
+	return 0;
+}
+
+static int hctx_tags_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_tags_show, inode->i_private);
+}
+
+static const struct file_operations hctx_tags_fops = {
+	.open		= hctx_tags_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int hctx_sched_tags_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct request_queue *q = hctx->queue;
+
+	mutex_lock(&q->sysfs_lock);
+	if (hctx->sched_tags)
+		blk_mq_debugfs_tags_show(m, hctx->sched_tags);
+	mutex_unlock(&q->sysfs_lock);
+
+	return 0;
+}
+
+static int hctx_sched_tags_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_sched_tags_show, inode->i_private);
+}
+
+static const struct file_operations hctx_sched_tags_fops = {
+	.open		= hctx_sched_tags_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
 {
 	struct blk_mq_ctx *ctx = m->private;
@@ -200,6 +268,8 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"flags", 0400, &hctx_flags_fops},
 	{"dispatch", 0400, &hctx_dispatch_fops},
 	{"ctx_map", 0400, &hctx_ctx_map_fops},
+	{"tags", 0400, &hctx_tags_fops},
+	{"sched_tags", 0400, &hctx_sched_tags_fops},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index ee3694d8c4ee..a0ae1f536ed0 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -184,17 +184,16 @@ static ssize_t blk_mq_hw_sysfs_dispatched_show(struct blk_mq_hw_ctx *hctx,
 	return page - start_page;
 }
 
-static ssize_t blk_mq_hw_sysfs_sched_tags_show(struct blk_mq_hw_ctx *hctx, char *page)
+static ssize_t blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
+					    char *page)
 {
-	if (hctx->sched_tags)
-		return blk_mq_tag_sysfs_show(hctx->sched_tags, page);
-
-	return 0;
+	return sprintf(page, "%u\n", hctx->tags->nr_tags);
 }
 
-static ssize_t blk_mq_hw_sysfs_tags_show(struct blk_mq_hw_ctx *hctx, char *page)
+static ssize_t blk_mq_hw_sysfs_nr_reserved_tags_show(struct blk_mq_hw_ctx *hctx,
+						     char *page)
 {
-	return blk_mq_tag_sysfs_show(hctx->tags, page);
+	return sprintf(page, "%u\n", hctx->tags->nr_reserved_tags);
 }
 
 static ssize_t blk_mq_hw_sysfs_active_show(struct blk_mq_hw_ctx *hctx, char *page)
@@ -293,18 +292,18 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_dispatched = {
 	.attr = {.name = "dispatched", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_dispatched_show,
 };
+static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
+	.attr = {.name = "nr_tags", .mode = S_IRUGO },
+	.show = blk_mq_hw_sysfs_nr_tags_show,
+};
+static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_reserved_tags = {
+	.attr = {.name = "nr_reserved_tags", .mode = S_IRUGO },
+	.show = blk_mq_hw_sysfs_nr_reserved_tags_show,
+};
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_active = {
 	.attr = {.name = "active", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_active_show,
 };
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_sched_tags = {
-	.attr = {.name = "sched_tags", .mode = S_IRUGO },
-	.show = blk_mq_hw_sysfs_sched_tags_show,
-};
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_tags = {
-	.attr = {.name = "tags", .mode = S_IRUGO },
-	.show = blk_mq_hw_sysfs_tags_show,
-};
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
 	.attr = {.name = "cpu_list", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_cpus_show,
@@ -324,8 +323,8 @@ static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_queued.attr,
 	&blk_mq_hw_sysfs_run.attr,
 	&blk_mq_hw_sysfs_dispatched.attr,
-	&blk_mq_hw_sysfs_tags.attr,
-	&blk_mq_hw_sysfs_sched_tags.attr,
+	&blk_mq_hw_sysfs_nr_tags.attr,
+	&blk_mq_hw_sysfs_nr_reserved_tags.attr,
 	&blk_mq_hw_sysfs_cpus.attr,
 	&blk_mq_hw_sysfs_active.attr,
 	&blk_mq_hw_sysfs_poll.attr,
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 1b156ca79af6..f8de2dbbb29f 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -329,11 +329,6 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
 
 }
 
-static unsigned int bt_unused_tags(const struct sbitmap_queue *bt)
-{
-	return bt->sb.depth - sbitmap_weight(&bt->sb);
-}
-
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
 		    bool round_robin, int node)
 {
@@ -469,25 +464,3 @@ u32 blk_mq_unique_tag(struct request *rq)
 		(rq->tag & BLK_MQ_UNIQUE_TAG_MASK);
 }
 EXPORT_SYMBOL(blk_mq_unique_tag);
-
-ssize_t blk_mq_tag_sysfs_show(struct blk_mq_tags *tags, char *page)
-{
-	char *orig_page = page;
-	unsigned int free, res;
-
-	if (!tags)
-		return 0;
-
-	page += sprintf(page, "nr_tags=%u, reserved_tags=%u, "
-			"bits_per_word=%u\n",
-			tags->nr_tags, tags->nr_reserved_tags,
-			1U << tags->bitmap_tags.sb.shift);
-
-	free = bt_unused_tags(&tags->bitmap_tags);
-	res = bt_unused_tags(&tags->breserved_tags);
-
-	page += sprintf(page, "nr_free=%u, nr_reserved=%u\n", free, res);
-	page += sprintf(page, "active_queues=%u\n", atomic_read(&tags->active_queues));
-
-	return page - orig_page;
-}
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index ac22878462e7..63497423c5cd 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -28,7 +28,6 @@ extern unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data);
 extern void blk_mq_put_tag(struct blk_mq_hw_ctx *hctx, struct blk_mq_tags *tags,
 			   struct blk_mq_ctx *ctx, unsigned int tag);
 extern bool blk_mq_has_free_tags(struct blk_mq_tags *tags);
-extern ssize_t blk_mq_tag_sysfs_show(struct blk_mq_tags *tags, char *page);
 extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_tags **tags,
 					unsigned int depth, bool can_grow);
-- 
2.11.0

