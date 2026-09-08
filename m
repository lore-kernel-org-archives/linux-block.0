Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E663F4C9545
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857905; cv=none; b=W8gg5OaTbQYFVbf+9xuBMZ5i1EqIoVyx10/89Nf8Xnf1xzXy7jhRsVvsODhXsNSCOwu8EjCoLogy9A8WkmnYhpkjMzeHyjCeEBHIuAjjOwCy3aqAnkBKa747PKzPIn5KBvnh6fyGtDWnUVq/s22BYDezhdbWn2Xc+1dcrFjJvP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857905; c=relaxed/simple;
	bh=eGSeLPcAN2dRrtm8gTcVbQhjyjHj9DsOJPnzRNKKiT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0xUYP5vsnGKN/YK+0VULWbFWZkH1l1jsx7rkOmClaxbhPr+hhnMSmLkYzQv7n0mFQS3lZmB8m3ZIpWE5qMurZkfsT0WMZr/Ax19LKDU7voviQyAsCKYllmXxQ2WAwienyTSsALl9xpee0VzaRbTTaldHcmLPUnv9xkg48IDPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEFB3JFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEFB3JFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8614B1F00A3E;
	Tue,  8 Sep 2026 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857888;
	bh=XdIsFThekB4xlIKE9IVC6pE9dVReaPcc+UllrPFgSOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MEFB3JFQ0inNl6FQU7GY+mSPG0SrL33DxjPduFARcvlEU8cMo292eyqhc+N17wZpP
	 fFjNJaApZNIF92AFZsuEG20BIAi5uoc4QvFasqzNmRKXJyvsUbHldjQ4q6YPqTSYqh
	 Gtb0WN4+L4HcUo0j5FxuAaAuT/YKXP2Ux6x/HDAMqL3qNVv5V16AGUZmOQWPhqx5xr
	 iVFCMFoNkJ06DvDAWXwGOiQL2/X7TqJ7DX9Mp0KO8Y5+GLWVLBhbsT1ci5JdmmpOuh
	 pAOQdwfirsQ9l7tOu+nC9aHn9ki0INII8TYFyCEDIdiEgqkU4aJRfh5G/jUkJHb193
	 vGH+9NHN6DlgA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 15/16] block: allow read-only and offline conventional zones
Date: Tue,  8 Sep 2026 17:57:44 +0900
Message-ID: <20260908085745.1082697-16-dlemoal@kernel.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 66 +++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c653cfc9823c..2a8e573034b3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2370,57 +2370,32 @@ static int disk_revalidate_capacity(struct gendisk *disk,
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
 
@@ -2436,6 +2411,24 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
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
@@ -2518,11 +2511,6 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
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

