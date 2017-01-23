Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33938 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdAWTA1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 14:00:27 -0500
Received: by mail-pf0-f177.google.com with SMTP id e4so43114638pfg.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 11:00:27 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 10/10] blk-mq: move hctx and ctx counters from sysfs to debugfs
Date: Mon, 23 Jan 2017 10:59:47 -0800
Message-Id: <594c3becb32cb126ea5b47ddd43745cf829c7a0d.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These counters aren't as out-of-place in sysfs as the other stuff, but
debugfs is a slightly better home for them.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 181 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sysfs.c   |  64 -----------------
 2 files changed, 181 insertions(+), 64 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 37780d10bc9e..4a28c285c685 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -393,6 +393,88 @@ static const struct file_operations hctx_dispatched_fops = {
 	.release	= single_release,
 };
 
+static int hctx_queued_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	seq_printf(m, "%lu\n", hctx->queued);
+	return 0;
+}
+
+static int hctx_queued_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_queued_show, inode->i_private);
+}
+
+static ssize_t hctx_queued_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	hctx->queued = 0;
+	return count;
+}
+
+static const struct file_operations hctx_queued_fops = {
+	.open		= hctx_queued_open,
+	.read		= seq_read,
+	.write		= hctx_queued_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int hctx_run_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	seq_printf(m, "%lu\n", hctx->run);
+	return 0;
+}
+
+static int hctx_run_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_run_show, inode->i_private);
+}
+
+static ssize_t hctx_run_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	hctx->run = 0;
+	return count;
+}
+
+static const struct file_operations hctx_run_fops = {
+	.open		= hctx_run_open,
+	.read		= seq_read,
+	.write		= hctx_run_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int hctx_active_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	seq_printf(m, "%d\n", atomic_read(&hctx->nr_active));
+	return 0;
+}
+
+static int hctx_active_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_active_show, inode->i_private);
+}
+
+static const struct file_operations hctx_active_fops = {
+	.open		= hctx_active_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
 {
 	struct blk_mq_ctx *ctx = m->private;
@@ -434,6 +516,99 @@ static const struct file_operations ctx_rq_list_fops = {
 	.release	= seq_release,
 };
 
+static int ctx_dispatched_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_ctx *ctx = m->private;
+
+	seq_printf(m, "%lu %lu\n", ctx->rq_dispatched[1], ctx->rq_dispatched[0]);
+	return 0;
+}
+
+static int ctx_dispatched_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ctx_dispatched_show, inode->i_private);
+}
+
+static ssize_t ctx_dispatched_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_ctx *ctx = m->private;
+
+	ctx->rq_dispatched[0] = ctx->rq_dispatched[1] = 0;
+	return count;
+}
+
+static const struct file_operations ctx_dispatched_fops = {
+	.open		= ctx_dispatched_open,
+	.read		= seq_read,
+	.write		= ctx_dispatched_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int ctx_merged_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_ctx *ctx = m->private;
+
+	seq_printf(m, "%lu\n", ctx->rq_merged);
+	return 0;
+}
+
+static int ctx_merged_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ctx_merged_show, inode->i_private);
+}
+
+static ssize_t ctx_merged_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_ctx *ctx = m->private;
+
+	ctx->rq_merged = 0;
+	return count;
+}
+
+static const struct file_operations ctx_merged_fops = {
+	.open		= ctx_merged_open,
+	.read		= seq_read,
+	.write		= ctx_merged_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int ctx_completed_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_ctx *ctx = m->private;
+
+	seq_printf(m, "%lu %lu\n", ctx->rq_completed[1], ctx->rq_completed[0]);
+	return 0;
+}
+
+static int ctx_completed_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ctx_completed_show, inode->i_private);
+}
+
+static ssize_t ctx_completed_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_ctx *ctx = m->private;
+
+	ctx->rq_completed[0] = ctx->rq_completed[1] = 0;
+	return count;
+}
+
+static const struct file_operations ctx_completed_fops = {
+	.open		= ctx_completed_open,
+	.read		= seq_read,
+	.write		= ctx_completed_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, &hctx_state_fops},
 	{"flags", 0400, &hctx_flags_fops},
@@ -446,10 +621,16 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"io_poll", 0600, &hctx_io_poll_fops},
 	{"stats", 0600, &hctx_stats_fops},
 	{"dispatched", 0600, &hctx_dispatched_fops},
+	{"queued", 0600, &hctx_queued_fops},
+	{"run", 0600, &hctx_run_fops},
+	{"active", 0400, &hctx_active_fops},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{"rq_list", 0400, &ctx_rq_list_fops},
+	{"dispatched", 0600, &ctx_dispatched_fops},
+	{"merged", 0600, &ctx_merged_fops},
+	{"completed", 0600, &ctx_completed_fops},
 };
 
 int blk_mq_debugfs_register(struct request_queue *q, const char *name)
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index f505da2c542e..308b3f4fc310 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -122,34 +122,6 @@ static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
 	return res;
 }
 
-static ssize_t blk_mq_sysfs_dispatched_show(struct blk_mq_ctx *ctx, char *page)
-{
-	return sprintf(page, "%lu %lu\n", ctx->rq_dispatched[1],
-				ctx->rq_dispatched[0]);
-}
-
-static ssize_t blk_mq_sysfs_merged_show(struct blk_mq_ctx *ctx, char *page)
-{
-	return sprintf(page, "%lu\n", ctx->rq_merged);
-}
-
-static ssize_t blk_mq_sysfs_completed_show(struct blk_mq_ctx *ctx, char *page)
-{
-	return sprintf(page, "%lu %lu\n", ctx->rq_completed[1],
-				ctx->rq_completed[0]);
-}
-
-static ssize_t blk_mq_hw_sysfs_queued_show(struct blk_mq_hw_ctx *hctx,
-					   char *page)
-{
-	return sprintf(page, "%lu\n", hctx->queued);
-}
-
-static ssize_t blk_mq_hw_sysfs_run_show(struct blk_mq_hw_ctx *hctx, char *page)
-{
-	return sprintf(page, "%lu\n", hctx->run);
-}
-
 static ssize_t blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
 					    char *page)
 {
@@ -162,11 +134,6 @@ static ssize_t blk_mq_hw_sysfs_nr_reserved_tags_show(struct blk_mq_hw_ctx *hctx,
 	return sprintf(page, "%u\n", hctx->tags->nr_reserved_tags);
 }
 
-static ssize_t blk_mq_hw_sysfs_active_show(struct blk_mq_hw_ctx *hctx, char *page)
-{
-	return sprintf(page, "%u\n", atomic_read(&hctx->nr_active));
-}
-
 static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 {
 	unsigned int i, first = 1;
@@ -185,34 +152,10 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return ret;
 }
 
-static struct blk_mq_ctx_sysfs_entry blk_mq_sysfs_dispatched = {
-	.attr = {.name = "dispatched", .mode = S_IRUGO },
-	.show = blk_mq_sysfs_dispatched_show,
-};
-static struct blk_mq_ctx_sysfs_entry blk_mq_sysfs_merged = {
-	.attr = {.name = "merged", .mode = S_IRUGO },
-	.show = blk_mq_sysfs_merged_show,
-};
-static struct blk_mq_ctx_sysfs_entry blk_mq_sysfs_completed = {
-	.attr = {.name = "completed", .mode = S_IRUGO },
-	.show = blk_mq_sysfs_completed_show,
-};
-
 static struct attribute *default_ctx_attrs[] = {
-	&blk_mq_sysfs_dispatched.attr,
-	&blk_mq_sysfs_merged.attr,
-	&blk_mq_sysfs_completed.attr,
 	NULL,
 };
 
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_queued = {
-	.attr = {.name = "queued", .mode = S_IRUGO },
-	.show = blk_mq_hw_sysfs_queued_show,
-};
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_run = {
-	.attr = {.name = "run", .mode = S_IRUGO },
-	.show = blk_mq_hw_sysfs_run_show,
-};
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
 	.attr = {.name = "nr_tags", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_nr_tags_show,
@@ -221,22 +164,15 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_reserved_tags = {
 	.attr = {.name = "nr_reserved_tags", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_nr_reserved_tags_show,
 };
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_active = {
-	.attr = {.name = "active", .mode = S_IRUGO },
-	.show = blk_mq_hw_sysfs_active_show,
-};
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
 	.attr = {.name = "cpu_list", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_cpus_show,
 };
 
 static struct attribute *default_hw_ctx_attrs[] = {
-	&blk_mq_hw_sysfs_queued.attr,
-	&blk_mq_hw_sysfs_run.attr,
 	&blk_mq_hw_sysfs_nr_tags.attr,
 	&blk_mq_hw_sysfs_nr_reserved_tags.attr,
 	&blk_mq_hw_sysfs_cpus.attr,
-	&blk_mq_hw_sysfs_active.attr,
 	NULL,
 };
 
-- 
2.11.0

