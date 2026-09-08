Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3E4A9D4B
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857895; cv=none; b=dt4oT2Leb8YdI2PCijdbXNNkCas+1n+xXTtNep9pFtlEHFToB1sr9BhJ5nxAiA1J7lN96MC+5B8ZnoYNZgcZwQCSYUc5x9tUL6oK8iOMdXNfQ/LbIltJsnyQt8ao4y0fL4zummhtL8jHS1AH0kqA+eatr4iRpR41JOkk/zb0Sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857895; c=relaxed/simple;
	bh=YDj50WIYBp+Tb8kwyNbJk9jXep2hvxbfS7zpp4wrbdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=palLUsYdaBPGhq+MojyBQ1ayejEqcRoPOclA2Cp0vaGZdl/4EglBFhH7F/UaLYmah4EUu/0M9eTfri/zuboSVznqi5alaiLATpOo9whpkLbe7icndZ6lid9iaQ/npzS13gxedMBevmoGTYhlWBFAd+yHtmgxIkIwgroGxxAvEGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie2uxx5j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie2uxx5j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FEF1F00ACF;
	Tue,  8 Sep 2026 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857881;
	bh=H09OZXlnOsXAyespN4MYdNRfNjl+tZaF3R7vXpQt6SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ie2uxx5jUL/z9M8Gdaej4xBLUmR66EkNXqJPb3PugNKVEGVmzmF3fYgP7sftetm2z
	 FyRwSFyvR8bIM6dKIAiBOlebAaxUA6Lqn6fZKjUt5l5ExSrbj+gswdOw5xL3wWknQv
	 W3cZFnb16VEVzedvxNtGnsnYf3PyUqTMe0JIvBxlZkTcK9Aj1vtKK55yQqfzOu7QDJ
	 biyIKjbrC2O2fq0cC29abA3JTMDAPDFmHo47H/j22oZ0LCuTGMlOs13sg0ldm6cBbQ
	 9UlpCbQ1tGVaTvTkvRH9e5Cb608raGsWv3KIwN60z3qk4B+oPc+c4e9inj9H50kxKe
	 mLCUbadeNni2g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 06/16] block: refactor bdev_zone_is_seq()
Date: Tue,  8 Sep 2026 17:57:35 +0900
Message-ID: <20260908085745.1082697-7-dlemoal@kernel.org>
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
index 1284cc8cc367..14c88d11f243 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -260,6 +260,29 @@ static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
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
@@ -269,21 +292,10 @@ static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
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
 
@@ -1521,7 +1533,7 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	}
 
 	/* Conventional zones do not need write plugging. */
-	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
+	if (!disk_zone_is_seq(disk, sector)) {
 		/* Zone append to conventional zones is not allowed. */
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 			bio_io_error(bio);
-- 
2.55.0

