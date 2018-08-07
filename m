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
Subject: [RFC PATCH 03/14] SCSI: try to retrieve request_queue via 'scsi_cmnd' if possible
Date: Wed,  8 Aug 2018 01:44:22 +0800
Message-Id: <20180807174433.8374-4-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
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
 drivers/scsi/libsas/sas_ata.c       | 2 +-
 drivers/scsi/libsas/sas_scsi_host.c | 2 +-
 drivers/scsi/scsi_error.c           | 2 +-
 drivers/scsi/scsi_lib.c             | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index ff1d612f6fb9..590dffe6e960 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -594,7 +594,7 @@ void sas_ata_task_abort(struct sas_task *task)
 
 	/* Bounce SCSI-initiated commands to the SCSI EH */
 	if (qc->scsicmd) {
-		struct request_queue *q = qc->scsicmd->device->request_queue;
+		struct request_queue *q = qc->scsicmd->request->q;
 		unsigned long flags;
 
 		spin_lock_irqsave(q->queue_lock, flags);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index ceab5e5c41c2..42994ad9549c 100644
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
index 2715cdaa669c..9260b267fe43 100644
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
index 9cb9a166fa0c..4341cf8a7322 100644
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
@@ -667,7 +667,7 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 	struct scsi_device *sdev = cmd->device;
-	struct request_queue *q = sdev->request_queue;
+	struct request_queue *q = cmd->request->q;
 
 	if (blk_update_request(req, error, bytes))
 		return true;
@@ -792,7 +792,7 @@ static blk_status_t scsi_result_to_blk_status(struct scsi_cmnd *cmd, int result)
 void scsi_io_completion(struct scsi_cmnd *cmd, unsigned int good_bytes)
 {
 	int result = cmd->result;
-	struct request_queue *q = cmd->device->request_queue;
+	struct request_queue *q = cmd->request->q;
 	struct request *req = cmd->request;
 	blk_status_t error = BLK_STS_OK;
 	struct scsi_sense_hdr sshdr;
-- 
2.9.5
