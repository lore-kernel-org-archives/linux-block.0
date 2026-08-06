Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6DB47AF5F
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032306; cv=none; b=nACtNbz/rkmgMZpw11kxcR+qXWYaQYbvZKeQQZuph1uTVBhppgpHkXvno/SOxZL0aw8jIrdzFxyGy2QEmcs6sKJKOC9g5BR/vyaliHp3NBRHcwV6TOMsUQ2gxWEtaaEgWAewKhol7XOyhadTopWO+QVBylv/ChJ40rkVIeNYqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032306; c=relaxed/simple;
	bh=GurlrXDE8fBLyAV5C2QGvvll2i2OyYvacDjhBllEm3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Arv0xkVuLuk8fu1zJoCQFfm9CGcaKnW9JQh6DgtLUGSuhY69rUjbjbbJZtoTSaBIEfiGEsNUuVeU22+JH2a1tsjCF4yyu03gffH4rlOrfib9xOswg2jZAouFeQPe2QbfYq2610g7KztCtpS5u5PRCh9aCJontfHhiJFf2IPMwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOHLElye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOHLElye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288DF1F00A3D;
	Thu,  6 Aug 2026 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032305;
	bh=K7TmIUEhrqtvbTjLP+Bd2ZoTOLBdU/d3SSI2+sL0eDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IOHLElyeSKznpf3/Z81aS0Rfw2OQdaOdDDnMnXzC+O1QbLXQmFIj+7H/5LLkK8Bvi
	 EOylLk66oFjFcYc7VKcOE0wQaEi7oDRIIUZ1/Q9so2uGmSgNuYcDz/6h9I4yfmCVXw
	 BgEWFewnb230OP2gCsPy5nqcuOPvvc7LOmZ/nma/h4Q29d7cCSaj3cQQdN2M4wWVOP
	 sX+mMs7Atw8CsjbS7blya+9DAK9tqo/PP+9u8W28GkzcAScvoNP5jja1iej4ch9LmL
	 GwxiD5eL861GyNlMoj0sYYWZkQZq31sVNRGppOth8HO2s53jUNdKJiKOdVkC970NjO
	 VlTrvONGQ1Gxw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 11/13] block: allow read-only and offline conventional zones
Date: Fri,  7 Aug 2026 01:04:43 +0900
Message-ID: <20260806160445.848337-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806160445.848337-1-dlemoal@kernel.org>
References: <20260806160445.848337-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With SCSI and ATA SMR HDDs, the storage element depopulation feature can
change the condition of conventional zones to read-only (if a write head
is depopulated) or to offline (if a read head is depopulated).
However, the function blk_revalidate_zone_cond() currently does not allow
these conditions for conventional zones, causing a zone revalidation
failure.

Remove blk_revalidate_zone_cond() and move the zone condition checks for
conventional zones to blk_revalidate_conv_zone(), allowing the regular
BLK_ZONE_COND_NOT_WP condition as well as the BLK_ZONE_COND_OFFLINE and
BLK_ZONE_COND_READONLY conditions to match the conditions that can be
seen from a zoned device with depopulated storage elements.

The zone condition checks for sequential write required zones are moved
to blk_revalidate_seq_zone() without any change to the conditions allowed.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 65 +++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d13a6edc7362..d0bdef1a5774 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2333,57 +2333,31 @@ static int disk_revalidate_capacity(struct gendisk *disk)
 	return ret;
 }
 
-static int blk_revalidate_zone_cond(struct blk_zone *zone, unsigned int idx,
+static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
 				    struct blk_revalidate_zone_args *args)
 {
-	enum blk_zone_cond cond = zone->cond;
-	u8 flags = 0;
+	struct gendisk *disk = args->disk;
 
-	/* Check that the zone condition is consistent with the zone type. */
-	switch (cond) {
+	/* Check the zone condition. */
+	switch (zone->cond) {
 	case BLK_ZONE_COND_NOT_WP:
-		if (zone->type != BLK_ZONE_TYPE_CONVENTIONAL)
-			goto invalid_condition;
-		flags = BLK_ZFLAG_CONV;
-		break;
-	case BLK_ZONE_COND_IMP_OPEN:
-	case BLK_ZONE_COND_EXP_OPEN:
-	case BLK_ZONE_COND_CLOSED:
-	case BLK_ZONE_COND_EMPTY:
-	case BLK_ZONE_COND_FULL:
 	case BLK_ZONE_COND_OFFLINE:
 	case BLK_ZONE_COND_READONLY:
-		if (zone->type != BLK_ZONE_TYPE_SEQWRITE_REQ)
-			goto invalid_condition;
 		break;
 	default:
-		pr_warn("%s: Invalid zone condition 0x%X\n",
-			args->disk->disk_name, cond);
+		pr_warn("%s: Invalid conv. zone condition 0x%X at sector %llu\n",
+			disk->disk_name, zone->cond, zone->start);
 		return -ENODEV;
 	}
 
-	blk_zstate_set(args->zones_state, idx, cond, flags);
-
-	return 0;
-
-invalid_condition:
-	pr_warn("%s: Invalid zone condition 0x%x for type 0x%x\n",
-		args->disk->disk_name, cond, zone->type);
-
-	return -ENODEV;
-}
-
-static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
-				    struct blk_revalidate_zone_args *args)
-{
-	struct gendisk *disk = args->disk;
-
 	if (zone->capacity != zone->len) {
 		pr_warn("%s: Invalid conventional zone capacity\n",
 			disk->disk_name);
 		return -ENODEV;
 	}
 
+	blk_zstate_set(args->zones_state, idx, zone->cond, BLK_ZFLAG_CONV);
+
 	if (disk_zone_is_last(disk, zone))
 		args->last_zone_capacity = zone->capacity;
 
@@ -2399,6 +2373,24 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	struct blk_zone_wplug *zwplug;
 	unsigned int wp_offset;
 
+	/* Check the zone condition. */
+	switch (zone->cond) {
+	case BLK_ZONE_COND_IMP_OPEN:
+	case BLK_ZONE_COND_EXP_OPEN:
+	case BLK_ZONE_COND_CLOSED:
+	case BLK_ZONE_COND_EMPTY:
+	case BLK_ZONE_COND_FULL:
+	case BLK_ZONE_COND_OFFLINE:
+	case BLK_ZONE_COND_READONLY:
+		break;
+	default:
+		pr_warn("%s: Invalid seq. zone condition 0x%X at sector %llu\n",
+			disk->disk_name, zone->cond, zone->start);
+		return -ENODEV;
+	}
+
+	blk_zstate_set(args->zones_state, idx, zone->cond, 0);
+
 	/*
 	 * Remember the capacity of the first sequential zone and check
 	 * if it is constant for all zones, ignoring the last zone as it can be
@@ -2481,11 +2473,6 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		return -ENODEV;
 	}
 
-	/* Check zone condition */
-	ret = blk_revalidate_zone_cond(zone, idx, args);
-	if (ret)
-		return ret;
-
 	/* Check zone type */
 	switch (zone->type) {
 	case BLK_ZONE_TYPE_CONVENTIONAL:
-- 
2.55.0

