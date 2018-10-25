Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	David Miller <davem@davemloft.net>
Subject: [PATCH 01/28] sunvdc: convert to blk-mq
Date: Thu, 25 Oct 2018 15:10:12 -0600
Message-Id: <20181025211039.11559-2-axboe@kernel.dk>
In-Reply-To: <20181025211039.11559-1-axboe@kernel.dk>
References: <20181025211039.11559-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Convert from the old request_fn style driver to blk-mq.

Cc: David Miller <davem@davemloft.net>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/sunvdc.c | 149 +++++++++++++++++++++++++++--------------
 1 file changed, 98 insertions(+), 51 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index b54fa6726303..95cb4ea8e402 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -6,7 +6,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/hdreg.h>
 #include <linux/genhd.h>
 #include <linux/cdrom.h>
@@ -66,9 +66,10 @@ struct vdc_port {
 
 	u64			max_xfer_size;
 	u32			vdisk_block_size;
+	u32			drain;
 
 	u64			ldc_timeout;
-	struct timer_list	ldc_reset_timer;
+	struct delayed_work	ldc_reset_timer_work;
 	struct work_struct	ldc_reset_work;
 
 	/* The server fills these in for us in the disk attribute
@@ -80,12 +81,14 @@ struct vdc_port {
 	u8			vdisk_mtype;
 	u32			vdisk_phys_blksz;
 
+	struct blk_mq_tag_set	tag_set;
+
 	char			disk_name[32];
 };
 
 static void vdc_ldc_reset(struct vdc_port *port);
 static void vdc_ldc_reset_work(struct work_struct *work);
-static void vdc_ldc_reset_timer(struct timer_list *t);
+static void vdc_ldc_reset_timer_work(struct work_struct *work);
 
 static inline struct vdc_port *to_vdc_port(struct vio_driver_state *vio)
 {
@@ -175,11 +178,8 @@ static void vdc_blk_queue_start(struct vdc_port *port)
 	 * handshake completes, so check for initial handshake before we've
 	 * allocated a disk.
 	 */
-	if (port->disk && blk_queue_stopped(port->disk->queue) &&
-	    vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50) {
-		blk_start_queue(port->disk->queue);
-	}
-
+	if (port->disk && vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
+		blk_mq_start_hw_queues(port->disk->queue);
 }
 
 static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)
@@ -197,7 +197,7 @@ static void vdc_handshake_complete(struct vio_driver_state *vio)
 {
 	struct vdc_port *port = to_vdc_port(vio);
 
-	del_timer(&port->ldc_reset_timer);
+	cancel_delayed_work(&port->ldc_reset_timer_work);
 	vdc_finish(vio, 0, WAITING_FOR_LINK_UP);
 	vdc_blk_queue_start(port);
 }
@@ -320,7 +320,7 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
 
 	rqe->req = NULL;
 
-	__blk_end_request(req, (desc->status ? BLK_STS_IOERR : 0), desc->size);
+	blk_mq_end_request(req, desc->status ? BLK_STS_IOERR : 0);
 
 	vdc_blk_queue_start(port);
 }
@@ -525,29 +525,40 @@ static int __send_request(struct request *req)
 	return err;
 }
 
-static void do_vdc_request(struct request_queue *rq)
+static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd)
 {
-	struct request *req;
+	struct vdc_port *port = hctx->queue->queuedata;
+	struct vio_dring_state *dr;
+	unsigned long flags;
 
-	while ((req = blk_peek_request(rq)) != NULL) {
-		struct vdc_port *port;
-		struct vio_dring_state *dr;
+	dr = &port->vio.drings[VIO_DRIVER_TX_RING];
 
-		port = req->rq_disk->private_data;
-		dr = &port->vio.drings[VIO_DRIVER_TX_RING];
-		if (unlikely(vdc_tx_dring_avail(dr) < 1))
-			goto wait;
+	blk_mq_start_request(bd->rq);
 
-		blk_start_request(req);
+	spin_lock_irqsave(&port->vio.lock, flags);
 
-		if (__send_request(req) < 0) {
-			blk_requeue_request(rq, req);
-wait:
-			/* Avoid pointless unplugs. */
-			blk_stop_queue(rq);
-			break;
-		}
+	/*
+	 * Doing drain, just end the request in error
+	 */
+	if (unlikely(port->drain)) {
+		spin_unlock_irqrestore(&port->vio.lock, flags);
+		return BLK_STS_IOERR;
 	}
+
+	if (unlikely(vdc_tx_dring_avail(dr) < 1)) {
+		spin_unlock_irqrestore(&port->vio.lock, flags);
+		blk_mq_stop_hw_queue(hctx);
+		return BLK_STS_DEV_RESOURCE;
+	}
+
+	if (__send_request(bd->rq) < 0) {
+		spin_unlock_irqrestore(&port->vio.lock, flags);
+		return BLK_STS_IOERR;
+	}
+
+	spin_unlock_irqrestore(&port->vio.lock, flags);
+	return BLK_STS_OK;
 }
 
 static int generic_request(struct vdc_port *port, u8 op, void *buf, int len)
@@ -759,6 +770,32 @@ static void vdc_port_down(struct vdc_port *port)
 	vio_ldc_free(&port->vio);
 }
 
+static const struct blk_mq_ops vdc_mq_ops = {
+	.queue_rq	= vdc_queue_rq,
+};
+
+static void cleanup_queue(struct request_queue *q)
+{
+	struct vdc_port *port = q->queuedata;
+
+	blk_cleanup_queue(q);
+	blk_mq_free_tag_set(&port->tag_set);
+}
+
+static struct request_queue *init_queue(struct vdc_port *port)
+{
+	struct request_queue *q;
+	int ret;
+
+	q = blk_mq_init_sq_queue(&port->tag_set, &vdc_mq_ops, VDC_TX_RING_SIZE,
+					BLK_MQ_F_SHOULD_MERGE);
+	if (IS_ERR(q))
+		return q;
+
+	q->queuedata = port;
+	return q;
+}
+
 static int probe_disk(struct vdc_port *port)
 {
 	struct request_queue *q;
@@ -796,17 +833,17 @@ static int probe_disk(struct vdc_port *port)
 				    (u64)geom.num_sec);
 	}
 
-	q = blk_init_queue(do_vdc_request, &port->vio.lock);
-	if (!q) {
+	q = init_queue(port);
+	if (IS_ERR(q)) {
 		printk(KERN_ERR PFX "%s: Could not allocate queue.\n",
 		       port->vio.name);
-		return -ENOMEM;
+		return PTR_ERR(q);
 	}
 	g = alloc_disk(1 << PARTITION_SHIFT);
 	if (!g) {
 		printk(KERN_ERR PFX "%s: Could not allocate gendisk.\n",
 		       port->vio.name);
-		blk_cleanup_queue(q);
+		cleanup_queue(q);
 		return -ENOMEM;
 	}
 
@@ -981,7 +1018,7 @@ static int vdc_port_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	 */
 	ldc_timeout = mdesc_get_property(hp, vdev->mp, "vdc-timeout", NULL);
 	port->ldc_timeout = ldc_timeout ? *ldc_timeout : 0;
-	timer_setup(&port->ldc_reset_timer, vdc_ldc_reset_timer, 0);
+	INIT_DELAYED_WORK(&port->ldc_reset_timer_work, vdc_ldc_reset_timer_work);
 	INIT_WORK(&port->ldc_reset_work, vdc_ldc_reset_work);
 
 	err = vio_driver_init(&port->vio, vdev, VDEV_DISK,
@@ -1034,18 +1071,14 @@ static int vdc_port_remove(struct vio_dev *vdev)
 	struct vdc_port *port = dev_get_drvdata(&vdev->dev);
 
 	if (port) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&port->vio.lock, flags);
-		blk_stop_queue(port->disk->queue);
-		spin_unlock_irqrestore(&port->vio.lock, flags);
+		blk_mq_stop_hw_queues(port->disk->queue);
 
 		flush_work(&port->ldc_reset_work);
-		del_timer_sync(&port->ldc_reset_timer);
+		cancel_delayed_work_sync(&port->ldc_reset_timer_work);
 		del_timer_sync(&port->vio.timer);
 
 		del_gendisk(port->disk);
-		blk_cleanup_queue(port->disk->queue);
+		cleanup_queue(port->disk->queue);
 		put_disk(port->disk);
 		port->disk = NULL;
 
@@ -1080,32 +1113,46 @@ static void vdc_requeue_inflight(struct vdc_port *port)
 		}
 
 		rqe->req = NULL;
-		blk_requeue_request(port->disk->queue, req);
+		blk_mq_requeue_request(req, false);
 	}
 }
 
 static void vdc_queue_drain(struct vdc_port *port)
 {
-	struct request *req;
+	struct request_queue *q = port->disk->queue;
 
-	while ((req = blk_fetch_request(port->disk->queue)) != NULL)
-		__blk_end_request_all(req, BLK_STS_IOERR);
+	/*
+	 * Mark the queue as draining, then freeze/quiesce to ensure
+	 * that all existing requests are seen in ->queue_rq() and killed
+	 */
+	port->drain = 1;
+	spin_unlock_irq(&port->vio.lock);
+
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+
+	spin_lock_irq(&port->vio.lock);
+	port->drain = 0;
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
 }
 
-static void vdc_ldc_reset_timer(struct timer_list *t)
+static void vdc_ldc_reset_timer_work(struct work_struct *work)
 {
-	struct vdc_port *port = from_timer(port, t, ldc_reset_timer);
-	struct vio_driver_state *vio = &port->vio;
-	unsigned long flags;
+	struct vdc_port *port;
+	struct vio_driver_state *vio;
 
-	spin_lock_irqsave(&vio->lock, flags);
+	port = container_of(work, struct vdc_port, ldc_reset_timer_work.work);
+	vio = &port->vio;
+
+	spin_lock_irq(&vio->lock);
 	if (!(port->vio.hs_state & VIO_HS_COMPLETE)) {
 		pr_warn(PFX "%s ldc down %llu seconds, draining queue\n",
 			port->disk_name, port->ldc_timeout);
 		vdc_queue_drain(port);
 		vdc_blk_queue_start(port);
 	}
-	spin_unlock_irqrestore(&vio->lock, flags);
+	spin_unlock_irq(&vio->lock);
 }
 
 static void vdc_ldc_reset_work(struct work_struct *work)
@@ -1129,7 +1176,7 @@ static void vdc_ldc_reset(struct vdc_port *port)
 	assert_spin_locked(&port->vio.lock);
 
 	pr_warn(PFX "%s ldc link reset\n", port->disk_name);
-	blk_stop_queue(port->disk->queue);
+	blk_mq_stop_hw_queues(port->disk->queue);
 	vdc_requeue_inflight(port);
 	vdc_port_down(port);
 
@@ -1146,7 +1193,7 @@ static void vdc_ldc_reset(struct vdc_port *port)
 	}
 
 	if (port->ldc_timeout)
-		mod_timer(&port->ldc_reset_timer,
+		mod_delayed_work(system_wq, &port->ldc_reset_timer_work,
 			  round_jiffies(jiffies + HZ * port->ldc_timeout));
 	mod_timer(&port->vio.timer, round_jiffies(jiffies + HZ));
 	return;
-- 
2.17.1
