Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4621B4C35;
	Sun, 24 Nov 2024 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452030; cv=none; b=uy3m4BkLxgU+ZIlseUCdqASMDQ161LtNFratRlmMe+hYq/dNVUXXbHMAWeOyx8wGsHPCYUtbxo7vr+lAWowtPbetSeR8ypBhOAOurXRZG9t2XmauHp8b9VCtVUfgfZmhadPD73D9gBKzgmwrdMcplFod3WoXSCpFfjH6GIXDVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452030; c=relaxed/simple;
	bh=KTfCYc6h3kcuPD3tzTwJCQ/vsS7zuOHczUbuje/d6bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pfi8dchr7ie6O/IH/RR3a70toEZfhj2cwpv5POUaG0fZTJK2fZ6NZlaaYxzUJ64jkxyrQdVPpA/Yht5PV7SI974JWmeOX3COVDQh5watrtEk3xe+juEfolg3ha/Pz/gpaxrM/49MfiJ/LIYFGvWK++u8+OBHPFlzSXUFTvCuwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOBlu8p8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOBlu8p8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DD0C4CED3;
	Sun, 24 Nov 2024 12:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452030;
	bh=KTfCYc6h3kcuPD3tzTwJCQ/vsS7zuOHczUbuje/d6bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOBlu8p8ZRhhAaYXcPlttemfZlJbqMhJLzT9MheYAE8sFICX5d/c0DQM7La1/DrT5
	 3KI7GG3ximo0mofvFgkcM4Oi0d5eOENYZMcmFoCNVHit76foZqLn+D3KwR3YbpsxeK
	 FGxKxXREXFKCIOTfg1Zxxx7mmzIzjm3NF0WxibSbDOXmuaTM5uF/3PRCjptHDkeX2x
	 mwcxqiFSLj8OGnox9o54YSyujuAVJAssF7K0J5qcFFWhJCq0fWoWsNz/i65QA3kWfn
	 FuF7HnrT/Yzg5gWxcesDtaQQ+I4x2Qc6ej3bZzI0HeczwOviOgtygcTEXENf+fuzdp
	 Nj6vvAaRz2ibQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 07/16] block: RCU protect disk->conv_zones_bitmap
Date: Sun, 24 Nov 2024 07:39:44 -0500
Message-ID: <20241124124009.3336072-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124009.3336072-1-sashal@kernel.org>
References: <20241124124009.3336072-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit d7cb6d7414ea1b33536fa6d11805cb8dceec1f97 ]

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Link: https://lore.kernel.org/r/20241107064300.227731-2-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-zoned.c      | 43 ++++++++++++++++++++++++++++++------------
 include/linux/blkdev.h |  2 +-
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index af19296fa50df..74e39545562d5 100644
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
@@ -1823,8 +1844,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		disk_free_zone_resources(disk);
 	blk_mq_unfreeze_queue(q);
 
-	kfree(args.conv_zones_bitmap);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b7664d593486a..44f084811de23 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -194,7 +194,7 @@ struct gendisk {
 	unsigned int		nr_zones;
 	unsigned int		zone_capacity;
 	unsigned int		last_zone_capacity;
-	unsigned long		*conv_zones_bitmap;
+	unsigned long __rcu	*conv_zones_bitmap;
 	unsigned int            zone_wplugs_hash_bits;
 	spinlock_t              zone_wplugs_lock;
 	struct mempool_s	*zone_wplugs_pool;
-- 
2.43.0

