Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78093C433F5
	for <linux-block@archiver.kernel.org>; Mon, 29 Nov 2021 14:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245678AbhK2OTj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Nov 2021 09:19:39 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:51554 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbhK2ORh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Nov 2021 09:17:37 -0500
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1ATEDvx4073543;
        Mon, 29 Nov 2021 23:13:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Mon, 29 Nov 2021 23:13:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1ATEDuWx073540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Nov 2021 23:13:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <16c7d304-60ef-103f-1b2c-8592b48f47c6@i-love.sakura.ne.jp>
Date:   Mon, 29 Nov 2021 23:13:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [syzbot] possible deadlock in blkdev_put (2)
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
In-Reply-To: <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/29 19:36, Tetsuo Handa wrote:
> On 2021/11/29 19:21, Christoph Hellwig wrote:
>> On Sun, Nov 28, 2021 at 04:42:35PM +0900, Tetsuo Handa wrote:
>>> Is dropping disk->open_mutex inside lo_release()
>>> ( https://lkml.kernel.org/r/e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp ) possible?
>>
>> I don't think we can drop open_mutex inside ->release. What is the
>> problem with offloading the clearing to a different context than the
>> one that calls ->release?
>>
> 
> Offloading to a WQ context?
> 
> If the caller just want to call ioctl(LOOP_CTL_GET_FREE) followed by
> ioctl(LOOP_CONFIGURE), deferring __loop_clr_fd() would be fine.
> 
> But the caller might want to unmount as soon as fput(filp) from __loop_clr_fd() completes.
> I think we need to wait for __loop_clr_fd() from lo_release() to complete.
> 

Something like this?

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0a4416ef4fbf..2d54416abe24 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1210,10 +1210,16 @@ struct block_device_operations {
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
+	/*
+	 * Special callback for waiting for completion of release callback
+	 * without disk->open_mutex held. Used by loop driver.
+	 */
+	void (*wait_release)(struct gendisk *disk);
+
 	/*
 	 * Special callback for probing GPT entry at a given sector.
 	 * Needed by Android devices, used by GPT scanner and MMC blk
 	 * driver.
 	 */
diff --git a/block/bdev.c b/block/bdev.c
index ae063041f291..edadc3fc1df3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -952,10 +952,12 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 	if (bdev_is_partition(bdev))
 		blkdev_put_part(bdev, mode);
 	else
 		blkdev_put_whole(bdev, mode);
 	mutex_unlock(&disk->open_mutex);
+	if (bdev->bd_disk->fops->wait_release)
+		bdev->bd_disk->fops->wait_release(bdev->bd_disk);
 
 	blkdev_put_no_open(bdev);
 }
 EXPORT_SYMBOL(blkdev_put);
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 56b9392737b2..858bb6b4ceea 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -55,10 +55,11 @@ struct loop_device {
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
 	struct gendisk		*lo_disk;
 	struct mutex		lo_mutex;
 	bool			idr_visible;
+	struct work_struct      rundown_work;
 };
 
 struct loop_cmd {
 	struct list_head list_entry;
 	bool use_aio; /* use AIO interface to handle I/O */
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3dfb39d38235..8f1db8ca0eb8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1060,11 +1060,11 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
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
 
@@ -1119,23 +1119,13 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
 
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
@@ -1186,11 +1176,11 @@ static int loop_clr_fd(struct loop_device *lo)
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
@@ -1694,10 +1684,17 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 		atomic_inc(&lo->lo_refcnt);
 	mutex_unlock(&lo->lo_mutex);
 	return err;
 }
 
+static void loop_rundown_workfn(struct work_struct *work)
+{
+	struct loop_device *lo = container_of(work, struct loop_device, rundown_work);
+
+	__loop_clr_fd(lo);
+}
+
 static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
 
 	mutex_lock(&lo->lo_mutex);
@@ -1710,11 +1707,12 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		mutex_unlock(&lo->lo_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		__loop_clr_fd(lo, true);
+		INIT_WORK(&lo->rundown_work, loop_rundown_workfn);
+		queue_work(system_long_wq, &lo->rundown_work);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
 		 * Otherwise keep thread (if running) and config,
 		 * but flush possible ongoing bios in thread.
@@ -1725,14 +1723,22 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
 }
 
+static void lo_wait_release(struct gendisk *disk)
+{
+	struct loop_device *lo = disk->private_data;
+
+	flush_workqueue(system_long_wq);
+}
+
 static const struct block_device_operations lo_fops = {
 	.owner =	THIS_MODULE,
 	.open =		lo_open,
 	.release =	lo_release,
+	.wait_release = lo_wait_release,
 	.ioctl =	lo_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl =	lo_compat_ioctl,
 #endif
 };
