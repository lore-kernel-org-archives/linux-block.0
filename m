Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 01/12] block, scsi: Introduce request flag RQF_DV
Date: Thu,  9 Aug 2018 12:41:38 -0700
Message-Id: <20180809194149.15285-2-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Instead of marking all power management, SCSI domain validation and
IDE preempt requests with RQF_PREEMPT, only mark IDE preempt
requests with RQF_PREEMPT. Use RQF_DV to mark requests submitted by
scsi_execute() and RQF_PM to mark power management requests. Most
but not all power management requests already have the RQF_PM flag
set.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c        | 11 +++++------
 block/blk-mq-debugfs.c  |  1 +
 block/blk-mq.c          |  2 --
 drivers/ide/ide-pm.c    |  3 ++-
 drivers/scsi/scsi_lib.c | 11 ++++++++---
 include/linux/blk-mq.h  |  6 ++++--
 include/linux/blkdev.h  |  5 +++--
 7 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 12550340418d..c4ff58491758 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -913,11 +913,11 @@ EXPORT_SYMBOL(blk_alloc_queue);
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
- * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PREEMPT
+ * @flags: BLK_MQ_REQ_NOWAIT, BLK_MQ_REQ_PM and/or BLK_MQ_REQ_DV
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-	const bool preempt = flags & BLK_MQ_REQ_PREEMPT;
+	const bool preempt = flags & (BLK_MQ_REQ_PM | BLK_MQ_REQ_DV);
 
 	while (true) {
 		bool success = false;
@@ -1436,8 +1436,6 @@ static struct request *__get_request(struct request_list *rl, unsigned int op,
 	blk_rq_set_rl(rq, rl);
 	rq->cmd_flags = op;
 	rq->rq_flags = rq_flags;
-	if (flags & BLK_MQ_REQ_PREEMPT)
-		rq->rq_flags |= RQF_PREEMPT;
 
 	/* init elvpriv */
 	if (rq_flags & RQF_ELVPRIV) {
@@ -1575,7 +1573,7 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	goto retry;
 }
 
-/* flags: BLK_MQ_REQ_PREEMPT and/or BLK_MQ_REQ_NOWAIT. */
+/* flags: BLK_MQ_REQ_NOWAIT, BLK_MQ_REQ_PM and/or BLK_MQ_REQ_DV. */
 static struct request *blk_old_get_request(struct request_queue *q,
 				unsigned int op, blk_mq_req_flags_t flags)
 {
@@ -1618,7 +1616,8 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 	struct request *req;
 
 	WARN_ON_ONCE(op & REQ_NOWAIT);
-	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT));
+	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PM |
+			       BLK_MQ_REQ_DV));
 
 	if (q->mq_ops) {
 		req = blk_mq_alloc_request(q, op, flags);
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cb1e6cf7ac48..b4e722311ae1 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -330,6 +330,7 @@ static const char *const rqf_name[] = {
 	RQF_NAME(SPECIAL_PAYLOAD),
 	RQF_NAME(ZONE_WRITE_LOCKED),
 	RQF_NAME(MQ_POLL_SLEPT),
+	RQF_NAME(DV),
 };
 #undef RQF_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 72a0033ccee9..2a0eb058ba5a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -300,8 +300,6 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	rq->rq_flags = rq_flags;
 	rq->cpu = -1;
 	rq->cmd_flags = op;
-	if (data->flags & BLK_MQ_REQ_PREEMPT)
-		rq->rq_flags |= RQF_PREEMPT;
 	if (blk_queue_io_stat(data->q))
 		rq->rq_flags |= RQF_IO_STAT;
 	INIT_LIST_HEAD(&rq->queuelist);
diff --git a/drivers/ide/ide-pm.c b/drivers/ide/ide-pm.c
index 59217aa1d1fb..8bf378164aee 100644
--- a/drivers/ide/ide-pm.c
+++ b/drivers/ide/ide-pm.c
@@ -90,8 +90,9 @@ int generic_ide_resume(struct device *dev)
 	}
 
 	memset(&rqpm, 0, sizeof(rqpm));
-	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_PREEMPT);
+	rq = blk_get_request(drive->queue, REQ_OP_DRV_IN, BLK_MQ_REQ_PM);
 	ide_req(rq)->type = ATA_PRIV_PM_RESUME;
+	rq->rq_flags |= RQF_PM;
 	rq->special = &rqpm;
 	rqpm.pm_step = IDE_PM_START_RESUME;
 	rqpm.pm_state = PM_EVENT_ON;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9cb9a166fa0c..a65a03e2bcc4 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -263,11 +263,16 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 {
 	struct request *req;
 	struct scsi_request *rq;
+	blk_mq_req_flags_t blk_mq_req_flags = 0;
 	int ret = DRIVER_ERROR << 24;
 
+	if (rq_flags & RQF_PM)
+		blk_mq_req_flags |= BLK_MQ_REQ_PM;
+	rq_flags |= RQF_DV;
+	blk_mq_req_flags |= BLK_MQ_REQ_DV;
 	req = blk_get_request(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
-			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
+			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, blk_mq_req_flags);
 	if (IS_ERR(req))
 		return ret;
 	rq = scsi_req(req);
@@ -1356,7 +1361,7 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 			/*
 			 * If the devices is blocked we defer normal commands.
 			 */
-			if (req && !(req->rq_flags & RQF_PREEMPT))
+			if (req && !(req->rq_flags & (RQF_PM | RQF_DV)))
 				ret = BLKPREP_DEFER;
 			break;
 		default:
@@ -1365,7 +1370,7 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 			 * special commands.  In particular any user initiated
 			 * command is not allowed.
 			 */
-			if (req && !(req->rq_flags & RQF_PREEMPT))
+			if (req && !(req->rq_flags & (RQF_PM | RQF_DV)))
 				ret = BLKPREP_KILL;
 			break;
 		}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..4ac964eeabc8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -221,8 +221,10 @@ enum {
 	BLK_MQ_REQ_RESERVED	= (__force blk_mq_req_flags_t)(1 << 1),
 	/* allocate internal/sched tag */
 	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
-	/* set RQF_PREEMPT */
-	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
+	/* RQF_PM will be set by the caller */
+	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 3),
+	/* RQF_DV will be set by the caller */
+	BLK_MQ_REQ_DV		= (__force blk_mq_req_flags_t)(1 << 4),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0e2b64..938725ef492b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -97,8 +97,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_INFLIGHT		((__force req_flags_t)(1 << 6))
 /* don't call prep for this one */
 #define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
-/* set for "ide_preempt" requests and also for requests for which the SCSI
-   "quiesce" state must be ignored. */
+/* set for "ide_preempt" requests */
 #define RQF_PREEMPT		((__force req_flags_t)(1 << 8))
 /* contains copies of user pages */
 #define RQF_COPY_USER		((__force req_flags_t)(1 << 9))
@@ -127,6 +126,8 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_POLL_SLEPT	((__force req_flags_t)(1 << 20))
 /* ->timeout has been called, don't expire again */
 #define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
+/* set for SCSI domain validation requests */
+#define RQF_DV			((__force req_flags_t)(1 << 22))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.18.0
