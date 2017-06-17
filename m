Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/11] blk-mq: expose stream write hints through debugfs
Date: Sat, 17 Jun 2017 13:59:46 -0600
Message-Id: <1497729594-4707-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
References: <1497729594-4707-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Useful to verify that things are working the way they should.
Reading the file will return number of kb written with each
write hint. Writing the file will reset the statistics. No care
is taken to ensure that we don't race on updates.

Drivers will write to q->write_hints[] if they handle a given
write hint.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 803aed4d7221..b069a76f7fc7 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -133,6 +133,29 @@ static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 	}
 }
 
+static int queue_write_hint_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	int i;
+
+	for (i = 0; i < BLK_MAX_WRITE_HINTS; i++)
+		seq_printf(m, "hint%d: %llu\n", i, q->write_hints[i]);
+
+	return 0;
+}
+
+static ssize_t queue_write_hint_store(void *data, const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct request_queue *q = data;
+	int i;
+
+	for (i = 0; i < BLK_MAX_WRITE_HINTS; i++)
+		q->write_hints[i] = 0;
+
+	return count;
+}
+
 static int queue_poll_stat_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
@@ -656,6 +679,7 @@ const struct file_operations blk_mq_debugfs_fops = {
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{"poll_stat", 0400, queue_poll_stat_show},
 	{"state", 0600, queue_state_show, queue_state_write},
+	{"write_hints", 0600, queue_write_hint_show, queue_write_hint_store},
 	{},
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b74a3edcb3da..ab36068f6129 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -588,6 +588,9 @@ struct request_queue {
 	void			*rq_alloc_data;
 
 	struct work_struct	release_work;
+
+#define BLK_MAX_WRITE_HINTS	5
+	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
 #define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
-- 
2.7.4
