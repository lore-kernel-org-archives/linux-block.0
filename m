Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33183132C36
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073670; cv=none; b=DJl8TQnS+k76UAEeStrOhvWuTShVmKeGhshut2mOQA24eS3gZyJFBmJGdlf+nU+FtAP+RZ8q2dy2Q5IswiCiDCAspqJUMuf3+dk7aSEgMCCG353G7RYrjwHbOB9IJz+9RgO6EKW53DGnGY2TU/KJL06bnBb7hwyONVKpQxnLlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073670; c=relaxed/simple;
	bh=nWMBSTgh2ekEaoSFt8fcZQR8TSnDdpHT0pIXnFJ6v/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lAtyQH9qpYZVrWCj5qCFYdN/pw9fu4TXdxjODAaWodr78AcLzNXmzVAC9hIRzbSD7XiNtiRacu3letX+/R3C7Z6c/zApYtuT70L6l9Y4QFL/FLStfmBL9ACEZNLV1/4ehMqlMPWPcVtkSmv+TDG58y7NlD1q/W6tgy4DK5BeMAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q/yqz1R+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q/yqz1R+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=SGbhclRD0DAk+v5My0P7qkez5A8z/UBvrsfC/BinQ2I=; b=Q/yqz1R+K8GtA2Eugsfm7bFGc5
	Y4vGTB5Hb17yzSiiM+clPea4QH/cuOyXY7RkC/GwThTB6thGwOt4BLDeFl1gCf/ovyank64hq5K//
	a1uZnvPZjHV9k/pAIikZKIBwyF7zd5VERIJRxUp2b78y/9VaSAl4iLMLFSzVRRLLLqizo/y/BOFjJ
	gVv2RRXI6Xv+AJ8h6hhCSMf4jNqxUAjYc+Hg5rhuUlrbTR1lNDJpRC9KjgfAkMKlFi+pkS0FRBrXn
	INqP+f4G12qOdAg6zqpvqifNhiVNdqWNmhqk0cYaKDlXCspqyyXqBwhLNrAvPsLuzY6gPiVA2KNPG
	mDiF8spg==;
Received: from [2001:4bb8:199:60a5:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgZN-0000000BwJN-3WCT;
	Tue, 02 Apr 2024 16:01:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	Saranya Muruganandam <saranyamohan@google.com>
Subject: [PATCH] block: propagate partition scanning errors to the BLKRRPART ioctl
Date: Tue,  2 Apr 2024 18:01:03 +0200
Message-Id: <20240402160103.758141-1-hch@lst.de>
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
Reported-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c           | 29 +++++++++++++++++++----------
 block/ioctl.c          |  3 ++-
 include/linux/blkdev.h |  2 ++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e3e..42940bced33bb4 100644
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
index 79ed07bd652ac4..0b39df4864ef19 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -129,6 +129,8 @@ typedef unsigned int __bitwise blk_mode_t;
 #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
 /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
 #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
+/* return partition scanning errors */
+#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 5))
 
 struct gendisk {
 	/*
-- 
2.39.2

