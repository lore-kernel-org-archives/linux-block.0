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
Subject: [PATCH V3 05/17] SCSI: try to retrieve request_queue via 'scsi_cmnd' if possible
Date: Thu, 13 Sep 2018 20:15:34 +0800
Message-Id: <20180913121546.5710-6-ming.lei@redhat.com>
In-Reply-To: <20180913121546.5710-1-ming.lei@redhat.com>
References: <20180913121546.5710-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Prepare for introduing per-host admin queue.

The most important part is that the request originated from admin queue
can't be called back to the IO queue associated with scsi_device, especially,
one request may be requeued, timedout or completed via block layer helper, so
what we should do is to use 'scsi_cmnd->request->q' to retrieve the request
queue, and pass that to block layer helper, instead of
sdev->request_queue.

Fortunately most of users of 'scsi_device->request_queue' aren't in related IO
path(requeue, timeout, complete, run queue), so the audit isn't more difficult
than I thought of.

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
 drivers/ata/libata-eh.c             | 2 +-
 drivers/scsi/libsas/sas_ata.c       | 2 +-
 drivers/scsi/libsas/sas_scsi_host.c | 2 +-
 drivers/scsi/scsi_error.c           | 2 +-
 drivers/scsi/scsi_lib.c             | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 01306c018398..fbceea6b62a9 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -919,7 +919,7 @@ static void ata_eh_set_pending(struct ata_port *ap, int fastdrain)
 void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
-	struct request_queue *q = qc->scsicmd->device->request_queue;
+	struct request_queue *q = qc->scsicmd->request->q;
 	unsigned long flags;
 
 	WARN_ON(!ap->ops->error_handler);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 64a958a99f6a..fcf46437b756 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -601,7 +601,7 @@ void sas_ata_task_abort(struct sas_task *task)
 
 	/* Bounce SCSI-initiated commands to the SCSI EH */
 	if (qc->scsicmd) {
-		struct request_queue *q = qc->scsicmd->device->request_queue;
+		struct request_queue *q = qc->scsicmd->request->q;
 		unsigned long flags;
 
 		spin_lock_irqsave(q->queue_lock, flags);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 33229348dcb6..91e192f93ae1 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -933,7 +933,7 @@ void sas_task_abort(struct sas_task *task)
 	if (dev_is_sata(task->dev)) {
 		sas_ata_task_abort(task);
 	} else {
-		struct request_queue *q = sc->device->request_queue;
+		struct request_queue *q = sc->request->q;
 		unsigned long flags;
 
 		spin_lock_irqsave(q->queue_lock, flags);
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index b7a8fdfeb2f4..9f19c80b983c 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1360,7 +1360,7 @@ static int scsi_eh_try_stu(struct scsi_cmnd *scmd)
 		int i, rtn = NEEDS_RETRY;
 
 		for (i = 0; rtn == NEEDS_RETRY && i < 2; i++)
-			rtn = scsi_send_eh_cmnd(scmd, stu_command, 6, scmd->device->request_queue->rq_timeout, 0);
+			rtn = scsi_send_eh_cmnd(scmd, stu_command, 6, scmd->request->q->rq_timeout, 0);
 
 		if (rtn == SUCCESS)
 			return 0;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index eb97d2dd3651..6fb8fd3ccc2c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -168,7 +168,7 @@ static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 {
 	struct scsi_device *device = cmd->device;
-	struct request_queue *q = device->request_queue;
+	struct request_queue *q = cmd->request->q;
 	unsigned long flags;
 
 	SCSI_LOG_MLQUEUE(1, scmd_printk(KERN_INFO, cmd,
@@ -668,7 +668,7 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 	struct scsi_device *sdev = cmd->device;
-	struct request_queue *q = sdev->request_queue;
+	struct request_queue *q = cmd->request->q;
 
 	if (blk_update_request(req, error, bytes))
 		return true;
@@ -1038,7 +1038,7 @@ static int scsi_io_completion_nz_result(struct scsi_cmnd *cmd, int result,
 void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 {
 	int result = cmd->result;
-	struct request_queue *q = cmd->device->request_queue;
+	struct request_queue *q = cmd->request->q;
 	struct request *req = cmd->request;
 	blk_status_t blk_stat = BLK_STS_OK;
 
-- 
2.9.5
