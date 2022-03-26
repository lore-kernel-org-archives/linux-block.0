Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEC6C433EF
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 02:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiCZCyP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 22:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCZCyO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 22:54:14 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A684C1D78A6
        for <linux-block@vger.kernel.org>; Fri, 25 Mar 2022 19:52:38 -0700 (PDT)
Received: from fsav312.sakura.ne.jp (fsav312.sakura.ne.jp [153.120.85.143])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22Q2qaEv006264;
        Sat, 26 Mar 2022 11:52:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav312.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp);
 Sat, 26 Mar 2022 11:52:36 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav312.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22Q2qaQI006261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 26 Mar 2022 11:52:36 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <03628e13-ca56-4ed0-da5a-ee698c83f48d@I-love.SAKURA.ne.jp>
Date:   Sat, 26 Mar 2022 11:52:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 13/14] loop: remove lo_refcount and avoid lo_mutex in
 ->open / ->release
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
References: <20220325063929.1773899-1-hch@lst.de>
 <20220325063929.1773899-14-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220325063929.1773899-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since __loop_clr_fd() is currently holding loop_validate_mutex and lo->lo_mutex,
"avoid lo_mutex in ->release" part is incomplete.

The intent of holding loop_validate_mutex (which causes disk->open_mutex =>
loop_validate_mutex => lo->lo_mutex => blk_mq_freeze_queue()/blk_mq_unfreeze_queue()
chain) is to make loop_validate_file() traversal safe.

Since ->release is called with disk->open_mutex held, and __loop_clr_fd() from
lo_release() is called via ->release when disk_openers() == 0, we are guaranteed
that "struct file" which will be passed to loop_validate_file() via fget() cannot
be the loop device __loop_clr_fd(lo, true) will clear. Thus, there is no need to
hold loop_validate_mutex and lo->lo_mutex from __loop_clr_fd() if release == true.

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2506193a4fd1..d47f3d86dd55 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1136,25 +1136,26 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	gfp_t gfp = lo->old_gfp_mask;
 
 	/*
-	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
-	 * loop_validate_file() to succeed, for actual clear operation has not
-	 * started yet.
-	 */
-	mutex_lock(&loop_validate_mutex);
-	mutex_unlock(&loop_validate_mutex);
-	/*
-	 * loop_validate_file() now fails because l->lo_state != Lo_bound
-	 * became visible.
+	 * Make sure that Lo_rundown state becomes visible to loop_configure()
+	 * and loop_change_fd(). When called from ->release, we are guaranteed
+	 * that the "struct file" which loop_configure()/loop_change_fd() found
+	 * via fget() is not this loop device.
 	 */
+	if (!release) {
+		mutex_lock(&loop_validate_mutex);
+		mutex_unlock(&loop_validate_mutex);
+	}
 
 	/*
-	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
-	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
-	 * lo->lo_state has changed while waiting for lo->lo_mutex.
+	 * It is a sign of something going wrong if lo->lo_state has changed
+	 * while waiting for lo->lo_mutex. When called from ->release, we are
+	 * guaranteed that the nobody is using this loop device.
 	 */
-	mutex_lock(&lo->lo_mutex);
-	BUG_ON(lo->lo_state != Lo_rundown);
-	mutex_unlock(&lo->lo_mutex);
+	if (!release) {
+		mutex_lock(&lo->lo_mutex);
+		BUG_ON(lo->lo_state != Lo_rundown);
+		mutex_unlock(&lo->lo_mutex);
+	}
 
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);

But thinking again about release == false case, which I wrote "It is acceptable
for loop_validate_file() to succeed, for actual clear operation has not started
yet.", I came to feel why it is acceptable to succeed.

Even if loop_validate_file() was safely traversed due to serialization via
loop_validate_mutex, I/O requests after loop_configure()/loop_change_fd() completed
will fail. Is this behavior what we want?

If we don't want I/O requests after loop_configure()/loop_change_fd() completed
fail due to __loop_clr_fd(), it is not acceptable for loop_validate_file() to
succeed. We should hold loop_validate_mutex before setting Lo_rundown in order to
make sure that loop_validate_file() will see Lo_rundown state. That is, something
like below will be expected?

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2506193a4fd1..a4ff94ca654f 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1135,27 +1135,6 @@ static void __loop_clr_fd(struct loop_device *lo, bool release)
 	struct file *filp;
 	gfp_t gfp = lo->old_gfp_mask;
 
-	/*
-	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
-	 * loop_validate_file() to succeed, for actual clear operation has not
-	 * started yet.
-	 */
-	mutex_lock(&loop_validate_mutex);
-	mutex_unlock(&loop_validate_mutex);
-	/*
-	 * loop_validate_file() now fails because l->lo_state != Lo_bound
-	 * became visible.
-	 */
-
-	/*
-	 * Since this function is called upon "ioctl(LOOP_CLR_FD)" xor "close()
-	 * after ioctl(LOOP_CLR_FD)", it is a sign of something going wrong if
-	 * lo->lo_state has changed while waiting for lo->lo_mutex.
-	 */
-	mutex_lock(&lo->lo_mutex);
-	BUG_ON(lo->lo_state != Lo_rundown);
-	mutex_unlock(&lo->lo_mutex);
-
 	if (test_bit(QUEUE_FLAG_WC, &lo->lo_queue->queue_flags))
 		blk_queue_write_cache(lo->lo_queue, false, false);
 
@@ -1238,11 +1217,18 @@ static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
 
-	err = mutex_lock_killable(&lo->lo_mutex);
+	/*
+	 * Use global lock when setting Lo_rundown state in order to make sure
+	 * that loop_validate_file() will fail if the "struct file" which
+	 * loop_configure()/loop_change_fd() found via fget() was this loop
+	 * device. The disk_openers(lo->lo_disk) > 1 test below guarantees that
+	 * fget() did not return this loop device.
+	 */
+	err = loop_global_lock_killable(lo, true);
 	if (err)
 		return err;
 	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&lo->lo_mutex);
+		loop_global_unlock(lo, true);
 		return -ENXIO;
 	}
 	/*
@@ -1257,11 +1243,11 @@ static int loop_clr_fd(struct loop_device *lo)
 	 */
 	if (disk_openers(lo->lo_disk) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&lo->lo_mutex);
+		loop_global_unlock(lo, true);
 		return 0;
 	}
 	lo->lo_state = Lo_rundown;
-	mutex_unlock(&lo->lo_mutex);
+	loop_global_unlock(lo, true);
 
 	__loop_clr_fd(lo, false);
 	return 0;

