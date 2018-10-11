Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Jeff Dike <jdike@addtoit.com>
Subject: [PATCH 07/17] uml: convert ubd to blk-mq
Date: Thu, 11 Oct 2018 10:58:59 -0600
Message-Id: <20181011165909.32615-8-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Just a straight forward conversion. The retry handling could
potentially be done by blk-mq as well, but that's for another
day.

Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/um/drivers/ubd_kern.c | 154 ++++++++++++++++++++++---------------
 1 file changed, 94 insertions(+), 60 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 83c470364dfb..a302962a441d 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -22,7 +22,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/ata.h>
 #include <linux/hdreg.h>
 #include <linux/cdrom.h>
@@ -156,6 +156,7 @@ struct ubd {
 	struct cow cow;
 	struct platform_device pdev;
 	struct request_queue *queue;
+	struct blk_mq_tag_set tag_set;
 	spinlock_t lock;
 	struct scatterlist sg[MAX_SG];
 	struct request *request;
@@ -436,7 +437,9 @@ __uml_help(udb_setup,
 "    in the boot output.\n\n"
 );
 
-static void do_ubd_request(struct request_queue * q);
+static void ubd_handle_request(struct ubd *dev);
+static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd);
 
 /* Only changed by ubd_init, which is an initcall. */
 static int thread_fd = -1;
@@ -520,12 +523,12 @@ static void ubd_handler(void)
 			return;
 		}
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
-			blk_end_request(
-				(*irq_req_buffer)[count]->req,
-				BLK_STS_OK,
-				(*irq_req_buffer)[count]->length
-			);
-			kfree((*irq_req_buffer)[count]);
+			struct io_thread_req *io_req = (*irq_req_buffer)[count];
+
+			if (!blk_update_request(io_req->req, BLK_STS_OK, io_req->length))
+				__blk_mq_end_request(io_req->req, BLK_STS_OK);
+
+			kfree(io_req);
 		}
 	}
 	reactivate_fd(thread_fd, UBD_IRQ);
@@ -534,7 +537,7 @@ static void ubd_handler(void)
 		ubd = container_of(list, struct ubd, restart);
 		list_del_init(&ubd->restart);
 		spin_lock_irqsave(&ubd->lock, flags);
-		do_ubd_request(ubd->queue);
+		ubd_handle_request(ubd);
 		spin_unlock_irqrestore(&ubd->lock, flags);
 	}
 }
@@ -856,6 +859,7 @@ static void ubd_device_release(struct device *dev)
 {
 	struct ubd *ubd_dev = dev_get_drvdata(dev);
 
+	blk_mq_free_tag_set(&ubd_dev->tag_set);
 	blk_cleanup_queue(ubd_dev->queue);
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 }
@@ -897,20 +901,25 @@ static int ubd_disk_register(int major, u64 size, int unit,
 	return 0;
 }
 
+static const struct blk_mq_ops ubd_mq_ops = {
+	.queue_rq	= ubd_queue_rq,
+};
+
 #define ROUND_BLOCK(n) ((n + ((1 << 9) - 1)) & (-1 << 9))
 
 static int ubd_add(int n, char **error_out)
 {
 	struct ubd *ubd_dev = &ubd_devs[n];
+	struct blk_mq_tag_set *set;
 	int err = 0;
 
 	if(ubd_dev->file == NULL)
-		goto out;
+		goto out1;
 
 	err = ubd_file_size(ubd_dev, &ubd_dev->size);
 	if(err < 0){
 		*error_out = "Couldn't determine size of device's file";
-		goto out;
+		goto out1;
 	}
 
 	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
@@ -918,12 +927,26 @@ static int ubd_add(int n, char **error_out)
 	INIT_LIST_HEAD(&ubd_dev->restart);
 	sg_init_table(ubd_dev->sg, MAX_SG);
 
-	err = -ENOMEM;
-	ubd_dev->queue = blk_init_queue(do_ubd_request, &ubd_dev->lock);
-	if (ubd_dev->queue == NULL) {
+	set = &ubd_dev->tag_set;
+	set->ops = &ubd_mq_ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = 2;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = BLK_MQ_F_SHOULD_MERGE;
+	err = blk_mq_alloc_tag_set(set);
+	if (err) {
+		*error_out = "Failed to initialize device tag set";
+		goto out1;
+	}
+
+	ubd_dev->queue = blk_mq_init_queue(set);
+	if (IS_ERR(ubd_dev->queue)) {
+		err = PTR_ERR(ubd_dev->queue);
+		ubd_dev->queue = NULL;
 		*error_out = "Failed to initialize device queue";
 		goto out;
 	}
+
 	ubd_dev->queue->queuedata = ubd_dev;
 	blk_queue_write_cache(ubd_dev->queue, true, false);
 
@@ -947,9 +970,12 @@ static int ubd_add(int n, char **error_out)
 
 	err = 0;
 out:
+	blk_mq_free_tag_set(&ubd_dev->tag_set);
+out1:
 	return err;
 
 out_cleanup:
+	blk_mq_free_tag_set(&ubd_dev->tag_set);
 	blk_cleanup_queue(ubd_dev->queue);
 	goto out;
 }
@@ -1338,10 +1364,11 @@ static bool submit_request(struct io_thread_req *io_req, struct ubd *dev)
 	int n = os_write_file(thread_fd, &io_req,
 			     sizeof(io_req));
 	if (n != sizeof(io_req)) {
-		if (n != -EAGAIN)
+		if (n != -EAGAIN) {
 			printk("write to io thread failed, "
 			       "errno = %d\n", -n);
-		else if (list_empty(&dev->restart))
+			blk_mq_end_request(io_req->req, BLK_STS_IOERR);
+		} else if (list_empty(&dev->restart))
 			list_add(&dev->restart, &restart);
 
 		kfree(io_req);
@@ -1351,62 +1378,69 @@ static bool submit_request(struct io_thread_req *io_req, struct ubd *dev)
 }
 
 /* Called with dev->lock held */
-static void do_ubd_request(struct request_queue *q)
+static void ubd_handle_request(struct ubd *dev)
 {
+	struct request *req = dev->request;
 	struct io_thread_req *io_req;
-	struct request *req;
-
-	while(1){
-		struct ubd *dev = q->queuedata;
-		if(dev->request == NULL){
-			struct request *req = blk_fetch_request(q);
-			if(req == NULL)
-				return;
 
-			dev->request = req;
-			dev->rq_pos = blk_rq_pos(req);
-			dev->start_sg = 0;
-			dev->end_sg = blk_rq_map_sg(q, req, dev->sg);
+	if (req_op(req) == REQ_OP_FLUSH) {
+		io_req = kmalloc(sizeof(struct io_thread_req), GFP_ATOMIC);
+		if (io_req == NULL) {
+			if (list_empty(&dev->restart))
+				list_add(&dev->restart, &restart);
+			return;
 		}
+		prepare_flush_request(req, io_req);
+		if (submit_request(io_req, dev) == false)
+			return;
+	}
 
-		req = dev->request;
+	while (dev->start_sg < dev->end_sg){
+		struct scatterlist *sg = &dev->sg[dev->start_sg];
 
-		if (req_op(req) == REQ_OP_FLUSH) {
-			io_req = kmalloc(sizeof(struct io_thread_req),
-					 GFP_ATOMIC);
-			if (io_req == NULL) {
-				if (list_empty(&dev->restart))
-					list_add(&dev->restart, &restart);
-				return;
-			}
-			prepare_flush_request(req, io_req);
-			if (submit_request(io_req, dev) == false)
-				return;
+		io_req = kmalloc(sizeof(struct io_thread_req), GFP_ATOMIC);
+		if (io_req == NULL){
+			if (list_empty(&dev->restart))
+				list_add(&dev->restart, &restart);
+			return;
 		}
+		prepare_request(req, io_req,
+				(unsigned long long)dev->rq_pos << 9,
+				sg->offset, sg->length, sg_page(sg));
 
-		while(dev->start_sg < dev->end_sg){
-			struct scatterlist *sg = &dev->sg[dev->start_sg];
+		if (submit_request(io_req, dev) == false)
+			return;
 
-			io_req = kmalloc(sizeof(struct io_thread_req),
-					 GFP_ATOMIC);
-			if(io_req == NULL){
-				if(list_empty(&dev->restart))
-					list_add(&dev->restart, &restart);
-				return;
-			}
-			prepare_request(req, io_req,
-					(unsigned long long)dev->rq_pos << 9,
-					sg->offset, sg->length, sg_page(sg));
+		dev->rq_pos += sg->length >> 9;
+		dev->start_sg++;
+	}
 
-			if (submit_request(io_req, dev) == false)
-				return;
+	dev->end_sg = 0;
+	dev->request = NULL;
+}
 
-			dev->rq_pos += sg->length >> 9;
-			dev->start_sg++;
-		}
-		dev->end_sg = 0;
-		dev->request = NULL;
+static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
+				 const struct blk_mq_queue_data *bd)
+{
+	struct ubd *dev = hctx->queue->queuedata;
+	struct request *req;
+
+	spin_lock_irq(&dev->lock);
+	if (dev->request != NULL) {
+		spin_unlock_irq(&dev->lock);
+		return BLK_STS_DEV_RESOURCE;
 	}
+
+	req = bd->rq;
+	blk_mq_start_request(req);
+	dev->request = req;
+	dev->rq_pos = blk_rq_pos(req);
+	dev->start_sg = 0;
+	dev->end_sg = blk_rq_map_sg(req->q, req, dev->sg);
+
+	ubd_handle_request(dev);
+	spin_unlock_irq(&dev->lock);
+	return BLK_STS_OK;
 }
 
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
-- 
2.17.1
