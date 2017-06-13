Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/11] blk-mq: expose stream write stats through debugfs
Date: Tue, 13 Jun 2017 11:15:15 -0600
Message-Id: <1497374123-15286-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Useful to verify that things are working the way they should.
Reading the file will return number of kb written to each
stream. Writing the file will reset the statistics. No care
is taken to ensure that we don't race on updates.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c       |  2 ++
 block/blk-mq-debugfs.c | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index a7421b772d0e..12e402e4e741 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2057,6 +2057,8 @@ blk_qc_t generic_make_request(struct bio *bio)
 	do {
 		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 
+		q->stream_writes[bio_stream(bio)] += bio->bi_iter.bi_size >> 9;
+
 		if (likely(blk_queue_enter(q, false) == 0)) {
 			struct bio_list lower, same;
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 803aed4d7221..a0a480a0b373 100644
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
+	for (i = 0; i < WRITE_LIFE_NR; i++)
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
+	for (i = 0; i < WRITE_LIFE_NR; i++)
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
index ab92c4ea138b..ab623deb20b2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -586,6 +586,8 @@ struct request_queue {
 
 	size_t			cmd_size;
 	void			*rq_alloc_data;
+
+	u64			stream_writes[WRITE_LIFE_NR];
 };
 
 #define QUEUE_FLAG_QUEUED	1	/* uses generic tag queueing */
-- 
2.7.4
