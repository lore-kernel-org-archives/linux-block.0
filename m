Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE1F4B1B3D
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857904; cv=none; b=Gcj4VhjoakSBa1MzceztTHpDq+m/+rBdsJDSLEnj1ItTTL42LVsOX5fV/SqEBEqtnhvE2Sr2uIdb6xauHH3oPWeQq4tl8FFKSxT5l8Cm1kAB1DVMdEBhJUMTHCX2TwIUhwRcNQ0Y9EryDtgIr1JrPvyBHtt5zaIQvwsBbdojXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857904; c=relaxed/simple;
	bh=QHklt4vZrxkmSFQTuhZeKh5uxQt3Tw1/diTjWMc/Sf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlXP3et0jwxDR0KJ9FgyBDe9V5tzeRn0QrPt7e2CHhqfAwC875AC3RjNJC+EbJf3NEQa0phgplTZ6CmL6xyy6xSHR0ezvCdNWclK+PBIVPkLMqJIuV6WCc0jx1NJZVEZ372PgqHHMxZKBmrqAj9e9Yv4csyKInB8hc2BmoI4f5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXqSFEhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXqSFEhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450DC1F00A3A;
	Tue,  8 Sep 2026 08:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857888;
	bh=gLueg33ySYwnEbPvT81yPC+hRNTKTRUuWuopNve3COo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hXqSFEhrwNkNbmCzWOVvWTmK+8X0hAo6vn2HgjVEm4aVRUS9g0KmAHeMJS83Nealx
	 wlH7PqpilHBLpuzZMTnCaFvMyRufXGfjtUaqc3eWJc1xWFR2kGUNGoWARc/DRHJ2sL
	 +UqJgnAfZyJruyopry8qE4f/+9FXaX5x0ZUtGuMjdFu8/bgYWjeXMbKdapVON4P8Qf
	 /rONMzEpDMddKAWHvBnqDIYN7zqMJLtHWDl4akl/DJg7d7ekNWThH+LD7LFlzPJdNF
	 cT4RNOs4aET/unCoU5F0rz4aEVqcLYm3xN4GuVuiwIj8BJc/p+zTVO31XTFyz+RBdg
	 H/0Tebq3URcaw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 16/16] block: simplify disk_zone_set_cond()
Date: Tue,  8 Sep 2026 17:57:45 +0900
Message-ID: <20260908085745.1082697-17-dlemoal@kernel.org>
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

disk_zone_set_cond() is used to set a zone condition afer a reset, a
finish or a reset all operation. For a single zone reset or finish, we are
guaranteed that the target zone is a sequential one that is not offline
nor read-only (otherwise, the operation would have failed). For a reset
all operation, there is no point in calling this function for offline and
read-only zones since the condition checks in disk_zone_set_cond() will
result in nothing being done.

Simplify all this using disk_zone_is_offline_or_readonly() in
blk_zone_reset_all_bio_endio() to skip zones that are offline or
read-only. This change allows simplifying disk_zone_set_cond() by removing
the zone condition checks. This change is also consistent with the fact
that conventional zones can now have the offline or read-only condition.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 block/blk-zoned.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 2a8e573034b3..ec510d66dfe2 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -240,23 +240,9 @@ static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
 
 	rcu_read_lock();
 	zones_state = rcu_dereference(disk->zones_state);
-	if (zones_state && zno < disk->nr_zones) {
-		/*
-		 * The condition of a conventional, readonly and offline zones
-		 * never changes, so do nothing if the target zone is in one of
-		 * these conditions.
-		 */
-		switch (zones_state[zno] & BLK_ZSTATE_COND_MASK) {
-		case BLK_ZSTATE_NOT_WP:
-		case BLK_ZSTATE_READONLY:
-		case BLK_ZSTATE_OFFLINE:
-			break;
-		default:
-			blk_zstate_set(zones_state, disk->nr_zones, zno, cond,
-				       blk_zstate_flags(zones_state[zno]));
-			break;
-		}
-	}
+	if (likely(zones_state && zno < disk->nr_zones))
+		blk_zstate_set(zones_state, disk->nr_zones, zno, cond,
+			       blk_zstate_flags(zones_state[zno]));
 	rcu_read_unlock();
 }
 
@@ -1310,7 +1296,8 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 	/* Update the cached zone conditions. */
 	for (sector = 0; sector < get_capacity(disk);
 	     sector += bdev_zone_sectors(bio->bi_bdev)) {
-		if (disk_zone_is_offline_or_readonly(disk, sector))
+		if (!disk_zone_is_seq(disk, sector) ||
+		    disk_zone_is_offline_or_readonly(disk, sector))
 			continue;
 		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
 	}
-- 
2.55.0

