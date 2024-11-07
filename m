Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C215B0F2
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730961782; cv=none; b=vFg15Xu/ACIU06EGsmYlvJBEjD3h2BCJZUx2SZGjYIG2eyE38K/Oz0RY3CiFIsP307oucpvY3QimfNu0n734IK4ZPBB3QI2H635axPCBg1qSeOldEyIwXvNEAhKcGqCyV65w8YJAPAyaWgPBwqhW7sfcKimf5jHCHsG13wd8Y7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730961782; c=relaxed/simple;
	bh=c9J/W68ja/bG8M6HEQisFBurSiGwwMsrgytfNTJPgS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERvTUq5hGz/bhD0viClynYOFaiBP/3mB2f2ExbCv2DKmyPUHlowrFZ9AydeYJCH9y03BU9em8ovxP5tcRZQw66PywpwcebFhMIhJxEqqwE37hMrUFO0KW1tgM8FzijKZgaEqeHIpwD2js8i0KVx+Wiy7vCa7nHABJD0nwzrZeDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzR6QPkE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzR6QPkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084BEC4CECD;
	Thu,  7 Nov 2024 06:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730961782;
	bh=c9J/W68ja/bG8M6HEQisFBurSiGwwMsrgytfNTJPgS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rzR6QPkEERkZabzw368b+3b6Yfk708K0yJLhk8ZIOamQ1R38QLqxM0v66KkCkmxxm
	 4K87PHlm956UFc/YA6887ibefg0jBLA3WKDjVM0qLvIj5jT2dXcjlY1RGo7HAn7TJV
	 AM0wZD567kk9EjpznaQOlGC+dAg4a05J6nZA5PhAZ65f6qaxWDuOyPPZVx5RRt/KZQ
	 SHdHWDyy0CnC4TCylJTQtiYslxUSenUTu6k5lQqRELMmZhDvC9/XWwAGUrtr2vxGmM
	 rj8KgakNy8nV8kzz/xZpNYsS6DW+M+yROmOkietPkpRZIdgCJcEoZC7a732/iRROd8
	 CwnJiFrHN6iZQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 1/2] block: RCU protect disk->conv_zones_bitmap
Date: Thu,  7 Nov 2024 15:42:59 +0900
Message-ID: <20241107064300.227731-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107064300.227731-1-dlemoal@kernel.org>
References: <20241107064300.227731-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that a disk revalidation changing the conventional zones bitmap
of a disk does not cause invalid memory references when using the
disk_zone_is_conv() helper by RCU protecting the disk->conv_zones_bitmap
pointer.

disk_zone_is_conv() is modified to operate under the RCU read lock and
the function disk_set_conv_zones_bitmap() is added to update a disk
conv_zones_bitmap pointer using rcu_replace_pointer() with the disk
zone_wplugs_lock spinlock held.

disk_free_zone_resources() is modified to call
disk_update_zone_resources() with a NULL bitmap pointer to free the disk
conv_zones_bitmap. disk_set_conv_zones_bitmap() is also used in
disk_update_zone_resources() to set the new (revalidated) bitmap and
free the old one.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c      | 43 ++++++++++++++++++++++++++++++------------
 include/linux/blkdev.h |  2 +-
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a287577d1ad6..bf4458b11720 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -350,9 +350,15 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
 {
-	if (!disk->conv_zones_bitmap)
-		return false;
-	return test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
+	unsigned long *bitmap;
+	bool is_conv;
+
+	rcu_read_lock();
+	bitmap = rcu_dereference(disk->conv_zones_bitmap);
+	is_conv = bitmap && test_bit(disk_zone_no(disk, sector), bitmap);
+	rcu_read_unlock();
+
+	return is_conv;
 }
 
 static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zone)
@@ -1455,6 +1461,24 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	disk->zone_wplugs_hash_bits = 0;
 }
 
+static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
+					       unsigned long *bitmap)
+{
+	unsigned int nr_conv_zones = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+	if (bitmap)
+		nr_conv_zones = bitmap_weight(bitmap, disk->nr_zones);
+	bitmap = rcu_replace_pointer(disk->conv_zones_bitmap, bitmap,
+				     lockdep_is_held(&disk->zone_wplugs_lock));
+	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
+
+	kfree_rcu_mightsleep(bitmap);
+
+	return nr_conv_zones;
+}
+
 void disk_free_zone_resources(struct gendisk *disk)
 {
 	if (!disk->zone_wplugs_pool)
@@ -1478,8 +1502,7 @@ void disk_free_zone_resources(struct gendisk *disk)
 	mempool_destroy(disk->zone_wplugs_pool);
 	disk->zone_wplugs_pool = NULL;
 
-	bitmap_free(disk->conv_zones_bitmap);
-	disk->conv_zones_bitmap = NULL;
+	disk_set_conv_zones_bitmap(disk, NULL);
 	disk->zone_capacity = 0;
 	disk->last_zone_capacity = 0;
 	disk->nr_zones = 0;
@@ -1538,17 +1561,15 @@ static int disk_update_zone_resources(struct gendisk *disk,
 				      struct blk_revalidate_zone_args *args)
 {
 	struct request_queue *q = disk->queue;
-	unsigned int nr_seq_zones, nr_conv_zones = 0;
+	unsigned int nr_seq_zones, nr_conv_zones;
 	unsigned int pool_size;
 	struct queue_limits lim;
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
 	disk->last_zone_capacity = args->last_zone_capacity;
-	swap(disk->conv_zones_bitmap, args->conv_zones_bitmap);
-	if (disk->conv_zones_bitmap)
-		nr_conv_zones = bitmap_weight(disk->conv_zones_bitmap,
-					      disk->nr_zones);
+	nr_conv_zones =
+		disk_set_conv_zones_bitmap(disk, args->conv_zones_bitmap);
 	if (nr_conv_zones >= disk->nr_zones) {
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
 			disk->disk_name, nr_conv_zones, disk->nr_zones);
@@ -1817,8 +1838,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q);
 
-	kfree(args.conv_zones_bitmap);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6d1413bd69a5..5687eb2a019c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -195,7 +195,7 @@ struct gendisk {
 	unsigned int		nr_zones;
 	unsigned int		zone_capacity;
 	unsigned int		last_zone_capacity;
-	unsigned long		*conv_zones_bitmap;
+	unsigned long __rcu	*conv_zones_bitmap;
 	unsigned int            zone_wplugs_hash_bits;
 	spinlock_t              zone_wplugs_lock;
 	struct mempool_s	*zone_wplugs_pool;
-- 
2.47.0

