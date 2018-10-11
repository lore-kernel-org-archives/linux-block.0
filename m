Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Geoff Levand <geoff@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 03/17] ps3disk: convert to blk-mq
Date: Thu, 11 Oct 2018 10:58:55 -0600
Message-Id: <20181011165909.32615-4-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Convert from the old request_fn style driver to blk-mq.

Cc: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ps3disk.c | 95 +++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index afe1508d82c6..e8b41e95a679 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -19,7 +19,7 @@
  */
 
 #include <linux/ata.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
@@ -42,6 +42,7 @@
 struct ps3disk_private {
 	spinlock_t lock;		/* Request queue spinlock */
 	struct request_queue *queue;
+	struct blk_mq_tag_set tag_set;
 	struct gendisk *gendisk;
 	unsigned int blocking_factor;
 	struct request *req;
@@ -118,8 +119,8 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 	}
 }
 
-static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
-				     struct request *req)
+static void ps3disk_submit_request_sg(struct ps3_storage_device *dev,
+				      struct request *req)
 {
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	int write = rq_data_dir(req), res;
@@ -158,16 +159,15 @@ static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: %s failed %d\n", __func__,
 			__LINE__, op, res);
-		__blk_end_request_all(req, BLK_STS_IOERR);
-		return 0;
+		blk_mq_end_request(req, BLK_STS_IOERR);
+		return;
 	}
 
 	priv->req = req;
-	return 1;
 }
 
-static int ps3disk_submit_flush_request(struct ps3_storage_device *dev,
-					struct request *req)
+static void ps3disk_submit_flush_request(struct ps3_storage_device *dev,
+					 struct request *req)
 {
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	u64 res;
@@ -180,50 +180,46 @@ static int ps3disk_submit_flush_request(struct ps3_storage_device *dev,
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: sync cache failed 0x%llx\n",
 			__func__, __LINE__, res);
-		__blk_end_request_all(req, BLK_STS_IOERR);
-		return 0;
+		blk_mq_end_request(req, BLK_STS_IOERR);
+		return;
 	}
 
 	priv->req = req;
-	return 1;
 }
 
 static void ps3disk_do_request(struct ps3_storage_device *dev,
-			       struct request_queue *q)
+			       struct request *req)
 {
-	struct request *req;
-
 	dev_dbg(&dev->sbd.core, "%s:%u\n", __func__, __LINE__);
 
-	while ((req = blk_fetch_request(q))) {
-		switch (req_op(req)) {
-		case REQ_OP_FLUSH:
-			if (ps3disk_submit_flush_request(dev, req))
-				return;
-			break;
-		case REQ_OP_READ:
-		case REQ_OP_WRITE:
-			if (ps3disk_submit_request_sg(dev, req))
-				return;
-			break;
-		default:
-			blk_dump_rq_flags(req, DEVICE_NAME " bad request");
-			__blk_end_request_all(req, BLK_STS_IOERR);
-		}
+	switch (req_op(req)) {
+	case REQ_OP_FLUSH:
+		ps3disk_submit_flush_request(dev, req);
+		break;
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+		ps3disk_submit_request_sg(dev, req);
+		break;
+	default:
+		blk_dump_rq_flags(req, DEVICE_NAME " bad request");
+		blk_mq_end_request(req, BLK_STS_IOERR);
 	}
 }
 
-static void ps3disk_request(struct request_queue *q)
+static blk_status_t ps3disk_queue_rq(struct blk_mq_hw_ctx *hctx,
+				     const struct blk_mq_queue_data *bd)
 {
+	struct request_queue *q = hctx->queue;
 	struct ps3_storage_device *dev = q->queuedata;
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 
-	if (priv->req) {
-		dev_dbg(&dev->sbd.core, "%s:%u busy\n", __func__, __LINE__);
-		return;
-	}
+	blk_mq_start_request(bd->rq);
+
+	spin_lock_irq(&priv->lock);
+	ps3disk_do_request(dev, bd->rq);
+	spin_unlock_irq(&priv->lock);
 
-	ps3disk_do_request(dev, q);
+	return BLK_STS_OK;
 }
 
 static irqreturn_t ps3disk_interrupt(int irq, void *data)
@@ -279,12 +275,13 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
 			ps3disk_scatter_gather(dev, req, 0);
 	}
 
+	blk_mq_end_request(req, error);
+
 	spin_lock(&priv->lock);
-	__blk_end_request_all(req, error);
 	priv->req = NULL;
-	ps3disk_do_request(dev, priv->queue);
 	spin_unlock(&priv->lock);
 
+	blk_mq_start_hw_queues(priv->queue);
 	return IRQ_HANDLED;
 }
 
@@ -404,6 +401,10 @@ static unsigned long ps3disk_mask;
 
 static DEFINE_MUTEX(ps3disk_mask_mutex);
 
+static const struct blk_mq_ops ps3disk_mq_ops = {
+	.queue_rq	= ps3disk_queue_rq,
+};
+
 static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
@@ -411,6 +412,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 	int error;
 	unsigned int devidx;
 	struct request_queue *queue;
+	struct blk_mq_tag_set *set;
 	struct gendisk *gendisk;
 
 	if (dev->blk_size < 512) {
@@ -454,11 +456,21 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 
 	ps3disk_identify(dev);
 
-	queue = blk_init_queue(ps3disk_request, &priv->lock);
-	if (!queue) {
-		dev_err(&dev->sbd.core, "%s:%u: blk_init_queue failed\n",
+	set = &priv->tag_set;
+	set->ops = &ps3disk_mq_ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = 2;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = BLK_MQ_F_SHOULD_MERGE;
+	error = blk_mq_alloc_tag_set(set);
+	if (error)
+		goto fail_teardown;
+
+	queue = blk_mq_init_queue(set);
+	if (IS_ERR(queue)) {
+		dev_err(&dev->sbd.core, "%s:%u: blk_mq_init_queue failed\n",
 			__func__, __LINE__);
-		error = -ENOMEM;
+		error = PTR_ERR(queue);
 		goto fail_teardown;
 	}
 
@@ -504,6 +516,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 	return 0;
 
 fail_cleanup_queue:
+	blk_mq_free_tag_set(&priv->tag_set);
 	blk_cleanup_queue(queue);
 fail_teardown:
 	ps3stor_teardown(dev);
-- 
2.17.1
