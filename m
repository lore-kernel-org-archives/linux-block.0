Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF207F7F0
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365271; cv=none; b=o2y61MR2jqH0Zy08s+ly6F8wjSXEcaoFUk+Kau3JThUpd61iGkZ8htUDZYZS+YbiTDUrBEszyTsYtdSooTsb3hvYDiJUMuSCXftNrWGENVZtD6Xo+cDWo/B/+RLybYsViAfBdxaf6NVLD6SGwXRt3Zx72G/H9HPyhmBp4rXQ0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365271; c=relaxed/simple;
	bh=oNB32pbdzxCd938iKeTdUZGb14a0GVHnD4KeCfi7f1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P7EgD5m+LoDkyk44HePFCKWKutn2RhfUFPjNb84FuCyHUocx6t0+0CsodJTe9/Dtn7LmxXE6JwE6ZSPuj3wb0701E74nKFC8xDT+9UNcNm2857NQpauKzY7Y0xwK9L2AfqWV0xzx+leMz/D0NvIM0V8InBgwCnQIn9EvPZ7zC5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rANN5Tis; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rANN5Tis"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UjqxTWuuB6hwwISeGcwn1rhriB/ESjb8XweNljLebVA=; b=rANN5Tis9UvfJyODNmf7Bk9O6o
	dI4ZGKEYkLeMSSRT0bdN7EF06RLbO0Ba/5hdpJSjAOJVloZrHc1RYC/crFHNK41UBZUe0a4QWCwsA
	oeD/YATPVghas6GXqNATYrbOzF2fnPWmURR3/iZHbnxwe4RvwbD9ft1CxRjqQbb7zF1X8xPXCZ2Vu
	bc/FZFOsBOC0q1JsLbaFny14oXjG6t53hrq/E9x0f+g1D/X30aF78P8mcZhXQe/ByY+1/l6YPiYdA
	B51O7Sz13hzWvK0bXUij3mLpKUuwGLUBNlri2Ho03Hds8oE5AZcjp/y2UwjgEQd+j1qj1OSQUNSxC
	DwKdwOHg==;
Received: from 3.95.143.157.bbcs.as8758.net ([157.143.95.3] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6Zf-0000000GQRz-18sq;
	Wed, 17 Apr 2024 14:47:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	saranyamohan@google.com,
	shinichiro.kawasaki@wdc.com
Subject: [PATCH v2] block: propagate partition scanning errors to the BLKRRPART ioctl
Date: Wed, 17 Apr 2024 16:47:43 +0200
Message-Id: <20240417144743.2277601-1-hch@lst.de>
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

Changes since v1:
 - fix the rebase error that causes the flag to reuse a bit number
 - fixed a comment typo

 block/bdev.c           | 29 +++++++++++++++++++----------
 block/ioctl.c          |  3 ++-
 include/linux/blkdev.h |  2 ++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e3e..cea51dca875315 100644
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
+		 * Only return scanning errors if we are called from contexts
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
index c3e8f7cf96be9e..d16320852c4ba2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -128,6 +128,8 @@ typedef unsigned int __bitwise blk_mode_t;
 #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
 /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
 #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
+/* return partition scanning errors */
+#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 6))
 
 struct gendisk {
 	/*
-- 
2.39.2

