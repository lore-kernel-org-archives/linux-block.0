Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60339C54FCC
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5B0218AC
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 08:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="DQMB+4zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgDTIEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgDTIEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 04:04:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF56C061A10
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 01:04:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so5481906wrt.1
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 01:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A01NMrXjS7VtgqWCD0bD53SNdf5elrWrIS2BaQX/HrY=;
        b=DQMB+4zcBMFzGtBiegZ5VZEaEfV9ctHofixe0ajqjYHu4uXEOGV/nh+ERiW6Gc7sNM
         Wmcq3zKq+22nFDk/NAZk9pZH0mmkbaUkVD/rKEtkUZkF+RE+7EQhGOVLEu3GtVP0ASYC
         7B13Uf3v8QuL4/VjhJM1s8tg+goPB48LWrk2tlO1VlUmt6DfF1fuOOfHxdZ4Usl6/JTy
         HVxpJkwODhr7RozBUqj46NXJ99H4p+MoBrLdv6Z3vBOVrGtO0M4ZzT2CEl87RaOIzrwT
         sinQXxa9Pk2Ks7y6CVfnnL8i6EIiWhUMNAmnTXixMphNQYX1Gd3TEUBKGbzDc0ii9KRL
         5uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A01NMrXjS7VtgqWCD0bD53SNdf5elrWrIS2BaQX/HrY=;
        b=odmaKpHxTuZNtWPS3ncngbAuHlLGtuqqznZB0yCHjiVZkOKtBHaBppKA3UMjCmHDbs
         7iDOama62/p3AzDBD4qmmQEKg8IHQjj3NkooQjfEiuhztKm8hCFM5gJqqi0QTAMZf3+r
         goS8I2t+obqk7EdKSIozNpGtTWybnaxifLv05Uq7n+i7i2DVKi7LueBjgQP4zy6a1RIV
         1KHeCa9tBiIYdWoD23+kazUiFefBIUgtnm7AhckeVHVtR+S3EbKisTZn2LqWr8Y/S7Jd
         /wJC/J1EzGe+u3/cvJD8+XVAyY+e8BUtYi9BJCEJYfSbr7cMsGyPlBhDPZFdlNCIw//J
         lRRw==
X-Gm-Message-State: AGi0PuZ2mtlvpQT21YNMsbdGW3ITaxDLYvO1V1D7aXL+UuVnvxKUd3zo
        pPf8X3HJCGljUGE+7holfsjWMA==
X-Google-Smtp-Source: APiQypI6epwI8aFZAU9m3HCB1a2zvbI20vpWZwmWLwYpp+66bEnAAuTiO+VfjHTeVtYr1AJym04T3Q==
X-Received: by 2002:a5d:5230:: with SMTP id i16mr18675235wra.71.1587369884431;
        Mon, 20 Apr 2020 01:04:44 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id a67sm335827wmc.30.2020.04.20.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:04:43 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        Martijn Coenen <maco@android.com>
Subject: [PATCH 1/4] loop: Refactor size calculation.
Date:   Mon, 20 Apr 2020 10:04:06 +0200
Message-Id: <20200420080409.111693-2-maco@android.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200420080409.111693-1-maco@android.com>
References: <20200420080409.111693-1-maco@android.com>
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
index f1754262fc94..d934d65dbe92 100644
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
+	bd_set_size(bdev, size << 9);
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
+		/* kill_bdev should have truncated all the pages */
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
2.26.1.301.g55bc3eb7cb9-goog

