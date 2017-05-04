Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36038 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdEDHbt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 03:31:49 -0400
Received: by mail-pg0-f53.google.com with SMTP id t7so4071621pgt.3
        for <linux-block@vger.kernel.org>; Thu, 04 May 2017 00:31:49 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH v2 06/12] blk-mq-debugfs: get rid of a bunch of boilerplate
Date: Thu,  4 May 2017 00:31:28 -0700
Message-Id: <fe05c2e075a1f02a952760f38a3854942f38478f.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
In-Reply-To: <cover.1493882751.git.osandov@fb.com>
References: <cover.1493882751.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

A large part of blk-mq-debugfs.c is file_operations and seq_file
boilerplate. This sucks as is but will suck even more when schedulers
can define their own debugfs entries. Factor it all out into a single
blk_mq_debugfs_fops which multiplexes as needed. We store the
request_queue, blk_mq_hw_ctx, or blk_mq_ctx in the parent directory
dentry, which is kind of hacky, but it works.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 464 +++++++++++++++----------------------------------
 1 file changed, 136 insertions(+), 328 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2eae3238fb35..1579af6fcbed 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -26,23 +26,12 @@
 struct blk_mq_debugfs_attr {
 	const char *name;
 	umode_t mode;
-	const struct file_operations *fops;
+	int (*show)(void *, struct seq_file *);
+	ssize_t (*write)(void *, const char __user *, size_t, loff_t *);
+	/* Set either .show or .seq_ops. */
+	const struct seq_operations *seq_ops;
 };
 
-static int blk_mq_debugfs_seq_open(struct inode *inode, struct file *file,
-				   const struct seq_operations *ops)
-{
-	struct seq_file *m;
-	int ret;
-
-	ret = seq_open(file, ops);
-	if (!ret) {
-		m = file->private_data;
-		m->private = inode->i_private;
-	}
-	return ret;
-}
-
 static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 			  const char *const *flag_name, int flag_name_count)
 {
@@ -97,9 +86,9 @@ static const char *const blk_queue_flag_name[] = {
 };
 #undef QUEUE_FLAG_NAME
 
-static int blk_queue_flags_show(struct seq_file *m, void *v)
+static int queue_state_show(void *data, struct seq_file *m)
 {
-	struct request_queue *q = m->private;
+	struct request_queue *q = data;
 
 	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,
 		       ARRAY_SIZE(blk_queue_flag_name));
@@ -107,10 +96,10 @@ static int blk_queue_flags_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t blk_queue_flags_store(struct file *file, const char __user *buf,
-				     size_t count, loff_t *ppos)
+static ssize_t queue_state_write(void *data, const char __user *buf,
+				 size_t count, loff_t *ppos)
 {
-	struct request_queue *q = file_inode(file)->i_private;
+	struct request_queue *q = data;
 	char opbuf[16] = { }, *op;
 
 	if (count >= sizeof(opbuf)) {
@@ -134,19 +123,6 @@ static ssize_t blk_queue_flags_store(struct file *file, const char __user *buf,
 	return count;
 }
 
-static int blk_queue_flags_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, blk_queue_flags_show, inode->i_private);
-}
-
-static const struct file_operations blk_queue_flags_fops = {
-	.open		= blk_queue_flags_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.write		= blk_queue_flags_store,
-};
-
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 {
 	if (stat->nr_samples) {
@@ -157,9 +133,9 @@ static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 	}
 }
 
-static int queue_poll_stat_show(struct seq_file *m, void *v)
+static int queue_poll_stat_show(void *data, struct seq_file *m)
 {
-	struct request_queue *q = m->private;
+	struct request_queue *q = data;
 	int bucket;
 
 	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS/2; bucket++) {
@@ -174,18 +150,6 @@ static int queue_poll_stat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int queue_poll_stat_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, queue_poll_stat_show, inode->i_private);
-}
-
-static const struct file_operations queue_poll_stat_fops = {
-	.open		= queue_poll_stat_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 #define HCTX_STATE_NAME(name) [BLK_MQ_S_##name] = #name
 static const char *const hctx_state_name[] = {
 	HCTX_STATE_NAME(STOPPED),
@@ -196,9 +160,9 @@ static const char *const hctx_state_name[] = {
 };
 #undef HCTX_STATE_NAME
 
-static int hctx_state_show(struct seq_file *m, void *v)
+static int hctx_state_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	blk_flags_show(m, hctx->state, hctx_state_name,
 		       ARRAY_SIZE(hctx_state_name));
@@ -206,18 +170,6 @@ static int hctx_state_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int hctx_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_state_show, inode->i_private);
-}
-
-static const struct file_operations hctx_state_fops = {
-	.open		= hctx_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 #define BLK_TAG_ALLOC_NAME(name) [BLK_TAG_ALLOC_##name] = #name
 static const char *const alloc_policy_name[] = {
 	BLK_TAG_ALLOC_NAME(FIFO),
@@ -235,9 +187,9 @@ static const char *const hctx_flag_name[] = {
 };
 #undef HCTX_FLAG_NAME
 
-static int hctx_flags_show(struct seq_file *m, void *v)
+static int hctx_flags_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
 
 	seq_puts(m, "alloc_policy=");
@@ -254,18 +206,6 @@ static int hctx_flags_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int hctx_flags_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_flags_show, inode->i_private);
-}
-
-static const struct file_operations hctx_flags_fops = {
-	.open		= hctx_flags_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 #define REQ_OP_NAME(name) [REQ_OP_##name] = #name
 static const char *const op_name[] = {
 	REQ_OP_NAME(READ),
@@ -383,38 +323,14 @@ static const struct seq_operations hctx_dispatch_seq_ops = {
 	.show	= blk_mq_debugfs_rq_show,
 };
 
-static int hctx_dispatch_open(struct inode *inode, struct file *file)
-{
-	return blk_mq_debugfs_seq_open(inode, file, &hctx_dispatch_seq_ops);
-}
-
-static const struct file_operations hctx_dispatch_fops = {
-	.open		= hctx_dispatch_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static int hctx_ctx_map_show(struct seq_file *m, void *v)
+static int hctx_ctx_map_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	sbitmap_bitmap_show(&hctx->ctx_map, m);
 	return 0;
 }
 
-static int hctx_ctx_map_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_ctx_map_show, inode->i_private);
-}
-
-static const struct file_operations hctx_ctx_map_fops = {
-	.open		= hctx_ctx_map_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static void blk_mq_debugfs_tags_show(struct seq_file *m,
 				     struct blk_mq_tags *tags)
 {
@@ -432,9 +348,9 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 	}
 }
 
-static int hctx_tags_show(struct seq_file *m, void *v)
+static int hctx_tags_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 	struct request_queue *q = hctx->queue;
 	int res;
 
@@ -449,21 +365,9 @@ static int hctx_tags_show(struct seq_file *m, void *v)
 	return res;
 }
 
-static int hctx_tags_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_tags_show, inode->i_private);
-}
-
-static const struct file_operations hctx_tags_fops = {
-	.open		= hctx_tags_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int hctx_tags_bitmap_show(struct seq_file *m, void *v)
+static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 	struct request_queue *q = hctx->queue;
 	int res;
 
@@ -478,21 +382,9 @@ static int hctx_tags_bitmap_show(struct seq_file *m, void *v)
 	return res;
 }
 
-static int hctx_tags_bitmap_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_tags_bitmap_show, inode->i_private);
-}
-
-static const struct file_operations hctx_tags_bitmap_fops = {
-	.open		= hctx_tags_bitmap_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int hctx_sched_tags_show(struct seq_file *m, void *v)
+static int hctx_sched_tags_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 	struct request_queue *q = hctx->queue;
 	int res;
 
@@ -507,21 +399,9 @@ static int hctx_sched_tags_show(struct seq_file *m, void *v)
 	return res;
 }
 
-static int hctx_sched_tags_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_sched_tags_show, inode->i_private);
-}
-
-static const struct file_operations hctx_sched_tags_fops = {
-	.open		= hctx_sched_tags_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int hctx_sched_tags_bitmap_show(struct seq_file *m, void *v)
+static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 	struct request_queue *q = hctx->queue;
 	int res;
 
@@ -536,21 +416,9 @@ static int hctx_sched_tags_bitmap_show(struct seq_file *m, void *v)
 	return res;
 }
 
-static int hctx_sched_tags_bitmap_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_sched_tags_bitmap_show, inode->i_private);
-}
-
-static const struct file_operations hctx_sched_tags_bitmap_fops = {
-	.open		= hctx_sched_tags_bitmap_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int hctx_io_poll_show(struct seq_file *m, void *v)
+static int hctx_io_poll_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	seq_printf(m, "considered=%lu\n", hctx->poll_considered);
 	seq_printf(m, "invoked=%lu\n", hctx->poll_invoked);
@@ -558,32 +426,18 @@ static int hctx_io_poll_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int hctx_io_poll_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_io_poll_show, inode->i_private);
-}
-
-static ssize_t hctx_io_poll_write(struct file *file, const char __user *buf,
+static ssize_t hctx_io_poll_write(void *data, const char __user *buf,
 				  size_t count, loff_t *ppos)
 {
-	struct seq_file *m = file->private_data;
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	hctx->poll_considered = hctx->poll_invoked = hctx->poll_success = 0;
 	return count;
 }
 
-static const struct file_operations hctx_io_poll_fops = {
-	.open		= hctx_io_poll_open,
-	.read		= seq_read,
-	.write		= hctx_io_poll_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int hctx_dispatched_show(struct seq_file *m, void *v)
+static int hctx_dispatched_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 	int i;
 
 	seq_printf(m, "%8u\t%lu\n", 0U, hctx->dispatched[0]);
@@ -598,16 +452,10 @@ static int hctx_dispatched_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int hctx_dispatched_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_dispatched_show, inode->i_private);
-}
-
-static ssize_t hctx_dispatched_write(struct file *file, const char __user *buf,
+static ssize_t hctx_dispatched_write(void *data, const char __user *buf,
 				     size_t count, loff_t *ppos)
 {
-	struct seq_file *m = file->private_data;
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 	int i;
 
 	for (i = 0; i < BLK_MQ_MAX_DISPATCH_ORDER; i++)
@@ -615,96 +463,48 @@ static ssize_t hctx_dispatched_write(struct file *file, const char __user *buf,
 	return count;
 }
 
-static const struct file_operations hctx_dispatched_fops = {
-	.open		= hctx_dispatched_open,
-	.read		= seq_read,
-	.write		= hctx_dispatched_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int hctx_queued_show(struct seq_file *m, void *v)
+static int hctx_queued_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	seq_printf(m, "%lu\n", hctx->queued);
 	return 0;
 }
 
-static int hctx_queued_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_queued_show, inode->i_private);
-}
-
-static ssize_t hctx_queued_write(struct file *file, const char __user *buf,
+static ssize_t hctx_queued_write(void *data, const char __user *buf,
 				 size_t count, loff_t *ppos)
 {
-	struct seq_file *m = file->private_data;
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	hctx->queued = 0;
 	return count;
 }
 
-static const struct file_operations hctx_queued_fops = {
-	.open		= hctx_queued_open,
-	.read		= seq_read,
-	.write		= hctx_queued_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int hctx_run_show(struct seq_file *m, void *v)
+static int hctx_run_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	seq_printf(m, "%lu\n", hctx->run);
 	return 0;
 }
 
-static int hctx_run_open(struct inode *inode, struct file *file)
+static ssize_t hctx_run_write(void *data, const char __user *buf, size_t count,
+			      loff_t *ppos)
 {
-	return single_open(file, hctx_run_show, inode->i_private);
-}
-
-static ssize_t hctx_run_write(struct file *file, const char __user *buf,
-				 size_t count, loff_t *ppos)
-{
-	struct seq_file *m = file->private_data;
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	hctx->run = 0;
 	return count;
 }
 
-static const struct file_operations hctx_run_fops = {
-	.open		= hctx_run_open,
-	.read		= seq_read,
-	.write		= hctx_run_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int hctx_active_show(struct seq_file *m, void *v)
+static int hctx_active_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_hw_ctx *hctx = data;
 
 	seq_printf(m, "%d\n", atomic_read(&hctx->nr_active));
 	return 0;
 }
 
-static int hctx_active_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, hctx_active_show, inode->i_private);
-}
-
-static const struct file_operations hctx_active_fops = {
-	.open		= hctx_active_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static void *ctx_rq_list_start(struct seq_file *m, loff_t *pos)
 	__acquires(&ctx->lock)
 {
@@ -735,140 +535,146 @@ static const struct seq_operations ctx_rq_list_seq_ops = {
 	.stop	= ctx_rq_list_stop,
 	.show	= blk_mq_debugfs_rq_show,
 };
-
-static int ctx_rq_list_open(struct inode *inode, struct file *file)
-{
-	return blk_mq_debugfs_seq_open(inode, file, &ctx_rq_list_seq_ops);
-}
-
-static const struct file_operations ctx_rq_list_fops = {
-	.open		= ctx_rq_list_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
-static int ctx_dispatched_show(struct seq_file *m, void *v)
+static int ctx_dispatched_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_ctx *ctx = m->private;
+	struct blk_mq_ctx *ctx = data;
 
 	seq_printf(m, "%lu %lu\n", ctx->rq_dispatched[1], ctx->rq_dispatched[0]);
 	return 0;
 }
 
-static int ctx_dispatched_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ctx_dispatched_show, inode->i_private);
-}
-
-static ssize_t ctx_dispatched_write(struct file *file, const char __user *buf,
+static ssize_t ctx_dispatched_write(void *data, const char __user *buf,
 				    size_t count, loff_t *ppos)
 {
-	struct seq_file *m = file->private_data;
-	struct blk_mq_ctx *ctx = m->private;
+	struct blk_mq_ctx *ctx = data;
 
 	ctx->rq_dispatched[0] = ctx->rq_dispatched[1] = 0;
 	return count;
 }
 
-static const struct file_operations ctx_dispatched_fops = {
-	.open		= ctx_dispatched_open,
-	.read		= seq_read,
-	.write		= ctx_dispatched_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int ctx_merged_show(struct seq_file *m, void *v)
+static int ctx_merged_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_ctx *ctx = m->private;
+	struct blk_mq_ctx *ctx = data;
 
 	seq_printf(m, "%lu\n", ctx->rq_merged);
 	return 0;
 }
 
-static int ctx_merged_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ctx_merged_show, inode->i_private);
-}
-
-static ssize_t ctx_merged_write(struct file *file, const char __user *buf,
-				    size_t count, loff_t *ppos)
+static ssize_t ctx_merged_write(void *data, const char __user *buf,
+				size_t count, loff_t *ppos)
 {
-	struct seq_file *m = file->private_data;
-	struct blk_mq_ctx *ctx = m->private;
+	struct blk_mq_ctx *ctx = data;
 
 	ctx->rq_merged = 0;
 	return count;
 }
 
-static const struct file_operations ctx_merged_fops = {
-	.open		= ctx_merged_open,
-	.read		= seq_read,
-	.write		= ctx_merged_write,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int ctx_completed_show(struct seq_file *m, void *v)
+static int ctx_completed_show(void *data, struct seq_file *m)
 {
-	struct blk_mq_ctx *ctx = m->private;
+	struct blk_mq_ctx *ctx = data;
 
 	seq_printf(m, "%lu %lu\n", ctx->rq_completed[1], ctx->rq_completed[0]);
 	return 0;
 }
 
-static int ctx_completed_open(struct inode *inode, struct file *file)
+static ssize_t ctx_completed_write(void *data, const char __user *buf,
+				   size_t count, loff_t *ppos)
 {
-	return single_open(file, ctx_completed_show, inode->i_private);
+	struct blk_mq_ctx *ctx = data;
+
+	ctx->rq_completed[0] = ctx->rq_completed[1] = 0;
+	return count;
 }
 
-static ssize_t ctx_completed_write(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
+static int blk_mq_debugfs_show(struct seq_file *m, void *v)
+{
+	const struct blk_mq_debugfs_attr *attr = m->private;
+	void *data = d_inode(m->file->f_path.dentry->d_parent)->i_private;
+
+	return attr->show(data, m);
+}
+
+static ssize_t blk_mq_debugfs_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos)
 {
 	struct seq_file *m = file->private_data;
-	struct blk_mq_ctx *ctx = m->private;
+	const struct blk_mq_debugfs_attr *attr = m->private;
+	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
 
-	ctx->rq_completed[0] = ctx->rq_completed[1] = 0;
-	return count;
+	if (!attr->write)
+		return -EPERM;
+
+	return attr->write(data, buf, count, ppos);
+}
+
+static int blk_mq_debugfs_open(struct inode *inode, struct file *file)
+{
+	const struct blk_mq_debugfs_attr *attr = inode->i_private;
+	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
+	struct seq_file *m;
+	int ret;
+
+	if (attr->seq_ops) {
+		ret = seq_open(file, attr->seq_ops);
+		if (!ret) {
+			m = file->private_data;
+			m->private = data;
+		}
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(!attr->show))
+		return -EPERM;
+
+	return single_open(file, blk_mq_debugfs_show, inode->i_private);
 }
 
-static const struct file_operations ctx_completed_fops = {
-	.open		= ctx_completed_open,
+static int blk_mq_debugfs_release(struct inode *inode, struct file *file)
+{
+	const struct blk_mq_debugfs_attr *attr = inode->i_private;
+
+	if (attr->show)
+		return single_release(inode, file);
+	else
+		return seq_release(inode, file);
+}
+
+const struct file_operations blk_mq_debugfs_fops = {
+	.open		= blk_mq_debugfs_open,
 	.read		= seq_read,
-	.write		= ctx_completed_write,
+	.write		= blk_mq_debugfs_write,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= blk_mq_debugfs_release,
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
-	{"poll_stat", 0400, &queue_poll_stat_fops},
-	{"state", 0600, &blk_queue_flags_fops},
+	{"poll_stat", 0400, queue_poll_stat_show},
+	{"state", 0600, queue_state_show, queue_state_write},
 	{},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_hctx_attrs[] = {
-	{"state", 0400, &hctx_state_fops},
-	{"flags", 0400, &hctx_flags_fops},
-	{"dispatch", 0400, &hctx_dispatch_fops},
-	{"ctx_map", 0400, &hctx_ctx_map_fops},
-	{"tags", 0400, &hctx_tags_fops},
-	{"tags_bitmap", 0400, &hctx_tags_bitmap_fops},
-	{"sched_tags", 0400, &hctx_sched_tags_fops},
-	{"sched_tags_bitmap", 0400, &hctx_sched_tags_bitmap_fops},
-	{"io_poll", 0600, &hctx_io_poll_fops},
-	{"dispatched", 0600, &hctx_dispatched_fops},
-	{"queued", 0600, &hctx_queued_fops},
-	{"run", 0600, &hctx_run_fops},
-	{"active", 0400, &hctx_active_fops},
+	{"state", 0400, hctx_state_show},
+	{"flags", 0400, hctx_flags_show},
+	{"dispatch", 0400, .seq_ops = &hctx_dispatch_seq_ops},
+	{"ctx_map", 0400, hctx_ctx_map_show},
+	{"tags", 0400, hctx_tags_show},
+	{"tags_bitmap", 0400, hctx_tags_bitmap_show},
+	{"sched_tags", 0400, hctx_sched_tags_show},
+	{"sched_tags_bitmap", 0400, hctx_sched_tags_bitmap_show},
+	{"io_poll", 0600, hctx_io_poll_show, hctx_io_poll_write},
+	{"dispatched", 0600, hctx_dispatched_show, hctx_dispatched_write},
+	{"queued", 0600, hctx_queued_show, hctx_queued_write},
+	{"run", 0600, hctx_run_show, hctx_run_write},
+	{"active", 0400, hctx_active_show},
 	{},
 };
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_ctx_attrs[] = {
-	{"rq_list", 0400, &ctx_rq_list_fops},
-	{"dispatched", 0600, &ctx_dispatched_fops},
-	{"merged", 0600, &ctx_merged_fops},
-	{"completed", 0600, &ctx_completed_fops},
+	{"rq_list", 0400, .seq_ops = &ctx_rq_list_seq_ops},
+	{"dispatched", 0600, ctx_dispatched_show, ctx_dispatched_write},
+	{"merged", 0600, ctx_merged_show, ctx_merged_write},
+	{"completed", 0600, ctx_completed_show, ctx_completed_write},
 	{},
 };
 
@@ -900,11 +706,13 @@ void blk_mq_debugfs_unregister(struct request_queue *q)
 }
 
 static bool debugfs_create_files(struct dentry *parent, void *data,
-				const struct blk_mq_debugfs_attr *attr)
+				 const struct blk_mq_debugfs_attr *attr)
 {
+	d_inode(parent)->i_private = data;
+
 	for (; attr->name; attr++) {
 		if (!debugfs_create_file(attr->name, attr->mode, parent,
-					 data, attr->fops))
+					 (void *)attr, &blk_mq_debugfs_fops))
 			return false;
 	}
 	return true;
-- 
2.12.2
