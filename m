Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 1/2] blk-mq: Export queue state through /sys/kernel/debug/block/*/state
Date: Thu, 30 Mar 2017 11:21:26 -0700
Message-ID: <20170330182127.24288-2-bart.vanassche@sandisk.com>
In-Reply-To: <20170330182127.24288-1-bart.vanassche@sandisk.com>
References: <20170330182127.24288-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Make it possible to check whether or not a block layer queue has
been stopped. Make it possible to start and to run a blk-mq queue
from user space.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 107 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4b3f962a9c7a..9e86056d47cd 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -43,6 +43,110 @@ static int blk_mq_debugfs_seq_open(struct inode *inode, struct file *file,
 	return ret;
 }
 
+static int blk_flags_show(struct seq_file *m, const unsigned long flags,
+			  const char *const *flag_name, int flag_name_count)
+{
+	bool sep = false;
+	int i;
+
+	for (i = 0; i < sizeof(flags) * BITS_PER_BYTE; i++) {
+		if (!(flags & BIT(i)))
+			continue;
+		if (sep)
+			seq_puts(m, " ");
+		sep = true;
+		if (i < flag_name_count && flag_name[i])
+			seq_puts(m, flag_name[i]);
+		else
+			seq_printf(m, "%d", i);
+	}
+	seq_puts(m, "\n");
+	return 0;
+}
+
+static const char *const blk_queue_flag_name[] = {
+	[QUEUE_FLAG_QUEUED]	 = "QUEUED",
+	[QUEUE_FLAG_STOPPED]	 = "STOPPED",
+	[QUEUE_FLAG_SYNCFULL]	 = "SYNCFULL",
+	[QUEUE_FLAG_ASYNCFULL]	 = "ASYNCFULL",
+	[QUEUE_FLAG_DYING]	 = "DYING",
+	[QUEUE_FLAG_BYPASS]	 = "BYPASS",
+	[QUEUE_FLAG_BIDI]	 = "BIDI",
+	[QUEUE_FLAG_NOMERGES]	 = "NOMERGES",
+	[QUEUE_FLAG_SAME_COMP]	 = "SAME_COMP",
+	[QUEUE_FLAG_FAIL_IO]	 = "FAIL_IO",
+	[QUEUE_FLAG_STACKABLE]	 = "STACKABLE",
+	[QUEUE_FLAG_NONROT]	 = "NONROT",
+	[QUEUE_FLAG_IO_STAT]	 = "IO_STAT",
+	[QUEUE_FLAG_DISCARD]	 = "DISCARD",
+	[QUEUE_FLAG_NOXMERGES]	 = "NOXMERGES",
+	[QUEUE_FLAG_ADD_RANDOM]	 = "ADD_RANDOM",
+	[QUEUE_FLAG_SECERASE]	 = "SECERASE",
+	[QUEUE_FLAG_SAME_FORCE]	 = "SAME_FORCE",
+	[QUEUE_FLAG_DEAD]	 = "DEAD",
+	[QUEUE_FLAG_INIT_DONE]	 = "INIT_DONE",
+	[QUEUE_FLAG_NO_SG_MERGE] = "NO_SG_MERGE",
+	[QUEUE_FLAG_POLL]	 = "POLL",
+	[QUEUE_FLAG_WC]		 = "WC",
+	[QUEUE_FLAG_FUA]	 = "FUA",
+	[QUEUE_FLAG_FLUSH_NQ]	 = "FLUSH_NQ",
+	[QUEUE_FLAG_DAX]	 = "DAX",
+	[QUEUE_FLAG_STATS]	 = "STATS",
+	[QUEUE_FLAG_RESTART]	 = "RESTART",
+	[QUEUE_FLAG_POLL_STATS]	 = "POLL_STATS",
+	[QUEUE_FLAG_REGISTERED]	 = "REGISTERED",
+};
+
+static int blk_queue_flags_show(struct seq_file *m, void *v)
+{
+	struct request_queue *q = m->private;
+
+	blk_flags_show(m, q->queue_flags, blk_queue_flag_name,
+		       ARRAY_SIZE(blk_queue_flag_name));
+	return 0;
+}
+
+static ssize_t blk_queue_flags_store(struct file *file, const char __user *ubuf,
+				     size_t len, loff_t *offp)
+{
+	struct request_queue *q = file_inode(file)->i_private;
+	char op[16] = { }, *s;
+
+	len = min(len, sizeof(op) - 1);
+	if (copy_from_user(op, ubuf, len))
+		return -EFAULT;
+	s = op;
+	strsep(&s, " \t\n"); /* strip trailing whitespace */
+	if (strcmp(op, "run") == 0) {
+		blk_mq_run_hw_queues(q, true);
+	} else if (strcmp(op, "start") == 0) {
+		blk_mq_start_stopped_hw_queues(q, true);
+	} else {
+		pr_err("%s: unsupported operation %s. Use either 'run' or 'start'\n",
+		       __func__, op);
+		return -EINVAL;
+	}
+	return len;
+}
+
+static int blk_queue_flags_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, blk_queue_flags_show, inode->i_private);
+}
+
+static const struct file_operations blk_queue_flags_fops = {
+	.open		= blk_queue_flags_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= blk_queue_flags_store,
+};
+
+static const struct blk_mq_debugfs_attr blk_queue_attrs[] = {
+	{"state", 0600, &blk_queue_flags_fops},
+	{},
+};
+
 static void print_stat(struct seq_file *m, struct blk_rq_stat *stat)
 {
 	if (stat->nr_samples) {
@@ -735,6 +839,9 @@ int blk_mq_debugfs_register_hctxs(struct request_queue *q)
 	if (!q->debugfs_dir)
 		return -ENOENT;
 
+	if (!debugfs_create_files(q->debugfs_dir, q, blk_queue_attrs))
+		goto err;
+
 	q->mq_debugfs_dir = debugfs_create_dir("mq", q->debugfs_dir);
 	if (!q->mq_debugfs_dir)
 		goto err;
-- 
2.12.0
