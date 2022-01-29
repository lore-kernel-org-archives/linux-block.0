Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3553C433FE
	for <linux-block@archiver.kernel.org>; Sat, 29 Jan 2022 07:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243344AbiA2HQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Jan 2022 02:16:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56784 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349265AbiA2HQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jan 2022 02:16:03 -0500
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 20T7FXMD082117;
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Sat, 29 Jan 2022 16:15:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 20T7FSNr082068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 29 Jan 2022 16:15:33 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 6/7] loop: don't hold lo->lo_mutex from lo_open()/lo_release()
Date:   Sat, 29 Jan 2022 16:14:59 +0900
Message-Id: <20220129071500.3566-7-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20220129071500.3566-1-penguin-kernel@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since holding lo->lo_mutex from lo_open()/lo_release() can indirectly
wait for I/O requests via e.g. ioctl(LOOP_SET_STATUS64), we need to avoid
holding lo->lo_mutex from lo_open()/lo_release() paths.

Replace lo->lo_state == Lo_deleting with lo->lo_refcnt == -1, making it
possible for lo_open() to run without holding lo->lo_mutex.

Since nobody except loop_control_remove() will access lo->lo_state and
lo->lo_refcnt when lo->lo_refcnt became 0 in lo_release(), we can avoid
holding lo->lo_mutex from lo_release().

Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/block/loop.c | 76 ++++++++++++++------------------------------
 drivers/block/loop.h |  1 -
 2 files changed, 23 insertions(+), 54 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 481d2371864a..b45198f2d76b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1706,41 +1706,25 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 static int lo_open(struct block_device *bdev, fmode_t mode)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
-	int err;
 
-	err = mutex_lock_killable(&lo->lo_mutex);
-	if (err)
-		return err;
-	if (lo->lo_state == Lo_deleting)
-		err = -ENXIO;
-	else
-		atomic_inc(&lo->lo_refcnt);
-	mutex_unlock(&lo->lo_mutex);
-	return err;
+	return atomic_inc_unless_negative(&lo->lo_refcnt) ? 0 : -ENXIO;
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
 {
 	struct loop_device *lo = disk->private_data;
 
-	mutex_lock(&lo->lo_mutex);
-	if (atomic_dec_return(&lo->lo_refcnt))
-		goto out_unlock;
-
-	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
-		if (lo->lo_state != Lo_bound)
-			goto out_unlock;
-		lo->lo_state = Lo_rundown;
-		mutex_unlock(&lo->lo_mutex);
-		__loop_clr_fd(lo, true);
-		mutex_lock(&lo->lo_mutex);
-		lo->lo_state = Lo_unbound;
-		mutex_unlock(&lo->lo_mutex);
+	/*
+	 * Since lo_open() and lo_release() are serialized by disk->open_mutex,
+	 * and lo->refcnt == 0 means nobody is using this device, we can access
+	 * lo->lo_state and lo->lo_flags without holding lo->lo_mutex.
+	 */
+	if (atomic_dec_return(&lo->lo_refcnt) ||
+	    lo->lo_state != Lo_bound || !(lo->lo_flags & LO_FLAGS_AUTOCLEAR))
 		return;
-	}
-
-out_unlock:
-	mutex_unlock(&lo->lo_mutex);
+	lo->lo_state = Lo_rundown;
+	__loop_clr_fd(lo, true);
+	lo->lo_state = Lo_unbound;
 }
 
 static const struct block_device_operations lo_fops = {
@@ -2077,42 +2061,28 @@ static int loop_control_remove(int idx)
 		pr_warn_once("deleting an unspecified loop device is not supported.\n");
 		return -EINVAL;
 	}
-		
-	/* Hide this loop device for serialization. */
+
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
 	lo = idr_find(&loop_index_idr, idx);
+	/* Fail if loop_add() or loop_remove() are in progress. */
 	if (!lo || !lo->idr_visible)
 		ret = -ENODEV;
-	else
+	/* Fail if somebody is using this loop device. */
+	else if (data_race(lo->lo_state) != Lo_unbound ||
+		 atomic_read(&lo->lo_refcnt) > 0)
+		ret = -EBUSY;
+	/* Fail if somebody started using this loop device. */
+	else if (atomic_dec_return(&lo->lo_refcnt) == -1)
 		lo->idr_visible = false;
-	mutex_unlock(&loop_ctl_mutex);
-	if (ret)
-		return ret;
-
-	/* Check whether this loop device can be removed. */
-	ret = mutex_lock_killable(&lo->lo_mutex);
-	if (ret)
-		goto mark_visible;
-	if (lo->lo_state != Lo_unbound ||
-	    atomic_read(&lo->lo_refcnt) > 0) {
-		mutex_unlock(&lo->lo_mutex);
+	else {
+		atomic_inc(&lo->lo_refcnt);
 		ret = -EBUSY;
-		goto mark_visible;
 	}
-	/* Mark this loop device no longer open()-able. */
-	lo->lo_state = Lo_deleting;
-	mutex_unlock(&lo->lo_mutex);
-
-	loop_remove(lo);
-	return 0;
-
-mark_visible:
-	/* Show this loop device again. */
-	mutex_lock(&loop_ctl_mutex);
-	lo->idr_visible = true;
 	mutex_unlock(&loop_ctl_mutex);
+	if (!ret)
+		loop_remove(lo);
 	return ret;
 }
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 082d4b6bfc6a..49bfa223072b 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -21,7 +21,6 @@ enum {
 	Lo_unbound,
 	Lo_bound,
 	Lo_rundown,
-	Lo_deleting,
 };
 
 struct loop_func_table;
-- 
2.32.0

