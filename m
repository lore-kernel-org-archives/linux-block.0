Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35968 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbdAYQH2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 11:07:28 -0500
Received: by mail-pf0-f172.google.com with SMTP id 189so59281407pfu.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 08:07:28 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 08/10] blk-mq: add tags and sched_tags bitmaps to debugfs
Date: Wed, 25 Jan 2017 08:06:47 -0800
Message-Id: <4111b718c290489dae105f88678caada9d887044.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These can be used to debug issues like tag leaks and stuck requests.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9f811007cf4f..9b87b15619f1 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -197,6 +197,30 @@ static const struct file_operations hctx_tags_fops = {
 	.release	= single_release,
 };
 
+static int hctx_tags_bitmap_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct request_queue *q = hctx->queue;
+
+	mutex_lock(&q->sysfs_lock);
+	if (hctx->tags)
+		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
+	mutex_unlock(&q->sysfs_lock);
+	return 0;
+}
+
+static int hctx_tags_bitmap_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_tags_bitmap_show, inode->i_private);
+}
+
+static const struct file_operations hctx_tags_bitmap_fops = {
+	.open		= hctx_tags_bitmap_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int hctx_sched_tags_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
@@ -222,6 +246,30 @@ static const struct file_operations hctx_sched_tags_fops = {
 	.release	= single_release,
 };
 
+static int hctx_sched_tags_bitmap_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct request_queue *q = hctx->queue;
+
+	mutex_lock(&q->sysfs_lock);
+	if (hctx->sched_tags)
+		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
+	mutex_unlock(&q->sysfs_lock);
+	return 0;
+}
+
+static int hctx_sched_tags_bitmap_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_sched_tags_bitmap_show, inode->i_private);
+}
+
+static const struct file_operations hctx_sched_tags_bitmap_fops = {
+	.open		= hctx_sched_tags_bitmap_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
 {
 	struct blk_mq_ctx *ctx = m->private;
@@ -269,7 +317,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"dispatch", 0400, &hctx_dispatch_fops},
 	{"ctx_map", 0400, &hctx_ctx_map_fops},
 	{"tags", 0400, &hctx_tags_fops},
+	{"tags_bitmap", 0400, &hctx_tags_bitmap_fops},
 	{"sched_tags", 0400, &hctx_sched_tags_fops},
+	{"sched_tags_bitmap", 0400, &hctx_sched_tags_bitmap_fops},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
-- 
2.11.0

