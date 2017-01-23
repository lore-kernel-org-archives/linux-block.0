Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35250 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWTA0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 14:00:26 -0500
Received: by mail-pf0-f174.google.com with SMTP id f144so43216636pfa.2
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 11:00:25 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 08/10] blk-mq: add tags and sched_tags bitmaps to debugfs
Date: Mon, 23 Jan 2017 10:59:45 -0800
Message-Id: <c32c0c78f0aa467f30ce5304e56bd22d68a8012a.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

These can be used to debug issues like tag leaks and stuck requests.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 48b3a11402fb..9f43b285fe3a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -191,6 +191,30 @@ static const struct file_operations hctx_tags_fops = {
 	.release	= single_release,
 };
 
+static int hctx_tags_bitmap_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct request_queue *q = hctx->queue;
+
+	mutex_lock(&q->sysfs_lock);
+	if (hctx->tags)
+		sbitmap_bitmap_show(m, &hctx->tags->bitmap_tags.sb);
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
@@ -216,6 +240,30 @@ static const struct file_operations hctx_sched_tags_fops = {
 	.release	= single_release,
 };
 
+static int hctx_sched_tags_bitmap_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct request_queue *q = hctx->queue;
+
+	mutex_lock(&q->sysfs_lock);
+	if (hctx->sched_tags)
+		sbitmap_bitmap_show(m, &hctx->sched_tags->bitmap_tags.sb);
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
@@ -263,7 +311,9 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
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

