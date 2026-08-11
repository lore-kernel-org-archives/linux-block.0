Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB443CE62
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445947; cv=none; b=GqFnVsKp+S8+gMjZxHEYFkdVozaVA+hewEbMrXoSx6PGXcI5jCPYBCGdhrTo7ADDuJ7/n5SuNFs+frZH8z5b8jmUqjIrYloWN8ojOXCZ4Nw1gfaE9aNrs/+npy1m8e3cI1Fj2Nesusv3N5CsFgzr1QD6ex2b5RYBA9Zr62nAQNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445947; c=relaxed/simple;
	bh=SMROCQuosONlznu8fE5O1h458HyX3mdO/Mg1qnhixK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twIsd2LIFzTmM2aU92D2waESzhChp/56gi2tRCDWuTnhHMPJbwAywSSjRkxFX08pqn7oSnk/Py6q+NJPDaHt/7yC5D0k5KGkQ/3tjxz3YLMe/zhaR6fdTjKW4oNNjiKxHEtDSNlWRnZctumEbdeDj2SLNJSNsJEnojGBeIG1Fjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHMOJXGm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHMOJXGm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63A91F000E9;
	Tue, 11 Aug 2026 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445946;
	bh=jwV8oQ5O8C+xRsyJJXiyuY2QDQ6403hvK/jjPQMJ+2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GHMOJXGmxnFF7u7OLvg7x+rFyRAqp9PFvVpgVdnGJc4dbdhiSdRNb2YhmIG/nO2J4
	 g1058IiLSUvhqv3V4/us8DKwLjXI9LuC3QM1bA0nGUCmRyS1vmY1r9BbSunyia31KI
	 KtQuOY4xEhfRuwhaWJYeEqfzw7yJVXYOBtFjML3K1qm9x9BDqQxR+WBQoGM84pAh28
	 WcjYXEH+Dho205Y8YBK1NoKkgHI8xXu+PLSXrHdWhatqufikj71w2/X7k9h0+Eq2uq
	 dzXY2ZQ2UrFU1oJhWKRxhTR8NblDXKFRgsV9lqCAJyiw+wwWVH+i6Iii+hQ2AKKTFH
	 yFqt1IsR9nZfQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 03/13] block: refactor disk_update_zone_resources()
Date: Tue, 11 Aug 2026 19:58:42 +0900
Message-ID: <20260811105852.1245357-4-dlemoal@kernel.org>
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

Since the function disk_update_zone_resources() does a lot of checks
beside updating a zoned disk limits and resources, rename this function
to disk_revalidate_zone_resources(). To keep all checks together, move
the capacity check in blk_revalidate_disk_zones() to this function and
simplify it by moving the check on the number of zones before the call to
queue_limits_start_update().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 908944b55b59..7585d5c65298 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2032,11 +2032,11 @@ static int disk_init_revalidate_args(struct gendisk *disk,
 }
 
 /*
- * Update the disk zone resources information and device queue limits.
- * The disk queue is frozen when this is executed.
+ * Revalidate and update the disk zone resources information and device queue
+ * limits.
  */
-static int disk_update_zone_resources(struct gendisk *disk,
-				      struct blk_revalidate_zone_args *args)
+static int disk_revalidate_zone_resources(struct gendisk *disk,
+					  struct blk_revalidate_zone_args *args)
 {
 	struct request_queue *q = disk->queue;
 	unsigned int nr_seq_zones;
@@ -2044,19 +2044,24 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	struct queue_limits lim;
 	int ret = 0;
 
+	/* Make sure that the entire disk capacity has been checked. */
+	if (args->sector != get_capacity(disk)) {
+		pr_warn("%s: Missing zones from sector %llu\n",
+			disk->disk_name, args->sector);
+		return -ENODEV;
+	}
+
+	if (args->nr_conv_zones >= args->nr_zones) {
+		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
+			disk->disk_name, args->nr_conv_zones, args->nr_zones);
+		return -ENODEV;
+	}
+
 	lim = queue_limits_start_update(q);
 
 	memflags = blk_mq_freeze_queue(q);
 
 	disk->nr_zones = args->nr_zones;
-	if (args->nr_conv_zones >= disk->nr_zones) {
-		queue_limits_cancel_update(q);
-		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
-			disk->disk_name, args->nr_conv_zones, disk->nr_zones);
-		ret = -ENODEV;
-		goto unfreeze;
-	}
-
 	disk->zone_capacity = args->zone_capacity;
 	disk->last_zone_capacity = args->last_zone_capacity;
 	disk_set_zones_cond_array(disk, args->zones_cond);
@@ -2100,7 +2105,6 @@ static int disk_update_zone_resources(struct gendisk *disk,
 commit:
 	ret = queue_limits_commit_update(q, &lim);
 
-unfreeze:
 	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
@@ -2295,7 +2299,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	sector_t zone_sectors = q->limits.chunk_sectors;
-	sector_t capacity = get_capacity(disk);
 	struct blk_revalidate_zone_args args = { };
 	struct blk_report_zones_args rep_args = {
 		.cb = blk_revalidate_zone_cb,
@@ -2307,7 +2310,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
 		return -EIO;
 
-	if (!capacity)
+	if (!get_capacity(disk))
 		return -ENODEV;
 
 	/*
@@ -2351,18 +2354,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (ret <= 0)
 		goto free_args;
 
-	/*
-	 * If zones where reported, make sure that the entire disk capacity
-	 * has been checked.
-	 */
-	if (args.sector != capacity) {
-		pr_warn("%s: Missing zones from sector %llu\n",
-			disk->disk_name, args.sector);
-		ret = -ENODEV;
-		goto free_args;
-	}
-
-	ret = disk_update_zone_resources(disk, &args);
+	ret = disk_revalidate_zone_resources(disk, &args);
 	if (ret)
 		goto free_args;
 
-- 
2.55.0

