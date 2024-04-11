Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81245142620
	for <linux-block@vger.kernel.org>; Thu, 11 Apr 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825705; cv=none; b=XK5aAD+QSMdekEEcTD7gn3L2lcUEDRfqwFO8OPLQyXN43NEGvadbI8yzzIxJX9VTOyJqJrhKgMkT3WWmoudrPzW7ATtE2AEwHGnwG0vL+lWX2EnK8+ACT4hBnIFDOFOBkh9drj/GXzoWsJWvdz5mb6sAfxuYHboN4WXmKWIB2ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825705; c=relaxed/simple;
	bh=nJmLeEyrlW2LfY7xQHjPqw5C1Y9QOBuCBPpTXymiSm8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0Nfhgc4oezvipQAGqbKIIRMcy/OkOofMCdblyD2YW/nioAvD6JfzRRCQdd700CsdWDdblHJmJfC9Xvhy+dsZtKaWh9h2BpOdGxKKzxNEVtG+c2nMNnWFM4xGdKQyS4g86H4OsPoueKIuZ84aBLkMTVv1hLug5rFMlLssiTvlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT/4N6kg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT/4N6kg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D80DC433C7;
	Thu, 11 Apr 2024 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712825705;
	bh=nJmLeEyrlW2LfY7xQHjPqw5C1Y9QOBuCBPpTXymiSm8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HT/4N6kgry63T6dyVJtSMDw4dibtr0kfBiisO7Dwd2zMFl/MnyP4Khio3ICKx8703
	 oR5ka9houc9XeYSTJ0Nechl6QKJgqO4KEYOZpZiC6NNIo4WOnP/tbQNKYaxMql4dlN
	 ka57F26NRdXhLrvQaV2vh7I88w+ArlIoEFS/8dcKhwnw/1OLVoxFpcu86q99KbYyB1
	 5twsZu8inr0VkpOE68RrTC9cydfRYWGO0jlwfRxzacVmuflKCfCC7+Ty1tT8ujHx0I
	 JEG2YYFg1mh6bdQDgW5GcbMVGanRZfw+JI1n+PTkFfut8LY+rESN07PLL1If+g/CHB
	 8MKzT+68BfZoQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/3] null_blk: Do zone resource management only if necessary
Date: Thu, 11 Apr 2024 17:55:01 +0900
Message-ID: <20240411085502.728558-3-dlemoal@kernel.org>
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

For zoned null_blk devices setup without any limit on the maximum number
of open and active zones, there is no need to count the number of zones
that are implicitly open, explicitly open and closed. This is indicated
by the boolean field need_zone_res_mgmt of sturct nullb_device.

Modify the zone management functions null_reset_zone(),
null_finish_zone(), null_open_zone() and null_close_zone() to manage
the zone condition counters only if the device need_zone_res_mgmt field
is true. With this change, the function __null_close_zone() is removed
and integrated into the 2 caller sites directly, with the
null_close_imp_open_zone() call site greatly simplified as this function
closes zones that are known to be in the implicit open condition.

null_zone_write() is modified in a similar manner to do zone condition
accouting only when the device need_zone_res_mgmt field is true.

With these changes, the inline helpers null_lock_zone_res() and
null_unlock_zone_res() are removed and replaced with direct calls to
spin_lock()/spin_unlock().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/zoned.c | 311 +++++++++++++++++----------------
 1 file changed, 165 insertions(+), 146 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 4ddd84752557..c31ad2620eb0 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -19,18 +19,6 @@ static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
-static inline void null_lock_zone_res(struct nullb_device *dev)
-{
-	if (dev->need_zone_res_mgmt)
-		spin_lock_irq(&dev->zone_res_lock);
-}
-
-static inline void null_unlock_zone_res(struct nullb_device *dev)
-{
-	if (dev->need_zone_res_mgmt)
-		spin_unlock_irq(&dev->zone_res_lock);
-}
-
 static inline void null_init_zone_lock(struct nullb_device *dev,
 				       struct nullb_zone *zone)
 {
@@ -251,35 +239,6 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 	return (zone->wp - sector) << SECTOR_SHIFT;
 }
 
-static blk_status_t __null_close_zone(struct nullb_device *dev,
-				      struct nullb_zone *zone)
-{
-	switch (zone->cond) {
-	case BLK_ZONE_COND_CLOSED:
-		/* close operation on closed is not an error */
-		return BLK_STS_OK;
-	case BLK_ZONE_COND_IMP_OPEN:
-		dev->nr_zones_imp_open--;
-		break;
-	case BLK_ZONE_COND_EXP_OPEN:
-		dev->nr_zones_exp_open--;
-		break;
-	case BLK_ZONE_COND_EMPTY:
-	case BLK_ZONE_COND_FULL:
-	default:
-		return BLK_STS_IOERR;
-	}
-
-	if (zone->wp == zone->start) {
-		zone->cond = BLK_ZONE_COND_EMPTY;
-	} else {
-		zone->cond = BLK_ZONE_COND_CLOSED;
-		dev->nr_zones_closed++;
-	}
-
-	return BLK_STS_OK;
-}
-
 static void null_close_imp_open_zone(struct nullb_device *dev)
 {
 	struct nullb_zone *zone;
@@ -296,7 +255,13 @@ static void null_close_imp_open_zone(struct nullb_device *dev)
 			zno = dev->zone_nr_conv;
 
 		if (zone->cond == BLK_ZONE_COND_IMP_OPEN) {
-			__null_close_zone(dev, zone);
+			dev->nr_zones_imp_open--;
+			if (zone->wp == zone->start) {
+				zone->cond = BLK_ZONE_COND_EMPTY;
+			} else {
+				zone->cond = BLK_ZONE_COND_CLOSED;
+				dev->nr_zones_closed++;
+			}
 			dev->imp_close_zone_no = zno;
 			return;
 		}
@@ -392,7 +357,7 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	    zone->cond == BLK_ZONE_COND_OFFLINE) {
 		/* Cannot write to the zone */
 		ret = BLK_STS_IOERR;
-		goto unlock;
+		goto unlock_zone;
 	}
 
 	/*
@@ -406,54 +371,57 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		blk_mq_rq_from_pdu(cmd)->__sector = sector;
 	} else if (sector != zone->wp) {
 		ret = BLK_STS_IOERR;
-		goto unlock;
+		goto unlock_zone;
 	}
 
 	if (zone->wp + nr_sectors > zone->start + zone->capacity) {
 		ret = BLK_STS_IOERR;
-		goto unlock;
+		goto unlock_zone;
 	}
 
 	if (zone->cond == BLK_ZONE_COND_CLOSED ||
 	    zone->cond == BLK_ZONE_COND_EMPTY) {
-		null_lock_zone_res(dev);
+		if (dev->need_zone_res_mgmt) {
+			spin_lock(&dev->zone_res_lock);
 
-		ret = null_check_zone_resources(dev, zone);
-		if (ret != BLK_STS_OK) {
-			null_unlock_zone_res(dev);
-			goto unlock;
-		}
-		if (zone->cond == BLK_ZONE_COND_CLOSED) {
-			dev->nr_zones_closed--;
-			dev->nr_zones_imp_open++;
-		} else if (zone->cond == BLK_ZONE_COND_EMPTY) {
-			dev->nr_zones_imp_open++;
-		}
+			ret = null_check_zone_resources(dev, zone);
+			if (ret != BLK_STS_OK) {
+				spin_unlock(&dev->zone_res_lock);
+				goto unlock_zone;
+			}
+			if (zone->cond == BLK_ZONE_COND_CLOSED) {
+				dev->nr_zones_closed--;
+				dev->nr_zones_imp_open++;
+			} else if (zone->cond == BLK_ZONE_COND_EMPTY) {
+				dev->nr_zones_imp_open++;
+			}
 
-		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
-			zone->cond = BLK_ZONE_COND_IMP_OPEN;
+			spin_unlock(&dev->zone_res_lock);
+		}
 
-		null_unlock_zone_res(dev);
+		zone->cond = BLK_ZONE_COND_IMP_OPEN;
 	}
 
 	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
 	if (ret != BLK_STS_OK)
-		goto unlock;
+		goto unlock_zone;
 
 	zone->wp += nr_sectors;
 	if (zone->wp == zone->start + zone->capacity) {
-		null_lock_zone_res(dev);
-		if (zone->cond == BLK_ZONE_COND_EXP_OPEN)
-			dev->nr_zones_exp_open--;
-		else if (zone->cond == BLK_ZONE_COND_IMP_OPEN)
-			dev->nr_zones_imp_open--;
+		if (dev->need_zone_res_mgmt) {
+			spin_lock(&dev->zone_res_lock);
+			if (zone->cond == BLK_ZONE_COND_EXP_OPEN)
+				dev->nr_zones_exp_open--;
+			else if (zone->cond == BLK_ZONE_COND_IMP_OPEN)
+				dev->nr_zones_imp_open--;
+			spin_unlock(&dev->zone_res_lock);
+		}
 		zone->cond = BLK_ZONE_COND_FULL;
-		null_unlock_zone_res(dev);
 	}
 
 	ret = BLK_STS_OK;
 
-unlock:
+unlock_zone:
 	null_unlock_zone(dev, zone);
 
 	return ret;
@@ -467,54 +435,100 @@ static blk_status_t null_open_zone(struct nullb_device *dev,
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
-	null_lock_zone_res(dev);
-
 	switch (zone->cond) {
 	case BLK_ZONE_COND_EXP_OPEN:
-		/* open operation on exp open is not an error */
-		goto unlock;
+		/* Open operation on exp open is not an error */
+		return BLK_STS_OK;
 	case BLK_ZONE_COND_EMPTY:
-		ret = null_check_zone_resources(dev, zone);
-		if (ret != BLK_STS_OK)
-			goto unlock;
-		break;
 	case BLK_ZONE_COND_IMP_OPEN:
-		dev->nr_zones_imp_open--;
-		break;
 	case BLK_ZONE_COND_CLOSED:
-		ret = null_check_zone_resources(dev, zone);
-		if (ret != BLK_STS_OK)
-			goto unlock;
-		dev->nr_zones_closed--;
 		break;
 	case BLK_ZONE_COND_FULL:
 	default:
-		ret = BLK_STS_IOERR;
-		goto unlock;
+		return BLK_STS_IOERR;
 	}
 
-	zone->cond = BLK_ZONE_COND_EXP_OPEN;
-	dev->nr_zones_exp_open++;
+	if (dev->need_zone_res_mgmt) {
+		spin_lock(&dev->zone_res_lock);
 
-unlock:
-	null_unlock_zone_res(dev);
+		switch (zone->cond) {
+		case BLK_ZONE_COND_EMPTY:
+			ret = null_check_zone_resources(dev, zone);
+			if (ret != BLK_STS_OK) {
+				spin_unlock(&dev->zone_res_lock);
+				return ret;
+			}
+			break;
+		case BLK_ZONE_COND_IMP_OPEN:
+			dev->nr_zones_imp_open--;
+			break;
+		case BLK_ZONE_COND_CLOSED:
+			ret = null_check_zone_resources(dev, zone);
+			if (ret != BLK_STS_OK) {
+				spin_unlock(&dev->zone_res_lock);
+				return ret;
+			}
+			dev->nr_zones_closed--;
+			break;
+		default:
+			break;
+		}
 
-	return ret;
+		dev->nr_zones_exp_open++;
+
+		spin_unlock(&dev->zone_res_lock);
+	}
+
+	zone->cond = BLK_ZONE_COND_EXP_OPEN;
+
+	return BLK_STS_OK;
 }
 
 static blk_status_t null_close_zone(struct nullb_device *dev,
 				    struct nullb_zone *zone)
 {
-	blk_status_t ret;
-
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
-	null_lock_zone_res(dev);
-	ret = __null_close_zone(dev, zone);
-	null_unlock_zone_res(dev);
+	switch (zone->cond) {
+	case BLK_ZONE_COND_CLOSED:
+		/* close operation on closed is not an error */
+		return BLK_STS_OK;
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+		break;
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_FULL:
+	default:
+		return BLK_STS_IOERR;
+	}
+
+	if (dev->need_zone_res_mgmt) {
+		spin_lock(&dev->zone_res_lock);
 
-	return ret;
+		switch (zone->cond) {
+		case BLK_ZONE_COND_IMP_OPEN:
+			dev->nr_zones_imp_open--;
+			break;
+		case BLK_ZONE_COND_EXP_OPEN:
+			dev->nr_zones_exp_open--;
+			break;
+		default:
+			break;
+		}
+
+		if (zone->wp > zone->start)
+			dev->nr_zones_closed++;
+
+		spin_unlock(&dev->zone_res_lock);
+	}
+
+	if (zone->wp == zone->start)
+		zone->cond = BLK_ZONE_COND_EMPTY;
+	else
+		zone->cond = BLK_ZONE_COND_CLOSED;
+
+	return BLK_STS_OK;
 }
 
 static blk_status_t null_finish_zone(struct nullb_device *dev,
@@ -525,41 +539,47 @@ static blk_status_t null_finish_zone(struct nullb_device *dev,
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
-	null_lock_zone_res(dev);
+	if (dev->need_zone_res_mgmt) {
+		spin_lock(&dev->zone_res_lock);
 
-	switch (zone->cond) {
-	case BLK_ZONE_COND_FULL:
-		/* finish operation on full is not an error */
-		goto unlock;
-	case BLK_ZONE_COND_EMPTY:
-		ret = null_check_zone_resources(dev, zone);
-		if (ret != BLK_STS_OK)
-			goto unlock;
-		break;
-	case BLK_ZONE_COND_IMP_OPEN:
-		dev->nr_zones_imp_open--;
-		break;
-	case BLK_ZONE_COND_EXP_OPEN:
-		dev->nr_zones_exp_open--;
-		break;
-	case BLK_ZONE_COND_CLOSED:
-		ret = null_check_zone_resources(dev, zone);
-		if (ret != BLK_STS_OK)
-			goto unlock;
-		dev->nr_zones_closed--;
-		break;
-	default:
-		ret = BLK_STS_IOERR;
-		goto unlock;
+		switch (zone->cond) {
+		case BLK_ZONE_COND_FULL:
+			/* Finish operation on full is not an error */
+			spin_unlock(&dev->zone_res_lock);
+			return BLK_STS_OK;
+		case BLK_ZONE_COND_EMPTY:
+			ret = null_check_zone_resources(dev, zone);
+			if (ret != BLK_STS_OK) {
+				spin_unlock(&dev->zone_res_lock);
+				return ret;
+			}
+			break;
+		case BLK_ZONE_COND_IMP_OPEN:
+			dev->nr_zones_imp_open--;
+			break;
+		case BLK_ZONE_COND_EXP_OPEN:
+			dev->nr_zones_exp_open--;
+			break;
+		case BLK_ZONE_COND_CLOSED:
+			ret = null_check_zone_resources(dev, zone);
+			if (ret != BLK_STS_OK) {
+				spin_unlock(&dev->zone_res_lock);
+				return ret;
+			}
+			dev->nr_zones_closed--;
+			break;
+		default:
+			spin_unlock(&dev->zone_res_lock);
+			return BLK_STS_IOERR;
+		}
+
+		spin_unlock(&dev->zone_res_lock);
 	}
 
 	zone->cond = BLK_ZONE_COND_FULL;
 	zone->wp = zone->start + zone->len;
 
-unlock:
-	null_unlock_zone_res(dev);
-
-	return ret;
+	return BLK_STS_OK;
 }
 
 static blk_status_t null_reset_zone(struct nullb_device *dev,
@@ -568,34 +588,33 @@ static blk_status_t null_reset_zone(struct nullb_device *dev,
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return BLK_STS_IOERR;
 
-	null_lock_zone_res(dev);
+	if (dev->need_zone_res_mgmt) {
+		spin_lock(&dev->zone_res_lock);
 
-	switch (zone->cond) {
-	case BLK_ZONE_COND_EMPTY:
-		/* reset operation on empty is not an error */
-		null_unlock_zone_res(dev);
-		return BLK_STS_OK;
-	case BLK_ZONE_COND_IMP_OPEN:
-		dev->nr_zones_imp_open--;
-		break;
-	case BLK_ZONE_COND_EXP_OPEN:
-		dev->nr_zones_exp_open--;
-		break;
-	case BLK_ZONE_COND_CLOSED:
-		dev->nr_zones_closed--;
-		break;
-	case BLK_ZONE_COND_FULL:
-		break;
-	default:
-		null_unlock_zone_res(dev);
-		return BLK_STS_IOERR;
+		switch (zone->cond) {
+		case BLK_ZONE_COND_IMP_OPEN:
+			dev->nr_zones_imp_open--;
+			break;
+		case BLK_ZONE_COND_EXP_OPEN:
+			dev->nr_zones_exp_open--;
+			break;
+		case BLK_ZONE_COND_CLOSED:
+			dev->nr_zones_closed--;
+			break;
+		case BLK_ZONE_COND_EMPTY:
+		case BLK_ZONE_COND_FULL:
+			break;
+		default:
+			spin_unlock(&dev->zone_res_lock);
+			return BLK_STS_IOERR;
+		}
+
+		spin_unlock(&dev->zone_res_lock);
 	}
 
 	zone->cond = BLK_ZONE_COND_EMPTY;
 	zone->wp = zone->start;
 
-	null_unlock_zone_res(dev);
-
 	if (dev->memory_backed)
 		return null_handle_discard(dev, zone->start, zone->len);
 
-- 
2.44.0

