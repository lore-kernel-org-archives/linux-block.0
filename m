Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/4] block/loop: Reorganize loop_reread_partitions() callers.
Date: Wed, 26 Sep 2018 00:26:48 +0900
Message-Id: <1537889209-7208-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1537889209-7208-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1537889209-7208-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

We will drop loop_ctl_mutex before calling blkdev_reread_part() in
order to fix circular locking dependency between bdev->bd_mutex and
loop_ctl_mutex. To do that we need to make sure that we won't touch
"struct loop_device" after releasing loop_ctl_mutex.

As a preparation step, this patch reorganizes loop_reread_partitions()
callers. According to Ming Lei, calling loop_unprepare_queue() before
loop_reread_partitions() (like we did until 3.19) is fine. Therefore,
this patch will not cause user visible changes.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 920cbb1..4b05a27 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -632,6 +632,11 @@ static void loop_reread_partitions(struct loop_device *lo,
 				   struct block_device *bdev)
 {
 	int rc;
+	char filename[LO_NAME_SIZE];
+	const int num = lo->lo_number;
+	const int count = atomic_read(&lo->lo_refcnt);
+
+	memcpy(filename, lo->lo_file_name, sizeof(filename));
 
 	/*
 	 * bd_mutex has been held already in release path, so don't
@@ -641,13 +646,13 @@ static void loop_reread_partitions(struct loop_device *lo,
 	 * must be at least one and it can only become zero when the
 	 * current holder is released.
 	 */
-	if (!atomic_read(&lo->lo_refcnt))
+	if (!count)
 		rc = __blkdev_reread_part(bdev);
 	else
 		rc = blkdev_reread_part(bdev);
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
-			__func__, lo->lo_number, lo->lo_file_name, rc);
+			__func__, num, filename, rc);
 }
 
 static inline int is_loop_device(struct file *file)
@@ -730,9 +735,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	fput(old_file);
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
 		loop_reread_partitions(lo, bdev);
+	fput(old_file);
 	return 0;
 
  out_putf:
@@ -971,16 +976,18 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
 
+	/*
+	 * Grab the block_device to prevent its destruction after we
+	 * put /dev/loopXX inode. Later in loop_clr_fd() we bdput(bdev).
+	 */
+	bdgrab(bdev);
+
 	lo->lo_state = Lo_bound;
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
 		loop_reread_partitions(lo, bdev);
 
-	/* Grab the block_device to prevent its destruction after we
-	 * put /dev/loopXX inode. Later in loop_clr_fd() we bdput(bdev).
-	 */
-	bdgrab(bdev);
 	return 0;
 
  out_putf:
@@ -1033,6 +1040,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct file *filp = lo->lo_backing_file;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct block_device *bdev = lo->lo_device;
+	bool reread;
 
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
@@ -1096,12 +1104,13 @@ static int loop_clr_fd(struct loop_device *lo)
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
-		loop_reread_partitions(lo, bdev);
+	reread = (lo->lo_flags & LO_FLAGS_PARTSCAN) && bdev;
+	loop_unprepare_queue(lo);
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
-	loop_unprepare_queue(lo);
+	if (reread)
+		loop_reread_partitions(lo, bdev);
 	mutex_unlock(&loop_ctl_mutex);
 	/*
 	 * Need not hold loop_ctl_mutex to fput backing file.
-- 
1.8.3.1
