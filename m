Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 07/11] amiflop: convert to blk-mq
Date: Thu, 11 Oct 2018 12:20:47 -0700
Message-Id: <e7bfd2b7c1572542be4e3f9ce04461f3540ffbd1.1539284959.git.osandov@fb.com>
In-Reply-To: <cover.1539284959.git.osandov@fb.com>
References: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Straightforward conversion, just use the existing amiflop_lock to
serialize access to the controller. Compile-tested only.

Cc: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/amiflop.c | 125 +++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 79 deletions(-)

diff --git a/drivers/block/amiflop.c b/drivers/block/amiflop.c
index eef3b085e70a..1225b802f632 100644
--- a/drivers/block/amiflop.c
+++ b/drivers/block/amiflop.c
@@ -201,6 +201,7 @@ struct amiga_floppy_struct {
 	int dirty;			/* true when trackbuf is not on disk */
 	int status;			/* current error code for unit */
 	struct gendisk *gendisk;
+	struct blk_mq_tag_set tag_set;
 };
 
 /*
@@ -281,7 +282,6 @@ static volatile int selected = -1;	/* currently selected drive */
 static int writepending;
 static int writefromint;
 static char *raw_buf;
-static int fdc_queue;
 
 static DEFINE_SPINLOCK(amiflop_lock);
 
@@ -1454,76 +1454,20 @@ static int get_track(int drive, int track)
 	return -1;
 }
 
-/*
- * Round-robin between our available drives, doing one request from each
- */
-static struct request *set_next_request(void)
-{
-	struct request_queue *q;
-	int cnt = FD_MAX_UNITS;
-	struct request *rq = NULL;
-
-	/* Find next queue we can dispatch from */
-	fdc_queue = fdc_queue + 1;
-	if (fdc_queue == FD_MAX_UNITS)
-		fdc_queue = 0;
-
-	for(cnt = FD_MAX_UNITS; cnt > 0; cnt--) {
-
-		if (unit[fdc_queue].type->code == FD_NODRIVE) {
-			if (++fdc_queue == FD_MAX_UNITS)
-				fdc_queue = 0;
-			continue;
-		}
-
-		q = unit[fdc_queue].gendisk->queue;
-		if (q) {
-			rq = blk_fetch_request(q);
-			if (rq)
-				break;
-		}
-
-		if (++fdc_queue == FD_MAX_UNITS)
-			fdc_queue = 0;
-	}
-
-	return rq;
-}
-
-static void redo_fd_request(void)
+static blk_status_t amiflop_rw_cur_segment(struct amiga_floppy_struct *floppy,
+					   struct request *rq)
 {
-	struct request *rq;
+	int drive = floppy - unit;
 	unsigned int cnt, block, track, sector;
-	int drive;
-	struct amiga_floppy_struct *floppy;
 	char *data;
-	unsigned long flags;
-	blk_status_t err;
-
-next_req:
-	rq = set_next_request();
-	if (!rq) {
-		/* Nothing left to do */
-		return;
-	}
-
-	floppy = rq->rq_disk->private_data;
-	drive = floppy - unit;
 
-next_segment:
-	/* Here someone could investigate to be more efficient */
-	for (cnt = 0, err = BLK_STS_OK; cnt < blk_rq_cur_sectors(rq); cnt++) {
+	for (cnt = 0; cnt < blk_rq_cur_sectors(rq); cnt++) {
 #ifdef DEBUG
 		printk("fd: sector %ld + %d requested for %s\n",
 		       blk_rq_pos(rq), cnt,
 		       (rq_data_dir(rq) == READ) ? "read" : "write");
 #endif
 		block = blk_rq_pos(rq) + cnt;
-		if ((int)block > floppy->blocks) {
-			err = BLK_STS_IOERR;
-			break;
-		}
-
 		track = block / (floppy->dtype->sects * floppy->type->sect_mult);
 		sector = block % (floppy->dtype->sects * floppy->type->sect_mult);
 		data = bio_data(rq->bio) + 512 * cnt;
@@ -1532,10 +1476,8 @@ static void redo_fd_request(void)
 		       "0x%08lx\n", track, sector, data);
 #endif
 
-		if (get_track(drive, track) == -1) {
-			err = BLK_STS_IOERR;
-			break;
-		}
+		if (get_track(drive, track) == -1)
+			return BLK_STS_IOERR;
 
 		if (rq_data_dir(rq) == READ) {
 			memcpy(data, floppy->trackbuf + sector * 512, 512);
@@ -1543,31 +1485,40 @@ static void redo_fd_request(void)
 			memcpy(floppy->trackbuf + sector * 512, data, 512);
 
 			/* keep the drive spinning while writes are scheduled */
-			if (!fd_motor_on(drive)) {
-				err = BLK_STS_IOERR;
-				break;
-			}
+			if (!fd_motor_on(drive))
+				return BLK_STS_IOERR;
 			/*
 			 * setup a callback to write the track buffer
 			 * after a short (1 tick) delay.
 			 */
-			local_irq_save(flags);
-
 			floppy->dirty = 1;
 		        /* reset the timer */
 			mod_timer (flush_track_timer + drive, jiffies + 1);
-			local_irq_restore(flags);
 		}
 	}
 
-	if (__blk_end_request_cur(rq, err))
-		goto next_segment;
-	goto next_req;
+	return BLK_STS_OK;
 }
 
-static void do_fd_request(struct request_queue * q)
+static blk_status_t amiflop_queue_rq(struct blk_mq_hw_ctx *hctx,
+				     const struct blk_mq_queue_data *bd)
 {
-	redo_fd_request();
+	struct request *rq = bd->rq;
+	struct amiga_floppy_struct *floppy = rq->rq_disk->private_data;
+	blk_status_t err;
+
+	if (!spin_trylock_irq(&amiflop_lock))
+		return BLK_STS_DEV_RESOURCE;
+
+	blk_mq_start_request(rq);
+
+	do {
+		err = amiflop_rw_cur_segment(floppy, rq);
+	} while (blk_update_request(rq, err, blk_rq_cur_bytes(rq)));
+	blk_mq_end_request(rq, err);
+
+	spin_unlock_irq(&amiflop_lock);
+	return BLK_STS_OK;
 }
 
 static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
@@ -1818,18 +1769,32 @@ static const struct block_device_operations floppy_fops = {
 	.check_events	= amiga_check_events,
 };
 
+static const struct blk_mq_ops amiflop_mq_ops = {
+	.queue_rq = amiflop_queue_rq,
+};
+
 static struct gendisk *fd_alloc_disk(int drive)
 {
 	struct gendisk *disk;
+	struct blk_mq_tag_set *set;
 
 	disk = alloc_disk(1);
 	if (!disk)
 		goto out;
 
-	disk->queue = blk_init_queue(do_fd_request, &amiflop_lock);
+	set = &unit[drive].tag_set;
+	set->ops = &amiflop_mq_ops;
+	set->nr_hw_queues = 1;
+	set->queue_depth = 2;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = BLK_MQ_F_SHOULD_MERGE;
+	if (blk_mq_alloc_tag_set(set))
+		goto out_put_disk;
+
+	disk->queue = blk_mq_init_queue(set);
 	if (IS_ERR(disk->queue)) {
 		disk->queue = NULL;
-		goto out_put_disk;
+		goto out_free_tag_set;
 	}
 
 	unit[drive].trackbuf = kmalloc(FLOPPY_MAX_SECTORS * 512, GFP_KERNEL);
@@ -1841,6 +1806,8 @@ static struct gendisk *fd_alloc_disk(int drive)
 out_cleanup_queue:
 	blk_cleanup_queue(disk->queue);
 	disk->queue = NULL;
+out_free_tag_set:
+	blk_mq_free_tag_set(set);
 out_put_disk:
 	put_disk(disk);
 out:
-- 
2.19.1
