Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36020 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753034AbdCNVEb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2017 17:04:31 -0400
Received: by mail-pf0-f177.google.com with SMTP id o126so75584444pfb.3
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2017 14:04:30 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 1/4] block: tear out blk-stat debugfs/sysfs entries
Date: Tue, 14 Mar 2017 14:03:28 -0700
Message-Id: <d6844f36f6d54c021e411068165a5b163031628f.1489524591.git.osandov@fb.com>
In-Reply-To: <cover.1489524591.git.osandov@fb.com>
References: <cover.1489524591.git.osandov@fb.com>
In-Reply-To: <cover.1489524591.git.osandov@fb.com>
References: <cover.1489524591.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These made sense when there was a single stats buffer for the request
queue, but that's going away.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 55 --------------------------------------------------
 block/blk-sysfs.c      | 26 ------------------------
 2 files changed, 81 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f6d917977b33..18672225c417 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -322,60 +322,6 @@ static const struct file_operations hctx_io_poll_fops = {
 	.release	= single_release,
 };
 
-static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
-{
-	seq_printf(m, "samples=%d, mean=%lld, min=%llu, max=%llu",
-		   stat->nr_samples, stat->mean, stat->min, stat->max);
-}
-
-static int hctx_stats_show(struct seq_file *m, void *v)
-{
-	struct blk_mq_hw_ctx *hctx = m->private;
-	struct blk_rq_stat stat[2];
-
-	blk_stat_init(&stat[BLK_STAT_READ]);
-	blk_stat_init(&stat[BLK_STAT_WRITE]);
-
-	blk_hctx_stat_get(hctx, stat);
-
-	seq_puts(m, "read: ");
-	print_stat(m, &stat[BLK_STAT_READ]);
-	seq_puts(m, "\n");
-
-	seq_puts(m, "write: ");
-	print_stat(m, &stat[BLK_STAT_WRITE]);
-	seq_puts(m, "\n");
-	return 0;
-}
-
-static int hctx_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_stats_show, inode->i_private);
-}
-
-static ssize_t hctx_stats_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	struct seq_file *m = file->private_data;
-	struct blk_mq_hw_ctx *hctx = m->private;
-	struct blk_mq_ctx *ctx;
-	int i;
-
-	hctx_for_each_ctx(hctx, ctx, i) {
-		blk_stat_init(&ctx->stat[BLK_STAT_READ]);
-		blk_stat_init(&ctx->stat[BLK_STAT_WRITE]);
-	}
-	return count;
-}
-
-static const struct file_operations hctx_stats_fops = {
-	.open		= hctx_stats_open,
-	.read		= seq_read,
-	.write		= hctx_stats_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int hctx_dispatched_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
@@ -646,7 +592,6 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"sched_tags", 0400, &hctx_sched_tags_fops},
 	{"sched_tags_bitmap", 0400, &hctx_sched_tags_bitmap_fops},
 	{"io_poll", 0600, &hctx_io_poll_fops},
-	{"stats", 0600, &hctx_stats_fops},
 	{"dispatched", 0600, &hctx_dispatched_fops},
 	{"queued", 0600, &hctx_queued_fops},
 	{"run", 0600, &hctx_run_fops},
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index c44b321335f3..6e1cf622af21 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -503,26 +503,6 @@ static ssize_t queue_dax_show(struct request_queue *q, char *page)
 	return queue_var_show(blk_queue_dax(q), page);
 }
 
-static ssize_t print_stat(char *page, struct blk_rq_stat *stat, const char *pre)
-{
-	return sprintf(page, "%s samples=%llu, mean=%lld, min=%lld, max=%lld\n",
-			pre, (long long) stat->nr_samples,
-			(long long) stat->mean, (long long) stat->min,
-			(long long) stat->max);
-}
-
-static ssize_t queue_stats_show(struct request_queue *q, char *page)
-{
-	struct blk_rq_stat stat[2];
-	ssize_t ret;
-
-	blk_queue_stat_get(q, stat);
-
-	ret = print_stat(page, &stat[BLK_STAT_READ], "read :");
-	ret += print_stat(page + ret, &stat[BLK_STAT_WRITE], "write:");
-	return ret;
-}
-
 static struct queue_sysfs_entry queue_requests_entry = {
 	.attr = {.name = "nr_requests", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_requests_show,
@@ -691,11 +671,6 @@ static struct queue_sysfs_entry queue_dax_entry = {
 	.show = queue_dax_show,
 };
 
-static struct queue_sysfs_entry queue_stats_entry = {
-	.attr = {.name = "stats", .mode = S_IRUGO },
-	.show = queue_stats_show,
-};
-
 static struct queue_sysfs_entry queue_wb_lat_entry = {
 	.attr = {.name = "wbt_lat_usec", .mode = S_IRUGO | S_IWUSR },
 	.show = queue_wb_lat_show,
@@ -733,7 +708,6 @@ static struct attribute *default_attrs[] = {
 	&queue_poll_entry.attr,
 	&queue_wc_entry.attr,
 	&queue_dax_entry.attr,
-	&queue_stats_entry.attr,
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
 	NULL,
-- 
2.12.0
