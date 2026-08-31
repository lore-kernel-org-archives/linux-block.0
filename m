Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13C3B71D1
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147709; cv=none; b=FLr8IAdTitSob1qA3bPxmTjCJbhF+EqsguTDr7Ak9e23MkbQO4DtaWx11rRVEh/56y4w0aQQSpS4i1gPY487XZx3DAisYpBuoew7pvwrwAzXPMcB66YESpQ4BeZblyoDOGLgJpu5IW5OoVcI5nGLBnkMaPS2HGEoGl++stG/x8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147709; c=relaxed/simple;
	bh=W2bLz+tYD3jmuxlLXpT/9pAVcQNR/heVPR6wi2z8MyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ja6RsmV+gvX3D4OPVyoq6vh55gBqbCB+Ve2rfG3sF1DPOGO9Tt+c5VTweGAGCDJNAAUB3FmfnT8Fpr6K7hLVdU+hVf0Ch49frt1lMuTULXuPLRI2uSWakCYNDx9nPJCbGeVTS59Iwbx9dFnM4lwJIA1NjP+IrelKDD7JQK7LFgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi2r/Vqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi2r/Vqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A226B1F00ACF;
	Mon, 31 Aug 2026 03:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788147686;
	bh=thuUKVd7MTvgD/OnPFueIfUBahEpo9gtN24lEpGUDGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wi2r/VqqCEA4jjikBsHFJ6sTS5hDa0cDoY16ODtqOVAnlDlEmMBE5erlMl8k7bd98
	 nSIj2igXzbBxrEM3y62OdQjzUWB6ENy/5fpRWwx7BK8Qcx/EXa+NsgTfPbKh/hruu8
	 GPYVZcHxgGNHOGFYgB9VCIqdVD1nw/TI4bWkUROfZbl2Faxtugb6XCk1EjeJHT4ctk
	 SZxZabtiakBVxtcVZG3HEIiJrhU9yEFAlGXQDMnni/mA9uuM7LrXBKLsVq0zV85anx
	 uJXvNyPOrsTUOR06zc4dh25h6USx4rOHqbN+2sDEjI25GPjVxI7Y468b6p3Kn+I5AE
	 XJGFqYp68P+uA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 05/12] block: refactor bdev_zone_is_seq()
Date: Mon, 31 Aug 2026 12:41:02 +0900
Message-ID: <20260831034109.744039-6-dlemoal@kernel.org>
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

