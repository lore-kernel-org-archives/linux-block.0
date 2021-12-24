Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4441C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 14:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhLXOFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Dec 2021 09:05:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60597 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbhLXOFf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Dec 2021 09:05:35 -0500
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BOE5KNt001652;
        Fri, 24 Dec 2021 23:05:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Fri, 24 Dec 2021 23:05:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BOE5JQe001648
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 24 Dec 2021 23:05:20 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <53ec857e-e890-751c-7ebe-0036389f48eb@i-love.sakura.ne.jp>
Date:   Fri, 24 Dec 2021 23:05:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 1/2] loop: use a global workqueue
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org
References: <20211223112509.1116461-1-hch@lst.de>
 <20211223112509.1116461-2-hch@lst.de>
 <bb151d84-8a56-f6da-a5dd-b2d8d1fb6cdb@i-love.sakura.ne.jp>
 <20211224060311.GC12234@lst.de>
 <f839a895-bb91-02f8-33fb-5994dd725d24@i-love.sakura.ne.jp>
In-Reply-To: <f839a895-bb91-02f8-33fb-5994dd725d24@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/24 21:05, Tetsuo Handa wrote:
> Also, is
> 
> 	blk_mq_start_request(rq);
> 
> 	if (lo->lo_state != Lo_bound)
> 		return BLK_STS_IOERR;
> 
> in loop_queue_rq() correct? (Not only lo->lo_state test is racy, but wants
> blk_mq_end_request() like lo_complete_rq() does?

OK. blk_mq_end_request() is called by blk_mq_dispatch_rq_list() when BLK_STS_IOERR
is returned. Thus, just "s/lo->lo_state/data_race(lo->lo_state)/" will be fine.

> By the way, is it safe to use single global WQ if (4) is a synchronous I/O request?
> Since there can be up to 1048576 loop devices, and one loop device can use another
> loop device as lo->lo_backing_file (unless loop_validate_file() finds a circular
> usage), one synchronous I/O request in (4) might recursively involve up to 1048576
> works (which would be too many concurrency to be handled by a WQ) ?

I wonder whether use of WQ_MEM_RECLAIM in your patch is appropriate.
WQ_MEM_RECLAIM guarantees that at least one "struct task_struct" is available
so that "struct work" can be processed under memory pressure. However, while
flushing buffered write() request to storage would help increasing free memory,
processing buffered read() request would not help increasing free memory. Rather,
doesn't it help reducing free memory by copying that data into page cache?
So, I feel that only works which flush buffered write() request would qualify
processing via WQ_MEM_RECLAIM WQ, and mixing both read() and write() into the
same queue is wrong.

Anyway, as a minimal change for fixing xfstest problem, what about below one?
Just a revert of commit 322c4293ecc58110 ("loop: make autoclear operation
asynchronous") and simply defer destroy_workqueue(lo->workqueue) till
loop_remove().

---
 drivers/block/loop.c | 75 ++++++++++++++++++++------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..e0ac186ca998 100644
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
@@ -2080,6 +2072,7 @@ static void loop_remove(struct loop_device *lo)
 	mutex_unlock(&loop_ctl_mutex);
 	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
+	destroy_workqueue(lo->workqueue);
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

