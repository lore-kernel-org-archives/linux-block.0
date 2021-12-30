Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81988C433FE
	for <linux-block@archiver.kernel.org>; Thu, 30 Dec 2021 10:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhL3Kwu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Dec 2021 05:52:50 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58554 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhL3Kwu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Dec 2021 05:52:50 -0500
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BUAqXTr026974;
        Thu, 30 Dec 2021 19:52:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Thu, 30 Dec 2021 19:52:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BUAqWmx026970
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 30 Dec 2021 19:52:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <4e7b711f-744b-3a78-39be-c9432a3cecd2@i-love.sakura.ne.jp>
Date:   Thu, 30 Dec 2021 19:52:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] make autoclear operation synchronous again
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block <linux-block@vger.kernel.org>
References: <03f43407-c34b-b7b2-68cd-d4ca93a993b8@i-love.sakura.ne.jp>
 <20211229172902.GC27693@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211229172902.GC27693@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/30 2:29, Christoph Hellwig wrote:
> The subject line is missing the loop: prefix.

Oops.

> 
> This approach looks very reasonable, but a few comments below:

I prefer task_work approach if it is safe, for it can call destroy_workqueue()
without global locks held. Note that __loop_clear_fd() is also called from
ioctl(LOOP_CLR_FD), and creating locking dependency chain for both with and without
global locks held looks stupid. If we can do without global locks held, why bother
to do with global locks held?

> 
>> -	lo->workqueue = alloc_workqueue("loop%d",
>> -					WQ_UNBOUND | WQ_FREEZABLE,
>> -					0,
>> -					lo->lo_number);
>> +	if (!lo->workqueue)
>> +		lo->workqueue = alloc_workqueue("loop%d",
>> +						WQ_UNBOUND | WQ_FREEZABLE,
>> +						0, lo->lo_number);
> 
> Instead of having to deal with sometimes present workqueues, why
> not move the workqueue allocation to loop_add?

A bit of worrisome thing is that destroy_workqueue() can be called with
major_names_lock held, for loop_add() may be called as probe function from
blk_request_module(). Some unexpected dependency might bite us in future.

We can avoid destroy_workqueue() from loop_add() if we call alloc_workqueue()
after add_disk() succeeded. But in that case calling alloc_workqueue() from
loop_configure() (which is called without global locks like major_names_lock)
sounds safer.

> 
>> +	/* This is safe: open() is still holding a reference. */
>> +	module_put(THIS_MODULE);
> 
> Any reason to move the module_put here insted of keeping it at the
> end of the function as the old code did?

OK. Two patches shown below. Are these look reasonable?



From 1409a49181efcc474fbae2cf4e60cbc37adf34aa Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 30 Dec 2021 18:41:05 +0900
Subject: [PATCH 1/2] loop: Revert "loop: make autoclear operation asynchronous"

The kernel test robot is reporting that xfstest can fail at

  umount ext2 on xfs
  umount xfs

sequence, for commit 322c4293ecc58110 ("loop: make autoclear operation
asynchronous") broke what commit ("loop: Make explicit loop device
destruction lazy") wanted to achieve.

Although we cannot guarantee that nobody is holding a reference when
"umount xfs" is called, we should try to close a race window opened
by asynchronous autoclear operation.

Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 65 ++++++++++++++++++++------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..e52a8a5e8cbc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo)
+static void __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1144,6 +1144,8 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
+	/* This is safe: open() is still holding a reference. */
+	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
@@ -1151,52 +1153,44 @@ static void __loop_clr_fd(struct loop_device *lo)
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
@@ -1228,8 +1222,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
+	__loop_clr_fd(lo, false);
 	return 0;
 }
 
@@ -1754,7 +1747,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		loop_schedule_rundown(lo);
+		__loop_clr_fd(lo, true);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
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



From 639bd8cfad4b776094b1d05e8d4802c365e8436a Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 30 Dec 2021 19:45:00 +0900
Subject: [PATCH 2/2] loop: allocate WQ when creating a loop device

syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
is calling destroy_workqueue() with disk->open_mutex held.

It turned out that there is no need to call flush_workqueue() from
__loop_clr_fd(), for blk_mq_freeze_queue() blocks until all pending
"struct work_struct" are processed by loop_process_work().

Thus, allocate a WQ from loop_add() than loop_configure() and destroy
this WQ from loop_remove() than __loop_clr_fd(). Also, use WQ_MEM_RECLAIM
because this WQ needs to be able to start when writeback operation for
reclaiming memory is in progress.

Ideally, loop_process_work() which this WQ calls should be able to
complete without memory allocation, for e.g. kmalloc_array() from
lo_rw_aio() from do_req_filebacked() from loop_handle_cmd() may be
subjected to infinite loop problem [2], but such change is too big
to make in this patch. This patch tries to make sure that this WQ can
call loop_process_work() as needed.

Link: https://syzkaller.appspot.com/bug?extid=643e4ce4b6ad1347d372 [1]
Link: https://lwn.net/Articles/627419/ [2]
Reported-by: syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 48 +++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e52a8a5e8cbc..e7c25d5a40f5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -959,9 +959,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		return -EBADF;
 	is_loop = is_loop_device(file);
 
-	/* This is safe, since we have a reference from open(). */
-	__module_get(THIS_MODULE);
-
 	/*
 	 * If we don't hold exclusive handle for the device, upgrade to it
 	 * here to avoid changing device under exclusive owner.
@@ -1006,15 +1003,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo->lo_flags |= LO_FLAGS_READ_ONLY;
 
-	lo->workqueue = alloc_workqueue("loop%d",
-					WQ_UNBOUND | WQ_FREEZABLE,
-					0,
-					lo->lo_number);
-	if (!lo->workqueue) {
-		error = -ENOMEM;
-		goto out_unlock;
-	}
-
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
 
@@ -1068,6 +1056,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		loop_reread_partitions(lo);
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
+	/* Disallow module unloading while holding backing file. */
+	__module_get(THIS_MODULE);
 	return 0;
 
 out_unlock:
@@ -1077,8 +1067,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		bd_abort_claiming(bdev, loop_configure);
 out_putf:
 	fput(file);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	return error;
 }
 
@@ -1115,7 +1103,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	/* freeze request queue during the transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
-	destroy_workqueue(lo->workqueue);
 	spin_lock_irq(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
@@ -1144,8 +1131,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
@@ -1185,12 +1170,9 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 
-	/*
-	 * Need not hold lo_mutex to fput backing file. Calling fput holding
-	 * lo_mutex triggers a circular lock dependency possibility warning as
-	 * fput can take open_mutex which is usually taken before lo_mutex.
-	 */
+	/* Release backing file and allow module unloading. */
 	fput(filp);
+	module_put(THIS_MODULE);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
@@ -1972,6 +1954,23 @@ static int loop_add(int i)
 		goto out_free_dev;
 	i = err;
 
+	/*
+	 * Allocate a WQ for this loop device. We can't use a global WQ because
+	 * an I/O request will hung when number of active work hits concurrency
+	 * limit due to stacked loop devices. Also, specify WQ_MEM_RECLAIM in
+	 * order to guarantee that loop_process_work() can start processing an
+	 * I/O request even under memory pressure. As a result, this allocation
+	 * sounds a sort of resource wasting prepared for the worst condition.
+	 * We hope that people utilize ioctl(LOOP_CTL_GET_FREE) in order to
+	 * create only minimal number of loop devices.
+	 */
+	lo->workqueue = alloc_workqueue("loop%d", WQ_MEM_RECLAIM | WQ_UNBOUND |
+					WQ_FREEZABLE, 0, i);
+	if (!lo->workqueue) {
+		err = -ENOMEM;
+		goto out_free_idr;
+	}
+
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
 	lo->tag_set.queue_depth = 128;
@@ -1983,7 +1982,7 @@ static int loop_add(int i)
 
 	err = blk_mq_alloc_tag_set(&lo->tag_set);
 	if (err)
-		goto out_free_idr;
+		goto out_free_workqueue;
 
 	disk = lo->lo_disk = blk_mq_alloc_disk(&lo->tag_set, lo);
 	if (IS_ERR(disk)) {
@@ -2052,6 +2051,8 @@ static int loop_add(int i)
 	blk_cleanup_disk(disk);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&lo->tag_set);
+out_free_workqueue:
+	destroy_workqueue(lo->workqueue);
 out_free_idr:
 	mutex_lock(&loop_ctl_mutex);
 	idr_remove(&loop_index_idr, i);
@@ -2073,6 +2074,7 @@ static void loop_remove(struct loop_device *lo)
 	mutex_unlock(&loop_ctl_mutex);
 	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
+	destroy_workqueue(lo->workqueue);
 	kfree(lo);
 }
 
-- 
2.32.0

