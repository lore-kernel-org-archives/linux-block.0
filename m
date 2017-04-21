Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v4 09/10] blk-mq: Add blk_mq_ops.show_rq()
Date: Fri, 21 Apr 2017 16:40:25 -0700
Message-ID: <20170421234026.18970-10-bart.vanassche@sandisk.com>
In-Reply-To: <20170421234026.18970-1-bart.vanassche@sandisk.com>
References: <20170421234026.18970-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

This new callback function will be used in the next patch to show
more information about SCSI requests.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 6 +++++-
 include/linux/blk-mq.h | 6 ++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 3a99146ece39..c5eca9245459 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -311,6 +311,7 @@ static const char *const rqf_name[] = {
 static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 {
 	struct request *rq = list_entry_rq(v);
+	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
 	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
 
 	seq_printf(m, "%p {.op=", rq);
@@ -324,8 +325,11 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 	seq_puts(m, ", .rq_flags=");
 	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
 		       ARRAY_SIZE(rqf_name));
-	seq_printf(m, ", .tag=%d, .internal_tag=%d}\n", rq->tag,
+	seq_printf(m, ", .tag=%d, .internal_tag=%d", rq->tag,
 		   rq->internal_tag);
+	if (mq_ops->show_rq)
+		mq_ops->show_rq(m, rq);
+	seq_puts(m, "}\n");
 	return 0;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0c4dadb85f62..b7bf11c05568 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -121,6 +121,12 @@ struct blk_mq_ops {
 	softirq_done_fn		*complete;
 
 	/*
+	 * Used by the debugfs implementation to show driver-specific
+	 * information about a request.
+	 */
+	void (*show_rq)(struct seq_file *m, struct request *rq);
+
+	/*
 	 * Called when the block layer side of a hardware queue has been
 	 * set up, allowing the driver to allocate/init matching structures.
 	 * Ditto for exit/teardown.
-- 
2.12.2
