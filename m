Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 4/6] blk-mq: Show operation, cmd_flags and rq_flags names
Date: Tue, 11 Apr 2017 13:58:40 -0700
Message-ID: <20170411205842.28137-5-bart.vanassche@sandisk.com>
In-Reply-To: <20170411205842.28137-1-bart.vanassche@sandisk.com>
References: <20170411205842.28137-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Show the operation name, .cmd_flags and .rq_flags as names instead
of numbers.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index aae4b7c7b7b0..161f30fc236f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -258,13 +258,79 @@ static const struct file_operations hctx_flags_fops = {
 	.release	= single_release,
 };
 
+static const char *const op_name[] = {
+	[REQ_OP_READ]		= "READ",
+	[REQ_OP_WRITE]		= "WRITE",
+	[REQ_OP_FLUSH]		= "FLUSH",
+	[REQ_OP_DISCARD]	= "DISCARD",
+	[REQ_OP_ZONE_REPORT]	= "ZONE_REPORT",
+	[REQ_OP_SECURE_ERASE]	= "SECURE_ERASE",
+	[REQ_OP_ZONE_RESET]	= "ZONE_RESET",
+	[REQ_OP_WRITE_SAME]	= "WRITE_SAME",
+	[REQ_OP_WRITE_ZEROES]	= "WRITE_ZEROES",
+	[REQ_OP_SCSI_IN]	= "SCSI_IN",
+	[REQ_OP_SCSI_OUT]	= "SCSI_OUT",
+	[REQ_OP_DRV_IN]		= "DRV_IN",
+	[REQ_OP_DRV_OUT]	= "DRV_OUT",
+};
+
+static const char *const cmd_flag_name[] = {
+	[__REQ_FAILFAST_DEV]		= "FAILFAST_DEV",
+	[__REQ_FAILFAST_TRANSPORT]	= "FAILFAST_TRANSPORT",
+	[__REQ_FAILFAST_DRIVER]		= "FAILFAST_DRIVER",
+	[__REQ_SYNC]			= "SYNC",
+	[__REQ_META]			= "META",
+	[__REQ_PRIO]			= "PRIO",
+	[__REQ_NOMERGE]			= "NOMERGE",
+	[__REQ_IDLE]			= "IDLE",
+	[__REQ_INTEGRITY]		= "INTEGRITY",
+	[__REQ_FUA]			= "FUA",
+	[__REQ_PREFLUSH]		= "PREFLUSH",
+	[__REQ_RAHEAD]			= "RAHEAD",
+	[__REQ_BACKGROUND]		= "BACKGROUND",
+	[__REQ_NR_BITS]			= "NR_BITS",
+};
+
+static const char *const rqf_name[] = {
+	[ilog2(RQF_SORTED)]		= "SORTED",
+	[ilog2(RQF_STARTED)]		= "STARTED",
+	[ilog2(RQF_QUEUED)]		= "QUEUED",
+	[ilog2(RQF_SOFTBARRIER)]	= "SOFTBARRIER",
+	[ilog2(RQF_FLUSH_SEQ)]		= "FLUSH_SEQ",
+	[ilog2(RQF_MIXED_MERGE)]	= "MIXED_MERGE",
+	[ilog2(RQF_MQ_INFLIGHT)]	= "MQ_INFLIGHT",
+	[ilog2(RQF_DONTPREP)]		= "DONTPREP",
+	[ilog2(RQF_PREEMPT)]		= "PREEMPT",
+	[ilog2(RQF_COPY_USER)]		= "COPY_USER",
+	[ilog2(RQF_FAILED)]		= "FAILED",
+	[ilog2(RQF_QUIET)]		= "QUIET",
+	[ilog2(RQF_ELVPRIV)]		= "ELVPRIV",
+	[ilog2(RQF_IO_STAT)]		= "IO_STAT",
+	[ilog2(RQF_ALLOCED)]		= "ALLOCED",
+	[ilog2(RQF_PM)]			= "PM",
+	[ilog2(RQF_HASHED)]		= "HASHED",
+	[ilog2(RQF_STATS)]		= "STATS",
+	[ilog2(RQF_SPECIAL_PAYLOAD)]	= "SPECIAL_PAYLOAD",
+};
+
 static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 {
 	struct request *rq = list_entry_rq(v);
+	const unsigned int op = rq->cmd_flags & REQ_OP_MASK;
 
-	seq_printf(m, "%p {.cmd_flags=0x%x, .rq_flags=0x%x, .tag=%d, .internal_tag=%d}\n",
-		   rq, rq->cmd_flags, (__force unsigned int)rq->rq_flags,
-		   rq->tag, rq->internal_tag);
+	seq_printf(m, "%p {.op=", rq);
+	if (op < ARRAY_SIZE(op_name) && op_name[op])
+		seq_printf(m, "%s", op_name[op]);
+	else
+		seq_printf(m, "%d", op);
+	seq_puts(m, ", .cmd_flags=");
+	blk_flags_show(m, rq->cmd_flags ^ op, cmd_flag_name,
+		       ARRAY_SIZE(cmd_flag_name));
+	seq_puts(m, ", .rq_flags=");
+	blk_flags_show(m, (__force unsigned int)rq->rq_flags, rqf_name,
+		       ARRAY_SIZE(rqf_name));
+	seq_printf(m, ", .tag=%d, .internal_tag=%d}\n", rq->tag,
+		   rq->internal_tag);
 	return 0;
 }
 
-- 
2.12.0
