Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH 0/14] loop: Fix oops and possible deadlocks
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20180927113652.5422-1-jack@suse.cz>
From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9aa37417-990d-84bf-5a6e-88bcca1c106a@i-love.sakura.ne.jp>
Date: Thu, 27 Sep 2018 23:47:01 +0900
MIME-Version: 1.0
In-Reply-To: <20180927113652.5422-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Possible changes folded into this series.

  (1) (I guess) no need to use _nested version.

  (2) Use mutex_lock_killable() where possible.

  (3) Move fput() to after mutex_unlock().

  (4) Don't return 0 upon invalid loop_control_ioctl().

  (5) No need to mutex_lock()/mutex_unlock() on each loop device at
      unregister_transfer_cb() callback.

  (6) No need to mutex_unlock()+mutex_lock() when calling __loop_clr_fd().

---
 drivers/block/loop.c | 78 ++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a0fb7bf..395d1e9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -678,11 +678,11 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
 {
-	struct file	*file, *old_file;
+	struct file	*file = NULL, *old_file;
 	int		error;
 	bool		partscan;
 
-	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
 		return error;
 	error = -ENXIO;
@@ -701,7 +701,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	error = loop_validate_file(file, bdev);
 	if (error)
-		goto out_putf;
+		goto out_unlock;
 
 	old_file = lo->lo_backing_file;
 
@@ -709,29 +709,31 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 	/* size of the new backing store needs to be the same */
 	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
-		goto out_putf;
+		goto out_unlock;
 
 	/* and ... switch */
 	blk_mq_freeze_queue(lo->lo_queue);
 	mapping_set_gfp_mask(old_file->f_mapping, lo->old_gfp_mask);
+	spin_lock_irq(&lo->lo_lock);
 	lo->lo_backing_file = file;
+	spin_unlock_irq(&lo->lo_lock);
 	lo->old_gfp_mask = mapping_gfp_mask(file->f_mapping);
 	mapping_set_gfp_mask(file->f_mapping,
 			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	fput(old_file);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	mutex_unlock(&loop_ctl_mutex);
+	fput(old_file);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	return 0;
 
-out_putf:
-	fput(file);
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
+	if (file)
+		fput(file);
 	return error;
 }
 
@@ -916,7 +918,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	if (!file)
 		goto out;
 
-	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
 		goto out_putf;
 
@@ -975,7 +977,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 
-	/* Grab the block_device to prevent its destruction after we
+	/*
+	 * Grab the block_device to prevent its destruction after we
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
@@ -1031,26 +1034,21 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	return err;
 }
 
+/* loop_ctl_mutex is held by caller, and is released before return. */
 static int __loop_clr_fd(struct loop_device *lo, bool release)
 {
-	struct file *filp = NULL;
+	/*
+	 * filp != NULL because the caller checked lo->lo_state == Lo_bound
+	 * under loop_ctl_mutex.
+	 */
+	struct file *filp = lo->lo_backing_file;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct block_device *bdev = lo->lo_device;
 	int err = 0;
 	bool partscan = false;
 	int lo_number;
 
-	mutex_lock(&loop_ctl_mutex);
-	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
-		err = -ENXIO;
-		goto out_unlock;
-	}
-
-	filp = lo->lo_backing_file;
-	if (filp == NULL) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	lo->lo_state = Lo_rundown;
 
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
@@ -1091,13 +1089,12 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
+	partscan = (lo->lo_flags & LO_FLAGS_PARTSCAN) && bdev;
 	lo_number = lo->lo_number;
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	loop_unprepare_queue(lo);
-out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
 	if (partscan) {
 		/*
@@ -1123,8 +1120,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	 * lock dependency possibility warning as fput can take
 	 * bd_mutex which is usually taken before loop_ctl_mutex.
 	 */
-	if (filp)
-		fput(filp);
+	fput(filp);
 	return err;
 }
 
@@ -1132,7 +1128,7 @@ static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	if (lo->lo_state != Lo_bound) {
@@ -1154,9 +1150,6 @@ static int loop_clr_fd(struct loop_device *lo)
 		mutex_unlock(&loop_ctl_mutex);
 		return 0;
 	}
-	lo->lo_state = Lo_rundown;
-	mutex_unlock(&loop_ctl_mutex);
-
 	return __loop_clr_fd(lo, false);
 }
 
@@ -1169,7 +1162,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct block_device *bdev;
 	bool partscan = false;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	if (lo->lo_encrypt_key_size &&
@@ -1274,7 +1267,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	struct kstat stat;
 	int ret;
 
-	ret = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
 	if (lo->lo_state != Lo_bound) {
@@ -1463,7 +1456,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 {
 	int err;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	switch (cmd) {
@@ -1712,8 +1705,6 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
-		lo->lo_state = Lo_rundown;
-		mutex_unlock(&loop_ctl_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
@@ -1769,10 +1760,8 @@ static int unregister_transfer_cb(int id, void *ptr, void *data)
 	struct loop_device *lo = ptr;
 	struct loop_func_table *xfer = data;
 
-	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_encryption == xfer)
 		loop_release_xfer(lo);
-	mutex_unlock(&loop_ctl_mutex);
 	return 0;
 }
 
@@ -1785,7 +1774,13 @@ int loop_unregister_transfer(int number)
 		return -EINVAL;
 
 	xfer_funcs[n] = NULL;
+	/*
+	 * cleanup_cryptoloop() cannot handle errors because it is called
+	 * from module_exit(). Thus, don't give up upon SIGKILL here.
+	 */
+	mutex_lock(&loop_ctl_mutex);
 	idr_for_each(&loop_index_idr, &unregister_transfer_cb, xfer);
+	mutex_unlock(&loop_ctl_mutex);
 	return 0;
 }
 
@@ -2031,7 +2026,9 @@ static struct kobject *loop_probe(dev_t dev, int *part, void *data)
 	struct kobject *kobj;
 	int err;
 
-	mutex_lock(&loop_ctl_mutex);
+	*part = 0;
+	if (mutex_lock_killable(&loop_ctl_mutex))
+		return NULL;
 	err = loop_lookup(&lo, MINOR(dev) >> part_shift);
 	if (err < 0)
 		err = loop_add(&lo, MINOR(dev) >> part_shift);
@@ -2040,8 +2037,6 @@ static struct kobject *loop_probe(dev_t dev, int *part, void *data)
 	else
 		kobj = get_disk_and_module(lo->lo_disk);
 	mutex_unlock(&loop_ctl_mutex);
-
-	*part = 0;
 	return kobj;
 }
 
@@ -2049,12 +2044,11 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			       unsigned long parm)
 {
 	struct loop_device *lo;
-	int ret = -ENOSYS;
+	int ret = mutex_lock_killable(&loop_ctl_mutex);
 
-	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
-
+	ret = -ENOSYS;
 	switch (cmd) {
 	case LOOP_CTL_ADD:
 		ret = loop_lookup(&lo, parm);
-- 
1.8.3.1
