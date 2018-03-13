Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752455AbeCMJoY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Mar 2018 05:44:24 -0400
From: Ming Lei <ming.lei@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@fb.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Laurence Oberman <loberman@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 5/5] scsi: virtio_scsi: unify scsi_host_template
Date: Tue, 13 Mar 2018 17:42:43 +0800
Message-Id: <20180313094243.8710-6-ming.lei@redhat.com>
In-Reply-To: <20180313094243.8710-1-ming.lei@redhat.com>
References: <20180313094243.8710-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now we switch to use_blk_mq always, and both single queue and multi
queue cases can be handled in one .queuecommand callback, not necessary
to use two scsi_host_template.

Suggested-by: Christoph Hellwig <hch@lst.de>,
Cc: Omar Sandoval <osandov@fb.com>,
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
Cc: James Bottomley <james.bottomley@hansenpartnership.com>,
Cc: Christoph Hellwig <hch@lst.de>,
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 74 ++++++++++------------------------------------
 1 file changed, 15 insertions(+), 59 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 54e3a0f6844c..45d04631888a 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -522,11 +522,20 @@ static void virtio_scsi_init_hdr_pi(struct virtio_device *vdev,
 }
 #endif
 
-static int virtscsi_queuecommand(struct virtio_scsi *vscsi,
-				 struct virtio_scsi_vq *req_vq,
+static struct virtio_scsi_vq *virtscsi_pick_vq_mq(struct virtio_scsi *vscsi,
+						  struct scsi_cmnd *sc)
+{
+	u32 tag = blk_mq_unique_tag(sc->request);
+	u16 hwq = blk_mq_unique_tag_to_hwq(tag);
+
+	return &vscsi->req_vqs[hwq];
+}
+
+static int virtscsi_queuecommand(struct Scsi_Host *shost,
 				 struct scsi_cmnd *sc)
 {
-	struct Scsi_Host *shost = virtio_scsi_host(vscsi->vdev);
+	struct virtio_scsi *vscsi = shost_priv(shost);
+	struct virtio_scsi_vq *req_vq = virtscsi_pick_vq_mq(vscsi, sc);
 	struct virtio_scsi_cmd *cmd = scsi_cmd_priv(sc);
 	unsigned long flags;
 	int req_size;
@@ -569,32 +578,6 @@ static int virtscsi_queuecommand(struct virtio_scsi *vscsi,
 	return 0;
 }
 
-static int virtscsi_queuecommand_single(struct Scsi_Host *sh,
-					struct scsi_cmnd *sc)
-{
-	struct virtio_scsi *vscsi = shost_priv(sh);
-
-	return virtscsi_queuecommand(vscsi, &vscsi->req_vqs[0], sc);
-}
-
-static struct virtio_scsi_vq *virtscsi_pick_vq_mq(struct virtio_scsi *vscsi,
-						  struct scsi_cmnd *sc)
-{
-	u32 tag = blk_mq_unique_tag(sc->request);
-	u16 hwq = blk_mq_unique_tag_to_hwq(tag);
-
-	return &vscsi->req_vqs[hwq];
-}
-
-static int virtscsi_queuecommand_multi(struct Scsi_Host *sh,
-				       struct scsi_cmnd *sc)
-{
-	struct virtio_scsi *vscsi = shost_priv(sh);
-	struct virtio_scsi_vq *req_vq = virtscsi_pick_vq_mq(vscsi, sc);
-
-	return virtscsi_queuecommand(vscsi, req_vq, sc);
-}
-
 static int virtscsi_tmf(struct virtio_scsi *vscsi, struct virtio_scsi_cmd *cmd)
 {
 	DECLARE_COMPLETION_ONSTACK(comp);
@@ -750,34 +733,13 @@ static enum blk_eh_timer_return virtscsi_eh_timed_out(struct scsi_cmnd *scmnd)
 	return BLK_EH_RESET_TIMER;
 }
 
-static struct scsi_host_template virtscsi_host_template_single = {
-	.module = THIS_MODULE,
-	.name = "Virtio SCSI HBA",
-	.proc_name = "virtio_scsi",
-	.this_id = -1,
-	.cmd_size = sizeof(struct virtio_scsi_cmd),
-	.queuecommand = virtscsi_queuecommand_single,
-	.change_queue_depth = virtscsi_change_queue_depth,
-	.eh_abort_handler = virtscsi_abort,
-	.eh_device_reset_handler = virtscsi_device_reset,
-	.eh_timed_out = virtscsi_eh_timed_out,
-	.slave_alloc = virtscsi_device_alloc,
-
-	.dma_boundary = UINT_MAX,
-	.use_clustering = ENABLE_CLUSTERING,
-	.target_alloc = virtscsi_target_alloc,
-	.target_destroy = virtscsi_target_destroy,
-	.track_queue_depth = 1,
-	.force_blk_mq = 1,
-};
-
-static struct scsi_host_template virtscsi_host_template_multi = {
+static struct scsi_host_template virtscsi_host_template = {
 	.module = THIS_MODULE,
 	.name = "Virtio SCSI HBA",
 	.proc_name = "virtio_scsi",
 	.this_id = -1,
 	.cmd_size = sizeof(struct virtio_scsi_cmd),
-	.queuecommand = virtscsi_queuecommand_multi,
+	.queuecommand = virtscsi_queuecommand,
 	.change_queue_depth = virtscsi_change_queue_depth,
 	.eh_abort_handler = virtscsi_abort,
 	.eh_device_reset_handler = virtscsi_device_reset,
@@ -883,7 +845,6 @@ static int virtscsi_probe(struct virtio_device *vdev)
 	u32 sg_elems, num_targets;
 	u32 cmd_per_lun;
 	u32 num_queues;
-	struct scsi_host_template *hostt;
 
 	if (!vdev->config->get) {
 		dev_err(&vdev->dev, "%s failure: config access disabled\n",
@@ -896,12 +857,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
 
 	num_targets = virtscsi_config_get(vdev, max_target) + 1;
 
-	if (num_queues == 1)
-		hostt = &virtscsi_host_template_single;
-	else
-		hostt = &virtscsi_host_template_multi;
-
-	shost = scsi_host_alloc(hostt,
+	shost = scsi_host_alloc(&virtscsi_host_template,
 		sizeof(*vscsi) + sizeof(vscsi->req_vqs[0]) * num_queues);
 	if (!shost)
 		return -ENOMEM;
-- 
2.9.5
