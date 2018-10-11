Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 04/11] swim3: convert to blk-mq
Date: Thu, 11 Oct 2018 12:20:44 -0700
Message-Id: <9f506128a665c5c2bdcf5d4da11bf00faa28e44d.1539284959.git.osandov@fb.com>
In-Reply-To: <cover.1539284959.git.osandov@fb.com>
References: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Pretty simple conversion. grab_drive() could probably be replaced by
some freeze/quiesce incantation, but I left it alone, and just used
freeze/quiesce for eject. Compile-tested only.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/swim3.c | 163 +++++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 88 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index df7ebe016e2c..cc28f17bfa5b 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -25,7 +25,7 @@
 #include <linux/delay.h>
 #include <linux/fd.h>
 #include <linux/ioctl.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
@@ -206,6 +206,7 @@ struct floppy_state {
 	char	dbdma_cmd_space[5 * sizeof(struct dbdma_cmd)];
 	int	index;
 	struct request *cur_req;
+	struct blk_mq_tag_set tag_set;
 };
 
 #define swim3_err(fmt, arg...)	dev_err(&fs->mdev->ofdev.dev, "[fd%d] " fmt, fs->index, arg)
@@ -260,16 +261,15 @@ static int floppy_revalidate(struct gendisk *disk);
 static bool swim3_end_request(struct floppy_state *fs, blk_status_t err, unsigned int nr_bytes)
 {
 	struct request *req = fs->cur_req;
-	int rc;
 
 	swim3_dbg("  end request, err=%d nr_bytes=%d, cur_req=%p\n",
 		  err, nr_bytes, req);
 
 	if (err)
 		nr_bytes = blk_rq_cur_bytes(req);
-	rc = __blk_end_request(req, err, nr_bytes);
-	if (rc)
+	if (blk_update_request(req, err, nr_bytes))
 		return true;
+	__blk_mq_end_request(req, err);
 	fs->cur_req = NULL;
 	return false;
 }
@@ -309,86 +309,58 @@ static int swim3_readbit(struct floppy_state *fs, int bit)
 	return (stat & DATA) == 0;
 }
 
-static void start_request(struct floppy_state *fs)
+static blk_status_t swim3_queue_rq(struct blk_mq_hw_ctx *hctx,
+				   const struct blk_mq_queue_data *bd)
 {
-	struct request *req;
+	struct floppy_state *fs = hctx->queue->queuedata;
+	struct request *req = bd->rq;
 	unsigned long x;
 
-	swim3_dbg("start request, initial state=%d\n", fs->state);
-
-	if (fs->state == idle && fs->wanted) {
-		fs->state = available;
-		wake_up(&fs->wait);
-		return;
+	spin_lock_irq(&swim3_lock);
+	if (fs->cur_req || fs->state != idle) {
+		spin_unlock_irq(&swim3_lock);
+		return BLK_STS_DEV_RESOURCE;
 	}
-	while (fs->state == idle) {
-		swim3_dbg("start request, idle loop, cur_req=%p\n", fs->cur_req);
-		if (!fs->cur_req) {
-			fs->cur_req = blk_fetch_request(disks[fs->index]->queue);
-			swim3_dbg("  fetched request %p\n", fs->cur_req);
-			if (!fs->cur_req)
-				break;
-		}
-		req = fs->cur_req;
-
-		if (fs->mdev->media_bay &&
-		    check_media_bay(fs->mdev->media_bay) != MB_FD) {
-			swim3_dbg("%s", "  media bay absent, dropping req\n");
-			swim3_end_request(fs, BLK_STS_IOERR, 0);
-			continue;
-		}
-
-#if 0 /* This is really too verbose */
-		swim3_dbg("do_fd_req: dev=%s cmd=%d sec=%ld nr_sec=%u buf=%p\n",
-			  req->rq_disk->disk_name, req->cmd,
-			  (long)blk_rq_pos(req), blk_rq_sectors(req),
-			  bio_data(req->bio));
-		swim3_dbg("           current_nr_sectors=%u\n",
-			  blk_rq_cur_sectors(req));
-#endif
-
-		if (blk_rq_pos(req) >= fs->total_secs) {
-			swim3_dbg("  pos out of bounds (%ld, max is %ld)\n",
-				  (long)blk_rq_pos(req), (long)fs->total_secs);
-			swim3_end_request(fs, BLK_STS_IOERR, 0);
-			continue;
-		}
-		if (fs->ejected) {
-			swim3_dbg("%s", "  disk ejected\n");
+	blk_mq_start_request(req);
+	fs->cur_req = req;
+	if (fs->mdev->media_bay &&
+	    check_media_bay(fs->mdev->media_bay) != MB_FD) {
+		swim3_dbg("%s", "  media bay absent, dropping req\n");
+		swim3_end_request(fs, BLK_STS_IOERR, 0);
+		goto out;
+	}
+	if (fs->ejected) {
+		swim3_dbg("%s", "  disk ejected\n");
+		swim3_end_request(fs, BLK_STS_IOERR, 0);
+		goto out;
+	}
+	if (rq_data_dir(req) == WRITE) {
+		if (fs->write_prot < 0)
+			fs->write_prot = swim3_readbit(fs, WRITE_PROT);
+		if (fs->write_prot) {
+			swim3_dbg("%s", "  try to write, disk write protected\n");
 			swim3_end_request(fs, BLK_STS_IOERR, 0);
-			continue;
-		}
-
-		if (rq_data_dir(req) == WRITE) {
-			if (fs->write_prot < 0)
-				fs->write_prot = swim3_readbit(fs, WRITE_PROT);
-			if (fs->write_prot) {
-				swim3_dbg("%s", "  try to write, disk write protected\n");
-				swim3_end_request(fs, BLK_STS_IOERR, 0);
-				continue;
-			}
+			goto out;
 		}
-
-		/* Do not remove the cast. blk_rq_pos(req) is now a
-		 * sector_t and can be 64 bits, but it will never go
-		 * past 32 bits for this driver anyway, so we can
-		 * safely cast it down and not have to do a 64/32
-		 * division
-		 */
-		fs->req_cyl = ((long)blk_rq_pos(req)) / fs->secpercyl;
-		x = ((long)blk_rq_pos(req)) % fs->secpercyl;
-		fs->head = x / fs->secpertrack;
-		fs->req_sector = x % fs->secpertrack + 1;
-		fs->state = do_transfer;
-		fs->retries = 0;
-
-		act(fs);
 	}
-}
 
-static void do_fd_request(struct request_queue * q)
-{
-	start_request(q->queuedata);
+	/*
+	 * Do not remove the cast. blk_rq_pos(req) is now a sector_t and can be
+	 * 64 bits, but it will never go past 32 bits for this driver anyway, so
+	 * we can safely cast it down and not have to do a 64/32 division
+	 */
+	fs->req_cyl = ((long)blk_rq_pos(req)) / fs->secpercyl;
+	x = ((long)blk_rq_pos(req)) % fs->secpercyl;
+	fs->head = x / fs->secpertrack;
+	fs->req_sector = x % fs->secpertrack + 1;
+	fs->state = do_transfer;
+	fs->retries = 0;
+
+	act(fs);
+
+out:
+	spin_unlock_irq(&swim3_lock);
+	return BLK_STS_OK;
 }
 
 static void set_timeout(struct floppy_state *fs, int nticks,
@@ -585,7 +557,6 @@ static void scan_timeout(struct timer_list *t)
 	if (fs->retries > 5) {
 		swim3_end_request(fs, BLK_STS_IOERR, 0);
 		fs->state = idle;
-		start_request(fs);
 	} else {
 		fs->state = jogging;
 		act(fs);
@@ -609,7 +580,6 @@ static void seek_timeout(struct timer_list *t)
 	swim3_err("%s", "Seek timeout\n");
 	swim3_end_request(fs, BLK_STS_IOERR, 0);
 	fs->state = idle;
-	start_request(fs);
 	spin_unlock_irqrestore(&swim3_lock, flags);
 }
 
@@ -638,7 +608,6 @@ static void settle_timeout(struct timer_list *t)
 	swim3_err("%s", "Seek settle timeout\n");
 	swim3_end_request(fs, BLK_STS_IOERR, 0);
 	fs->state = idle;
-	start_request(fs);
  unlock:
 	spin_unlock_irqrestore(&swim3_lock, flags);
 }
@@ -667,7 +636,6 @@ static void xfer_timeout(struct timer_list *t)
 	       (long)blk_rq_pos(fs->cur_req));
 	swim3_end_request(fs, BLK_STS_IOERR, 0);
 	fs->state = idle;
-	start_request(fs);
 	spin_unlock_irqrestore(&swim3_lock, flags);
 }
 
@@ -704,7 +672,6 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 				if (fs->retries > 5) {
 					swim3_end_request(fs, BLK_STS_IOERR, 0);
 					fs->state = idle;
-					start_request(fs);
 				} else {
 					fs->state = jogging;
 					act(fs);
@@ -796,7 +763,6 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 					  fs->state, rq_data_dir(req), intr, err);
 				swim3_end_request(fs, BLK_STS_IOERR, 0);
 				fs->state = idle;
-				start_request(fs);
 				break;
 			}
 			fs->retries = 0;
@@ -813,8 +779,6 @@ static irqreturn_t swim3_interrupt(int irq, void *dev_id)
 			} else
 				fs->state = idle;
 		}
-		if (fs->state == idle)
-			start_request(fs);
 		break;
 	default:
 		swim3_err("Don't know what to do in state %d\n", fs->state);
@@ -862,14 +826,19 @@ static int grab_drive(struct floppy_state *fs, enum swim_state state,
 
 static void release_drive(struct floppy_state *fs)
 {
+	struct request_queue *q = disks[fs->index]->queue;
 	unsigned long flags;
 
 	swim3_dbg("%s", "-> release drive\n");
 
 	spin_lock_irqsave(&swim3_lock, flags);
 	fs->state = idle;
-	start_request(fs);
 	spin_unlock_irqrestore(&swim3_lock, flags);
+
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
 }
 
 static int fd_eject(struct floppy_state *fs)
@@ -1089,6 +1058,10 @@ static const struct block_device_operations floppy_fops = {
 	.revalidate_disk= floppy_revalidate,
 };
 
+static const struct blk_mq_ops swim3_mq_ops = {
+	.queue_rq = swim3_queue_rq,
+};
+
 static void swim3_mb_event(struct macio_dev* mdev, int mb_state)
 {
 	struct floppy_state *fs = macio_get_drvdata(mdev);
@@ -1222,10 +1195,22 @@ static int swim3_attach(struct macio_dev *mdev,
 		rc = -ENOMEM;
 		goto out_unregister;
 	}
-	disk->queue = blk_init_queue(do_fd_request, &swim3_lock);
-	if (disk->queue == NULL) {
-		rc = -ENOMEM;
+
+	fs->tag_set.ops = &swim3_mq_ops;
+	fs->tag_set.nr_hw_queues = 1;
+	fs->tag_set.queue_depth = 2;
+	fs->tag_set.numa_node = NUMA_NO_NODE;
+	fs->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+
+	rc = blk_mq_alloc_tag_set(&fs->tag_set);
+	if (rc)
 		goto out_put_disk;
+
+	disk->queue = blk_mq_init_queue(&fs->tag_set);
+	if (IS_ERR(disk->queue)) {
+		rc = PTR_ERR(disk->queue);
+		disk->queue = NULL;
+		goto out_free_tag_set;
 	}
 	blk_queue_bounce_limit(disk->queue, BLK_BOUNCE_HIGH);
 	disk->queue->queuedata = fs;
@@ -1249,6 +1234,8 @@ static int swim3_attach(struct macio_dev *mdev,
 out_cleanup_queue:
 	blk_cleanup_queue(disk->queue);
 	disk->queue = NULL;
+out_free_tag_set:
+	blk_mq_free_tag_set(&fs->tag_set);
 out_put_disk:
 	put_disk(disk);
 out_unregister:
-- 
2.19.1
