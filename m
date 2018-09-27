Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 14/14] loop: Fix deadlock when calling blkdev_reread_part()
Date: Thu, 27 Sep 2018 13:36:52 +0200
Message-Id: <20180927113652.5422-15-jack@suse.cz>
In-Reply-To: <20180927113652.5422-1-jack@suse.cz>
References: <20180927113652.5422-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Calling blkdev_reread_part() under loop_ctl_mutex causes lockdep to
complain about circular lock dependency between bdev->bd_mutex and
lo->lo_ctl_mutex. The problem is that on loop device open or close
lo_open() and lo_release() get called with bdev->bd_mutex held and they
need to acquire loop_ctl_mutex. OTOH when loop_reread_partitions() is
called with loop_ctl_mutex held, it will call blkdev_reread_part() which
acquires bdev->bd_mutex. See syzbot report for details [1].

Move call to blkdev_reread_part() in __loop_clr_fd() from under
loop_ctl_mutex to finish fixing of the lockdep warning and the possible
deadlock.

[1] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d1588

Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d2be85c48f03..a0fb7bf62b29 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1031,12 +1031,14 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
 	return err;
 }
 
-static int __loop_clr_fd(struct loop_device *lo)
+static int __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp = NULL;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct block_device *bdev = lo->lo_device;
 	int err = 0;
+	bool partscan = false;
+	int lo_number;
 
 	mutex_lock(&loop_ctl_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
@@ -1089,7 +1091,15 @@ static int __loop_clr_fd(struct loop_device *lo)
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev) {
+	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
+	lo_number = lo->lo_number;
+	lo->lo_flags = 0;
+	if (!part_shift)
+		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+	loop_unprepare_queue(lo);
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
+	if (partscan) {
 		/*
 		 * bd_mutex has been held already in release path, so don't
 		 * acquire it if this function is called in such case.
@@ -1098,21 +1108,15 @@ static int __loop_clr_fd(struct loop_device *lo)
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
 		 */
-		if (!atomic_read(&lo->lo_refcnt))
+		if (release)
 			err = __blkdev_reread_part(bdev);
 		else
 			err = blkdev_reread_part(bdev);
 		pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
-			__func__, lo->lo_number, err);
+			__func__, lo_number, err);
 		/* Device is gone, no point in returning error */
 		err = 0;
 	}
-	lo->lo_flags = 0;
-	if (!part_shift)
-		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
-	loop_unprepare_queue(lo);
-out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
 	/*
 	 * Need not hold loop_ctl_mutex to fput backing file.
 	 * Calling fput holding loop_ctl_mutex triggers a circular
@@ -1153,7 +1157,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&loop_ctl_mutex);
 
-	return __loop_clr_fd(lo);
+	return __loop_clr_fd(lo, false);
 }
 
 static int
@@ -1714,7 +1718,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		__loop_clr_fd(lo);
+		__loop_clr_fd(lo, true);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
-- 
2.16.4
