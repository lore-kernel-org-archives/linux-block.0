Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDFF3BED31
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147708; cv=none; b=MY2jqLG5kZL2sWnvlKos3/RU06WwmoN1rnT8H50kmFwYOCryfzu108JtKpMCzJBeCG+hrzQEVF2Cz6xl9vACuF1htnLSoi2m7NwL+W3g35INOC5f17DELvDuWE52L2RAI7S3ymyow7oGsu5kn8jNKYFgq2GNc0wFFal7lCE+NZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147708; c=relaxed/simple;
	bh=HJIUPQlN78Uqflcc8LGHvYDBGSxVkxcZBewv+dRr8Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHpPDKQKR0M2Rknsnz8esXUkrSdSyqDwp5iOt2JVVKm9/6z91LPipQzGqu/fyVh8+YxpR0XWMJdr9NPL2M9J+txB6+PD5lXb4263D8EPeDHl5GWqUOQuisvVn6edd/ztXNOjvKW1YFmzqH2rGzugRlstegiNdjrYxzNlx5hBCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGAsRoAv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGAsRoAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86A11F01559;
	Mon, 31 Aug 2026 03:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788147690;
	bh=XNEa6PKMoKPaJIWeXZQZdBTQP0yMPbLVjJ8v/Bh6+Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGAsRoAvKTcwloxtCarz/Tiq0iDeggMKicWZsegtIcozIPKMBcJOy/ZVQVwnb/ap7
	 TiU6Aea08I+Nf/3dWpPO/dCKLHciJ5+vm94DbcgP1NvXNGbOA0nxhqE1YsK1f1yW4T
	 EGq0xqTzNd4u7+WOsxK8YgnpVIT9LfVI/XLR4BXOrIzVDGLIMbfnpMrcrcb4e2ySjj
	 ulbTa4dyl3H1k5OpiGS1vqN7Vfvjcay9+1yJI7VtyZsDlFIN4t2cLTvsZ2hKxsYL/K
	 VVoXgK+kDXpcOG+q1ck+RTngYQYWXM23BwZBgv/Y6zeqqg1vNZcHLwH41x+YPXCfpD
	 aB9P09m5Q5VsQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 10/12] block: fail zone management operations to read-only and offline zones
Date: Mon, 31 Aug 2026 12:41:07 +0900
Message-ID: <20260831034109.744039-11-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831034109.744039-1-dlemoal@kernel.org>
References: <20260831034109.744039-1-dlemoal@kernel.org>
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
function bdev_zone_mgmt_allowed() to check that a zone is sequential (as
was checked before) and also that the zone is not offline nor read-only.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c  |  7 +++++--
 block/blk-zoned.c | 25 +++++++++++++++++++++++++
 block/blk.h       |  6 ++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58..13dc70e8f55d 100644
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
+		if (!bdev_zone_mgmt_allowed(bdev, bio->bi_iter.bi_sector))
 			goto end_io;
 		break;
 	case REQ_OP_ZONE_RESET_ALL:
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 576f82b605a0..57006c595ca8 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -323,6 +323,31 @@ bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
 }
 EXPORT_SYMBOL_GPL(bdev_zone_is_seq);
 
+/**
+ * bdev_zone_mgmt_allowed - check if management operations are allowed on a zone
+ * @bdev:       block device to check
+ * @sector:     sector number
+ *
+ * Check if the zone containing @sector on @bdev can be a target for a zone
+ * management operation, that is, if the zone is a sequential write required
+ * zone that is not offline nor read-only.
+ */
+bool bdev_zone_mgmt_allowed(struct block_device *bdev, sector_t sector)
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
index 50abfd932886..2cc03aa54c53 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -577,6 +577,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 		unsigned long arg);
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
+bool bdev_zone_mgmt_allowed(struct block_device *bdev, sector_t sector);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline void disk_init_zone_resources(struct gendisk *disk)
 {
@@ -619,6 +620,11 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 {
 	return -ENOTTY;
 }
+static inline bool bdev_zone_mgmt_allowed(struct block_device *bdev,
+					  sector_t sector)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
-- 
2.55.0

