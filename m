Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Omar Sandoval <osandov@fb.com>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 06/12] blk-mq-debugfs: Generate name-to-text translation tables
Date: Thu, 17 Aug 2017 16:23:05 -0700
Message-Id: <20170817232311.25948-7-bart.vanassche@wdc.com>
In-Reply-To: <20170817232311.25948-1-bart.vanassche@wdc.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

It is easy to add a flag to one of the block layer headers and to
forget to update blk-mq-debugfs.c. E.g. QUEUE_FLAG_SCSI_PASSTHROUGH,
QUEUE_FLAG_QUIESCED and REQ_NOWAIT are missing from blk-mq-debugfs.c.
Hence generate the symbol-to-text translation tables.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
---
 block/.gitignore       |   1 +
 block/Makefile         |  58 ++++++++++++++++++++++
 block/blk-mq-debugfs.c | 130 +------------------------------------------------
 3 files changed, 61 insertions(+), 128 deletions(-)
 create mode 100644 block/.gitignore

diff --git a/block/.gitignore b/block/.gitignore
new file mode 100644
index 000000000000..63b09639ab06
--- /dev/null
+++ b/block/.gitignore
@@ -0,0 +1 @@
+blk-name-tables.c
diff --git a/block/Makefile b/block/Makefile
index 2b281cf258a0..f9bd77426ac1 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -33,3 +33,61 @@ obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
+
+clean-files := blk-name-tables.c
+
+$(obj)/blk-mq-debugfs.o: $(obj)/blk-name-tables.c
+
+$(obj)/blk-name-tables.c: block/Makefile block/blk.h include/linux/blk-mq.h \
+		include/linux/blk_types.h include/linux/blkdev.h
+	@(								\
+	printf "static const char *const blk_queue_flag_name[] = {\n";	\
+	s='^#define QUEUE_FLAG_\([^[:blank:]]*\)[[:blank:]]\+[0-9]\+.*';\
+	r='\t\[QUEUE_FLAG_\1\] = "\1",';				\
+	sed -n "s/$$s/$$r/p" include/linux/blkdev.h;			\
+	printf "};\n";							\
+	printf "\n";							\
+	printf "static const char *const hctx_state_name[] = {\n";	\
+	s='^[[:blank:]]BLK_MQ_S_\([^[:blank:]]*\)[[:blank:]]\+=[[:blank:]]*[0-9]\+.*'; \
+	r='\t\[BLK_MQ_S_\1\] = "\1",';					\
+	sed -n "s/$$s/$$r/p" include/linux/blk-mq.h;			\
+	printf "};\n";							\
+	printf "\n";							\
+	printf "static const char *const alloc_policy_name[] = {\n";	\
+	s='^#define BLK_TAG_ALLOC_\([^[:blank:]]*\)[[:blank:]]\+[0-9]\+.*';\
+	r='\t\[BLK_TAG_ALLOC_\1\] = "\1",';				\
+	sed -n "s/$$s/$$r/p" include/linux/blkdev.h;			\
+	printf "};\n";							\
+	printf "\n";							\
+	printf "static const char *const hctx_flag_name[] = {\n";	\
+	s='^[[:blank:]]BLK_MQ_F_\([^[:blank:]]*\)[[:blank:]]\+=[[:blank:]]*[0-9]\+.*'; \
+	r='\t\[ilog2(BLK_MQ_F_\1)\] = "\1",';				\
+	sed -n "s/$$s/$$r/p" include/linux/blk-mq.h |			\
+	grep -v BLK_MQ_F_ALLOC_POLICY_;					\
+	printf "};\n";							\
+	printf "\n";							\
+	printf "static const char *const op_name[] = {\n";		\
+	s='^[[:blank:]]REQ_OP_\([^[:blank:]]*\)[[:blank:]]\+=[[:blank:]]*[0-9]\+.*';   \
+	r='\t\[REQ_OP_\1\] = "\1",';					\
+	sed -n "s/$$s/$$r/p" include/linux/blk_types.h;			\
+	printf "};\n";							\
+	printf "\n";							\
+	printf "static const char *const cmd_flag_name[] = {\n";	\
+	s='^#define REQ_\([^[:blank:]]*\)[[:blank:]]*(1.*';		\
+	r='\t\[REQ_\1\] = "\1",';					\
+	sed -n "s/$$s/$$r/p" include/linux/blk_types.h;			\
+	printf "};\n";							\
+	printf "\n";							\
+	printf "static const char *const rqf_name[] = {\n";		\
+	s='^#define RQF_\([^[:blank:]]*\)[[:blank:]]\+(.*';		\
+	r='\t\[RQF_\1\] = "\1",';					\
+	sed -n "s/$$s/$$r/p" include/linux/blkdev.h;			\
+	printf "};\n";							\
+	printf "\n";							\
+	printf "static const char *const rqaf_name[] = {\n";		\
+	s='^[[:blank:]]REQ_ATOM_\([^[:blank:],]*\).*';			\
+	r='\t\[REQ_ATOM_\1\] = "\1",';					\
+	sed -n "s/$$s/$$r/p" block/blk.h;				\
+	printf "};\n";							\
+	printf "\n";							\
+	) >$@
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index e53b6129ca5a..a3239db953b7 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -24,6 +24,8 @@
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
 
+#include "blk-name-tables.c"
+
 static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 			  const char *const *flag_name, int flag_name_count)
 {
@@ -44,38 +46,6 @@ static int blk_flags_show(struct seq_file *m, const unsigned long flags,
 	return 0;
 }
 
-#define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
-static const char *const blk_queue_flag_name[] = {
-	QUEUE_FLAG_NAME(QUEUED),
-	QUEUE_FLAG_NAME(STOPPED),
-	QUEUE_FLAG_NAME(DYING),
-	QUEUE_FLAG_NAME(BYPASS),
-	QUEUE_FLAG_NAME(BIDI),
-	QUEUE_FLAG_NAME(NOMERGES),
-	QUEUE_FLAG_NAME(SAME_COMP),
-	QUEUE_FLAG_NAME(FAIL_IO),
-	QUEUE_FLAG_NAME(STACKABLE),
-	QUEUE_FLAG_NAME(NONROT),
-	QUEUE_FLAG_NAME(IO_STAT),
-	QUEUE_FLAG_NAME(DISCARD),
-	QUEUE_FLAG_NAME(NOXMERGES),
-	QUEUE_FLAG_NAME(ADD_RANDOM),
-	QUEUE_FLAG_NAME(SECERASE),
-	QUEUE_FLAG_NAME(SAME_FORCE),
-	QUEUE_FLAG_NAME(DEAD),
-	QUEUE_FLAG_NAME(INIT_DONE),
-	QUEUE_FLAG_NAME(NO_SG_MERGE),
-	QUEUE_FLAG_NAME(POLL),
-	QUEUE_FLAG_NAME(WC),
-	QUEUE_FLAG_NAME(FUA),
-	QUEUE_FLAG_NAME(FLUSH_NQ),
-	QUEUE_FLAG_NAME(DAX),
-	QUEUE_FLAG_NAME(STATS),
-	QUEUE_FLAG_NAME(POLL_STATS),
-	QUEUE_FLAG_NAME(REGISTERED),
-};
-#undef QUEUE_FLAG_NAME
-
 static int queue_state_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
@@ -173,16 +143,6 @@ static int queue_poll_stat_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-#define HCTX_STATE_NAME(name) [BLK_MQ_S_##name] = #name
-static const char *const hctx_state_name[] = {
-	HCTX_STATE_NAME(STOPPED),
-	HCTX_STATE_NAME(TAG_ACTIVE),
-	HCTX_STATE_NAME(SCHED_RESTART),
-	HCTX_STATE_NAME(TAG_WAITING),
-	HCTX_STATE_NAME(START_ON_RUN),
-};
-#undef HCTX_STATE_NAME
-
 static int hctx_state_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
@@ -193,23 +153,6 @@ static int hctx_state_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-#define BLK_TAG_ALLOC_NAME(name) [BLK_TAG_ALLOC_##name] = #name
-static const char *const alloc_policy_name[] = {
-	BLK_TAG_ALLOC_NAME(FIFO),
-	BLK_TAG_ALLOC_NAME(RR),
-};
-#undef BLK_TAG_ALLOC_NAME
-
-#define HCTX_FLAG_NAME(name) [ilog2(BLK_MQ_F_##name)] = #name
-static const char *const hctx_flag_name[] = {
-	HCTX_FLAG_NAME(SHOULD_MERGE),
-	HCTX_FLAG_NAME(TAG_SHARED),
-	HCTX_FLAG_NAME(SG_MERGE),
-	HCTX_FLAG_NAME(BLOCKING),
-	HCTX_FLAG_NAME(NO_SCHED),
-};
-#undef HCTX_FLAG_NAME
-
 static int hctx_flags_show(void *data, struct seq_file *m)
 {
 	struct blk_mq_hw_ctx *hctx = data;
@@ -229,75 +172,6 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-#define REQ_OP_NAME(name) [REQ_OP_##name] = #name
-static const char *const op_name[] = {
-	REQ_OP_NAME(READ),
-	REQ_OP_NAME(WRITE),
-	REQ_OP_NAME(FLUSH),
-	REQ_OP_NAME(DISCARD),
-	REQ_OP_NAME(ZONE_REPORT),
-	REQ_OP_NAME(SECURE_ERASE),
-	REQ_OP_NAME(ZONE_RESET),
-	REQ_OP_NAME(WRITE_SAME),
-	REQ_OP_NAME(WRITE_ZEROES),
-	REQ_OP_NAME(SCSI_IN),
-	REQ_OP_NAME(SCSI_OUT),
-	REQ_OP_NAME(DRV_IN),
-	REQ_OP_NAME(DRV_OUT),
-};
-#undef REQ_OP_NAME
-
-#define CMD_FLAG_NAME(name) [__REQ_##name] = #name
-static const char *const cmd_flag_name[] = {
-	CMD_FLAG_NAME(FAILFAST_DEV),
-	CMD_FLAG_NAME(FAILFAST_TRANSPORT),
-	CMD_FLAG_NAME(FAILFAST_DRIVER),
-	CMD_FLAG_NAME(SYNC),
-	CMD_FLAG_NAME(META),
-	CMD_FLAG_NAME(PRIO),
-	CMD_FLAG_NAME(NOMERGE),
-	CMD_FLAG_NAME(IDLE),
-	CMD_FLAG_NAME(INTEGRITY),
-	CMD_FLAG_NAME(FUA),
-	CMD_FLAG_NAME(PREFLUSH),
-	CMD_FLAG_NAME(RAHEAD),
-	CMD_FLAG_NAME(BACKGROUND),
-	CMD_FLAG_NAME(NOUNMAP),
-};
-#undef CMD_FLAG_NAME
-
-#define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
-static const char *const rqf_name[] = {
-	RQF_NAME(SORTED),
-	RQF_NAME(STARTED),
-	RQF_NAME(QUEUED),
-	RQF_NAME(SOFTBARRIER),
-	RQF_NAME(FLUSH_SEQ),
-	RQF_NAME(MIXED_MERGE),
-	RQF_NAME(MQ_INFLIGHT),
-	RQF_NAME(DONTPREP),
-	RQF_NAME(PREEMPT),
-	RQF_NAME(COPY_USER),
-	RQF_NAME(FAILED),
-	RQF_NAME(QUIET),
-	RQF_NAME(ELVPRIV),
-	RQF_NAME(IO_STAT),
-	RQF_NAME(ALLOCED),
-	RQF_NAME(PM),
-	RQF_NAME(HASHED),
-	RQF_NAME(STATS),
-	RQF_NAME(SPECIAL_PAYLOAD),
-};
-#undef RQF_NAME
-
-#define RQAF_NAME(name) [REQ_ATOM_##name] = #name
-static const char *const rqaf_name[] = {
-	RQAF_NAME(COMPLETE),
-	RQAF_NAME(STARTED),
-	RQAF_NAME(POLL_SLEPT),
-};
-#undef RQAF_NAME
-
 int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 {
 	const struct blk_mq_ops *const mq_ops = rq->q->mq_ops;
-- 
2.14.0
