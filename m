Return-Path: <BATV+7c9ed557eb952ccf5513+4914+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: axboe@kernel.dk,
	pbonzini@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] virtio_blk: use virtio IRQ affinity
Date: Sun,  5 Feb 2017 18:15:25 +0100
Message-Id: <20170205171526.6224-9-hch@lst.de>
In-Reply-To: <20170205171526.6224-1-hch@lst.de>
References: <20170205171526.6224-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Use automatic IRQ affinity assignment in the virtio layer if available,
and build the blk-mq queues based on it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c54118bdc67d..1028dfeb5a7f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -5,6 +5,7 @@
 #include <linux/hdreg.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/interrupt.h>
 #include <linux/virtio.h>
 #include <linux/virtio_blk.h>
 #include <linux/scatterlist.h>
@@ -12,6 +13,7 @@
 #include <scsi/scsi_cmnd.h>
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-mq-virtio.h>
 #include <linux/numa.h>
 
 #define PART_BITS 4
@@ -385,6 +387,7 @@ static int init_vq(struct virtio_blk *vblk)
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	struct virtio_device *vdev = vblk->vdev;
+	struct irq_affinity desc = { 0, };
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
@@ -412,7 +415,7 @@ static int init_vq(struct virtio_blk *vblk)
 
 	/* Discover virtqueues and write information to configuration.  */
 	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names,
-			NULL);
+			&desc);
 	if (err)
 		goto out;
 
@@ -543,10 +546,18 @@ static int virtblk_init_request(void *data, struct request *rq,
 	return 0;
 }
 
+static int virtblk_map_queues(struct blk_mq_tag_set *set)
+{
+	struct virtio_blk *vblk = set->driver_data;
+
+	return blk_mq_virtio_map_queues(set, vblk->vdev, 0);
+}
+
 static struct blk_mq_ops virtio_mq_ops = {
 	.queue_rq	= virtio_queue_rq,
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
+	.map_queues	= virtblk_map_queues,
 };
 
 static unsigned int virtblk_queue_depth;
-- 
2.11.0
