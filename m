Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org
Subject: [PATCH 16/17] mtd_blkdevs: convert to blk-mq
Date: Thu, 11 Oct 2018 10:59:08 -0600
Message-Id: <20181011165909.32615-17-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Straight forward conversion, using an internal list to enable the
driver to pull requests at will.

Dynamically allocate the tag set to avoid having to pull in the
block headers for blktrans.h, since various mtd drivers use
block conflicting names for defines and functions.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/mtd/mtd_blkdevs.c    | 109 +++++++++++++++++++++++------------
 include/linux/mtd/blktrans.h |   5 +-
 2 files changed, 74 insertions(+), 40 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 29c0bfd74e8a..6a94cffbca20 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -27,6 +27,7 @@
 #include <linux/mtd/blktrans.h>
 #include <linux/mtd/mtd.h>
 #include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/blkpg.h>
 #include <linux/spinlock.h>
 #include <linux/hdreg.h>
@@ -44,6 +45,8 @@ static void blktrans_dev_release(struct kref *kref)
 		container_of(kref, struct mtd_blktrans_dev, ref);
 
 	dev->disk->private_data = NULL;
+	blk_mq_free_tag_set(dev->tag_set);
+	kfree(dev->tag_set);
 	blk_cleanup_queue(dev->rq);
 	put_disk(dev->disk);
 	list_del(&dev->list);
@@ -134,28 +137,37 @@ int mtd_blktrans_cease_background(struct mtd_blktrans_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mtd_blktrans_cease_background);
 
-static void mtd_blktrans_work(struct work_struct *work)
+static struct request *mtd_next_request(struct mtd_blktrans_dev *dev)
+{
+	struct request *rq;
+
+	rq = list_first_entry_or_null(&dev->rq_list, struct request, queuelist);
+	if (rq) {
+		list_del_init(&rq->queuelist);
+		blk_mq_start_request(rq);
+		return rq;
+	}
+
+	return NULL;
+}
+
+static void mtd_blktrans_work(struct mtd_blktrans_dev *dev)
 {
-	struct mtd_blktrans_dev *dev =
-		container_of(work, struct mtd_blktrans_dev, work);
 	struct mtd_blktrans_ops *tr = dev->tr;
-	struct request_queue *rq = dev->rq;
 	struct request *req = NULL;
 	int background_done = 0;
 
-	spin_lock_irq(rq->queue_lock);
-
 	while (1) {
 		blk_status_t res;
 
 		dev->bg_stop = false;
-		if (!req && !(req = blk_fetch_request(rq))) {
+		if (!req && !(req = mtd_next_request(dev))) {
 			if (tr->background && !background_done) {
-				spin_unlock_irq(rq->queue_lock);
+				spin_unlock_irq(&dev->queue_lock);
 				mutex_lock(&dev->lock);
 				tr->background(dev);
 				mutex_unlock(&dev->lock);
-				spin_lock_irq(rq->queue_lock);
+				spin_lock_irq(&dev->queue_lock);
 				/*
 				 * Do background processing just once per idle
 				 * period.
@@ -166,35 +178,39 @@ static void mtd_blktrans_work(struct work_struct *work)
 			break;
 		}
 
-		spin_unlock_irq(rq->queue_lock);
+		spin_unlock_irq(&dev->queue_lock);
 
 		mutex_lock(&dev->lock);
 		res = do_blktrans_request(dev->tr, dev, req);
 		mutex_unlock(&dev->lock);
 
-		spin_lock_irq(rq->queue_lock);
-
-		if (!__blk_end_request_cur(req, res))
+		if (!blk_update_request(req, res, blk_rq_cur_bytes(req))) {
 			req = NULL;
+			__blk_mq_end_request(req, res);
+		}
 
 		background_done = 0;
+		spin_lock_irq(&dev->queue_lock);
 	}
-
-	spin_unlock_irq(rq->queue_lock);
 }
 
-static void mtd_blktrans_request(struct request_queue *rq)
+static blk_status_t mtd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd)
 {
 	struct mtd_blktrans_dev *dev;
-	struct request *req = NULL;
 
-	dev = rq->queuedata;
+	dev = hctx->queue->queuedata;
+	if (!dev) {
+		blk_mq_start_request(bd->rq);
+		return BLK_STS_IOERR;
+	}
+
+	spin_lock_irq(&dev->queue_lock);
+	list_add_tail(&bd->rq->queuelist, &dev->rq_list);
+	mtd_blktrans_work(dev);
+	spin_unlock_irq(&dev->queue_lock);
 
-	if (!dev)
-		while ((req = blk_fetch_request(rq)) != NULL)
-			__blk_end_request_all(req, BLK_STS_IOERR);
-	else
-		queue_work(dev->wq, &dev->work);
+	return BLK_STS_OK;
 }
 
 static int blktrans_open(struct block_device *bdev, fmode_t mode)
@@ -329,9 +345,14 @@ static const struct block_device_operations mtd_block_ops = {
 	.getgeo		= blktrans_getgeo,
 };
 
+static const struct blk_mq_ops mtd_mq_ops = {
+	.queue_rq	= mtd_queue_rq,
+};
+
 int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 {
 	struct mtd_blktrans_ops *tr = new->tr;
+	struct blk_mq_tag_set *set;
 	struct mtd_blktrans_dev *d;
 	int last_devnum = -1;
 	struct gendisk *gd;
@@ -416,11 +437,28 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 
 	/* Create the request queue */
 	spin_lock_init(&new->queue_lock);
-	new->rq = blk_init_queue(mtd_blktrans_request, &new->queue_lock);
+	INIT_LIST_HEAD(&new->rq_list);
 
-	if (!new->rq)
+	new->tag_set = kzalloc(sizeof(*new->tag_set), GFP_KERNEL);
+	if (!new->tag_set)
 		goto error3;
 
+	set = new->tag_set;
+	set->ops = &mtd_mq_ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = 2;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING;
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret)
+		goto error4;
+
+	new->rq = blk_mq_init_queue(set);
+	if (!new->rq) {
+		blk_mq_free_tag_set(new->tag_set);
+		goto error5;
+	}
+
 	if (tr->flush)
 		blk_queue_write_cache(new->rq, true, false);
 
@@ -437,13 +475,6 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 
 	gd->queue = new->rq;
 
-	/* Create processing workqueue */
-	new->wq = alloc_workqueue("%s%d", 0, 0,
-				  tr->name, new->mtd->index);
-	if (!new->wq)
-		goto error4;
-	INIT_WORK(&new->work, mtd_blktrans_work);
-
 	if (new->readonly)
 		set_disk_ro(gd, 1);
 
@@ -455,8 +486,10 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 		WARN_ON(ret);
 	}
 	return 0;
+error5:
+	blk_mq_free_tag_set(new->tag_set);
 error4:
-	blk_cleanup_queue(new->rq);
+	kfree(new->tag_set);
 error3:
 	put_disk(new->disk);
 error2:
@@ -481,15 +514,17 @@ int del_mtd_blktrans_dev(struct mtd_blktrans_dev *old)
 	/* Stop new requests to arrive */
 	del_gendisk(old->disk);
 
-	/* Stop workqueue. This will perform any pending request. */
-	destroy_workqueue(old->wq);
-
 	/* Kill current requests */
 	spin_lock_irqsave(&old->queue_lock, flags);
 	old->rq->queuedata = NULL;
-	blk_start_queue(old->rq);
 	spin_unlock_irqrestore(&old->queue_lock, flags);
 
+	/* freeze+quiesce queue to ensure all requests are flushed */
+	blk_mq_freeze_queue(old->rq);
+	blk_mq_quiesce_queue(old->rq);
+	blk_mq_unquiesce_queue(old->rq);
+	blk_mq_unfreeze_queue(old->rq);
+
 	/* If the device is currently open, tell trans driver to close it,
 		then put mtd device, and don't touch it again */
 	mutex_lock(&old->lock);
diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index e93837f647de..1d3ade69d39a 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -23,7 +23,6 @@
 #include <linux/mutex.h>
 #include <linux/kref.h>
 #include <linux/sysfs.h>
-#include <linux/workqueue.h>
 
 struct hd_geometry;
 struct mtd_info;
@@ -44,9 +43,9 @@ struct mtd_blktrans_dev {
 	struct kref ref;
 	struct gendisk *disk;
 	struct attribute_group *disk_attributes;
-	struct workqueue_struct *wq;
-	struct work_struct work;
 	struct request_queue *rq;
+	struct list_head rq_list;
+	struct blk_mq_tag_set *tag_set;
 	spinlock_t queue_lock;
 	void *priv;
 	fmode_t file_mode;
-- 
2.17.1
