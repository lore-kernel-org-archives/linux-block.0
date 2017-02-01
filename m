Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 1/4] blk-mq-debugfs: Add missing __acquires() / __releases() annotations
Date: Wed, 1 Feb 2017 10:20:56 -0800
Message-ID: <20170201182059.25601-2-bart.vanassche@sandisk.com>
In-Reply-To: <20170201182059.25601-1-bart.vanassche@sandisk.com>
References: <20170201182059.25601-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

This patch avoids that sparse complains about lock imbalances.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5cd2b435a9f5..7bcd4b6edf83 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -95,6 +95,7 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 }
 
 static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
+	__acquires(&hctx->lock)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 
@@ -110,6 +111,7 @@ static void *hctx_dispatch_next(struct seq_file *m, void *v, loff_t *pos)
 }
 
 static void hctx_dispatch_stop(struct seq_file *m, void *v)
+	__releases(&hctx->lock)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 
@@ -482,6 +484,7 @@ static const struct file_operations hctx_active_fops = {
 };
 
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
+	__acquires(&ctx->lock)
 {
 	struct blk_mq_ctx *ctx = m->private;
 
@@ -497,6 +500,7 @@ static void *ctx_rq_list_next(struct seq_file *m, void *v, loff_t *pos)
 }
 
 static void ctx_rq_list_stop(struct seq_file *m, void *v)
+	__releases(&ctx->lock)
 {
 	struct blk_mq_ctx *ctx = m->private;
 
-- 
2.11.0
