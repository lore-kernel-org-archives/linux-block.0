Return-Path: <BATV+571a12579731380ce5cc+4882+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	mst@redhat.com,
	jasowang@redhat.com
Cc: linux-block@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_blk: avoid DMA to stack for the sense buffer
Date: Wed,  4 Jan 2017 08:25:05 +0300
Message-Id: <1483507505-26797-2-git-send-email-hch@lst.de>
In-Reply-To: <1483507505-26797-1-git-send-email-hch@lst.de>
References: <1483507505-26797-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Most users of BLOCK_PC requests allocate the sense buffer on the stack,
so to avoid DMA to the stack copy them to a field in the heap allocated
virtblk_req structure.  Without that any attempt at SCSI passthrough I/O,
including the SG_IO ioctl from userspace will crash the kernel.  Note that
this includes running tools like hdparm even when the host does not have
SCSI passthrough enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5545a67..3c3b8f6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -56,6 +56,7 @@ struct virtblk_req {
 	struct virtio_blk_outhdr out_hdr;
 	struct virtio_scsi_inhdr in_hdr;
 	u8 status;
+	u8 sense[SCSI_SENSE_BUFFERSIZE];
 	struct scatterlist sg[];
 };
 
@@ -102,7 +103,8 @@ static int __virtblk_add_req(struct virtqueue *vq,
 	}
 
 	if (type == cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_SCSI_CMD)) {
-		sg_init_one(&sense, vbr->req->sense, SCSI_SENSE_BUFFERSIZE);
+		memcpy(vbr->sense, vbr->req->sense, SCSI_SENSE_BUFFERSIZE);
+		sg_init_one(&sense, vbr->sense, SCSI_SENSE_BUFFERSIZE);
 		sgs[num_out + num_in++] = &sense;
 		sg_init_one(&inhdr, &vbr->in_hdr, sizeof(vbr->in_hdr));
 		sgs[num_out + num_in++] = &inhdr;
-- 
2.1.4
