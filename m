Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH 2/3] scsi: Add scsi_restart_queues()
Date: Fri, 31 Mar 2017 16:12:04 -0700
Message-ID: <20170331231205.16640-3-bart.vanassche@sandisk.com>
In-Reply-To: <20170331231205.16640-1-bart.vanassche@sandisk.com>
References: <20170331231205.16640-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

This patch avoids that if multiple SCSI devices are associated with
a SCSI host that a queue can get stuck if scsi_queue_rq() returns
"busy".

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_lib.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index c1519660824b..1d804e33971a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -555,6 +555,21 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 		scsi_run_queue(sdev->request_queue);
 }
 
+static void scsi_restart_queues(struct request_queue *q)
+{
+	struct scsi_device *sdev = q->queuedata;
+	struct Scsi_Host *shost = sdev->host;
+	unsigned long flags;
+
+	spin_lock_irqsave(shost->host_lock, flags);
+	__shost_for_each_device(sdev, shost) {
+		q = sdev->request_queue;
+		if (q->mq_ops && !blk_queue_dying(q))
+			blk_mq_run_hw_queues(q, true);
+	}
+	spin_unlock_irqrestore(shost->host_lock, flags);
+}
+
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 {
 	if (!blk_rq_is_passthrough(cmd->request)) {
@@ -2156,6 +2171,7 @@ struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
 
 static const struct blk_mq_ops scsi_mq_ops = {
 	.queue_rq	= scsi_queue_rq,
+	.restart_queues	= scsi_restart_queues,
 	.complete	= scsi_softirq_done,
 	.timeout	= scsi_timeout,
 	.init_request	= scsi_init_request,
-- 
2.12.0
