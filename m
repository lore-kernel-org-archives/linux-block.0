Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36119 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdAYQH1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Jan 2017 11:07:27 -0500
Received: by mail-pg0-f43.google.com with SMTP id 3so6991250pgj.3
        for <linux-block@vger.kernel.org>; Wed, 25 Jan 2017 08:07:27 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: [PATCH v2 06/10] blk-mq: export software queue pending map to debugfs
Date: Wed, 25 Jan 2017 08:06:45 -0800
Message-Id: <7d7f0b56d453193f821f7f22fca3e2d4174017ae.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
In-Reply-To: <cover.1485360145.git.osandov@fb.com>
References: <cover.1485360145.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is useful for debugging problems where we've gotten stuck with
requests in the software queues.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ee947f2f605b..857bdadc6b1f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -134,6 +134,26 @@ static const struct file_operations hctx_dispatch_fops = {
 	.release	= seq_release,
 };
 
+static int hctx_ctx_map_show(struct seq_file *m, void *v)
+{
+	struct blk_mq_hw_ctx *hctx = m->private;
+
+	sbitmap_bitmap_show(&hctx->ctx_map, m);
+	return 0;
+}
+
+static int hctx_ctx_map_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hctx_ctx_map_show, inode->i_private);
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
@@ -179,6 +199,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"state", 0400, &hctx_state_fops},
 	{"flags", 0400, &hctx_flags_fops},
 	{"dispatch", 0400, &hctx_dispatch_fops},
+	{"ctx_map", 0400, &hctx_ctx_map_fops},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
-- 
2.11.0

