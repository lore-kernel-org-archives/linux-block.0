Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A347B435
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032300; cv=none; b=Nrbgbb5pxVaxcg/gX86UxjhJVpsgJZQk6VXng2MXQoOMatCNp11k8bbR0PgV6nVJQfliHa5JKmDO6CxVtm8ajrh3vcY15fLT/qo03Y8WgzelLn8esf9PfGPPsq54OjmYPZEXNzlZcNwv7bqOKeIf51106S8dYKVO0T6XvBc8OL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032300; c=relaxed/simple;
	bh=vFTcds+90Ec3EWG+/kCLvWssmL1Iass8yFOH6qIBTdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuVnNTnP5RAH/tRZBn7QWhxdnkNMdlcjLeiDFKe6OFZg+ETYwkhB/rX1rXfKiP2rJte5VMebir2Ppyoq5hEY+YyKV00TIZosk/KtIQR7zBx6YB4li4TD2LItNI3KsLYkb3Xe60UxAzy5Wxf8m0ziNTTZczX+7FWmMCVez142pDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+29t4tk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+29t4tk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F441F000E9;
	Thu,  6 Aug 2026 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032299;
	bh=lN3LzpKhibpeYGgf+fkQyxPg+F8lPeVwt+7VDbF3OZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e+29t4tkpx12TY9Nlsqy1D8TdCDYplt+1KuUaPP1nHgE/fJXh62omzaXP+bwE1rAr
	 8lL+8n1El+kqp7E1JERzDhK38qnCaxJIxaTXVuP5AdV+XF8HdHc73XgprmEi6J1/iK
	 6KLm/7HkGDhe6kp+PKUkyXF6eUaU1qrWJ2XiMZtG9FdEyBZlCKbYtrphIzZDRd3mAB
	 pkqHioTvstB0IU9EGPgCiWLglGr3LiDQajId5r/ccMEwhEovIyF9J8O26BG/Dv50Rj
	 IBdPj7jt2kZsqJdc6pTQrBL/I49r8nyVHrXiZhKUoQijsmqY/b4SEz78oSWrnQHcvM
	 YqPYXJL6xIJsQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/13] block: refactor disk_update_zone_resources()
Date: Fri,  7 Aug 2026 01:04:35 +0900
Message-ID: <20260806160445.848337-4-dlemoal@kernel.org>
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
index 0580f0bc333c..b6970e635671 100644
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

