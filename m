Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34401 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbdAWTAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 14:00:24 -0500
Received: by mail-pg0-f51.google.com with SMTP id 14so47093763pgg.1
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2017 11:00:24 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH 06/10] blk-mq: export software queue pending map to debugfs
Date: Mon, 23 Jan 2017 10:59:43 -0800
Message-Id: <9006e3aee4f0bdecdfb879ec5e227c50d9ff6256.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
In-Reply-To: <cover.1485197480.git.osandov@fb.com>
References: <cover.1485197480.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is useful for debugging problems where we've gotten stuck with
requests in the software queues.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ee947f2f605b..4ee6ab28f56f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -134,6 +134,20 @@ static const struct file_operations hctx_dispatch_fops = {
 	.release	= seq_release,
 };
 
+static int hctx_ctx_map_open(struct inode *inode, struct file *file)
+{
+	struct blk_mq_hw_ctx *hctx = inode->i_private;
+
+	return single_open(file, sbitmap_bitmap_show, &hctx->ctx_map);
+}
+
+static const struct file_operations hctx_ctx_map_fops = {
+	.open		= hctx_ctx_map_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
 {
 	struct blk_mq_ctx *ctx = m->private;
@@ -179,6 +193,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, &hctx_state_fops},
 	{"flags", 0400, &hctx_flags_fops},
 	{"dispatch", 0400, &hctx_dispatch_fops},
+	{"ctx_map", 0400, &hctx_ctx_map_fops},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
-- 
2.11.0

