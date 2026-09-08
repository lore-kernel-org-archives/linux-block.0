Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DFB4B0494
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857898; cv=none; b=RI2kPImdaHXqRPqBCntBSTA4z1DzQKZipvOh/rmDv0TmfexdApAHEyniUkzi5PDhmgVSo3PJuweXHCfVFZnMzjTfNnV/L3pjU+LIVSpHX3kyo4W843lMrcCd4YFVPi5iSKcZDumdTXUzSiDX2S6hb4BM4ZcjhYpfRAeEo73LKZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857898; c=relaxed/simple;
	bh=DOSnX96o3PcCwYuOymm6g4a2yFAskY8UZXGWeu+JCm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuWTT6rr8zQWakF2YJjpw6+9r/3yljefsShkRf963DOs+nBtr1t0FDc9FxnpjjPjDgE3IZtUnvcutm3eONujVoYU0xnQSXhDcefDxCL4N5A885tBVe/93wjPyRTdlaDBcrLLOuR5dyjwYWUlC67ue5ok1CZfBKafpnuRj//PMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YINLJ+vM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YINLJ+vM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BD61F00AC4;
	Tue,  8 Sep 2026 08:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857880;
	bh=GpKAhKDN/vTss6T8T+ZbjVANPTqvPQHj+JDhghm//+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YINLJ+vM7Dzqv5Uo8lrOiEcmRhJDs+XoMDvJZx/ZrFrg1dab7BaQRSmYQhZAPgCmT
	 QM5IS66ou/Cls8p2QO9FpsqvYLDYPubeKUsQYxlS8GHHHwgEpS3mqtG154nWzDEDaQ
	 C24wVJZAx0RORWbFeVOHOUhFUNkPf+cCgp5dyYrJZfPaFyz6smlTYrWG6PFE66PmTV
	 C7E5FbIljJwvOIC9I/ehJAGyXMUKo9pU4HVu3Qx3YyHAWPDAzjZuIJt7mKDqCDLUeX
	 ppieq1sCd+7I25CDz/GDjx2U0ZCfD5I/h6SyIuMtsFQ4RLxlUVxf9pGvwSQjLYHK7V
	 BY5Po92QMOlpg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 04/16] block: refactor disk_update_zone_resources()
Date: Tue,  8 Sep 2026 17:57:33 +0900
Message-ID: <20260908085745.1082697-5-dlemoal@kernel.org>
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

Since the function disk_update_zone_resources() does a lot of checks
beside updating a zoned disk limits and resources, rename this function
to disk_revalidate_zone_resources().

To keep all the checks together, move the capacity checks (including the
check on the end sector of the last zone of the disk) in
blk_revalidate_disk_zones() to this function.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 64 ++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 993ddaf7acf1..f07f5ab31b06 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2039,31 +2039,51 @@ static int disk_init_revalidate_args(struct gendisk *disk,
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
 	unsigned int pool_size, memflags;
 	struct queue_limits lim;
+	sector_t capacity;
 	int ret = 0;
 
 	lim = queue_limits_start_update(q);
 
 	memflags = blk_mq_freeze_queue(q);
 
-	disk->nr_zones = args->nr_zones;
-	if (args->nr_conv_zones >= disk->nr_zones) {
-		queue_limits_cancel_update(q);
+	/*
+	 * Using the re-evaluated disk capacity, make sure that the entire disk
+	 * has been checked.
+	 */
+	capacity = get_capacity(disk);
+	if (args->capacity != capacity) {
+		pr_warn("%s: Capacity has changed (%llu -> %llu)\n",
+			disk->disk_name, args->capacity, capacity);
+		ret = -ENODEV;
+		goto unfreeze;
+	}
+
+	/* Make sure that all zones have been checked. */
+	if (args->sector != capacity) {
+		pr_warn("%s: last zone and capacity mismatch (%llu != %llu)\n",
+			disk->disk_name, args->sector, capacity);
+		ret = -ENODEV;
+		goto unfreeze;
+	}
+
+	if (args->nr_conv_zones >= args->nr_zones) {
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
-			disk->disk_name, args->nr_conv_zones, disk->nr_zones);
+			disk->disk_name, args->nr_conv_zones, args->nr_zones);
 		ret = -ENODEV;
 		goto unfreeze;
 	}
 
+	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
 	disk->last_zone_capacity = args->last_zone_capacity;
 	disk_set_zones_cond_array(disk, args->zones_cond);
@@ -2082,7 +2102,7 @@ static int disk_update_zone_resources(struct gendisk *disk,
 		lim.max_active_zones = 0;
 
 	if (!disk->zone_wplugs_pool)
-		goto commit;
+		goto unfreeze;
 
 	/*
 	 * If the device has no limit on the maximum number of open and active
@@ -2104,10 +2124,12 @@ static int disk_update_zone_resources(struct gendisk *disk,
 			lim.max_open_zones = 0;
 	}
 
-commit:
-	ret = queue_limits_commit_update(q, &lim);
-
 unfreeze:
+	if (ret)
+		queue_limits_cancel_update(q);
+	else
+		ret = queue_limits_commit_update(q, &lim);
+
 	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
@@ -2359,23 +2381,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (ret < 0)
 		goto free_args;
 
-	/*
-	 * If zones where reported, make sure that the entire disk capacity
-	 * has been checked.
-	 */
-	if (args.capacity != get_capacity(disk)) {
-		pr_warn("%s: Capacity has changed\n", disk->disk_name);
-		ret = -ENODEV;
-		goto free_args;
-	}
-	if (args.sector != args.capacity) {
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

