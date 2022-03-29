Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26071C433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 15:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiC2Pi4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiC2Pii (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 11:38:38 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B82D1B0857
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 08:36:54 -0700 (PDT)
Received: from fsav415.sakura.ne.jp (fsav415.sakura.ne.jp [133.242.250.114])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 22TFaqnS020483;
        Wed, 30 Mar 2022 00:36:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav415.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp);
 Wed, 30 Mar 2022 00:36:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav415.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 22TFapE4020480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 30 Mar 2022 00:36:52 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <fda9e2b7-d1db-e00c-98aa-e8ff555b88eb@I-love.SAKURA.ne.jp>
Date:   Wed, 30 Mar 2022 00:36:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: [PATCH 15/14] loop: avoid loop_validate_mutex/lo_mutex in ->release
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
References: <20220325063929.1773899-1-hch@lst.de>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220325063929.1773899-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since ->release is called with disk->open_mutex held, and __loop_clr_fd()
 from lo_release() is called via ->release when disk_openers() == 0, we are
guaranteed that "struct file" which will be passed to loop_validate_file()
via fget() cannot be the loop device __loop_clr_fd(lo, true) will clear.
Thus, there is no need to hold loop_validate_mutex from __loop_clr_fd()
if release == true.

When I made commit 3ce6e1f662a91097 ("loop: reintroduce global lock for
safe loop_validate_file() traversal"), I wrote "It is acceptable for
loop_validate_file() to succeed, for actual clear operation has not started
yet.". But now I came to feel why it is acceptable to succeed.

It seems that the loop driver was added in Linux 1.3.68, and

  if (lo->lo_refcnt > 1)
    return -EBUSY;

check in loop_clr_fd() was there from the beginning. The intent of this
check was unclear. But now I think that current

  disk_openers(lo->lo_disk) > 1

form is there for three reasons.

(1) Avoid I/O errors when some process which opens and reads from this
    loop device in response to uevent notification (e.g. systemd-udevd),
    as described in commit a1ecac3b0656a682 ("loop: Make explicit loop
    device destruction lazy"). This opener is short-lived because it is
    likely that the file descriptor used by that process is closed soon.

(2) Avoid I/O errors caused by underlying layer of stacked loop devices
    (i.e. ioctl(some_loop_fd, LOOP_SET_FD, other_loop_fd)) being suddenly
    disappeared. This opener is long-lived because this reference is
    associated with not a file descriptor but lo->lo_backing_file.

(3) Avoid I/O errors caused by underlying layer of mounted loop device
    (i.e. mount(some_loop_device, some_mount_point)) being suddenly
    disappeared. This opener is long-lived because this reference is
    associated with not a file descriptor but mount.

While race in (1) might be acceptable, (2) and (3) should be checked
racelessly. That is, make sure that __loop_clr_fd() will not run if
loop_validate_file() succeeds, by doing refcount check with global lock
held when explicit loop device destruction is requested.

As a result of no longer waiting for lo->lo_mutex after setting Lo_rundown,
we can remove pointless BUG_ON(lo->lo_state != Lo_rundown) check.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 2506193a4fd1..6b813c592159 100644
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
 
@@ -1238,11 +1217,20 @@ static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
 
-	err = mutex_lock_killable(&lo->lo_mutex);
+	/*
+	 * Since lo_ioctl() is called without locks held, it is possible that
+	 * loop_configure()/loop_change_fd() and loop_clr_fd() run in parallel.
+	 *
+	 * Therefore, use global lock when setting Lo_rundown state in order to
+	 * make sure that loop_validate_file() will fail if the "struct file"
+	 * which loop_configure()/loop_change_fd() found via fget() was this
+	 * loop device.
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
@@ -1257,11 +1245,11 @@ static int loop_clr_fd(struct loop_device *lo)
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
-- 
2.32.0


