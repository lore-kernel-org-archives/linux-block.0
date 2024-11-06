Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE920CCF8
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 23:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934806; cv=none; b=USJ9EOj7k5EHaJkLgijW9rbNHhi1Mx8urUuCIDFLsR5EoRM+nS/+ZmBRNvRI7JsZil7/pAx/v2JMeyiSAdF3bwJhMpMhZkhN+k3EzxGlhp0qSO396yPTfuQmNV7IibawNQeuvexWFjo8HVU7gJyAFZ9TJGDee35mXwgrstDmpu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934806; c=relaxed/simple;
	bh=W+1/Z1+QfHOY0t6w2Nvkv+7+MyyLGTYmiTmz/n49sB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrZQy9nPFx2bsGD9s8K1skICaH3EH5cG/29uymXIxIWkpwuwbn3A2GGW7Tb/qGOkCFr3DPSSJ6+dSHKTZKyjaiLk88b+GPxyOyS6hXB+LM9cucUSliCOAwHYx/cw1Q/E9k9e17ez2CaLsgBocJryJ2vA8ab+0mmnykfftAY9jIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+gjEQeP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+gjEQeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC7BC4CED2;
	Wed,  6 Nov 2024 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730934806;
	bh=W+1/Z1+QfHOY0t6w2Nvkv+7+MyyLGTYmiTmz/n49sB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+gjEQePiyDILxHm1V3N/9GJdILRhTeT0X6akG7TdrQMcZVqveThsyEpYt9b/VX18
	 cvd8TOuJrsl55ZS4mXY0ZjbliI2RKjFDSD0eVDmd4GYC3Bc/1rM3Y0y/shCnNhv/Bo
	 JQnXZ8/cVB4i0JrpOkir5pQ4xfMwWPN7uSM66wT3C0C6Srfr2WfsUWc3f557J6f3Vu
	 2hRRRS+hel1EoXP8zToq6r2AZ4usTrmqilXb/RHt8FwCcI0zk/VnmD5bFV0bqQIGpD
	 5SXYF6yQLY2LOh0k3oo7kfXpHDibOxkkOFv9zxWUiSVC4xNy7g24MWuINwxsSihLHQ
	 KgyyVcl4oVnWQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] block: Add a public bdev_zone_is_seq() helper
Date: Thu,  7 Nov 2024 08:13:23 +0900
Message-ID: <20241106231323.8008-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106231323.8008-1-dlemoal@kernel.org>
References: <20241106231323.8008-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Turn the private disk_zone_is_conv() function in blk-zoned.c into a
public and documented bdev_zone_is_seq() helper with the inverse
polarity of the original function, also adding a check for non-zoned
devices so that all file systems can use the helper, even with a regular
block device.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 16 ++--------------
 include/linux/blkdev.h | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7a7855555d6d..a8c1e4106d6d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -348,18 +348,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 	return ret;
 }
 
-static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
-{
-	bool is_conv;
-
-	rcu_read_lock();
-	is_conv = disk->conv_zones_bitmap &&
-		test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
-	rcu_read_unlock();
-
-	return is_conv;
-}
-
 static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zone)
 {
 	return zone->start + zone->len >= get_capacity(disk);
@@ -714,7 +702,7 @@ static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
 	struct blk_zone_wplug *zwplug;
 
 	/* Conventional zones cannot be reset nor finished. */
-	if (disk_zone_is_conv(disk, sector)) {
+	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
 		bio_io_error(bio);
 		return true;
 	}
@@ -968,7 +956,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	}
 
 	/* Conventional zones do not need write plugging. */
-	if (disk_zone_is_conv(disk, sector)) {
+	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
 		/* Zone append to conventional zones is not allowed. */
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			bio_io_error(bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5687eb2a019c..24fef307d594 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1380,6 +1380,32 @@ static inline bool bdev_is_zone_start(struct block_device *bdev,
 	return bdev_offset_from_zone_start(bdev, sector) == 0;
 }
 
+/**
+ * bdev_zone_is_seq - check if a sector belongs to a sequential write zone
+ * @bdev:	block device to check
+ * @sector:	sector number
+ *
+ * Check if @sector on @bdev is contained in a sequential write required zone.
+ */
+static inline bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
+{
+	bool is_seq = false;
+
+#if IS_ENABLED(CONFIG_BLK_DEV_ZONED)
+	if (bdev_is_zoned(bdev)) {
+		struct gendisk *disk = bdev->bd_disk;
+
+		rcu_read_lock();
+		is_seq = !disk->conv_zones_bitmap ||
+			!test_bit(disk_zone_no(disk, sector),
+				  disk->conv_zones_bitmap);
+		rcu_read_unlock();
+	}
+#endif
+
+	return is_seq;
+}
+
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q->limits.dma_alignment;
-- 
2.47.0

