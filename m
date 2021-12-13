Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443FC433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Dec 2021 12:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhLMMzd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Dec 2021 07:55:33 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:58612 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhLMMzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Dec 2021 07:55:32 -0500
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BDCtSZQ058195;
        Mon, 13 Dec 2021 21:55:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Mon, 13 Dec 2021 21:55:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BDCtRlk058118
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 Dec 2021 21:55:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <1ed7df28-ebd6-71fb-70e5-1c2972e05ddb@i-love.sakura.ne.jp>
Date:   Mon, 13 Dec 2021 21:55:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH (resend)] loop: make autoclear operation asynchronous
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
is calling destroy_workqueue() with disk->open_mutex held.

This circular dependency cannot be broken unless we call __loop_clr_fd()
without holding disk->open_mutex. Therefore, defer __loop_clr_fd() from
lo_release() to a WQ context.

Link: https://syzkaller.appspot.com/bug?extid=643e4ce4b6ad1347d372 [1]
Reported-by: syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>
Tested-by: syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 65 ++++++++++++++++++++++++--------------------
 drivers/block/loop.h |  1 +
 2 files changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ba76319b5544..7f4ea06534c2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo, bool release)
+static void __loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1144,8 +1144,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	/* This is safe: open() is still holding a reference. */
-	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
@@ -1153,44 +1151,52 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
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
+
+	fput(filp);
+}
+
+static void loop_rundown_completed(struct loop_device *lo)
+{
 	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
+	module_put(THIS_MODULE);
+}
 
-	/*
-	 * Need not hold lo_mutex to fput backing file. Calling fput holding
-	 * lo_mutex triggers a circular lock dependency possibility warning as
-	 * fput can take open_mutex which is usually taken before lo_mutex.
-	 */
-	fput(filp);
+static void loop_rundown_workfn(struct work_struct *work)
+{
+	struct loop_device *lo = container_of(work, struct loop_device,
+					      rundown_work);
+	struct block_device *bdev = lo->lo_device;
+	struct gendisk *disk = lo->lo_disk;
+
+	__loop_clr_fd(lo);
+	kobject_put(&bdev->bd_device.kobj);
+	module_put(disk->fops->owner);
+	loop_rundown_completed(lo);
+}
+
+static void loop_schedule_rundown(struct loop_device *lo)
+{
+	struct block_device *bdev = lo->lo_device;
+	struct gendisk *disk = lo->lo_disk;
+
+	__module_get(disk->fops->owner);
+	kobject_get(&bdev->bd_device.kobj);
+	INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
+	queue_work(system_long_wq, &lo->rundown_work);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
@@ -1222,7 +1228,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo, false);
+	__loop_clr_fd(lo);
+	loop_rundown_completed(lo);
 	return 0;
 }
 
@@ -1747,7 +1754,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		__loop_clr_fd(lo, true);
+		loop_schedule_rundown(lo);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 082d4b6bfc6a..918a7a2dc025 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,6 +56,7 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
+	struct work_struct      rundown_work;
 };
 
 struct loop_cmd {
-- 
2.18.4

