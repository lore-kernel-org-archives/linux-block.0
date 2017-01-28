Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbdA1Jcw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 04:32:52 -0500
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>, mst@redhat.com, jasowang@redhat.com
Cc: linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 5/5] virtio_blk: make SCSI passthrough support configurable
Date: Sat, 28 Jan 2017 09:32:53 +0100
Message-Id: <1485592373-29837-6-git-send-email-hch@lst.de>
In-Reply-To: <1485592373-29837-1-git-send-email-hch@lst.de>
References: <1485592373-29837-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The SCSI passthrough idea was a a bad idea to start with (guess who came
up with it?), and has been removed from the virtio 1.O spec, and is not
enabled by defauly by any host I know of.  Add a separate config option
for it so that we don't need to enable it for most setups.  That way
any bugs related to it (like the one recently fixed for vmapped stacks)
do not affect other users, and the size of the virtblk_req structure
also shrinks significantly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/Kconfig      |  11 +++-
 drivers/block/virtio_blk.c | 143 +++++++++++++++++++++++++++++----------------
 2 files changed, 104 insertions(+), 50 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 7a4c787..f744de7 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -500,11 +500,20 @@ config XEN_BLKDEV_BACKEND
 config VIRTIO_BLK
 	tristate "Virtio block driver"
 	depends on VIRTIO
-	select BLK_SCSI_REQUEST
 	---help---
 	  This is the virtual block driver for virtio.  It can be used with
           lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
+config VIRTIO_BLK_SCSI
+	bool "SCSI passthrough request for the Virtio block driver"
+	depends on VIRTIO_BLK
+	select BLK_SCSI_REQUEST
+	---help---
+	  Enable support for SCSI passthrough (e.g. the SG_IO ioctl) on
+	  virtio-blk devices.  This is only supported for the legacy
+	  virtio protocol and not enabled by default by any hypervisor.
+	  Your probably want to virtio-scsi instead.
+
 config BLK_DEV_HD
 	bool "Very old hard disk (MFM/RLL/IDE) driver"
 	depends on HAVE_IDE
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7c730e2..d9491bd 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -52,11 +52,13 @@ struct virtio_blk {
 };
 
 struct virtblk_req {
-	struct scsi_request sreq;	/* for SCSI passthrough */
-	struct virtio_blk_outhdr out_hdr;
+#ifdef CONFIG_VIRTIO_BLK_SCSI
+	struct scsi_request sreq;	/* for SCSI passthrough, must be first */
+	u8 sense[SCSI_SENSE_BUFFERSIZE];
 	struct virtio_scsi_inhdr in_hdr;
+#endif
+	struct virtio_blk_outhdr out_hdr;
 	u8 status;
-	u8 sense[SCSI_SENSE_BUFFERSIZE];
 	struct scatterlist sg[];
 };
 
@@ -72,28 +74,88 @@ static inline int virtblk_result(struct virtblk_req *vbr)
 	}
 }
 
-static int __virtblk_add_req(struct virtqueue *vq,
-			     struct virtblk_req *vbr,
-			     struct scatterlist *data_sg,
-			     bool have_data)
+/*
+ * If this is a packet command we need a couple of additional headers.  Behind
+ * the normal outhdr we put a segment with the scsi command block, and before
+ * the normal inhdr we put the sense data and the inhdr with additional status
+ * information.
+ */
+#ifdef CONFIG_VIRTIO_BLK_SCSI
+static int virtblk_add_req_scsi(struct virtqueue *vq, struct virtblk_req *vbr,
+		struct scatterlist *data_sg, bool have_data)
 {
 	struct scatterlist hdr, status, cmd, sense, inhdr, *sgs[6];
 	unsigned int num_out = 0, num_in = 0;
-	__virtio32 type = vbr->out_hdr.type & ~cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT);
 
 	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
 	sgs[num_out++] = &hdr;
+	sg_init_one(&cmd, vbr->sreq.cmd, vbr->sreq.cmd_len);
+	sgs[num_out++] = &cmd;
+
+	if (have_data) {
+		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
+			sgs[num_out++] = data_sg;
+		else
+			sgs[num_out + num_in++] = data_sg;
+	}
+
+	sg_init_one(&sense, vbr->sense, SCSI_SENSE_BUFFERSIZE);
+	sgs[num_out + num_in++] = &sense;
+	sg_init_one(&inhdr, &vbr->in_hdr, sizeof(vbr->in_hdr));
+	sgs[num_out + num_in++] = &inhdr;
+	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
+	sgs[num_out + num_in++] = &status;
+
+	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
+}
+
+static inline void virtblk_scsi_reques_done(struct request *req)
+{
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+	struct virtio_blk *vblk = req->q->queuedata;
+	struct scsi_request *sreq = &vbr->sreq;
+
+	sreq->resid_len = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.residual);
+	sreq->sense_len = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.sense_len);
+	req->errors = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.errors);
+}
+
+static int virtblk_ioctl(struct block_device *bdev, fmode_t mode,
+			     unsigned int cmd, unsigned long data)
+{
+	struct gendisk *disk = bdev->bd_disk;
+	struct virtio_blk *vblk = disk->private_data;
 
 	/*
-	 * If this is a packet command we need a couple of additional headers.
-	 * Behind the normal outhdr we put a segment with the scsi command
-	 * block, and before the normal inhdr we put the sense data and the
-	 * inhdr with additional status information.
+	 * Only allow the generic SCSI ioctls if the host can support it.
 	 */
-	if (type == cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_SCSI_CMD)) {
-		sg_init_one(&cmd, vbr->sreq.cmd, vbr->sreq.cmd_len);
-		sgs[num_out++] = &cmd;
-	}
+	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_SCSI))
+		return -ENOTTY;
+
+	return scsi_cmd_blk_ioctl(bdev, mode, cmd,
+				  (void __user *)data);
+}
+#else
+static inline int virtblk_add_req_scsi(struct virtqueue *vq,
+		struct virtblk_req *vbr, struct scatterlist *data_sg,
+		bool have_data)
+{
+	return -EIO;
+}
+static inline void virtblk_scsi_reques_done(struct request *req)
+{
+}
+#define virtblk_ioctl	NULL
+#endif /* CONFIG_VIRTIO_BLK_SCSI */
+
+static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
+		struct scatterlist *data_sg, bool have_data)
+{
+	struct scatterlist hdr, status, *sgs[3];
+	unsigned int num_out = 0, num_in = 0;
+
+	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
+	sgs[num_out++] = &hdr;
 
 	if (have_data) {
 		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
@@ -102,13 +164,6 @@ static int __virtblk_add_req(struct virtqueue *vq,
 			sgs[num_out + num_in++] = data_sg;
 	}
 
-	if (type == cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_SCSI_CMD)) {
-		sg_init_one(&sense, vbr->sense, SCSI_SENSE_BUFFERSIZE);
-		sgs[num_out + num_in++] = &sense;
-		sg_init_one(&inhdr, &vbr->in_hdr, sizeof(vbr->in_hdr));
-		sgs[num_out + num_in++] = &inhdr;
-	}
-
 	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
 	sgs[num_out + num_in++] = &status;
 
@@ -118,17 +173,15 @@ static int __virtblk_add_req(struct virtqueue *vq,
 static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	struct virtio_blk *vblk = req->q->queuedata;
 	int error = virtblk_result(vbr);
 
-	if (req->cmd_type == REQ_TYPE_BLOCK_PC) {
-		scsi_req(req)->resid_len =
-			virtio32_to_cpu(vblk->vdev, vbr->in_hdr.residual);
-		vbr->sreq.sense_len =
-			virtio32_to_cpu(vblk->vdev, vbr->in_hdr.sense_len);
-		req->errors = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.errors);
-	} else if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
+	switch (req->cmd_type) {
+	case REQ_TYPE_BLOCK_PC:
+		virtblk_scsi_reques_done(req);
+		break;
+	case REQ_TYPE_DRV_PRIV:
 		req->errors = (error != 0);
+		break;
 	}
 
 	blk_mq_end_request(req, error);
@@ -214,7 +267,10 @@ static int virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
-	err = __virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
+	if (req->cmd_type == REQ_TYPE_BLOCK_PC)
+		err = virtblk_add_req_scsi(vblk->vqs[qid].vq, vbr, vbr->sg, num);
+	else
+		err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
 		blk_mq_stop_hw_queue(hctx);
@@ -259,22 +315,6 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
 	return err;
 }
 
-static int virtblk_ioctl(struct block_device *bdev, fmode_t mode,
-			     unsigned int cmd, unsigned long data)
-{
-	struct gendisk *disk = bdev->bd_disk;
-	struct virtio_blk *vblk = disk->private_data;
-
-	/*
-	 * Only allow the generic SCSI ioctls if the host can support it.
-	 */
-	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_SCSI))
-		return -ENOTTY;
-
-	return scsi_cmd_blk_ioctl(bdev, mode, cmd,
-				  (void __user *)data);
-}
-
 /* We provide getgeo only to please some old bootloader/partitioning tools */
 static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 {
@@ -540,7 +580,9 @@ static int virtblk_init_request(void *data, struct request *rq,
 	struct virtio_blk *vblk = data;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
 
+#ifdef CONFIG_VIRTIO_BLK_SCSI
 	vbr->sreq.sense = vbr->sense;
+#endif
 	sg_init_table(vbr->sg, vblk->sg_elems);
 	return 0;
 }
@@ -824,7 +866,10 @@ static const struct virtio_device_id id_table[] = {
 
 static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
-	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE, VIRTIO_BLK_F_SCSI,
+	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
+#ifdef CONFIG_VIRTIO_BLK_SCSI
+	VIRTIO_BLK_F_SCSI,
+#endif
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ,
 }
-- 
2.1.4

