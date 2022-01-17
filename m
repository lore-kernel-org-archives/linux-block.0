Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0442C433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 09:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiAQJeq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 04:34:46 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53563 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbiAQJep (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 04:34:45 -0500
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20H9YJgf011995;
        Mon, 17 Jan 2022 18:34:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Mon, 17 Jan 2022 18:34:19 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20H9YIhQ011991
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 17 Jan 2022 18:34:19 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <cdaf1346-2885-f0da-8878-12264bd48348@I-love.SAKURA.ne.jp>
Date:   Mon, 17 Jan 2022 18:34:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
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
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220117081554.GA22708@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/17 17:15, Christoph Hellwig wrote:
> On Sat, Jan 15, 2022 at 09:34:10AM +0900, Tetsuo Handa wrote:
>> Christoph is not a fan of proliferating the use of task_work_add(). Can we go with exporting task_work_add()
> 
> Not a fan != NAK.  If we can't think of anything better we'll have to do
> that.  Note that I also have a task_work_add API cleanup pending that makes
> it a lot less ugly.
> 
>> for this release cycle? Or instead can we go with providing release() callback without disk->open_mutex held
>> ( https://lkml.kernel.org/r/08d703d1-8b32-ec9b-2b50-54b8376d3d40@i-love.sakura.ne.jp ) ?
> 
> This one OTOH is a hard NAK as this is an API that will just cause a lot
> of problems.

What problems can you think of with [PATCH 1/4] below?

I found that patches below are robuster than task_work_add() approach because
the loop module does not need to know about refcounts which the core block layer
manipulates. If we go with task_work_add() approach, the loop module needs to be
updated in sync with refcount manipulations in the core block layer.



Subject: [PATCH 1/4] block: add post_open/post_release block device callbacks

Commit 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
silenced a circular locking dependency warning, but caused a breakage for
/bin/mount and /bin/umount users. Further analysis by Jan revealed that
waiting for I/O completion with disk->open_mutex held has possibility of
deadlock.

We need to fix this breakage, without waiting for I/O completion with
disk->open_mutex held. We can't temporarily drop disk->open_mutex inside
open and release block device callbacks. We could export task_work_add()
for the loop module, but Christoph is not a fan of proliferating the use
of task_work_add().

Therefore, add post_open and post_release block device callbacks which
allows performing an extra operation without holding disk->open_mutex
after returning from open and release block device callbacks respectively.

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 block/bdev.c           | 30 +++++++++++++++++++++---------
 include/linux/blkdev.h |  6 ++++++
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 8bf93a19041b..efde8ffd0df6 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -683,15 +683,16 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
 	bdev->bd_openers++;
-	return 0;;
+	return 0;
 }
 
-static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
+static bool blkdev_put_whole(struct block_device *bdev, fmode_t mode)
 {
 	if (!--bdev->bd_openers)
 		blkdev_flush_mapping(bdev);
 	if (bdev->bd_disk->fops->release)
 		bdev->bd_disk->fops->release(bdev->bd_disk, mode);
+	return true;
 }
 
 static int blkdev_get_part(struct block_device *part, fmode_t mode)
@@ -721,15 +722,15 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	return ret;
 }
 
-static void blkdev_put_part(struct block_device *part, fmode_t mode)
+static bool blkdev_put_part(struct block_device *part, fmode_t mode)
 {
 	struct block_device *whole = bdev_whole(part);
 
 	if (--part->bd_openers)
-		return;
+		return false;
 	blkdev_flush_mapping(part);
 	whole->bd_disk->open_partitions--;
-	blkdev_put_whole(whole, mode);
+	return blkdev_put_whole(whole, mode);
 }
 
 struct block_device *blkdev_get_no_open(dev_t dev)
@@ -784,6 +785,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	bool unblock_events = true;
 	struct block_device *bdev;
 	struct gendisk *disk;
+	bool release_called = false;
 	int ret;
 
 	ret = devcgroup_check_permission(DEVCG_DEV_BLOCK,
@@ -812,10 +814,13 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		goto abort_claiming;
 	if (!try_module_get(disk->fops->owner))
 		goto abort_claiming;
-	if (bdev_is_partition(bdev))
+	if (bdev_is_partition(bdev)) {
 		ret = blkdev_get_part(bdev, mode);
-	else
+		if (ret)
+			release_called = true;
+	} else {
 		ret = blkdev_get_whole(bdev, mode);
+	}
 	if (ret)
 		goto put_module;
 	if (mode & FMODE_EXCL) {
@@ -835,6 +840,8 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		}
 	}
 	mutex_unlock(&disk->open_mutex);
+	if (bdev->bd_disk->fops->post_open)
+		bdev->bd_disk->fops->post_open(bdev->bd_disk);
 
 	if (unblock_events)
 		disk_unblock_events(disk);
@@ -845,6 +852,8 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 	if (mode & FMODE_EXCL)
 		bd_abort_claiming(bdev, holder);
 	mutex_unlock(&disk->open_mutex);
+	if (release_called && bdev->bd_disk->fops->post_release)
+		bdev->bd_disk->fops->post_release(bdev->bd_disk);
 	disk_unblock_events(disk);
 put_blkdev:
 	blkdev_put_no_open(bdev);
@@ -893,6 +902,7 @@ EXPORT_SYMBOL(blkdev_get_by_path);
 void blkdev_put(struct block_device *bdev, fmode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
+	bool release_called;
 
 	/*
 	 * Sync early if it looks like we're the last one.  If someone else
@@ -944,10 +954,12 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	disk_flush_events(disk, DISK_EVENT_MEDIA_CHANGE);
 
 	if (bdev_is_partition(bdev))
-		blkdev_put_part(bdev, mode);
+		release_called = blkdev_put_part(bdev, mode);
 	else
-		blkdev_put_whole(bdev, mode);
+		release_called = blkdev_put_whole(bdev, mode);
 	mutex_unlock(&disk->open_mutex);
+	if (release_called && bdev->bd_disk->fops->post_release)
+		bdev->bd_disk->fops->post_release(bdev->bd_disk);
 
 	module_put(disk->fops->owner);
 	blkdev_put_no_open(bdev);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9c95df26fc26..f35e92fd72d0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1227,6 +1227,12 @@ struct block_device_operations {
 	 * driver.
 	 */
 	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
+	/*
+	 * Special callback for doing extra operations without
+	 * disk->open_mutex held. Used by loop driver.
+	 */
+	void (*post_open)(struct gendisk *disk);
+	void (*post_release)(struct gendisk *disk);
 };
 
 #ifdef CONFIG_COMPAT
-- 
2.32.0



Subject: [PATCH 2/4] loop: don't hold lo->lo_mutex from lo_open()

Waiting for I/O completion with disk->open_mutex held has possibility of
deadlock. Since disk->open_mutex => lo->lo_mutex dependency is recorded by
lo_open(), and blk_mq_freeze_queue() by e.g. loop_set_status() waits for
I/O completion with lo->lo_mutex held, from locking dependency chain
perspective waiting for I/O completion with disk->open_mutex held still
remains.

Introduce loop_delete_spinlock dedicated for protecting lo->lo_state
versus lo->lo_refcnt race in lo_open() and loop_remove_control().

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..9b9f821d1ea7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -89,6 +89,7 @@
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
+static DEFINE_SPINLOCK(loop_delete_spinlock);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -1724,16 +1725,15 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
-	int err;
+	int err = 0;
 
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		return err;
-	if (lo->lo_state == Lo_deleting)
+	spin_lock(&loop_delete_spinlock);
+	/* lo->lo_state may be changed to any Lo_* but Lo_deleting. */
+	if (data_race(lo->lo_state) == Lo_deleting)
 		err = -ENXIO;
 	else
 		atomic_inc(&lo->lo_refcnt);
-	mutex_unlock(&lo->lo_mutex);
+	spin_unlock(&loop_delete_spinlock);
 	return err;
 }
 
@@ -2119,19 +2119,18 @@ static int loop_control_remove(int idx)
 	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		goto mark_visible;
-	if (lo->lo_state != Lo_unbound ||
-	    atomic_read(&lo->lo_refcnt) > 0) {
-		mutex_unlock(&lo->lo_mutex);
+	spin_lock(&loop_delete_spinlock);
+	/* Mark this loop device no longer open()-able if nobody is using. */
+	if (lo->lo_state != Lo_unbound || atomic_read(&lo->lo_refcnt) > 0)
 		ret = -EBUSY;
-		goto mark_visible;
-	}
-	/* Mark this loop device no longer open()-able. */
-	lo->lo_state = Lo_deleting;
+	else
+		lo->lo_state = Lo_deleting;
+	spin_unlock(&loop_delete_spinlock);
 	mutex_unlock(&lo->lo_mutex);
-
-	loop_remove(lo);
-	return 0;
-
+	if (!ret) {
+		loop_remove(lo);
+		return 0;
+	}
 mark_visible:
 	/* Show this loop device again. */
 	mutex_lock(&loop_ctl_mutex);
-- 
2.32.0



Subject: [PATCH 3/4] loop: move lo_release to lo_post_release

The kernel test robot is reporting that xfstest which does

  umount ext2 on xfs
  umount xfs

sequence started failing, for commit 322c4293ecc58110 ("loop: make
autoclear operation asynchronous") removed a guarantee that fput() of
backing file is processed before lo_release() from close() returns to
user mode.

To fix this breakage while killing disk->open_mutex => lo->lo_mutex
dependency, defer whole lo_release() to lo_post_release() and make
autoclear operation synchronous again.

Reported-by: kernel test robot <oliver.sang@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 60 +++++++++++---------------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9b9f821d1ea7..84a3889037d7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1166,40 +1166,12 @@ static void __loop_clr_fd(struct loop_device *lo)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
 
 	fput(filp);
-}
-
-static void loop_rundown_completed(struct loop_device *lo)
-{
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 	module_put(THIS_MODULE);
 }
 
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
-
-static void loop_schedule_rundown(struct loop_device *lo)
-{
-	struct block_device *bdev = lo->lo_device;
-	struct gendisk *disk = lo->lo_disk;
-
-	__module_get(disk->fops->owner);
-	kobject_get(&bdev->bd_device.kobj);
-	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
-	queue_work(system_long_wq, &lo->rundown_work);
-}
-
 static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
@@ -1230,7 +1202,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_mutex);
 
 	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
 	return 0;
 }
 
@@ -1737,30 +1708,29 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	return err;
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
+	 * Clear this loop device since nobody is using. Note that since lo_open()
+	 * increments lo->lo_refcnt without holding lo->lo_mutex, I might become
+	 * no longer the last user, but there is a fact that there was no user.
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
-		loop_schedule_rundown(lo);
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
@@ -1772,7 +1742,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
-	.release =	lo_release,
+	.post_release = lo_post_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
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



Subject: [PATCH 4/4] loop: wait for __loop_clr_fd() to complete upon lo_open()

Since lo_open() and lo_release() were previously serialized via
disk->open_mutex, new file descriptors returned by open() never reached
a loop device in Lo_rundown state unless ioctl(LOOP_CLR_FD) was inside
__loop_clr_fd(). But now that since lo_open() and lo_release() no longer
hold lo->lo_mutex in order to kill disk->open_mutex => lo->lo_mutex
depencency, new file descriptors returned by open() can easily reach a
loop device in Lo_rundown state.

For example, Jan Stancek is reporting that LTP tests which do mount/umount
in close succession like

  # for i in `seq 1 2`;do mount -t iso9660 -o loop /root/isofs.iso /mnt/isofs; umount /mnt/isofs/; done

started failing. Since commit 322c4293ecc58110 ("loop: make autoclear
operation asynchronous") removed disk->open_mutex() serialization,
/bin/mount started to fail when __loop_clr_fd() was called from WQ context
after lo_open() returned [1].

/bin/mount needs to be updated to check ioctl(LOOP_GET_STATUS) after open()
in order to confirm that lo->lo_state remains Lo_bound. But we need some
migration period for allowing users to update their util-linux package.
Thus, meantime emulate serialization between lo_open() and lo_release()
without using disk->open_mutex.

Link: https://lkml.kernel.org/r/20220113154735.hdzi4cqsz5jt6asp@quack3.lan [1]
Reported-by: Jan Stancek <jstancek@redhat.com>
Analyzed-by: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 84a3889037d7..cd19af969209 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -90,6 +90,7 @@ static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
 static DEFINE_MUTEX(loop_validate_mutex);
 static DEFINE_SPINLOCK(loop_delete_spinlock);
+static DECLARE_WAIT_QUEUE_HEAD(loop_rundown_wait);
 
 /**
  * loop_global_lock_killable() - take locks for safe loop_validate_file() test
@@ -1169,6 +1170,7 @@ static void __loop_clr_fd(struct loop_device *lo)
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
+	wake_up_all(&loop_rundown_wait);
 	module_put(THIS_MODULE);
 }
 
@@ -1708,6 +1710,18 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	return err;
 }
 
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
 static void lo_post_release(struct gendisk *disk)
 {
 	struct loop_device *lo = disk->private_data;
@@ -1742,6 +1756,7 @@ static void lo_post_release(struct gendisk *disk)
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
+	.post_open =	lo_post_open,
 	.post_release = lo_post_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.32.0

