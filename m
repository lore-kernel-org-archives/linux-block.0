Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, James Bottomley
	<James.Bottomley@HansenPartnership.com>, Bart Van Assche
	<bart.vanassche@sandisk.com>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke
	<hare@suse.com>
Subject: [PATCH v2 4/5] scsi: Add scsi_restart_hctx()
Date: Mon, 3 Apr 2017 16:22:27 -0700
Message-ID: <20170403232228.11208-5-bart.vanassche@sandisk.com>
In-Reply-To: <20170403232228.11208-1-bart.vanassche@sandisk.com>
References: <20170403232228.11208-1-bart.vanassche@sandisk.com>
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
index c1519660824b..0e240aebc150 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -555,6 +555,21 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 		scsi_run_queue(sdev->request_queue);
 }
 
+static void scsi_restart_hctx(struct request_queue *q,
+			      struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_tags *tags = hctx->tags;
+	struct blk_mq_tag_set *set = q->tag_set;
+	int i;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list)
+		queue_for_each_hw_ctx(q, hctx, i)
+			if (hctx->tags == tags)
+				blk_mq_sched_restart_hctx(hctx);
+	rcu_read_unlock();
+}
+
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 {
 	if (!blk_rq_is_passthrough(cmd->request)) {
@@ -2156,6 +2171,7 @@ struct request_queue *scsi_alloc_queue(struct scsi_device *sdev)
 
 static const struct blk_mq_ops scsi_mq_ops = {
 	.queue_rq	= scsi_queue_rq,
+	.restart_hctx	= scsi_restart_hctx,
 	.complete	= scsi_softirq_done,
 	.timeout	= scsi_timeout,
 	.init_request	= scsi_init_request,
-- 
2.12.0
