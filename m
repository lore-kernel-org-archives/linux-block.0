Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F121C433F5
	for <linux-block@archiver.kernel.org>; Fri, 14 Jan 2022 11:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbiANLF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jan 2022 06:05:59 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57618 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiANLF6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jan 2022 06:05:58 -0500
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20EB5X5k012609;
        Fri, 14 Jan 2022 20:05:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Fri, 14 Jan 2022 20:05:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20EB5VJa012603
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Jan 2022 20:05:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <37878b0a-da3b-1285-4f42-27871bfaddee@I-love.SAKURA.ne.jp>
Date:   Fri, 14 Jan 2022 20:05:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/2] loop: use task_work for autoclear operation
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Jan Stancek <jstancek@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
References: <969f764d-0e0f-6c64-de72-ecfee30bdcf7@I-love.SAKURA.ne.jp>
 <bcaf38e6-055e-0d83-fd1d-cb7c0c649372@I-love.SAKURA.ne.jp>
 <20220110103057.h775jv2br2xr2l5k@quack3.lan>
 <fc15d4a1-a9d2-1a26-71dc-827b0445d957@I-love.SAKURA.ne.jp>
 <20220110134234.qebxn5gghqupsc7t@quack3.lan>
 <d1ca4fa4-ac3e-1354-3d94-1bf55f2000a9@I-love.SAKURA.ne.jp>
 <20220112131615.qsdxx6r7xvnvlwgx@quack3.lan>
 <a614bffa-d2a8-60c0-a2d9-e0ad1be17939@I-love.SAKURA.ne.jp>
 <20220113152306.n4awebeougcamvny@quack3.lan>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220113152306.n4awebeougcamvny@quack3.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/01/14 0:23, Jan Kara wrote:
> Well, we cannot guarantee what will be state of the loop device when you
> open it but I think we should guarantee that once you have loop device
> open, it will not be torn down under your hands. And now that I have
> realized there are those lo_state checks, I think everything is fine in
> that regard. I wanted to make sure that sequence such as:

Well, we could abort __loop_clr_fd() if somebody called "open()", something
like below. But

----------------------------------------
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1b05c45c07c..960db2c484ab 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1082,7 +1082,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static void __loop_clr_fd(struct loop_device *lo)
+static bool __loop_clr_fd(struct loop_device *lo, int expected_refcnt)
 {
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
@@ -1104,9 +1104,19 @@ static void __loop_clr_fd(struct loop_device *lo)
 	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
 	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
 	 * lo->lo_state has changed while waiting for lo->lo_mutex.
+	 *
+	 * However, if somebody called "open()" after lo->lo_state became
+	 * Lo_rundown, we should abort rundown in order to avoid unexpected
+	 * I/O error.
 	 */
 	mutex_lock(&lo->lo_mutex);
 	BUG_ON(lo->lo_state != Lo_rundown);
+	if (atomic_read(&lo->lo_refcnt) != expected_refcnt) {
+		lo->lo_state = Lo_bound;
+		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
+		mutex_unlock(&lo->lo_mutex);
+		return false;
+	}
 	mutex_unlock(&lo->lo_mutex);
 
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
@@ -1165,6 +1175,7 @@ static void __loop_clr_fd(struct loop_device *lo)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART;
 
 	fput(filp);
+	return true;
 }
 
 static void loop_rundown_completed(struct loop_device *lo)
@@ -1181,11 +1192,12 @@ static void loop_rundown_workfn(struct work_struct *work)
 					      rundown_work);
 	struct block_device *bdev = lo->lo_device;
 	struct gendisk *disk = lo->lo_disk;
+	const bool cleared = __loop_clr_fd(lo, 0);
 
-	__loop_clr_fd(lo);
 	kobject_put(&bdev->bd_device.kobj);
 	module_put(disk->fops->owner);
-	loop_rundown_completed(lo);
+	if (cleared)
+		loop_rundown_completed(lo);
 }
 
 static void loop_schedule_rundown(struct loop_device *lo)
@@ -1228,8 +1240,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo);
-	loop_rundown_completed(lo);
+	if (__loop_clr_fd(lo, 1))
+		loop_rundown_completed(lo);
 	return 0;
 }
 
----------------------------------------

> Currently, we may hold both. With your async patch we hold only lo_mutex.
> Now that I better understand the nature of the deadlock, I agree that
> holding either still creates the deadlock possibility because both are
> acquired on loop device open. But now that I reminded myself the lo_state
> handling, I think the following should be safe in __loop_clr_fd:
> 
> 	/* Just a safety check... */
> 	if (WARN_ON_ONCE(data_race(lo->lo_state) != Lo_rundown))
> 		return -ENXIO;
> 

this is still racy, for somebody can reach lo_open() right after this check.

Anyway, since the problem that umount() immediately after close() (reported by
kernel test robot) remains, we need to make sure that __loop_clr_fd() completes
before close() returns to user mode.

