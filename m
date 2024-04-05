Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52279E4
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 01:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712281405; cv=none; b=d042UmIZ56f05jttZyDw8L5PVWIajA6muymcpD15vSn7QhY7VG7thuzj85aVD9AfwPKhq3b/WHqIsxfuG/JuHwtTy2G4PNwo6WnA8fC2yZkSK34B7t+0eyyUg4JEl1hPVGFf0VXNStyhaOa4TmaqgIvR5dGpiewAUklolo0nPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712281405; c=relaxed/simple;
	bh=URaZQzuDjC1y+JWc4rSLFFtEsZXFxrIaWQtmHQtpG64=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M1N1cazpsSn2ETyj5u57PImlA4Y1uvDJKRRLUZ91/Utsmla7eLsjQjuXs6eG5L6RCkW3AxgsL3H+b9gtAVIK4291r7vVkyfnQc6aNDMRLFKfjVhUAc6l3TRgHXNKvfcmyQ5IWRYPenCddrc+TmhtMV0TI3o91SXtyurbRzdpmzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXxi5cPS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXxi5cPS"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cbba6f571so27238087b3.1
        for <linux-block@vger.kernel.org>; Thu, 04 Apr 2024 18:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712281402; x=1712886202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3yhnAORJgGG1KHraVLDZCGL3HZq2R87i+RUHP6rWUSg=;
        b=CXxi5cPS8ba34z1a5yDAQ9tPNaoj4imfe+/kMhEUraNVjGrGp2C4Gf0GEW3qGCPNih
         UhWLCWubya1a9UmRS+ry0nv1EG2mQbRQfCLWpJ7mGJ2BeJW9mrMhcGh78lwWuNEn03rV
         JTvEJ7D9iOvhEnPRFQAybSd9W/t4LrToV+IBlF2DkQ93YB+r1Guogbg+4HHQs/ax1viV
         2E/J9ywURbrYXkkHw00Q6/FGXmETxABDwHwW/dZcO/qS3ZPrwoe2ZfLlycnkF+ctRPrj
         12cgs1bBqQPGaWNWIpsV04RdjszQWYkNXbAhiKJr/OtdyRhLdaHjbYkrZOmmdVSfjsGw
         E6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712281402; x=1712886202;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yhnAORJgGG1KHraVLDZCGL3HZq2R87i+RUHP6rWUSg=;
        b=Jvu49gASKpvGlboN9PwfmamW8FZ5FwdXVQ7r7fWBhRTsl3IBXLP3rBkyOuODBlxM+O
         SuF8QbI7JkV6zDJFCOfGT7ItttYDU4awx22+IdRvbMzariqKK0nc7x6mvqZBL6Ok9FGG
         cO9IdiC2kTdp+u2RS1EnDb3Qz0XSZ52ja7o+gSxN3NQPZidkfj/G0ai+rl7T2XlYV6bT
         R11Mw4RCJ80uKxYNnVXp0Y9/YsxH2gQnb7+EPECFXW5K/vD9Am1W9QutXkFJqtqJ07gf
         b93CnDyvH08SS3/el64KSZTKuJVd0yJKEgpwipt6gHiSK8BT5oso70pGaDimsRzK61Gc
         5iIA==
X-Gm-Message-State: AOJu0Yz8ypYzAuTRB65O5EuKZEKm+rrcS2FO2yKyyt9q8/eFrY5LDAQ4
	tM3H1h2WPs8WCQKUODJuaL1Ivu9pc5o1Oi76g+FsBgnNtKC7Xrft1XFRcHNaAXPS5iTZ6y4KYSD
	jCKTpB76QCXkJzgocSmaTvEtvRA==
X-Google-Smtp-Source: AGHT+IGuSeucnURFqdpRNkhu5A9mlb9yFfsSaydOKK0WTKBYMa+IRt1tjptLuEyfYnMvrp0t3LRZ5aWiDWX8iAqK5/Q=
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2a3:200:b12b:59df:64f6:cb16])
 (user=saranyamohan job=sendgmr) by 2002:a05:6902:154d:b0:dda:eee6:8e52 with
 SMTP id r13-20020a056902154d00b00ddaeee68e52mr352605ybu.7.1712281402308; Thu,
 04 Apr 2024 18:43:22 -0700 (PDT)
Date: Thu,  4 Apr 2024 18:42:53 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405014253.748627-1-saranyamohan@google.com>
Subject: [PATCH] block: Fix BLKRRPART regression
From: Saranya Muruganandam <saranyamohan@google.com>
To: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai1@huaweicloud.com>, 
	Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Saranya Muruganandam <saranyamohan@google.com>
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
 block/bdev.c           | 31 +++++++++++++++++++++----------
 block/ioctl.c          |  3 ++-
 include/linux/blkdev.h |  3 +++
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 77fa77cd29bee..71478f8865546 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -632,6 +632,14 @@ static void blkdev_flush_mapping(struct block_device *bdev)
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
@@ -650,18 +658,21 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 
 	if (!atomic_read(&bdev->bd_openers))
 		set_init_blocksize(bdev);
-	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
-		bdev_disk_changed(disk, false);
 	atomic_inc(&bdev->bd_openers);
-	return 0;
-}
 
-static void blkdev_put_whole(struct block_device *bdev)
-{
-	if (atomic_dec_and_test(&bdev->bd_openers))
-		blkdev_flush_mapping(bdev);
-	if (bdev->bd_disk->fops->release)
-		bdev->bd_disk->fops->release(bdev->bd_disk);
+	if (test_bit(GD_NEED_PART_SCAN, &disk->state)) {
+		/*
+		 * Only return scanning errors if we are called from contexts
+		 * that explicitly want them, e.g. the BLKRRPART ioctl.
+		 */
+		ret = bdev_disk_changed(disk, false);
+		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
+			blkdev_put_whole(bdev);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
diff --git a/block/ioctl.c b/block/ioctl.c
index aa46f3761c3ed..e8d72d9f327fd 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -557,7 +557,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
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
index 01983eece8f2a..d0104dc839b0d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -151,6 +151,9 @@ struct access_rules_head {
 	int max_rules;
 };
 
+/* return partition scanning errors */
+#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 5))
+
 struct gendisk {
 	/*
 	 * major/first_minor/minors should not be set by any new driver, the
-- 
2.44.0.478.gd926399ef9-goog

