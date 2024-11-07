Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5884E194C6F
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961783; cv=none; b=ocibF/AmHEELJhqPWp7LC/vH+h7oSmhPll30K9F3CCETy2tW/ofjE1egEK90PNgTp7BqMf8omO6s6ZeiOLZwsqJP21POGTZw36EryS82a2pKeLNPWuQhyQBCRlAKQ0jfuj8g+MbK5/lxcgwG8sgFucpUpOZXfVpnLzyo+QLx6Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961783; c=relaxed/simple;
	bh=jn82UvHOgzDNdskv8oSNeU+IHJZJDzodSlIUEfbNce0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d212nNud1+nNtZy4Pzs6K1X35SA1kZJuTv2NjVwViuHbQ/CrA1MDiDdbvsqmrv8Rvu+cna+xWMs8+Vbg0QRA67+P/lvGlkdsWK2sxQlHPoik5IAXiuUIM9VzT7RQfBowr296iRBTHsbXqFrHxp7FoPe5q1Ou8tiVmZi4iN+r9C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9nBbfNq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9nBbfNq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92E9C4CED3;
	Thu,  7 Nov 2024 06:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961783;
	bh=jn82UvHOgzDNdskv8oSNeU+IHJZJDzodSlIUEfbNce0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G9nBbfNqeGMZiK/cfLYXjyzc38FUgrLcI5DC6hgD/odilj78rfJb8hqx2J6Acrk9N
	 ZzFBBzsoDHMtNaZhR1mrKzfaIvj6ttysk8UZEwa7hLnxz1HmtV5ndy+aT5hiuoE2jZ
	 HsKoKkRULGG5ey7HMrOvHaudP01QRgzCBiYNujq32MbojGZ4aA674mNwldSrK/ATBn
	 7i3MmdVwcAbdU8dZwazhAv5ZwoTUXEHmW7zAH5UcbC/9yJ+Df4MzsoIl8vTCisUdsj
	 +ZJXehTl2Ilx4Q4xg81kaJW9HrusSdrtBPFw/Ku1I301U6JXnmRoOBVx+/pzYAOqWj
	 C1AHFiMYaJ44w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/2] block: Add a public bdev_zone_is_seq() helper
Date: Thu,  7 Nov 2024 15:43:00 +0900
Message-ID: <20241107064300.227731-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107064300.227731-1-dlemoal@kernel.org>
References: <20241107064300.227731-1-dlemoal@kernel.org>
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
 block/blk-zoned.c      | 17 ++---------------
 include/linux/blkdev.h | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bf4458b11720..797a5d30ac01 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -348,19 +348,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 	return ret;
 }
 
-static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
-{
-	unsigned long *bitmap;
-	bool is_conv;
-
-	rcu_read_lock();
-	bitmap = rcu_dereference(disk->conv_zones_bitmap);
-	is_conv = bitmap && test_bit(disk_zone_no(disk, sector), bitmap);
-	rcu_read_unlock();
-
-	return is_conv;
-}
-
 static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zone)
 {
 	return zone->start + zone->len >= get_capacity(disk);
@@ -715,7 +702,7 @@ static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
 	struct blk_zone_wplug *zwplug;
 
 	/* Conventional zones cannot be reset nor finished. */
-	if (disk_zone_is_conv(disk, sector)) {
+	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
 		bio_io_error(bio);
 		return true;
 	}
@@ -969,7 +956,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	}
 
 	/* Conventional zones do not need write plugging. */
-	if (disk_zone_is_conv(disk, sector)) {
+	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
 		/* Zone append to conventional zones is not allowed. */
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			bio_io_error(bio);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5687eb2a019c..ac5aad7ca22f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1380,6 +1380,33 @@ static inline bool bdev_is_zone_start(struct block_device *bdev,
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
+		unsigned long *bitmap;
+
+		rcu_read_lock();
+		bitmap = rcu_dereference(disk->conv_zones_bitmap);
+		is_seq = !bitmap ||
+			!test_bit(disk_zone_no(disk, sector), bitmap);
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

