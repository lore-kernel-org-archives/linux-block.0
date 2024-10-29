Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E3F206045
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211586; cv=none; b=q8RnlmKhM9Fmd6MLIgtfo+lCConV1ugdBQ+ijYVxT6ji/nW/qPwBP1QDBgrkqBVAoaeADFDQERFzqhtjUJQuZxzYkdVpPSKhbycRL8Vh7RbvGPoQ4R3+rrReSTjMs0fDAtQhU7QoZIaGJMBMEDHNJOJ9a4XgI0eg4+sVwE89oUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211586; c=relaxed/simple;
	bh=unA474vqNLlHejUqhR6aj0g+xfwZ46KVg7yvTTABG5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uarsxyw5J2k2yqhiiJwPoOlFWAM4p/95hvySSD7FwpfjJonmis5M8jHeYQCpszGrSF9iE2WIZzVvP0KII1QkoTmuDixGjqYKV5PSdWaOua9Rjk1eChGX12cPRicehWAiZYZdjyBr+oxxLq8XL6j0hPbNPdP7GigKzIqcTuaJrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sSkgYki/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSkgYki/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lpkwz/Hq5+900iE7JhgIR8AHZ/MI2DeNvttLnsF5Mxg=; b=sSkgYki/qCkeYqQN25+p4DQ6V4
	NT84dJb2lPWomKx4JKcRyBX4irXhIVHxjt5fmB86T0r3eB8DMtP3mr2+D4TGcVZOFZh+NIxrlagMA
	Z7GT2Xs+Uw9os+A9kF6Q3mnxF+4PvehZgiX3QJiYLdhdNCdGsneVcreMHscNRD+VHS4uKF/36M6Kl
	x0Cx6ybG3UtognuIsEHFxbLJ2M5H2ux3YKQeTN0+PqxsEyEGyasxepigysIGKXV3ZKlNHn5Xz3Jps
	IR1jVRNsc4Om2bPxqD4tY6lzKurxdr5kZiEa/7lg7toX/1FIT9NifEz5LUweOSsg7r9+tWe/GXHhP
	Y5nhjPnQ==;
Received: from 2a02-8389-2341-5b80-1009-120a-6297-8bca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1009:120a:6297:8bca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5n4P-0000000EiH0-3lw4;
	Tue, 29 Oct 2024 14:19:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: add a bdev_limits helper
Date: Tue, 29 Oct 2024 15:19:37 +0100
Message-ID: <20241029141937.249920-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to get the queue_limits from the bdev without having to
poke into the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-merge.c            |  3 +--
 block/blk-settings.c         |  2 +-
 drivers/md/dm-cache-target.c |  4 ++--
 drivers/md/dm-clone-target.c |  4 ++--
 drivers/md/dm-thin.c         |  2 +-
 fs/btrfs/zoned.c             |  7 ++-----
 include/linux/blkdev.h       | 15 ++++++++++-----
 7 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8b9a9646aed8..d813d799cee7 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -411,10 +411,9 @@ struct bio *bio_split_zone_append(struct bio *bio,
  */
 struct bio *bio_split_to_limits(struct bio *bio)
 {
-	const struct queue_limits *lim = &bdev_get_queue(bio->bi_bdev)->limits;
 	unsigned int nr_segs;
 
-	return __bio_split_to_limits(bio, lim, &nr_segs);
+	return __bio_split_to_limits(bio, bdev_limits(bio->bi_bdev), &nr_segs);
 }
 EXPORT_SYMBOL(bio_split_to_limits);
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index a446654ddee5..95fc39d09872 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -661,7 +661,7 @@ EXPORT_SYMBOL(blk_stack_limits);
 void queue_limits_stack_bdev(struct queue_limits *t, struct block_device *bdev,
 		sector_t offset, const char *pfx)
 {
-	if (blk_stack_limits(t, &bdev_get_queue(bdev)->limits,
+	if (blk_stack_limits(t, bdev_limits(bdev),
 			get_start_sect(bdev) + offset))
 		pr_notice("%s: Warning: Device %pg is misaligned\n",
 			pfx, bdev);
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 40709310e327..bc18255380b0 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3361,7 +3361,7 @@ static int cache_iterate_devices(struct dm_target *ti,
 static void disable_passdown_if_not_supported(struct cache *cache)
 {
 	struct block_device *origin_bdev = cache->origin_dev->bdev;
-	struct queue_limits *origin_limits = &bdev_get_queue(origin_bdev)->limits;
+	struct queue_limits *origin_limits = bdev_limits(origin_bdev);
 	const char *reason = NULL;
 
 	if (!cache->features.discard_passdown)
@@ -3383,7 +3383,7 @@ static void disable_passdown_if_not_supported(struct cache *cache)
 static void set_discard_limits(struct cache *cache, struct queue_limits *limits)
 {
 	struct block_device *origin_bdev = cache->origin_dev->bdev;
-	struct queue_limits *origin_limits = &bdev_get_queue(origin_bdev)->limits;
+	struct queue_limits *origin_limits = bdev_limits(origin_bdev);
 
 	if (!cache->features.discard_passdown) {
 		/* No passdown is done so setting own virtual limits */
diff --git a/drivers/md/dm-clone-target.c b/drivers/md/dm-clone-target.c
index 12bbe487a4c8..e956d980672c 100644
--- a/drivers/md/dm-clone-target.c
+++ b/drivers/md/dm-clone-target.c
@@ -2020,7 +2020,7 @@ static void clone_resume(struct dm_target *ti)
 static void disable_passdown_if_not_supported(struct clone *clone)
 {
 	struct block_device *dest_dev = clone->dest_dev->bdev;
-	struct queue_limits *dest_limits = &bdev_get_queue(dest_dev)->limits;
+	struct queue_limits *dest_limits = bdev_limits(dest_dev);
 	const char *reason = NULL;
 
 	if (!test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags))
@@ -2041,7 +2041,7 @@ static void disable_passdown_if_not_supported(struct clone *clone)
 static void set_discard_limits(struct clone *clone, struct queue_limits *limits)
 {
 	struct block_device *dest_bdev = clone->dest_dev->bdev;
-	struct queue_limits *dest_limits = &bdev_get_queue(dest_bdev)->limits;
+	struct queue_limits *dest_limits = bdev_limits(dest_bdev);
 
 	if (!test_bit(DM_CLONE_DISCARD_PASSDOWN, &clone->flags)) {
 		/* No passdown is done so we set our own virtual limits */
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 89632ce97760..9095f19a84f3 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -2842,7 +2842,7 @@ static void disable_discard_passdown_if_not_supported(struct pool_c *pt)
 {
 	struct pool *pool = pt->pool;
 	struct block_device *data_bdev = pt->data_dev->bdev;
-	struct queue_limits *data_limits = &bdev_get_queue(data_bdev)->limits;
+	struct queue_limits *data_limits = bdev_limits(data_bdev);
 	const char *reason = NULL;
 
 	if (!pt->adjusted_pf.discard_passdown)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 826b128a6df0..32ce2edf582b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -707,11 +707,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		 * zoned mode. In this case, we don't have a valid max zone
 		 * append size.
 		 */
-		if (bdev_is_zoned(device->bdev)) {
-			blk_stack_limits(lim,
-					 &bdev_get_queue(device->bdev)->limits,
-					 0);
-		}
+		if (bdev_is_zoned(device->bdev))
+			blk_stack_limits(lim, bdev_limits(device->bdev), 0);
 	}
 
 	/*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d0a52ed05e60..7bfc877e159e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1159,6 +1159,11 @@ enum blk_default_limits {
  */
 #define BLK_DEF_MAX_SECTORS_CAP	2560u
 
+static inline struct queue_limits *bdev_limits(struct block_device *bdev)
+{
+	return &bdev_get_queue(bdev)->limits;
+}
+
 static inline unsigned long queue_segment_boundary(const struct request_queue *q)
 {
 	return q->limits.seg_boundary_mask;
@@ -1293,23 +1298,23 @@ unsigned int bdev_discard_alignment(struct block_device *bdev);
 
 static inline unsigned int bdev_max_discard_sectors(struct block_device *bdev)
 {
-	return bdev_get_queue(bdev)->limits.max_discard_sectors;
+	return bdev_limits(bdev)->max_discard_sectors;
 }
 
 static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 {
-	return bdev_get_queue(bdev)->limits.discard_granularity;
+	return bdev_limits(bdev)->discard_granularity;
 }
 
 static inline unsigned int
 bdev_max_secure_erase_sectors(struct block_device *bdev)
 {
-	return bdev_get_queue(bdev)->limits.max_secure_erase_sectors;
+	return bdev_limits(bdev)->max_secure_erase_sectors;
 }
 
 static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 {
-	return bdev_get_queue(bdev)->limits.max_write_zeroes_sectors;
+	return bdev_limits(bdev)->max_write_zeroes_sectors;
 }
 
 static inline bool bdev_nonrot(struct block_device *bdev)
@@ -1345,7 +1350,7 @@ static inline bool bdev_write_cache(struct block_device *bdev)
 
 static inline bool bdev_fua(struct block_device *bdev)
 {
-	return bdev_get_queue(bdev)->limits.features & BLK_FEAT_FUA;
+	return bdev_limits(bdev)->features & BLK_FEAT_FUA;
 }
 
 static inline bool bdev_nowait(struct block_device *bdev)
-- 
2.45.2

