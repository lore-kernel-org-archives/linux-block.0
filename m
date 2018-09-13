Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH V3 07/17] SCSI: prepare for introducing admin queue for legacy path
Date: Thu, 13 Sep 2018 20:15:36 +0800
Message-Id: <20180913121546.5710-8-ming.lei@redhat.com>
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
References: <20180913121546.5710-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Uses scsi_is_admin_queue() and scsi_get_scsi_dev() to retrieve
'scsi_device' for legacy path.

The same approach can be used in SCSI_MQ path too, just not very efficiently,
and will deal with that in the patch when introducing admin queue for SCSI_MQ.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/scsi_lib.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2800dfae19cd..2f541b4fb32b 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -46,6 +46,20 @@ static DEFINE_MUTEX(scsi_sense_cache_mutex);
 
 static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd);
 
+/* For admin queue, its queuedata is NULL */
+static inline bool scsi_is_admin_queue(struct request_queue *q)
+{
+	return !q->queuedata;
+}
+
+/* This helper can only be used in req prep stage */
+static inline struct scsi_device *scsi_get_scsi_dev(struct request *rq)
+{
+	if (scsi_is_admin_queue(rq->q))
+		return scsi_req(rq)->sdev;
+	return rq->q->queuedata;
+}
+
 static inline struct kmem_cache *
 scsi_select_sense_cache(bool unchecked_isa_dma)
 {
@@ -1426,10 +1440,9 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 }
 
 static int
-scsi_prep_return(struct request_queue *q, struct request *req, int ret)
+scsi_prep_return(struct scsi_device *sdev, struct request_queue *q,
+		struct request *req, int ret)
 {
-	struct scsi_device *sdev = q->queuedata;
-
 	switch (ret) {
 	case BLKPREP_KILL:
 	case BLKPREP_INVALID:
@@ -1461,7 +1474,7 @@ scsi_prep_return(struct request_queue *q, struct request *req, int ret)
 
 static int scsi_prep_fn(struct request_queue *q, struct request *req)
 {
-	struct scsi_device *sdev = q->queuedata;
+	struct scsi_device *sdev = scsi_get_scsi_dev(req);
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 	int ret;
 
@@ -1486,7 +1499,7 @@ static int scsi_prep_fn(struct request_queue *q, struct request *req)
 
 	ret = scsi_setup_cmnd(sdev, req);
 out:
-	return scsi_prep_return(q, req, ret);
+	return scsi_prep_return(sdev, q, req, ret);
 }
 
 static void scsi_unprep_fn(struct request_queue *q, struct request *req)
@@ -1663,6 +1676,9 @@ static int scsi_lld_busy(struct request_queue *q)
 	if (blk_queue_dying(q))
 		return 0;
 
+	if (WARN_ON_ONCE(scsi_is_admin_queue(q)))
+		return 0;
+
 	shost = sdev->host;
 
 	/*
@@ -1866,7 +1882,7 @@ static void scsi_request_fn(struct request_queue *q)
 	__releases(q->queue_lock)
 	__acquires(q->queue_lock)
 {
-	struct scsi_device *sdev = q->queuedata;
+	struct scsi_device *sdev;
 	struct Scsi_Host *shost;
 	struct scsi_cmnd *cmd;
 	struct request *req;
@@ -1875,7 +1891,6 @@ static void scsi_request_fn(struct request_queue *q)
 	 * To start with, we keep looping until the queue is empty, or until
 	 * the host is no longer able to accept any more requests.
 	 */
-	shost = sdev->host;
 	for (;;) {
 		int rtn;
 		/*
@@ -1887,6 +1902,10 @@ static void scsi_request_fn(struct request_queue *q)
 		if (!req)
 			break;
 
+		cmd = blk_mq_rq_to_pdu(req);
+		sdev = cmd->device;
+		shost = sdev->host;
+
 		if (unlikely(!scsi_device_online(sdev))) {
 			sdev_printk(KERN_ERR, sdev,
 				    "rejecting I/O to offline device\n");
@@ -1904,7 +1923,6 @@ static void scsi_request_fn(struct request_queue *q)
 			blk_start_request(req);
 
 		spin_unlock_irq(q->queue_lock);
-		cmd = blk_mq_rq_to_pdu(req);
 		if (cmd != req->special) {
 			printk(KERN_CRIT "impossible request in %s.\n"
 					 "please mail a stack trace to "
@@ -2382,6 +2400,9 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 {
 	struct scsi_device *sdev = NULL;
 
+	/* admin queue won't be exposed to external users */
+	WARN_ON_ONCE(scsi_is_admin_queue(q));
+
 	if (q->mq_ops) {
 		if (q->mq_ops == &scsi_mq_ops)
 			sdev = q->queuedata;
-- 
2.9.5
