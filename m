Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdGNXS1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 19:18:27 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/6] block: use BLK_MQ_F_AUTO_RESTART on virtio-blk and xen-blkfront
Date: Sat, 15 Jul 2017 07:16:00 +0800
Message-Id: <20170714231601.14444-6-ming.lei@redhat.com>
In-Reply-To: <20170714231601.14444-1-ming.lei@redhat.com>
References: <20170714231601.14444-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now blk-mq implements such function via BLK_MQ_F_AUTO_RESTART,
so just use that and remove related code in virtio-blk and xen-blkfront.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/virtio_blk.c   |  8 +-------
 drivers/block/xen-blkfront.c | 15 ++-------------
 2 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4e02aa5fdac0..3ab630e91306 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -189,7 +189,6 @@ static inline void virtblk_request_done(struct request *req)
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
-	bool req_done = false;
 	int qid = vq->index;
 	struct virtblk_req *vbr;
 	unsigned long flags;
@@ -202,15 +201,11 @@ static void virtblk_done(struct virtqueue *vq)
 			struct request *req = blk_mq_rq_from_pdu(vbr);
 
 			blk_mq_complete_request(req);
-			req_done = true;
 		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
 
-	/* In case queue is stopped waiting for more buffers. */
-	if (req_done)
-		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
 	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
@@ -271,7 +266,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
-		blk_mq_stop_hw_queue(hctx);
 		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 		/* Out of mem doesn't actually happen, since we fall back
 		 * to direct descriptors */
@@ -670,7 +664,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	vblk->tag_set.ops = &virtio_mq_ops;
 	vblk->tag_set.queue_depth = virtblk_queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
-	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_AUTO_RESTART;
 	vblk->tag_set.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * sg_elems;
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 1578befda635..d80f867ffc3f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -907,7 +907,6 @@ static blk_status_t blkif_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 out_busy:
 	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
-	blk_mq_stop_hw_queue(hctx);
 	return BLK_STS_RESOURCE;
 }
 
@@ -975,7 +974,8 @@ static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
 	} else
 		info->tag_set.queue_depth = BLK_RING_SIZE(info);
 	info->tag_set.numa_node = NUMA_NO_NODE;
-	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
+	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE |
+		BLK_MQ_F_AUTO_RESTART;
 	info->tag_set.cmd_size = sizeof(struct blkif_req);
 	info->tag_set.driver_data = info;
 
@@ -1213,15 +1213,6 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 	info->gd = NULL;
 }
 
-/* Already hold rinfo->ring_lock. */
-static inline void kick_pending_request_queues_locked(struct blkfront_ring_info *rinfo)
-{
-	if (!RING_FULL(&rinfo->ring)) {
-		blk_mq_start_stopped_hw_queues(rinfo->dev_info->rq, true);
-		blk_mq_kick_requeue_list(rinfo->dev_info->rq);
-	}
-}
-
 static void kick_pending_request_queues(struct blkfront_ring_info *rinfo)
 {
 	unsigned long flags;
@@ -1659,8 +1650,6 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 	} else
 		rinfo->ring.sring->rsp_event = i + 1;
 
-	kick_pending_request_queues_locked(rinfo);
-
 	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
 
 	return IRQ_HANDLED;
-- 
2.9.4
