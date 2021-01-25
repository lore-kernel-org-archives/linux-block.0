Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C60C433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 20:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6D722583
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 20:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbhAYUNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 15:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731984AbhAYUMl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 15:12:41 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39F1C0613D6
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 12:12:00 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id t63so1146463qkc.1
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 12:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PLbgmCMm0FhltnfMcJbi+FzUyet2cUHru1+w8v2w4Ik=;
        b=NAUAPBL5of1NvglP8xUf1Zp35YN/GRq5q8j0WajH8T5q1I/AJDN/mTkn9BGLpVyold
         XqqthaJtlaWFRJj/P0nMtjNA0cOVzzVloM5N4CfeMEG9m6a3oeQ8Qq9vcsjWlPWBQfsC
         Gy6y37QKGgcrcpR/OqHUgz90rMqQ5mfxfQu17SHRj+GMCOtrvsFukb6WS9t/RQkyKxl2
         WmcAv8Lc2O9ADJkWZepFe/WThHfO1LmhQgi0ddL6EVLEjVEKgt9OLcNUAuQYtSF8qLlz
         fufz0Srn0KWRjyso2sFtCqSgv+61JfKXQ/BHv3p31S7Q5aLBN3pSRP7X+SngHt8QLUKB
         D2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLbgmCMm0FhltnfMcJbi+FzUyet2cUHru1+w8v2w4Ik=;
        b=pL4xXjyvp3O7ukngSDfTQ802QP8lxS58ghTn5Y4ZskvD53u1LmqojE77k0JTuU1U04
         Ui6gwKZbVvdIyT7k+BfZVZUBafgt884aHb/Y1Q9WYHZnFn+pZRAlCRc3u/CS4HvaAzFi
         jXoTCgek4BEl86yfYrNbPLPjrxZGMt1V3fdezK0dnMrwssZ5yqWHjWdnLjc/8ZIrEVKN
         JMpcD7ZeFAIN8QRxEQaCHQx9YAqGE4W+ZeOMFt6XuCNhoJLWYl66XHIxgKYXmOXSzRkt
         +qvPNqrxHjfNLMRU61dBcKpv9k/0kxee70RpT3XaS2jtcEX/17bGTF40m09A4Rxb1LDI
         zNoQ==
X-Gm-Message-State: AOAM533F/tEFsxUE+cRGEZolz9PyOvupRABjBzyBC6wHYx4hmQxwxM4P
        P0fBUvnZ6KR9guQKkIlXgs684w==
X-Google-Smtp-Source: ABdhPJxFP3+McMlCyT8jtzI9OCw2G4gf6mtiYQu0lO99Ajs26VVRLs3LmXARtSoLSMobpCRlBwJ8Gg==
X-Received: by 2002:a37:5d5:: with SMTP id 204mr2474305qkf.436.1611605520153;
        Mon, 25 Jan 2021 12:12:00 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id 2sm11918564qtt.24.2021.01.25.12.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 12:11:59 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org, jmorris@namei.org,
        lukas.bulwahn@gmail.com, hch@lst.de, pvorel@suse.cz,
        ming.lei@redhat.com, mzxreary@0pointer.de, mcgrof@kernel.org,
        zhengbin13@huawei.com, maco@android.com, colin.king@canonical.com,
        evgreen@chromium.org
Subject: [PATCH v3 1/1] loop: scale loop device by introducing per device lock
Date:   Mon, 25 Jan 2021 15:11:56 -0500
Message-Id: <20210125201156.1330164-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
References: <20210125201156.1330164-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, loop device has only one global lock:
loop_ctl_mutex.

This becomes hot in scenarios where many loop devices are used.

Scale it by introducing per-device lock: lo_mutex that protects the
fields in struct loop_device. Keep loop_ctl_mutex to protect global
data such as loop_index_idr, loop_lookup, loop_add.

Lock ordering: loop_ctl_mutex > lo_mutex.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/block/loop.c | 92 +++++++++++++++++++++++++-------------------
 drivers/block/loop.h |  1 +
 2 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e5ff328f0917..e520aaf94f93 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -704,7 +704,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	int		error;
 	bool		partscan;
 
-	error = mutex_lock_killable(&loop_ctl_mutex);
+	error = mutex_lock_killable(&lo->lo_mutex);
 	if (error)
 		return error;
 	error = -ENXIO;
@@ -743,9 +743,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	/*
-	 * We must drop file reference outside of loop_ctl_mutex as dropping
+	 * We must drop file reference outside of lo_mutex as dropping
 	 * the file ref can take bd_mutex which creates circular locking
 	 * dependency.
 	 */
@@ -755,7 +755,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	return 0;
 
 out_err:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	if (file)
 		fput(file);
 	return error;
@@ -1092,7 +1092,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 			goto out_putf;
 	}
 
-	error = mutex_lock_killable(&loop_ctl_mutex);
+	error = mutex_lock_killable(&lo->lo_mutex);
 	if (error)
 		goto out_bdev;
 
@@ -1171,7 +1171,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	if (!(mode & FMODE_EXCL))
@@ -1179,7 +1179,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return 0;
 
 out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 out_bdev:
 	if (!(mode & FMODE_EXCL))
 		bd_abort_claiming(bdev, loop_configure);
@@ -1200,7 +1200,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	bool partscan = false;
 	int lo_number;
 
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&lo->lo_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
 		err = -ENXIO;
 		goto out_unlock;
@@ -1253,7 +1253,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	lo_number = lo->lo_number;
 	loop_unprepare_queue(lo);
 out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	if (partscan) {
 		/*
 		 * bd_mutex has been held already in release path, so don't
@@ -1284,18 +1284,18 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	 * protects us from all the other places trying to change the 'lo'
 	 * device.
 	 */
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&lo->lo_mutex);
 	lo->lo_flags = 0;
 	if (!part_shift)
 		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	lo->lo_state = Lo_unbound;
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 
 	/*
-	 * Need not hold loop_ctl_mutex to fput backing file.
-	 * Calling fput holding loop_ctl_mutex triggers a circular
+	 * Need not hold lo_mutex to fput backing file.
+	 * Calling fput holding lo_mutex triggers a circular
 	 * lock dependency possibility warning as fput can take
-	 * bd_mutex which is usually taken before loop_ctl_mutex.
+	 * bd_mutex which is usually taken before lo_mutex.
 	 */
 	if (filp)
 		fput(filp);
@@ -1306,11 +1306,11 @@ static int loop_clr_fd(struct loop_device *lo)
 {
 	int err;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
+	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
 	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&loop_ctl_mutex);
+		mutex_unlock(&lo->lo_mutex);
 		return -ENXIO;
 	}
 	/*
@@ -1325,11 +1325,11 @@ static int loop_clr_fd(struct loop_device *lo)
 	 */
 	if (atomic_read(&lo->lo_refcnt) > 1) {
 		lo->lo_flags |= LO_FLAGS_AUTOCLEAR;
-		mutex_unlock(&loop_ctl_mutex);
+		mutex_unlock(&lo->lo_mutex);
 		return 0;
 	}
 	lo->lo_state = Lo_rundown;
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 
 	return __loop_clr_fd(lo, false);
 }
@@ -1344,7 +1344,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	bool partscan = false;
 	bool size_changed = false;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
+	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
 	if (lo->lo_encrypt_key_size &&
@@ -1411,7 +1411,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		partscan = true;
 	}
 out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 
@@ -1425,11 +1425,11 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	struct kstat stat;
 	int ret;
 
-	ret = mutex_lock_killable(&loop_ctl_mutex);
+	ret = mutex_lock_killable(&lo->lo_mutex);
 	if (ret)
 		return ret;
 	if (lo->lo_state != Lo_bound) {
-		mutex_unlock(&loop_ctl_mutex);
+		mutex_unlock(&lo->lo_mutex);
 		return -ENXIO;
 	}
 
@@ -1448,10 +1448,10 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 		       lo->lo_encrypt_key_size);
 	}
 
-	/* Drop loop_ctl_mutex while we call into the filesystem. */
+	/* Drop lo_mutex while we call into the filesystem. */
 	path = lo->lo_backing_file->f_path;
 	path_get(&path);
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
 	if (!ret) {
 		info->lo_device = huge_encode_dev(stat.dev);
@@ -1637,7 +1637,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 {
 	int err;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
+	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
 	switch (cmd) {
@@ -1653,7 +1653,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	return err;
 }
 
@@ -1879,27 +1879,33 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
 	struct loop_device *lo;
 	int err;
 
+	/*
+	 * take loop_ctl_mutex to protect lo pointer from race with
+	 * loop_control_ioctl(LOOP_CTL_REMOVE), however, to reduce
+	 * contention release it prior to updating lo->lo_refcnt.
+	 */
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	lo = bdev->bd_disk->private_data;
 	if (!lo) {
-		err = -ENXIO;
-		goto out;
+		mutex_unlock(&loop_ctl_mutex);
+		return -ENXIO;
 	}
-
-	atomic_inc(&lo->lo_refcnt);
-out:
+	err = mutex_lock_killable(&lo->lo_mutex);
 	mutex_unlock(&loop_ctl_mutex);
-	return err;
+	if (err)
+		return err;
+	atomic_inc(&lo->lo_refcnt);
+	mutex_unlock(&lo->lo_mutex);
+	return 0;
 }
 
 static void lo_release(struct gendisk *disk, fmode_t mode)
 {
-	struct loop_device *lo;
+	struct loop_device *lo = disk->private_data;
 
-	mutex_lock(&loop_ctl_mutex);
-	lo = disk->private_data;
+	mutex_lock(&lo->lo_mutex);
 	if (atomic_dec_return(&lo->lo_refcnt))
 		goto out_unlock;
 
@@ -1907,7 +1913,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
 		lo->lo_state = Lo_rundown;
-		mutex_unlock(&loop_ctl_mutex);
+		mutex_unlock(&lo->lo_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
@@ -1924,7 +1930,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	}
 
 out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 }
 
 static const struct block_device_operations lo_fops = {
@@ -1963,10 +1969,10 @@ static int unregister_transfer_cb(int id, void *ptr, void *data)
 	struct loop_device *lo = ptr;
 	struct loop_func_table *xfer = data;
 
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&lo->lo_mutex);
 	if (lo->lo_encryption == xfer)
 		loop_release_xfer(lo);
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	return 0;
 }
 
@@ -2152,6 +2158,7 @@ static int loop_add(struct loop_device **l, int i)
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	disk->flags |= GENHD_FL_EXT_DEVT;
 	atomic_set(&lo->lo_refcnt, 0);
+	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
 	disk->major		= LOOP_MAJOR;
@@ -2182,6 +2189,7 @@ static void loop_remove(struct loop_device *lo)
 	blk_cleanup_queue(lo->lo_queue);
 	blk_mq_free_tag_set(&lo->tag_set);
 	put_disk(lo->lo_disk);
+	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
 
@@ -2261,15 +2269,21 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 		ret = loop_lookup(&lo, parm);
 		if (ret < 0)
 			break;
+		ret = mutex_lock_killable(&lo->lo_mutex);
+		if (ret)
+			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
+			mutex_unlock(&lo->lo_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
+			mutex_unlock(&lo->lo_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;
+		mutex_unlock(&lo->lo_mutex);
 		idr_remove(&loop_index_idr, lo->lo_number);
 		loop_remove(lo);
 		break;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index af75a5ee4094..a3c04f310672 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -62,6 +62,7 @@ struct loop_device {
 	struct request_queue	*lo_queue;
 	struct blk_mq_tag_set	tag_set;
 	struct gendisk		*lo_disk;
+	struct mutex		lo_mutex;
 };
 
 struct loop_cmd {
-- 
2.25.1

