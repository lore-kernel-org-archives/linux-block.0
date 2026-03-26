Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895125776
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774507365; cv=none; b=Ycn6XRla1NFTnLSJUByolJ6PC8YliKOCdsdAl6X4vJ84Yl0Q9cVR4reLadoAPu0J8tJYsBejazc43cz4BIkl7hqGVL/P9aAso3DY1fRT7TMcH8/mWITdkfFY8pR1I0R7iAgVjkykNZG+dDeieDBMrb/xX+NmCETdZ+FAyhCqZdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774507365; c=relaxed/simple;
	bh=ftNBq7/p9OU6CGlLtac2IhrmzluXOuKkzay9bsyEyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aESz3jZkD1RJSK5jNUCv6VWTfqmu8N/vzr3PakFan6rF4wQklI0BcPA4J+PwklY2v6pxYXF77qkbFqciXR/+/HsxKRkh7y8AK+WFMCkO0K4+pNaYfXV0YM0ovoiAwVU9quYVHjf9IEXFe8t7s2Cy26p770Xtw6ftZTqZDHK7UyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C158568C4E; Thu, 26 Mar 2026 07:42:39 +0100 (CET)
Date: Thu, 26 Mar 2026 07:42:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 09/26] block/blk-zoned: Add lock context annotations
Message-ID: <20260326064239.GA24534@lst.de>
References: <20260325214518.2854494-1-bvanassche@acm.org> <20260325214518.2854494-10-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325214518.2854494-10-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 25, 2026 at 02:44:50PM -0700, Bart Van Assche wrote:
>  int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
>  			   unsigned int cmd, unsigned long arg)
> +	__cond_acquires(0, bdev->bd_mapping->host->i_rwsem)
>  {
>  	void __user *argp = (void __user *)arg;
>  	struct blk_zone_range zrange;

This looks wrong, the lock is just conditionally taken inside the
function and dropped again.  This cleanup should fix the lock annotation
issues:

---
From 99e701882a9026f56cf6940d858e92ce51d86638 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 26 Mar 2026 07:37:43 +0100
Subject: block: refactor blkdev_zone_mgmt_ioctl

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

