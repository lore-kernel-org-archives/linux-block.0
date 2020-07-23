Return-Path: <SRS0=kKib=BC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E6EC433E8
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 21:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12EE320792
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 21:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jwqLaS1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGWVRx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgGWVRw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jul 2020 17:17:52 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD1C0619D3
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2020 14:17:52 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s23so5486471qtq.12
        for <linux-block@vger.kernel.org>; Thu, 23 Jul 2020 14:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=k91cBqGNljRWHxiX5/SQuWCw8TET4IQ06VDtszBxGaI=;
        b=jwqLaS1YrC9PISW5/WxLkTTpn03gMVkFqWFzQPySNDrqVxbE9SUuLPuIx1hIQzgNlm
         h7oLNOLJo4epZbERTIPUS/lE3oIaeKTrR4Xjqs/8IQ4kyi6gklxMqUpr9Jy0u1hTCB4E
         s2Ow8l5G9rYTDHLXYKjDNbiwDcJzuJwYv7IWReQ837g7htSR7FlZEWzAkBGPH6T4VeFe
         DW9n0Fyi7kE35D555FotkfaHNN5PghbzIlmLT3r5P+PL52zONidPOnrNZuOz7uNpgOnb
         epnMEzvddUDboMQWU8ml6Mg4Sjg0B+duRQJ/b8pFRwo1a1zVRZXtdAqQlHuuWe5LO678
         o4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k91cBqGNljRWHxiX5/SQuWCw8TET4IQ06VDtszBxGaI=;
        b=HqE6qxerZK/S8vNjg+vZ24OhkEMYfiYXzFCPCMCp8e416KGrZS6vnMcFiRILhxq7wN
         syDfDHXRtx+g4qFiulwLC5W4lKC1JjPs4lf6RGNfcyu9AohA4GrQLe2u4HANjZCcC00N
         lGg4Y+ftEGLKguv4cbzTfPKhzrjfos2sXUotdZRVH3fb1bl1W8Mz9OJPYz2nVSG8P55R
         CcRHOy8l1wXei9R34o0MbyNvdcp/iVV5CG2YbkO7UIbj64DatvBzgggR/UJOJ2dR4tTE
         6ifLuzuhrSAu8EyION1Ar5Oowy6E4eom5Hb8PIVI8+ZvwRRsCAFHVQllbMr0zGMDZ4Ht
         Wd4g==
X-Gm-Message-State: AOAM533ba/Bx50Y+XgHMnRealNnTHGujUPxRzF0jSSPV4t07NHvV7ldw
        HGEBwX3/GVz92x2nJAyPlbogYg==
X-Google-Smtp-Source: ABdhPJyNWY9OaDgNz+zeO6+gt2lQHWmg/aKWYZcgDSVJTktAk35Wwfo9wXFiKvLmZkzEiAmcRI5WDA==
X-Received: by 2002:ac8:c7:: with SMTP id d7mr6330387qtg.235.1595539071361;
        Thu, 23 Jul 2020 14:17:51 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c7sm4165918qta.95.2020.07.23.14.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:17:50 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] loop: scale loop device by introducing per device lock
Date:   Thu, 23 Jul 2020 17:17:48 -0400
Message-Id: <20200723211748.13139-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723211748.13139-1-pasha.tatashin@soleen.com>
References: <20200723211748.13139-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
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
---
 drivers/block/loop.c | 99 ++++++++++++++++++++++++++------------------
 drivers/block/loop.h |  1 +
 2 files changed, 59 insertions(+), 41 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 475e1a738560..88735ab60a89 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -706,7 +706,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	int		error;
 	bool		partscan;
 
-	error = mutex_lock_killable(&loop_ctl_mutex);
+	error = mutex_lock_killable(&lo->lo_mutex);
 	if (error)
 		return error;
 	error = -ENXIO;
@@ -745,9 +745,9 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
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
@@ -757,7 +757,7 @@ static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 	return 0;
 
 out_err:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	if (file)
 		fput(file);
 	return error;
@@ -1096,7 +1096,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 		}
 	}
 
-	error = mutex_lock_killable(&loop_ctl_mutex);
+	error = mutex_lock_killable(&lo->lo_mutex);
 	if (error)
 		goto out_bdev;
 
@@ -1176,7 +1176,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	if (claimed_bdev)
@@ -1184,7 +1184,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	return 0;
 
 out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 out_bdev:
 	if (claimed_bdev)
 		bd_abort_claiming(bdev, claimed_bdev, loop_configure);
@@ -1205,7 +1205,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	bool partscan = false;
 	int lo_number;
 
-	mutex_lock(&loop_ctl_mutex);
+	mutex_lock(&lo->lo_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
 		err = -ENXIO;
 		goto out_unlock;
@@ -1259,7 +1259,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	lo_number = lo->lo_number;
 	loop_unprepare_queue(lo);
 out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	if (partscan) {
 		/*
 		 * bd_mutex has been held already in release path, so don't
@@ -1290,18 +1290,18 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
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
@@ -1312,11 +1312,11 @@ static int loop_clr_fd(struct loop_device *lo)
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
@@ -1331,11 +1331,11 @@ static int loop_clr_fd(struct loop_device *lo)
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
@@ -1350,7 +1350,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	bool partscan = false;
 	bool size_changed = false;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
+	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
 	if (lo->lo_encrypt_key_size &&
@@ -1417,7 +1417,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		partscan = true;
 	}
 out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 
@@ -1431,11 +1431,11 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
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
 
@@ -1454,10 +1454,10 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
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
@@ -1643,7 +1643,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 {
 	int err;
 
-	err = mutex_lock_killable(&loop_ctl_mutex);
+	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
 	switch (cmd) {
@@ -1659,7 +1659,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 	default:
 		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
 	}
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 	return err;
 }
 
@@ -1885,27 +1885,33 @@ static int lo_open(struct block_device *bdev, fmode_t mode)
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
 
@@ -1913,7 +1919,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 		if (lo->lo_state != Lo_bound)
 			goto out_unlock;
 		lo->lo_state = Lo_rundown;
-		mutex_unlock(&loop_ctl_mutex);
+		mutex_unlock(&lo->lo_mutex);
 		/*
 		 * In autoclear mode, stop the loop thread
 		 * and remove configuration after last close.
@@ -1930,7 +1936,7 @@ static void lo_release(struct gendisk *disk, fmode_t mode)
 	}
 
 out_unlock:
-	mutex_unlock(&loop_ctl_mutex);
+	mutex_unlock(&lo->lo_mutex);
 }
 
 static const struct block_device_operations lo_fops = {
@@ -1969,10 +1975,10 @@ static int unregister_transfer_cb(int id, void *ptr, void *data)
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
 
@@ -2157,6 +2163,7 @@ static int loop_add(struct loop_device **l, int i)
 		disk->flags |= GENHD_FL_NO_PART_SCAN;
 	disk->flags |= GENHD_FL_EXT_DEVT;
 	atomic_set(&lo->lo_refcnt, 0);
+	mutex_init(&lo->lo_mutex);
 	lo->lo_number		= i;
 	spin_lock_init(&lo->lo_lock);
 	disk->major		= LOOP_MAJOR;
@@ -2187,6 +2194,7 @@ static void loop_remove(struct loop_device *lo)
 	blk_cleanup_queue(lo->lo_queue);
 	blk_mq_free_tag_set(&lo->tag_set);
 	put_disk(lo->lo_disk);
+	mutex_destroy(&lo->lo_mutex);
 	kfree(lo);
 }
 
@@ -2238,10 +2246,13 @@ static struct kobject *loop_probe(dev_t dev, int *part, void *data)
 	err = loop_lookup(&lo, MINOR(dev) >> part_shift);
 	if (err < 0)
 		err = loop_add(&lo, MINOR(dev) >> part_shift);
-	if (err < 0)
+	if (err < 0) {
 		kobj = NULL;
-	else
+	} else {
+		mutex_lock(&lo->lo_mutex);
 		kobj = get_disk_and_module(lo->lo_disk);
+		mutex_unlock(&lo->lo_mutex);
+	}
 	mutex_unlock(&loop_ctl_mutex);
 
 	*part = 0;
@@ -2272,15 +2283,21 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
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

