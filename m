Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
Subject: [PATCH] block/loop: Don't hold lock while rereading partition.
Date: Tue, 25 Sep 2018 14:10:03 +0900
Message-Id: <1537852203-3193-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

syzbot is reporting circular locking dependency between bdev->bd_mutex and
lo->lo_ctl_mutex [1] which is caused by calling blkdev_reread_part() with
lock held. Don't hold loop_ctl_mutex while calling blkdev_reread_part().
Also, bring bdgrab() at loop_set_fd() to before loop_reread_partitions()
in case loop_clr_fd() is called while blkdev_reread_part() from
loop_set_fd() is in progress.

[1] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
---
 drivers/block/loop.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 920cbb1..877cca8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -632,7 +632,12 @@ static void loop_reread_partitions(struct loop_device *lo,
 				   struct block_device *bdev)
 {
 	int rc;
+	char filename[LO_NAME_SIZE];
+	const int num = lo->lo_number;
+	const int count = atomic_read(&lo->lo_refcnt);
 
+	memcpy(filename, lo->lo_file_name, sizeof(filename));
+	mutex_unlock(&loop_ctl_mutex);
 	/*
 	 * bd_mutex has been held already in release path, so don't
 	 * acquire it if this function is called in such case.
@@ -641,13 +646,14 @@ static void loop_reread_partitions(struct loop_device *lo,
 	 * must be at least one and it can only become zero when the
 	 * current holder is released.
 	 */
-	if (!atomic_read(&lo->lo_refcnt))
+	if (!count)
 		rc = __blkdev_reread_part(bdev);
 	else
 		rc = blkdev_reread_part(bdev);
+	mutex_lock(&loop_ctl_mutex);
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
-			__func__, lo->lo_number, lo->lo_file_name, rc);
+			__func__, num, filename, rc);
 }
 
 static inline int is_loop_device(struct file *file)
@@ -971,16 +977,18 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
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
-- 
1.8.3.1
