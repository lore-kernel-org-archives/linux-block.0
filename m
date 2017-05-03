Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35030 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756389AbdECTTM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 15:19:12 -0400
Received: by mail-pf0-f174.google.com with SMTP id v14so17046970pfd.2
        for <linux-block@vger.kernel.org>; Wed, 03 May 2017 12:19:12 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
Subject: [PATCH 2/9] blk-mq-debugfs: clean up flag definitions
Date: Wed,  3 May 2017 12:18:55 -0700
Message-Id: <a7ef9bfaa9756e211fa480d84c7f832a8f8c1d4f.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
In-Reply-To: <cover.1493839103.git.osandov@fb.com>
References: <cover.1493839103.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Make sure the spelled out flag names match the definition. This also
adds a missing hctx state, BLK_MQ_S_START_ON_RUN, and a missing
cmd_flag, __REQ_NOUNMAP.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 block/blk-mq-debugfs.c | 201 ++++++++++++++++++++++++++-----------------------
 1 file changed, 108 insertions(+), 93 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 1ff3d726fb03..f58a116d6cca 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -63,37 +63,39 @@ static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 	return 0;
 }
 
+#define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
 static const char *const blk_queue_flag_name[] = {
-	[QUEUE_FLAG_QUEUED]	 = "QUEUED",
-	[QUEUE_FLAG_STOPPED]	 = "STOPPED",
-	[QUEUE_FLAG_SYNCFULL]	 = "SYNCFULL",
-	[QUEUE_FLAG_ASYNCFULL]	 = "ASYNCFULL",
-	[QUEUE_FLAG_DYING]	 = "DYING",
-	[QUEUE_FLAG_BYPASS]	 = "BYPASS",
-	[QUEUE_FLAG_BIDI]	 = "BIDI",
-	[QUEUE_FLAG_NOMERGES]	 = "NOMERGES",
-	[QUEUE_FLAG_SAME_COMP]	 = "SAME_COMP",
-	[QUEUE_FLAG_FAIL_IO]	 = "FAIL_IO",
-	[QUEUE_FLAG_STACKABLE]	 = "STACKABLE",
-	[QUEUE_FLAG_NONROT]	 = "NONROT",
-	[QUEUE_FLAG_IO_STAT]	 = "IO_STAT",
-	[QUEUE_FLAG_DISCARD]	 = "DISCARD",
-	[QUEUE_FLAG_NOXMERGES]	 = "NOXMERGES",
-	[QUEUE_FLAG_ADD_RANDOM]	 = "ADD_RANDOM",
-	[QUEUE_FLAG_SECERASE]	 = "SECERASE",
-	[QUEUE_FLAG_SAME_FORCE]	 = "SAME_FORCE",
-	[QUEUE_FLAG_DEAD]	 = "DEAD",
-	[QUEUE_FLAG_INIT_DONE]	 = "INIT_DONE",
-	[QUEUE_FLAG_NO_SG_MERGE] = "NO_SG_MERGE",
-	[QUEUE_FLAG_POLL]	 = "POLL",
-	[QUEUE_FLAG_WC]		 = "WC",
-	[QUEUE_FLAG_FUA]	 = "FUA",
-	[QUEUE_FLAG_FLUSH_NQ]	 = "FLUSH_NQ",
-	[QUEUE_FLAG_DAX]	 = "DAX",
-	[QUEUE_FLAG_STATS]	 = "STATS",
-	[QUEUE_FLAG_POLL_STATS]	 = "POLL_STATS",
-	[QUEUE_FLAG_REGISTERED]	 = "REGISTERED",
-};
+	QUEUE_FLAG_NAME(QUEUED),
+	QUEUE_FLAG_NAME(STOPPED),
+	QUEUE_FLAG_NAME(SYNCFULL),
+	QUEUE_FLAG_NAME(ASYNCFULL),
+	QUEUE_FLAG_NAME(DYING),
+	QUEUE_FLAG_NAME(BYPASS),
+	QUEUE_FLAG_NAME(BIDI),
+	QUEUE_FLAG_NAME(NOMERGES),
+	QUEUE_FLAG_NAME(SAME_COMP),
+	QUEUE_FLAG_NAME(FAIL_IO),
+	QUEUE_FLAG_NAME(STACKABLE),
+	QUEUE_FLAG_NAME(NONROT),
+	QUEUE_FLAG_NAME(IO_STAT),
+	QUEUE_FLAG_NAME(DISCARD),
+	QUEUE_FLAG_NAME(NOXMERGES),
+	QUEUE_FLAG_NAME(ADD_RANDOM),
+	QUEUE_FLAG_NAME(SECERASE),
+	QUEUE_FLAG_NAME(SAME_FORCE),
+	QUEUE_FLAG_NAME(DEAD),
+	QUEUE_FLAG_NAME(INIT_DONE),
+	QUEUE_FLAG_NAME(NO_SG_MERGE),
+	QUEUE_FLAG_NAME(POLL),
+	QUEUE_FLAG_NAME(WC),
+	QUEUE_FLAG_NAME(FUA),
+	QUEUE_FLAG_NAME(FLUSH_NQ),
+	QUEUE_FLAG_NAME(DAX),
+	QUEUE_FLAG_NAME(STATS),
+	QUEUE_FLAG_NAME(POLL_STATS),
+	QUEUE_FLAG_NAME(REGISTERED),
+};
+#undef QUEUE_FLAG_NAME
 
 static int blk_queue_flags_show(struct seq_file *m, void *v)
 {
@@ -180,13 +182,16 @@ static const struct file_operations queue_poll_stat_fops = {
 	.release	= single_release,
 };
 
+#define HCTX_STATE_NAME(name) [BLK_MQ_S_##name] = #name
 static const char *const hctx_state_name[] = {
-	[BLK_MQ_S_STOPPED]	 = "STOPPED",
-	[BLK_MQ_S_TAG_ACTIVE]	 = "TAG_ACTIVE",
-	[BLK_MQ_S_SCHED_RESTART] = "SCHED_RESTART",
-	[BLK_MQ_S_TAG_WAITING]	 = "TAG_WAITING",
-
+	HCTX_STATE_NAME(STOPPED),
+	HCTX_STATE_NAME(TAG_ACTIVE),
+	HCTX_STATE_NAME(SCHED_RESTART),
+	HCTX_STATE_NAME(TAG_WAITING),
+	HCTX_STATE_NAME(START_ON_RUN),
 };
+#undef HCTX_STATE_NAME
+
 static int hctx_state_show(struct seq_file *m, void *v)
 {
 	struct blk_mq_hw_ctx *hctx = m->private;
@@ -209,18 +214,22 @@ static const struct file_operations hctx_state_fops = {
 	.release	= single_release,
 };
 
+#define BLK_TAG_ALLOC_NAME(name) [BLK_TAG_ALLOC_##name] = #name
 static const char *const alloc_policy_name[] = {
-	[BLK_TAG_ALLOC_FIFO]	= "fifo",
-	[BLK_TAG_ALLOC_RR]	= "rr",
+	BLK_TAG_ALLOC_NAME(FIFO),
+	BLK_TAG_ALLOC_NAME(RR),
 };
+#undef BLK_TAG_ALLOC_NAME
 
+#define HCTX_FLAG_NAME(name) [ilog2(BLK_MQ_F_##name)] = #name
 static const char *const hctx_flag_name[] = {
-	[ilog2(BLK_MQ_F_SHOULD_MERGE)]	= "SHOULD_MERGE",
-	[ilog2(BLK_MQ_F_TAG_SHARED)]	= "TAG_SHARED",
-	[ilog2(BLK_MQ_F_SG_MERGE)]	= "SG_MERGE",
-	[ilog2(BLK_MQ_F_BLOCKING)]	= "BLOCKING",
-	[ilog2(BLK_MQ_F_NO_SCHED)]	= "NO_SCHED",
+	HCTX_FLAG_NAME(SHOULD_MERGE),
+	HCTX_FLAG_NAME(TAG_SHARED),
+	HCTX_FLAG_NAME(SG_MERGE),
+	HCTX_FLAG_NAME(BLOCKING),
+	HCTX_FLAG_NAME(NO_SCHED),
 };
+#undef HCTX_FLAG_NAME
 
 static int hctx_flags_show(struct seq_file *m, void *v)
 {
@@ -253,60 +262,66 @@ static const struct file_operations hctx_flags_fops = {
 	.release	= single_release,
 };
 
+#define REQ_OP_NAME(name) [REQ_OP_##name] = #name
 static const char *const op_name[] = {
-	[REQ_OP_READ]		= "READ",
-	[REQ_OP_WRITE]		= "WRITE",
-	[REQ_OP_FLUSH]		= "FLUSH",
-	[REQ_OP_DISCARD]	= "DISCARD",
-	[REQ_OP_ZONE_REPORT]	= "ZONE_REPORT",
-	[REQ_OP_SECURE_ERASE]	= "SECURE_ERASE",
-	[REQ_OP_ZONE_RESET]	= "ZONE_RESET",
-	[REQ_OP_WRITE_SAME]	= "WRITE_SAME",
-	[REQ_OP_WRITE_ZEROES]	= "WRITE_ZEROES",
-	[REQ_OP_SCSI_IN]	= "SCSI_IN",
-	[REQ_OP_SCSI_OUT]	= "SCSI_OUT",
-	[REQ_OP_DRV_IN]		= "DRV_IN",
-	[REQ_OP_DRV_OUT]	= "DRV_OUT",
-};
-
+	REQ_OP_NAME(READ),
+	REQ_OP_NAME(WRITE),
+	REQ_OP_NAME(FLUSH),
+	REQ_OP_NAME(DISCARD),
+	REQ_OP_NAME(ZONE_REPORT),
+	REQ_OP_NAME(SECURE_ERASE),
+	REQ_OP_NAME(ZONE_RESET),
+	REQ_OP_NAME(WRITE_SAME),
+	REQ_OP_NAME(WRITE_ZEROES),
+	REQ_OP_NAME(SCSI_IN),
+	REQ_OP_NAME(SCSI_OUT),
+	REQ_OP_NAME(DRV_IN),
+	REQ_OP_NAME(DRV_OUT),
+};
+#undef REQ_OP_NAME
+
+#define CMD_FLAG_NAME(name) [__REQ_##name] = #name
 static const char *const cmd_flag_name[] = {
-	[__REQ_FAILFAST_DEV]		= "FAILFAST_DEV",
-	[__REQ_FAILFAST_TRANSPORT]	= "FAILFAST_TRANSPORT",
-	[__REQ_FAILFAST_DRIVER]		= "FAILFAST_DRIVER",
-	[__REQ_SYNC]			= "SYNC",
-	[__REQ_META]			= "META",
-	[__REQ_PRIO]			= "PRIO",
-	[__REQ_NOMERGE]			= "NOMERGE",
-	[__REQ_IDLE]			= "IDLE",
-	[__REQ_INTEGRITY]		= "INTEGRITY",
-	[__REQ_FUA]			= "FUA",
-	[__REQ_PREFLUSH]		= "PREFLUSH",
-	[__REQ_RAHEAD]			= "RAHEAD",
-	[__REQ_BACKGROUND]		= "BACKGROUND",
-	[__REQ_NR_BITS]			= "NR_BITS",
-};
-
+	CMD_FLAG_NAME(FAILFAST_DEV),
+	CMD_FLAG_NAME(FAILFAST_TRANSPORT),
+	CMD_FLAG_NAME(FAILFAST_DRIVER),
+	CMD_FLAG_NAME(SYNC),
+	CMD_FLAG_NAME(META),
+	CMD_FLAG_NAME(PRIO),
+	CMD_FLAG_NAME(NOMERGE),
+	CMD_FLAG_NAME(IDLE),
+	CMD_FLAG_NAME(INTEGRITY),
+	CMD_FLAG_NAME(FUA),
+	CMD_FLAG_NAME(PREFLUSH),
+	CMD_FLAG_NAME(RAHEAD),
+	CMD_FLAG_NAME(BACKGROUND),
+	CMD_FLAG_NAME(NOUNMAP),
+};
+#undef CMD_FLAG_NAME
+
+#define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
 static const char *const rqf_name[] = {
-	[ilog2((__force u32)RQF_SORTED)]		= "SORTED",
-	[ilog2((__force u32)RQF_STARTED)]		= "STARTED",
-	[ilog2((__force u32)RQF_QUEUED)]		= "QUEUED",
-	[ilog2((__force u32)RQF_SOFTBARRIER)]		= "SOFTBARRIER",
-	[ilog2((__force u32)RQF_FLUSH_SEQ)]		= "FLUSH_SEQ",
-	[ilog2((__force u32)RQF_MIXED_MERGE)]		= "MIXED_MERGE",
-	[ilog2((__force u32)RQF_MQ_INFLIGHT)]		= "MQ_INFLIGHT",
-	[ilog2((__force u32)RQF_DONTPREP)]		= "DONTPREP",
-	[ilog2((__force u32)RQF_PREEMPT)]		= "PREEMPT",
-	[ilog2((__force u32)RQF_COPY_USER)]		= "COPY_USER",
-	[ilog2((__force u32)RQF_FAILED)]		= "FAILED",
-	[ilog2((__force u32)RQF_QUIET)]			= "QUIET",
-	[ilog2((__force u32)RQF_ELVPRIV)]		= "ELVPRIV",
-	[ilog2((__force u32)RQF_IO_STAT)]		= "IO_STAT",
-	[ilog2((__force u32)RQF_ALLOCED)]		= "ALLOCED",
-	[ilog2((__force u32)RQF_PM)]			= "PM",
-	[ilog2((__force u32)RQF_HASHED)]		= "HASHED",
-	[ilog2((__force u32)RQF_STATS)]			= "STATS",
-	[ilog2((__force u32)RQF_SPECIAL_PAYLOAD)]	= "SPECIAL_PAYLOAD",
-};
+	RQF_NAME(SORTED),
+	RQF_NAME(STARTED),
+	RQF_NAME(QUEUED),
+	RQF_NAME(SOFTBARRIER),
+	RQF_NAME(FLUSH_SEQ),
+	RQF_NAME(MIXED_MERGE),
+	RQF_NAME(MQ_INFLIGHT),
+	RQF_NAME(DONTPREP),
+	RQF_NAME(PREEMPT),
+	RQF_NAME(COPY_USER),
+	RQF_NAME(FAILED),
+	RQF_NAME(QUIET),
+	RQF_NAME(ELVPRIV),
+	RQF_NAME(IO_STAT),
+	RQF_NAME(ALLOCED),
+	RQF_NAME(PM),
+	RQF_NAME(HASHED),
+	RQF_NAME(STATS),
+	RQF_NAME(SPECIAL_PAYLOAD),
+};
+#undef RQF_NAME
 
 static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
 {
-- 
2.12.2
