Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 10/15] loop: Push loop_ctl_mutex down to loop_set_fd()
Date: Wed, 10 Oct 2018 12:04:10 +0200
Message-Id: <20181010100415.26525-11-jack@suse.cz>
In-Reply-To: <20181010100415.26525-1-jack@suse.cz>
References: <20181010100415.26525-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Push lo_ctl_mutex down to loop_set_fd(). We will need this to be able to
call loop_reread_partitions() without lo_ctl_mutex.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5661489d11a7..b4500d82238d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -919,13 +919,17 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!file)
 		goto out;
 
+	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	if (error)
+		goto out_putf;
+
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
-		goto out_putf;
+		goto out_unlock;
 
 	error = loop_validate_file(file, bdev);
 	if (error)
-		goto out_putf;
+		goto out_unlock;
 
 	mapping = file->f_mapping;
 	inode = mapping->host;
@@ -937,10 +941,10 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	error = -EFBIG;
 	size = get_loop_size(lo, file);
 	if ((loff_t)(sector_t)size != size)
-		goto out_putf;
+		goto out_unlock;
 	error = loop_prepare_queue(lo);
 	if (error)
-		goto out_putf;
+		goto out_unlock;
 
 	error = 0;
 
@@ -979,11 +983,14 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
+	mutex_unlock(&loop_ctl_mutex);
 	return 0;
 
- out_putf:
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
+out_putf:
 	fput(file);
- out:
+out:
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return error;
@@ -1461,12 +1468,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch (cmd) {
 	case LOOP_SET_FD:
-		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-		if (err)
-			return err;
-		err = loop_set_fd(lo, mode, bdev, arg);
-		mutex_unlock(&loop_ctl_mutex);
-		break;
+		return loop_set_fd(lo, mode, bdev, arg);
 	case LOOP_CHANGE_FD:
 		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 		if (err)
-- 
2.16.4
