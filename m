Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9863BED2D
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147714; cv=none; b=XnJ+Du7LUBsm8/5VL89NTDrjD86OsZ1sl/NMB3Zjm7TKZHHo00px6THORkqT3n/JKQS5Vu6bzbBLNOMGDPde0sEKYCnfTusqxu+ZIO9+NPoYmNr+lIQvJ+nq4v57DIu9aU/DZ1O9bzD5WiopnDdCxSjtNHWVL1ReuWEkQVv4mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147714; c=relaxed/simple;
	bh=B9ZsUGtPEKoB3u5YosUbtVnOdAaqqWTzuxgfj8aKNHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AIouDhDN/j/RuzGpmzjjqVhPCGIWgS3dankkOx8eS6ifPQrfqJ4PPExo2aMNymrBAP3bGhZiAYVeSM/qmgU4CekxfVNbn8vXH3zCa+3w5HmKMH9hTLyP77aGdstD+Hx1E+hSkxg7K2b3jBnGJM8mWf/JEVcMJQS1gD9aWK3OhOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVEXeTPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVEXeTPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7061F0155A;
	Mon, 31 Aug 2026 03:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788147691;
	bh=DZuXcrETJNazZ3tOfprkt1b9IlLLYIwg1Fk2eaayd1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dVEXeTPCfZxzNUOXfsPHKYSrUf8lS5iKTDzEHnR2JdSSbAVqu2uSbGH7kmlouO4iJ
	 Zkk1EPFTgNvV3Hannxpwn/jNhUsYHAm2S+JwGjM2/ao8keJw5EOkCld9mQvhgDIHmh
	 6xJoxht8FP63DIwG7tfRN2XNW8phUbGw79JOx/5LGHrH8wK1DVnI3lP5ssiltNpv0+
	 ZaeJAIMUiQRoko6Oc31l6fO630DueLtlJip83kQpbI3pnUhil+qbLbsAyko/E7UxQT
	 KwOurp/cUvC2x6Ve9vo14Qfj2nvpGxocuqLXCgC2GxJBbi0O0PSBMbRtm9M/QG3/M+
	 yEcjckr8cXyPw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 11/12] block: allow read-only and offline conventional zones
Date: Mon, 31 Aug 2026 12:41:08 +0900
Message-ID: <20260831034109.744039-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831034109.744039-1-dlemoal@kernel.org>
References: <20260831034109.744039-1-dlemoal@kernel.org>
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
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 66 +++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 57006c595ca8..c3b56dc947af 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2342,57 +2342,32 @@ static int disk_revalidate_capacity(struct gendisk *disk)
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
 
-	blk_zstate_set(args->zones_state, args->nr_zones, idx, cond, flags);
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
 
+	blk_zstate_set(args->zones_state, args->nr_zones, idx,
+		       zone->cond, BLK_ZFLAG_CONV);
+
 	if (disk_zone_is_last(disk, zone))
 		args->last_zone_capacity = zone->capacity;
 
@@ -2408,6 +2383,24 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
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
+	blk_zstate_set(args->zones_state, args->nr_zones, idx, zone->cond, 0);
+
 	/*
 	 * Remember the capacity of the first sequential zone and check
 	 * if it is constant for all zones, ignoring the last zone as it can be
@@ -2490,11 +2483,6 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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

