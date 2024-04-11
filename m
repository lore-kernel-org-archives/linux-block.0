Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD41428EA
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 08:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825706; cv=none; b=LAqU+P1YIURF/qfOi8EfUVxgSNg859cX7qdaILkR1HkCok0tZt3mpdonsyrAe/oyCE1nYbZhEm9R/2DWVB0u3egTvyfWXY17aqihbZ7oiHT5iqJx+/hB4ViJwnU+7XQ91RztDshxrkuz19V7twTE/hRbQ9uDW6dKnsDT5ZkTSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825706; c=relaxed/simple;
	bh=/YJrMzEozxmBoxGmn/Vu41M3FC9Tdb6G/RD0XS7iQT0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DAsOiSqNTy5pyg4l2Hu5QPFfvRFJRIIHDIxSmPWL845WW758kfaBzdmWsOAzy2bFi+ibAIvG9Wdl5PzHU2SV3sFSn2wc5E+KHCWlO6eFbh55wWSihZAJmftYn4Np1vJKH7JGYbGTveqU5wqob6oSE2BMOTeLcJOscO+anKNoWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3NgAwK0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3NgAwK0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE07C433A6;
	Thu, 11 Apr 2024 08:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712825706;
	bh=/YJrMzEozxmBoxGmn/Vu41M3FC9Tdb6G/RD0XS7iQT0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=b3NgAwK0sZ/0zgHOse3gl5H0DMvlzSftEx6Aa0b6S1BTORmPVN3puN9KxnE/gOm6Z
	 jwn8/R3l3QGk03y/iAmfUETrcDS1ub53QERKwiBgQbDzOIz7B1C7LqFLoHseGviICX
	 F62seakJWnTmFZKRVc/RQRpSBmLanIghJOhmTmhwJdzeWrOCouYzvzjNpfsYr8jF68
	 he1kORGKfXrUCH0aHiraHufxK4gZfWWLhUxZEIAR78snbv5VkxouPYzRrYkmHKohUW
	 jSEKMsDjOrT0zgNHSdojtR6reOgN+pG3DnhjgktrmTDSB+183giP5QjKjJVpBiChlP
	 86zyzY+Cmh0/A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/3] null_blk: Simplify null_zone_write()
Date: Thu, 11 Apr 2024 17:55:02 +0900
Message-ID: <20240411085502.728558-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411085502.728558-1-dlemoal@kernel.org>
References: <20240411085502.728558-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In null_zone_write, we do not need to first check if the target zone
condition is FULL, READONLY or OFFLINE: for theses conditions, the check
of the command sector against the zone write pointer will always result
in the command failing. Remove these checks.

We still however need to check that the target zone write pointer is not
invalid for zone append operations. To do so, add the macro
NULL_ZONE_INVALID_WP and use it in null_set_zone_cond() when changing a
zone to READONLY or OFFLINE condition.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/zoned.c | 36 +++++++++++++++-------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index c31ad2620eb0..5b5a63adacc1 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -9,6 +9,8 @@
 #undef pr_fmt
 #define pr_fmt(fmt)	"null_blk: " fmt
 
+#define NULL_ZONE_INVALID_WP	((sector_t)-1)
+
 static inline sector_t mb_to_sects(unsigned long mb)
 {
 	return ((sector_t)mb * SZ_1M) >> SECTOR_SHIFT;
@@ -341,9 +343,6 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
 
-	if (WARN_ON_ONCE(append && !dev->zone_append_max_sectors))
-		return BLK_STS_IOERR;
-
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		if (append)
 			return BLK_STS_IOERR;
@@ -352,29 +351,26 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 
 	null_lock_zone(dev, zone);
 
-	if (zone->cond == BLK_ZONE_COND_FULL ||
-	    zone->cond == BLK_ZONE_COND_READONLY ||
-	    zone->cond == BLK_ZONE_COND_OFFLINE) {
-		/* Cannot write to the zone */
-		ret = BLK_STS_IOERR;
-		goto unlock_zone;
-	}
-
 	/*
-	 * Regular writes must be at the write pointer position.
-	 * Zone append writes are automatically issued at the write
-	 * pointer and the position returned using the request or BIO
-	 * sector.
+	 * Regular writes must be at the write pointer position. Zone append
+	 * writes are automatically issued at the write pointer and the position
+	 * returned using the request sector. Note that we do not check the zone
+	 * condition because for FULL, READONLY and OFFLINE zones, the sector
+	 * check against the zone write pointer will always result in failing
+	 * the command.
 	 */
 	if (append) {
+		if (WARN_ON_ONCE(!dev->zone_append_max_sectors) ||
+		    zone->wp == NULL_ZONE_INVALID_WP) {
+			ret = BLK_STS_IOERR;
+			goto unlock_zone;
+		}
 		sector = zone->wp;
 		blk_mq_rq_from_pdu(cmd)->__sector = sector;
-	} else if (sector != zone->wp) {
-		ret = BLK_STS_IOERR;
-		goto unlock_zone;
 	}
 
-	if (zone->wp + nr_sectors > zone->start + zone->capacity) {
+	if (sector != zone->wp ||
+	    zone->wp + nr_sectors > zone->start + zone->capacity) {
 		ret = BLK_STS_IOERR;
 		goto unlock_zone;
 	}
@@ -743,7 +739,7 @@ static void null_set_zone_cond(struct nullb_device *dev,
 		    zone->cond != BLK_ZONE_COND_OFFLINE)
 			null_finish_zone(dev, zone);
 		zone->cond = cond;
-		zone->wp = (sector_t)-1;
+		zone->wp = NULL_ZONE_INVALID_WP;
 	}
 
 	null_unlock_zone(dev, zone);
-- 
2.44.0

