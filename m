Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 12/14] loop: Move special partition reread handling in loop_clr_fd()
Date: Thu, 27 Sep 2018 13:36:50 +0200
Message-Id: <20180927113652.5422-13-jack@suse.cz>
In-Reply-To: <20180927113652.5422-1-jack@suse.cz>
References: <20180927113652.5422-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

The call of __blkdev_reread_part() from loop_reread_partition() happens
only when we need to invalidate partitions from loop_release(). Thus
move a detection for this into loop_clr_fd() and simplify
loop_reread_partition().

This makes loop_reread_partition() safe to use without loop_ctl_mutex
because we use only lo->lo_number and lo->lo_file_name in case of error
for reporting purposes (thus possibly reporting outdate information is
not a big deal) and we are safe from 'lo' going away under us by
elevated lo->lo_refcnt.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b4ea862f14fd..cce1a32ae6d0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -631,18 +631,7 @@ static void loop_reread_partitions(struct loop_device *lo,
 {
 	int rc;
 
-	/*
-	 * bd_mutex has been held already in release path, so don't
-	 * acquire it if this function is called in such case.
-	 *
-	 * If the reread partition isn't from release path, lo_refcnt
-	 * must be at least one and it can only become zero when the
-	 * current holder is released.
-	 */
-	if (!atomic_read(&lo->lo_refcnt))
-		rc = __blkdev_reread_part(bdev);
-	else
-		rc = blkdev_reread_part(bdev);
+	rc = blkdev_reread_part(bdev);
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
 			__func__, lo->lo_number, lo->lo_file_name, rc);
@@ -1096,8 +1085,24 @@ static int __loop_clr_fd(struct loop_device *lo)
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
-		loop_reread_partitions(lo, bdev);
+	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev) {
+		/*
+		 * bd_mutex has been held already in release path, so don't
+		 * acquire it if this function is called in such case.
+		 *
+		 * If the reread partition isn't from release path, lo_refcnt
+		 * must be at least one and it can only become zero when the
+		 * current holder is released.
+		 */
+		if (!atomic_read(&lo->lo_refcnt))
+			err = __blkdev_reread_part(bdev);
+		else
+			err = blkdev_reread_part(bdev);
+		pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
+			__func__, lo->lo_number, err);
+		/* Device is gone, no point in returning error */
+		err = 0;
+	}
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
-- 
2.16.4
