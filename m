Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE9B2609E3
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689141; cv=none; b=bGEMUmoNXSAtELMcKyHaBFCRWoGJb094/KTPlU6bXx1KbEYqzgj61bDt4497r+BLEsarDdxfkWy8+wCzxtK0hj0I1BcZTK18ZNo+c2+qSq1kydz8GtcTIz8p/NDnZApLDgdKNcBY4yRkU4ZUfYCXC7hzmqQJHDp+pSw5gnAvoVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689141; c=relaxed/simple;
	bh=vKSI7k94BOHDPtyfyCxkWUG5yO4+GUEzI+A4F84+pZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yrtrkbr/AvweE/UlpGDU9Swp6/VFIN+D9NMoML76AhZmtIx5ooyBSE16nFLJhs9zI9UOE6fF7ncFT35qBIHLhl4pBIarIGtKb5w6JLb/Xqi9vYmlmd+iyf/pn1BgPToi8xYlZEIac1WU8xQtnMpDwx83dAvRUND5c/4mzjkoTLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4VR6KG5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4VR6KG5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DE41F000E9;
	Fri, 14 Aug 2026 06:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786689139;
	bh=XeNYh1ILA19LwSVdS9tDEAozh48sbDa8mreBOIXiYc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U4VR6KG5uAUHB9LP25ODlhdzgPKPNX+qDrnK0Q/Q3hHYU/eLXEns4GzrOXTOaH2RH
	 OyEM/bevdCpkv8AOfHPWMyuw0zaG6XXQIml1L7xciQMWqTIwPfqZ9Zb2lhf4sHp1Q7
	 1AAAv4iVGx9Qpgc/x3kZePWCI5CoPMGKTXlR/uszkxrON5GYIpyMZa2RMk9/4aF5Gd
	 KxLwWdBAsy5KDjBF7Crmmqm2I4WYI2Gys/GqBshlPUrVLhQyrgbKUL6fHkjeNg/sPA
	 nzH5GVBy86vFa9hYlwyLaH+XlK1JtiXkebkCrveDi6Lt58sLBBc3Rmu5EE7tqG9H0C
	 Z+B+yGuBlhrJw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 08/13] block: propagate readonly and offline conditions to zone write plugs
Date: Fri, 14 Aug 2026 15:31:56 +0900
Message-ID: <20260814063201.1762743-9-dlemoal@kernel.org>
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

When revalidating the zones of a zoned block device, or when handling a
zone which has a zone write plug flagged with
BLK_ZONE_WPLUG_NEED_WP_UPDATE, the function
disk_zone_wplug_sync_wp_offset() is used to update the write pointer
offset of a zone write plug. However, this does not take into account the
condition of the zone, which may have changed to readonly or offline,
which in itself will always cause errors.

In order to catch such errors, rename disk_zone_wplug_sync_wp_offset() to
disk_zone_wplug_sync_state() and in addition to the zone write pointer,
also update the zone write plug condition if the zone is readonly or
offline.

This change also requires changes to how a reset all zones operation
(REQ_OP_ZONE_RESET_ALL) is handled so that the offline or read-only
condition of zone write plugs is not overwritten with an erroneous empty
condition. To do so, introduce the helper function
disk_zone_is_offline_or_readonly() to skip updating the condition of zones
that are read-only or offline and that do not have a zone write plug.
For zones that have a zone write plug, the helper function
disk_zone_wplug_is_offline_or_readonly() is used in
disk_zone_wplug_set_wp_offset() to not update a zone write plug write
pointer and condition for read-only and offline zones.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 block/blk-zoned.c | 55 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index b153bed9d576..28fcf37dba0b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -277,6 +277,29 @@ static inline u8 disk_zone_get_state(struct gendisk *disk, sector_t sector)
 	return zs;
 }
 
+static enum blk_zone_cond disk_zone_get_cond(struct gendisk *disk,
+					     sector_t sector)
+{
+	u8 zs = disk_zone_get_state(disk, sector);
+
+	return blk_zstate_to_zone_cond(zs);
+}
+
+static inline bool
+disk_zone_cond_is_offline_or_readonly(enum blk_zone_cond cond)
+{
+	return cond == BLK_ZONE_COND_READONLY ||
+		cond == BLK_ZONE_COND_OFFLINE;
+}
+
+static inline bool disk_zone_is_offline_or_readonly(struct gendisk *disk,
+						    sector_t sector)
+{
+	enum blk_zone_cond cond = disk_zone_get_cond(disk, sector);
+
+	return disk_zone_cond_is_offline_or_readonly(cond);
+}
+
 static bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
 {
 	u8 zs = disk_zone_get_state(disk, sector);
@@ -587,6 +610,11 @@ static bool disk_zone_wplug_is_full(struct gendisk *disk,
 	return zwplug->wp_offset >= disk->last_zone_capacity;
 }
 
+static bool disk_zone_wplug_is_offline_or_readonly(struct blk_zone_wplug *zwplug)
+{
+	return disk_zone_cond_is_offline_or_readonly(zwplug->cond);
+}
+
 static bool disk_insert_zone_wplug(struct gendisk *disk,
 				   struct blk_zone_wplug *zwplug)
 {
@@ -893,8 +921,10 @@ static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 
 	/* Update the zone write pointer and abort all plugged BIOs. */
 	zwplug->flags &= ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
-	zwplug->wp_offset = wp_offset;
-	disk_zone_wplug_update_cond(disk, zwplug);
+	if (!disk_zone_wplug_is_offline_or_readonly(zwplug)) {
+		zwplug->wp_offset = wp_offset;
+		disk_zone_wplug_update_cond(disk, zwplug);
+	}
 
 	disk_zone_wplug_abort(zwplug);
 	if (!zwplug->wp_offset || disk_zone_wplug_is_full(disk, zwplug))
@@ -924,8 +954,8 @@ static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
 	}
 }
 
-static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
-						   struct blk_zone *zone)
+static unsigned int disk_zone_wplug_sync_state(struct gendisk *disk,
+					       struct blk_zone *zone)
 {
 	struct blk_zone_wplug *zwplug;
 	unsigned int wp_offset = blk_zone_wp_offset(zone);
@@ -935,6 +965,11 @@ static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
 		unsigned long flags;
 
 		spin_lock_irqsave(&zwplug->lock, flags);
+		if (disk_zone_cond_is_offline_or_readonly(zone->cond)) {
+			zwplug->flags &= ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
+			zwplug->cond = zone->cond;
+			zwplug->wp_offset = UINT_MAX;
+		}
 		if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
 			disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
 		spin_unlock_irqrestore(&zwplug->lock, flags);
@@ -979,7 +1014,7 @@ int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
 	}
 
 	if (disk->zone_wplugs_hash)
-		disk_zone_wplug_sync_wp_offset(disk, zone);
+		disk_zone_wplug_sync_state(disk, zone);
 
 	if (args && args->cb)
 		return args->cb(zone, idx, args->data);
@@ -1100,8 +1135,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	else
 		zone->capacity = disk->zone_capacity;
 
-	if (zone->cond == BLK_ZONE_COND_READONLY ||
-	    zone->cond == BLK_ZONE_COND_OFFLINE) {
+	if (disk_zone_cond_is_offline_or_readonly(zone->cond)) {
 		zone->wp = ULLONG_MAX;
 		return 0;
 	}
@@ -1240,8 +1274,11 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 
 	/* Update the cached zone conditions. */
 	for (sector = 0; sector < get_capacity(disk);
-	     sector += bdev_zone_sectors(bio->bi_bdev))
+	     sector += bdev_zone_sectors(bio->bi_bdev)) {
+		if (disk_zone_is_offline_or_readonly(disk, sector))
+			continue;
 		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
+	}
 	clear_bit(GD_ZONE_APPEND_USED, &disk->state);
 }
 
@@ -2365,7 +2402,7 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	if (!disk->zone_wplugs_hash)
 		return 0;
 
-	wp_offset = disk_zone_wplug_sync_wp_offset(disk, zone);
+	wp_offset = disk_zone_wplug_sync_state(disk, zone);
 	if (!wp_offset || wp_offset >= zone->capacity)
 		return 0;
 
-- 
2.55.0

