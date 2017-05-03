Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/4] blk-mq: support to use hw tag for scheduling
To: Bart Van Assche <Bart.VanAssche@sandisk.com>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <20170428151539.25514-1-ming.lei@redhat.com>
 <839682da-f375-8eab-d6f5-fcf1457150f1@fb.com>
 <20170503040303.GA20187@ming.t460p>
 <f52b4478-0d18-a248-3fbf-721216a79f92@fb.com>
 <370fbeb6-d832-968a-2759-47f16b866551@kernel.dk>
 <20170503150351.GA7927@ming.t460p>
 <31bb973e-d9cf-9454-58fd-4893701088c5@kernel.dk>
 <20170503153808.GB7927@ming.t460p> <20170503165201.GB9706@ming.t460p>
 <20170503170315.GD9706@ming.t460p>
 <24ff7ca6-73d6-f8a5-b7d9-e92d0bfdb4b0@kernel.dk>
 <1493831722.3901.19.camel@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "osandov@fb.com" <osandov@fb.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d537355e-3581-fc86-62ce-0757a84d9c1a@kernel.dk>
Date: Wed, 3 May 2017 11:24:56 -0600
MIME-Version: 1.0
In-Reply-To: <1493831722.3901.19.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 05/03/2017 11:15 AM, Bart Van Assche wrote:
> On Wed, 2017-05-03 at 11:07 -0600, Jens Axboe wrote:
>> +void blk_mq_stop_hw_queues(struct request_queue *q)
>> +{
>> +	__blk_mq_stop_hw_queues(q, false);
>>  }
>>  EXPORT_SYMBOL(blk_mq_stop_hw_queues);
> 
> Hello Jens,
> 
> So the approach of this patch is to make all blk_mq_stop_hw_queue()
> and blk_mq_stop_hw_queues() callers cancel run_work without waiting?
> That should make the BUG reported by Ming disappear. However, I think
> we may want to review all calls from block drivers to
> blk_mq_stop_hw_queues(). There are drivers that call this function to
> quiesce I/O so I think these need the synchronous work cancellation
> ...

I took a look at the drivers, and it's trivial enough to do. Most of
them will work fine with a sync block for stopping _all_ queues. See
below.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index e339247a2570..9dcb9592dbf9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -166,7 +166,7 @@ void blk_mq_quiesce_queue(struct request_queue *q)
 	unsigned int i;
 	bool rcu = false;
 
-	blk_mq_stop_hw_queues(q);
+	blk_mq_stop_hw_queues(q, true);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
@@ -1218,20 +1218,29 @@ bool blk_mq_queue_stopped(struct request_queue *q)
 }
 EXPORT_SYMBOL(blk_mq_queue_stopped);
 
-void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
+static void __blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx, bool sync)
 {
-	cancel_delayed_work_sync(&hctx->run_work);
+	if (sync)
+		cancel_delayed_work_sync(&hctx->run_work);
+	else
+		cancel_delayed_work(&hctx->run_work);
+
 	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
 }
+
+void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx)
+{
+	__blk_mq_stop_hw_queue(hctx, false);
+}
 EXPORT_SYMBOL(blk_mq_stop_hw_queue);
 
-void blk_mq_stop_hw_queues(struct request_queue *q)
+void blk_mq_stop_hw_queues(struct request_queue *q, bool sync)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
 	queue_for_each_hw_ctx(q, hctx, i)
-		blk_mq_stop_hw_queue(hctx);
+		__blk_mq_stop_hw_queue(hctx, sync);
 }
 EXPORT_SYMBOL(blk_mq_stop_hw_queues);
 
diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 3a779a4f5653..33b5d1382c45 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -950,7 +950,7 @@ static int mtip_quiesce_io(struct mtip_port *port, unsigned long timeout)
 	unsigned long to;
 	bool active = true;
 
-	blk_mq_stop_hw_queues(port->dd->queue);
+	blk_mq_stop_hw_queues(port->dd->queue, true);
 
 	to = jiffies + msecs_to_jiffies(timeout);
 	do {
@@ -4009,7 +4009,7 @@ static int mtip_block_remove(struct driver_data *dd)
 						dd->disk->disk_name);
 
 	blk_freeze_queue_start(dd->queue);
-	blk_mq_stop_hw_queues(dd->queue);
+	blk_mq_stop_hw_queues(dd->queue, true);
 	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
 
 	/*
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6b98ec2a3824..ce5490938232 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -656,7 +656,7 @@ static void nbd_clear_req(struct request *req, void *data, bool reserved)
 
 static void nbd_clear_que(struct nbd_device *nbd)
 {
-	blk_mq_stop_hw_queues(nbd->disk->queue);
+	blk_mq_stop_hw_queues(nbd->disk->queue, true);
 	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
 	blk_mq_start_hw_queues(nbd->disk->queue);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 94173de1efaa..a73d2823cdb2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -844,7 +844,7 @@ static int virtblk_freeze(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
-	blk_mq_stop_hw_queues(vblk->disk->queue);
+	blk_mq_stop_hw_queues(vblk->disk->queue, true);
 
 	vdev->config->del_vqs(vdev);
 	return 0;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 70e689bf1cad..b6891e4af837 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1969,7 +1969,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 			return BLK_MQ_RQ_QUEUE_ERROR;
 
 		if (op->rq) {
-			blk_mq_stop_hw_queues(op->rq->q);
+			blk_mq_stop_hw_queues(op->rq->q, false);
 			blk_mq_delay_queue(queue->hctx, NVMEFC_QUEUE_DELAY);
 		}
 		return BLK_MQ_RQ_QUEUE_BUSY;
@@ -2478,7 +2478,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 * use blk_mq_tagset_busy_itr() and the transport routine to
 	 * terminate the exchanges.
 	 */
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q, true);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 56a315bd4d96..6e87854eddd5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1084,7 +1084,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	spin_unlock_irq(&nvmeq->q_lock);
 
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
-		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q);
+		blk_mq_stop_hw_queues(nvmeq->dev->ctrl.admin_q, true);
 
 	free_irq(vector, nvmeq);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dd1c6deef82f..b478839c5d79 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -792,7 +792,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	return;
 
 stop_admin_q:
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q, true);
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
 			ctrl->ctrl.opts->nr_reconnects);
@@ -814,7 +814,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (ctrl->queue_count > 1)
 		nvme_stop_queues(&ctrl->ctrl);
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q, true);
 
 	/* We must take care of fastfail/requeue all our inflight requests */
 	if (ctrl->queue_count > 1)
@@ -1651,7 +1651,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 	if (test_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[0].flags))
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q, true);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index feb497134aee..ea0911e36f2d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -446,7 +446,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
+	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q, true);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 327b10206d63..64100c6b5811 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2976,7 +2976,7 @@ scsi_internal_device_block(struct scsi_device *sdev, bool wait)
 		if (wait)
 			blk_mq_quiesce_queue(q);
 		else
-			blk_mq_stop_hw_queues(q);
+			blk_mq_stop_hw_queues(q, true);
 	} else {
 		spin_lock_irqsave(q->queue_lock, flags);
 		blk_stop_queue(q);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index a104832e7ae5..1f6684aa465f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -239,7 +239,7 @@ void blk_mq_complete_request(struct request *rq);
 bool blk_mq_queue_stopped(struct request_queue *q);
 void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hctx);
 void blk_mq_start_hw_queue(struct blk_mq_hw_ctx *hctx);
-void blk_mq_stop_hw_queues(struct request_queue *q);
+void blk_mq_stop_hw_queues(struct request_queue *q, bool sync);
 void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);

-- 
Jens Axboe
