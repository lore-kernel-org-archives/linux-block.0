Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Subject: [PATCH 2/4] block/loop: Use global lock for ioctl() operation.
Date: Wed, 26 Sep 2018 00:26:47 +0900
Message-Id: <1537889209-7208-2-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1537889209-7208-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1537889209-7208-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
List-ID: <linux-block@vger.kernel.org>

syzbot is reporting NULL pointer dereference [1] which is caused by
race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
loop devices at loop_validate_file() without holding corresponding
lo->lo_ctl_mutex locks.

Since ioctl() request on loop devices is not frequent operation, we don't
need fine grained locking. Let's use global lock in order to allow safe
traversal at loop_validate_file().

Note that syzbot is also reporting circular locking dependency between
bdev->bd_mutex and lo->lo_ctl_mutex [2] which is caused by calling
blkdev_reread_part() with lock held. This patch does not address it.

[1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
[2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 58 ++++++++++++++++++++++++++--------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c2745e6..920cbb1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -85,6 +85,7 @@
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_index_mutex);
+static DEFINE_MUTEX(loop_ctl_mutex);
 
 static int max_part;
 static int part_shift;
@@ -1048,7 +1049,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	 */
 	if (atomic_read(&lo->lo_refcnt) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return 0;
 	}
 
@@ -1101,12 +1102,12 @@ static int loop_clr_fd(struct loop_device *lo)
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	loop_unprepare_queue(lo);
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 	/*
-	 * Need not hold lo_ctl_mutex to fput backing file.
-	 * Calling fput holding lo_ctl_mutex triggers a circular
+	 * Need not hold loop_ctl_mutex to fput backing file.
+	 * Calling fput holding loop_ctl_mutex triggers a circular
 	 * lock dependency possibility warning as fput can take
-	 * bd_mutex which is usually taken before lo_ctl_mutex.
+	 * bd_mutex which is usually taken before loop_ctl_mutex.
 	 */
 	fput(filp);
 	return 0;
@@ -1211,7 +1212,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	int ret;
 
 	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return -ENXIO;
 	}
 
@@ -1230,10 +1231,10 @@ static int loop_clr_fd(struct loop_device *lo)
 		       lo->lo_encrypt_key_size);
 	}
 
-	/* Drop lo_ctl_mutex while we call into the filesystem. */
+	/* Drop loop_ctl_mutex while we call into the filesystem. */
 	path = lo->lo_backing_file->f_path;
 	path_get(&path);
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
 	if (!ret) {
 		info->lo_device = huge_encode_dev(stat.dev);
@@ -1325,7 +1326,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	int err;
 
 	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return -EINVAL;
 	}
 	err = loop_get_status(lo, &info64);
@@ -1343,7 +1344,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	int err;
 
 	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return -EINVAL;
 	}
 	err = loop_get_status(lo, &info64);
@@ -1401,7 +1402,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
-	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
+	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 	if (err)
 		goto out_unlocked;
 
@@ -1413,7 +1414,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		err = loop_change_fd(lo, bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		/* loop_clr_fd would have unlocked lo_ctl_mutex on success */
+		/* loop_clr_fd would have unlocked loop_ctl_mutex on success */
 		err = loop_clr_fd(lo);
 		if (!err)
 			goto out_unlocked;
@@ -1426,7 +1427,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
+		/* loop_get_status() unlocks loop_ctl_mutex */
 		goto out_unlocked;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
@@ -1436,7 +1437,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
+		/* loop_get_status() unlocks loop_ctl_mutex */
 		goto out_unlocked;
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
@@ -1456,7 +1457,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 
 out_unlocked:
 	return err;
@@ -1573,7 +1574,7 @@ struct compat_loop_info {
 	int err;
 
 	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		return -EINVAL;
 	}
 	err = loop_get_status(lo, &info64);
@@ -1590,19 +1591,19 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = mutex_lock_killable(&lo->lo_ctl_mutex);
+		err = mutex_lock_killable(&loop_ctl_mutex);
 		if (!err) {
 			err = loop_set_status_compat(lo,
 						     (const struct compat_loop_info __user *)arg);
-			mutex_unlock(&lo->lo_ctl_mutex);
+			mutex_unlock(&loop_ctl_mutex);
 		}
 		break;
 	case LOOP_GET_STATUS:
-		err = mutex_lock_killable(&lo->lo_ctl_mutex);
+		err = mutex_lock_killable(&loop_ctl_mutex);
 		if (!err) {
 			err = loop_get_status_compat(lo,
 						     (struct compat_loop_info __user *)arg);
-			/* loop_get_status() unlocks lo_ctl_mutex */
+			/* loop_get_status() unlocks loop_ctl_mutex */
 		}
 		break;
 	case LOOP_SET_CAPACITY:
@@ -1649,7 +1650,7 @@ static void __lo_release(struct loop_device *lo)
 	if (atomic_dec_return(&lo->lo_refcnt))
 		return;
 
-	mutex_lock(&lo->lo_ctl_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1667,7 +1668,7 @@ static void __lo_release(struct loop_device *lo)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
 
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
@@ -1713,10 +1714,10 @@ static int unregister_transfer_cb(int id, void *ptr, void *data)
 	struct loop_device *lo = ptr;
 	struct loop_func_table *xfer = data;
 
-	mutex_lock(&lo->lo_ctl_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_encryption == xfer)
 		loop_release_xfer(lo);
-	mutex_unlock(&lo->lo_ctl_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 	return 0;
 }
 
@@ -1897,7 +1898,6 @@ static int loop_add(struct loop_device **l, int i)
 	if (!part_shift)
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	disk->flags |= GENHD_FL_EXT_DEVT;
-	mutex_init(&lo->lo_ctl_mutex);
 	atomic_set(&lo->lo_refcnt, 0);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
@@ -2010,21 +2010,21 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
-		ret = mutex_lock_killable(&lo->lo_ctl_mutex);
+		ret = mutex_lock_killable(&loop_ctl_mutex);
 		if (ret)
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
-			mutex_unlock(&lo->lo_ctl_mutex);
+			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
-			mutex_unlock(&lo->lo_ctl_mutex);
+			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
-		mutex_unlock(&lo->lo_ctl_mutex);
+		mutex_unlock(&loop_ctl_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 4d42c7a..af75a5e 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -54,7 +54,6 @@ struct loop_device {
 
 	spinlock_t		lo_lock;
 	int			lo_state;
-	struct mutex		lo_ctl_mutex;
 	struct kthread_worker	worker;
 	struct task_struct	*worker_task;
 	bool			use_dio;
-- 
1.8.3.1
