Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34396 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWTAW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 14:00:22 -0500
Received: by mail-pg0-f48.google.com with SMTP id 14so47093473pgg.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 11:00:22 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 03/10] blk-mq: move hctx->dispatch and ctx->rq_list from sysfs to debugfs
Date: Mon, 23 Jan 2017 10:59:40 -0800
Message-Id: <c4344c36c87b05ad4b05280d2d95621b25c8d403.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These lists are only useful for debugging; they definitely don't belong
in sysfs. Putting them in debugfs also removes the limitation of a
single page of output.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sysfs.c   |  57 --------------------------
 2 files changed, 106 insertions(+), 57 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 0c14511fa9e0..1967c06d80e0 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -29,6 +29,20 @@ struct blk_mq_debugfs_attr {
 
 static struct dentry *block_debugfs_root;
 
+static int blk_mq_debugfs_seq_open(struct inode *inode, struct file *file,
+				   const struct seq_operations *ops)
+{
+	struct seq_file *m;
+	int ret;
+
+	ret = seq_open(file, ops);
+	if (!ret) {
+		m = file->private_data;
+		m->private = inode->i_private;
+	}
+	return ret;
+}
+
 static int hctx_state_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
@@ -69,12 +83,104 @@ static const struct file_operations hctx_flags_fops = {
 	.release	= single_release,
 };
 
+static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
+{
+	struct request *rq = list_entry_rq(v);
+
+	seq_printf(m, "%p\n", rq);
+	return 0;
+}
+
+static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	spin_lock(&hctx->lock);
+	return seq_list_start(&hctx->dispatch, *pos);
+}
+
+static void *hctx_dispatch_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	return seq_list_next(v, &hctx->dispatch, pos);
+}
+
+static void hctx_dispatch_stop(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	spin_unlock(&hctx->lock);
+}
+
+static const struct seq_operations hctx_dispatch_seq_ops = {
+	.start	= hctx_dispatch_start,
+	.next	= hctx_dispatch_next,
+	.stop	= hctx_dispatch_stop,
+	.show	= blk_mq_debugfs_rq_show,
+};
+
+static int hctx_dispatch_open(struct inode *inode, struct file *file)
+{
+	return blk_mq_debugfs_seq_open(inode, file, &hctx_dispatch_seq_ops);
+}
+
+static const struct file_operations hctx_dispatch_fops = {
+	.open		= hctx_dispatch_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
+{
+	struct blk_mq_ctx *ctx = m->private;
+
+	spin_lock(&ctx->lock);
+	return seq_list_start(&ctx->rq_list, *pos);
+}
+
+static void *ctx_rq_list_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct blk_mq_ctx *ctx = m->private;
+
+	return seq_list_next(v, &ctx->rq_list, pos);
+}
+
+static void ctx_rq_list_stop(struct seq_file *m, void *v)
+{
+	struct blk_mq_ctx *ctx = m->private;
+
+	spin_unlock(&ctx->lock);
+}
+
+static const struct seq_operations ctx_rq_list_seq_ops = {
+	.start	= ctx_rq_list_start,
+	.next	= ctx_rq_list_next,
+	.stop	= ctx_rq_list_stop,
+	.show	= blk_mq_debugfs_rq_show,
+};
+
+static int ctx_rq_list_open(struct inode *inode, struct file *file)
+{
+	return blk_mq_debugfs_seq_open(inode, file, &ctx_rq_list_seq_ops);
+}
+
+static const struct file_operations ctx_rq_list_fops = {
+	.open		= ctx_rq_list_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, &hctx_state_fops},
 	{"flags", 0400, &hctx_flags_fops},
+	{"dispatch", 0400, &hctx_dispatch_fops},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
+	{"rq_list", 0400, &ctx_rq_list_fops},
 };
 
 int blk_mq_debugfs_register(struct request_queue *q, const char *name)
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 91b93ca1c1e0..ee3694d8c4ee 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -139,41 +139,6 @@ static ssize_t blk_mq_sysfs_completed_show(struct blk_mq_ctx *ctx, char *page)
 				ctx->rq_completed[0]);
 }
 
-static ssize_t sysfs_list_show(char *page, struct list_head *list, char *msg)
-{
-	struct request *rq;
-	int len = snprintf(page, PAGE_SIZE - 1, "%s:\n", msg);
-
-	list_for_each_entry(rq, list, queuelist) {
-		const int rq_len = 2 * sizeof(rq) + 2;
-
-		/* if the output will be truncated */
-		if (PAGE_SIZE - 1 < len + rq_len) {
-			/* backspacing if it can't hold '\t...\n' */
-			if (PAGE_SIZE - 1 < len + 5)
-				len -= rq_len;
-			len += snprintf(page + len, PAGE_SIZE - 1 - len,
-					"\t...\n");
-			break;
-		}
-		len += snprintf(page + len, PAGE_SIZE - 1 - len,
-				"\t%p\n", rq);
-	}
-
-	return len;
-}
-
-static ssize_t blk_mq_sysfs_rq_list_show(struct blk_mq_ctx *ctx, char *page)
-{
-	ssize_t ret;
-
-	spin_lock(&ctx->lock);
-	ret = sysfs_list_show(page, &ctx->rq_list, "CTX pending");
-	spin_unlock(&ctx->lock);
-
-	return ret;
-}
-
 static ssize_t blk_mq_hw_sysfs_poll_show(struct blk_mq_hw_ctx *hctx, char *page)
 {
 	return sprintf(page, "considered=%lu, invoked=%lu, success=%lu\n",
@@ -219,18 +184,6 @@ static ssize_t blk_mq_hw_sysfs_dispatched_show(struct blk_mq_hw_ctx *hctx,
 	return page - start_page;
 }
 
-static ssize_t blk_mq_hw_sysfs_rq_list_show(struct blk_mq_hw_ctx *hctx,
-					    char *page)
-{
-	ssize_t ret;
-
-	spin_lock(&hctx->lock);
-	ret = sysfs_list_show(page, &hctx->dispatch, "HCTX pending");
-	spin_unlock(&hctx->lock);
-
-	return ret;
-}
-
 static ssize_t blk_mq_hw_sysfs_sched_tags_show(struct blk_mq_hw_ctx *hctx, char *page)
 {
 	if (hctx->sched_tags)
@@ -320,16 +273,11 @@ static struct blk_mq_ctx_sysfs_entry blk_mq_sysfs_completed = {
 	.attr = {.name = "completed", .mode = S_IRUGO },
 	.show = blk_mq_sysfs_completed_show,
 };
-static struct blk_mq_ctx_sysfs_entry blk_mq_sysfs_rq_list = {
-	.attr = {.name = "rq_list", .mode = S_IRUGO },
-	.show = blk_mq_sysfs_rq_list_show,
-};
 
 static struct attribute *default_ctx_attrs[] = {
 	&blk_mq_sysfs_dispatched.attr,
 	&blk_mq_sysfs_merged.attr,
 	&blk_mq_sysfs_completed.attr,
-	&blk_mq_sysfs_rq_list.attr,
 	NULL,
 };
 
@@ -349,10 +297,6 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_active = {
 	.attr = {.name = "active", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_active_show,
 };
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_pending = {
-	.attr = {.name = "pending", .mode = S_IRUGO },
-	.show = blk_mq_hw_sysfs_rq_list_show,
-};
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_sched_tags = {
 	.attr = {.name = "sched_tags", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_sched_tags_show,
@@ -380,7 +324,6 @@ static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_queued.attr,
 	&blk_mq_hw_sysfs_run.attr,
 	&blk_mq_hw_sysfs_dispatched.attr,
-	&blk_mq_hw_sysfs_pending.attr,
 	&blk_mq_hw_sysfs_tags.attr,
 	&blk_mq_hw_sysfs_sched_tags.attr,
 	&blk_mq_hw_sysfs_cpus.attr,
-- 
2.11.0

