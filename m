Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821B426409
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445952; cv=none; b=uEIMH4zM5FAt+yLDmRBDV1ZLwSdo180rGYODzPZLn/Ue/fBidVoWb2dYb6MXQXZR0X4CTrDs2mJ/LecL8QTEO+T+ZwJbmxFJAbsX2JfvAFi2NYDdW0d7YDqz9bYXbeK5slM+FQGx8nyAgmQlK6CoG0UGXcgGUH9c0l2JsOI7atM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445952; c=relaxed/simple;
	bh=/e2upsQDIRQ3P2OH3D6gSpukAhbV2RvIFmzn+sbDz3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FF0gIs+uLxz2Jrc/UuwNSEMcW54wDUkMskuw+eALAigcdOaLDFnjm5G2MCAkPuLC8EtYS/eIYW3TW1AmuA3tdUworl1iKXGaO913qXYD+Kqcv7+L4FoaWGmPeBqiyzKToIdY6m00z9+7d4JDcBVoMja32voTdiSBLkQsIadRIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYp6fVzN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYp6fVzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087251F000E9;
	Tue, 11 Aug 2026 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445951;
	bh=webplP6mrl/wH1RX3tL4q7ImKqa3Y6bhXaesWv4syuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RYp6fVzNo7+qbJA5sQVoj7vZlh/qg0j82AxcVnZRUMJOXuh9DH7TQVnjxrAdhHmcT
	 /AYCI9q1dXTMoheyRIVKq9NWacDt9yfUBb+rB8njT8bf7+PUec/ocZ97/Hr6kU6G7i
	 n29fkYJJVk0oJ/9Rg1d0n40tP7wUeUbpPUzT9V86Hoyy8Hin9V+OxfygpyNEqRPVwK
	 K/l4h+RFJ6zLobYAMZdiGEvMdpd7ZxNHteRinUsUGVDETaPOHfTppZKItPX2+5boUe
	 iI1wxGwxAnoAB0SoeKjgXKzJ1jFbgDJRhEoKouf9oKWHwl6cyoO+/+XgrPj4i49fIP
	 GldFNFIApDlww==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 10/13] block: fail zone management operations to read-only and offline zones
Date: Tue, 11 Aug 2026 19:58:49 +0900
Message-ID: <20260811105852.1245357-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811105852.1245357-1-dlemoal@kernel.org>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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
index b43b3745f700..7ed1cb1341c2 100644
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

