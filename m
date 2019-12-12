Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2EC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 16:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34162173E
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 16:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N/Dt6YXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbfLLQh2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:37:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbfLLQh2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 11:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2Jz6taz35JZegkKFQERoTLypJxH/c8Nr8d7W3QSRKDE=; b=N/Dt6YXPRT7NcUkjKnjgqq0OS
        vwGJBFdgvYrnpOIF/wuehpr834OyUN6bzI9QriM26xkIa+cuiHw/jlRSDG5i2Tme5c+i75m3y3aeE
        Tk+04yBRI1G5Bwv46ymqEXqAL7/nuYKUu2YJrpB5RdrPSStM7PE0tb08DXTV5cXnV5YYGLL5IzAmi
        eCK7vT1Kky5W+BDsbkWHSUNIJyzEsyq5vt4CxYW1E459rRl8Qax0sbbDtz3/4hNipXA0IQsuEm1v/
        LnRHVWUGyVqNFcu3vAZsq83ay0hSi0/Agw+ge0bJ5HjmyzG1fcB077bzWiygSKneAqWR/WGVc9+de
        2MbRS71bw==;
Received: from [2001:4bb8:188:2b00:20e6:8b5a:ed96:f9da] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifRSt-0008Bp-RL; Thu, 12 Dec 2019 16:37:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        pbonzini@redhat.com, stefanha@redhat.com
Cc:     linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio-blk: remove VIRTIO_BLK_F_SCSI support
Date:   Thu, 12 Dec 2019 17:37:19 +0100
Message-Id: <20191212163719.28432-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the need for a special flag to support SCSI passthrough on a
block device was added in May 2017 the SCSI passthrough support in
virtio-blk has been disabled.  It has always been a bad idea
(just ask the original author..) and we have virtio-scsi for proper
passthrough.  The feature also never made it into the virtio 1.0
or later specifications.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/configs/guest.config |   1 -
 drivers/block/Kconfig             |  10 ---
 drivers/block/virtio_blk.c        | 115 +-----------------------------
 3 files changed, 1 insertion(+), 125 deletions(-)

diff --git a/arch/powerpc/configs/guest.config b/arch/powerpc/configs/guest.config
index 8b8cd18ecd7c..209f58515d88 100644
--- a/arch/powerpc/configs/guest.config
+++ b/arch/powerpc/configs/guest.config
@@ -1,5 +1,4 @@
 CONFIG_VIRTIO_BLK=y
-CONFIG_VIRTIO_BLK_SCSI=y
 CONFIG_SCSI_VIRTIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_NET_FAILOVER=y
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1bb8ec575352..025b1b77b11a 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -432,16 +432,6 @@ config VIRTIO_BLK
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
index 7ffd719d89de..54158766334b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -11,7 +11,6 @@
 #include <linux/virtio_blk.h>
 #include <linux/scatterlist.h>
 #include <linux/string_helpers.h>
-#include <scsi/scsi_cmnd.h>
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-virtio.h>
@@ -56,11 +55,6 @@ struct virtio_blk {
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
@@ -78,80 +72,6 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
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
@@ -216,13 +136,6 @@ static inline void virtblk_request_done(struct request *req)
 		      req->special_vec.bv_offset);
 	}
 
-	switch (req_op(req)) {
-	case REQ_OP_SCSI_IN:
-	case REQ_OP_SCSI_OUT:
-		virtblk_scsi_request_done(req);
-		break;
-	}
-
 	blk_mq_end_request(req, virtblk_result(vbr));
 }
 
@@ -299,10 +212,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		type = VIRTIO_BLK_T_WRITE_ZEROES;
 		unmap = !(req->cmd_flags & REQ_NOUNMAP);
 		break;
-	case REQ_OP_SCSI_IN:
-	case REQ_OP_SCSI_OUT:
-		type = VIRTIO_BLK_T_SCSI_CMD;
-		break;
 	case REQ_OP_DRV_IN:
 		type = VIRTIO_BLK_T_GET_ID;
 		break;
@@ -333,10 +242,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
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
@@ -404,7 +310,6 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
 }
 
 static const struct block_device_operations virtblk_fops = {
-	.ioctl  = virtblk_ioctl,
 	.owner  = THIS_MODULE,
 	.getgeo = virtblk_getgeo,
 };
@@ -683,9 +588,6 @@ static int virtblk_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	struct virtio_blk *vblk = set->driver_data;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
 
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	vbr->sreq.sense = vbr->sense;
-#endif
 	sg_init_table(vbr->sg, vblk->sg_elems);
 	return 0;
 }
@@ -698,23 +600,11 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
 					vblk->vdev, 0);
 }
 
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-static void virtblk_initialize_rq(struct request *req)
-{
-	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
-
-	scsi_req_init(&vbr->sreq);
-}
-#endif
-
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.commit_rqs	= virtio_commit_rqs,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	.initialize_rq_fn = virtblk_initialize_rq,
-#endif
 	.map_queues	= virtblk_map_queues,
 };
 
@@ -991,9 +881,6 @@ static const struct virtio_device_id id_table[] = {
 static unsigned int features_legacy[] = {
 	VIRTIO_BLK_F_SEG_MAX, VIRTIO_BLK_F_SIZE_MAX, VIRTIO_BLK_F_GEOMETRY,
 	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
-#ifdef CONFIG_VIRTIO_BLK_SCSI
-	VIRTIO_BLK_F_SCSI,
-#endif
 	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
 	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
 }
-- 
2.20.1

