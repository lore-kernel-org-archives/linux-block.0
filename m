Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3D3C1405
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896862; cv=none; b=NdJZlIZvaxW0p3pMp3ByFsL9sxN9LhPHq5X6bMcQZUqTQhaD+Srw7hIKuRXuzz3g3+s1b/srAnu30313wmfRDx6xeGc5xxo7ZDH1VRSHQ7jdZjP2Sgk8rq12TI0EgYKNq239P1gAPEqvLPF93HYkhQiuk68bS5UZwev4SI6y5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896862; c=relaxed/simple;
	bh=Yieh6nXHGR3f4HOKD1/m26nvZ7h4lhO/ZXPKAuID+KM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upo2DcVEnvA6+IygWrQP54eTHlaa4byYq5CeCHXWfk7WYFH0mF2X0Q/x1RgiDDDJDhdZIH95jG/XKYLr8ev2dUmdNHsi/ZEZXfY/HZBlqf8irpWPSZa4JdYNHpx8u3I4yNwbiFpwjLRE93n2a3zuYdggJh4+TcWTZ0H48pqkoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxymXdQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxymXdQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C451D1F00A3A;
	Wed,  5 Aug 2026 02:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896861;
	bh=EbO+njhVpvWlfCZqr8bQ5DgIsvH6JtKJ9083g3Abj2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxymXdQZqvIgVkJMJ4hF3TRj/3Yk+D8XZmLU3eabWr9hVgG1sxOtI+IgGZZH3g5zX
	 uKGUY1IPk8czEV1AMY1BdFKYkNr9CE1YAs24xj807DR5fpXocMS58+GTRWbDGXJI0I
	 L62i5vU/zKU+OmmJ9l2QDdkslECKok9EYYsyEKnMsGn6uYttb4xvt7H4caWUJaQBOY
	 wOY5Eg6aCOBUjYdq3qUg83xfKwOhTPNrEMfPuVnWKPf3p129eWjnW98BYU3n3Jhb1l
	 K5Rgx+bnKTGPxvy6z0Kdp9dIPkY/V6RejTzNHiz82GmM377GAm/W9j3fxsjjyH3bXr
	 tj7TUoqTkRRYg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/14] block: fail zone management operations to read-only and offline zones
Date: Wed,  5 Aug 2026 11:27:15 +0900
Message-ID: <20260805022719.735323-11-dlemoal@kernel.org>
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
index 069251171154..1d1175638763 100644
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
index eaac05815cb0..4024bd9251d4 100644
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

