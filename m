Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DC4C433F5
	for <linux-block@archiver.kernel.org>; Sat, 27 Nov 2021 11:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhK0Lco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Nov 2021 06:32:44 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:59857 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbhK0Lao (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Nov 2021 06:30:44 -0500
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1ARBRGpt032943;
        Sat, 27 Nov 2021 20:27:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sat, 27 Nov 2021 20:27:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1ARBRFr9032940
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 27 Nov 2021 20:27:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
Date:   Sat, 27 Nov 2021 20:27:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [syzbot] possible deadlock in blkdev_put (2)
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
References: <0000000000007f2f5405d1bfe618@google.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <0000000000007f2f5405d1bfe618@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

> HEAD commit:    f81e94e91878 Add linux-next specific files for 20211125
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16366216b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=be9183de0824e4d7
> dashboard link: https://syzkaller.appspot.com/bug?extid=643e4ce4b6ad1347d372
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

This looks unsolvable as long as flush_workqueue() is called with disk->open_mutex
held. I think we need to call flush_workqueue() without holding disk->open_mutex.

Since disk->fops->open == lo_open and bdev->bd_disk->fops->release == lo_release
and blkdev_put() calls bdev->bd_disk->fops->release() right before dropping
disk->open_mutex, is dropping disk->open_mutex inside lo_release (something like
below) possible?

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3dfb39d38235..0fde1842686a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1057,17 +1057,17 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		bd_abort_claiming(bdev, loop_configure);
 out_putf:
 	fput(file);
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo, bool release)
+static void __loop_clr_fd(struct loop_device *lo)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 	struct loop_worker *pos, *worker;
 
 	/*
 	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
 	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
@@ -1117,28 +1117,26 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
 		int err;
 
 		/*
-		 * open_mutex has been held already in release path, so don't
-		 * acquire it if this function is called in such case.
+		 * If the reread partition is from release path, lo_refcnt is
+		 * already zero.
 		 *
 		 * If the reread partition isn't from release path, lo_refcnt
 		 * must be at least one and it can only become zero when the
 		 * current holder is released.
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
 		/* Device is gone, no point in returning error */
 	}
 
 	/*
 	 * lo->lo_state is set to Lo_unbound here after above partscan has
@@ -1183,17 +1181,17 @@ static int loop_clr_fd(struct loop_device *lo)
 	if (atomic_read(&lo->lo_refcnt) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 		mutex_unlock(&lo->lo_mutex);
 		return 0;
 	}
 	loop_update_state_locked(lo, Lo_rundown);
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo, false);
+	__loop_clr_fd(lo);
 	return 0;
 }
 
 static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	int err;
 	int prev_lo_flags;
@@ -1683,17 +1681,17 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
-	if (lo->lo_state == Lo_deleting)
+	if (lo->lo_state == Lo_deleting || lo->lo_state == Lo_rundown)
 		err = -ENXIO;
 	else
 		atomic_inc(&lo->lo_refcnt);
 	mutex_unlock(&lo->lo_mutex);
 	return err;
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
@@ -1706,18 +1704,27 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
 		if (!loop_try_update_state_locked(lo, Lo_bound, Lo_rundown))
 			goto out_unlock;
 		mutex_unlock(&lo->lo_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
+		 *
+		 * Since calling flush_workqueue() with open_mutex held causes
+		 * circular locking dependency problem, call __loop_clr_fd()
+		 * without open_mutex. Use lo->lo_state == Lo_rundown condition
+		 * for preventing lo_open() from incrementing lo_refcnt, for
+		 * calling __loop_clr_fd() without open_mutex might result in
+		 * entering lo_open() before lo_release() completes.
 		 */
-		__loop_clr_fd(lo, true);
+		mutex_unlock(&lo->lo_disk->open_mutex);
+		__loop_clr_fd(lo);
+		mutex_lock(&lo->lo_disk->open_mutex);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
 		 * but flush possible ongoing bios in thread.
 		 */
 		blk_mq_freeze_queue(lo->lo_queue);
 		blk_mq_unfreeze_queue(lo->lo_queue);

