Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4F23BD05
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896857; cv=none; b=DnLd1MF1O3iGV5Dqm+S5DZpdcWIEolko4/MsSbDyIBYbuN5TPXCDhn2fYuL5208SwXdUbtG5jKmDoTMhnxh1pL0KILIzOgaCwQBlohUgYGvLUdxXzKdy6CHr8M07APUklRkgMJp378djeRNLc/mSz2zGnDtK9usNSHaQBNCnQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896857; c=relaxed/simple;
	bh=XAjiGU60Qs4Wk7czp5IT6XuGzqrbloxYEvf6geChmTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OphklkCT2bgQGw4e5YFMZNWJuPZwuBVFG5QaEpsNRijvmR8fjePaccCxTE3IOnjL0xKh08/zyGtZTAUPlA39YEamgMJMnxYBTFgqrrOZ3X3t5Z4ZpXF3s8tpHqlxEUTwBwUbrRQ6leV4pmg2bY6wQnvvb5MpI87PaQfw8+Y6CFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R24rGZ+F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R24rGZ+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37CD1F00A3E;
	Wed,  5 Aug 2026 02:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896855;
	bh=tKQ/uqF2cVm2GCt+pI3PWwJGurZ74Y8mit/bHVwo/Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R24rGZ+F4Dsq9ZqlCoWgNT0TMstloBgmfHm3AHdCx7m4V2uIe7sN7TbPPtwyowomn
	 Zqj0XGTWE8DfmkzpNz25Qn83mpsokxcOXyLXd7hxIz1q68Q0TPMK1rAq9yUtWktUTi
	 WKdc2XfvdTp7Vp6/b5g5nN87tEa1ldvpibvwgUK+ajLcHaIf40JlWpJc9CBu0V3Cr2
	 hpv7clf5z7gBv3dBcpzGdSFzdVHogUKuWYi4rEOouoAS5f+RySx/gT8+HOowPVKdlG
	 DozjGhKchTQp+zFusPejbsco0D5ih+lUj1GerVLOdzi8fBtHTnHJ5zDxZW+EP/Lk3a
	 Qbgl3zQZefA6Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/14] block: remember a zone type regardless of its condition
Date: Wed,  5 Aug 2026 11:27:09 +0900
Message-ID: <20260805022719.735323-5-dlemoal@kernel.org>
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

Currently, bdev_zone_is_seq() identifies a sequential zone by looking at
the zone condition, assuming that any zone that does not have the
condition BLK_ZONE_COND_NOT_WP is a sequential write required zone. That
is correct only as long as the target zoned device does not support
storage element depopulation (aka HDD head depopulation), which is a
feature that can transition conventional zones to the read-only or offline
condition. For such device, we cannot distinguish anymore between
conventional and sequential zones using the zone condition as both zone
types can have the same conditions.

Prepare for fully supporting storage element depopulation and restoration
by caching the type of a zone in addition to its condition. This is
implemented by reformating the zones_cond array using a more compact zone
condition representation with the new enum blk_zstate. This zone condition
representation only uses the lower 4 bits of a byte for the condition
values, thus leaving the high order 4 bits of each byte entry of the
array for flags. The flag BLK_ZFLAG_CONV is defined to indicate
conventional zones.

The helper functions blk_zstate_to_zone_cond() and
blk_zone_cond_to_zstate() are implemented using lookup tables to convert
between enum blk_zone_condition values and enum blk_zstate zone condition
values. The helper blk_zstate_set() can be used to prepare a zones_state
entry for a disk with a zone condition and zone type flags. This helper is
used in disk_zone_set_cond() to update a zone condition.
bdev_zone_is_seq() is modified to use the flags of the zones_state array
entries to identify sequential zones. The zones_state array initialization
and revalidation is unchanged from the former zones_cond array.

Overall, any zone condition that is being considered outside of the
zones_state array always uses the enum blk_zone_condition values as
before, thus minimizing the number of changes.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 202 +++++++++++++++++++++++++++++------------
 include/linux/blkdev.h |   2 +-
 2 files changed, 143 insertions(+), 61 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index bfcd3cd99ec9..e5afef2bd7f1 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -39,6 +39,103 @@ static const char *const zone_cond_name[] = {
 };
 #undef ZONE_COND_NAME
 
+/*
+ * Internal and compact representation of enum blk_zone_cond values for zone
+ * conditions. All these values fit into 4-bits, allowing using the high order
+ * bits as the zone type.
+ */
+enum blk_zstate {
+	BLK_ZSTATE_NOT_WP	= 0x00,
+	BLK_ZSTATE_EMPTY	= 0x01,
+	BLK_ZSTATE_IMP_OPEN	= 0x02,
+	BLK_ZSTATE_EXP_OPEN	= 0x03,
+	BLK_ZSTATE_CLOSED	= 0x04,
+	BLK_ZSTATE_READONLY	= 0x05,
+	BLK_ZSTATE_FULL		= 0x06,
+	BLK_ZSTATE_OFFLINE	= 0x07,
+	BLK_ZSTATE_ACTIVE	= 0x08,
+
+	BLK_ZSTATE_COND_MASK	= 0x0F,
+
+	/* Conventional zone. */
+	BLK_ZFLAG_CONV		= 0x80,
+	BLK_ZSTATE_FLAGS_MASK	= ~BLK_ZSTATE_COND_MASK,
+};
+
+/*
+ * Lookup table and helper to convert enum blk_zstate conditions into enum
+ * blk_zone_condition values.
+ */
+static const u8 blk_zstate2zcond[] = {
+	[BLK_ZSTATE_NOT_WP]	= BLK_ZONE_COND_NOT_WP,
+	[BLK_ZSTATE_EMPTY]	= BLK_ZONE_COND_EMPTY,
+	[BLK_ZSTATE_IMP_OPEN]	= BLK_ZONE_COND_IMP_OPEN,
+	[BLK_ZSTATE_EXP_OPEN]	= BLK_ZONE_COND_EXP_OPEN,
+	[BLK_ZSTATE_CLOSED]	= BLK_ZONE_COND_CLOSED,
+	[BLK_ZSTATE_READONLY]	= BLK_ZONE_COND_READONLY,
+	[BLK_ZSTATE_FULL]	= BLK_ZONE_COND_FULL,
+	[BLK_ZSTATE_OFFLINE]	= BLK_ZONE_COND_OFFLINE,
+	[BLK_ZSTATE_ACTIVE]	= BLK_ZONE_COND_ACTIVE,
+};
+
+static inline enum blk_zone_cond blk_zstate_to_zone_cond(enum blk_zstate zs)
+{
+	u8 idx = zs & BLK_ZSTATE_COND_MASK;
+
+	if (WARN_ON(idx >= ARRAY_SIZE(blk_zstate2zcond)))
+		return 0;
+
+	return blk_zstate2zcond[idx];
+}
+
+/*
+ * Lookup table and helper to convert an enum blk_zone_condition into an enum
+ * blk_zstate condition value. To keep the lookup table small, the
+ * BLK_ZONE_COND_ACTIVE condition is not added and handled separately.
+ */
+static const u8 blk_zcond2zstate[] = {
+	[BLK_ZONE_COND_NOT_WP]		= BLK_ZSTATE_NOT_WP,
+	[BLK_ZONE_COND_EMPTY]		= BLK_ZSTATE_EMPTY,
+	[BLK_ZONE_COND_IMP_OPEN]	= BLK_ZSTATE_ACTIVE,
+	[BLK_ZONE_COND_EXP_OPEN]	= BLK_ZSTATE_ACTIVE,
+	[BLK_ZONE_COND_CLOSED]		= BLK_ZSTATE_ACTIVE,
+	[BLK_ZONE_COND_READONLY]	= BLK_ZSTATE_READONLY,
+	[BLK_ZONE_COND_FULL]		= BLK_ZSTATE_FULL,
+	[BLK_ZONE_COND_OFFLINE]		= BLK_ZSTATE_OFFLINE,
+};
+
+static inline enum blk_zstate blk_zone_cond_to_zstate(enum blk_zone_cond cond)
+{
+	if (cond == BLK_ZONE_COND_ACTIVE)
+		return BLK_ZSTATE_ACTIVE;
+
+	if (WARN_ON(cond >= ARRAY_SIZE(blk_zcond2zstate)))
+		return 0;
+
+	return blk_zcond2zstate[cond];
+}
+
+/*
+ * Combine an enum blk_zone_condition and zone flags into a zones_state array
+ * entry.
+ */
+static inline void blk_zstate_set(u8 *zones_state, unsigned int zno,
+				  enum blk_zone_cond cond, u8 flags)
+{
+	if (zones_state)
+		zones_state[zno] = flags | blk_zone_cond_to_zstate(cond);
+}
+
+static inline u8 blk_zstate_flags(enum blk_zstate zs)
+{
+	return zs & BLK_ZSTATE_FLAGS_MASK;
+}
+
+static inline bool blk_zstate_is_conv(enum blk_zstate zs)
+{
+	return blk_zstate_flags(zs) & BLK_ZFLAG_CONV;
+}
+
 /*
  * Per-zone write plug.
  * @node: hlist_node structure for managing the plug using a hash table.
@@ -135,37 +232,14 @@ const char *blk_zone_cond_str(enum blk_zone_cond zone_cond)
 }
 EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 
-static void blk_zone_set_cond(u8 *zones_cond, unsigned int zno,
-			      enum blk_zone_cond cond)
-{
-	if (!zones_cond)
-		return;
-
-	switch (cond) {
-	case BLK_ZONE_COND_IMP_OPEN:
-	case BLK_ZONE_COND_EXP_OPEN:
-	case BLK_ZONE_COND_CLOSED:
-		zones_cond[zno] = BLK_ZONE_COND_ACTIVE;
-		return;
-	case BLK_ZONE_COND_NOT_WP:
-	case BLK_ZONE_COND_EMPTY:
-	case BLK_ZONE_COND_FULL:
-	case BLK_ZONE_COND_OFFLINE:
-	case BLK_ZONE_COND_READONLY:
-	default:
-		zones_cond[zno] = cond;
-		return;
-	}
-}
-
 static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
 			       enum blk_zone_cond cond)
 {
-	u8 *zones_cond;
+	u8 *zones_state;
 
 	rcu_read_lock();
-	zones_cond = rcu_dereference(disk->zones_cond);
-	if (zones_cond) {
+	zones_state = rcu_dereference(disk->zones_state);
+	if (zones_state) {
 		unsigned int zno = disk_zone_no(disk, sector);
 
 		/*
@@ -173,13 +247,14 @@ static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
 		 * never changes, so do nothing if the target zone is in one of
 		 * these conditions.
 		 */
-		switch (zones_cond[zno]) {
-		case BLK_ZONE_COND_NOT_WP:
-		case BLK_ZONE_COND_READONLY:
-		case BLK_ZONE_COND_OFFLINE:
+		switch (zones_state[zno] & BLK_ZSTATE_COND_MASK) {
+		case BLK_ZSTATE_NOT_WP:
+		case BLK_ZSTATE_READONLY:
+		case BLK_ZSTATE_OFFLINE:
 			break;
 		default:
-			blk_zone_set_cond(zones_cond, zno, cond);
+			blk_zstate_set(zones_state, zno, cond,
+				       blk_zstate_flags(zones_state[zno]));
 			break;
 		}
 	}
@@ -198,15 +273,15 @@ bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
 	struct gendisk *disk = bdev->bd_disk;
 	unsigned int zno = disk_zone_no(disk, sector);
 	bool is_seq = false;
-	u8 *zones_cond;
+	u8 *zones_state;
 
 	if (!bdev_is_zoned(bdev))
 		return false;
 
 	rcu_read_lock();
-	zones_cond = rcu_dereference(disk->zones_cond);
-	if (zones_cond && zno < disk->nr_zones)
-		is_seq = zones_cond[zno] != BLK_ZONE_COND_NOT_WP;
+	zones_state = rcu_dereference(disk->zones_state);
+	if (zones_state && zno < disk->nr_zones)
+		is_seq = !blk_zstate_is_conv(zones_state[zno]);
 	rcu_read_unlock();
 
 	return is_seq;
@@ -505,7 +580,7 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 {
 	struct blk_zone_wplug *zwplg;
 	unsigned long flags;
-	u8 *zones_cond;
+	u8 *zones_state;
 	unsigned int idx =
 		hash_32(zwplug->zone_no, disk->zone_wplugs_hash_bits);
 
@@ -524,15 +599,16 @@ static bool disk_insert_zone_wplug(struct gendisk *disk,
 	}
 
 	/*
-	 * Set the zone condition: if we do not yet have a zones_cond array
+	 * Set the zone condition: if we do not yet have a zones_state array
 	 * attached to the disk, then this is a zone write plug insert from the
 	 * first call to blk_revalidate_disk_zones(), in which case the zone is
 	 * necessarilly in the active condition.
 	 */
-	zones_cond = rcu_dereference_check(disk->zones_cond,
+	zones_state = rcu_dereference_check(disk->zones_state,
 				lockdep_is_held(&disk->zone_wplugs_hash_lock));
-	if (zones_cond)
-		zwplug->cond = zones_cond[zwplug->zone_no];
+	if (zones_state)
+		zwplug->cond =
+			blk_zstate_to_zone_cond(zones_state[zwplug->zone_no]);
 	else
 		zwplug->cond = BLK_ZONE_COND_ACTIVE;
 
@@ -592,9 +668,9 @@ static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
 	WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
 
 	spin_lock_irqsave(&disk->zone_wplugs_hash_lock, flags);
-	blk_zone_set_cond(rcu_dereference_check(disk->zones_cond,
+	blk_zstate_set(rcu_dereference_check(disk->zones_state,
 				lockdep_is_held(&disk->zone_wplugs_hash_lock)),
-			  zwplug->zone_no, zwplug->cond);
+		       zwplug->zone_no, zwplug->cond, 0);
 	hlist_del_init_rcu(&zwplug->node);
 	atomic_dec(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
@@ -940,7 +1016,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	sector_t zone_sectors = bdev_zone_sectors(bdev);
 	struct blk_zone_wplug *zwplug;
 	unsigned long flags;
-	u8 *zones_cond;
+	u8 *zones_state, zs;
 
 	if (!bdev_is_zoned(bdev))
 		return -EOPNOTSUPP;
@@ -955,12 +1031,18 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 		return blkdev_report_zone_fallback(bdev, sector, zone);
 
 	rcu_read_lock();
-	zones_cond = rcu_dereference(disk->zones_cond);
-	if (!disk->zone_wplugs_hash || !zones_cond) {
+	zones_state = rcu_dereference(disk->zones_state);
+	if (!disk->zone_wplugs_hash || !zones_state) {
 		rcu_read_unlock();
 		return blkdev_report_zone_fallback(bdev, sector, zone);
 	}
-	zone->cond = zones_cond[disk_zone_no(disk, sector)];
+
+	zs = zones_state[disk_zone_no(disk, sector)];
+	zone->cond = blk_zstate_to_zone_cond(zs);
+	if (blk_zstate_is_conv(zs))
+		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
+	else
+		zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 	rcu_read_unlock();
 
 	zone->start = sector;
@@ -970,8 +1052,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	 * If this is a conventional zone, we do not have a zone write plug and
 	 * can report the zone immediately.
 	 */
-	if (zone->cond == BLK_ZONE_COND_NOT_WP) {
-		zone->type = BLK_ZONE_TYPE_CONVENTIONAL;
+	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		zone->capacity = zone_sectors;
 		zone->wp = ULLONG_MAX;
 		return 0;
@@ -982,7 +1063,6 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	 * offline, only set the zone write pointer to an invalid value and
 	 * report the zone.
 	 */
-	zone->type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 	if (disk_zone_is_last(disk, zone))
 		zone->capacity = disk->last_zone_capacity;
 	else
@@ -1974,16 +2054,16 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	disk->zone_wplugs_pool = NULL;
 }
 
-static void disk_set_zones_cond_array(struct gendisk *disk, u8 *zones_cond)
+static void disk_set_zones_state_array(struct gendisk *disk, u8 *zones_state)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&disk->zone_wplugs_hash_lock, flags);
-	zones_cond = rcu_replace_pointer(disk->zones_cond, zones_cond,
+	zones_state = rcu_replace_pointer(disk->zones_state, zones_state,
 				lockdep_is_held(&disk->zone_wplugs_hash_lock));
 	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
 
-	kfree_rcu_mightsleep(zones_cond);
+	kfree_rcu_mightsleep(zones_state);
 }
 
 void disk_release_zone_resources(struct gendisk *disk)
@@ -2001,7 +2081,7 @@ void disk_release_zone_resources(struct gendisk *disk)
 
 	disk_destroy_zone_wplugs_hash_table(disk);
 
-	disk_set_zones_cond_array(disk, NULL);
+	disk_set_zones_state_array(disk, NULL);
 	disk->zone_capacity = 0;
 	disk->last_zone_capacity = 0;
 	disk->nr_zones = 0;
@@ -2009,7 +2089,7 @@ void disk_release_zone_resources(struct gendisk *disk)
 
 struct blk_revalidate_zone_args {
 	struct gendisk	*disk;
-	u8		*zones_cond;
+	u8		*zones_state;
 	unsigned int	nr_zones;
 	unsigned int	nr_conv_zones;
 	unsigned int	zone_capacity;
@@ -2024,8 +2104,8 @@ static int disk_init_revalidate_args(struct gendisk *disk,
 	args->nr_zones = disk_get_nr_zones(disk);
 
 	/* Cached zone conditions: 1 byte per zone */
-	args->zones_cond = kzalloc(args->nr_zones, GFP_NOIO);
-	if (!args->zones_cond)
+	args->zones_state = kzalloc(args->nr_zones, GFP_NOIO);
+	if (!args->zones_state)
 		return -ENOMEM;
 
 	return 0;
@@ -2064,8 +2144,8 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
 	disk->last_zone_capacity = args->last_zone_capacity;
-	disk_set_zones_cond_array(disk, args->zones_cond);
-	args->zones_cond = NULL;
+	disk_set_zones_state_array(disk, args->zones_state);
+	args->zones_state = NULL;
 
 	/*
 	 * Some devices can advertise zone resource limits that are larger than
@@ -2114,12 +2194,14 @@ static int blk_revalidate_zone_cond(struct blk_zone *zone, unsigned int idx,
 				    struct blk_revalidate_zone_args *args)
 {
 	enum blk_zone_cond cond = zone->cond;
+	u8 flags = 0;
 
 	/* Check that the zone condition is consistent with the zone type. */
 	switch (cond) {
 	case BLK_ZONE_COND_NOT_WP:
 		if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
 			goto invalid_condition;
+		flags = BLK_ZFLAG_CONV;
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
@@ -2137,7 +2219,7 @@ static int blk_revalidate_zone_cond(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
-	blk_zone_set_cond(args->zones_cond, idx, cond);
+	blk_zstate_set(args->zones_state, idx, cond, flags);
 
 	return 0;
 
@@ -2363,7 +2445,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 free_args:
 	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
 
-	kfree(args.zones_cond);
+	kfree(args.zones_state);
 
 	return ret;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 20cb8ed7d987..4fa00757527d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -200,7 +200,7 @@ struct gendisk {
 	unsigned int		nr_zones;
 	unsigned int		zone_capacity;
 	unsigned int		last_zone_capacity;
-	u8 __rcu		*zones_cond;
+	u8 __rcu		*zones_state;
 	unsigned int		zone_wplugs_hash_bits;
 	atomic_t		nr_zone_wplugs;
 	spinlock_t		zone_wplugs_hash_lock;
-- 
2.55.0

