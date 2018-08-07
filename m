Return-Path: <prvs=750bc9d11=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v5 5/9] block: Change the runtime power management approach (1/2)
Date: Tue,  7 Aug 2018 15:51:29 -0700
Message-Id: <20180807225133.27221-6-bart.vanassche@wdc.com>
In-Reply-To: <20180807225133.27221-1-bart.vanassche@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Instead of scheduling runtime resume of a request queue after a
request has been queued, schedule asynchronous resume during request
allocation. The new pm_request_resume() calls occur after
blk_queue_enter() has increased the q_usage_counter request queue
member. This change is needed for a later patch that will make request
allocation block while the queue status is not RPM_ACTIVE.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-core.c        | 11 +++++++----
 block/blk-mq.c          |  5 +++++
 block/elevator.c        |  2 --
 drivers/scsi/scsi_lib.c |  6 +++++-
 include/linux/blk-mq.h  |  2 ++
 5 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 64697a97147a..179a13be0fca 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -909,11 +909,11 @@ EXPORT_SYMBOL(blk_alloc_queue);
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
- * @flags: BLK_MQ_REQ_NOWAIT and/or BLK_MQ_REQ_PREEMPT
+ * @flags: BLK_MQ_REQ_NOWAIT, BLK_MQ_REQ_PREEMPT and/or BLK_MQ_REQ_PM
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-	const bool pm = flags & BLK_MQ_REQ_PREEMPT;
+	const bool pm = flags & (BLK_MQ_REQ_PREEMPT | BLK_MQ_REQ_PM);
 
 	while (true) {
 		bool success = false;
@@ -1571,7 +1571,7 @@ static struct request *get_request(struct request_queue *q, unsigned int op,
 	goto retry;
 }
 
-/* flags: BLK_MQ_REQ_PREEMPT and/or BLK_MQ_REQ_NOWAIT. */
+/* flags: BLK_MQ_REQ_PREEMPT, BLK_MQ_REQ_PM and/or BLK_MQ_REQ_NOWAIT. */
 static struct request *blk_old_get_request(struct request_queue *q,
 				unsigned int op, blk_mq_req_flags_t flags)
 {
@@ -1595,6 +1595,8 @@ static struct request *blk_old_get_request(struct request_queue *q,
 		return rq;
 	}
 
+	blk_pm_add_request(q, rq);
+
 	/* q->queue_lock is unlocked at this point */
 	rq->__data_len = 0;
 	rq->__sector = (sector_t) -1;
@@ -1614,7 +1616,8 @@ struct request *blk_get_request(struct request_queue *q, unsigned int op,
 	struct request *req;
 
 	WARN_ON_ONCE(op & REQ_NOWAIT);
-	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT));
+	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PREEMPT |
+			       BLK_MQ_REQ_PM));
 
 	if (q->mq_ops) {
 		req = blk_mq_alloc_request(q, op, flags);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c92ce06fd565..434515018c43 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -24,6 +24,7 @@
 #include <linux/sched/signal.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
+#include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
 
 #include <trace/events/block.h>
@@ -33,6 +34,7 @@
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
 #include "blk-mq-tag.h"
+#include "blk-pm.h"
 #include "blk-stat.h"
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
@@ -391,6 +393,9 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		}
 	}
 	data->hctx->queued++;
+
+	blk_pm_add_request(q, rq);
+
 	return rq;
 }
 
diff --git a/block/elevator.c b/block/elevator.c
index 4c15f0240c99..3965292b0724 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -600,8 +600,6 @@ void __elv_add_request(struct request_queue *q, struct request *rq, int where)
 {
 	trace_block_rq_insert(q, rq);
 
-	blk_pm_add_request(q, rq);
-
 	rq->q = q;
 
 	if (rq->rq_flags & RQF_SOFTBARRIER) {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0e48136329c6..6843b49cc130 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -263,11 +263,15 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 {
 	struct request *req;
 	struct scsi_request *rq;
+	blk_mq_req_flags_t blk_mq_req_flags;
 	int ret = DRIVER_ERROR << 24;
 
+	blk_mq_req_flags = BLK_MQ_REQ_PREEMPT;
+	if (rq_flags & RQF_PM)
+		blk_mq_req_flags |= BLK_MQ_REQ_PM;
 	req = blk_get_request(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
-			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
+			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, blk_mq_req_flags);
 	if (IS_ERR(req))
 		return ret;
 	rq = scsi_req(req);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..1c9fae629eec 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -223,6 +223,8 @@ enum {
 	BLK_MQ_REQ_INTERNAL	= (__force blk_mq_req_flags_t)(1 << 2),
 	/* set RQF_PREEMPT */
 	BLK_MQ_REQ_PREEMPT	= (__force blk_mq_req_flags_t)(1 << 3),
+	/* RQF_PM will be set */
+	BLK_MQ_REQ_PM		= (__force blk_mq_req_flags_t)(1 << 4),
 };
 
 struct request *blk_mq_alloc_request(struct request_queue *q, unsigned int op,
-- 
2.18.0
