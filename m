Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FB83B6354
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147697; cv=none; b=Ilpz6gzUma/lY6k/H+A0RiqmNW6ZnimQ5LLOIjKMnCFCn/jJmncS9ObnhJixUIcWADOg65vPZMswEG6nj3TA/3QhrZzAgj7xshzgKin3H0Fc6t1pvbxxXbQVseLum2P4rIuT+SiNgZjdWDsFDGRCo35adt3z5WWBG4c8Gt91yvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147697; c=relaxed/simple;
	bh=BiqXUxOAimfUnEO3pizTpA5IhqZqr2LRtgr1VUm4A8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ER02EvnQP6Vs52A68eZdJY3zc4RungLu1N/rG7MVEkHEujTiW0/UbQ2axAyFhuRObWLwvsVpsKFpkA74zn49Zk+4lBeGQxS1btdE1pDkN8vQanft6yeVmYCNqdL8Ao7k9eLLb9xCiDIHp7YDrLv5VBZbQrnLoeGwqUKUtrYh50o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMm8ce7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMm8ce7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5D01F00A3F;
	Mon, 31 Aug 2026 03:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788147684;
	bh=29yrWh05NMYzdonMP6seb06QiUpdL/Jeq3kYqy8hITA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMm8ce7ZZvrqLBslEaaIP44L492/Wh4osAOJ3t1JjOvksm+NJXVTtn6sTfxnFf3Dy
	 ssV0SzzvS4CJaZ0OYA7pMnTj4/ArkgyA3DR/Xoms7Z1fnR68lQ91SAelm3q7GAbve+
	 IEcty8jrZ9CFg0rpwbuA6FOiTb6aauAhrAAC7vcepl30RtZoOP19BinKauOCG5F6Dd
	 l2YjBs1Us3rS7VSD8ykhus55ZhV9prnUuscX1OOUw0yB1xpTYn5tvMVzzE0RQPtVR+
	 D5QUkcIAO0mgrr/zqogJ2CO8KmB5e/SpvsY6bhpEygEKq56yF0g86HOIkJcHEJ+Aee
	 JUcw50ijuLJPw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 03/12] block: refactor disk_update_zone_resources()
Date: Mon, 31 Aug 2026 12:41:00 +0900
Message-ID: <20260831034109.744039-4-dlemoal@kernel.org>
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

Since the function disk_update_zone_resources() does a lot of checks
beside updating a zoned disk limits and resources, rename this function
to disk_revalidate_zone_resources(). To keep all checks together, move
the capacity check in blk_revalidate_disk_zones() to this function and
simplify it by moving the check on the number of zones before the call to
queue_limits_start_update().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0c298fefecf8..f96953befcb6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2038,11 +2038,11 @@ static int disk_init_revalidate_args(struct gendisk *disk,
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
@@ -2050,19 +2050,24 @@ static int disk_update_zone_resources(struct gendisk *disk,
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
@@ -2106,7 +2111,6 @@ static int disk_update_zone_resources(struct gendisk *disk,
 commit:
 	ret = queue_limits_commit_update(q, &lim);
 
-unfreeze:
 	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
@@ -2301,7 +2305,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
 	sector_t zone_sectors = q->limits.chunk_sectors;
-	sector_t capacity = get_capacity(disk);
 	struct blk_revalidate_zone_args args = { };
 	struct blk_report_zones_args rep_args = {
 		.cb = blk_revalidate_zone_cb,
@@ -2313,7 +2316,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
 		return -EIO;
 
-	if (!capacity)
+	if (!get_capacity(disk))
 		return -ENODEV;
 
 	/*
@@ -2357,18 +2360,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
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

