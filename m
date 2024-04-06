Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C6F4FB
	for <linux-block@vger.kernel.org>; Sat,  6 Apr 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712378808; cv=none; b=YXW6U3wCLQtdGMja+7olZAvQCIncNJvhI7qGLaKsZ7f1CFd/Wc7H3/lXQ4HP5uRxGlo2YRrIrD0gXOyKVPgzp6jlshfSGpQZ2tcrNOHaRj4fHb+F6ecfYuuMUnFehD8rBA85dVPG8/3rkfMTw8SP8A1r2vlCoODunpxEBGV8ldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712378808; c=relaxed/simple;
	bh=Pa+glBIAYGUeYvj4bbkUW/0xQGcg4XhjmjmYm9pBmZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8Ak5U7yLA5PJ3VEeWMKLshaYkBDVFxW2P2LcAngnU/rmIuO7ZortBUb7UcYmyR2gTAYb1wT9e8MoDQobBP77NSrETWjZWWviS+VX3E81Ap5EKxl8TZfoNG4kGIC7ZD1nE5RSY+Av1imSYoy+EBEq/Ov4x4NB+zZO7NR4uLuBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mnf0g/2R; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mnf0g/2R"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a61b31993so46027957b3.1
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2024 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712378806; x=1712983606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIhiZai/XuhGKAO7L+OPGtFolltjq5ipvv/SRv/Vr7Q=;
        b=Mnf0g/2RLooUEyF/mevFn7IKuVAP23dGQzKJDC+4txu8zhFS7YOjqak1eA+Gm1kTj5
         Mh4u1Y+HRYVdKiCCrfmLcverMZ6khm19uYL5z5isa9j6ytEAdCAsu7wgEVcTPmSBXbjP
         ChAjNELIEC5vN0QiQ8ctePkPe1AxtL4LeSVQEnuT3Ps7noUYLeRZHB8F3jKQxGLTkNGB
         iX82Zdn1AH+8gThTIZZNKI9JpsgM7RAkwaBMJAUZiA0TRyUOVwBNYt4qWT6q8Q6G5I87
         tfry+R/4lC3MizL5DP+DkCBf/MSCF5dLD1S/g3vwhmdFHyaESA4opAbhoNGi1HARgNc2
         SfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712378806; x=1712983606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIhiZai/XuhGKAO7L+OPGtFolltjq5ipvv/SRv/Vr7Q=;
        b=aHzmEun4VM5Cz2dB1/3kKo1963aaL4vwwtAAlbQUAY60R74bv6uGSEFD0F2pSSp+NE
         PjSwy0Va7/Xo1mdkvhbvaZ+a83Jrqlik/bBLWHpejUl/TPolHRSOaAoKKQHjVmoc8Lnz
         yq57lsQ4Wk1C4eGO5vZ1oI8AEci9Rv2jg9oUtHRgsxQFGhOza7H/qzJMqMtdNk8X5mU7
         nChbSPaMre+5fKOIz2tQ8rtcbmR6V01L//pEbvR8dDhfqeSD5lNaJCo/GVWcs3FUaCjC
         t9TIiMOSTGWBXULBXUj84Ag0TrgWpGI9GMGi2hvC40EGY6DXrfxgeuutk4ZEqgQ37aCl
         goyA==
X-Forwarded-Encrypted: i=1; AJvYcCW8JMkys+0DUqm6H0iKRdgsO4Xi8gdDWcmDZd3EYPVjvJqBX0rGKv+POe1a3P1xdlPKupjrhx/2U07d9c97GgVlcK564Sh7ni4GBPU=
X-Gm-Message-State: AOJu0Yy3FRCKdwo6fnzd437fLfKKpSwz/gApP0hZvSpNBvWdyZyB+SFJ
	crvYLRRmpEU7fjrt5y+qQSYkxb02gFUGkcRjFVhuxk2VY1tnk84Bj2whi8kREYN8fLDBmdxP7nR
	UzIYBcAolo0Hd/Cx1L1cCmxQtkA==
X-Google-Smtp-Source: AGHT+IH8o09JKg5ZtCJKPS59RQeXuArqA/XwGlDrtkB/c4fbBs7RTuImDTcRIF6jeh9pgqyE8L2cGcClE7x9pZPYXz8=
X-Received: from srnym.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2728])
 (user=saranyamohan job=sendgmr) by 2002:a0d:e251:0:b0:615:134c:7ef3 with SMTP
 id l78-20020a0de251000000b00615134c7ef3mr805341ywe.9.1712378806373; Fri, 05
 Apr 2024 21:46:46 -0700 (PDT)
Date: Sat,  6 Apr 2024 04:46:43 +0000
In-Reply-To: <20240405065333.GB4023@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405065333.GB4023@lst.de>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406044643.2475360-1-saranyamohan@google.com>
Subject: [PATCH] block: Fix BLKRRPART regression
From: Saranya Muruganandam <saranyamohan@google.com>
To: hch@lst.de
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	saranyamohan@google.com, stable@vger.kernel.org, tj@kernel.org, 
	yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

The BLKRRPART ioctl used to report errors such as EIO before we changed
the blkdev_reread_part() logic.

Lets add a flag and capture the errors returned by bdev_disk_changed()
when the flag is set. Setting this flag for the BLKRRPART path when we
want the errors to be reported when rereading partitions on the disk.

Link: https://lore.kernel.org/all/20240320015134.GA14267@lst.de/
Suggested-by: Christoph Hellwig <hch@lst.de>
Tested: Tested by simulating failure to the block device and will
propose a new test to blktests.
Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
Reported-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

Change-Id: Idf3d97390ed78061556f8468d10d6cab24ae20b1
---
 block/bdev.c           | 29 +++++++++++++++++++----------
 block/ioctl.c          |  3 ++-
 include/linux/blkdev.h |  2 ++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e3..42940bced33bb 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -652,6 +652,14 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 	bdev_write_inode(bdev);
 }
 
+static void blkdev_put_whole(struct block_device *bdev)
+{
+	if (atomic_dec_and_test(&bdev->bd_openers))
+		blkdev_flush_mapping(bdev);
+	if (bdev->bd_disk->fops->release)
+		bdev->bd_disk->fops->release(bdev->bd_disk);
+}
+
 static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -670,20 +678,21 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 
 	if (!atomic_read(&bdev->bd_openers))
 		set_init_blocksize(bdev);
-	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
-		bdev_disk_changed(disk, false);
 	atomic_inc(&bdev->bd_openers);
+	if (test_bit(GD_NEED_PART_SCAN, &disk->state)) {
+		/*
+		 * Only return scanning errors if we are called from conexts
+		 * that explicitly want them, e.g. the BLKRRPART ioctl.
+		 */
+		ret = bdev_disk_changed(disk, false);
+		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
+			blkdev_put_whole(bdev);
+			return ret;
+		}
+	}
 	return 0;
 }
 
-static void blkdev_put_whole(struct block_device *bdev)
-{
-	if (atomic_dec_and_test(&bdev->bd_openers))
-		blkdev_flush_mapping(bdev);
-	if (bdev->bd_disk->fops->release)
-		bdev->bd_disk->fops->release(bdev->bd_disk);
-}
-
 static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
 {
 	struct gendisk *disk = part->bd_disk;
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaaa..128f503828cee 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -562,7 +562,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 			return -EACCES;
 		if (bdev_is_partition(bdev))
 			return -EINVAL;
-		return disk_scan_partitions(bdev->bd_disk, mode);
+		return disk_scan_partitions(bdev->bd_disk,
+				mode | BLK_OPEN_STRICT_SCAN);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be9..3ed5e03109c29 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -128,6 +128,8 @@ typedef unsigned int __bitwise blk_mode_t;
 #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
 /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
 #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
+/* return partition scanning errors */
+#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 5))
 
 struct gendisk {
 	/*
-- 
2.44.0.478.gd926399ef9-goog

