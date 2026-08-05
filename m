Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF33C279B
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896864; cv=none; b=Cxl67FKDS9RrSa7ANsUCIq0SuBmSQ8v0DP0nNhdvm+jCTPoMOTwDET4uj2/SQzk6yiPL/H6mjkIZqmyAgy7C0DAYofFGyjPebVF2Ci8pYg1Vk+9C5SWn7cRpnQegB0A6WllcF7l3sf2ZH+abez56P0NVHlh+ZR+lpaE6bT4By/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896864; c=relaxed/simple;
	bh=AyJS+sdYiIk157ugpGKSBX0wXpyOnIikobDwomR0pBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAg42CzRXlQdnJ/A758I5O7BmWgMEi2O8ngIp3sIDQnywzALqbYsGIOvXYCfNnbLBpJgdWsKhffwlTyhqBd4gyZx2a9UdU/P1rzXjL6gzx0ficjnpfa6IqCn+rYxDDwIwzELG7edbddMxYRn65SfDuwhFLSvoxRaGRWWDJbs8N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlFshiVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlFshiVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB99C1F00A3D;
	Wed,  5 Aug 2026 02:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896862;
	bh=Qn0irZpWNdNPc2Isd7vOYR4XKqLVMMYEGmB9km2VKiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QlFshiVame9WwNBM83bC78qNoa8ke2AT4Uu8daygmzsv2mcLuvAv2vTEoUS3RfUVM
	 8LBJW/elwO1JuT3X987t4he16KE3J7b3uMC6FZ4qsD4MaRoUl7XUQrxjcckdfnW4Ls
	 F0/a1MEYdvJs2/k5tRowMipKO9fKwYrstEe+6YFjKGJ1m3ae12vACiecZb/ed2z0NA
	 KI1gC3poAkU9cyNLwxxzJpQJeWOp01HTIZj37nqazo5Ru+D0DHngezXi64kYprnfhi
	 bRIoQ4Wqjh1GRxmPDNnZtG0jSWjoVZSbS2L2rWuGb4TaToJK5XNUUkxdUpBcAGF7mt
	 2UvjhEMNW3gyA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/14] block: allow read-only and offline conventional zones
Date: Wed,  5 Aug 2026 11:27:16 +0900
Message-ID: <20260805022719.735323-12-dlemoal@kernel.org>
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
index 1d1175638763..3494f06ec3f1 100644
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

