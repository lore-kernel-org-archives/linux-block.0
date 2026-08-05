Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5563C13F9
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896857; cv=none; b=uZsKBRcctbt260QLJ9+F87eugNqpDPNXWFTJYFHpHQrhfjrEwRrDBr8/xB50vrYZjzOyQPeT4zPK8SzaCiPUkp820pPw6YS4O0D3E6iy1wHyZ1F3PnTboyn7f44DpMJIiz39DudC2y6MT7Vflev54q804rt5yQha2HA1ttT26SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896857; c=relaxed/simple;
	bh=MdgTq7kOZXJgseZ6dDNS0TsarUI4v/Qy9771/tIoec4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWB3wgtldipJ8NcaYEOYNdD018EtHMM4oZKZQFUXItdocHwzAtL95gaGDcBpwbHwLcAduNe2EcT5JHFsvfYXxhsZh4eTEMJxT82x8GlSzmyGPiZPGygOirNq6UsZHlkkXcxmDn7Ua53AxZcPyOYNttxDfLtOD7/A/QmMfIbBtAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqcOYxUs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqcOYxUs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0331F000E9;
	Wed,  5 Aug 2026 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896856;
	bh=cCe9bt+TFKCNuIOhYA3fRyd+U+b6lywh42hdG61MHaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UqcOYxUs85BhbKi3At0deB6VoEniBX61N1iyMgPdBelmv0oOwD/TxAQ9MoQ+obXsB
	 /rdqo/37Q8Bcd0JkZRDtdy/SwO1lCw+qS8JheTdiGxqqMb7voHp0eRCgF4HwJjg6Le
	 Zmi0+Jz0nsIrvNxvTZ3BtiRS6J8T+CMW5p+ivj2D9iXAlWqz3xKWWYgZvxdetMah5K
	 /MjfTj6ji0cr4WtgKNz075lg+/g0lektL6+O+dRyXjCgEFIqbDTS/5Fw+0tZ/VCW0P
	 vIKyxz0U6d6QQsLSZqlGVulIqph5ovIQfN+9K7VV5vuj/r3vnBuzVya4i7c/8i8ycn
	 Iv71qWEYhQdRg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/14] block: refactor bdev_zone_is_seq()
Date: Wed,  5 Aug 2026 11:27:10 +0900
Message-ID: <20260805022719.735323-6-dlemoal@kernel.org>
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

Define the helper function disk_zone_is_seq() and use it to refactor
bdev_zone_is_seq(). disk_zone_is_seq() is also used in
blk_zone_wplug_handle_write().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e5afef2bd7f1..60adc9a4c853 100644
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

