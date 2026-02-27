Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAF264A86
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198709; cv=none; b=lVXnXgOo2+ZMnHFfQL4WR8kNAzELhgGjfZLhXKDMp4HHpT///54+gLzyxcZE9dYxQ6e5xt8mdNmwzy/ruQ/lHPABFpMQ+Y/Ir6ms5y3My30O/dcC6M+Pg0qY63whdbZl3lU8aCiao2+l2hFaW6kA9rR7SO6w2/zKhHEM2u4lpNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198709; c=relaxed/simple;
	bh=9LKTv3cFU3PIP12SeGgV4rFKhauNjCY1n5ajvSNOW1c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPA2UOTYRoZQYXTGK29vZ4cgvO2Cpx2qtK6f/TQOlFaU4ifjxTP+G/ic/SmBpbkW/GjBbh4WZAL5Cd0wkLb3/OM/cwkfQlUCWo9UCyV+3KAvuI5/xqIscmW/vAXGWoLpUpcKR2QSl7p4oQHoh3ZT2u9HEhavpo3vbD7mMY7fLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhZFb2tw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhZFb2tw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACC0C19425;
	Fri, 27 Feb 2026 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198709;
	bh=9LKTv3cFU3PIP12SeGgV4rFKhauNjCY1n5ajvSNOW1c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UhZFb2twBXQFS6esvuNEZ9Ihpi3F11h5KhNkTTqX2hzMt/H4g8jk3/kZOE3J1fBjy
	 +wRY64p2IrjBV54t+B+Hw7C03r4+AkMUckzBqRI0TVyo6OywR+5ut3Oy9JyebNbgzY
	 i91UFLrizdPyHSkZoNkuWa7LI2fgwzoJ2+Xj5gQnQpYJsgMZoQ96aRGUuWk/hNw/yz
	 Mabp2XjJQ8pf698jPXswnT5nHufTuhEAmu5f8K+HQz66V/ST6/uk0HPqiIAhloVXZ5
	 EOpYnVI4jG//kDniRFHVQbvd8sg+S6Oh8iTo4jxB0ELwAkITzs8A+VT4UK46Lbs8Vh
	 CSUGgUjFyBgdQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v4 3/8] block: rename and simplify disk_get_and_lock_zone_wplug()
Date: Fri, 27 Feb 2026 22:19:46 +0900
Message-ID: <20260227131951.2464150-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227131951.2464150-1-dlemoal@kernel.org>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

