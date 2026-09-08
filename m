Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97544C6808
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857912; cv=none; b=eY0oTaDNQTE5VTy8H6iGCXaFHltEuPvObBNTFAdxi0kt9gsthyuCrpxpLp8LIknvRPqqrp+zyNDqL/SG+9HeldP0eWU41dkU/OgWbbpkG6oV7osvnOXG94KlDJIwDQiVOe8Nt2gS/O2fwLDD82IGqfU6ZT1+8qp0CI9MF6leIsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857912; c=relaxed/simple;
	bh=EmsHhZ8AZdcoAM4Utpp/4/ANErKd+MyVfAVw/0onrHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7wLZ46epL5dRzCd85X7IcubMYpvY3Z5dY3MY8pn+V2fySmQSDRYJW/25xH9KtXopirqRXJ9w+iJNFE3hMojQm9QOGegfqslgyzQy3PDa1Uw+2Gs8tCswE0SlZOuRZQGhF6MeqUrOA3Yi72rjANi5/jKRKvUtBoB1B0GLGNL+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSNj9t8Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSNj9t8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC75F1F01560;
	Tue,  8 Sep 2026 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857887;
	bh=Ev5OKhgGaFl2MoZvo8zNA8VsVmfh+dtu0qafdrq6aZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oSNj9t8ZOdLFNcFZaPfpJ06YS+rslrVTe/clETOMC3V7M0mXA7QzshhKSL2eIHkAV
	 oTO+QqlS93GLx0c6N9ldL64vbnxFREdfyP5sWJfk78d8ieAgWS3l0LoWCAtOBZz0s5
	 DyaxPxoji0XotzqyDZwKljlMsF0RiY83o0l/5y1246V5Q8TLvLt7HyFQHootpZ5uZZ
	 DLPuFGVBPmD63iJaTMVRcUfaqonfpAtZ3gMaG23u2Mq6HXToyVJcOapXuvSWhyePXg
	 wvbHQoWgEAkNRTY9Z218G6BQSYhq2aZJfZmUB9ASuWuVZNXoUyhlBpWWyo1XktnNon
	 zkIKO2bkv4ykg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 14/16] block: fail zone management operations to read-only and offline zones
Date: Tue,  8 Sep 2026 17:57:43 +0900
Message-ID: <20260908085745.1082697-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908085745.1082697-1-dlemoal@kernel.org>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index ecaeacf3b287..c653cfc9823c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -322,6 +322,31 @@ bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
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

