Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315183B813D
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032302; cv=none; b=VQ1B/ZZPT060QvuWm0juCvKthoFdJyQ5t8ym3iP47NeXdXKjkReoEy6Q3l/B2YG4HYJy72TszxMy0l31yYc220uTRQjk7SrbWfVtl7Kw+mGoCQENazOB9sWbEWvFat/MImtEHr3zFUg6D/pHmg2IKVTCtCLQlLfM4xXL7tWYnlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032302; c=relaxed/simple;
	bh=quPUuF/eVO2SkaSJ6T0OG+vmWcCqrRXv5svh0NU6XTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdZgxubBwhdrOUt33dMRcLVzE2BtLZUA+PvO/BA1HF6fLQV34J5f+ChNNaqoz4nIJIp4yMFOoptaM4Xqn89Q4V5fWM6+kOh8tBmrPMl7eLed3wOWEV1/a8x6qvKeGTG7aINZ0M2ZVVM2XOrqKjDg4niqeRSBU3iU1uQ7IzYjtxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaT/Dkd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaT/Dkd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32451F00A3D;
	Thu,  6 Aug 2026 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032301;
	bh=Kr7nni49KafcHS+goFEt7zaSwspWmj8jBMzrlbt+lWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IaT/Dkd/bA9c8BNEH0q5Muqtzf7l+a1ZOGZZX51jCcCCO9erCTf7Du27prFma7JTu
	 wjGmnGSXI6g/GUS6YN/+SD3EOAYPlSwVSKXjqGv66uwJE+YoChMs2JcTEqfDRAgltG
	 1MkvV7oZWhTqACcV+tX1VyfZeOrV1Blpvh1BShutkeCqaDMg4dzWoyGHfVHgmuzh3y
	 Tuz8d/IhSZv0GrLzipr5bF5R4v1xuugq74TBakFupP96JN8bIdff0uVKa2Xc51U8vP
	 B3TdNjaFdBfSHBu8L3um4+vC5Ka8V1wZehr7jHFtxIXm12dO6f+6AMJhwgJo1r6kJ3
	 3HDT95spQqq+A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 05/13] block: refactor bdev_zone_is_seq()
Date: Fri,  7 Aug 2026 01:04:37 +0900
Message-ID: <20260806160445.848337-6-dlemoal@kernel.org>
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

Define the helper function disk_zone_is_seq() and use it to refactor
bdev_zone_is_seq(). disk_zone_is_seq() is also used in
blk_zone_wplug_handle_write().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 50b98c394b50..c1090155d961 100644
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
+		zs = 0;
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

