Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, "Bart Van
 Assche" <bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Ming
 Lei <ming.lei@redhat.com>
Subject: [PATCH v2 2/4] blk-mq-debugfs: Show requeue list
Date: Wed, 31 May 2017 14:30:48 -0700
Message-ID: <20170531213050.30276-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170531213050.30276-1-bart.vanassche@sandisk.com>
References: <20170531213050.30276-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

When verifying whether or not a blk-mq driver forgot to kick the
requeue list after having requeued a request it is important to
be able to verify the contents of the requeue list. Hence export
that list through debugfs.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index d56ddd7a1285..8b06a12c1461 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -308,6 +308,37 @@ int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 }
 EXPORT_SYMBOL_GPL(blk_mq_debugfs_rq_show);
 
+static void *queue_requeue_list_start(struct seq_file *m, loff_t *pos)
+	__acquires(&q->requeue_lock)
+{
+	struct request_queue *q = m->private;
+
+	spin_lock_irq(&q->requeue_lock);
+	return seq_list_start(&q->requeue_list, *pos);
+}
+
+static void *queue_requeue_list_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct request_queue *q = m->private;
+
+	return seq_list_next(v, &q->requeue_list, pos);
+}
+
+static void queue_requeue_list_stop(struct seq_file *m, void *v)
+	__releases(&q->requeue_lock)
+{
+	struct request_queue *q = m->private;
+
+	spin_unlock_irq(&q->requeue_lock);
+}
+
+static const struct seq_operations queue_requeue_list_seq_ops = {
+	.start	= queue_requeue_list_start,
+	.next	= queue_requeue_list_next,
+	.stop	= queue_requeue_list_stop,
+	.show	= blk_mq_debugfs_rq_show,
+};
+
 static void *hctx_dispatch_start(struct seq_file *m, loff_t *pos)
 	__acquires(&hctx->lock)
 {
@@ -665,6 +696,7 @@ const struct file_operations blk_mq_debugfs_fops = {
 
 static const struct blk_mq_debugfs_attr blk_mq_debugfs_queue_attrs[] = {
 	{"poll_stat", 0400, queue_poll_stat_show},
+	{"requeue_list", 0400, .seq_ops = &queue_requeue_list_seq_ops},
 	{"state", 0600, queue_state_show, queue_state_write},
 	{},
 };
-- 
2.12.2
