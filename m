Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F39FC433EF
	for <linux-block@archiver.kernel.org>; Sun, 28 Nov 2021 05:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhK1Fij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Nov 2021 00:38:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:65387 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhK1Fgj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Nov 2021 00:36:39 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1AS5WtF9026713;
        Sun, 28 Nov 2021 14:32:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sun, 28 Nov 2021 14:32:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1AS5WsOp026707
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 28 Nov 2021 14:32:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
Date:   Sun, 28 Nov 2021 14:32:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [syzbot] possible deadlock in blkdev_put (2)
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
In-Reply-To: <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On 2021/11/27 20:27, Tetsuo Handa wrote:
> Hello.
> 
>> HEAD commit:    f81e94e91878 Add linux-next specific files for 20211125
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=16366216b00000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
>> dashboard link: https://syzkaller.appspot.com/bug?extid=643e4ce4b6ad1347d372
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> This looks unsolvable as long as flush_workqueue() is called with disk->open_mutex
> held. I think we need to call flush_workqueue() without holding disk->open_mutex.

Commit a1ecac3b0656a682 ("loop: Make explicit loop device destruction lazy") changed

	if (lo->lo_refcnt > 1)  /* we needed one fd for the ioctl */
		return -EBUSY;

in loop_clr_fd() to

	if (lo->lo_refcnt > 1) {
		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
		mutex_unlock(&lo->lo_ctl_mutex);
		return 0;
	}

but how does lo_refcnt matter here?
What happens if we ignore lo->lo_refcnt > 1 check (i.e. allow this loop device
to tear down even if somebody else (likely blkid via udev) is still accessing
this loop device) ?

lo_open() increments lo->lo_refcnt with lo->lo_mutex held. However, since
loop_clr_fd() releases lo->lo_mutex before calling __loop_clr_fd(), setting
LO_FLAGS_AUTOCLEAR flag based on whether there is somebody else accessing
this loop device is racy. That is, __loop_clr_fd() might be already started
by the moment blkid via udev calls lo_open(). lo_open() by blkid via udev will
succeed and blkid would access loop device in Lo_rundown state.

That is, userspace programs can tolerate accessing loop devide in Lo_rundown
state. Then, why not unconditionally start __loop_clr_fd() instead of unreliably
setting LO_FLAGS_AUTOCLEAR flag (i.e. force loop device destruction instead of
making loop device destruction lazy) ?

If we can unconditionally start __loop_clr_fd() upon ioctl(LOOP_CLR_FD), I think
we can avoid circular locking between disk->open_mutex and flush_workqueue().

---
 drivers/block/loop.c | 86 +++++++-------------------------------------
 1 file changed, 12 insertions(+), 74 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3dfb39d38235..cd82c8a5c8d5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -680,9 +680,7 @@ static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
-	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
-
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return sprintf(buf, "%s\n", "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
@@ -1062,20 +1060,13 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo, bool release)
+static int loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp;
-	gfp_t gfp = lo->old_gfp_mask;
 	struct loop_worker *pos, *worker;
 
-	/*
-	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
-	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
-	 * lo->lo_state has changed while waiting for lo->lo_mutex.
-	 */
-	mutex_lock(&lo->lo_mutex);
-	BUG_ON(lo->lo_state != Lo_rundown);
-	mutex_unlock(&lo->lo_mutex);
+	if (!loop_try_update_state(lo, Lo_bound, Lo_rundown))
+		return -ENXIO;
 
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
@@ -1111,7 +1102,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	loop_sysfs_exit(lo);
 	/* let user-space know about this change */
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
-	mapping_set_gfp_mask(filp->f_mapping, gfp);
+	mapping_set_gfp_mask(filp->f_mapping, lo->old_gfp_mask);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
@@ -1122,18 +1113,12 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 		int err;
 
 		/*
-		 * open_mutex has been held already in release path, so don't
-		 * acquire it if this function is called in such case.
-		 *
-		 * If the reread partition isn't from release path, lo_refcnt
-		 * must be at least one and it can only become zero when the
-		 * current holder is released.
+		 * lo_refcnt must be at least one and it can only become zero
+		 * when the current holder is released.
 		 */
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
@@ -1142,7 +1127,7 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 
 	/*
 	 * lo->lo_state is set to Lo_unbound here after above partscan has
-	 * finished. There cannot be anybody else entering __loop_clr_fd() as
+	 * finished. There cannot be anybody else entering loop_clr_fd() as
 	 * Lo_rundown state protects us from all the other places trying to
 	 * change the 'lo' device.
 	 */
@@ -1157,38 +1142,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	 * fput can take open_mutex which is usually taken before lo_mutex.
 	 */
 	fput(filp);
-}
-
-static int loop_clr_fd(struct loop_device *lo)
-{
-	int err;
-
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		return err;
-	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&lo->lo_mutex);
-		return -ENXIO;
-	}
-	/*
-	 * If we've explicitly asked to tear down the loop device,
-	 * and it has an elevated reference count, set it for auto-teardown when
-	 * the last reference goes away. This stops $!~#$@ udev from
-	 * preventing teardown because it decided that it needs to run blkid on
-	 * the loopback device whenever they appear. xfstests is notorious for
-	 * failing tests because blkid via udev races with a losetup
-	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup -d
-	 * command to fail with EBUSY.
-	 */
-	if (atomic_read(&lo->lo_refcnt) > 1) {
-		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&lo->lo_mutex);
-		return 0;
-	}
-	loop_update_state_locked(lo, Lo_rundown);
-	mutex_unlock(&lo->lo_mutex);
-
-	__loop_clr_fd(lo, false);
 	return 0;
 }
 
@@ -1703,26 +1656,11 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	mutex_lock(&lo->lo_mutex);
 	if (atomic_dec_return(&lo->lo_refcnt))
 		goto out_unlock;
-
-	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (!loop_try_update_state_locked(lo, Lo_bound, Lo_rundown))
-			goto out_unlock;
-		mutex_unlock(&lo->lo_mutex);
-		/*
-		 * In autoclear mode, stop the loop thread
-		 * and remove configuration after last close.
-		 */
-		__loop_clr_fd(lo, true);
-		return;
-	} else if (lo->lo_state == Lo_bound) {
-		/*
-		 * Otherwise keep thread (if running) and config,
-		 * but flush possible ongoing bios in thread.
-		 */
+	/* If still bound, flush request queue. */
+	if (lo->lo_state == Lo_bound) {
 		blk_mq_freeze_queue(lo->lo_queue);
 		blk_mq_unfreeze_queue(lo->lo_queue);
 	}
-
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 }
-- 
2.18.4

