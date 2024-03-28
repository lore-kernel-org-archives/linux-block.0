Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436558485
	for <linux-block@vger.kernel.org>; Thu, 28 Mar 2024 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603913; cv=none; b=TLbdGGz+aHZgD54YnG8/4enTFR+DafAU42gTF5S2jXVJVCU4irAasVLWpiNwy2t3MCL3sujPYEo6ZtUY7XuSiwOpGyeAVq8KhRL3G0je8pxkHHrBbcU/PH6BAeU4rMUr/aa1PjByngP1cy+s3xzg4C09kpI0mSngYghvXtuF53Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603913; c=relaxed/simple;
	bh=7o14r+euxrERGVe6YmKumDE20TDZTTvZjQ1dEG359uw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxAh7H0euw7TG6wlKaEOnX0QEOroPxlKlfe85dMD4exSbFHl2RFd13nS1DX9/jPJWSnbGBTwzcUgXcfjzpylo4NBqpvQz4D8FPrf5C8C6ZvmdOVCbxoaH3t1i5mwm12bmcrKtA63YwuBGBQBO/AUCu6z52dQPgbTe1PZygmc6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4wEMArrq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4wEMArrq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=3VSld0STP2bLFNX0EbW2/k3eklfr7hfB2kdTkNmPIzc=; b=4wEMArrqkdWhPE+n+mFemEmHoe
	D/w7bqAsjjgjvs6ehNfXUVYsqvQ3VqCblYXP6Im8aCzCUjWY4BRz/eEOKfkpwtGbDIn50qBaKo/8U
	e1YhhCb/2VlvkTl0QIYO7lCMASGKuhrJbboHci5TfZXbY8q0ddB6cDm42jz5wG5pQ4Djg9gOS3VHX
	UXZBWIOKIXFzRseEQj3PskLvxGr9n4GG3lthJN15hdzx7u8y6+p1M17bNSynAr80d35ak9BXN8ztz
	Op2bz0EOOEZJQielza/CN1Nah8DZSyniuvvzFMs02PWPk80O4sKHwapg2Gzz7f0EbY/2683suBDG6
	+PmYoNQA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpiMf-0000000CZD2-37n6;
	Thu, 28 Mar 2024 05:31:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: propagate partition scanning errors to the BLKRRPART ioctl
Date: Thu, 28 Mar 2024 06:31:46 +0100
Message-Id: <20240328053146.2861986-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit 4601b4b130de ("block: reopen the device in blkdev_reread_part")
lost the propagation of I/O errors from the low-level read of the
partition table to the user space caller of the BLKRRPART.

Apparently some user space relies on, so restore the propagation.  This
isn't exactly pretty as other block device open calls explicitly do not
are about these errors, so add a new BLK_OPEN_STRICT_SCAN to opt into
the error propagation.

Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
Reported-by Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c           | 29 +++++++++++++++++++----------
 block/ioctl.c          |  3 ++-
 include/linux/blkdev.h |  2 ++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e7adaaf1c21927..51071d371863e0 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -645,6 +645,14 @@ static void blkdev_flush_mapping(struct block_device *bdev)
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
@@ -663,20 +671,21 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 
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
index 0c76137adcaaa5..128f503828cee7 100644
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
index f9b87c39cab047..272ce42f297cfe 100644
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
2.39.2

