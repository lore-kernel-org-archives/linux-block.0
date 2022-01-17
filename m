Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFA1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 14:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiAQOKj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 09:10:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:49923 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiAQOKj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 09:10:39 -0500
Received: from fsav112.sakura.ne.jp (fsav112.sakura.ne.jp [27.133.134.239])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20HEADGG051216;
        Mon, 17 Jan 2022 23:10:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav112.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp);
 Mon, 17 Jan 2022 23:10:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav112.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20HEACQ7051210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jan 2022 23:10:13 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <1c400c45-1427-6c8c-8053-a4e1e7e92b81@I-love.SAKURA.ne.jp>
Date:   Mon, 17 Jan 2022 23:10:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <20220113104424.u6fj3z2zd34ohthc@quack3.lan>
 <f893638a-2109-c197-9783-c5e6dced23e5@I-love.SAKURA.ne.jp>
 <20220114195840.kdzegicjx7uyscoq@quack3.lan>
 <33f360ca-d3e1-7070-654e-26ef22109a61@I-love.SAKURA.ne.jp>
 <20220117081554.GA22708@lst.de>
 <cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp>
In-Reply-To: <cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/17 18:34, Tetsuo Handa wrote:
> On 2022/01/17 17:15, Christoph Hellwig wrote:
>> On Sat, Jan 15, 2022 at 09:34:10AM +0900, Tetsuo Handa wrote:
>>> Christoph is not a fan of proliferating the use of task_work_add(). Can we go with exporting task_work_add()
>>
>> Not a fan != NAK.  If we can't think of anything better we'll have to do
>> that.  Note that I also have a task_work_add API cleanup pending that makes
>> it a lot less ugly.
>>
>>> for this release cycle? Or instead can we go with providing release() callback without disk->open_mutex held
>>> ( https://lkml.kernel.org/r/08d703d1-8b32-ec9b-2b50-54b8376d3d40@i-love.sakura.ne.jp ) ?
>>
>> This one OTOH is a hard NAK as this is an API that will just cause a lot
>> of problems.
> 
> What problems can you think of with [PATCH 1/4] below?
> 
> I found that patches below are robuster than task_work_add() approach because
> the loop module does not need to know about refcounts which the core block layer
> manipulates. If we go with task_work_add() approach, the loop module needs to be
> updated in sync with refcount manipulations in the core block layer.
> 

For your information, below is how task_work_add() approach would look like.
Despite full of refcount management, cannot provide synchronous autoclear
operation if closed by kernel threads, cannot provide synchronous waiting if
opened by kernel threads, possibility to fail to run autoclear operation when
open by user threads failed... What a mess!

---
 block/bdev.c           |  30 +++-------
 drivers/block/loop.c   | 125 ++++++++++++++++++++++++++++++++++++-----
 include/linux/blkdev.h |   6 --
 kernel/task_work.c     |   1 +
 4 files changed, 121 insertions(+), 41 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index efde8ffd0df6..8bf93a19041b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -683,16 +683,15 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
 	bdev->bd_openers++;
-	return 0;
+	return 0;;
 }
 
-static bool blkdev_put_whole(struct block_device *bdev, fmode_t mode)
+static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
 {
 	if (!--bdev->bd_openers)
 		blkdev_flush_mapping(bdev);
 	if (bdev->bd_disk->fops->release)
 		bdev->bd_disk->fops->release(bdev->bd_disk, mode);
-	return true;
 }
 
 static int blkdev_get_part(struct block_device *part, fmode_t mode)
@@ -722,15 +721,15 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	return ret;
 }
 
-static bool blkdev_put_part(struct block_device *part, fmode_t mode)
+static void blkdev_put_part(struct block_device *part, fmode_t mode)
 {
 	struct block_device *whole = bdev_whole(part);
 
 	if (--part->bd_openers)
-		return false;
+		return;
 	blkdev_flush_mapping(part);
 	whole->bd_disk->open_partitions--;
-	return blkdev_put_whole(whole, mode);
+	blkdev_put_whole(whole, mode);
 }
 
 struct block_device *blkdev_get_no_open(dev_t dev)
@@ -785,7 +784,6 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	bool unblock_events = true;
 	struct block_device *bdev;
 	struct gendisk *disk;
-	bool release_called = false;
 	int ret;
 
 	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
@@ -814,13 +812,10 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		goto abort_claiming;
 	if (!try_module_get(disk->fops->owner))
 		goto abort_claiming;
-	if (bdev_is_partition(bdev)) {
+	if (bdev_is_partition(bdev))
 		ret = blkdev_get_part(bdev, mode);
-		if (ret)
-			release_called = true;
-	} else {
+	else
 		ret = blkdev_get_whole(bdev, mode);
-	}
 	if (ret)
 		goto put_module;
 	if (mode & FMODE_EXCL) {
@@ -840,8 +835,6 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		}
 	}
 	mutex_unlock(&disk->open_mutex);
-	if (bdev->bd_disk->fops->post_open)
-		bdev->bd_disk->fops->post_open(bdev->bd_disk);
 
 	if (unblock_events)
 		disk_unblock_events(disk);
@@ -852,8 +845,6 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	if (mode & FMODE_EXCL)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
-	if (release_called && bdev->bd_disk->fops->post_release)
-		bdev->bd_disk->fops->post_release(bdev->bd_disk);
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
@@ -902,7 +893,6 @@ EXPORT_SYMBOL(blkdev_get_by_path);
 void blkdev_put(struct block_device *bdev, fmode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	bool release_called;
 
 	/*
 	 * Sync early if it looks like we're the last one.  If someone else
@@ -954,12 +944,10 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	disk_flush_events(disk, DISK_EVENT_MEDIA_CHANGE);
 
 	if (bdev_is_partition(bdev))
-		release_called = blkdev_put_part(bdev, mode);
+		blkdev_put_part(bdev, mode);
 	else
-		release_called = blkdev_put_whole(bdev, mode);
+		blkdev_put_whole(bdev, mode);
 	mutex_unlock(&disk->open_mutex);
-	if (release_called && bdev->bd_disk->fops->post_release)
-		bdev->bd_disk->fops->post_release(bdev->bd_disk);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cd19af969209..cfa6ab7c315a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1695,6 +1695,38 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 }
 #endif
 
+static void lo_post_open(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
+
+	/* Wait for lo_post_release() to leave lo->lo_mutex section. */
+	if (mutex_lock_killable(&lo->lo_mutex))
+		return;
+	mutex_unlock(&lo->lo_mutex);
+	/* Also wait for __loop_clr_fd() to complete if Lo_rundown was set. */
+	wait_event_killable(loop_rundown_wait, data_race(lo->lo_state) != Lo_rundown);
+}
+
+struct loop_open_task {
+	struct callback_head cb;
+	struct loop_device *lo;
+};
+
+static void loop_open_callbackfn(struct callback_head *callback)
+{
+	struct loop_open_task *lot =
+		container_of(callback, struct loop_open_task, cb);
+	struct gendisk *disk = lot->lo->lo_disk;
+
+	lo_post_open(disk);
+	/*
+	 * Since I didn't hold references, I can't call lo_post_release().
+	 * That is, I won't handle __loop_clr_fd() if I was the last user.
+	 */
+	atomic_dec(&lot->lo->lo_refcnt);
+	kfree(lot);
+}
+
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
@@ -1707,21 +1739,29 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	else
 		atomic_inc(&lo->lo_refcnt);
 	spin_unlock(&loop_delete_spinlock);
+	/* Try to avoid accessing Lo_rundown loop device. */
+	if (!(current->flags & PF_KTHREAD)) {
+		struct loop_open_task *lot =
+			kmalloc(sizeof(*lot), GFP_KERNEL | __GFP_NOWARN);
+
+		if (lot) {
+			lot->lo = lo;
+			init_task_work(&lot->cb, loop_open_callbackfn);
+			if (task_work_add(current, &lot->cb, TWA_RESUME))
+				kfree(lot);
+			/*
+			 * Needs an extra reference for avoiding use-after-free
+			 * when an error occurred before returning to user mode
+			 * because the task work list is LIFO. But that in turn
+			 * bothers me with dropping this extra reference.
+			 */
+			else
+				atomic_inc(&lo->lo_refcnt);
+		}
+	}
 	return err;
 }
 
-static void lo_post_open(struct gendisk *disk)
-{
-	struct loop_device *lo = disk->private_data;
-
-	/* Wait for lo_post_release() to leave lo->lo_mutex section. */
-	if (mutex_lock_killable(&lo->lo_mutex))
-		return;
-	mutex_unlock(&lo->lo_mutex);
-	/* Also wait for __loop_clr_fd() to complete if Lo_rundown was set. */
-	wait_event_killable(loop_rundown_wait, data_race(lo->lo_state) != Lo_rundown);
-}
-
 static void lo_post_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
@@ -1753,11 +1793,68 @@ static void lo_post_release(struct gendisk *disk)
 	mutex_unlock(&lo->lo_mutex);
 }
 
+struct loop_release_task {
+	union {
+		struct callback_head cb;
+		struct work_struct ws;
+	};
+	struct loop_device *lo;
+};
+
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
+	/* Drop a reference to allow loop_exit(). */
+	module_put(THIS_MODULE);
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
+	struct loop_release_task *lrt = kmalloc(sizeof(*lrt),
+						GFP_KERNEL | __GFP_NOFAIL);
+
+	/* Hold a reference to disallow loop_exit(). */
+	__module_get(THIS_MODULE);
+	/* Hold references which will be dropped after lo_release(). */
+	__module_get(disk->fops->owner);
+	kobject_get(&disk_to_dev(disk)->kobj);
+	/* Clear this loop device. */
+	lrt->lo = lo;
+	if (!(current->flags & PF_KTHREAD)) {
+		/*
+		 * Prefer task work so that clear operation completes
+		 * before close() returns to user mode.
+		 */
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
-	.post_open =	lo_post_open,
-	.post_release = lo_post_release,
+	.release =	lo_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f35e92fd72d0..9c95df26fc26 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1227,12 +1227,6 @@ struct block_device_operations {
 	 * driver.
 	 */
 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
-	/*
-	 * Special callback for doing extra operations without
-	 * disk->open_mutex held. Used by loop driver.
-	 */
-	void (*post_open)(struct gendisk *disk);
-	void (*post_release)(struct gendisk *disk);
 };
 
 #ifdef CONFIG_COMPAT
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 1698fbe6f0e1..2a1644189182 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -60,6 +60,7 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(task_work_add);
 
 /**
  * task_work_cancel_match - cancel a pending work added by task_work_add()
-- 
2.32.0

