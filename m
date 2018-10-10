Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-block@vger.kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 04/15] loop: Get rid of loop_index_mutex
Date: Wed, 10 Oct 2018 12:04:04 +0200
Message-Id: <20181010100415.26525-5-jack@suse.cz>
In-Reply-To: <20181010100415.26525-1-jack@suse.cz>
References: <20181010100415.26525-1-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Now that loop_ctl_mutex is global, just get rid of loop_index_mutex as
there is no good reason to keep these two separate and it just
complicates the locking.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cc43d835fe6f..3fa5e63944a4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -83,7 +83,6 @@
 #include <linux/uaccess.h>
 
 static DEFINE_IDR(loop_index_idr);
-static DEFINE_MUTEX(loop_index_mutex);
 static DEFINE_MUTEX(loop_ctl_mutex);
 
 static int max_part;
@@ -1627,9 +1626,11 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo;
-	int err = 0;
+	int err;
 
-	mutex_lock(&loop_index_mutex);
+	err = mutex_lock_killable(&loop_ctl_mutex);
+	if (err)
+		return err;
 	lo = bdev->bd_disk->private_data;
 	if (!lo) {
 		err = -ENXIO;
@@ -1638,7 +1639,7 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 
 	atomic_inc(&lo->lo_refcnt);
 out:
-	mutex_unlock(&loop_index_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 	return err;
 }
 
@@ -1647,12 +1648,11 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	struct loop_device *lo;
 	int err;
 
-	mutex_lock(&loop_index_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	lo = disk->private_data;
 	if (atomic_dec_return(&lo->lo_refcnt))
-		goto unlock_index;
+		goto out_unlock;
 
-	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		/*
 		 * In autoclear mode, stop the loop thread
@@ -1660,7 +1660,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			goto unlock_index;
+			return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1670,9 +1670,8 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
 
+out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
-unlock_index:
-	mutex_unlock(&loop_index_mutex);
 }
 
 static const struct block_device_operations lo_fops = {
@@ -1973,7 +1972,7 @@ static struct kobject *loop_probe(dev_t dev, int *part, void *data)
 	struct kobject *kobj;
 	int err;
 
-	mutex_lock(&loop_index_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	err = loop_lookup(&lo, MINOR(dev) >> part_shift);
 	if (err < 0)
 		err = loop_add(&lo, MINOR(dev) >> part_shift);
@@ -1981,7 +1980,7 @@ static struct kobject *loop_probe(dev_t dev, int *part, void *data)
 		kobj = NULL;
 	else
 		kobj = get_disk_and_module(lo->lo_disk);
-	mutex_unlock(&loop_index_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 
 	*part = 0;
 	return kobj;
@@ -1991,9 +1990,13 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			       unsigned long parm)
 {
 	struct loop_device *lo;
-	int ret = -ENOSYS;
+	int ret;
 
-	mutex_lock(&loop_index_mutex);
+	ret = mutex_lock_killable(&loop_ctl_mutex);
+	if (ret)
+		return ret;
+
+	ret = -ENOSYS;
 	switch (cmd) {
 	case LOOP_CTL_ADD:
 		ret = loop_lookup(&lo, parm);
@@ -2007,9 +2010,6 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
-		ret = mutex_lock_killable(&loop_ctl_mutex);
-		if (ret)
-			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
 			mutex_unlock(&loop_ctl_mutex);
@@ -2021,7 +2021,6 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
-		mutex_unlock(&loop_ctl_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
@@ -2031,7 +2030,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 			break;
 		ret = loop_add(&lo, -1);
 	}
-	mutex_unlock(&loop_index_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 
 	return ret;
 }
@@ -2115,10 +2114,10 @@ static int __init loop_init(void)
 				  THIS_MODULE, loop_probe, NULL, NULL);
 
 	/* pre-create number of devices given by config or max_loop */
-	mutex_lock(&loop_index_mutex);
+	mutex_lock(&loop_ctl_mutex);
 	for (i = 0; i < nr; i++)
 		loop_add(&lo, i);
-	mutex_unlock(&loop_index_mutex);
+	mutex_unlock(&loop_ctl_mutex);
 
 	printk(KERN_INFO "loop: module loaded\n");
 	return 0;
-- 
2.16.4
