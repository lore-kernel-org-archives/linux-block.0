Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F63C1F26
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896866; cv=none; b=nFM0cpgSPB6JXP8XuMcb/zY9ejFE4Wm7M9V1ezpZl4WfvtcxedqLxzMwVGhBI8j5yfWq9i28IuNUV8O/yr02UWeyOBJdeIP3V+RQ4AppJgVHi9f/lviZDgxtGVLjTfgQicCGh5/JdO3W2BOxMwkVmfRysI1fel27NKr6VYeuc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896866; c=relaxed/simple;
	bh=37b18YckRymc4WhHPLeL9gHm4UCC4tJlHkpOmam/3pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcpO/37lvbfvfj0ktvDC6hk7Sv/xM2w9ok0MiMDNFCeXYgZCjZQzp7ZQa9IdyHKlzZFM00vFyZiodMv3z/X3OSYQP/HZOa2JIg6rNeAj57BvFTI6ZxhsZIwyfwYcwIts7e6jwpB74EbpzIVMsf2x/8isRZRAJxdJr5odrM1jY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D60T1Zpv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D60T1Zpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1C11F00A3D;
	Wed,  5 Aug 2026 02:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896865;
	bh=LyytBMOksibxewbjbc9uQSA17CIVCkJ4n3t+ukhW95A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D60T1ZpvLS8xPkqCGyoNwPzTgTOiGHCW7yszy9jVyS2uqOiA417Jiiex7DkIyCxz5
	 2VdUvuwigkDREHSBUqGsRcGpuPnCf0b41ny8YBmWcvsCxidPU4yz45pR0gXPb0nc5W
	 WAqo5sDLNl2xow+R4Qbv2t6Bjpnp2wXohcJ+LfC/yF2Mid7XfZXEYsI0Zq4Vk+hiDK
	 XIx0mWruhIXSK3CKRgN0cuAswZsb1k3WIpOXSV4qPv/PbYpq3U9tG8jqWHSrbjaQCh
	 oGG7JlSCz+4HzP7RqgymcKe2zm/XAi07H9Mh7mnsnYjwyZ4XY9PYdy5uLrShKoW6DH
	 UIJ90wnrS42VQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/14] block: fail reads to offline zones early
Date: Wed,  5 Aug 2026 11:27:19 +0900
Message-ID: <20260805022719.735323-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805022719.735323-1-dlemoal@kernel.org>
References: <20260805022719.735323-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We know that any operation targeting a zone that is offline will fail,
including read commands. So there is no point in issuing such reads.
Fail them early if we ever see one, and be quiet about the error.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-core.c  |  5 +++++
 block/blk-zoned.c | 17 +++++++++++++++++
 block/blk.h       |  6 ++++++
 3 files changed, 28 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 80a4e2bcc3f3..a5c4fcd210bb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -866,6 +866,11 @@ void submit_bio_noacct(struct bio *bio)
 
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
+		if (bdev_is_zoned(bdev) &&
+		    bdev_zone_is_offline(bdev, bio->bi_iter.bi_sector)) {
+			bio_set_flag(bio, BIO_QUIET);
+			goto end_io;
+		}
 		break;
 	case REQ_OP_WRITE:
 		if (bio->bi_opf & REQ_ATOMIC) {
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e900c5d14414..83185fc0cc4d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -308,6 +308,23 @@ bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
 }
 EXPORT_SYMBOL_GPL(bdev_zone_is_seq);
 
+/**
+ * bdev_zone_is_offline - check if a sector belongs to an offline zone
+ * @bdev:       block device to check
+ * @sector:     sector number
+ *
+ * Check if @sector on @bdev is contained in an offline zone.
+ */
+bool bdev_zone_is_offline(struct block_device *bdev, sector_t sector)
+{
+	enum blk_zone_cond cond = disk_zone_get_cond(bdev->bd_disk, sector);
+
+	if (!bdev_is_zoned(bdev))
+		return false;
+
+	return cond == BLK_ZONE_COND_OFFLINE;
+}
+
 /**
  * bdev_check_zone_mgmt - check if a sector belongs to a valid sequential zone
  * @bdev:       block device to check
diff --git a/block/blk.h b/block/blk.h
index 4024bd9251d4..636884424873 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -578,6 +578,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
 bool bdev_check_zone_mgmt(struct block_device *bdev, sector_t sector);
+bool bdev_zone_is_offline(struct block_device *bdev, sector_t sector);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline void disk_init_zone_resources(struct gendisk *disk)
 {
@@ -625,6 +626,11 @@ static inline bool bdev_check_zone_mgmt(struct block_device *bdev,
 {
 	return false;
 }
+static inline bool bdev_zone_is_offline(struct block_device *bdev,
+					sector_t sector)
+{
+	return false;
+}
 #endif /* CONFIG_BLK_DEV_ZONED */
 
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
-- 
2.55.0

