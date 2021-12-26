Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF2C433F5
	for <linux-block@archiver.kernel.org>; Sun, 26 Dec 2021 07:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhLZHGu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Dec 2021 02:06:50 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62306 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLZHGu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Dec 2021 02:06:50 -0500
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BQ76Vck030680;
        Sun, 26 Dec 2021 16:06:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sun, 26 Dec 2021 16:06:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BQ76TOq030672
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 26 Dec 2021 16:06:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp>
Date:   Sun, 26 Dec 2021 16:06:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH] make autoclear operation synchronous again
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The kernel test robot is reporting that xfstest can fail at

  umount ext2 on xfs
  umount xfs

sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
asynchronous") broke what commit ("loop: Make explicit loop device
destruction lazy") wanted to achieve.

Although we cannot guarantee that nobody is holding a reference when
"umount xfs" is called, we should try to close a race window opened
by asynchronous autoclear operation.

It turned out that there is no need to call flush_workqueue() from
__loop_clr_fd(), for blk_mq_freeze_queue() blocks until all pending
"struct work_struct" are processed by loop_process_work().

Revert commit 322c4293ecc58110 ("loop: make autoclear operation
asynchronous"), and simply defer calling destroy_workqueue() till
loop_remove().

Since a loop device is likely reused after once created thanks to
ioctl(LOOP_CTL_GET_FREE), being unable to destroy corresponding WQ
when ioctl(LOOP_CLR_FD) is called should be an acceptable waste.

Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---

 drivers/block/loop.c | 76 ++++++++++++++++++++------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..93137858b00c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1006,10 +1006,10 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
-	lo->workqueue = alloc_workqueue("loop%d",
-					WQ_UNBOUND | WQ_FREEZABLE,
-					0,
-					lo->lo_number);
+	if (!lo->workqueue)
+		lo->workqueue = alloc_workqueue("loop%d",
+						WQ_UNBOUND | WQ_FREEZABLE,
+						0, lo->lo_number);
 	if (!lo->workqueue) {
 		error = -ENOMEM;
 		goto out_unlock;
@@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo)
+static void __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1115,7 +1115,6 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-	destroy_workqueue(lo->workqueue);
 	spin_lock_irq(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
@@ -1144,6 +1143,8 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
+	/* This is safe: open() is still holding a reference. */
+	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
@@ -1151,52 +1152,44 @@ static void __loop_clr_fd(struct loop_device *lo)
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
 		int err;
 
-		mutex_lock(&lo->lo_disk->open_mutex);
+		/*
+		 * open_mutex has been held already in release path, so don't
+		 * acquire it if this function is called in such case.
+		 *
+		 * If the reread partition isn't from release path, lo_refcnt
+		 * must be at least one and it can only become zero when the
+		 * current holder is released.
+		 */
+		if (!release)
+			mutex_lock(&lo->lo_disk->open_mutex);
 		err = bdev_disk_changed(lo->lo_disk, false);
-		mutex_unlock(&lo->lo_disk->open_mutex);
+		if (!release)
+			mutex_unlock(&lo->lo_disk->open_mutex);
 		if (err)
 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
 				__func__, lo->lo_number, err);
 		/* Device is gone, no point in returning error */
 	}
 
+	/*
+	 * lo->lo_state is set to Lo_unbound here after above partscan has
+	 * finished. There cannot be anybody else entering __loop_clr_fd() as
+	 * Lo_rundown state protects us from all the other places trying to
+	 * change the 'lo' device.
+	 */
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
-
-	fput(filp);
-}
-
-static void loop_rundown_completed(struct loop_device *lo)
-{
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
-	module_put(THIS_MODULE);
-}
-
-static void loop_rundown_workfn(struct work_struct *work)
-{
-	struct loop_device *lo = container_of(work, struct loop_device,
-					      rundown_work);
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__loop_clr_fd(lo);
-	kobject_put(&bdev->bd_device.kobj);
-	module_put(disk->fops->owner);
-	loop_rundown_completed(lo);
-}
 
-static void loop_schedule_rundown(struct loop_device *lo)
-{
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__module_get(disk->fops->owner);
-	kobject_get(&bdev->bd_device.kobj);
-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
-	queue_work(system_long_wq, &lo->rundown_work);
+	/*
+	 * Need not hold lo_mutex to fput backing file. Calling fput holding
+	 * lo_mutex triggers a circular lock dependency possibility warning as
+	 * fput can take open_mutex which is usually taken before lo_mutex.
+	 */
+	fput(filp);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
@@ -1228,8 +1221,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
+	__loop_clr_fd(lo, false);
 	return 0;
 }
 
@@ -1754,7 +1746,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		loop_schedule_rundown(lo);
+		__loop_clr_fd(lo, true);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
@@ -2080,6 +2072,8 @@ static void loop_remove(struct loop_device *lo)
 	mutex_unlock(&loop_ctl_mutex);
 	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
+	if (lo->workqueue)
+		destroy_workqueue(lo->workqueue);
 	kfree(lo);
 }
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc025..082d4b6bfc6a 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,6 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
 };
 
 struct loop_cmd {
-- 
2.32.0
