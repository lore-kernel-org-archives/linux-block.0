Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Omar Sandoval <osandov@fb.com>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 2/2] blk-mq: Show symbolic names for hctx state and flags
Date: Thu, 30 Mar 2017 11:21:27 -0700
Message-ID: <20170330182127.24288-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170330182127.24288-1-bart.vanassche@sandisk.com>
References: <20170330182127.24288-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

Instead of showing the hctx state and flags as numbers, show the
names of the flags.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/blk-mq-debugfs.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 9e86056d47cd..91d09f58a596 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -183,11 +183,19 @@ static const struct file_operations queue_poll_stat_fops = {
 	.release	= single_release,
 };
 
+static const char *const hctx_state_name[] = {
+	[BLK_MQ_S_STOPPED]	 = "STOPPED",
+	[BLK_MQ_S_TAG_ACTIVE]	 = "TAG_ACTIVE",
+	[BLK_MQ_S_SCHED_RESTART] = "SCHED_RESTART",
+	[BLK_MQ_S_TAG_WAITING]	 = "TAG_WAITING",
+
+};
 static int hctx_state_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
 
-	seq_printf(m, "0x%lx\n", hctx->state);
+	blk_flags_show(m, hctx->state, hctx_state_name,
+		       ARRAY_SIZE(hctx_state_name));
 	return 0;
 }
 
@@ -203,11 +211,34 @@ static const struct file_operations hctx_state_fops = {
 	.release	= single_release,
 };
 
+static const char *const alloc_policy_name[] = {
+	[BLK_TAG_ALLOC_FIFO]	= "fifo",
+	[BLK_TAG_ALLOC_RR]	= "rr",
+};
+
+static const char *const hctx_flag_name[] = {
+	[ilog2(BLK_MQ_F_SHOULD_MERGE)]	= "SHOULD_MERGE",
+	[ilog2(BLK_MQ_F_TAG_SHARED)]	= "TAG_SHARED",
+	[ilog2(BLK_MQ_F_SG_MERGE)]	= "SG_MERGE",
+	[ilog2(BLK_MQ_F_BLOCKING)]	= "BLOCKING",
+	[ilog2(BLK_MQ_F_NO_SCHED)]	= "NO_SCHED",
+};
+
 static int hctx_flags_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
-
-	seq_printf(m, "0x%lx\n", hctx->flags);
+	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
+
+	seq_puts(m, "alloc_policy=");
+	if (alloc_policy < ARRAY_SIZE(alloc_policy_name) &&
+	    alloc_policy_name[alloc_policy])
+		seq_puts(m, alloc_policy_name[alloc_policy]);
+	else
+		seq_printf(m, "%d", alloc_policy);
+	seq_puts(m, " ");
+	blk_flags_show(m,
+		       hctx->flags ^ BLK_ALLOC_POLICY_TO_MQ_FLAG(alloc_policy),
+		       hctx_flag_name, ARRAY_SIZE(hctx_flag_name));
 	return 0;
 }
 
-- 
2.12.0
