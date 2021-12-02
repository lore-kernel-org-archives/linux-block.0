Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C53C433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 11:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241502AbhLBLHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 06:07:18 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56580 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357146AbhLBLHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 06:07:17 -0500
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1B2B3c0Q012863;
        Thu, 2 Dec 2021 20:03:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Thu, 02 Dec 2021 20:03:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1B2B3bt6012858
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Dec 2021 20:03:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <fb6adcdc-fb56-3b90-355b-3f5a81220f2b@i-love.sakura.ne.jp>
Date:   Thu, 2 Dec 2021 20:03:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] loop: make autoclear operation asynchronous
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
 <YaYfu0H2k0PSQL6W@infradead.org>
 <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
 <Yah0Q//l+I+eM+kf@infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <Yah0Q//l+I+eM+kf@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/12/02 16:22, Christoph Hellwig wrote:
> On Wed, Dec 01, 2021 at 11:41:23PM +0900, Tetsuo Handa wrote:
>> OK. Here is a patch.
>> Is this better than temporarily dropping disk->open_mutex ?
> 
> This looks much better, and also cleans up the horrible locking warts
> in __loop_clr_fd.
> 

What "the horrible locking warts" refer to? Below approach temporarily
drops disk->open_mutex. I think there is no locking difference between
synchronous and asynchronous...

Anyway, I resent
https://lkml.kernel.org/r/d1f760f9-cdb2-f40d-33d8-bfa517c731be@i-love.sakura.ne.jp
in order to apply before "loop: replace loop_validate_mutex with loop_validate_spinlock".

---
 drivers/block/loop.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ba76319b5544..31d3fbe67fea 100644
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
@@ -1153,31 +1153,15 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
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
@@ -1185,11 +1169,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 
-	/*
-	 * Need not hold lo_mutex to fput backing file. Calling fput holding
-	 * lo_mutex triggers a circular lock dependency possibility warning as
-	 * fput can take open_mutex which is usually taken before lo_mutex.
-	 */
 	fput(filp);
 }
 
@@ -1222,7 +1201,7 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	__loop_clr_fd(lo, false);
+	__loop_clr_fd(lo);
 	return 0;
 }
 
@@ -1747,7 +1726,9 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
 		 */
-		__loop_clr_fd(lo, true);
+		mutex_unlock(&lo->lo_disk->open_mutex);
+		__loop_clr_fd(lo);
+		mutex_lock(&lo->lo_disk->open_mutex);
 		return;
 	} else if (lo->lo_state == Lo_bound) {
 		/*
-- 
2.18.4

