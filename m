Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23843CED2
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445954; cv=none; b=m0PMfDP9IfzFv20nAeBrYvaCup0IcREJATIbCOuwCif5U6qttkggLBfgOPQMkkBbAoyIG870iblzFGIgu1yAhqZ9ZIMLZ/2CEWD6FfgXZ1up/w0AvDaeldLjM+1LJh6SH2zT1A4HGLbtmXzEf3IV5E+7gwnNrBsuaWR8Ezkl+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445954; c=relaxed/simple;
	bh=PMERcBeN6ff5MUU6vQLxp3Cjnm6Setf1M22cOi9THnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nm7uHqJEVZgFBf/Nf2es1EymN4103DrNAqqPz/25AgABM52gLtlU9lEnortK2+uM0jDA/HGOIEyDmCx12ACIdBa9EykDtdMVgPurx/6kbLp71q5utnkQBfUDk8Ks4rEWEZg38IzOB3eR30oLibwhDoPz+z3KvuazIDrLELML3nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK9k5X/E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK9k5X/E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD58A1F00A3D;
	Tue, 11 Aug 2026 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445952;
	bh=nEMom0l0zlL9C4bGAEBKSPhhUwiot5TmJ65bqRobGWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gK9k5X/EzIiMd5q5TrLIDwetL9jyBiDry5slWHz4BEcwGj6+CyHpXV5/fMuxWTFQe
	 deN0DBQ/WCnw0rTWKNbWOkCYfwG2UFhTUwxhGcKns5kFNwkq7vK8g2ELiChLeOb6b4
	 RDS/JumYs1Suk8j2Lwa5BVIWGfuaAaGxBXThTrsagIUgnnOQ2HAUR4LZG21gDA8wXp
	 WY35eQjYXFhASb0ltfhhCmctV696tOm/7SxA3WzD5rwewewH6W/WUY3MoxSdjqWFhp
	 5KRex/wM3yn8UvjHlRswS3iwtLYAsZXfkKXTByg5AtYZkv8R2Bg4OQJ5spwUYNBA3Z
	 E4EVSNpZ2YV5A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 11/13] block: allow read-only and offline conventional zones
Date: Tue, 11 Aug 2026 19:58:50 +0900
Message-ID: <20260811105852.1245357-12-dlemoal@kernel.org>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 65 +++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 39 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7ed1cb1341c2..acf60982e6c9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2341,57 +2341,31 @@ static int disk_revalidate_capacity(struct gendisk *disk)
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
 
@@ -2407,6 +2381,24 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
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
@@ -2489,11 +2481,6 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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

