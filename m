Return-Path: <prvs=4177119eb=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/5] block: Introduce REQ_PM and remove RQF_PM
Date: Fri,  8 Sep 2017 16:52:24 -0700
Message-Id: <20170908235226.26622-4-bart.vanassche@wdc.com>
In-Reply-To: <20170908235226.26622-1-bart.vanassche@wdc.com>
References: <20170908235226.26622-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Tell the block layer at request allocation time whether or not a
request will be used to change the power management state of a
block device.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c          | 11 +++++++++--
 block/blk-mq-debugfs.c    |  2 +-
 block/elevator.c          |  4 ++--
 drivers/scsi/scsi_lib.c   |  9 +++++----
 include/linux/blk_types.h |  2 ++
 include/linux/blkdev.h    |  2 --
 6 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d709c0e3a2ac..bb53c6b58e8c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1412,6 +1412,13 @@ static struct request *blk_old_get_request(struct request_queue *q,
 	return rq;
 }
 
+/**
+ * blk_get_request() - allocate a request
+ * @q: request queue.
+ * @op: bitwise or of operation (REQ_OP_*; see also enum req_opf) and flags
+ *      (REQ_*; see also enum req_flag_bits).
+ * @gfp_mask: request memory allocation flags.
+ */
 struct request *blk_get_request(struct request_queue *q, unsigned int op,
 				gfp_t gfp_mask)
 {
@@ -1529,7 +1536,7 @@ EXPORT_SYMBOL_GPL(part_round_stats);
 #ifdef CONFIG_PM
 static void blk_pm_put_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM) && !--rq->q->nr_pending)
+	if (rq->q->dev && !(rq->cmd_flags & REQ_PM) && !--rq->q->nr_pending)
 		pm_runtime_mark_last_busy(rq->q->dev);
 }
 #else
@@ -2460,7 +2467,7 @@ static struct request *blk_pm_peek_request(struct request_queue *q,
 					   struct request *rq)
 {
 	if (q->dev && (q->rpm_status == RPM_SUSPENDED ||
-	    (q->rpm_status != RPM_ACTIVE && !(rq->rq_flags & RQF_PM))))
+	    (q->rpm_status != RPM_ACTIVE && !(rq->cmd_flags & REQ_PM))))
 		return NULL;
 	else
 		return rq;
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 980e73095643..ea21124b190b 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -266,6 +266,7 @@ static const char *const cmd_flag_name[] = {
 	CMD_FLAG_NAME(BACKGROUND),
 	CMD_FLAG_NAME(NOUNMAP),
 	CMD_FLAG_NAME(NOWAIT),
+	CMD_FLAG_NAME(PM),
 };
 #undef CMD_FLAG_NAME
 
@@ -286,7 +287,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(ELVPRIV),
 	RQF_NAME(IO_STAT),
 	RQF_NAME(ALLOCED),
-	RQF_NAME(PM),
 	RQF_NAME(HASHED),
 	RQF_NAME(STATS),
 	RQF_NAME(SPECIAL_PAYLOAD),
diff --git a/block/elevator.c b/block/elevator.c
index 153926a90901..7898960bed2a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -574,13 +574,13 @@ void elv_bio_merged(struct request_queue *q, struct request *rq,
 #ifdef CONFIG_PM
 static void blk_pm_requeue_request(struct request *rq)
 {
-	if (rq->q->dev && !(rq->rq_flags & RQF_PM))
+	if (rq->q->dev && !(rq->cmd_flags & REQ_PM))
 		rq->q->nr_pending--;
 }
 
 static void blk_pm_add_request(struct request_queue *q, struct request *rq)
 {
-	if (q->dev && !(rq->rq_flags & RQF_PM) && q->nr_pending++ == 0 &&
+	if (q->dev && !(rq->cmd_flags & REQ_PM) && q->nr_pending++ == 0 &&
 	    (q->rpm_status == RPM_SUSPENDED || q->rpm_status == RPM_SUSPENDING))
 		pm_request_resume(q->dev);
 }
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5be515c8c6bd..64ad70e8447c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -242,11 +242,12 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 {
 	struct request *req;
 	struct scsi_request *rq;
+	unsigned int op_and_flags;
 	int ret = DRIVER_ERROR << 24;
 
-	req = blk_get_request(sdev->request_queue,
-			data_direction == DMA_TO_DEVICE ?
-			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, __GFP_RECLAIM);
+	op_and_flags = (data_direction == DMA_TO_DEVICE ? REQ_OP_SCSI_OUT :
+			REQ_OP_SCSI_IN) | (is_pm_req ? REQ_PM : 0);
+	req = blk_get_request(sdev->request_queue, op_and_flags, __GFP_RECLAIM);
 	if (IS_ERR(req))
 		return ret;
 	rq = scsi_req(req);
@@ -260,7 +261,7 @@ int scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	rq->retries = retries;
 	req->timeout = timeout;
 	req->cmd_flags |= flags;
-	req->rq_flags |= (is_pm_req ? RQF_PM : 0) | RQF_QUIET | RQF_PREEMPT;
+	req->rq_flags |= RQF_QUIET | RQF_PREEMPT;
 
 	/*
 	 * head injection *required* here otherwise quiesce won't work
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index a2d2aa709cef..fdf4685a5856 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -229,6 +229,7 @@ enum req_flag_bits {
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
 	__REQ_NOWAIT,           /* Don't wait if request will block */
+	__REQ_PM,		/* Power management request */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -248,6 +249,7 @@ enum req_flag_bits {
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
+#define REQ_PM			(1ULL << __REQ_PM)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 460294bb0fa5..7f9a0743fc09 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -111,8 +111,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
 /* request came from our alloc pool */
 #define RQF_ALLOCED		((__force req_flags_t)(1 << 14))
-/* runtime pm request */
-#define RQF_PM			((__force req_flags_t)(1 << 15))
 /* on IO scheduler merge hash */
 #define RQF_HASHED		((__force req_flags_t)(1 << 16))
 /* IO stats tracking on */
-- 
2.14.1
