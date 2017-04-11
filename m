Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 5/6] blk-mq: Add blk_mq_ops.show_rq()
Date: Tue, 11 Apr 2017 13:58:41 -0700
Message-ID: <20170411205842.28137-6-bart.vanassche@sandisk.com>
In-Reply-To: <20170411205842.28137-1-bart.vanassche@sandisk.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

This new callback function will be used in the next patch to show
more information about SCSI requests.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 10 ++++++++--
 include/linux/blk-mq.h |  6 ++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 161f30fc236f..6b28d92d4c0e 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -316,7 +316,9 @@ static const char *const rqf_name[] = {
 static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 {
 	struct request *rq = list_entry_rq(v);
+	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
 	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
+	char drv_info[200];
 
 	seq_printf(m, "%p {.op=", rq);
 	if (op < ARRAY_SIZE(op_name) && op_name[op])
@@ -329,8 +331,12 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 	seq_puts(m, ", .rq_flags=");
 	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
 		       ARRAY_SIZE(rqf_name));
-	seq_printf(m, ", .tag=%d, .internal_tag=%d}\n", rq->tag,
-		   rq->internal_tag);
+	if (mq_ops->show_rq)
+		mq_ops->show_rq(rq, drv_info, sizeof(drv_info));
+	else
+		drv_info[0] = '\0';
+	seq_printf(m, ", .tag=%d, .internal_tag=%d%s%s}\n", rq->tag,
+		   rq->internal_tag, drv_info[0] ? ", " : "", drv_info);
 	return 0;
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index dea255dee359..de2a1c2ddd84 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -120,6 +120,12 @@ struct blk_mq_ops {
 	softirq_done_fn		*complete;
 
 	/*
+	 * Used by the debugfs implementation to show driver-specific
+	 * information about a request.
+	 */
+	void (*show_rq)(struct request *rq, char *info, unsigned int info_sz);
+
+	/*
 	 * Called when the block layer side of a hardware queue has been
 	 * set up, allowing the driver to allocate/init matching structures.
 	 * Ditto for exit/teardown.
-- 
2.12.0
