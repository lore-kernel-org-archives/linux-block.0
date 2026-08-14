Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4681377566
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689139; cv=none; b=O3KHARlxbAX30EvYfzmivltuG+C7uPy0XAGIO0Pqt1N5c4b+bcejdjmSA+mQiP1l1VyYn6+Q2Yi9r5XmKrH+FWi0hUrAcT9TYMdAjtiHneVSq83sv8WTPkqPyGkUft5LDTiG0jJdVuSscdDcJnpT1D05Stg9W1ZrxkGln1YmQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689139; c=relaxed/simple;
	bh=f7HN6aRfockMxD61GMNIa3wfmfzLnQQVc8iBkxlR4oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY0EuU3fCtJ2bePT1vOX6oGiKL47AqibaVQwA0nqxPHXCf5a5J2louU+88GwX30mbV+bnd8xq6Pa8mB7ayRQMXbQvlaOaGFJVyqgGsTiae9k1LHCXejxjRHWgWHGkzWrTz0pWprHa2y3BUw3KWZA915zUH2y9DlO3OCeqSTkZw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/nMXrT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/nMXrT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC591F000E9;
	Fri, 14 Aug 2026 06:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786689137;
	bh=Wc5B+D9axaJhG8aoV90769ogEdg5HcCJC1VCHX4HzGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k/nMXrT1xjTeNtI13cuZDOeXSLSzOWw8zuUW1h5t2F2fFfahCnPSFmJ0WZNPXjyKR
	 gl7fvLCngSCUywyBnr8lA1648ZuBqeYADnPG9maSWuw71aRwNgKBUAKRdbaekL1KNe
	 MOT/NoFohwuvEFi5H2tP2pjmBvP52uwd+YKExZ4nNt9Q3287KWgRpCwH0sJvK+0zwN
	 AbScYmdzB+3QJWYTWXnmtXiery/0jZxOuj1lpVu2IONRXIDj+yiwxges4EHXb5G9aB
	 +8nux2Rjqa7glfgIYgBjL7Q4i7wX0PBFDr8AzVGrrmL17xgcTwXl8lUxzObgrGi8f7
	 AiTnENOCKzJ+w==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 05/13] block: refactor bdev_zone_is_seq()
Date: Fri, 14 Aug 2026 15:31:53 +0900
Message-ID: <20260814063201.1762743-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814063201.1762743-1-dlemoal@kernel.org>
References: <20260814063201.1762743-1-dlemoal@kernel.org>
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

