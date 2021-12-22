Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C3AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 12:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhLVMDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 07:03:24 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54321 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244754AbhLVMDX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 07:03:23 -0500
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1BMC3E2a014278;
        Wed, 22 Dec 2021 21:03:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Wed, 22 Dec 2021 21:03:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1BMC3DOp014275
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Dec 2021 21:03:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <465d3a0a-a55d-4838-ffc4-176f774dbcdb@i-love.sakura.ne.jp>
Date:   Wed, 22 Dec 2021 21:03:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: [PATCH 2/2] loop: make autoclear operation synchronous again
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
References: <08d703d1-8b32-ec9b-2b50-54b8376d3d40@i-love.sakura.ne.jp>
In-Reply-To: <08d703d1-8b32-ec9b-2b50-54b8376d3d40@i-love.sakura.ne.jp>
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

Make the autoclear operation upon close() synchronous, by performing
__loop_clr_fd() from post_release() block device callback than from
release() block device callback.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 322c4293ecc58110 ("loop: make autoclear operation asynchronous")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 42 ++++++++++++------------------------------
 drivers/block/loop.h |  2 +-
 2 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..faa3a3097b22 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1165,40 +1165,12 @@ static void __loop_clr_fd(struct loop_device *lo)
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
@@ -1229,7 +1201,6 @@ static int loop_clr_fd(struct loop_device *lo)
 	mutex_unlock(&lo->lo_mutex);
 
 	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
 	return 0;
 }
 
@@ -1754,7 +1725,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		loop_schedule_rundown(lo);
+		lo->rundown_owner = current;
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
@@ -1769,10 +1740,21 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	mutex_unlock(&lo->lo_mutex);
 }
 
+static void lo_post_release(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
+
+	if (lo->rundown_owner != current)
+		return;
+	lo->rundown_owner = NULL;
+	__loop_clr_fd(lo);
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
 	.release =	lo_release,
+	.post_release = lo_post_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 918a7a2dc025..f2e9f38694dc 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -56,7 +56,7 @@ struct loop_device {
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
-	struct work_struct      rundown_work;
+	struct task_struct	*rundown_owner; /* current or NULL */
 };
 
 struct loop_cmd {
-- 
2.32.0


