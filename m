Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] virtio_blk: Fix an SG_IO regression
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "dann.frazier@canonical.com" <dann.frazier@canonical.com>
References: <20171025095617.7315-1-bart.vanassche@wdc.com>
 <11a35a46-dc51-c32f-cb64-793d9dd02c53@kernel.dk>
 <1508959556.5073.1.camel@wdc.com>
 <83926138-e6aa-6792-5275-31f5c1330c90@kernel.dk>
 <20171025193752.GA6164@lst.de> <1508992426.8734.3.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <c0e0aad4-3e79-998d-08b9-c0f26f9b9035@kernel.dk>
Date: Wed, 25 Oct 2017 21:38:38 -0700
MIME-Version: 1.0
In-Reply-To: <1508992426.8734.3.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/25/2017 09:33 PM, Bart Van Assche wrote:
> On Wed, 2017-10-25 at 21:37 +0200, hch@lst.de wrote:
>> Honestly I think the right fix is to just kill the SCSI passthrough
>> in virtio.  It has been replaced by virtio-scsi a long time ago, and
>> has been disabled by default in qemu for a long time (and I don't
>> think any other hypervisor ever supported it).
>>
>> It should never have been added (saying that as the person who added
>> it).
> 
> Hello Christoph,
> 
> Sorry but I'm not familiar enough with the virtio_blk driver to do that
> removal myself. Since the patch at the start of this e-mail thread has
> a "Cc: stable" tag, can you submit such a patch after this patch went
> in?

Something like the below. But yes, we should probably get the simple fix
in, then kill it after, since the fix is targeting stable and the
current series.

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 2dfe99b328f8..9fac2b724577 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -446,16 +446,6 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
-config VIRTIO_BLK_SCSI
-	bool "SCSI passthrough request for the Virtio block driver"
-	depends on VIRTIO_BLK
-	select BLK_SCSI_REQUEST
-	---help---
-	  Enable support for SCSI passthrough (e.g. the SG_IO ioctl) on
-	  virtio-blk devices.  This is only supported for the legacy
-	  virtio protocol and not enabled by default by any hypervisor.
-	  You probably want to use virtio-scsi instead.
-
 config BLK_DEV_RBD
 	tristate "Rados block device (RBD)"
 	depends on INET && BLOCK
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 34e17ee799be..1764df4f1c60 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -10,7 +10,6 @@
 #include <linux/virtio_blk.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
-#include <scsi/scsi_cmnd.h>
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-virtio.h>
@@ -54,11 +53,6 @@ struct virtio_blk {
 };
 
 struct virtblk_req {
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	struct scsi_request sreq;	/* for SCSI passthrough, must be first */
-	u8 sense[SCSI_SENSE_BUFFERSIZE];
-	struct virtio_scsi_inhdr in_hdr;
-#endif
 	struct virtio_blk_outhdr out_hdr;
 	u8 status;
 	struct scatterlist sg[];
@@ -76,80 +70,6 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
 	}
 }
 
-/*
- * If this is a packet command we need a couple of additional headers.  Behind
- * the normal outhdr we put a segment with the scsi command block, and before
- * the normal inhdr we put the sense data and the inhdr with additional status
- * information.
- */
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-static int virtblk_add_req_scsi(struct virtqueue *vq, struct virtblk_req *vbr,
-		struct scatterlist *data_sg, bool have_data)
-{
-	struct scatterlist hdr, status, cmd, sense, inhdr, *sgs[6];
-	unsigned int num_out = 0, num_in = 0;
-
-	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
-	sgs[num_out++] = &hdr;
-	sg_init_one(&cmd, vbr->sreq.cmd, vbr->sreq.cmd_len);
-	sgs[num_out++] = &cmd;
-
-	if (have_data) {
-		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
-			sgs[num_out++] = data_sg;
-		else
-			sgs[num_out + num_in++] = data_sg;
-	}
-
-	sg_init_one(&sense, vbr->sense, SCSI_SENSE_BUFFERSIZE);
-	sgs[num_out + num_in++] = &sense;
-	sg_init_one(&inhdr, &vbr->in_hdr, sizeof(vbr->in_hdr));
-	sgs[num_out + num_in++] = &inhdr;
-	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
-	sgs[num_out + num_in++] = &status;
-
-	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
-}
-
-static inline void virtblk_scsi_request_done(struct request *req)
-{
-	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-	struct virtio_blk *vblk = req->q->queuedata;
-	struct scsi_request *sreq = &vbr->sreq;
-
-	sreq->resid_len = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.residual);
-	sreq->sense_len = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.sense_len);
-	sreq->result = virtio32_to_cpu(vblk->vdev, vbr->in_hdr.errors);
-}
-
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
-#else
-static inline int virtblk_add_req_scsi(struct virtqueue *vq,
-		struct virtblk_req *vbr, struct scatterlist *data_sg,
-		bool have_data)
-{
-	return -EIO;
-}
-static inline void virtblk_scsi_request_done(struct request *req)
-{
-}
-#define virtblk_ioctl	NULL
-#endif /* CONFIG_VIRTIO_BLK_SCSI */
-
 static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr,
 		struct scatterlist *data_sg, bool have_data)
 {
@@ -176,13 +96,6 @@ static inline void virtblk_request_done(struct request *req)
 {
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 
-	switch (req_op(req)) {
-	case REQ_OP_SCSI_IN:
-	case REQ_OP_SCSI_OUT:
-		virtblk_scsi_request_done(req);
-		break;
-	}
-
 	blk_mq_end_request(req, virtblk_result(vbr));
 }
 
@@ -237,10 +150,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case REQ_OP_FLUSH:
 		type = VIRTIO_BLK_T_FLUSH;
 		break;
-	case REQ_OP_SCSI_IN:
-	case REQ_OP_SCSI_OUT:
-		type = VIRTIO_BLK_T_SCSI_CMD;
-		break;
 	case REQ_OP_DRV_IN:
 		type = VIRTIO_BLK_T_GET_ID;
 		break;
@@ -265,10 +174,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
-	if (blk_rq_is_scsi(req))
-		err = virtblk_add_req_scsi(vblk->vqs[qid].vq, vbr, vbr->sg, num);
-	else
-		err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
+	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
 		blk_mq_stop_hw_queue(hctx);
@@ -336,7 +242,6 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 }
 
 static const struct block_device_operations virtblk_fops = {
-	.ioctl  = virtblk_ioctl,
 	.owner  = THIS_MODULE,
 	.getgeo = virtblk_getgeo,
 };
@@ -579,9 +484,6 @@ static int virtblk_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	struct virtio_blk *vblk = set->driver_data;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
 
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	vbr->sreq.sense = vbr->sense;
-#endif
 	sg_init_table(vbr->sg, vblk->sg_elems);
 	return 0;
 }
@@ -871,9 +773,6 @@ static const struct virtio_device_id id_table[] = {
 static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	VIRTIO_BLK_F_SCSI,
-#endif
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ,
 }

-- 
Jens Axboe
