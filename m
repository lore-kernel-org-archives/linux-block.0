Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FEFC2BA4C
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 15:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiAZPvI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiAZPvH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 10:51:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB44C06173B
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+z9BCWEVZR0qmxdIpRWZf3RBB6NlkLhMsrLB//YKZJ8=; b=ZPVbwlcsRpmQ+9O4wf9y2gyioc
        wtkWXN0kE654ovurEbZ33SI8kF63Sq7FTe4Ik9dknh2xyrX08mhZIt+UGiXG8tBhzxhl06ZDUAcnd
        739QnRZt/PVMPbcABlc2X/AjZnW+vFs14+MTRQnei1He5mH+WHTwW006FRVBiaQk/xTi2Y8LvLAGz
        uOKetgUS136dvnoI2e/RloE7JJchWMjBGOvMgznWdy506fRaAb6BWsFEzdWoWUZq5cFDitVE+8oQm
        kyj7EkW1cltr+5mlSibPQC+mH/7/Iz8irwSv6/+1MkK+8BI6t/FXp5lNT+gOJIUyHfB4nQH+JYO7E
        wZ6/ba2g==;
Received: from [2001:4bb8:180:4c4c:c422:bb0a:5a5f:dce0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCkZc-00CQEF-Mi; Wed, 26 Jan 2022 15:51:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        kernel test robot <oliver.sang@intel.com>,
        syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
Subject: [PATCH 8/8] loop: make autoclear operation synchronous again
Date:   Wed, 26 Jan 2022 16:50:40 +0100
Message-Id: <20220126155040.1190842-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126155040.1190842-1-hch@lst.de>
References: <20220126155040.1190842-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

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
loop_remove() after ensuring that the worker rbtree and repaing
timer are kept alive while the loop device exists.

Since a loop device is likely reused after once created thanks to
ioctl(LOOP_CTL_GET_FREE), being unable to destroy corresponding WQ
when ioctl(LOOP_CLR_FD) is called should be an acceptable waste.

Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot <syzbot+643e4ce4b6ad1347d372@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
[hch: rebased, keep the work rbtree and timer around longer]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 71 ++++++++++++++------------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fc0cdd1612b1d..cf7830a68113a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1038,10 +1038,10 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
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
@@ -1147,10 +1147,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	if (!release)
 		blk_mq_freeze_queue(lo->lo_queue);
 
-	destroy_workqueue(lo->workqueue);
-	loop_free_idle_workers(lo, true);
-	del_timer_sync(&lo->timer);
-
 	spin_lock_irq(&lo->lo_lock);
 	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
@@ -1176,9 +1172,11 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
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
@@ -1189,39 +1187,17 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
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
 
-	__loop_clr_fd(lo, true);
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
+	/*
+	 * Need not hold lo_mutex to fput backing file. Calling fput holding
+	 * lo_mutex triggers a circular lock dependency possibility warning as
+	 * fput can take open_mutex which is usually taken before lo_mutex.
+	 */
+	fput(filp);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
@@ -1254,7 +1230,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_mutex);
 
 	__loop_clr_fd(lo, false);
-	loop_rundown_completed(lo);
 	return 0;
 }
 
@@ -1753,20 +1728,14 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		return;
 
 	mutex_lock(&lo->lo_mutex);
-	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (lo->lo_state != Lo_bound)
-			goto out_unlock;
+	if (lo->lo_state == Lo_bound &&
+	    (lo->lo_flags & LO_FLAGS_AUTOCLEAR)) {
 		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
-		/*
-		 * In autoclear mode, stop the loop thread
-		 * and remove configuration after last close.
-		 */
-		loop_schedule_rundown(lo);
+		__loop_clr_fd(lo, true);
 		return;
 	}
 
-out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 }
 
@@ -2056,6 +2025,12 @@ static void loop_remove(struct loop_device *lo)
 	mutex_lock(&loop_ctl_mutex);
 	idr_remove(&loop_index_idr, lo->lo_number);
 	mutex_unlock(&loop_ctl_mutex);
+
+	if (lo->workqueue)
+		destroy_workqueue(lo->workqueue);
+	loop_free_idle_workers(lo, true);
+	del_timer_sync(&lo->timer);
+
 	/* There is no route which can find this loop device. */
 	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
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
-- 
2.30.2

