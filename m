Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 25 Jan 2022 15:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582539AbiAYPtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Jan 2022 10:49:39 -0500
Received: from verein.lst.de ([213.95.11.211]:36129 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1582392AbiAYPrk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 10:47:40 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4737767373; Tue, 25 Jan 2022 16:47:30 +0100 (CET)
Date:   Tue, 25 Jan 2022 16:47:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH v3 1/5] task_work: export task_work_add()
Message-ID: <20220125154730.GA4611@lst.de>
References: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121114006.3633-1-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm sometimes a little slow, but I still fail to understand why we need
all this.  Your cut down patch that moves the destroy_workqueue call
and the work_struct fixed all the know lockdep issues, right?

And the only other problem we're thinking off is that blk_mq_freeze_queue
could have the same effect, except that lockdep doesn't track it and
we've not seen it in the wild.

As far as I can tell we do not need the freeze at all for given that
by the time release is called I/O is quiesced.  So with a little prep
work we should not need any of that.  See below (this is actually
three patches, with the last one being a very slight rebase of your
patch):

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 01cbbfc4e9e24..91b56761392e2 100644
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
@@ -1112,10 +1112,14 @@ static void __loop_clr_fd(struct loop_device *lo)
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
 
-	/* freeze request queue during the transition */
-	blk_mq_freeze_queue(lo->lo_queue);
+	/*
+	 * Freeze the request queue when unbinding on a live file descriptor and
+	 * thus an open device.  When called from ->release we are guaranteed
+	 * that there is no I/O in progress already.
+	 */
+	if (!release)
+		blk_mq_freeze_queue(lo->lo_queue);
 
-	destroy_workqueue(lo->workqueue);
 	spin_lock_irq(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
@@ -1144,16 +1148,19 @@ static void __loop_clr_fd(struct loop_device *lo)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	blk_mq_unfreeze_queue(lo->lo_queue);
+	if (!release)
+		blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
 		int err;
 
-		mutex_lock(&lo->lo_disk->open_mutex);
+		if (!release)
+			mutex_lock(&lo->lo_disk->open_mutex);
 		err = bdev_disk_changed(lo->lo_disk, false);
-		mutex_unlock(&lo->lo_disk->open_mutex);
+		if (!release)
+			mutex_unlock(&lo->lo_disk->open_mutex);
 		if (err)
 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
 				__func__, lo->lo_number, err);
@@ -1164,39 +1171,17 @@ static void __loop_clr_fd(struct loop_device *lo)
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
 
-	fput(filp);
-}
-
-static void loop_rundown_completed(struct loop_device *lo)
-{
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 	module_put(THIS_MODULE);
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
@@ -1228,8 +1213,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
+	__loop_clr_fd(lo, false);
 	return 0;
 }
 
@@ -1754,15 +1738,8 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		loop_schedule_rundown(lo);
+		__loop_clr_fd(lo, true);
 		return;
-	} else if (lo->lo_state == Lo_bound) {
-		/*
-		 * Otherwise keep thread (if running) and config,
-		 * but flush possible ongoing bios in thread.
-		 */
-		blk_mq_freeze_queue(lo->lo_queue);
-		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
 
 out_unlock:
@@ -2080,6 +2057,8 @@ static void loop_remove(struct loop_device *lo)
 	mutex_unlock(&loop_ctl_mutex);
 	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
+	if (lo->workqueue)
+		destroy_workqueue(lo->workqueue);
 	kfree(lo);
 }
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc0259..082d4b6bfc6a6 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,6 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
 };
 
 struct loop_cmd {
