Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C26FC433F5
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 16:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5844B61029
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 16:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhKLQ2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:28:22 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:49875 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhKLQ2U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 11:28:20 -0500
Received: from fsav115.sakura.ne.jp (fsav115.sakura.ne.jp [27.133.134.242])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 1ACGPDEr005958;
        Sat, 13 Nov 2021 01:25:13 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav115.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp);
 Sat, 13 Nov 2021 01:25:13 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav115.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 1ACGPCjc005955
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 13 Nov 2021 01:25:12 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-ID: <7d851c88-f657-dfd8-34ab-4891ac6388dc@i-love.sakura.ne.jp>
Date:   Sat, 13 Nov 2021 01:25:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [syzbot] possible deadlock in __loop_clr_fd (3)
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org
References: <00000000000089436205d07229eb@google.com>
 <0e91a4b0-ef91-0e60-c0fc-e03da3b65d57@I-love.SAKURA.ne.jp>
 <YYxqHhzEwCqhsy1Y@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
 <9e583550-7cc8-e8a9-59bf-69d415fffe16@i-love.sakura.ne.jp>
 <20211112062015.GA28294@lst.de>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <20211112062015.GA28294@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/12 15:20, Christoph Hellwig wrote:
>> @@ -1121,7 +1125,20 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
>>  	/* freeze request queue during the transition */
>>  	blk_mq_freeze_queue(lo->lo_queue);
>>  
>> +	/*
>> +	 * To avoid circular locking dependency, call destroy_workqueue()
>> +	 * without holding lo->lo_mutex.
>> +	 */
>> +	mutex_unlock(&lo->lo_mutex);
>>  	destroy_workqueue(lo->workqueue);
>> +	mutex_lock(&lo->lo_mutex);
> 
> As far as I can tell there is absolutely no need to hold lo_mutex
> above these changes at all, as the Lo_rundown check prevents
> access to all the other fields we're changing.  So I think we can
> drop this entire critical section and just keep the one at the
> end of the funtion where lo_state is changed.

Indeed, since the access pattern is

  mutex_lock(&lo->lo_mutex);
  if (lo->lo_state == Lo_expected_state) {
    /* Do something here. */
    lo->lo_state = Lo_new_state;
  }
  mutex_unlock(&lo->lo_mutex);

, assigning a dedicated state for individual operation (e.g.
Lo_deleting for loop_remove(), Lo_rundown for __loop_clr_fd())
eliminates the need to hold lo->lo_mutex throughout that operation
(which in turn helps shortening locking dependency chains).

  mutex_lock(&lo->lo_mutex);
  if (lo->lo_state != Lo_expected_state) {
    mutex_unlock(&lo->lo_mutex);
    return;
  }
  lo->lo_state = Lo_state_for_this_operation;
  mutex_unlock(&lo->lo_mutex);
  /* Do something here without lo->lo_mutex. */
  mutex_lock(&lo->lo_mutex);
  lo->lo_state = Lo_new_state;
  mutex_unlock(&lo->lo_mutex);

From 4ba8c1de297d6a09649a434ac4fa81e3f07bedba Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 13 Nov 2021 10:19:15 +0900
Subject: [PATCH v2] loop: don't hold lo_mutex during __loop_clr_fd()

syzbot is reporting circular locking problem at __loop_clr_fd() [1], for
commit 87579e9b7d8dc36e ("loop: use worker per cgroup instead of kworker")
is calling destroy_workqueue() with lo->lo_mutex held.

Since all functions where lo->lo_state matters are already checking
lo->lo_state with lo->lo_mutex held (in order to avoid racing with e.g.
ioctl(LOOP_CTL_REMOVE)), and __loop_clr_fd() can be called from either
ioctl(LOOP_CLR_FD) xor close(), lo->lo_state == Lo_rundown is considered
as an exclusive lock for __loop_clr_fd(). Therefore, hold lo->lo_mutex
inside __loop_clr_fd() only when asserting/updating lo->lo_state.

Since ioctl(LOOP_CLR_FD) depends on lo->lo_state == Lo_bound, a valid
lo->lo_backing_file must have been assigned by ioctl(LOOP_SET_FD) or
ioctl(LOOP_CONFIGURE). Thus, we can remove lo->lo_backing_file test,
and convert __loop_clr_fd() into a void function.

Link: https://syzkaller.appspot.com/bug?extid=63614029dfb79abd4383 [1]
Reported-by: syzbot <syzbot+63614029dfb79abd4383@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Hold lo->lo_mutex only when asserting/updating lo->lo_state.
  Convert __loop_clr_fd() to return void.

 drivers/block/loop.c | 55 ++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a154cab6cd98..30ee34c6498e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1082,13 +1082,10 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return error;
 }
 
-static int __loop_clr_fd(struct loop_device *lo, bool release)
+static void __loop_clr_fd(struct loop_device *lo, bool release)
 {
-	struct file *filp = NULL;
+	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
-	int err = 0;
-	bool partscan = false;
-	int lo_number;
 	struct loop_worker *pos, *worker;
 
 	/*
@@ -1103,17 +1100,14 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	 * became visible.
 	 */
 
+	/*
+	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
+	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
+	 * lo->lo_state has changed while waiting for lo->lo_mutex.
+	 */
 	mutex_lock(&lo->lo_mutex);
-	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
-		err = -ENXIO;
-		goto out_unlock;
-	}
-
-	filp = lo->lo_backing_file;
-	if (filp == NULL) {
-		err = -EINVAL;
-		goto out_unlock;
-	}
+	BUG_ON(lo->lo_state != Lo_rundown);
+	mutex_unlock(&lo->lo_mutex);
 
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
@@ -1134,6 +1128,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	del_timer_sync(&lo->timer);
 
 	spin_lock_irq(&lo->lo_lock);
+	filp = lo->lo_backing_file;
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
 
@@ -1153,12 +1148,11 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
-	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
-	lo_number = lo->lo_number;
 	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
-out_unlock:
-	mutex_unlock(&lo->lo_mutex);
-	if (partscan) {
+
+	if (lo->lo_flags & LO_FLAGS_PARTSCAN) {
+		int err;
+
 		/*
 		 * open_mutex has been held already in release path, so don't
 		 * acquire it if this function is called in such case.
@@ -1174,24 +1168,20 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 			mutex_unlock(&lo->lo_disk->open_mutex);
 		if (err)
 			pr_warn("%s: partition scan of loop%d failed (rc=%d)\n",
-				__func__, lo_number, err);
+				__func__, lo->lo_number, err);
 		/* Device is gone, no point in returning error */
-		err = 0;
 	}
 
 	/*
 	 * lo->lo_state is set to Lo_unbound here after above partscan has
-	 * finished.
-	 *
-	 * There cannot be anybody else entering __loop_clr_fd() as
-	 * lo->lo_backing_file is already cleared and Lo_rundown state
-	 * protects us from all the other places trying to change the 'lo'
-	 * device.
+	 * finished. There cannot be anybody else entering __loop_clr_fd() as
+	 * Lo_rundown state protects us from all the other places trying to
+	 * change the 'lo' device.
 	 */
-	mutex_lock(&lo->lo_mutex);
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+	mutex_lock(&lo->lo_mutex);
 	lo->lo_state = Lo_unbound;
 	mutex_unlock(&lo->lo_mutex);
 
@@ -1200,9 +1190,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	 * lo_mutex triggers a circular lock dependency possibility warning as
 	 * fput can take open_mutex which is usually taken before lo_mutex.
 	 */
-	if (filp)
-		fput(filp);
-	return err;
+	fput(filp);
 }
 
 static int loop_clr_fd(struct loop_device *lo)
@@ -1234,7 +1222,8 @@ static int loop_clr_fd(struct loop_device *lo)
 	lo->lo_state = Lo_rundown;
 	mutex_unlock(&lo->lo_mutex);
 
-	return __loop_clr_fd(lo, false);
+	__loop_clr_fd(lo, false);
+	return 0;
 }
 
 static int
-- 
2.18.4
