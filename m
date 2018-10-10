Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 06/15] loop: Split setting of lo_state from loop_clr_fd
Date: Wed, 10 Oct 2018 12:04:06 +0200
Message-Id: <20181010100415.26525-7-jack@suse.cz>
In-Reply-To: <20181010100415.26525-1-jack@suse.cz>
References: <20181010100415.26525-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Move setting of lo_state to Lo_rundown out into the callers. That will
allow us to unlock loop_ctl_mutex while the loop device is protected
from other changes by its special state.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 52 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b7b3b4ae0896..2410921bd9ff 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -976,7 +976,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		loop_reread_partitions(lo, bdev);
 
 	/* Grab the block_device to prevent its destruction after we
-	 * put /dev/loopXX inode. Later in loop_clr_fd() we bdput(bdev).
+	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
 	return 0;
@@ -1026,31 +1026,15 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
 	return err;
 }
 
-static int loop_clr_fd(struct loop_device *lo)
+static int __loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp = lo->lo_backing_file;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct block_device *bdev = lo->lo_device;
 
-	if (lo->lo_state != Lo_bound)
+	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown))
 		return -ENXIO;
 
-	/*
-	 * If we've explicitly asked to tear down the loop device,
-	 * and it has an elevated reference count, set it for auto-teardown when
-	 * the last reference goes away. This stops $!~#$@ udev from
-	 * preventing teardown because it decided that it needs to run blkid on
-	 * the loopback device whenever they appear. xfstests is notorious for
-	 * failing tests because blkid via udev races with a losetup
-	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
-	 * command to fail with EBUSY.
-	 */
-	if (atomic_read(&lo->lo_refcnt) > 1) {
-		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&loop_ctl_mutex);
-		return 0;
-	}
-
 	if (filp == NULL)
 		return -EINVAL;
 
@@ -1058,7 +1042,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	spin_lock_irq(&lo->lo_lock);
-	lo->lo_state = Lo_rundown;
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
 
@@ -1111,6 +1094,30 @@ static int loop_clr_fd(struct loop_device *lo)
 	return 0;
 }
 
+static int loop_clr_fd(struct loop_device *lo)
+{
+	if (lo->lo_state != Lo_bound)
+		return -ENXIO;
+	/*
+	 * If we've explicitly asked to tear down the loop device,
+	 * and it has an elevated reference count, set it for auto-teardown when
+	 * the last reference goes away. This stops $!~#$@ udev from
+	 * preventing teardown because it decided that it needs to run blkid on
+	 * the loopback device whenever they appear. xfstests is notorious for
+	 * failing tests because blkid via udev races with a losetup
+	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
+	 * command to fail with EBUSY.
+	 */
+	if (atomic_read(&lo->lo_refcnt) > 1) {
+		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
+		mutex_unlock(&loop_ctl_mutex);
+		return 0;
+	}
+	lo->lo_state = Lo_rundown;
+
+	return __loop_clr_fd(lo);
+}
+
 static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
@@ -1692,11 +1699,14 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		goto out_unlock;
 
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
+		if (lo->lo_state != Lo_bound)
+			goto out_unlock;
+		lo->lo_state = Lo_rundown;
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		err = loop_clr_fd(lo);
+		err = __loop_clr_fd(lo);
 		if (!err)
 			return;
 	} else if (lo->lo_state == Lo_bound) {
-- 
2.16.4
