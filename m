Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34138 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdAYQHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 11:07:30 -0500
Received: by mail-pg0-f45.google.com with SMTP id 14so65589659pgg.1
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 08:07:29 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 09/10] blk-mq: move hctx io_poll, stats, and dispatched from sysfs to debugfs
Date: Wed, 25 Jan 2017 08:06:48 -0800
Message-Id: <3535c8dbffe91e2003195cc5deb0f0db21820c73.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These statistics _might_ be useful to userspace, but it's better not to
commit to an ABI for these yet. Also, the dispatched file in sysfs
couldn't be cleared, so make it clearable like the others in debugfs.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 132 +++++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-mq-sysfs.c   |  92 ----------------------------------
 2 files changed, 132 insertions(+), 92 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9b87b15619f1..28ca56dd2c4e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -270,6 +270,135 @@ static const struct file_operations hctx_sched_tags_bitmap_fops = {
 	.release	= single_release,
 };
 
+static int hctx_io_poll_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	seq_printf(m, "considered=%lu\n", hctx->poll_considered);
+	seq_printf(m, "invoked=%lu\n", hctx->poll_invoked);
+	seq_printf(m, "success=%lu\n", hctx->poll_success);
+	return 0;
+}
+
+static int hctx_io_poll_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_io_poll_show, inode->i_private);
+}
+
+static ssize_t hctx_io_poll_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	hctx->poll_considered = hctx->poll_invoked = hctx->poll_success = 0;
+	return count;
+}
+
+static const struct file_operations hctx_io_poll_fops = {
+	.open		= hctx_io_poll_open,
+	.read		= seq_read,
+	.write		= hctx_io_poll_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
+{
+	seq_printf(m, "samples=%d, mean=%lld, min=%llu, max=%llu",
+		   stat->nr_samples, stat->mean, stat->min, stat->max);
+}
+
+static int hctx_stats_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_rq_stat stat[2];
+
+	blk_stat_init(&stat[BLK_STAT_READ]);
+	blk_stat_init(&stat[BLK_STAT_WRITE]);
+
+	blk_hctx_stat_get(hctx, stat);
+
+	seq_puts(m, "read: ");
+	print_stat(m, &stat[BLK_STAT_READ]);
+	seq_puts(m, "\n");
+
+	seq_puts(m, "write: ");
+	print_stat(m, &stat[BLK_STAT_WRITE]);
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static int hctx_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_stats_show, inode->i_private);
+}
+
+static ssize_t hctx_stats_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_ctx *ctx;
+	int i;
+
+	hctx_for_each_ctx(hctx, ctx, i) {
+		blk_stat_init(&ctx->stat[BLK_STAT_READ]);
+		blk_stat_init(&ctx->stat[BLK_STAT_WRITE]);
+	}
+	return count;
+}
+
+static const struct file_operations hctx_stats_fops = {
+	.open		= hctx_stats_open,
+	.read		= seq_read,
+	.write		= hctx_stats_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int hctx_dispatched_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	int i;
+
+	seq_printf(m, "%8u\t%lu\n", 0U, hctx->dispatched[0]);
+
+	for (i = 1; i < BLK_MQ_MAX_DISPATCH_ORDER - 1; i++) {
+		unsigned int d = 1U << (i - 1);
+
+		seq_printf(m, "%8u\t%lu\n", d, hctx->dispatched[i]);
+	}
+
+	seq_printf(m, "%8u+\t%lu\n", 1U << (i - 1), hctx->dispatched[i]);
+	return 0;
+}
+
+static int hctx_dispatched_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_dispatched_show, inode->i_private);
+}
+
+static ssize_t hctx_dispatched_write(struct file *file, const char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_hw_ctx *hctx = m->private;
+	int i;
+
+	for (i = 0; i < BLK_MQ_MAX_DISPATCH_ORDER; i++)
+		hctx->dispatched[i] = 0;
+	return count;
+}
+
+static const struct file_operations hctx_dispatched_fops = {
+	.open		= hctx_dispatched_open,
+	.read		= seq_read,
+	.write		= hctx_dispatched_write,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
 {
 	struct blk_mq_ctx *ctx = m->private;
@@ -320,6 +449,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"tags_bitmap", 0400, &hctx_tags_bitmap_fops},
 	{"sched_tags", 0400, &hctx_sched_tags_fops},
 	{"sched_tags_bitmap", 0400, &hctx_sched_tags_bitmap_fops},
+	{"io_poll", 0600, &hctx_io_poll_fops},
+	{"stats", 0600, &hctx_stats_fops},
+	{"dispatched", 0600, &hctx_dispatched_fops},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index a0ae1f536ed0..f505da2c542e 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -139,21 +139,6 @@ static ssize_t blk_mq_sysfs_completed_show(struct blk_mq_ctx *ctx, char *page)
 				ctx->rq_completed[0]);
 }
 
-static ssize_t blk_mq_hw_sysfs_poll_show(struct blk_mq_hw_ctx *hctx, char *page)
-{
-	return sprintf(page, "considered=%lu, invoked=%lu, success=%lu\n",
-		       hctx->poll_considered, hctx->poll_invoked,
-		       hctx->poll_success);
-}
-
-static ssize_t blk_mq_hw_sysfs_poll_store(struct blk_mq_hw_ctx *hctx,
-					  const char *page, size_t size)
-{
-	hctx->poll_considered = hctx->poll_invoked = hctx->poll_success = 0;
-
-	return size;
-}
-
 static ssize_t blk_mq_hw_sysfs_queued_show(struct blk_mq_hw_ctx *hctx,
 					   char *page)
 {
@@ -165,25 +150,6 @@ static ssize_t blk_mq_hw_sysfs_run_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return sprintf(page, "%lu\n", hctx->run);
 }
 
-static ssize_t blk_mq_hw_sysfs_dispatched_show(struct blk_mq_hw_ctx *hctx,
-					       char *page)
-{
-	char *start_page = page;
-	int i;
-
-	page += sprintf(page, "%8u\t%lu\n", 0U, hctx->dispatched[0]);
-
-	for (i = 1; i < BLK_MQ_MAX_DISPATCH_ORDER - 1; i++) {
-		unsigned int d = 1U << (i - 1);
-
-		page += sprintf(page, "%8u\t%lu\n", d, hctx->dispatched[i]);
-	}
-
-	page += sprintf(page, "%8u+\t%lu\n", 1U << (i - 1),
-						hctx->dispatched[i]);
-	return page - start_page;
-}
-
 static ssize_t blk_mq_hw_sysfs_nr_tags_show(struct blk_mq_hw_ctx *hctx,
 					    char *page)
 {
@@ -219,47 +185,6 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return ret;
 }
 
-static void blk_mq_stat_clear(struct blk_mq_hw_ctx *hctx)
-{
-	struct blk_mq_ctx *ctx;
-	unsigned int i;
-
-	hctx_for_each_ctx(hctx, ctx, i) {
-		blk_stat_init(&ctx->stat[BLK_STAT_READ]);
-		blk_stat_init(&ctx->stat[BLK_STAT_WRITE]);
-	}
-}
-
-static ssize_t blk_mq_hw_sysfs_stat_store(struct blk_mq_hw_ctx *hctx,
-					  const char *page, size_t count)
-{
-	blk_mq_stat_clear(hctx);
-	return count;
-}
-
-static ssize_t print_stat(char *page, struct blk_rq_stat *stat, const char *pre)
-{
-	return sprintf(page, "%s samples=%llu, mean=%lld, min=%lld, max=%lld\n",
-			pre, (long long) stat->nr_samples,
-			(long long) stat->mean, (long long) stat->min,
-			(long long) stat->max);
-}
-
-static ssize_t blk_mq_hw_sysfs_stat_show(struct blk_mq_hw_ctx *hctx, char *page)
-{
-	struct blk_rq_stat stat[2];
-	ssize_t ret;
-
-	blk_stat_init(&stat[BLK_STAT_READ]);
-	blk_stat_init(&stat[BLK_STAT_WRITE]);
-
-	blk_hctx_stat_get(hctx, stat);
-
-	ret = print_stat(page, &stat[BLK_STAT_READ], "read :");
-	ret += print_stat(page + ret, &stat[BLK_STAT_WRITE], "write:");
-	return ret;
-}
-
 static struct blk_mq_ctx_sysfs_entry blk_mq_sysfs_dispatched = {
 	.attr = {.name = "dispatched", .mode = S_IRUGO },
 	.show = blk_mq_sysfs_dispatched_show,
@@ -288,10 +213,6 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_run = {
 	.attr = {.name = "run", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_run_show,
 };
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_dispatched = {
-	.attr = {.name = "dispatched", .mode = S_IRUGO },
-	.show = blk_mq_hw_sysfs_dispatched_show,
-};
 static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_nr_tags = {
 	.attr = {.name = "nr_tags", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_nr_tags_show,
@@ -308,27 +229,14 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
 	.attr = {.name = "cpu_list", .mode = S_IRUGO },
 	.show = blk_mq_hw_sysfs_cpus_show,
 };
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_poll = {
-	.attr = {.name = "io_poll", .mode = S_IWUSR | S_IRUGO },
-	.show = blk_mq_hw_sysfs_poll_show,
-	.store = blk_mq_hw_sysfs_poll_store,
-};
-static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_stat = {
-	.attr = {.name = "stats", .mode = S_IRUGO | S_IWUSR },
-	.show = blk_mq_hw_sysfs_stat_show,
-	.store = blk_mq_hw_sysfs_stat_store,
-};
 
 static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_queued.attr,
 	&blk_mq_hw_sysfs_run.attr,
-	&blk_mq_hw_sysfs_dispatched.attr,
 	&blk_mq_hw_sysfs_nr_tags.attr,
 	&blk_mq_hw_sysfs_nr_reserved_tags.attr,
 	&blk_mq_hw_sysfs_cpus.attr,
 	&blk_mq_hw_sysfs_active.attr,
-	&blk_mq_hw_sysfs_poll.attr,
-	&blk_mq_hw_sysfs_stat.attr,
 	NULL,
 };
 
-- 
2.11.0

