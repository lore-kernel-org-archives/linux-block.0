Return-Path: <bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Dann Frazier <dann.frazier@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] virtio_blk: Fix an SG_IO regression
Date: Thu, 26 Oct 2017 07:30:30 +0200
Message-Id: <20171026053030.12456-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Avoid that submitting an SG_IO ioctl triggers a kernel oops that
is preceded by:

usercopy: kernel memory overwrite attempt detected to (null) (<null>) (6 bytes)
kernel BUG at mm/usercopy.c:72!

Reported-by: Dann Frazier <dann.frazier@canonical.com>
Fixes: commit ca18d6f769d2 ("block: Make most scsi_req_init() calls implicit")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Dann Frazier <dann.frazier@canonical.com>
Cc: <stable@vger.kernel.org> # v4.13
---
 drivers/block/virtio_blk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 34e17ee799be..b44f5b7e68f6 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -593,10 +593,18 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
 	return blk_mq_virtio_map_queues(set, vblk->vdev, 0);
 }
 
+static void virtblk_initialize_rq(struct request *req)
+{
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
+
+	scsi_req_init(&vbr->sreq);
+}
+
 static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
+	.initialize_rq_fn = virtblk_initialize_rq,
 	.map_queues	= virtblk_map_queues,
 };
 
-- 
2.14.2
