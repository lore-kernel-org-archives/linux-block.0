Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4499C55185
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8485020775
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 10:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="wCRZog2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDVK4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728395AbgDVKGp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 06:06:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4090C03C1AA
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 03:06:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v8so4530225wma.0
        for <linux-block@vger.kernel.org>; Wed, 22 Apr 2020 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+0K7OIOKk8O51V5gNKinM3m15DeYTfEO7xsT25+AwY=;
        b=wCRZog2ujjq1VXrOoJzN2gxTVlzcdBgWGd3wj0+N+SFLxJ29cyO0YFt8VNRf5wO0nC
         ZQH2Gk7Q6cCNuGc9QTjkHwJXO7Hk0nDWCVOV2WP89hucJ9DSV9wdbxEmsJiuhuwKiA/s
         7H2WPVbbwStLDHuxz8DSHCTRR15JUYRbay/2Xi9u+M1WKFPgbIHR+H+/Rn5sipM8/n3r
         u081iY2UAJC+76ZowLZMM8tQ8/Zy+sV6bJo633hYjILCUIZMZsvqbaIGfIQtJIsDY7qc
         w/kBe8QD68/OjBVnQVvwFyiN+QnrBHR+Z1qmFdKM9OBOk+zo/NKKauVi8+IpLAZLU1yH
         sz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+0K7OIOKk8O51V5gNKinM3m15DeYTfEO7xsT25+AwY=;
        b=Q+NYcpEkyBe7fvBVbbMNNd4lesmi8ghVSR3DzNGEjh5E2aimN68orf+ixRx656CxNb
         gdwUUPyQhgq3w9PVaLef7MwZJ/JJ0p5q7WZWnShQzXF0cZLxMa3HDWpSfFjVIWzprpEv
         AMjvuBYU2uslpQ+MvRvscZWFuIEeaJgb8UQ169+qz43fs/uLM8m/vQubkz5y1MxxT3Vk
         Mo+zcMBLpwWsKaLejBSTu7ht7YAoFxG1yN+h35Hy9/Nw1G1cjnLAurrdhrTTbvmtqLB2
         K6jwuLfScz+6R6t79vjN5n8bsZaLbzIyqIooPq6wk1DNL+jH/+gLkxL5RHiGomYIIOfm
         sHZQ==
X-Gm-Message-State: AGi0Puae88Tdbf3egm4fOKKCGEbSXURkA3ArBxSE/6qHsO5hpkaCU/a0
        HUkrLZ8YjydQ56d1AsBNEmSCmw==
X-Google-Smtp-Source: APiQypIVrmoFnc4FjHc9aa3ZqH3XWubRL1wmduJTj/TKB0/OBgK9x8LJKNo/LKalhzxAomx4WTNxew==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr9466600wmi.173.1587550003569;
        Wed, 22 Apr 2020 03:06:43 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id j13sm7812462wrq.24.2020.04.22.03.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:06:42 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v2 1/5] loop: Refactor size calculation
Date:   Wed, 22 Apr 2020 12:06:32 +0200
Message-Id: <20200422100636.46357-2-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200422100636.46357-1-maco@android.com>
References: <20200422100636.46357-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

figure_loop_size() calculates the loop size based on the passed in
parameters, but at the same time it updates the offset and sizelimit
parameters in the loop device configuration. That is a somewhat
unexpected side effect of a function with this name, and it is only only
needed by one of the two callers of this function - loop_set_status().

Move the lo_offset and lo_sizelimit assignment back into loop_set_status(),
and factor out a new function (loop_set_size()) to apply a newly
calculated size that has been validated to fit in sector_t, and notify
user-space.

loop_update_size() is now solely used by loop_set_capacity to compute an
updated size, and loop_set_status() uses a combination of functions to
validate the loop size, and only apply it later.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 88 ++++++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f1754262fc94..4f5c765c73d8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -228,23 +228,42 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
+/**
+ * loop_set_size - sets device size and notifies userspace
+ * @lo: struct loop_device to set the size for
+ * @size: new size of the loop device
+ *
+ * Callers must validate that the size passed into this function fits into
+ * a sector_t.
+ */
+static void loop_set_size(struct loop_device *lo, loff_t size)
+{
+	struct block_device *bdev = lo->lo_device;
+
+	set_capacity(lo->lo_disk, size);
+	bd_set_size(bdev, size << SECTOR_SHIFT);
+	/* let user-space know about the new size */
+	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+}
+
+/**
+ * loop_update_size - updates device size from the backing file
+ * @lo: struct loop_device to update the size for
+ *
+ * Recomputes the device size from the backing file, and updates the device
+ * with the new size.
+ */
 static int
-figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
+loop_update_size(struct loop_device *lo)
 {
-	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
+	loff_t size = get_loop_size(lo, lo->lo_backing_file);
 	sector_t x = (sector_t)size;
-	struct block_device *bdev = lo->lo_device;
 
 	if (unlikely((loff_t)x != size))
 		return -EFBIG;
-	if (lo->lo_offset != offset)
-		lo->lo_offset = offset;
-	if (lo->lo_sizelimit != sizelimit)
-		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, x);
-	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+
+	loop_set_size(lo, size);
+
 	return 0;
 }
 
@@ -1040,11 +1059,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 
 	loop_update_rotational(lo);
 	loop_update_dio(lo);
-	set_capacity(lo->lo_disk, size);
-	bd_set_size(bdev, size << 9);
 	loop_sysfs_init(lo);
-	/* let user-space know about the new size */
-	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
+	loop_set_size(lo, size);
 
 	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
 		      block_size(inode->i_bdev) : PAGE_SIZE);
@@ -1267,6 +1283,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	kuid_t uid = current_uid();
 	struct block_device *bdev;
 	bool partscan = false;
+	bool size_changed = false;
+	loff_t validated_size;
 
 	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
@@ -1288,6 +1306,14 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
+		size_t size = get_size(info->lo_offset, info->lo_sizelimit,
+				       lo->lo_backing_file);
+		if ((loff_t)(sector_t)size != size) {
+			err = -EFBIG;
+			goto out_unlock;
+		}
+		size_changed = true;
+		validated_size = size;
 		sync_blockdev(lo->lo_device);
 		kill_bdev(lo->lo_device);
 	}
@@ -1295,6 +1321,15 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
+	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
+		/* If any pages were dirtied after kill_bdev(), try again */
+		err = -EAGAIN;
+		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+			__func__, lo->lo_number, lo->lo_file_name,
+			lo->lo_device->bd_inode->i_mapping->nrpages);
+		goto out_unfreeze;
+	}
+
 	err = loop_release_xfer(lo);
 	if (err)
 		goto out_unfreeze;
@@ -1318,22 +1353,8 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (err)
 		goto out_unfreeze;
 
-	if (lo->lo_offset != info->lo_offset ||
-	    lo->lo_sizelimit != info->lo_sizelimit) {
-		/* kill_bdev should have truncated all the pages */
-		if (lo->lo_device->bd_inode->i_mapping->nrpages) {
-			err = -EAGAIN;
-			pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
-				__func__, lo->lo_number, lo->lo_file_name,
-				lo->lo_device->bd_inode->i_mapping->nrpages);
-			goto out_unfreeze;
-		}
-		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
-			err = -EFBIG;
-			goto out_unfreeze;
-		}
-	}
-
+	lo->lo_offset = info->lo_offset;
+	lo->lo_sizelimit = info->lo_sizelimit;
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
 	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
@@ -1357,6 +1378,9 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 		lo->lo_key_owner = uid;
 	}
 
+	if (size_changed)
+		loop_set_size(lo, validated_size);
+
 	loop_config_discard(lo);
 
 	/* update dio if lo_offset or transfer is changed */
@@ -1534,7 +1558,7 @@ static int loop_set_capacity(struct loop_device *lo)
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+	return loop_update_size(lo);
 }
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
-- 
2.26.2.303.gf8c07b1a785-goog

