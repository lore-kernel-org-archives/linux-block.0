Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1943C7C2
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445949; cv=none; b=cIgV65kYcliQ3jlumZjp5gIABqB0DACDDKYjPF/bVBD7mk0SXh6RI964J7hvAL32j2mMSsBDyHLYJKLKmHGKugRg8lwYCDn8H8n5kGNrkqyi6OarB21ErNWmA9tt1jdI2oXkr7t2e7tkPRoOWlBPweDrmzX7BwYe946UDurBhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445949; c=relaxed/simple;
	bh=rnd3cFJlrR5M2bDh0P++u1Vlt1vlh8+8Yu7TW+UCGlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULweBHwksZo/vELcxB3p1cJOHDgcPu4pn6tH4O9yGp2TsPxNZX2sBhjKFR3wrEAnRNjKvg8fG4NJJF7Ce4xOSbpdCzXXo3eQTwarAmC1RWEQ4RH2L6wCbvygI2o8tnffnzRelbzrz7gb1X6EleV+lrl6emlrYNNd14g6124TB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hzkn/OSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hzkn/OSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBD31F00A3D;
	Tue, 11 Aug 2026 10:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445947;
	bh=9gZW5X5naIyjI0iYDLm9JjhoOfGhokqBdzfmLqykP+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hzkn/OSPznES9QuX40V8vZOjDut1BBeE4Fpgv9X4a7YzyMKD+U/XUIFpMw8m8oWqt
	 HA/FY5hxG+u4aeSqTtZ0usa5fW/HSwxkqKde1S3CeZpuWUaIh57xfEwi6Kr5sekRAe
	 QiUnyJhxfzJ8WzvQUb4E4dm9Iz8vdseM/FEP5CiQ4FjAD44+Yl8IA212gMroVKv7Zh
	 74/JHlBgPW+Q/xKS/+jTup66XxNlx7bFNX7nJOuo7vY1yttkzDMR912JAVJB0qWwWx
	 8Z7Yi+5CD0odMY1a2t1eyPxuw0jjJZ0yhHQGeRjEZpwUMNmzgFLTI1SNaOAqU12swJ
	 wFmyEafYRsrUQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 05/13] block: refactor bdev_zone_is_seq()
Date: Tue, 11 Aug 2026 19:58:44 +0900
Message-ID: <20260811105852.1245357-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811105852.1245357-1-dlemoal@kernel.org>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the helper function disk_zone_is_seq() and use it to refactor
bdev_zone_is_seq(). disk_zone_is_seq() is also used in
blk_zone_wplug_handle_write().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 837edfaf3298..557ca986bccf 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -261,6 +261,29 @@ static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
 	rcu_read_unlock();
 }
 
+static inline u8 disk_zone_get_state(struct gendisk *disk, sector_t sector)
+{
+	unsigned int zno = disk_zone_no(disk, sector);
+	u8 *zones_state, zs;
+
+	rcu_read_lock();
+	zones_state = rcu_dereference(disk->zones_state);
+	if (likely(zones_state && zno < disk->nr_zones))
+		zs = zones_state[zno];
+	else
+		zs = BLK_ZFLAG_CONV;
+	rcu_read_unlock();
+
+	return zs;
+}
+
+static bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
+{
+	u8 zs = disk_zone_get_state(disk, sector);
+
+	return !blk_zstate_is_conv(zs);
+}
+
 /**
  * bdev_zone_is_seq - check if a sector belongs to a sequential write zone
  * @bdev:       block device to check
@@ -270,21 +293,10 @@ static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
  */
 bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
 {
-	struct gendisk *disk = bdev->bd_disk;
-	unsigned int zno = disk_zone_no(disk, sector);
-	bool is_seq = false;
-	u8 *zones_state;
-
 	if (!bdev_is_zoned(bdev))
 		return false;
 
-	rcu_read_lock();
-	zones_state = rcu_dereference(disk->zones_state);
-	if (zones_state && zno < disk->nr_zones)
-		is_seq = !blk_zstate_is_conv(zones_state[zno]);
-	rcu_read_unlock();
-
-	return is_seq;
+	return disk_zone_is_seq(bdev->bd_disk, sector);
 }
 EXPORT_SYMBOL_GPL(bdev_zone_is_seq);
 
@@ -1522,7 +1534,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	}
 
 	/* Conventional zones do not need write plugging. */
-	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
+	if (!disk_zone_is_seq(disk, sector)) {
 		/* Zone append to conventional zones is not allowed. */
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			bio_io_error(bio);
-- 
2.55.0

