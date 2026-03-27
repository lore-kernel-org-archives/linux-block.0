Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E43DA5D6
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 09:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602041; cv=none; b=GSrbApjjo6Q+6yEnFXNr2OaHgTBsFg6dMtZpsn7mhnz8exby+Yd6ShbtV8Q4Xz7C+5V64ePzQb2LDwfnUcPjTamAvk8vS+IhGzY5v0cFA5UmKtMR0aWMsoY26fSH7XgvNWdOsWIuLkY0qWAYfK935EXRO+Z7+poJhZlbvsRiEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602041; c=relaxed/simple;
	bh=qGHFPxFCGglVw0f56nxUUg5Et8ozFasA9da9EvsXMq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOGn3NFf+06ELnAUyAkFSQtgnLmKiX+AgymVOyesjSAE2N6/zYQmN34dYr5iBIfQvEf1yLXL4jRGsg+tUV38bfq0nddNklBqAeV1Byzt4TpHzxKa1R+raRp43gMNz3Dxlo+PrZIG5O6hW11ADWCHj+7M43jfBmkaxMPFVTMDgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sQLp5YYt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQLp5YYt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qU5NnwyNFowTMx9H8UQmWwbhg91Uh7EQc+vyVe0pN60=; b=sQLp5YYtWPAX58MvJykFd9YAhO
	AH4QSLigwsp5minMHF7TK3pf8tAWBM9KC/hDxlNMdGs8FDUpZOx8smsQ0tidIxpOFs5eENcSXpwgt
	X8/3YAtbwJNXfZm4KGT0tZRjra5BrIM5H61n5zL3rgA0SBUD7yFCJ0IkbWG6625mgouiX5tlYuGsi
	2xcQeJ2kRrw5ExPTVhmoyGQJA+QNlty2nw7GPaJK8WVu/gtL4occGLeHaNkqC2Jt77XOXQpOdN501
	a+ZA1IN3OpiarutA5zGDycwKKrsm7DlOFf9RfNLvDRq2jB4yK1KaEJrixwQRM8aDcf0QBeH+mWNwF
	b08EL9TA==;
Received: from [213.208.157.36] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w633W-000000071Xr-0QR9;
	Fri, 27 Mar 2026 09:00:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	dlemoal@kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: refactor blkdev_zone_mgmt_ioctl
Date: Fri, 27 Mar 2026 10:00:32 +0100
Message-ID: <20260327090032.3722065-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split the zone reset case into a separate helper so that the conditional
locking goes away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 9d1dd6ccfad7..d370d871d019 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -412,20 +412,32 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, unsigned int cmd,
 	return 0;
 }
 
-static int blkdev_truncate_zone_range(struct block_device *bdev,
-		blk_mode_t mode, const struct blk_zone_range *zrange)
+static int blkdev_reset_zone(struct block_device *bdev, blk_mode_t mode,
+			     struct blk_zone_range *zrange)
 {
 	loff_t start, end;
+	int ret = -EINVAL;
 
+	inode_lock(bdev->bd_mapping->host);
+	filemap_invalidate_lock(bdev->bd_mapping);
 	if (zrange->sector + zrange->nr_sectors <= zrange->sector ||
 	    zrange->sector + zrange->nr_sectors > get_capacity(bdev->bd_disk))
 		/* Out of range */
-		return -EINVAL;
+		goto out_unlock;
 
 	start = zrange->sector << SECTOR_SHIFT;
 	end = ((zrange->sector + zrange->nr_sectors) << SECTOR_SHIFT) - 1;
 
-	return truncate_bdev_range(bdev, mode, start, end);
+	ret = truncate_bdev_range(bdev, mode, start, end);
+	if (ret)
+		goto out_unlock;
+
+	ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET, zrange->sector,
+			       zrange->nr_sectors);
+out_unlock:
+	filemap_invalidate_unlock(bdev->bd_mapping);
+	inode_unlock(bdev->bd_mapping->host);
+	return ret;
 }
 
 /*
@@ -438,7 +450,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 	void __user *argp = (void __user *)arg;
 	struct blk_zone_range zrange;
 	enum req_op op;
-	int ret;
 
 	if (!argp)
 		return -EINVAL;
@@ -454,15 +465,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 	switch (cmd) {
 	case BLKRESETZONE:
-		op = REQ_OP_ZONE_RESET;
-
-		/* Invalidate the page cache, including dirty pages. */
-		inode_lock(bdev->bd_mapping->host);
-		filemap_invalidate_lock(bdev->bd_mapping);
-		ret = blkdev_truncate_zone_range(bdev, mode, &zrange);
-		if (ret)
-			goto fail;
-		break;
+		return blkdev_reset_zone(bdev, mode, &zrange);
 	case BLKOPENZONE:
 		op = REQ_OP_ZONE_OPEN;
 		break;
@@ -476,15 +479,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 		return -ENOTTY;
 	}
 
-	ret = blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
-
-fail:
-	if (cmd == BLKRESETZONE) {
-		filemap_invalidate_unlock(bdev->bd_mapping);
-		inode_unlock(bdev->bd_mapping->host);
-	}
-
-	return ret;
+	return blkdev_zone_mgmt(bdev, op, zrange.sector, zrange.nr_sectors);
 }
 
 static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zone)
-- 
2.47.3

