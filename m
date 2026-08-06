Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C1A477985
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032306; cv=none; b=MuFhG+gEfitmHhuDoqdj9TkI89cYgjoUCT5pbbz8RN/7sBSb8hfa1lxo7WSN3yhUta3jWQurzIu5OzleUicFMkzBiZdyHtZaWy+wVH+9V2xszwbv/r5VB1+bD1FCYIrqxBKXUh35PNr9YLtTbCP7DyjisxQ0bWdl6/XqXTydmdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032306; c=relaxed/simple;
	bh=9q7V8NCDUSI8x+FDkUNzBJgFsnRXsewneMl8bM1fdoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FVA/9AZAkVPMqm5o2enW9vT8h5PoyPiU93sds9hL7wptZJ/4tArsK6YhHEWGFv6fqL92Nbde+w/D9Xky3wxfr0OVrr/6V2rCNeac6FE0SfdVBbpXkRlmdFYWOjlm/6vpgYEcK3NsDYht8BpCRe4VK5wd5F6xPa3B9kXAiO95Uno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oqtbq8xb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oqtbq8xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6931F00A3A;
	Thu,  6 Aug 2026 16:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032304;
	bh=XiKE7ZFUjFh15VTVujsPqHrb6xZBWXpz0dXzUR45B1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oqtbq8xbJPL0AcRWlCqbZ7pTEKX37xJlkJLor72WUTQncO/QUZWyaDqHgWIZKKI4a
	 Sfva00JZH/aimq5ZpSftsySdf2I8Gq3ElBCRxmS+vapavcFpjLaC3Vdg+aHDfYswbv
	 3Rx9tC7fV/C12c3Hf5b1ULErXa/JXjWwJ7O0mN9OEB44aExMttEAyueJTM5fToZ2Mo
	 k8rUE0R8ILoq9HzHozxWerYxIIhrNSILpVuESoFvzlY+epZpDurpikF3wRKmlnWDy9
	 ThP7QVAi7z/NdYtfnl+4mM5xuxuaCZFjjpBqPS/eEMzSOmTNGMXjMPDdjONzuxU1Ld
	 BKziygeQW/PVg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 10/13] block: fail zone management operations to read-only and offline zones
Date: Fri,  7 Aug 2026 01:04:42 +0900
Message-ID: <20260806160445.848337-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806160445.848337-1-dlemoal@kernel.org>
References: <20260806160445.848337-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any zone management operation targeting a zone that is in the read-only
or offline condition will fail. So there is no point in issuing such
BIO. Modify the check in submit_bio_noacct() to use the new helper
function bdev_check_zone_mgmt() to check that a zone is sequential (as was
checked before) and also that the zone is not offline nor read-only.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-core.c  |  7 +++++--
 block/blk-zoned.c | 24 ++++++++++++++++++++++++
 block/blk.h       |  6 ++++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58..80a4e2bcc3f3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -901,8 +901,11 @@ void submit_bio_noacct(struct bio *bio)
 	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_RESET:
 	case REQ_OP_ZONE_FINISH:
-		/* Zone management operations require sequential zones. */
-		if (!bdev_zone_is_seq(bio->bi_bdev, bio->bi_iter.bi_sector))
+		/*
+		 * Zone management operations require sequential zones that are
+		 * not offline nor read-only.
+		 */
+		if (!bdev_check_zone_mgmt(bdev, bio->bi_iter.bi_sector))
 			goto end_io;
 		break;
 	case REQ_OP_ZONE_RESET_ALL:
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0f0ffe832008..d13a6edc7362 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -323,6 +323,30 @@ bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
 }
 EXPORT_SYMBOL_GPL(bdev_zone_is_seq);
 
+/**
+ * bdev_check_zone_mgmt - check if a sector belongs to a valid sequential zone
+ * @bdev:       block device to check
+ * @sector:     sector number
+ *
+ * Check if @sector on @bdev is contained in a sequential write required zone
+ * that is not offline nor read-only.
+ */
+bool bdev_check_zone_mgmt(struct block_device *bdev, sector_t sector)
+{
+	enum blk_zone_cond cond;
+	u8 zs;
+
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	zs = disk_zone_get_state(bdev->bd_disk, sector);
+	if (blk_zstate_is_conv(zs))
+		return false;
+
+	cond = blk_zstate_to_zone_cond(zs);
+	return !disk_zone_cond_is_offline_or_readonly(cond);
+}
+
 /*
  * Zone report arguments for block device drivers report_zones operation.
  * @cb: report_zones_cb callback for each reported zone.
diff --git a/block/blk.h b/block/blk.h
index 50abfd932886..cfe8d4185e25 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -577,6 +577,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 		unsigned long arg);
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
+bool bdev_check_zone_mgmt(struct block_device *bdev, sector_t sector);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline void disk_init_zone_resources(struct gendisk *disk)
 {
@@ -619,6 +620,11 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 {
 	return -ENOTTY;
 }
+static inline bool bdev_check_zone_mgmt(struct block_device *bdev,
+					sector_t sector)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
-- 
2.55.0

