Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33003 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbdAWTAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 14:00:21 -0500
Received: by mail-pg0-f50.google.com with SMTP id 204so47203250pge.0
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 11:00:21 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 02/10] blk-mq: add hctx->{state,flags} to debugfs
Date: Mon, 23 Jan 2017 10:59:39 -0800
Message-Id: <ab6a91d92e1832116be1fdd8c47dca471badd727.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

hctx->state could come in handy for bugs where the hardware queue gets
stuck in the stopped state, and hctx->flags is just useful to know.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 01711bbf5ade..0c14511fa9e0 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -29,7 +29,49 @@ struct blk_mq_debugfs_attr {
 
 static struct dentry *block_debugfs_root;
 
+static int hctx_state_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	seq_printf(m, "0x%lx\n", hctx->state);
+	return 0;
+}
+
+static int hctx_state_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_state_show, inode->i_private);
+}
+
+static const struct file_operations hctx_state_fops = {
+	.open		= hctx_state_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int hctx_flags_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	seq_printf(m, "0x%lx\n", hctx->flags);
+	return 0;
+}
+
+static int hctx_flags_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_flags_show, inode->i_private);
+}
+
+static const struct file_operations hctx_flags_fops = {
+	.open		= hctx_flags_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
+	{"state", 0400, &hctx_state_fops},
+	{"flags", 0400, &hctx_flags_fops},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
-- 
2.11.0

