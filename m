Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33981 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbdCAUYm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2017 15:24:42 -0500
Received: by mail-pg0-f44.google.com with SMTP id p5so23736115pga.1
        for <linux-block@vger.kernel.org>; Wed, 01 Mar 2017 12:24:06 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 2/2] blk-mq-debugfs: add q->mq_freeze_depth output
Date: Wed,  1 Mar 2017 10:42:39 -0800
Message-Id: <d4ab26006c6b454db94d548df10da3ce8908c8a1.1488393750.git.osandov@fb.com>
In-Reply-To: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
References: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
In-Reply-To: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
References: <7e888cad9e6c35835559281d3ab9e05ea48836d0.1488393750.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This can be used to diagnose freeze-related hangs.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f6d917977b33..1459546788da 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -29,6 +29,26 @@ struct blk_mq_debugfs_attr {
 	const struct file_operations *fops;
 };
 
+static int queue_freeze_depth_show(struct seq_file *m, void *v)
+{
+	struct request_queue *q = m->private;
+
+	seq_printf(m, "%d\n", atomic_read(&q->mq_freeze_depth));
+	return 0;
+}
+
+static int queue_freeze_depth_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, queue_freeze_depth_show, inode->i_private);
+}
+
+static const struct file_operations queue_freeze_depth_fops = {
+	.open		= queue_freeze_depth_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int blk_mq_debugfs_seq_open(struct inode *inode, struct file *file,
 				   const struct seq_operations *ops)
 {
@@ -636,6 +656,11 @@ static const struct file_operations ctx_completed_fops = {
 	.release	= single_release,
 };
 
+static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
+	{"freeze_depth", 0400, &queue_freeze_depth_fops},
+	{},
+};
+
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, &hctx_state_fops},
 	{"flags", 0400, &hctx_flags_fops},
@@ -753,6 +778,9 @@ int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 	if (!q->mq_debugfs_dir)
 		goto err;
 
+	if (!debugfs_create_files(q->mq_debugfs_dir, q, blk_mq_debugfs_queue_attrs))
+		return -ENOMEM;
+
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (blk_mq_debugfs_register_hctx(q, hctx))
 			goto err;
-- 
2.12.0
