Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652E03515C5
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689142; cv=none; b=qoGjJYidPUvEl/jWYxLK+Cc5jeOKrd5HR1PlIo/NSi7M6wH/N4m3m1IiCOvC+tL5ZE2+g7OZob78Jrxp8VK9dRRuWKa47zQSNwlcucJRxmtnvtMPleI06S9ri5fdhcIcJsE9ucZ1OX2kcZ5gnD+rc3qhCL2ekkjFIlojl08OdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689142; c=relaxed/simple;
	bh=NqUTUMGrRBv3PVZDm9c38EsVA/b2V8O02zWzl53nZv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/thtHtWLsNsS08FdH61GCA6at4Kerllz/jizXRyVg7p9LeSAL31NZz5oXlg+ZMAe4vsUm3fsFrMW3KpDy3yHfldKe/sNi0fL+rYT/ASCcymTL6BHuKu+pViptZEPOm9ECISMAKwKGf/Ahudi9bYZ7m7ijVEu5xzuBjssmROyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLyjVI2c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLyjVI2c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60D41F00A3D;
	Fri, 14 Aug 2026 06:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786689141;
	bh=cqyelYjQPJu8B6FNcVBp7E+lze3glUURYsiAVqg4aGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aLyjVI2cQRh8iga2ZVQIxhv1nVVkLWUOSjYg87Mr7b4esti83Q46ehVqGGi/98uVQ
	 zDUzlZR3rQF/ubclboqCB5pxKi2qEJT1MaWh8DaBxQLxyiV06DuZCsg+HzHEMvYGRS
	 D1pPk6lt5Pz9vEFi/ly9sh16z1qQarRQtCUoRSKTCRldRilL06mQVVE1shpmJ5DIBu
	 ZfxtjyxyzNlvbecApwoE5y0S83WZX8zpDedR6o9aJI8raKk/nbUafa9WGe12YxPs5j
	 j3E6cDgqR67XbUcWVJOOyqLBeo0aamrxy94zse1Qi4H2PevrGIuDLXhb5DhyM7x5Sd
	 VGnGOmsQ7ZRRA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 10/13] block: fail zone management operations to read-only and offline zones
Date: Fri, 14 Aug 2026 15:31:58 +0900
Message-ID: <20260814063201.1762743-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814063201.1762743-1-dlemoal@kernel.org>
References: <20260814063201.1762743-1-dlemoal@kernel.org>
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
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
index b88860cf5864..ea1c00043a03 100644
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

