Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B53321A7
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715287; cv=none; b=UI2ii7XWw18Kpg0wV1wbMzc6N2eo/K2ieDqI/lvHXOq/bFSztFuUqA63jp1EaDrV2piXLqtuIv4/ghIZhDhohjV1MeYa6IeWR9HsRixTW2qO8EE0FfHmW+tXv4n047hWEqZw2e0UKryMa+P5KV3UmHLD28B4bQpAOsrVjjrPYgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715287; c=relaxed/simple;
	bh=W2bLz+tYD3jmuxlLXpT/9pAVcQNR/heVPR6wi2z8MyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NssUHx4JJl2lilxsDM+iem1BqQjzMamh0OnNmeafj9Phfr/VReWDbM6Q2VLb0+ZB1NuH4+qLXEP3UDbIk6HIKm4v6NGM+brAn0uCUBomufpxcz7sakoBBXDd+ujAu6OOA/cDL9I/uKxjHnG40lXZ0HlC7wE3DlXTotpleEq0iGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0Sa2P8m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0Sa2P8m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F6C1F00A3D;
	Fri, 14 Aug 2026 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715285;
	bh=thuUKVd7MTvgD/OnPFueIfUBahEpo9gtN24lEpGUDGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M0Sa2P8mqm2S75tRZ7gSsAsql9FD3uV5cWL5tSKgz6f7bdGuZfBHWilm4ZoRy/B/K
	 wUXxvwjwLeFgJsBztAhTPxuLNUPuMG0FhJ7osrqN1u/DmLkZOmZuJiSav6xnx2AE3Q
	 YKARUby0edp6YgXjQqbKBXkB/bNgPQWcETI5+zDW60s0LLUOf392L+k+EPVHOh4MV2
	 TD/xQoeDMuuVMzdD5R2HkSz1AtABwQp3P578codvNZyqZ7TjNup2nNu0eKL2G0Kzk5
	 V9iM583O7GKOTzh+I4kuZXXDP0XamuLvvksdmsheVzqLQi8/blchE4iYszjavN8cro
	 fN1nj6QR3InYw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 05/13] block: refactor bdev_zone_is_seq()
Date: Fri, 14 Aug 2026 22:47:42 +0900
Message-ID: <20260814134750.2100304-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814134750.2100304-1-dlemoal@kernel.org>
References: <20260814134750.2100304-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the helper function disk_zone_is_seq() and use it to refactor
bdev_zone_is_seq(). disk_zone_is_seq() is also used in
blk_zone_wplug_handle_write().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7d17f7f7ae95..e3c28db5690c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -261,6 +261,29 @@ static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
 	rcu_read_unlock();
 }
 
+static inline u8 disk_zone_get_state(struct gendisk *disk, sector_t sector)
+{
+	unsigned int zno = disk_zone_no(disk, sector);
+	u8 *zones_state, zs;
+
+	rcu_read_lock();
+	zones_state = rcu_dereference(disk->zones_state);
+	if (likely(zones_state && zno < disk->nr_zones))
+		zs = zones_state[zno];
+	else
+		zs = BLK_ZFLAG_CONV;
+	rcu_read_unlock();
+
+	return zs;
+}
+
+static bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
+{
+	u8 zs = disk_zone_get_state(disk, sector);
+
+	return !blk_zstate_is_conv(zs);
+}
+
 /**
  * bdev_zone_is_seq - check if a sector belongs to a sequential write zone
  * @bdev:       block device to check
@@ -270,21 +293,10 @@ static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
  */
 bool bdev_zone_is_seq(struct block_device *bdev, sector_t sector)
 {
-	struct gendisk *disk = bdev->bd_disk;
-	unsigned int zno = disk_zone_no(disk, sector);
-	bool is_seq = false;
-	u8 *zones_state;
-
 	if (!bdev_is_zoned(bdev))
 		return false;
 
-	rcu_read_lock();
-	zones_state = rcu_dereference(disk->zones_state);
-	if (zones_state && zno < disk->nr_zones)
-		is_seq = !blk_zstate_is_conv(zones_state[zno]);
-	rcu_read_unlock();
-
-	return is_seq;
+	return disk_zone_is_seq(bdev->bd_disk, sector);
 }
 EXPORT_SYMBOL_GPL(bdev_zone_is_seq);
 
@@ -1522,7 +1534,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	}
 
 	/* Conventional zones do not need write plugging. */
-	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
+	if (!disk_zone_is_seq(disk, sector)) {
 		/* Zone append to conventional zones is not allowed. */
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			bio_io_error(bio);
-- 
2.55.0

