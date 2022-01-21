Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9972FC433EF
	for <linux-block@archiver.kernel.org>; Fri, 21 Jan 2022 11:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380204AbiAULmO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jan 2022 06:42:14 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56591 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380202AbiAULmM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jan 2022 06:42:12 -0500
Received: from fsav116.sakura.ne.jp (fsav116.sakura.ne.jp [27.133.134.243])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20LBeF0d048224;
        Fri, 21 Jan 2022 20:40:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav116.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp);
 Fri, 21 Jan 2022 20:40:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav116.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20LBe9He048197
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 21 Jan 2022 20:40:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v3 4/5] loop: don't hold lo->lo_mutex from lo_release()
Date:   Fri, 21 Jan 2022 20:40:05 +0900
Message-Id: <20220121114006.3633-4-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a retry of commit 322c4293ecc58110 ("loop: make autoclear operation
asynchronous").

Since it turned out that we need to avoid waiting for I/O completion with
disk->open_mutex held, move whole lo_release() operation to task work
context (when possible) or WQ context (otherwise).

Refcount management in lo_release() and loop_release_workfn() needs to be
updated in sync with blkdev_put(), for blkdev_put() already dropped
references by the moment loop_release_callbackfn() is invoked.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 151 +++++++++++++++++++++++++++++++------------
 drivers/block/loop.h |   1 +
 2 files changed, 111 insertions(+), 41 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 5ce8ac2dfa4c..74d919e98a6b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1083,7 +1083,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo, bool release)
+static void __loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1145,8 +1145,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
@@ -1154,37 +1152,18 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
 		int err;
 
-		/*
-		 * open_mutex has been held already in release path, so don't
-		 * acquire it if this function is called in such case.
-		 *
-		 * If the reread partition isn't from release path, lo_refcnt
-		 * must be at least one and it can only become zero when the
-		 * current holder is released.
-		 */
-		if (!release)
-			mutex_lock(&lo->lo_disk->open_mutex);
+		mutex_lock(&lo->lo_disk->open_mutex);
 		err = bdev_disk_changed(lo->lo_disk, false);
-		if (!release)
-			mutex_unlock(&lo->lo_disk->open_mutex);
+		mutex_unlock(&lo->lo_disk->open_mutex);
 		if (err)
 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
 				__func__, lo->lo_number, err);
 		/* Device is gone, no point in returning error */
 	}
 
-	/*
-	 * lo->lo_state is set to Lo_unbound here after above partscan has
-	 * finished. There cannot be anybody else entering __loop_clr_fd() as
-	 * Lo_rundown state protects us from all the other places trying to
-	 * change the 'lo' device.
-	 */
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
-	mutex_lock(&lo->lo_mutex);
-	lo->lo_state = Lo_unbound;
-	mutex_unlock(&lo->lo_mutex);
 
 	/*
 	 * Need not hold lo_mutex to fput backing file. Calling fput holding
@@ -1192,6 +1171,10 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	 * fput can take open_mutex which is usually taken before lo_mutex.
 	 */
 	fput(filp);
+	mutex_lock(&lo->lo_mutex);
+	lo->lo_state = Lo_unbound;
+	mutex_unlock(&lo->lo_mutex);
+	module_put(THIS_MODULE);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
@@ -1223,7 +1206,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo, false);
+	__loop_clr_fd(lo);
 	return 0;
 }
 
@@ -1715,10 +1698,31 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
+struct loop_release_task {
+	union {
+		struct list_head head;
+		struct callback_head cb;
+		struct work_struct ws;
+	};
+	struct loop_device *lo;
+};
+
+static LIST_HEAD(release_task_spool);
+static DEFINE_SPINLOCK(release_task_spool_spinlock);
+
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err = 0;
+	/*
+	 * In order to avoid doing __GFP_NOFAIL allocaion from lo_release(),
+	 * reserve memory for calling lo_post_release() from lo_open().
+	 */
+	struct loop_release_task *lrt =
+		kmalloc(sizeof(*lrt), GFP_KERNEL | __GFP_NOWARN);
+
+	if (!lrt)
+		return -ENOMEM;
 
 	spin_lock(&loop_delete_spinlock);
 	/* lo->lo_state may be changed to any Lo_* but Lo_deleting. */
@@ -1727,33 +1731,40 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	else
 		atomic_inc(&lo->lo_refcnt);
 	spin_unlock(&loop_delete_spinlock);
-	return err;
+	if (err) {
+		kfree(lrt);
+		return err;
+	}
+	spin_lock(&release_task_spool_spinlock);
+	list_add(&lrt->head, &release_task_spool);
+	spin_unlock(&release_task_spool_spinlock);
+	return 0;
 }
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+static void lo_post_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
 
 	mutex_lock(&lo->lo_mutex);
-	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
 
+	/* Check whether this loop device can be cleared. */
+	if (atomic_dec_return(&lo->lo_refcnt) || lo->lo_state != Lo_bound)
+		goto out_unlock;
+	/*
+	 * Clear this loop device since nobody is using. Note that since
+	 * lo_open() increments lo->lo_refcnt without holding lo->lo_mutex,
+	 * I might become no longer the last user, but there is a fact that
+	 * there was no user.
+	 *
+	 * In autoclear mode, destroy WQ and remove configuration.
+	 * Otherwise flush possible ongoing bios in WQ and keep configuration.
+	 */
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (lo->lo_state != Lo_bound)
-			goto out_unlock;
 		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
-		/*
-		 * In autoclear mode, stop the loop thread
-		 * and remove configuration after last close.
-		 */
-		__loop_clr_fd(lo, true);
+		__loop_clr_fd(lo);
 		return;
-	} else if (lo->lo_state == Lo_bound) {
-		/*
-		 * Otherwise keep thread (if running) and config,
-		 * but flush possible ongoing bios in thread.
-		 */
+	} else {
 		blk_mq_freeze_queue(lo->lo_queue);
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
@@ -1762,6 +1773,60 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	mutex_unlock(&lo->lo_mutex);
 }
 
+static void loop_release_workfn(struct work_struct *work)
+{
+	struct loop_release_task *lrt =
+		container_of(work, struct loop_release_task, ws);
+	struct loop_device *lo = lrt->lo;
+	struct gendisk *disk = lo->lo_disk;
+
+	lo_post_release(disk);
+	/* Drop references which will be dropped after lo_release(). */
+	kobject_put(&disk_to_dev(disk)->kobj);
+	module_put(disk->fops->owner);
+	kfree(lrt);
+	atomic_dec(&lo->async_pending);
+}
+
+static void loop_release_callbackfn(struct callback_head *callback)
+{
+	struct loop_release_task *lrt =
+		container_of(callback, struct loop_release_task, cb);
+
+	loop_release_workfn(&lrt->ws);
+}
+
+static void lo_release(struct gendisk *disk, fmode_t mode)
+{
+	struct loop_device *lo = disk->private_data;
+	struct loop_release_task *lrt;
+
+	atomic_inc(&lo->async_pending);
+	/*
+	 * Fetch from spool. Since a successful lo_open() call is coupled with
+	 * a lo_release() call, we are guaranteed that spool is not empty.
+	 */
+	spin_lock(&release_task_spool_spinlock);
+	lrt = list_first_entry(&release_task_spool, typeof(*lrt), head);
+	list_del(&lrt->head);
+	spin_unlock(&release_task_spool_spinlock);
+	/* Hold references which will be dropped after lo_release(). */
+	__module_get(disk->fops->owner);
+	kobject_get(&disk_to_dev(disk)->kobj);
+	/*
+	 * Prefer task work so that clear operation completes
+	 * before close() returns to user mode.
+	 */
+	lrt->lo = lo;
+	if (!(current->flags & PF_KTHREAD)) {
+		init_task_work(&lrt->cb, loop_release_callbackfn);
+		if (!task_work_add(current, &lrt->cb, TWA_RESUME))
+			return;
+	}
+	INIT_WORK(&lrt->ws, loop_release_workfn);
+	queue_work(system_long_wq, &lrt->ws);
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
@@ -2023,6 +2088,7 @@ static int loop_add(int i)
 	if (!part_shift)
 		disk->flags |= GENHD_FL_NO_PART;
 	atomic_set(&lo->lo_refcnt, 0);
+	atomic_set(&lo->async_pending, 0);
 	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
@@ -2064,6 +2130,9 @@ static int loop_add(int i)
 
 static void loop_remove(struct loop_device *lo)
 {
+	/* Wait for task work and/or WQ to complete. */
+	while (atomic_read(&lo->async_pending))
+		schedule_timeout_uninterruptible(1);
 	/* Make this loop device unreachable from pathname. */
 	del_gendisk(lo->lo_disk);
 	blk_cleanup_disk(lo->lo_disk);
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 082d4b6bfc6a..20fc5eebe455 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,6 +56,7 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
+	atomic_t		async_pending;
 };
 
 struct loop_cmd {
-- 
2.32.0

