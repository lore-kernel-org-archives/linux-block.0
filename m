Return-Path: <prvs=7477a5644=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 02/10] block, scsi: Give RQF_PREEMPT back its original meaning
Date: Fri,  3 Aug 2018 17:03:17 -0700
Message-Id: <20180804000325.3610-3-bart.vanassche@wdc.com>
In-Reply-To: <20180804000325.3610-1-bart.vanassche@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

In kernel v2.6.18 RQF_PREEMPT was only set for IDE preempt requests.
Later on the SCSI core was modified such that RQF_PREEMPT requests
was set for all requests submitted by __scsi_execute(), including
power management requests. RQF_PREEMPT requests are the only requests
processed in the SDEV_QUIESCE state. Instead of setting RQF_PREEMPT
for all requests submitted by __scsi_execute(), only set RQF_PM for
power management requests. Modify blk_get_request() such that it
blocks in pm-only mode on non-RQF_PM requests. Leave the code out
from scsi_prep_state_check() that is no longer reachable.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 block/blk-core.c        |  9 +++++----
 drivers/scsi/scsi_lib.c | 28 ++++++++++++----------------
 include/linux/blk-mq.h  |  2 ++
 include/linux/blkdev.h  |  6 ++----
 4 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b83798c03ca8..3378fe478e67 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -908,11 +908,11 @@ EXPORT_SYMBOL(blk_alloc_queue);
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
- * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PREEMPT
+ * @flags: BLK_MQ_REQ_NOWAIT, BLK_MQ_REQ_PREEMPT and/or BLK_MQ_REQ_PM
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-	const bool pm = flags & BLK_MQ_REQ_PREEMPT;
+	const bool pm = flags & BLK_MQ_REQ_PM;
 
 	while (true) {
 		bool success = false;
@@ -1570,7 +1570,7 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	goto retry;
 }
 
-/* flags: BLK_MQ_REQ_PREEMPT and/or BLK_MQ_REQ_NOWAIT. */
+/* flags: BLK_MQ_REQ_PREEMPT, BLK_MQ_REQ_PM and/or BLK_MQ_REQ_NOWAIT. */
 static struct request *blk_old_get_request(struct request_queue *q,
 				unsigned int op, blk_mq_req_flags_t flags)
 {
@@ -1613,7 +1613,8 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 	struct request *req;
 
 	WARN_ON_ONCE(op & REQ_NOWAIT);
-	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT));
+	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT |
+			       BLK_MQ_REQ_PM));
 
 	if (q->mq_ops) {
 		req = blk_mq_alloc_request(q, op, flags);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 007bb2bc817d..481158ab5081 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -248,8 +248,8 @@ void scsi_queue_insert(struct scsi_cmnd *cmd, int reason)
  * @sshdr:	optional decoded sense header
  * @timeout:	request timeout in seconds
  * @retries:	number of times to retry request
- * @flags:	flags for ->cmd_flags
- * @rq_flags:	flags for ->rq_flags
+ * @flags:	REQ_* flags for ->cmd_flags
+ * @rq_flags:	RQF_* flags for ->rq_flags
  * @resid:	optional residual length
  *
  * Returns the scsi_cmnd result field if a command was executed, or a negative
@@ -267,7 +267,8 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 
 	req = blk_get_request(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
-			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
+			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN,
+			rq_flags & RQF_PM ? BLK_MQ_REQ_PM : 0);
 	if (IS_ERR(req))
 		return ret;
 	rq = scsi_req(req);
@@ -1353,20 +1354,15 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 			ret = BLKPREP_DEFER;
 			break;
 		case SDEV_QUIESCE:
-			/*
-			 * If the devices is blocked we defer normal commands.
-			 */
-			if (req && !(req->rq_flags & RQF_PREEMPT))
-				ret = BLKPREP_DEFER;
+			WARN_ON_ONCE(!(req->rq_flags & RQF_PM));
 			break;
-		default:
-			/*
-			 * For any other not fully online state we only allow
-			 * special commands.  In particular any user initiated
-			 * command is not allowed.
-			 */
-			if (req && !(req->rq_flags & RQF_PREEMPT))
-				ret = BLKPREP_KILL;
+		case SDEV_CANCEL:
+			ret = BLKPREP_KILL;
+			break;
+		case SDEV_CREATED:
+		case SDEV_RUNNING:
+			/* This code is never reached */
+			WARN_ONCE(true, "sdev state = %d\n", sdev->sdev_state);
 			break;
 		}
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..f15c1de51f5e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -223,6 +223,8 @@ enum {
 	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
 	/* set RQF_PREEMPT */
 	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
+	/* for power management requests */
+	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 4),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1a08edbddf9f..1b3fe78872dc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -99,8 +99,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_MQ_INFLIGHT		((__force req_flags_t)(1 << 6))
 /* don't call prep for this one */
 #define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
-/* set for "ide_preempt" requests and also for requests for which the SCSI
-   "quiesce" state must be ignored. */
+/* set for "ide_preempt" requests */
 #define RQF_PREEMPT		((__force req_flags_t)(1 << 8))
 /* contains copies of user pages */
 #define RQF_COPY_USER		((__force req_flags_t)(1 << 9))
@@ -508,8 +507,7 @@ struct request_queue {
 	unsigned long		queue_flags;
 	/*
 	 * Number of contexts that have called blk_set_pm_only(). If this
-	 * counter is above zero then only RQF_PM and RQF_PREEMPT requests are
-	 * processed.
+	 * counter is above zero then only RQF_PM requests are processed.
 	 */
 	atomic_t		pm_only;
 
-- 
2.18.0
