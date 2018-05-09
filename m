Return-Path: <linux-block-owner@vger.kernel.org>
Received: from www262.sakura.ne.jp ([202.181.97.72]:36079 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933778AbeEIKyL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 May 2018 06:54:11 -0400
To: ebiggers3@gmail.com, dvyukov@google.com, jack@suse.cz,
        tytso@mit.edu, gmazyland@gmail.com
Cc: syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org
Subject: [PATCH v2] block/loop: Serialize ioctl operations.
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
        <CACT4Y+bGjnajib6P4a0SxYkNUJpg_x8abEkec8AR+oBmC=-QUQ@mail.gmail.com>
        <20171105201834.GA8126@zzz.localdomain>
        <201804162302.GBI43737.OLFSOFQHVJMFtO@I-love.SAKURA.ne.jp>
        <201804202306.FGC05220.OOJFMFOSFHtLQV@I-love.SAKURA.ne.jp>
In-Reply-To: <201804202306.FGC05220.OOJFMFOSFHtLQV@I-love.SAKURA.ne.jp>
Message-Id: <201805091954.IHJ95339.FJtQHLOVFFMOOS@I-love.SAKURA.ne.jp>
Date: Wed, 9 May 2018 19:54:09 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>From 86acfa7288c5e6ddab26f430e2bd2f42ad1407f0 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Wed, 9 May 2018 13:01:31 +0900
Subject: [PATCH v2] block/loop: Serialize ioctl operations.

syzbot is reporting NULL pointer dereference [1] which is caused by
race condition between ioctl(loop_fd, LOOP_CLR_FD, 0) versus
ioctl(other_loop_fd, LOOP_SET_FD, loop_fd) due to traversing other
loop devices without holding corresponding locks.

syzbot is also reporting circular locking dependency between bdev->bd_mutex
and lo->lo_ctl_mutex [2] which is caused by calling blkdev_reread_part()
with lock held.

Since ioctl() request on loop devices is not frequent operation, we don't
need fine grained locking. Let's use global lock and simplify the locking
order.

Strategy is that the global lock is held upon entry of ioctl() request,
and release it before either starting operations which might deadlock or
leaving ioctl() request. After the global lock is released, current thread
no longer uses "struct loop_device" memory because it might be modified
by next ioctl() request which was waiting for current ioctl() request.

In order to enforce this strategy, this patch inversed
loop_reread_partitions() and loop_unprepare_queue() in loop_clr_fd().
I don't know whether it breaks something, but I don't have testcases.

Since this patch serializes using global lock, race bugs should no longer
exist. Thus, it will be easy to test whether this patch broke something.

[1] https://syzkaller.appspot.com/bug?id=f3cfe26e785d85f9ee259f385515291d21bd80a3
[2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+bf89c128e05dd6c62523@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+4684a000d5abdade83fac55b1e7d1f935ef1936e@syzkaller.appspotmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/loop.c | 231 ++++++++++++++++++++++++++++-----------------------
 drivers/block/loop.h |   1 -
 2 files changed, 128 insertions(+), 104 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 24f6682..b17fd05 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -81,11 +81,50 @@
 #include <linux/uaccess.h>
 
 static DEFINE_IDR(loop_index_idr);
-static DEFINE_MUTEX(loop_index_mutex);
+static DEFINE_MUTEX(loop_mutex);
+static void *loop_mutex_owner; /* == __mutex_owner(&loop_mutex) */
 
 static int max_part;
 static int part_shift;
 
+/*
+ * lock_loop - Lock loop_mutex.
+ */
+static void lock_loop(void)
+{
+	mutex_lock(&loop_mutex);
+	loop_mutex_owner = current;
+}
+
+/*
+ * lock_loop_killable - Lock loop_mutex unless killed.
+ */
+static int lock_loop_killable(void)
+{
+	int err = mutex_lock_killable(&loop_mutex);
+
+	if (err)
+		return err;
+	loop_mutex_owner = current;
+	return 0;
+}
+
+/*
+ * unlock_loop - Unlock loop_mutex as needed.
+ *
+ * Explicitly call this function before calling fput() or blkdev_reread_part()
+ * in order to avoid circular lock dependency. After this function is called,
+ * current thread is no longer allowed to access "struct loop_device" memory,
+ * for another thread would access that memory as soon as loop_mutex is held.
+ */
+static void unlock_loop(void)
+{
+	if (loop_mutex_owner == current) {
+		loop_mutex_owner = NULL;
+		mutex_unlock(&loop_mutex);
+	}
+}
+
 static int transfer_xor(struct loop_device *lo, int cmd,
 			struct page *raw_page, unsigned raw_off,
 			struct page *loop_page, unsigned loop_off,
@@ -626,7 +665,12 @@ static void loop_reread_partitions(struct loop_device *lo,
 				   struct block_device *bdev)
 {
 	int rc;
+	/* Save variables which might change after unlock_loop() is called. */
+	char filename[sizeof(lo->lo_file_name)];
+	const int num = lo->lo_number;
 
+	memmove(filename, lo->lo_file_name, sizeof(filename));
+	unlock_loop();
 	/*
 	 * bd_mutex has been held already in release path, so don't
 	 * acquire it if this function is called in such case.
@@ -641,7 +685,7 @@ static void loop_reread_partitions(struct loop_device *lo,
 		rc = blkdev_reread_part(bdev);
 	if (rc)
 		pr_warn("%s: partition scan of loop%d (%s) failed (rc=%d)\n",
-			__func__, lo->lo_number, lo->lo_file_name, rc);
+			__func__, num, filename, rc);
 }
 
 static inline int is_loop_device(struct file *file)
@@ -689,6 +733,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	struct inode	*inode;
 	int		error;
 
+	lockdep_assert_held(&loop_mutex);
 	error = -ENXIO;
 	if (lo->lo_state != Lo_bound)
 		goto out;
@@ -726,12 +771,14 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	fput(old_file);
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
-		loop_reread_partitions(lo, bdev);
+		loop_reread_partitions(lo, bdev); /* calls unlock_loop() */
+	unlock_loop();
+	fput(old_file);
 	return 0;
 
  out_putf:
+	unlock_loop();
 	fput(file);
  out:
 	return error;
@@ -909,6 +956,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	int		error;
 	loff_t		size;
 
+	lockdep_assert_held(&loop_mutex);
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
 
@@ -967,19 +1015,21 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
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
-		loop_reread_partitions(lo, bdev);
-
-	/* Grab the block_device to prevent its destruction after we
-	 * put /dev/loopXX inode. Later in loop_clr_fd() we bdput(bdev).
-	 */
-	bdgrab(bdev);
+		loop_reread_partitions(lo, bdev); /* calls unlock_loop() */
 	return 0;
 
  out_putf:
+	unlock_loop();
 	fput(file);
  out:
 	/* This is safe: open() is still holding a reference. */
@@ -1029,7 +1079,9 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct file *filp = lo->lo_backing_file;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct block_device *bdev = lo->lo_device;
+	bool reread;
 
+	lockdep_assert_held(&loop_mutex);
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
@@ -1045,7 +1097,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	 */
 	if (atomic_read(&lo->lo_refcnt) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&lo->lo_ctl_mutex);
 		return 0;
 	}
 
@@ -1090,20 +1141,14 @@ static int loop_clr_fd(struct loop_device *lo)
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
-
-	if (lo->lo_flags & LO_FLAGS_PARTSCAN && bdev)
-		loop_reread_partitions(lo, bdev);
+	reread = (lo->lo_flags & LO_FLAGS_PARTSCAN) && bdev;
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	loop_unprepare_queue(lo);
-	mutex_unlock(&lo->lo_ctl_mutex);
-	/*
-	 * Need not hold lo_ctl_mutex to fput backing file.
-	 * Calling fput holding lo_ctl_mutex triggers a circular
-	 * lock dependency possibility warning as fput can take
-	 * bd_mutex which is usually taken before lo_ctl_mutex.
-	 */
+	if (reread)
+		loop_reread_partitions(lo, bdev); /* calls unlock_loop() */
+	unlock_loop();
 	fput(filp);
 	return 0;
 }
@@ -1193,7 +1238,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	     !(lo->lo_flags & LO_FLAGS_PARTSCAN)) {
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
-		loop_reread_partitions(lo, lo->lo_device);
+		loop_reread_partitions(lo, lo->lo_device); /* calls unlock_loop() */
 	}
 
 	return err;
@@ -1202,14 +1247,13 @@ static int loop_clr_fd(struct loop_device *lo)
 static int
 loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 {
-	struct file *file;
+	struct path path;
 	struct kstat stat;
 	int ret;
 
-	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+	lockdep_assert_held(&loop_mutex);
+	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
-	}
 
 	memset(info, 0, sizeof(*info));
 	info->lo_number = lo->lo_number;
@@ -1226,17 +1270,17 @@ static int loop_clr_fd(struct loop_device *lo)
 		       lo->lo_encrypt_key_size);
 	}
 
-	/* Drop lo_ctl_mutex while we call into the filesystem. */
-	file = get_file(lo->lo_backing_file);
-	mutex_unlock(&lo->lo_ctl_mutex);
-	ret = vfs_getattr(&file->f_path, &stat, STATX_INO,
-			  AT_STATX_SYNC_AS_STAT);
+	/* Drop loop_mutex while we call into the filesystem. */
+	path = lo->lo_backing_file->f_path;
+	path_get(&path);
+	unlock_loop();
+	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
 	if (!ret) {
 		info->lo_device = huge_encode_dev(stat.dev);
 		info->lo_inode = stat.ino;
 		info->lo_rdevice = huge_encode_dev(stat.rdev);
 	}
-	fput(file);
+	path_put(&path);
 	return ret;
 }
 
@@ -1298,6 +1342,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct loop_info info;
 	struct loop_info64 info64;
 
+	lockdep_assert_held(&loop_mutex);
 	if (copy_from_user(&info, arg, sizeof (struct loop_info)))
 		return -EFAULT;
 	loop_info64_from_old(&info, &info64);
@@ -1309,6 +1354,7 @@ static int loop_clr_fd(struct loop_device *lo)
 {
 	struct loop_info64 info64;
 
+	lockdep_assert_held(&loop_mutex);
 	if (copy_from_user(&info64, arg, sizeof (struct loop_info64)))
 		return -EFAULT;
 	return loop_set_status(lo, &info64);
@@ -1320,10 +1366,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_old(&info64, &info);
@@ -1338,10 +1382,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err && copy_to_user(arg, &info64, sizeof(info64)))
 		err = -EFAULT;
@@ -1351,6 +1393,7 @@ static int loop_clr_fd(struct loop_device *lo)
 
 static int loop_set_capacity(struct loop_device *lo)
 {
+	lockdep_assert_held(&loop_mutex);
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
@@ -1360,6 +1403,8 @@ static int loop_set_capacity(struct loop_device *lo)
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 {
 	int error = -ENXIO;
+
+	lockdep_assert_held(&loop_mutex);
 	if (lo->lo_state != Lo_bound)
 		goto out;
 
@@ -1373,6 +1418,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 {
+	lockdep_assert_held(&loop_mutex);
 	if (lo->lo_state != Lo_bound)
 		return -ENXIO;
 
@@ -1395,12 +1441,10 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
-	int err;
+	int err = lock_loop_killable();
 
-	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
 	if (err)
-		goto out_unlocked;
-
+		return err;
 	switch (cmd) {
 	case LOOP_SET_FD:
 		err = loop_set_fd(lo, mode, bdev, arg);
@@ -1409,10 +1453,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		err = loop_change_fd(lo, bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		/* loop_clr_fd would have unlocked lo_ctl_mutex on success */
 		err = loop_clr_fd(lo);
-		if (!err)
-			goto out_unlocked;
 		break;
 	case LOOP_SET_STATUS:
 		err = -EPERM;
@@ -1422,8 +1463,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
-		goto out_unlocked;
+		break;
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1432,8 +1472,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 		break;
 	case LOOP_GET_STATUS64:
 		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		/* loop_get_status() unlocks lo_ctl_mutex */
-		goto out_unlocked;
+		break;
 	case LOOP_SET_CAPACITY:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN))
@@ -1452,9 +1491,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	mutex_unlock(&lo->lo_ctl_mutex);
-
-out_unlocked:
+	unlock_loop();
 	return err;
 }
 
@@ -1555,6 +1592,7 @@ struct compat_loop_info {
 	struct loop_info64 info64;
 	int ret;
 
+	lockdep_assert_held(&loop_mutex);
 	ret = loop_info64_from_compat(arg, &info64);
 	if (ret < 0)
 		return ret;
@@ -1568,10 +1606,9 @@ struct compat_loop_info {
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&lo->lo_ctl_mutex);
+	lockdep_assert_held(&loop_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_compat(&info64, arg);
@@ -1586,20 +1623,16 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = mutex_lock_killable(&lo->lo_ctl_mutex);
-		if (!err) {
+		err = lock_loop_killable();
+		if (!err)
 			err = loop_set_status_compat(lo,
 						     (const struct compat_loop_info __user *)arg);
-			mutex_unlock(&lo->lo_ctl_mutex);
-		}
 		break;
 	case LOOP_GET_STATUS:
-		err = mutex_lock_killable(&lo->lo_ctl_mutex);
-		if (!err) {
+		err = lock_loop_killable();
+		if (!err)
 			err = loop_get_status_compat(lo,
 						     (struct compat_loop_info __user *)arg);
-			/* loop_get_status() unlocks lo_ctl_mutex */
-		}
 		break;
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:
@@ -1614,6 +1647,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		err = -ENOIOCTLCMD;
 		break;
 	}
+	unlock_loop();
 	return err;
 }
 #endif
@@ -1621,37 +1655,30 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo;
-	int err = 0;
+	int err = lock_loop_killable();
 
-	mutex_lock(&loop_index_mutex);
+	if (err)
+		return err;
 	lo = bdev->bd_disk->private_data;
-	if (!lo) {
+	if (!lo)
 		err = -ENXIO;
-		goto out;
-	}
-
-	atomic_inc(&lo->lo_refcnt);
-out:
-	mutex_unlock(&loop_index_mutex);
+	else
+		atomic_inc(&lo->lo_refcnt);
+	unlock_loop();
 	return err;
 }
 
 static void __lo_release(struct loop_device *lo)
 {
-	int err;
-
 	if (atomic_dec_return(&lo->lo_refcnt))
 		return;
-
-	mutex_lock(&lo->lo_ctl_mutex);
+	lockdep_assert_held(&loop_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		err = loop_clr_fd(lo);
-		if (!err)
-			return;
+		loop_clr_fd(lo);
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1660,15 +1687,13 @@ static void __lo_release(struct loop_device *lo)
 		blk_mq_freeze_queue(lo->lo_queue);
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
-
-	mutex_unlock(&lo->lo_ctl_mutex);
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
 {
-	mutex_lock(&loop_index_mutex);
+	lock_loop();
 	__lo_release(disk->private_data);
-	mutex_unlock(&loop_index_mutex);
+	unlock_loop();
 }
 
 static const struct block_device_operations lo_fops = {
@@ -1707,10 +1732,8 @@ static int unregister_transfer_cb(int id, void *ptr, void *data)
 	struct loop_device *lo = ptr;
 	struct loop_func_table *xfer = data;
 
-	mutex_lock(&lo->lo_ctl_mutex);
 	if (lo->lo_encryption == xfer)
 		loop_release_xfer(lo);
-	mutex_unlock(&lo->lo_ctl_mutex);
 	return 0;
 }
 
@@ -1722,8 +1745,14 @@ int loop_unregister_transfer(int number)
 	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
 		return -EINVAL;
 
+	/*
+	 * cleanup_cryptoloop() cannot handle errors because it is called
+	 * from module_exit(). Thus, don't give up upon SIGKILL here.
+	 */
+	lock_loop();
 	xfer_funcs[n] = NULL;
 	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
+	unlock_loop();
 	return 0;
 }
 
@@ -1891,7 +1920,6 @@ static int loop_add(struct loop_device **l, int i)
 	if (!part_shift)
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	disk->flags |= GENHD_FL_EXT_DEVT;
-	mutex_init(&lo->lo_ctl_mutex);
 	atomic_set(&lo->lo_refcnt, 0);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
@@ -1967,20 +1995,19 @@ static int loop_lookup(struct loop_device **l, int i)
 static struct kobject *loop_probe(dev_t dev, int *part, void *data)
 {
 	struct loop_device *lo;
-	struct kobject *kobj;
-	int err;
+	struct kobject *kobj = NULL;
+	int err = lock_loop_killable();
 
-	mutex_lock(&loop_index_mutex);
+	*part = 0;
+	if (err)
+		return NULL;
 	err = loop_lookup(&lo, MINOR(dev) >> part_shift);
 	if (err < 0)
 		err = loop_add(&lo, MINOR(dev) >> part_shift);
-	if (err < 0)
-		kobj = NULL;
-	else
+	if (err >= 0)
 		kobj = get_disk_and_module(lo->lo_disk);
-	mutex_unlock(&loop_index_mutex);
+	unlock_loop();
 
-	*part = 0;
 	return kobj;
 }
 
@@ -1988,9 +2015,11 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			       unsigned long parm)
 {
 	struct loop_device *lo;
-	int ret = -ENOSYS;
+	int ret = lock_loop_killable();
 
-	mutex_lock(&loop_index_mutex);
+	if (ret)
+		return ret;
+	ret = -ENOSYS;
 	switch (cmd) {
 	case LOOP_CTL_ADD:
 		ret = loop_lookup(&lo, parm);
@@ -2004,21 +2033,17 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
-		ret = mutex_lock_killable(&lo->lo_ctl_mutex);
 		if (ret)
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
-			mutex_unlock(&lo->lo_ctl_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
-			mutex_unlock(&lo->lo_ctl_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
-		mutex_unlock(&lo->lo_ctl_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
@@ -2028,7 +2053,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			break;
 		ret = loop_add(&lo, -1);
 	}
-	mutex_unlock(&loop_index_mutex);
+	unlock_loop();
 
 	return ret;
 }
@@ -2112,10 +2137,10 @@ static int __init loop_init(void)
 				  THIS_MODULE, loop_probe, NULL, NULL);
 
 	/* pre-create number of devices given by config or max_loop */
-	mutex_lock(&loop_index_mutex);
+	lock_loop();
 	for (i = 0; i < nr; i++)
 		loop_add(&lo, i);
-	mutex_unlock(&loop_index_mutex);
+	unlock_loop();
 
 	printk(KERN_INFO "loop: module loaded\n");
 	return 0;
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
