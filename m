Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH sparc-next] sunvdc: Remove VLA usage
To: David Miller <davem@davemloft.net>, keescook@chromium.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org
References: <20181008154651.GA36881@beast>
 <20181008.111046.1103300226053324861.davem@davemloft.net>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <92c2b11c-acc5-4c7a-387f-19e2ecebe782@kernel.dk>
Date: Mon, 8 Oct 2018 13:16:28 -0600
MIME-Version: 1.0
In-Reply-To: <20181008.111046.1103300226053324861.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/8/18 12:10 PM, David Miller wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Mon, 8 Oct 2018 08:46:51 -0700
> 
>> In the quest to remove all stack VLA usage from the kernel[1], this moves
>> the math for cookies calculation into macros and allocates a fixed size
>> array for the maximum number of cookies and adds a runtime sanity check.
>> (Note that the size was always fixed, but just hidden from the compiler.)
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: linux-block@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Applied.

FWIW, you can add my reviewed-by if you haven't already queued it up.

On the topic of vdc, do you have a way to test it? I converted it to
use blk-mq, to make some progress on killing the legacy IO path.
See below, would be great if someone was able to test this...


diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index f68e9baffad7..cb70d835475c 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/scatterlist.h>
+#include <linux/blk-mq.h>
 
 #include <asm/vio.h>
 #include <asm/ldc.h>
@@ -66,6 +67,7 @@ struct vdc_port {
 
 	u64			max_xfer_size;
 	u32			vdisk_block_size;
+	u32			drain;
 
 	u64			ldc_timeout;
 	struct timer_list	ldc_reset_timer;
@@ -80,6 +82,8 @@ struct vdc_port {
 	u8			vdisk_mtype;
 	u32			vdisk_phys_blksz;
 
+	struct blk_mq_tag_set	tag_set;
+
 	char			disk_name[32];
 };
 
@@ -175,11 +179,8 @@ static void vdc_blk_queue_start(struct vdc_port *port)
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
@@ -320,7 +321,7 @@ static void vdc_end_one(struct vdc_port *port, struct vio_dring_state *dr,
 
 	rqe->req = NULL;
 
-	__blk_end_request(req, (desc->status ? BLK_STS_IOERR : 0), desc->size);
+	blk_mq_end_request(req, desc->status ? BLK_STS_IOERR : 0);
 
 	vdc_blk_queue_start(port);
 }
@@ -525,29 +526,41 @@ static int __send_request(struct request *req)
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
+	if (unlikely(vdc_tx_dring_avail(dr) < 1))
+		goto wait;
+
+	if (__send_request(bd->rq) < 0) {
+		blk_mq_requeue_request(bd->rq, false);
+		goto wait;
+	}
+
+	spin_unlock_irqrestore(&port->vio.lock, flags);
+	return BLK_STS_OK;
+wait:
+	spin_unlock_irqrestore(&port->vio.lock, flags);
+	blk_mq_stop_hw_queue(hctx);
+	return BLK_STS_RESOURCE;
 }
 
 static int generic_request(struct vdc_port *port, u8 op, void *buf, int len)
@@ -759,6 +772,43 @@ static void vdc_port_down(struct vdc_port *port)
 	vio_ldc_free(&port->vio);
 }
 
+static const struct blk_mq_ops vdc_mq_ops = {
+	.queue_rq	= vdc_queue_rq,
+};
+
+static void cleanup_queue(struct request_queue *q)
+{
+	blk_mq_free_tag_set(q->tag_set);
+	blk_cleanup_queue(q);
+}
+
+static struct request_queue *init_queue(struct vdc_port *port)
+{
+	struct blk_mq_tag_set *set = &port->tag_set;
+	struct request_queue *q;
+	int ret;
+
+	memset(set, 0, sizeof(*set));
+	set->ops = &vdc_mq_ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = VDC_TX_RING_SIZE;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = BLK_MQ_F_SHOULD_MERGE;
+
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret)
+		return ERR_PTR(ret);
+
+	q = blk_mq_init_queue(set);
+	if (IS_ERR(q)) {
+		blk_mq_free_tag_set(set);
+		return q;
+	}
+
+	q->queuedata = port;
+	return q;
+}
+
 static int probe_disk(struct vdc_port *port)
 {
 	struct request_queue *q;
@@ -796,17 +846,17 @@ static int probe_disk(struct vdc_port *port)
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
 
@@ -1034,18 +1084,14 @@ static int vdc_port_remove(struct vio_dev *vdev)
 	struct vdc_port *port = dev_get_drvdata(&vdev->dev);
 
 	if (port) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&port->vio.lock, flags);
-		blk_stop_queue(port->disk->queue);
-		spin_unlock_irqrestore(&port->vio.lock, flags);
+		blk_mq_stop_hw_queues(port->disk->queue);
 
 		flush_work(&port->ldc_reset_work);
 		del_timer_sync(&port->ldc_reset_timer);
 		del_timer_sync(&port->vio.timer);
 
 		del_gendisk(port->disk);
-		blk_cleanup_queue(port->disk->queue);
+		cleanup_queue(port->disk->queue);
 		put_disk(port->disk);
 		port->disk = NULL;
 
@@ -1080,16 +1126,28 @@ static void vdc_requeue_inflight(struct vdc_port *port)
 		}
 
 		rqe->req = NULL;
-		blk_requeue_request(port->disk->queue, req);
+		blk_mq_requeue_request(req, false);
 	}
 }
 
-static void vdc_queue_drain(struct vdc_port *port)
+static void vdc_queue_drain(struct vdc_port *port, unsigned long *flags)
 {
-	struct request *req;
+	struct request_queue *q = port->disk->queue;
+
+	/*
+	 * Mark the queue as draining, then freeze/quiesce to ensure
+	 * that all existing requests are seen in ->queue_rq() and killed
+	 */
+	port->drain = 1;
+	spin_unlock_irqrestore(&port->vio.lock, *flags);
+
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
 
-	while ((req = blk_fetch_request(port->disk->queue)) != NULL)
-		__blk_end_request_all(req, BLK_STS_IOERR);
+	spin_lock_irqsave(&port->vio.lock, *flags);
+	port->drain = 0;
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
 }
 
 static void vdc_ldc_reset_timer(struct timer_list *t)
@@ -1102,7 +1160,7 @@ static void vdc_ldc_reset_timer(struct timer_list *t)
 	if (!(port->vio.hs_state & VIO_HS_COMPLETE)) {
 		pr_warn(PFX "%s ldc down %llu seconds, draining queue\n",
 			port->disk_name, port->ldc_timeout);
-		vdc_queue_drain(port);
+		vdc_queue_drain(port, &flags);
 		vdc_blk_queue_start(port);
 	}
 	spin_unlock_irqrestore(&vio->lock, flags);
@@ -1129,7 +1187,7 @@ static void vdc_ldc_reset(struct vdc_port *port)
 	assert_spin_locked(&port->vio.lock);
 
 	pr_warn(PFX "%s ldc link reset\n", port->disk_name);
-	blk_stop_queue(port->disk->queue);
+	blk_mq_stop_hw_queues(port->disk->queue);
 	vdc_requeue_inflight(port);
 	vdc_port_down(port);
 

-- 
Jens Axboe
