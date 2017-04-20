Return-Path: <sbates130272@gmail.com>
Return-Path: <sbates130272@gmail.com>
From: sbates@raithlin.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Damien.LeMoal@wdc.com,
	osandov@osandov.com,
	sbates@raithlin.com,
	sagi@grimberg.me
Subject: [PATCH] blk-mq: Fix poll_stat for new size-based bucketing.
Date: Thu, 20 Apr 2017 16:59:11 -0600
Message-Id: <1492729151-20983-1-git-send-email-sbates@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

From: Stephen Bates <sbates@raithlin.com>

Fixes an issue where the size of the poll_stat array in request_queue
does not match the size expected by the new size based bucketing for
IO completion polling.

Should be applied on top of commit 720b8ccc4500 ("blk-mq: Add a
polling specific stats function").

Signed-off-by: Stephen Bates <sbates@raithlin.com>
---
 block/blk-mq-debugfs.c | 15 +++++++++------
 block/blk-mq.c         |  8 ++++----
 include/linux/blkdev.h |  5 ++++-
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index df9b688..3057641 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -159,14 +159,17 @@ static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 static int queue_poll_stat_show(struct seq_file *m, void *v)
 {
 	struct request_queue *q = m->private;
+	int bucket;
 
-	seq_puts(m, "read: ");
-	print_stat(m, &q->poll_stat[READ]);
-	seq_puts(m, "\n");
+	for (bucket = 0; bucket < BLK_MQ_POLL_STATS_BKTS/2; bucket++) {
+		seq_printf(m, "read  (%d Bytes): ", 1 << (9+bucket));
+		print_stat(m, &q->poll_stat[2*bucket]);
+		seq_puts(m, "\n");
 
-	seq_puts(m, "write: ");
-	print_stat(m, &q->poll_stat[WRITE]);
-	seq_puts(m, "\n");
+		seq_printf(m, "write (%d Bytes): ",  1 << (9+bucket));
+		print_stat(m, &q->poll_stat[2*bucket+1]);
+		seq_puts(m, "\n");
+	}
 	return 0;
 }
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9d7645f..81f7c99 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -42,8 +42,6 @@ static LIST_HEAD(all_q_list);
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
 
-/* Must be consisitent with function below */
-#define BLK_MQ_POLL_STATS_BKTS 16
 static int blk_mq_poll_stats_bkt(const struct request *rq)
 {
 	int ddir, bytes, bucket;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6c4ab0d..6c24786 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -46,6 +46,9 @@ struct blk_stat_callback;
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_MAX_RQ	128	/* Default maximum */
 
+/* Must be consisitent with blk_mq_poll_stats_bkt() */
+#define BLK_MQ_POLL_STATS_BKTS 16
+
 /*
  * Maximum number of blkcg policies allowed to be registered concurrently.
  * Defined here to simplify include dependency.
@@ -517,7 +520,7 @@ struct request_queue {
 	int			poll_nsec;
 
 	struct blk_stat_callback	*poll_cb;
-	struct blk_rq_stat	poll_stat[2];
+	struct blk_rq_stat	poll_stat[BLK_MQ_POLL_STATS_BKTS];
 
 	struct timer_list	timeout;
 	struct work_struct	timeout_work;
-- 
2.7.4
