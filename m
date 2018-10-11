Return-Path: <osandov@osandov.com>
Return-Path: <osandov@osandov.com>
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	kernel-team@fb.com,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 10/11] ataflop: convert to blk-mq
Date: Thu, 11 Oct 2018 12:20:50 -0700
Message-Id: <92c17caefba4d9a12d643db6fdc614f4bf0900bd.1539284959.git.osandov@fb.com>
In-Reply-To: <cover.1539284959.git.osandov@fb.com>
References: <cover.1539284959.git.osandov@fb.com>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

This driver is already pretty broken, in that it has two wait_events()
(one in stdma_lock()) in request_fn. Get rid of the first one by
freezing/quiescing the queue on format, and the second one by replacing
it with stdma_try_lock(). The rest is straightforward. Compile-tested
only and probably incorrect.

Cc: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 drivers/block/ataflop.c | 183 ++++++++++++++++++----------------------
 1 file changed, 81 insertions(+), 102 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 0144d598ac47..158d4dde6ad1 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -66,7 +66,7 @@
 #include <linux/fd.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
 #include <linux/mutex.h>
 #include <linux/completion.h>
 #include <linux/wait.h>
@@ -81,7 +81,6 @@
 
 static DEFINE_MUTEX(ataflop_mutex);
 static struct request *fd_request;
-static int fdc_queue;
 
 /*
  * WD1772 stuff
@@ -300,6 +299,7 @@ static struct atari_floppy_struct {
 	struct gendisk *disk;
 	int ref;
 	int type;
+	struct blk_mq_tag_set tag_set;
 } unit[FD_MAX_UNITS];
 
 #define	UD	unit[drive]
@@ -379,9 +379,6 @@ static int IsFormatting = 0, FormatError;
 static int UserSteprate[FD_MAX_UNITS] = { -1, -1 };
 module_param_array(UserSteprate, int, NULL, 0);
 
-/* Synchronization of FDC access. */
-static volatile int fdc_busy = 0;
-static DECLARE_WAIT_QUEUE_HEAD(fdc_wait);
 static DECLARE_COMPLETION(format_wait);
 
 static unsigned long changed_floppies = 0xff, fake_change = 0;
@@ -441,7 +438,6 @@ static void fd_times_out(struct timer_list *unused);
 static void finish_fdc( void );
 static void finish_fdc_done( int dummy );
 static void setup_req_params( int drive );
-static void redo_fd_request( void);
 static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
                      cmd, unsigned long param);
 static void fd_probe( int drive );
@@ -459,8 +455,11 @@ static DEFINE_TIMER(fd_timer, check_change);
 	
 static void fd_end_request_cur(blk_status_t err)
 {
-	if (!__blk_end_request_cur(fd_request, err))
+	if (!blk_update_request(fd_request, err,
+				blk_rq_cur_bytes(fd_request))) {
+		__blk_mq_end_request(fd_request, err);
 		fd_request = NULL;
+	}
 }
 
 static inline void start_motor_off_timer(void)
@@ -706,7 +705,6 @@ static void fd_error( void )
 		if (SelectedDrive != -1)
 			SUD.track = -1;
 	}
-	redo_fd_request();
 }
 
 
@@ -724,14 +722,15 @@ static void fd_error( void )
 
 static int do_format(int drive, int type, struct atari_format_descr *desc)
 {
+	struct request_queue *q = unit[drive].disk->queue;
 	unsigned char	*p;
 	int sect, nsect;
 	unsigned long	flags;
+	int ret;
 
-	DPRINT(("do_format( dr=%d tr=%d he=%d offs=%d )\n",
-		drive, desc->track, desc->head, desc->sect_offset ));
+	blk_mq_freeze_queue(q);
+	blk_mq_quiesce_queue(q);
 
-	wait_event(fdc_wait, cmpxchg(&fdc_busy, 0, 1) == 0);
 	local_irq_save(flags);
 	stdma_lock(floppy_irq, NULL);
 	atari_turnon_irq( IRQ_MFP_FDC ); /* should be already, just to be sure */
@@ -740,16 +739,16 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 	if (type) {
 		if (--type >= NUM_DISK_MINORS ||
 		    minor2disktype[type].drive_types > DriveType) {
-			redo_fd_request();
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		type = minor2disktype[type].index;
 		UDT = &atari_disk_type[type];
 	}
 
 	if (!UDT || desc->track >= UDT->blocks/UDT->spt/2 || desc->head >= 2) {
-		redo_fd_request();
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
 	nsect = UDT->spt;
@@ -788,8 +787,11 @@ static int do_format(int drive, int type, struct atari_format_descr *desc)
 
 	wait_for_completion(&format_wait);
 
-	redo_fd_request();
-	return( FormatError ? -EIO : 0 );	
+	ret = FormatError ? -EIO : 0;
+out:
+	blk_mq_unquiesce_queue(q);
+	blk_mq_unfreeze_queue(q);
+	return ret;
 }
 
 
@@ -819,7 +821,6 @@ static void do_fd_action( int drive )
 		    else {
 			/* all sectors finished */
 			fd_end_request_cur(BLK_STS_OK);
-			redo_fd_request();
 			return;
 		    }
 		}
@@ -1224,7 +1225,6 @@ static void fd_rwsec_done1(int status)
 	else {
 		/* all sectors finished */
 		fd_end_request_cur(BLK_STS_OK);
-		redo_fd_request();
 	}
 	return;
   
@@ -1382,8 +1382,6 @@ static void finish_fdc_done( int dummy )
 
 	local_irq_save(flags);
 	stdma_release();
-	fdc_busy = 0;
-	wake_up( &fdc_wait );
 	local_irq_restore(flags);
 
 	DPRINT(("finish_fdc() finished\n"));
@@ -1473,59 +1471,34 @@ static void setup_req_params( int drive )
 			ReqTrack, ReqSector, (unsigned long)ReqData ));
 }
 
-/*
- * Round-robin between our available drives, doing one request from each
- */
-static struct request *set_next_request(void)
+static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
+				     const struct blk_mq_queue_data *bd)
 {
-	struct request_queue *q;
-	int old_pos = fdc_queue;
-	struct request *rq = NULL;
-
-	do {
-		q = unit[fdc_queue].disk->queue;
-		if (++fdc_queue == FD_MAX_UNITS)
-			fdc_queue = 0;
-		if (q) {
-			rq = blk_fetch_request(q);
-			if (rq) {
-				rq->error_count = 0;
-				break;
-			}
-		}
-	} while (fdc_queue != old_pos);
-
-	return rq;
-}
-
+	struct atari_floppy_struct *floppy = bd->rq->rq_disk->private_data;
+	int drive = floppy - unit;
+	int type = floppy->type;
 
-static void redo_fd_request(void)
-{
-	int drive, type;
-	struct atari_floppy_struct *floppy;
+	spin_lock_irq(&ataflop_lock);
+	if (fd_request) {
+		spin_unlock_irq(&ataflop_lock);
+		return BLK_STS_DEV_RESOURCE;
+	}
+	if (!stdma_try_lock(floppy_irq, NULL))  {
+		spin_unlock_irq(&ataflop_lock);
+		return BLK_STS_RESOURCE;
+	}
+	fd_request = bd->rq;
+	blk_mq_start_request(fd_request);
 
-	DPRINT(("redo_fd_request: fd_request=%p dev=%s fd_request->sector=%ld\n",
-		fd_request, fd_request ? fd_request->rq_disk->disk_name : "",
-		fd_request ? blk_rq_pos(fd_request) : 0 ));
+	atari_disable_irq( IRQ_MFP_FDC );
 
 	IsFormatting = 0;
 
-repeat:
-	if (!fd_request) {
-		fd_request = set_next_request();
-		if (!fd_request)
-			goto the_end;
-	}
-
-	floppy = fd_request->rq_disk->private_data;
-	drive = floppy - unit;
-	type = floppy->type;
-	
 	if (!UD.connected) {
 		/* drive not connected */
 		printk(KERN_ERR "Unknown Device: fd%d\n", drive );
 		fd_end_request_cur(BLK_STS_IOERR);
-		goto repeat;
+		goto out;
 	}
 		
 	if (type == 0) {
@@ -1541,23 +1514,18 @@ static void redo_fd_request(void)
 		if (--type >= NUM_DISK_MINORS) {
 			printk(KERN_WARNING "fd%d: invalid disk format", drive );
 			fd_end_request_cur(BLK_STS_IOERR);
-			goto repeat;
+			goto out;
 		}
 		if (minor2disktype[type].drive_types > DriveType)  {
 			printk(KERN_WARNING "fd%d: unsupported disk format", drive );
 			fd_end_request_cur(BLK_STS_IOERR);
-			goto repeat;
+			goto out;
 		}
 		type = minor2disktype[type].index;
 		UDT = &atari_disk_type[type];
 		set_capacity(floppy->disk, UDT->blocks);
 		UD.autoprobe = 0;
 	}
-	
-	if (blk_rq_pos(fd_request) + 1 > UDT->blocks) {
-		fd_end_request_cur(BLK_STS_IOERR);
-		goto repeat;
-	}
 
 	/* stop deselect timer */
 	del_timer( &motor_off_timer );
@@ -1569,22 +1537,13 @@ static void redo_fd_request(void)
 	setup_req_params( drive );
 	do_fd_action( drive );
 
-	return;
-
-  the_end:
-	finish_fdc();
-}
-
-
-void do_fd_request(struct request_queue * q)
-{
-	DPRINT(("do_fd_request for pid %d\n",current->pid));
-	wait_event(fdc_wait, cmpxchg(&fdc_busy, 0, 1) == 0);
-	stdma_lock(floppy_irq, NULL);
-
-	atari_disable_irq( IRQ_MFP_FDC );
-	redo_fd_request();
+	if (bd->last)
+		finish_fdc();
 	atari_enable_irq( IRQ_MFP_FDC );
+
+out:
+	spin_unlock_irq(&ataflop_lock);
+	return BLK_STS_OK;
 }
 
 static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
@@ -1662,7 +1621,6 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 		/* what if type > 0 here? Overwrite specified entry ? */
 		if (type) {
 		        /* refuse to re-set a predefined type for now */
-			redo_fd_request();
 			return -EINVAL;
 		}
 
@@ -1730,10 +1688,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode,
 
 		/* sanity check */
 		if (setprm.track != dtp->blocks/dtp->spt/2 ||
-		    setprm.head != 2) {
-			redo_fd_request();
+		    setprm.head != 2)
 			return -EINVAL;
-		}
 
 		UDT = dtp;
 		set_capacity(floppy->disk, UDT->blocks);
@@ -1989,6 +1945,10 @@ static const struct block_device_operations floppy_fops = {
 	.revalidate_disk= floppy_revalidate,
 };
 
+static const struct blk_mq_ops ataflop_mq_ops = {
+	.queue_rq = ataflop_queue_rq,
+};
+
 static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 {
 	int drive = *part & 3;
@@ -2002,6 +1962,7 @@ static struct kobject *floppy_find(dev_t dev, int *part, void *data)
 static int __init atari_floppy_init (void)
 {
 	int i;
+	int ret;
 
 	if (!MACH_IS_ATARI)
 		/* Amiga, Mac, ... don't have Atari-compatible floppy :-) */
@@ -2011,14 +1972,30 @@ static int __init atari_floppy_init (void)
 		return -EBUSY;
 
 	for (i = 0; i < FD_MAX_UNITS; i++) {
+		struct blk_mq_tag_set *set;
+
 		unit[i].disk = alloc_disk(1);
-		if (!unit[i].disk)
-			goto Enomem;
+		if (!unit[i].disk) {
+			ret = -ENOMEM;
+			goto err;
+		}
 
-		unit[i].disk->queue = blk_init_queue(do_fd_request,
-						     &ataflop_lock);
-		if (!unit[i].disk->queue)
-			goto Enomem;
+		set = &unit[i].tag_set;
+		set->ops = &ataflop_mq_ops;
+		set->nr_hw_queues = 1;
+		set->queue_depth = 2;
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		ret = blk_mq_alloc_tag_set(set);
+		if (ret)
+			goto err;
+
+		unit[i].disk->queue = blk_mq_init_queue(set);
+		if (IS_ERR(unit[i].disk->queue)) {
+			ret = PTR_ERR(unit[i].disk->queue);
+			unit[i].disk->queue = NULL;
+			goto err;
+		}
 	}
 
 	if (UseTrackbuffer < 0)
@@ -2035,7 +2012,8 @@ static int __init atari_floppy_init (void)
 	DMABuffer = atari_stram_alloc(BUFFER_SIZE+512, "ataflop");
 	if (!DMABuffer) {
 		printk(KERN_ERR "atari_floppy_init: cannot get dma buffer\n");
-		goto Enomem;
+		ret = -ENOMEM;
+		goto err;
 	}
 	TrackBuffer = DMABuffer + 512;
 	PhysDMABuffer = atari_stram_to_phys(DMABuffer);
@@ -2063,7 +2041,8 @@ static int __init atari_floppy_init (void)
 	config_types();
 
 	return 0;
-Enomem:
+
+err:
 	do {
 		struct gendisk *disk = unit[i].disk;
 
@@ -2072,12 +2051,13 @@ static int __init atari_floppy_init (void)
 				blk_cleanup_queue(disk->queue);
 				disk->queue = NULL;
 			}
+			blk_mq_free_tag_set(&unit[i].tag_set);
 			put_disk(unit[i].disk);
 		}
 	} while (i--);
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-	return -ENOMEM;
+	return ret;
 }
 
 #ifndef MODULE
@@ -2124,11 +2104,10 @@ static void __exit atari_floppy_exit(void)
 	int i;
 	blk_unregister_region(MKDEV(FLOPPY_MAJOR, 0), 256);
 	for (i = 0; i < FD_MAX_UNITS; i++) {
-		struct request_queue *q = unit[i].disk->queue;
-
 		del_gendisk(unit[i].disk);
+		blk_cleanup_queue(unit[i].disk->queue);
+		blk_mq_free_tag_set(&unit[i].tag_set);
 		put_disk(unit[i].disk);
-		blk_cleanup_queue(q);
 	}
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 
-- 
2.19.1
