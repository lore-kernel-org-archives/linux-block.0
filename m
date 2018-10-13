Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 03/17] ps3disk: convert to blk-mq
To: Geoff Levand <geoff@infradead.org>, linux-block@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-4-axboe@kernel.dk>
 <17539e5f-742b-796e-8e36-31327120f883@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ee11f577-5766-13bc-2ff5-e3d672041462@kernel.dk>
Date: Fri, 12 Oct 2018 18:58:50 -0600
MIME-Version: 1.0
In-Reply-To: <17539e5f-742b-796e-8e36-31327120f883@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 4:47 PM, Geoff Levand wrote:
> Hi Jens,
> 
> On 10/11/2018 09:58 AM, Jens Axboe wrote:
>> Convert from the old request_fn style driver to blk-mq.
> 
> I tested this on PS3 applied to v4.19-rc7, and on boot it either
> gets a deadlock message or becomes unstable with various other
> block related error messages.
> 
> For what its worth, I put an image of the deadlock message here:
> 
>   https://storage.googleapis.com/public-tmp-files/blk-deadlock.jpg

Thanks for testing! Can you try this incremental? It's mostly just
a cleanup on top, but the last hunk should be the thing that
hopefully makes this tick again. If you prefer just using a new
patch, this one is updated:

http://git.kernel.dk/cgit/linux-block/commit/?h=mq-conversions&id=5c86f76f45e7c8d5a47a1f20b3e7b93fc945168a


diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 5f777b694f3c..338ea9dc3393 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -119,8 +119,8 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 	}
 }
 
-static void ps3disk_submit_request_sg(struct ps3_storage_device *dev,
-				      struct request *req)
+static blk_status_t ps3disk_submit_request_sg(struct ps3_storage_device *dev,
+					      struct request *req)
 {
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	int write = rq_data_dir(req), res;
@@ -159,15 +159,15 @@ static void ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: %s failed %d\n", __func__,
 			__LINE__, op, res);
-		blk_mq_end_request(req, BLK_STS_IOERR);
-		return;
+		return BLK_STS_IOERR;
 	}
 
 	priv->req = req;
+	return BLK_STS_OK;
 }
 
-static void ps3disk_submit_flush_request(struct ps3_storage_device *dev,
-					 struct request *req)
+static blk_status_t ps3disk_submit_flush_request(struct ps3_storage_device *dev,
+						 struct request *req)
 {
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	u64 res;
@@ -180,29 +180,27 @@ static void ps3disk_submit_flush_request(struct ps3_storage_device *dev,
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: sync cache failed 0x%llx\n",
 			__func__, __LINE__, res);
-		blk_mq_end_request(req, BLK_STS_IOERR);
-		return;
+		return BLK_STS_IOERR;
 	}
 
 	priv->req = req;
+	return BLK_STS_OK;
 }
 
-static void ps3disk_do_request(struct ps3_storage_device *dev,
-			       struct request *req)
+static blk_status_t ps3disk_do_request(struct ps3_storage_device *dev,
+				       struct request *req)
 {
 	dev_dbg(&dev->sbd.core, "%s:%u\n", __func__, __LINE__);
 
 	switch (req_op(req)) {
 	case REQ_OP_FLUSH:
-		ps3disk_submit_flush_request(dev, req);
-		break;
+		return ps3disk_submit_flush_request(dev, req);
 	case REQ_OP_READ:
 	case REQ_OP_WRITE:
-		ps3disk_submit_request_sg(dev, req);
-		break;
+		return ps3disk_submit_request_sg(dev, req);
 	default:
 		blk_dump_rq_flags(req, DEVICE_NAME " bad request");
-		blk_mq_end_request(req, BLK_STS_IOERR);
+		return BLK_STS_IOERR;
 	}
 }
 
@@ -212,14 +210,15 @@ static blk_status_t ps3disk_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request_queue *q = hctx->queue;
 	struct ps3_storage_device *dev = q->queuedata;
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
+	blk_status_t ret;
 
 	blk_mq_start_request(bd->rq);
 
 	spin_lock_irq(&priv->lock);
-	ps3disk_do_request(dev, bd->rq);
+	ret = ps3disk_do_request(dev, bd->rq);
 	spin_unlock_irq(&priv->lock);
 
-	return BLK_STS_OK;
+	return ret;
 }
 
 static irqreturn_t ps3disk_interrupt(int irq, void *data)
@@ -281,7 +280,7 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
 	priv->req = NULL;
 	spin_unlock(&priv->lock);
 
-	blk_mq_start_hw_queues(priv->queue);
+	blk_mq_run_hw_queues(priv->queue, true);
 	return IRQ_HANDLED;
 }
 

-- 
Jens Axboe
