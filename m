Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 3/4] blk-mq-debug: Make show() operations interruptible
Date: Wed, 1 Feb 2017 10:20:58 -0800
Message-ID: <20170201182059.25601-4-bart.vanassche@sandisk.com>
In-Reply-To: <20170201182059.25601-1-bart.vanassche@sandisk.com>
References: <20170201182059.25601-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Allow users to interrupt show operations instead of making a user
space process unkillable if ownership of q->sysfs_lock cannot be
obtained.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index aece9116b4f6..846943728939 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -179,13 +179,17 @@ static int hctx_tags_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 	struct request_queue *q = hctx->queue;
+	int res;
 
-	mutex_lock(&q->sysfs_lock);
+	res = mutex_lock_interruptible(&q->sysfs_lock);
+	if (res)
+		goto out;
 	if (hctx->tags)
 		blk_mq_debugfs_tags_show(m, hctx->tags);
 	mutex_unlock(&q->sysfs_lock);
 
-	return 0;
+out:
+	return res;
 }
 
 static int hctx_tags_open(struct inode *inode, struct file *file)
@@ -204,12 +208,17 @@ static int hctx_tags_bitmap_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 	struct request_queue *q = hctx->queue;
+	int res;
 
-	mutex_lock(&q->sysfs_lock);
+	res = mutex_lock_interruptible(&q->sysfs_lock);
+	if (res)
+		goto out;
 	if (hctx->tags)
 		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
 	mutex_unlock(&q->sysfs_lock);
-	return 0;
+
+out:
+	return res;
 }
 
 static int hctx_tags_bitmap_open(struct inode *inode, struct file *file)
@@ -228,13 +237,17 @@ static int hctx_sched_tags_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 	struct request_queue *q = hctx->queue;
+	int res;
 
-	mutex_lock(&q->sysfs_lock);
+	res = mutex_lock_interruptible(&q->sysfs_lock);
+	if (res)
+		goto out;
 	if (hctx->sched_tags)
 		blk_mq_debugfs_tags_show(m, hctx->sched_tags);
 	mutex_unlock(&q->sysfs_lock);
 
-	return 0;
+out:
+	return res;
 }
 
 static int hctx_sched_tags_open(struct inode *inode, struct file *file)
@@ -253,12 +266,17 @@ static int hctx_sched_tags_bitmap_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 	struct request_queue *q = hctx->queue;
+	int res;
 
-	mutex_lock(&q->sysfs_lock);
+	res = mutex_lock_interruptible(&q->sysfs_lock);
+	if (res)
+		goto out;
 	if (hctx->sched_tags)
 		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
 	mutex_unlock(&q->sysfs_lock);
-	return 0;
+
+out:
+	return res;
 }
 
 static int hctx_sched_tags_bitmap_open(struct inode *inode, struct file *file)
-- 
2.11.0
