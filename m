Return-Path: <bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Dann Frazier <dann.frazier@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] virtio_blk: Fix an SG_IO regression
Date: Wed, 25 Oct 2017 11:56:17 +0200
Message-Id: <20171025095617.7315-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Avoid that submitting an SG_IO ioctl triggers a kernel oops that
is preceded by:

usercopy: kernel memory overwrite attempt detected to (null) (<null>) (6 bytes)
kernel BUG at mm/usercopy.c:72!

Reported-by: Dann Frazier <dann.frazier@canonical.com>
Fixes: commit ca18d6f769d2 ("block: Make most scsi_req_init() calls implicit")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Tested-by: Dann Frazier <dann.frazier@canonical.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Dann Frazier <dann.frazier@canonical.com>
Cc: <stable@vger.kernel.org> # v4.13
---
 drivers/block/Kconfig      | 1 +
 drivers/block/virtio_blk.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 4a438b8abe27..b0b2100763bf 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -450,6 +450,7 @@ config VIRTIO_BLK_SCSI
 	bool "SCSI passthrough request for the Virtio block driver"
 	depends on VIRTIO_BLK
 	select BLK_SCSI_REQUEST
+	select SCSI_MOD
 	---help---
 	  Enable support for SCSI passthrough (e.g. the SG_IO ioctl) on
 	  virtio-blk devices.  This is only supported for the legacy
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 34e17ee799be..15e11a519801 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -597,6 +597,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
+	.initialize_rq_fn = scsi_initialize_rq,
 	.map_queues	= virtblk_map_queues,
 };
 
-- 
2.14.2
