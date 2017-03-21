Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@osandov.com>,
	linux-block@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] blk-mq: add statistics for tag allocation failures
Date: Tue, 21 Mar 2017 17:24:21 +0100
Message-Id: <1490113461-63123-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq-debugfs.c | 15 +++++++++++++++
 block/blk-mq-tag.c     |  6 ++++--
 block/blk-mq-tag.h     |  3 +++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index f6d9179..51622f6 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -161,6 +161,8 @@ static void blk_mq_debugfs_tags_show(struct seq_file *m,
 {
 	seq_printf(m, "nr_tags=%u\n", tags->nr_tags);
 	seq_printf(m, "nr_reserved_tags=%u\n", tags->nr_reserved_tags);
+	seq_printf(m, "starved_count=%u\n", tags->starved_count);
+	seq_printf(m, "failed_count=%u\n", tags->failed_count);
 	seq_printf(m, "active_queues=%d\n",
 		   atomic_read(&tags->active_queues));
 
@@ -190,6 +192,18 @@ static int hctx_tags_show(struct seq_file *m, void *v)
 	return res;
 }
 
+static ssize_t hctx_tags_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct blk_mq_hw_ctx *hctx = m->private;
+	struct blk_mq_tags *tags = hctx->tags;
+
+	tags->starved_count = 0;
+	tags->failed_count = 0;
+	return count;
+}
+
 static int hctx_tags_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, hctx_tags_show, inode->i_private);
@@ -198,6 +212,7 @@ static int hctx_tags_open(struct inode *inode, struct file *file)
 static const struct file_operations hctx_tags_fops = {
 	.open		= hctx_tags_open,
 	.read		= seq_read,
+	.write		= hctx_tags_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 54c8436..692ca28 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -125,9 +125,10 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (tag != -1)
 		goto found_tag;
 
-	if (data->flags & BLK_MQ_REQ_NOWAIT)
+	if (data->flags & BLK_MQ_REQ_NOWAIT) {
+		tags->failed_count++;
 		return BLK_MQ_TAG_FAIL;
-
+	}
 	ws = bt_wait_ptr(bt, data->hctx);
 	drop_ctx = data->ctx == NULL;
 	do {
@@ -152,6 +153,7 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		if (tag != -1)
 			break;
 
+		tags->starved_count++;
 		if (data->ctx)
 			blk_mq_put_ctx(data->ctx);
 
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 6349742..f4f618f 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -10,6 +10,9 @@ struct blk_mq_tags {
 	unsigned int nr_tags;
 	unsigned int nr_reserved_tags;
 
+	unsigned int starved_count;
+	unsigned int failed_count;
+
 	atomic_t active_queues;
 
 	struct sbitmap_queue bitmap_tags;
-- 
1.8.5.6
