Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Ming Lei <ming.lei@redhat.com>,
	virtio-dev@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 8/8] virtio_blk: quiesce/unquiesce live IO when entering PM states
Date: Wed,  5 Jul 2017 09:53:11 +0300
Message-Id: <1499237591-15861-9-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
References: <1499237591-15861-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Without it its not guaranteed that no .queue_rq is inflight.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/block/virtio_blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0297ad7c1452..4e02aa5fdac0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -840,7 +840,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_stop_hw_queues(vblk->disk->queue);
+	blk_mq_quiesce_queue(vblk->disk->queue);
 
 	vdev->config->del_vqs(vdev);
 	return 0;
@@ -857,7 +857,7 @@ static int virtblk_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
-	blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
+	blk_mq_unquiesce_queue(vblk->disk->queue);
 	return 0;
 }
 #endif
-- 
2.7.4
