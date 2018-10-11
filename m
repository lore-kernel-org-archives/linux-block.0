Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36955 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbeJLB7D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Oct 2018 21:59:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id j23-v6so4833343pfi.4
        for <linux-block@vger.kernel.org>; Thu, 11 Oct 2018 11:30:39 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, kernel-team@fb.com,
        Finn Thain <fthain@telegraphics.com.au>,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 02/13] swim: convert to blk-mq
Date: Thu, 11 Oct 2018 11:30:12 -0700
Message-Id: <fa367b63a11cfcc54c8063f62a6c1b51a9a8ecbd.1539282366.git.osandov@fb.com>
In-Reply-To: <cover.1539282366.git.osandov@fb.com>
References: <cover.1539282366.git.osandov@fb.com>
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The only interesting thing here is that there may be two floppies (i.e.,
request queues) sharing the same controller, so we use the global struct
swim_priv->lock to check whether the controller is busy. Compile-tested
only.

Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/swim.c | 103 +++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index cbe909c51847..bb3ac4da5b8d 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/fd.h>
 #include <linux/slab.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/mutex.h>
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
@@ -190,6 +190,7 @@ struct floppy_state {
 	int		ref_count;
 
 	struct gendisk *disk;
+	struct blk_mq_tag_set tag_set;
 
 	/* parent controller */
 
@@ -211,7 +212,6 @@ enum head {
 struct swim_priv {
 	struct swim __iomem *base;
 	spinlock_t lock;
-	int fdc_queue;
 	int floppy_count;
 	struct floppy_state unit[FD_MAX_UNIT];
 };
@@ -525,58 +525,38 @@ static blk_status_t floppy_read_sectors(struct floppy_state *fs,
 	return 0;
 }
 
-static struct request *swim_next_request(struct swim_priv *swd)
+static blk_status_t swim_queue_rq(struct blk_mq_hw_ctx *hctx,
+				  const struct blk_mq_queue_data *bd)
 {
-	struct request_queue *q;
-	struct request *rq;
-	int old_pos = swd->fdc_queue;
+	struct floppy_state *fs = hctx->queue->queuedata;
+	struct swim_priv *swd = fs->swd;
+	struct request *req = bd->rq;
+	blk_status_t err;
 
-	do {
-		q = swd->unit[swd->fdc_queue].disk->queue;
-		if (++swd->fdc_queue == swd->floppy_count)
-			swd->fdc_queue = 0;
-		if (q) {
-			rq = blk_fetch_request(q);
-			if (rq)
-				return rq;
-		}
-	} while (swd->fdc_queue != old_pos);
+	if (!spin_trylock_irq(&swd->lock))
+		return BLK_STS_DEV_RESOURCE;
 
-	return NULL;
-}
+	blk_mq_start_request(req);
 
-static void do_fd_request(struct request_queue *q)
-{
-	struct swim_priv *swd = q->queuedata;
-	struct request *req;
-	struct floppy_state *fs;
+	if (!fs->disk_in || rq_data_dir(req) == WRITE) {
+		err = BLK_STS_IOERR;
+		goto out;
+	}
 
-	req = swim_next_request(swd);
-	while (req) {
-		blk_status_t err = BLK_STS_IOERR;
+	do {
+		err = floppy_read_sectors(fs, blk_rq_pos(req),
+					  blk_rq_cur_sectors(req),
+					  bio_data(req->bio));
+		if (err)
+			break;
+	} while (blk_update_request(req, err, blk_rq_cur_bytes(req)));
+	blk_mq_end_request(req, err);
 
-		fs = req->rq_disk->private_data;
-		if (blk_rq_pos(req) >= fs->total_secs)
-			goto done;
-		if (!fs->disk_in)
-			goto done;
-		if (rq_data_dir(req) == WRITE && fs->write_protected)
-			goto done;
+	err = BLK_STS_OK;
+out:
+	spin_unlock_irq(&swd->lock);
+	return err;
 
-		switch (rq_data_dir(req)) {
-		case WRITE:
-			/* NOT IMPLEMENTED */
-			break;
-		case READ:
-			err = floppy_read_sectors(fs, blk_rq_pos(req),
-						  blk_rq_cur_sectors(req),
-						  bio_data(req->bio));
-			break;
-		}
-	done:
-		if (!__blk_end_request_cur(req, err))
-			req = swim_next_request(swd);
-	}
 }
 
 static struct floppy_struct floppy_type[4] = {
@@ -823,6 +803,10 @@ static int swim_add_floppy(struct swim_priv *swd, enum drive_location location)
 	return 0;
 }
 
+static const struct blk_mq_ops swim_mq_ops = {
+	.queue_rq = swim_queue_rq,
+};
+
 static int swim_floppy_init(struct swim_priv *swd)
 {
 	int err;
@@ -852,20 +836,33 @@ static int swim_floppy_init(struct swim_priv *swd)
 	spin_lock_init(&swd->lock);
 
 	for (drive = 0; drive < swd->floppy_count; drive++) {
+		struct blk_mq_tag_set *set;
+
 		swd->unit[drive].disk = alloc_disk(1);
 		if (swd->unit[drive].disk == NULL) {
 			err = -ENOMEM;
 			goto exit_put_disks;
 		}
-		swd->unit[drive].disk->queue = blk_init_queue(do_fd_request,
-							      &swd->lock);
-		if (!swd->unit[drive].disk->queue) {
-			err = -ENOMEM;
+
+		set = &swd->unit[drive].tag_set;
+		set->ops = &swim_mq_ops;
+		set->nr_hw_queues = 1;
+		set->queue_depth = 2;
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		err = blk_mq_alloc_tag_set(set);
+		if (err)
+			goto exit_put_disks;
+
+		swd->unit[drive].disk->queue = blk_mq_init_queue(set);
+		if (IS_ERR(swd->unit[drive].disk->queue)) {
+			err = PTR_ERR(swd->unit[drive].disk->queue);
+			swd->unit[drive].disk->queue = NULL;
 			goto exit_put_disks;
 		}
 		blk_queue_bounce_limit(swd->unit[drive].disk->queue,
 				BLK_BOUNCE_HIGH);
-		swd->unit[drive].disk->queue->queuedata = swd;
+		swd->unit[drive].disk->queue->queuedata = &swd->unit[drive];
 		swd->unit[drive].swd = swd;
 	}
 
@@ -895,6 +892,7 @@ static int swim_floppy_init(struct swim_priv *swd)
 				blk_cleanup_queue(disk->queue);
 				disk->queue = NULL;
 			}
+			blk_mq_free_tag_set(&swd->unit[drive].tag_set);
 			put_disk(disk);
 		}
 	} while (drive--);
@@ -970,6 +968,7 @@ static int swim_remove(struct platform_device *dev)
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		del_gendisk(swd->unit[drive].disk);
 		blk_cleanup_queue(swd->unit[drive].disk->queue);
+		blk_mq_free_tag_set(&swd->unit[drive].tag_set);
 		put_disk(swd->unit[drive].disk);
 	}
 
-- 
2.19.1
