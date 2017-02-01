Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 4/4] blk-mq-debug: Introduce debugfs_create_files()
Date: Wed, 1 Feb 2017 10:20:59 -0800
Message-ID: <20170201182059.25601-5-bart.vanassche@sandisk.com>
In-Reply-To: <20170201182059.25601-1-bart.vanassche@sandisk.com>
References: <20170201182059.25601-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Replace the two debugfs_create_file() loops by a call to the new
debugfs_create_files() function. Add an empty element at the end
of the two attribute arrays such that the array size does not have
to be passed to debugfs_create_files().

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 846943728939..b3bc9f02a5f5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -653,6 +653,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
 	{"queued", 0600, &hctx_queued_fops},
 	{"run", 0600, &hctx_run_fops},
 	{"active", 0400, &hctx_active_fops},
+	{},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
@@ -660,6 +661,7 @@ static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
 	{"dispatched", 0600, &ctx_dispatched_fops},
 	{"merged", 0600, &ctx_merged_fops},
 	{"completed", 0600, &ctx_completed_fops},
+	{},
 };
 
 int blk_mq_debugfs_register(struct request_queue *q, const char *name)
@@ -688,27 +690,31 @@ void blk_mq_debugfs_unregister(struct request_queue *q)
 	q->debugfs_dir = NULL;
 }
 
+static bool debugfs_create_files(struct dentry *parent, void *data,
+				const struct blk_mq_debugfs_attr *attr)
+{
+	for (; attr->name; attr++) {
+		if (!debugfs_create_file(attr->name, attr->mode, parent,
+					 data, attr->fops))
+			return false;
+	}
+	return true;
+}
+
 static int blk_mq_debugfs_register_ctx(struct request_queue *q,
 				       struct blk_mq_ctx *ctx,
 				       struct dentry *hctx_dir)
 {
 	struct dentry *ctx_dir;
 	char name[20];
-	int i;
 
 	snprintf(name, sizeof(name), "cpu%u", ctx->cpu);
 	ctx_dir = debugfs_create_dir(name, hctx_dir);
 	if (!ctx_dir)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(blk_mq_debugfs_ctx_attrs); i++) {
-		const struct blk_mq_debugfs_attr *attr;
-
-		attr = &blk_mq_debugfs_ctx_attrs[i];
-		if (!debugfs_create_file(attr->name, attr->mode, ctx_dir, ctx,
-					 attr->fops))
-			return -ENOMEM;
-	}
+	if (!debugfs_create_files(ctx_dir, ctx, blk_mq_debugfs_ctx_attrs))
+		return -ENOMEM;
 
 	return 0;
 }
@@ -726,14 +732,8 @@ static int blk_mq_debugfs_register_hctx(struct request_queue *q,
 	if (!hctx_dir)
 		return -ENOMEM;
 
-	for (i = 0; i < ARRAY_SIZE(blk_mq_debugfs_hctx_attrs); i++) {
-		const struct blk_mq_debugfs_attr *attr;
-
-		attr = &blk_mq_debugfs_hctx_attrs[i];
-		if (!debugfs_create_file(attr->name, attr->mode, hctx_dir, hctx,
-					 attr->fops))
-			return -ENOMEM;
-	}
+	if (!debugfs_create_files(hctx_dir, hctx, blk_mq_debugfs_hctx_attrs))
+		return -ENOMEM;
 
 	hctx_for_each_ctx(hctx, ctx, i) {
 		if (blk_mq_debugfs_register_ctx(q, ctx, hctx_dir))
-- 
2.11.0
