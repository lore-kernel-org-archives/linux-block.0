Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/16] block: replace REQ_NOIDLE with REQ_IDLE
Date: Tue,  1 Nov 2016 07:40:09 -0600
Message-Id: <1478007617-18715-9-git-send-email-hch@lst.de>
In-Reply-To: <1478007617-18715-1-git-send-email-hch@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Noidle should be the default for writes as seen by all the compounds
defintions in fs.h using it.  In fact only direct I/O really should
be using NODILE, so turn the whole flag around to get the defaults
right, which will make our life much easier especially onces the
WRITE_* defines go away.

This assumes all the existing "raw" users of REQ_SYNC for writes
want noidle behavior, which seems to be spot on from a quick audit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/block/cfq-iosched.txt | 32 ++++++++++++++++----------------
 block/cfq-iosched.c                 | 11 ++++++++---
 drivers/block/drbd/drbd_actlog.c    |  2 +-
 include/linux/blk_types.h           |  4 ++--
 include/linux/fs.h                  | 10 +++++-----
 include/trace/events/f2fs.h         |  2 +-
 6 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/Documentation/block/cfq-iosched.txt b/Documentation/block/cfq-iosched.txt
index 1e4f835..895bd38 100644
--- a/Documentation/block/cfq-iosched.txt
+++ b/Documentation/block/cfq-iosched.txt
@@ -240,11 +240,11 @@ All cfq queues doing synchronous sequential IO go on to sync-idle tree.
 On this tree we idle on each queue individually.
 
 All synchronous non-sequential queues go on sync-noidle tree. Also any
-request which are marked with REQ_NOIDLE go on this service tree. On this
-tree we do not idle on individual queues instead idle on the whole group
-of queues or the tree. So if there are 4 queues waiting for IO to dispatch
-we will idle only once last queue has dispatched the IO and there is
-no more IO on this service tree.
+synchronous write request which is not marked with REQ_IDLE goes on this
+service tree. On this tree we do not idle on individual queues instead idle
+on the whole group of queues or the tree. So if there are 4 queues waiting
+for IO to dispatch we will idle only once last queue has dispatched the IO
+and there is no more IO on this service tree.
 
 All async writes go on async service tree. There is no idling on async
 queues.
@@ -257,17 +257,17 @@ tree idling provides isolation with buffered write queues on async tree.
 
 FAQ
 ===
-Q1. Why to idle at all on queues marked with REQ_NOIDLE.
+Q1. Why to idle at all on queues not marked with REQ_IDLE.
 
-A1. We only do tree idle (all queues on sync-noidle tree) on queues marked
-    with REQ_NOIDLE. This helps in providing isolation with all the sync-idle
+A1. We only do tree idle (all queues on sync-noidle tree) on queues not marked
+    with REQ_IDLE. This helps in providing isolation with all the sync-idle
     queues. Otherwise in presence of many sequential readers, other
     synchronous IO might not get fair share of disk.
 
     For example, if there are 10 sequential readers doing IO and they get
-    100ms each. If a REQ_NOIDLE request comes in, it will be scheduled
-    roughly after 1 second. If after completion of REQ_NOIDLE request we
-    do not idle, and after a couple of milli seconds a another REQ_NOIDLE
+    100ms each. If a !REQ_IDLE request comes in, it will be scheduled
+    roughly after 1 second. If after completion of !REQ_IDLE request we
+    do not idle, and after a couple of milli seconds a another !REQ_IDLE
     request comes in, again it will be scheduled after 1second. Repeat it
     and notice how a workload can lose its disk share and suffer due to
     multiple sequential readers.
@@ -276,16 +276,16 @@ A1. We only do tree idle (all queues on sync-noidle tree) on queues marked
     context of fsync, and later some journaling data is written. Journaling
     data comes in only after fsync has finished its IO (atleast for ext4
     that seemed to be the case). Now if one decides not to idle on fsync
-    thread due to REQ_NOIDLE, then next journaling write will not get
+    thread due to !REQ_IDLE, then next journaling write will not get
     scheduled for another second. A process doing small fsync, will suffer
     badly in presence of multiple sequential readers.
 
-    Hence doing tree idling on threads using REQ_NOIDLE flag on requests
+    Hence doing tree idling on threads using !REQ_IDLE flag on requests
     provides isolation from multiple sequential readers and at the same
     time we do not idle on individual threads.
 
-Q2. When to specify REQ_NOIDLE
-A2. I would think whenever one is doing synchronous write and not expecting
+Q2. When to specify REQ_IDLE
+A2. I would think whenever one is doing synchronous write and expecting
     more writes to be dispatched from same context soon, should be able
-    to specify REQ_NOIDLE on writes and that probably should work well for
+    to specify REQ_IDLE on writes and that probably should work well for
     most of the cases.
diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index f28db97..dcbed8c 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -3914,6 +3914,12 @@ cfq_update_io_seektime(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 		cfqq->seek_history |= (sdist > CFQQ_SEEK_THR);
 }
 
+static inline bool req_noidle(struct request *req)
+{
+	return req_op(req) == REQ_OP_WRITE &&
+		(req->cmd_flags & (REQ_SYNC | REQ_IDLE)) == REQ_SYNC;
+}
+
 /*
  * Disable idle window if the process thinks too long or seeks so much that
  * it doesn't matter
@@ -3935,7 +3941,7 @@ cfq_update_idle_window(struct cfq_data *cfqd, struct cfq_queue *cfqq,
 	if (cfqq->queued[0] + cfqq->queued[1] >= 4)
 		cfq_mark_cfqq_deep(cfqq);
 
-	if (cfqq->next_rq && (cfqq->next_rq->cmd_flags & REQ_NOIDLE))
+	if (cfqq->next_rq && req_noidle(cfqq->next_rq))
 		enable_idle = 0;
 	else if (!atomic_read(&cic->icq.ioc->active_ref) ||
 		 !cfqd->cfq_slice_idle ||
@@ -4220,8 +4226,7 @@ static void cfq_completed_request(struct request_queue *q, struct request *rq)
 	const int sync = rq_is_sync(rq);
 	u64 now = ktime_get_ns();
 
-	cfq_log_cfqq(cfqd, cfqq, "complete rqnoidle %d",
-		     !!(rq->cmd_flags & REQ_NOIDLE));
+	cfq_log_cfqq(cfqd, cfqq, "complete rqnoidle %d", req_noidle(rq));
 
 	cfq_update_hw_tag(cfqd);
 
diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 2d3d50a..8d7bcfa 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -148,7 +148,7 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 
 	if ((op == REQ_OP_WRITE) && !test_bit(MD_NO_FUA, &device->flags))
 		op_flags |= REQ_FUA | REQ_PREFLUSH;
-	op_flags |= REQ_SYNC | REQ_NOIDLE;
+	op_flags |= REQ_SYNC;
 
 	bio = bio_alloc_drbd(GFP_NOIO);
 	bio->bi_bdev = bdev->md_bdev;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 107d23d..63b750a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -175,7 +175,7 @@ enum req_flag_bits {
 	__REQ_META,		/* metadata io request */
 	__REQ_PRIO,		/* boost priority in cfq */
 	__REQ_NOMERGE,		/* don't touch this for merging */
-	__REQ_NOIDLE,		/* don't anticipate more IO after this one */
+	__REQ_IDLE,		/* anticipate more IO after this one */
 	__REQ_INTEGRITY,	/* I/O includes block integrity payload */
 	__REQ_FUA,		/* forced unit access */
 	__REQ_PREFLUSH,		/* request for cache flush */
@@ -190,7 +190,7 @@ enum req_flag_bits {
 #define REQ_META		(1ULL << __REQ_META)
 #define REQ_PRIO		(1ULL << __REQ_PRIO)
 #define REQ_NOMERGE		(1ULL << __REQ_NOMERGE)
-#define REQ_NOIDLE		(1ULL << __REQ_NOIDLE)
+#define REQ_IDLE		(1ULL << __REQ_IDLE)
 #define REQ_INTEGRITY		(1ULL << __REQ_INTEGRITY)
 #define REQ_FUA			(1ULL << __REQ_FUA)
 #define REQ_PREFLUSH		(1ULL << __REQ_PREFLUSH)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ccedccb..46a7420 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -197,11 +197,11 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 #define WRITE			REQ_OP_WRITE
 
 #define READ_SYNC		0
-#define WRITE_SYNC		(REQ_SYNC | REQ_NOIDLE)
-#define WRITE_ODIRECT		REQ_SYNC
-#define WRITE_FLUSH		(REQ_NOIDLE | REQ_PREFLUSH)
-#define WRITE_FUA		(REQ_NOIDLE | REQ_FUA)
-#define WRITE_FLUSH_FUA		(REQ_NOIDLE | REQ_PREFLUSH | REQ_FUA)
+#define WRITE_SYNC		REQ_SYNC
+#define WRITE_ODIRECT		(REQ_SYNC | REQ_IDLE)
+#define WRITE_FLUSH		REQ_PREFLUSH
+#define WRITE_FUA		REQ_FUA
+#define WRITE_FLUSH_FUA		(REQ_PREFLUSH | REQ_FUA)
 
 /*
  * Attribute flags.  These should be or-ed together to figure out what
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 903a091..a9d3442 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -32,7 +32,7 @@ TRACE_DEFINE_ENUM(LFS);
 TRACE_DEFINE_ENUM(SSR);
 TRACE_DEFINE_ENUM(__REQ_RAHEAD);
 TRACE_DEFINE_ENUM(__REQ_SYNC);
-TRACE_DEFINE_ENUM(__REQ_NOIDLE);
+TRACE_DEFINE_ENUM(__REQ_IDLE);
 TRACE_DEFINE_ENUM(__REQ_PREFLUSH);
 TRACE_DEFINE_ENUM(__REQ_FUA);
 TRACE_DEFINE_ENUM(__REQ_PRIO);
-- 
2.1.4

