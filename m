Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 03/17] ps3disk: convert to blk-mq
From: Jens Axboe <axboe@kernel.dk>
To: Geoff Levand <geoff@infradead.org>, linux-block@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-4-axboe@kernel.dk>
 <17539e5f-742b-796e-8e36-31327120f883@infradead.org>
 <ee11f577-5766-13bc-2ff5-e3d672041462@kernel.dk>
 <7f27a68f-9cbe-c4c2-5c35-70763a5b1484@infradead.org>
 <b95e3ebf-f08d-2cbf-3f82-89424d7bf60d@kernel.dk>
 <3403ae47-1aaa-9d01-817c-cd52a7daa272@infradead.org>
 <ef7c0fb3-a31f-68e3-25f6-478958c08602@kernel.dk>
Message-ID: <6c9f8842-6043-60c2-ed68-39cae1fc2cc8@kernel.dk>
Date: Mon, 15 Oct 2018 13:09:11 -0600
MIME-Version: 1.0
In-Reply-To: <ef7c0fb3-a31f-68e3-25f6-478958c08602@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/15/18 12:38 PM, Jens Axboe wrote:
> On 10/15/18 12:23 PM, Geoff Levand wrote:
>> Hi Jens,
>>
>> On 10/15/2018 09:27 AM, Jens Axboe wrote:> Can you try and change the queue depth to 1 instead of 2? It's set in> the tag_set, as ->queue_depth.
>>
>> With this change:
>>
>> -       set->queue_depth = 2;
>> +       set->queue_depth = 1;
>>
>> Something is still wrong.  It can sometimes boot, sometimes udevd hangs
>> up on /sbin/blkid.  If it boots I can sometimes mount a ps3disk
>> partition, but then cat or echo to a file will hang.  Other times the
>> mount command will hang. I saw this error appear in the system log:
> 
> Weird, it looks like we're waiting for something to complete, and then
> we have a few others waiting for queue new IO.
> 
> Can you try and move the blk_mq_end_request() inside the priv->lock
> section and see if that helps?

If that still fails, replace with this version. It's closer to the original
logic.

Thanks for testing!!

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2ecd64a2403..dcf10e39995a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2507,6 +2507,39 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
+/*
+ * Helper for setting up a queue with mq ops, given queue depth, and
+ * the passed in mq ops flags.
+ */
+struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
+					   const struct blk_mq_ops *ops,
+					   unsigned int queue_depth,
+					   unsigned int set_flags)
+{
+	struct request_queue *q;
+	int ret;
+
+	memset(set, 0, sizeof(*set));
+	set->ops = ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = queue_depth;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = set_flags;
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
+	return q;
+}
+EXPORT_SYMBOL(blk_mq_init_sq_queue);
+
 static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 {
 	int hw_ctx_size = sizeof(struct blk_mq_hw_ctx);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..2286dc12c6bc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -203,6 +203,10 @@ enum {
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 						  struct request_queue *q);
+struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
+						const struct blk_mq_ops *ops,
+						unsigned int queue_depth,
+						unsigned int set_flags);
 int blk_mq_register_dev(struct device *, struct request_queue *);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 29a4419e8ba3..affc25a431e2 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -19,7 +19,7 @@
  */
 
 #include <linux/ata.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
@@ -42,6 +42,8 @@
 struct ps3disk_private {
 	spinlock_t lock;		/* Request queue spinlock */
 	struct request_queue *queue;
+	struct blk_mq_tag_set tag_set;
+	struct list_head rq_list;
 	struct gendisk *gendisk;
 	unsigned int blocking_factor;
 	struct request *req;
@@ -118,8 +120,8 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 	}
 }
 
-static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
-				     struct request *req)
+static blk_status_t ps3disk_submit_request_sg(struct ps3_storage_device *dev,
+					      struct request *req)
 {
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	int write = rq_data_dir(req), res;
@@ -158,16 +160,15 @@ static int ps3disk_submit_request_sg(struct ps3_storage_device *dev,
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: %s failed %d\n", __func__,
 			__LINE__, op, res);
-		__blk_end_request_all(req, BLK_STS_IOERR);
-		return 0;
+		return BLK_STS_IOERR;
 	}
 
 	priv->req = req;
-	return 1;
+	return BLK_STS_OK;
 }
 
-static int ps3disk_submit_flush_request(struct ps3_storage_device *dev,
-					struct request *req)
+static blk_status_t ps3disk_submit_flush_request(struct ps3_storage_device *dev,
+						 struct request *req)
 {
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	u64 res;
@@ -180,50 +181,63 @@ static int ps3disk_submit_flush_request(struct ps3_storage_device *dev,
 	if (res) {
 		dev_err(&dev->sbd.core, "%s:%u: sync cache failed 0x%llx\n",
 			__func__, __LINE__, res);
-		__blk_end_request_all(req, BLK_STS_IOERR);
-		return 0;
+		return BLK_STS_IOERR;
 	}
 
 	priv->req = req;
-	return 1;
+	return BLK_STS_OK;
 }
 
-static void ps3disk_do_request(struct ps3_storage_device *dev,
-			       struct request_queue *q)
+static blk_status_t __ps3disk_do_request(struct ps3_storage_device *dev,
+					 struct request *req)
 {
+	dev_dbg(&dev->sbd.core, "%s:%u\n", __func__, __LINE__);
+
+	switch (req_op(req)) {
+	case REQ_OP_FLUSH:
+		return ps3disk_submit_flush_request(dev, req);
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+		return ps3disk_submit_request_sg(dev, req);
+	default:
+		blk_dump_rq_flags(req, DEVICE_NAME " bad request");
+		return BLK_STS_IOERR;
+	}
+}
+
+static void ps3disk_do_request(struct ps3_storage_device *dev)
+{
+	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 	struct request *req;
+	blk_status_t ret;
 
-	dev_dbg(&dev->sbd.core, "%s:%u\n", __func__, __LINE__);
+	while (!list_empty(&priv->rq_list)) {
+		req = list_first_entry(&priv->rq_list, struct request, queuelist);
+		list_del_init(&req->queuelist);
+		blk_mq_start_request(req);
 
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
+		ret = __ps3disk_do_request(dev, req);
+		if (ret == BLK_STS_IOERR) {
+			blk_mq_end_request(req, BLK_STS_IOERR);
+			continue;
 		}
+		break;
 	}
 }
 
-static void ps3disk_request(struct request_queue *q)
+static blk_status_t ps3disk_queue_rq(struct blk_mq_hw_ctx *hctx,
+				     const struct blk_mq_queue_data *bd)
 {
-	struct ps3_storage_device *dev = q->queuedata;
+	struct ps3_storage_device *dev = hctx->queue->queuedata;
 	struct ps3disk_private *priv = ps3_system_bus_get_drvdata(&dev->sbd);
 
-	if (priv->req) {
-		dev_dbg(&dev->sbd.core, "%s:%u busy\n", __func__, __LINE__);
-		return;
-	}
+	spin_lock_irq(&priv->lock);
+	list_add_tail(&bd->rq->queuelist, &priv->rq_list);
+	if (!priv->req)
+		ps3disk_do_request(dev);
+	spin_unlock_irq(&priv->lock);
 
-	ps3disk_do_request(dev, q);
+	return BLK_STS_OK;
 }
 
 static irqreturn_t ps3disk_interrupt(int irq, void *data)
@@ -280,9 +294,9 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
 	}
 
 	spin_lock(&priv->lock);
-	__blk_end_request_all(req, error);
+	blk_mq_end_request(req, error);
 	priv->req = NULL;
-	ps3disk_do_request(dev, priv->queue);
+	ps3disk_do_request(dev);
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
@@ -404,6 +418,10 @@ static unsigned long ps3disk_mask;
 
 static DEFINE_MUTEX(ps3disk_mask_mutex);
 
+static const struct blk_mq_ops ps3disk_mq_ops = {
+	.queue_rq	= ps3disk_queue_rq,
+};
+
 static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
@@ -440,6 +458,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 
 	ps3_system_bus_set_drvdata(_dev, priv);
 	spin_lock_init(&priv->lock);
+	INIT_LIST_HEAD(&priv->rq_list);
 
 	dev->bounce_size = BOUNCE_SIZE;
 	dev->bounce_buf = kmalloc(BOUNCE_SIZE, GFP_DMA);
@@ -454,11 +473,12 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 
 	ps3disk_identify(dev);
 
-	queue = blk_init_queue(ps3disk_request, &priv->lock);
-	if (!queue) {
-		dev_err(&dev->sbd.core, "%s:%u: blk_init_queue failed\n",
+	queue = blk_mq_init_sq_queue(&priv->tag_set, &ps3disk_mq_ops, 16,
+					BLK_MQ_F_SHOULD_MERGE);
+	if (IS_ERR(queue)) {
+		dev_err(&dev->sbd.core, "%s:%u: blk_mq_init_queue failed\n",
 			__func__, __LINE__);
-		error = -ENOMEM;
+		error = PTR_ERR(queue);
 		goto fail_teardown;
 	}
 
@@ -505,6 +525,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 
 fail_cleanup_queue:
 	blk_cleanup_queue(queue);
+	blk_mq_free_tag_set(&priv->tag_set);
 fail_teardown:
 	ps3stor_teardown(dev);
 fail_free_bounce:
@@ -530,6 +551,7 @@ static int ps3disk_remove(struct ps3_system_bus_device *_dev)
 	mutex_unlock(&ps3disk_mask_mutex);
 	del_gendisk(priv->gendisk);
 	blk_cleanup_queue(priv->queue);
+	blk_mq_free_tag_set(&priv->tag_set);
 	put_disk(priv->gendisk);
 	dev_notice(&dev->sbd.core, "Synchronizing disk cache\n");
 	ps3disk_sync_cache(dev);

-- 
Jens Axboe
