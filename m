Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303D4C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 11:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1447961357
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 11:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFVLSA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 07:18:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61020 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhFVLSA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 07:18:00 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 15MBFXOj042264;
        Tue, 22 Jun 2021 20:15:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Tue, 22 Jun 2021 20:15:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 15MBFXun042257
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 22 Jun 2021 20:15:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: loop cleanups
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20210621101547.3764003-1-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <48fc3b1d-37b2-3f1f-3b2d-63a5711491bd@i-love.sakura.ne.jp>
Date:   Tue, 22 Jun 2021 20:15:27 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/21 19:15, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains a bunch of cleanups for the loop driver,
> mostly related to probing and the control device.
> 

Please fold

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a4a5466b998f..6c10400d4d38 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2163,8 +2163,9 @@ static int loop_add(int i)
 	disk->queue		= lo->lo_queue;
 	sprintf(disk->disk_name, "loop%d", i);
 	add_disk(disk);
+	err = lo->lo_number;
 	mutex_unlock(&loop_ctl_mutex);
-	return lo->lo_number;
+	return err;
 
 out_free_queue:
 	blk_cleanup_queue(lo->lo_queue);
@@ -2253,8 +2254,9 @@ static int loop_control_get_free(int idx)
 	mutex_unlock(&loop_ctl_mutex);
 	return loop_add(-1);
 found:
+	ret = lo->lo_number;
 	mutex_unlock(&loop_ctl_mutex);
-	return lo->lo_number;
+	return ret;
 }
 
 static long loop_control_ioctl(struct file *file, unsigned int cmd,

into this series, for "mutex_unlock(&loop_ctl_mutex)" allows loop_control_remove()
to call "kfree(lo)" before "return lo->lo_number" is evaluated.



By the way, how can we fix a regression introduced by commit 6cc8e7430801fa23
("loop: scale loop device by introducing per device lock") ?
Conditionally holding global lock like below untested diff?

 drivers/block/loop.c |   67 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a4a5466b998f..f755ef82ee51 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -86,6 +86,7 @@
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
+static DEFINE_MUTEX(loop_configure_mutex);
 
 static int max_part;
 static int part_shift;
@@ -680,9 +681,12 @@ static int loop_validate_file(struct file *file, struct block_device *bdev)
 			return -EBADF;
 
 		l = I_BDEV(f->f_mapping->host)->bd_disk->private_data;
-		if (l->lo_state != Lo_bound) {
+		/*
+		 * loop_configure_mutex protects us from observing
+		 * l->lo_state == Lo_bound but l->lo_backing_file == NULL.
+		 */
+		if (l->lo_state != Lo_bound)
 			return -EINVAL;
-		}
 		f = l->lo_backing_file;
 	}
 	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
@@ -704,10 +708,26 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	struct file	*file = NULL, *old_file;
 	int		error;
 	bool		partscan;
+	bool need_global_lock;
 
+	file = fget(arg);
+	if (!file)
+		return -EBADF;
+	need_global_lock = is_loop_device(file);
+	if (need_global_lock) {
+		error = mutex_lock_killable(&loop_configure_mutex);
+		if (error) {
+			fput(file);
+			return error;
+		}
+	}
 	error = mutex_lock_killable(&lo->lo_mutex);
-	if (error)
+	if (error) {
+		if (need_global_lock)
+			mutex_unlock(&loop_configure_mutex);
+		fput(file);
 		return error;
+	}
 	error = -ENXIO;
 	if (lo->lo_state != Lo_bound)
 		goto out_err;
@@ -717,11 +737,6 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
 		goto out_err;
 
-	error = -EBADF;
-	file = fget(arg);
-	if (!file)
-		goto out_err;
-
 	error = loop_validate_file(file, bdev);
 	if (error)
 		goto out_err;
@@ -745,6 +760,8 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	mutex_unlock(&lo->lo_mutex);
+	if (need_global_lock)
+		mutex_unlock(&loop_configure_mutex);
 	/*
 	 * We must drop file reference outside of lo_mutex as dropping
 	 * the file ref can take bd_mutex which creates circular locking
@@ -757,8 +774,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 
 out_err:
 	mutex_unlock(&lo->lo_mutex);
-	if (file)
-		fput(file);
+	if (need_global_lock)
+		mutex_unlock(&loop_configure_mutex);
+	fput(file);
 	return error;
 }
 
@@ -1074,6 +1092,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	loff_t		size;
 	bool		partscan;
 	unsigned short  bsize;
+	bool need_global_lock;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
@@ -1093,9 +1112,18 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 			goto out_putf;
 	}
 
+	need_global_lock = is_loop_device(file);
+	if (need_global_lock) {
+		error = mutex_lock_killable(&loop_configure_mutex);
+		if (error)
+			goto out_bdev;
+	}
 	error = mutex_lock_killable(&lo->lo_mutex);
-	if (error)
+	if (error) {
+		if (need_global_lock)
+			mutex_unlock(&loop_configure_mutex);
 		goto out_bdev;
+	}
 
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
@@ -1173,6 +1201,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 */
 	bdgrab(bdev);
 	mutex_unlock(&lo->lo_mutex);
+	if (need_global_lock)
+		mutex_unlock(&loop_configure_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	if (!(mode & FMODE_EXCL))
@@ -1181,6 +1211,8 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
+	if (need_global_lock)
+		mutex_unlock(&loop_configure_mutex);
 out_bdev:
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
@@ -1309,11 +1341,17 @@ static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
 
-	err = mutex_lock_killable(&lo->lo_mutex);
+	err = mutex_lock_killable(&loop_configure_mutex);
 	if (err)
 		return err;
+	err = mutex_lock_killable(&lo->lo_mutex);
+	if (err) {
+		mutex_unlock(&loop_configure_mutex);
+		return err;
+	}
 	if (lo->lo_state != Lo_bound) {
 		mutex_unlock(&lo->lo_mutex);
+		mutex_unlock(&loop_configure_mutex);
 		return -ENXIO;
 	}
 	/*
@@ -1329,10 +1367,12 @@ static int loop_clr_fd(struct loop_device *lo)
 	if (atomic_read(&lo->lo_refcnt) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
 		mutex_unlock(&lo->lo_mutex);
+		mutex_unlock(&loop_configure_mutex);
 		return 0;
 	}
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
+	mutex_unlock(&loop_configure_mutex);
 
 	return __loop_clr_fd(lo, false);
 }
@@ -1897,6 +1937,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
 
+	mutex_lock(&loop_configure_mutex);
 	mutex_lock(&lo->lo_mutex);
 	if (atomic_dec_return(&lo->lo_refcnt))
 		goto out_unlock;
@@ -1906,6 +1947,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 			goto out_unlock;
 		lo->lo_state = Lo_rundown;
 		mutex_unlock(&lo->lo_mutex);
+		mutex_unlock(&loop_configure_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
@@ -1923,6 +1965,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 
 out_unlock:
 	mutex_unlock(&lo->lo_mutex);
+	mutex_unlock(&loop_configure_mutex);
 }
 
 static const struct block_device_operations lo_fops = {
