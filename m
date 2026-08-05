Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4B3C13EC
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896855; cv=none; b=ZkT97c/T+5dRUWidOKB9vq9BBdx/bDylayjYhc706qr4esd+EYwR94qYmWjVe0YRUCk4lh/fVLMB5V5i3i9n8q+W2QbWsDZ9qPLzyfGbYq2X9lF2o/ZAfE1/FMDyOHdusc7glcLVw9ohtBaBqf0Sxr+A2/ZgMpQBej+10oflTO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896855; c=relaxed/simple;
	bh=0tVNPPGBcKac8pvv+4WzmluKRovYZzWpaoyj4NiI3Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciSZlMbcarLTThZ0EC9MvuqXLyQ3Ep1D6V/JVerIZI7rE60sXHlEUVRg+2IgUgbpxX7pXFWyxTQz8EXRAfHIGrW8HVnPOVdJyPZwWCgeMrFZiORdJ6BNrV9vL7AWSoxnsbajz1aAcNfV9O25w/klw1ZUEefRsxgYuEVPB9DHz6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILAMmEBO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILAMmEBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF4C1F00A3D;
	Wed,  5 Aug 2026 02:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896854;
	bh=VNvwmB8iF+AfDQF9pVk3u3m5Dj4EfaP5mrBEdK01W4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ILAMmEBOdD+Er1mBVFVJZ1jdfAB/hgtb8sI/u22lst7rdztyr0BJNrzsPumvTf5sz
	 M2n37bMRdqMN21TDTcdN6WTtH4vrV5aDdx75iSPVokiiL2zjzI9x6Xh7VaIPMyMjLt
	 pUkaprCI+JWrdevCGsJLTv9lma7nNLy02bJpfKxjSgsZ32/PToVBuNP4i75oo6YMpC
	 HWdSIFKksvE86E7IxUTEePr7LmLgGfSTa/NgMFDAV2ttqqcgvq4xgA+yOMshYAo1JN
	 at/ZoRE4PV0XUGmUcuXZhXZkgx7Iudq4rI4AxnUu9xDauUD7dBzvznrAfnikHadR+G
	 suMgGUE89PsnA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/14] block: refactor disk_update_zone_resources()
Date: Wed,  5 Aug 2026 11:27:08 +0900
Message-ID: <20260805022719.735323-4-dlemoal@kernel.org>
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

Since the function disk_update_zone_resources() does a lot of checks
beside updating a zoned disk limits and resources, rename this function
to disk_revalidate_zone_resources(). To keep all checks together, move
the capacity check in blk_revalidate_disk_zones() to this function and
simplify it by moving the check on the number of zones before the call to
queue_limits_start_update().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ba51e600ae92..bfcd3cd99ec9 100644
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

