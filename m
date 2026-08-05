Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE13C1405
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896860; cv=none; b=F9FSZmspoAXx5RgaG41HZCmu7gQX7f7dbQEAZz+dief2Fg00YTpIvMwyT5Q1G8AnQedqoPutgAXjdQq3SVd/tABJPIB+8uZA0tdXwJr2CUPiK7slQEIWvLBMFrouBBPDKKh2I2xIP1xNWSmUZnRfIw7sP0d0/2y92cF4cN1wc5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896860; c=relaxed/simple;
	bh=tBTHhKZjbh50xdkpu0fNJkWbo/sVZQmITp5XkVsMC8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gidH0TwOWnB7FfvxCT7J2xcn8oDFN5bbwHj/xtwp3iKeMfTJ/vDxC1hxegZa7JAN/lIb68UIGAM9i9vzm4vfXPYWoZ+CWMcL59Zy9nE4dtIJYlyx2SxcvnmJL5pi2CJG8Kh3ec0cOPzCkGK5SWUmBuXDPRauirekSeQZ9wtt0eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzneJHy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzneJHy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFD91F00A3A;
	Wed,  5 Aug 2026 02:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896859;
	bh=SS2kJ90r8KgS8IotRGFkqkMWP1s7+ng/KJB3t3/xyj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NzneJHy8uKE4zODGsLURWt1U1wk8jCIwlVAT2dPiIfXg9aVqGZjrXGJTcLTigijBT
	 PGVtdpYefy9YFSHKykoSP+NN2e/XbzlPwGse5hmxmi54CbwSgJuqM4yJmfwvlE1v69
	 Kwvi5iZHAm2agC9yGKJWKp3/QjzSbiD5j6CWZMjZ8XVVZRhoC2PaNnqQgUKjIK1zVV
	 DLcA1Kc36JBu5s5LqlibGp5fCgEZVs5bMtZ5vyB/Z9tzJOkQ4D4zAvmHQuNcOgqNt3
	 SG0zOpp1++aHOD86IJPfaiq4Rm7ix460suGJNa7DZ0StyhXe0cS3YdLz3ceUM7QGp6
	 MXcehq14TU8Sg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 08/14] block: propagate readonly and offline conditions to zone write plugs
Date: Wed,  5 Aug 2026 11:27:13 +0900
Message-ID: <20260805022719.735323-9-dlemoal@kernel.org>
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
---
 block/blk-zoned.c | 52 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f065febbae97..1560b000fb08 100644
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
@@ -937,6 +967,8 @@ static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
 		spin_lock_irqsave(&zwplug->lock, flags);
 		if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
 			disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
+		if (disk_zone_cond_is_offline_or_readonly(zone->cond))
+			zwplug->cond = zone->cond;
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
 	}
@@ -979,7 +1011,7 @@ int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
 	}
 
 	if (disk->zone_wplugs_hash)
-		disk_zone_wplug_sync_wp_offset(disk, zone);
+		disk_zone_wplug_sync_state(disk, zone);
 
 	if (args && args->cb)
 		return args->cb(zone, idx, args->data);
@@ -1100,8 +1132,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	else
 		zone->capacity = disk->zone_capacity;
 
-	if (zone->cond == BLK_ZONE_COND_READONLY ||
-	    zone->cond == BLK_ZONE_COND_OFFLINE) {
+	if (disk_zone_cond_is_offline_or_readonly(zone->cond)) {
 		zone->wp = ULLONG_MAX;
 		return 0;
 	}
@@ -1240,8 +1271,11 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 
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
 
@@ -2356,7 +2390,7 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	if (!disk->zone_wplugs_hash)
 		return 0;
 
-	wp_offset = disk_zone_wplug_sync_wp_offset(disk, zone);
+	wp_offset = disk_zone_wplug_sync_state(disk, zone);
 	if (!wp_offset || wp_offset >= zone->capacity)
 		return 0;
 
-- 
2.55.0

