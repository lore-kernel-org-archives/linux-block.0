Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756377AbdGKSWa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jul 2017 14:22:30 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/6] blk-mq: introduce basic congestion control
Date: Wed, 12 Jul 2017 02:21:02 +0800
Message-Id: <20170711182103.11461-6-ming.lei@redhat.com>
In-Reply-To: <20170711182103.11461-1-ming.lei@redhat.com>
References: <20170711182103.11461-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Now we have removed all usage of start/stop queue except
for the case BLK_STS_RESOURCE.

This patch implements basic congestion control so that
we can stop queue when congestion is detected. After the
congestion condition becomes invalid, restart the queue
again. The congestion threshold is introduced in last
patch, and if queue depth is bigger than this threshold,
this patch considers it is a congestion.

There are at least two advantage to do congestion control:

- avoid to waste CPU to dispatch rq to hardware/driver when
it might be busy

- avoid to let drivers handle this, so we can cleanup drivers
and unexport interfaces of restart/stop queue, which have casued
enough trouble already

One simple sequential read test(libaio, bs:4k, direct io, queue
depth:64, 8 jobs) on virtio-scsi shows that:
	- CPU utilization decreases ~20%
	- IOPS increases by ~10%

With this congestion control approach in blk-mq framework, we
can remove the handling in drivers. Actually the handling in
drivers isn't good enough too, such as:

	- virtio-blk/xen blk_front stops queue if one rq can't
	be handled, and restart the queue again if one request
	is completed, this way may cause trouble to dispatch
	request at batch, and make queue stop/restart too
	frequent

	- virtio-scsi won't stop queue, and just delay handling
	new requests after some delay in this case, this way wastes
	CPU and may affect both latency and throughput

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c               | 31 +++++++++++++++++++++++++++++++
 drivers/block/virtio_blk.c   |  7 -------
 drivers/block/xen-blkfront.c | 12 ------------
 drivers/md/dm-rq.c           |  1 -
 drivers/nvme/host/fc.c       |  4 ----
 drivers/scsi/scsi_lib.c      |  3 ---
 6 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index da50c187c508..d994449c154b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -416,6 +416,29 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+static void blk_mq_update_req_complete(struct blk_mq_hw_ctx *hctx)
+{
+	struct sbitmap_queue *sbq;
+	unsigned threshold, depth;
+
+	if (!blk_mq_hctx_stopped(hctx))
+		return;
+
+	sbq = &hctx->tags->bitmap_tags;
+	depth = sbitmap_weight(&sbq->sb);
+	threshold = READ_ONCE(hctx->avg_busy_threshold);
+
+	/*
+	 * TODO: replace the 1/8 hardcode window with one
+	 * intelligent way, such as exponential backoff
+	 */
+	if ((depth < threshold) &&
+			(threshold - depth) >= (threshold >> 3)) {
+		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+		blk_mq_run_hw_queue(hctx, true);
+	}
+}
+
 void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -447,6 +470,8 @@ void blk_mq_free_request(struct request *rq)
 		blk_mq_put_tag(hctx, hctx->sched_tags, ctx, sched_tag);
 	blk_mq_sched_restart(hctx);
 	blk_queue_exit(q);
+
+	blk_mq_update_req_complete(hctx);
 }
 EXPORT_SYMBOL_GPL(blk_mq_free_request);
 
@@ -986,6 +1011,12 @@ static void blk_mq_update_req_dispatch_busy(struct blk_mq_hw_ctx *hctx)
 
 	/* use EWMA to estimate a threshold for detecting congestion */
 	ewma_add(hctx->avg_busy_threshold, depth, 8, 0);
+
+	if (blk_mq_hctx_stopped(hctx))
+		return;
+
+	if (depth >= hctx->avg_busy_threshold)
+		set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
 
 bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list)
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 4e02aa5fdac0..8014017f7f69 100644
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
@@ -202,15 +201,10 @@ static void virtblk_done(struct virtqueue *vq)
 			struct request *req = blk_mq_rq_from_pdu(vbr);
 
 			blk_mq_complete_request(req);
-			req_done = true;
 		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
-
-	/* In case queue is stopped waiting for more buffers. */
-	if (req_done)
-		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
 	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
@@ -271,7 +265,6 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
 	if (err) {
 		virtqueue_kick(vblk->vqs[qid].vq);
-		blk_mq_stop_hw_queue(hctx);
 		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 		/* Out of mem doesn't actually happen, since we fall back
 		 * to direct descriptors */
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 1578befda635..9893abac4e0f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -907,7 +907,6 @@ static blk_status_t blkif_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 out_busy:
 	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
-	blk_mq_stop_hw_queue(hctx);
 	return BLK_STS_RESOURCE;
 }
 
@@ -1213,15 +1212,6 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
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
@@ -1659,8 +1649,6 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 	} else
 		rinfo->ring.sring->rsp_event = i + 1;
 
-	kick_pending_request_queues_locked(rinfo);
-
 	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
 
 	return IRQ_HANDLED;
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index c6ebc5b1e00e..71422cea1c4a 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -761,7 +761,6 @@ static blk_status_t dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		/* Undo dm_start_request() before requeuing */
 		rq_end_stats(md, rq);
 		rq_completed(md, rq_data_dir(rq), false);
-		blk_mq_delay_run_hw_queue(hctx, 100/*ms*/);
 		return BLK_STS_RESOURCE;
 	}
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a8d06aa09660..cc8c68dd6c9b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1970,10 +1970,6 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		if (ret != -EBUSY)
 			return BLK_STS_IOERR;
 
-		if (op->rq) {
-			blk_mq_stop_hw_queues(op->rq->q);
-			blk_mq_delay_queue(queue->hctx, NVMEFC_QUEUE_DELAY);
-		}
 		return BLK_STS_RESOURCE;
 	}
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 91d890356b78..ac030c64fa5f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1976,9 +1976,6 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	case BLK_STS_OK:
 		break;
 	case BLK_STS_RESOURCE:
-		if (atomic_read(&sdev->device_busy) == 0 &&
-		    !scsi_device_blocked(sdev))
-			blk_mq_delay_run_hw_queue(hctx, SCSI_QUEUE_DELAY);
 		break;
 	default:
 		/*
-- 
2.9.4
