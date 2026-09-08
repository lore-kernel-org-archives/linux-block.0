Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94DB4B5CA2
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857904; cv=none; b=uM4NZ05p0nAfHuPohYkCV8s60/2o/A79thRmvS+AfLyxWQ5i8QrAc3mVInebqjdShWiJuXdxY1zoAh0MuYB0AqO+J23QVlWPPUZ/DeJIDv7e5jwVS/Sqgz6deY2eNdidijfbh0Okzr9RPrzWbpnwvFLmefT6Sn0MDYumxeC5IWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857904; c=relaxed/simple;
	bh=/2iKqz9kJXakjOKHn3Nl7VInwFNfoxN3EiJJkGOAZFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbudhG46WcP1MBUbJ5tRKGlRgh2vWvHi26d57xGCRz0WrKLnEZ1Pr7jJueIo0aNeeN8vc5gok/kMB5XhefDFUynpYXdgOTnzP0s0RiYNjRCzChvHhndEt7Yk0TGyqS6sFZQ6G6//pJD6MB/mL4PewnzKzyENcPWj3+DWGkF3GLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAo55wo3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAo55wo3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B021F00ADF;
	Tue,  8 Sep 2026 08:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857885;
	bh=1ngOYIUWF5cLCp3hHnJnX5cTRfWTW7zyNsk9ZVJWwrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eAo55wo36vi4DklGwn+vEhwEP7Fn7S48zOlG4h2hZGVAWffhz/so1F5GY3BGyIj9E
	 6VnvEqy6RUm5gXbX0aM919ErvQUeg8O05x0dcSJ9nhMKk2W7HxiXs1JFn/Ddx2g3MS
	 V8KPP+sT/ujkTjlzzeMDCWPsQNIQh7yw9mfLjBZCAm4kuxoVWgXvTQQH+RJAFGWXQf
	 NjwZC8hOd0Fu0fbkKAk6CbIgyX7/nnueKY2j9MiSCavQVVcRLiZaElvADIOYw+ukGV
	 8/dPshcig2cy3prxgswSJNtWpyddYhvRxUmuZfOkHWWGqK6+Ui82Cola+3yxHEnkyQ
	 Fwm7HuDTvY8Jw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 12/16] block: propagate readonly and offline conditions to zone write plugs
Date: Tue,  8 Sep 2026 17:57:41 +0900
Message-ID: <20260908085745.1082697-13-dlemoal@kernel.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 55 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 96e922b7a126..ac94ab32564b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -276,6 +276,29 @@ static inline u8 disk_zone_get_state(struct gendisk *disk, sector_t sector)
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
@@ -586,6 +609,11 @@ static bool disk_zone_wplug_is_full(struct gendisk *disk,
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
@@ -892,8 +920,10 @@ static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 
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
@@ -923,8 +953,8 @@ static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
 	}
 }
 
-static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
-						   struct blk_zone *zone)
+static unsigned int disk_zone_wplug_sync_state(struct gendisk *disk,
+					       struct blk_zone *zone)
 {
 	struct blk_zone_wplug *zwplug;
 	unsigned int wp_offset = blk_zone_wp_offset(zone);
@@ -934,6 +964,11 @@ static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
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
@@ -978,7 +1013,7 @@ int disk_report_zone(struct gendisk *disk, struct blk_zone *zone,
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
@@ -1243,8 +1277,11 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 
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
 
@@ -2390,7 +2427,7 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	if (!disk->zone_wplugs_hash)
 		return 0;
 
-	wp_offset = disk_zone_wplug_sync_wp_offset(disk, zone);
+	wp_offset = disk_zone_wplug_sync_state(disk, zone);
 	if (!wp_offset || wp_offset >= zone->capacity)
 		return 0;
 
-- 
2.55.0

