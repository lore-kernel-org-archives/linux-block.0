Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/17] z2ram: convert to blk-mq
Date: Thu, 11 Oct 2018 10:59:03 -0600
Message-Id: <20181011165909.32615-12-axboe@kernel.dk>
In-Reply-To: <20181011165909.32615-1-axboe@kernel.dk>
References: <20181011165909.32615-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Straight forward conversion to blk-mq, nothing special about this
driver.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/z2ram.c | 96 ++++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index d0c5bc4e0703..82a022a5297e 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -31,7 +31,7 @@
 #include <linux/vmalloc.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/bitops.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -66,43 +66,44 @@ static DEFINE_SPINLOCK(z2ram_lock);
 
 static struct gendisk *z2ram_gendisk;
 
-static void do_z2_request(struct request_queue *q)
+static blk_status_t z2_queue_rq(struct blk_mq_hw_ctx *hctx,
+				const struct blk_mq_queue_data *bd)
 {
-	struct request *req;
-
-	req = blk_fetch_request(q);
-	while (req) {
-		unsigned long start = blk_rq_pos(req) << 9;
-		unsigned long len  = blk_rq_cur_bytes(req);
-		blk_status_t err = BLK_STS_OK;
-
-		if (start + len > z2ram_size) {
-			pr_err(DEVICE_NAME ": bad access: block=%llu, "
-			       "count=%u\n",
-			       (unsigned long long)blk_rq_pos(req),
-			       blk_rq_cur_sectors(req));
-			err = BLK_STS_IOERR;
-			goto done;
-		}
-		while (len) {
-			unsigned long addr = start & Z2RAM_CHUNKMASK;
-			unsigned long size = Z2RAM_CHUNKSIZE - addr;
-			void *buffer = bio_data(req->bio);
-
-			if (len < size)
-				size = len;
-			addr += z2ram_map[ start >> Z2RAM_CHUNKSHIFT ];
-			if (rq_data_dir(req) == READ)
-				memcpy(buffer, (char *)addr, size);
-			else
-				memcpy((char *)addr, buffer, size);
-			start += size;
-			len -= size;
-		}
-	done:
-		if (!__blk_end_request_cur(req, err))
-			req = blk_fetch_request(q);
+	struct request *req = bd->rq;
+	unsigned long start = blk_rq_pos(req) << 9;
+	unsigned long len  = blk_rq_cur_bytes(req);
+
+	blk_mq_start_request(req);
+
+	if (start + len > z2ram_size) {
+		pr_err(DEVICE_NAME ": bad access: block=%llu, "
+		       "count=%u\n",
+		       (unsigned long long)blk_rq_pos(req),
+		       blk_rq_cur_sectors(req));
+		return BLK_STS_IOERR;
 	}
+
+	spin_lock_irq(&z2ram_lock);
+
+	while (len) {
+		unsigned long addr = start & Z2RAM_CHUNKMASK;
+		unsigned long size = Z2RAM_CHUNKSIZE - addr;
+		void *buffer = bio_data(req->bio);
+
+		if (len < size)
+			size = len;
+		addr += z2ram_map[ start >> Z2RAM_CHUNKSHIFT ];
+		if (rq_data_dir(req) == READ)
+			memcpy(buffer, (char *)addr, size);
+		else
+			memcpy((char *)addr, buffer, size);
+		start += size;
+		len -= size;
+	}
+
+	spin_unlock_irq(&z2ram_lock);
+	blk_mq_end_request(req, BLK_STS_OK);
+	return BLK_STS_OK;
 }
 
 static void
@@ -337,6 +338,11 @@ static struct kobject *z2_find(dev_t dev, int *part, void *data)
 }
 
 static struct request_queue *z2_queue;
+static struct blk_mq_tag_set tag_set;
+
+static const struct blk_mq_ops z2_mq_ops = {
+	.queue_rq	= z2_queue_rq,
+};
 
 static int __init 
 z2_init(void)
@@ -355,10 +361,23 @@ z2_init(void)
     if (!z2ram_gendisk)
 	goto out_disk;
 
-    z2_queue = blk_init_queue(do_z2_request, &z2ram_lock);
-    if (!z2_queue)
+    tag_set.ops = &z2_mq_ops;
+    tag_set.nr_hw_queues = 1;
+    tag_set.queue_depth = 16; /* no hard limit */
+    tag_set.numa_node = NUMA_NO_NODE;
+    tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+    ret = blk_mq_alloc_tag_set(&tag_set);
+    if (ret)
 	goto out_queue;
 
+    z2_queue = blk_mq_init_queue(&tag_set);
+    if (IS_ERR(z2_queue)) {
+	ret = PTR_ERR(z2_queue);
+	z2_queue = NULL;
+	blk_mq_free_tag_set(&tag_set);
+	goto out_queue;
+    }
+
     z2ram_gendisk->major = Z2RAM_MAJOR;
     z2ram_gendisk->first_minor = 0;
     z2ram_gendisk->fops = &z2_fops;
@@ -386,6 +405,7 @@ static void __exit z2_exit(void)
     unregister_blkdev(Z2RAM_MAJOR, DEVICE_NAME);
     del_gendisk(z2ram_gendisk);
     put_disk(z2ram_gendisk);
+    blk_mq_free_tag_set(&tag_set);
     blk_cleanup_queue(z2_queue);
 
     if ( current_device != -1 )
-- 
2.17.1
