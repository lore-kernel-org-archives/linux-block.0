Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892A2BE03C
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157309; cv=none; b=p3r3c70VdnQhduv7OzmrUQ5fD/jwB8g0uecioX1T+QN63o1+uoS/DczP2xr1TYx7NGLvGiJU6jxNJm5LecWMEJJbm6ZoJ3UUSqaVFhRTg2Uhl5JpsZk9OYnY0YYqDKG2rsdB26fBtHAlX8AzZRZQcFMv+kcjdPaM8LubBcAG4kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157309; c=relaxed/simple;
	bh=4Y5raiBqBVFtFc8TNULm1ZXA9+etD5rVIz6nJ92c3kI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bql8j2ptZy2bQZ9z3iYpaT4/Hw722nCCCeqFXhw81UsIc1MEsEFy5LYxt2QI+9dXldCXaMFlSaw2VvFvBjlOHhTAIlG63PRhqJSjgvFuVDf5lMfDoGiIfgi6NyBPWBseN4vHnkOsnuv0cN9V0oVJCEtfZ/QTCGvNRTB0aZgfiCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hL/6E33Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hL/6E33Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BADC116C6;
	Fri, 27 Feb 2026 01:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157309;
	bh=4Y5raiBqBVFtFc8TNULm1ZXA9+etD5rVIz6nJ92c3kI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hL/6E33Q6utWDWAKlDQvK+0RCxI8RYGiTHMwUwzFaRYoSLe7YPyfTfJk+h5MP2kpy
	 XtHZtxMCh9O3Ww1OELcT2dgxLHiJ+UWo9IgDBsCThtO25wW0/IXSX3vC9sfs/DiV0q
	 JLztEuaJ2avziu023ie2Hzy8HBE3OKP/skkHDXnBC9SJ/CxmH88yjyxz9T/Yx28Dlv
	 dBm3cPxPhsHP7KVv+HJt+Q0Aq2vSu0JaIGPDPIyjYRwZS91D1vK3jfYZafg8TEa21a
	 floxz2O9MbAQlddY9bQl0tl5CtpIgZj4YTZnUMQkcOL0AlXdCXie1yPHwzP40roms6
	 oZc4r9Q8E7YTQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v3 3/8] block: rename and simplify disk_get_and_lock_zone_wplug()
Date: Fri, 27 Feb 2026 10:49:46 +0900
Message-ID: <20260227014951.2327711-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227014951.2327711-1-dlemoal@kernel.org>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

disk_get_and_lock_zone_wplug() always returns a zone write plug with the
plug lock held. This is unnecessary since this function does not look at
the fields of existing plugs, and new plugs need to be locked only after
their insertion in the disk hash table, when they are being used.

Remove the zone write plug locking from disk_get_and_lock_zone_wplug()
and rename this function disk_get_or_alloc_zone_wplug().
blk_zone_wplug_handle_write() is modified to add locking of the zone
write plug after calling disk_get_or_alloc_zone_wplug() and before
starting to use the plug. This change also simplifies
blk_revalidate_seq_zone() as unlocking the plug becomes unnecessary.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7aae3c236cad..185651a0d617 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -631,23 +631,20 @@ static void disk_mark_zone_wplug_dead(struct blk_zone_wplug *zwplug)
 static void blk_zone_wplug_bio_work(struct work_struct *work);
 
 /*
- * Get a reference on the write plug for the zone containing @sector.
- * If the plug does not exist, it is allocated and hashed.
- * Return a pointer to the zone write plug with the plug spinlock held.
+ * Get a zone write plug for the zone containing @sector.
+ * If the plug does not exist, it is allocated and inserted in the disk hash
+ * table.
  */
-static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
-					sector_t sector, gfp_t gfp_mask,
-					unsigned long *flags)
+static struct blk_zone_wplug *disk_get_or_alloc_zone_wplug(struct gendisk *disk,
+					sector_t sector, gfp_t gfp_mask)
 {
 	unsigned int zno = disk_zone_no(disk, sector);
 	struct blk_zone_wplug *zwplug;
 
 again:
 	zwplug = disk_get_zone_wplug(disk, sector);
-	if (zwplug) {
-		spin_lock_irqsave(&zwplug->lock, *flags);
+	if (zwplug)
 		return zwplug;
-	}
 
 	/*
 	 * Allocate and initialize a zone write plug with an extra reference
@@ -668,15 +665,12 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
 	zwplug->disk = disk;
 
-	spin_lock_irqsave(&zwplug->lock, *flags);
-
 	/*
 	 * Insert the new zone write plug in the hash table. This can fail only
 	 * if another context already inserted a plug. Retry from the beginning
 	 * in such case.
 	 */
 	if (!disk_insert_zone_wplug(disk, zwplug)) {
-		spin_unlock_irqrestore(&zwplug->lock, *flags);
 		mempool_free(zwplug, disk->zone_wplugs_pool);
 		goto again;
 	}
@@ -1398,7 +1392,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	if (bio->bi_opf & REQ_NOWAIT)
 		gfp_mask = GFP_NOWAIT;
 
-	zwplug = disk_get_and_lock_zone_wplug(disk, sector, gfp_mask, &flags);
+	zwplug = disk_get_or_alloc_zone_wplug(disk, sector, gfp_mask);
 	if (!zwplug) {
 		if (bio->bi_opf & REQ_NOWAIT)
 			bio_wouldblock_error(bio);
@@ -1407,6 +1401,8 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 		return true;
 	}
 
+	spin_lock_irqsave(&zwplug->lock, flags);
+
 	/*
 	 * If we got a zone write plug marked as dead, then the user is issuing
 	 * writes to a full zone, or without synchronizing with zone reset or
@@ -2045,7 +2041,6 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	struct gendisk *disk = args->disk;
 	struct blk_zone_wplug *zwplug;
 	unsigned int wp_offset;
-	unsigned long flags;
 
 	/*
 	 * Remember the capacity of the first sequential zone and check
@@ -2075,10 +2070,9 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	if (!wp_offset || wp_offset >= zone->capacity)
 		return 0;
 
-	zwplug = disk_get_and_lock_zone_wplug(disk, zone->wp, GFP_NOIO, &flags);
+	zwplug = disk_get_or_alloc_zone_wplug(disk, zone->wp, GFP_NOIO);
 	if (!zwplug)
 		return -ENOMEM;
-	spin_unlock_irqrestore(&zwplug->lock, flags);
 	disk_put_zone_wplug(zwplug);
 
 	return 0;
-- 
2.53.0

