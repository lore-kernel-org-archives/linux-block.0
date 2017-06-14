Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	hch@infradead.org,
	martin.petersen@oracle.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/11] blk-mq: expose stream write stats through debugfs
Date: Wed, 14 Jun 2017 13:05:25 -0600
Message-Id: <1497467134-6323-3-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
References: <1497467134-6323-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Useful to verify that things are working the way they should.
Reading the file will return number of kb written to each
stream. Writing the file will reset the statistics. No care
is taken to ensure that we don't race on updates.

Drivers will write to q->stream_writes[] if they handle a stream.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-debugfs.c | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 803aed4d7221..0a37c848961d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -133,6 +133,29 @@ static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 	}
 }
 
+static int queue_streams_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	int i;
+
+	for (i = 0; i < BLK_MAX_STREAM; i++)
+		seq_printf(m, "stream%d: %llu\n", i, q->stream_writes[i]);
+
+	return 0;
+}
+
+static ssize_t queue_streams_store(void *data, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	struct request_queue *q = data;
+	int i;
+
+	for (i = 0; i < BLK_MAX_STREAM; i++)
+		q->stream_writes[i] = 0;
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
+	{"streams", 0600, queue_streams_show, queue_streams_store},
 	{},
 };
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ab92c4ea138b..88719c6f3edf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -586,6 +586,9 @@ struct request_queue {
 
 	size_t			cmd_size;
 	void			*rq_alloc_data;
+
+#define BLK_MAX_STREAM	5
+	u64			stream_writes[BLK_MAX_STREAM];
 };
 
 #define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
-- 
2.7.4
