Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AC920CCF8
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 23:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934806; cv=none; b=O7P/RdRJXyH/yeKndemhXMQFYu07BFOU2fjXNBbROaC+V1DZPojlnVV2sz2sWfj+1jLz1hJcXDC2gN5xzK3LmRlJ+xIYTQqYMy7mYCCHmXmbIJw4AWRl64lLYnCDQoVKrXc8eDemq7LRvMLJQX3lY8BLDx7WZbv4E3l9tA6jkEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934806; c=relaxed/simple;
	bh=1N5Goib5K31T0qp1Ch2dr3g+MKAz7jdOq9xDH+foR5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohlHP8iVpwFxLOnDVEQMXkDCPS9zksJPH5ZTT3OZtKzrQCA6oVlVihjy3lyFr0tfzevshri70N2nTugc0e3HOQQVftYzkjPSiknWxRRIARLW8I7jgA6JPVv9mc2zDzhWRw/cIM/H34nzvzlpxIWVpF6JwzbNFruWvCYnwblZnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLHJBkNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLHJBkNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572F4C4CED0;
	Wed,  6 Nov 2024 23:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730934805;
	bh=1N5Goib5K31T0qp1Ch2dr3g+MKAz7jdOq9xDH+foR5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLHJBkNXEOOhZSjQewc4IEWZrvQ6XPQO2HrqDbOGF+G5hYC9UHbJ2YS+nQ/GmfhwM
	 H4Exc6GlfPIC7cqUivbBoI9EdXHgu2Unweo6hq8JPyFxvzC/Ua9FVu34S3l515CYG/
	 Ak1wsMjErVzgQTlyRu9cUj7k+NgnqA6XGxCk1GX5H9jxkCyV+4/zb0MxIRydxsnC1H
	 DGUNBP5QnsJlXHwFochL7KCQ2v21g27THkZuUiQYnPODMQtvmIDjKKdkuLt1LI3hil
	 yYF0+5YTc6HTCk5j/SSCO+WNp1dUICgmtWa0lt2/ZkSmfYdm2OlDZX+q1Nkgieq8T6
	 HOsyOgTBDAZmw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] block: RCU protect disk->conv_zones_bitmap
Date: Thu,  7 Nov 2024 08:13:22 +0900
Message-ID: <20241106231323.8008-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106231323.8008-1-dlemoal@kernel.org>
References: <20241106231323.8008-1-dlemoal@kernel.org>
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
index a287577d1ad6..7a7855555d6d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -350,9 +350,14 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 
 static inline bool disk_zone_is_conv(struct gendisk *disk, sector_t sector)
 {
-	if (!disk->conv_zones_bitmap)
-		return false;
-	return test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
+	bool is_conv;
+
+	rcu_read_lock();
+	is_conv = disk->conv_zones_bitmap &&
+		test_bit(disk_zone_no(disk, sector), disk->conv_zones_bitmap);
+	rcu_read_unlock();
+
+	return is_conv;
 }
 
 static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zone)
@@ -1455,6 +1460,25 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	disk->zone_wplugs_hash_bits = 0;
 }
 
+static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
+					       unsigned long *bitmap)
+{
+	unsigned int nr_conv_zones = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
+	bitmap = rcu_replace_pointer(disk->conv_zones_bitmap, bitmap,
+				     lockdep_is_held(&disk->zone_wplugs_lock));
+	if (disk->conv_zones_bitmap)
+		nr_conv_zones = bitmap_weight(disk->conv_zones_bitmap,
+					      disk->nr_zones);
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

