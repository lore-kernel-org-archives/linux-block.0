Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF40344030
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 19:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372352; cv=none; b=uJs4wdHrXLj/mikcmjTuM45r6A2vqvQJ/IKWmICGL2xGnxHAh71qHbeBwc5EZ5Qy1uR4weu5UXan5J3ViZnklKaQuPZVoj4tkR4SDM8rW6fYDVly/KmH86ZXcYQ8YtE8WiX+USJLDB4b0zd1EzYCoagoFNpv6rdNHGLCGWyRCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372352; c=relaxed/simple;
	bh=+Y5m8JQdieL3HIu4PqnawUIliKKbKgtcWSYcVjbQXrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdP0tPHpvETpHVjprqozgsiQo98kQLKLo7MNiuzAzXrkRfGRVR0owXLKpd2VJu1WdYdVWt4GNAGrAeffTBwZEV6aTDKxvCt79ZMds+Is6SO04rVVzFD6tV1TY+k+muwfCQj/5AQ227qXb/TY1UKMZrjVB3dJD7xbnKLQBmUPyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h7gmvB+w; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h7gmvB+w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kW1TC5YYinVB8IsJBIoaXxkSO5yi6HdbwLYvRhJ7Y+Y=; b=h7gmvB+wgWsscsb0DeFI5fB+4o
	A0Hagnb2YXkyvyTl/uu+Y96zUUg/JAGxkpR8HKXPEpSwjjXEdo9+rLM3foJTopyb7iZ3iHnEoUYJh
	XbIpBJGkT1bYF2CkJK/tQjSdQMWl91s0mu6r3RVxP8welB0U0fv2Q2C7Nu9Oig2ZN3r1fk5RWF/u7
	OyEdHom+BmMpQ1Jwbr1NOrfdCnr7w7Z766XI7dKIfMR5TRfni5OqHzspIRfxnraHNqPhdon5QmF8V
	GDWOdvg2jq397+w9xmwpH8s+Vv3RMs6jWiBUaJuvgu6FsZJlFtZJz6wZgIjb+XyZd8TNg6jpgaKwa
	pX96/vmw==;
Received: from [207.253.13.66] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGjYU-0000000EKwK-00sZ;
	Wed, 05 Nov 2025 19:52:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: fix cached zone reporting after zone append was used
Date: Wed,  5 Nov 2025 14:52:15 -0500
Message-ID: <20251105195225.2733142-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105195225.2733142-1-hch@lst.de>
References: <20251105195225.2733142-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No zone plugs are allocated when a zone is opened by calling Zone Append
on it.  This makes the cached zone reporting report incorrectly empty
zones if the file system is unmounted and report zones is called after
that, e.g. by xfstests test cases using the scratch device.

Fix this by recording if zone append was used on a device, and disable
cached reporting for the device until a ZONE_RESET_ALL happens that
guarantees all zones are empty.

We could probably do even better using a per-zone flag, but the practical
use cache for zone reporting after the initial mount are rather limited,
so let's keep things simple for now.

Fixes: 31f0656a4ab7 ("block: introduce blkdev_report_zones_cached()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c      | 26 +++++++++++++++++++++-----
 include/linux/blkdev.h |  1 +
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a0ce17e2143f..c5226bcaaa94 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -899,6 +899,19 @@ static int blkdev_report_zone_fallback(struct block_device *bdev,
 	return blkdev_do_report_zones(bdev, sector, 1, &args);
 }
 
+/*
+ * For devices that natively support zone append operations, we do not use zone
+ * write plugging for zone append writes, which makes the zone condition
+ * tracking invalid once zone append was used.  In that case fall back to a
+ * regular report zones to get correct information.
+ */
+static inline bool blkdev_has_cached_report_zones(struct block_device *bdev)
+{
+	return disk_need_zone_resources(bdev->bd_disk) &&
+		(bdev_emulates_zone_append(bdev) ||
+		 !test_bit(GD_ZONE_APPEND_USED, &bdev->bd_disk->state));
+}
+
 /**
  * blkdev_get_zone_info - Get a single zone information from cached data
  * @bdev:   Target block device
@@ -932,6 +945,9 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 	memset(zone, 0, sizeof(*zone));
 	sector = ALIGN_DOWN(sector, zone_sectors);
 
+	if (!blkdev_has_cached_report_zones(bdev))
+		return blkdev_report_zone_fallback(bdev, sector, zone);
+
 	rcu_read_lock();
 	zones_cond = rcu_dereference(disk->zones_cond);
 	if (!disk->zone_wplugs_hash || !zones_cond) {
@@ -1035,11 +1051,7 @@ int blkdev_report_zones_cached(struct block_device *bdev, sector_t sector,
 	if (!nr_zones || sector >= capacity)
 		return 0;
 
-	/*
-	 * If we do not have any zone write plug resources, fallback to using
-	 * the regular zone report.
-	 */
-	if (!disk_need_zone_resources(disk)) {
+	if (!blkdev_has_cached_report_zones(bdev)) {
 		struct blk_report_zones_args args = {
 			.cb = cb,
 			.data = data,
@@ -1115,6 +1127,7 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 	for (sector = 0; sector < capacity;
 	     sector += bdev_zone_sectors(bio->bi_bdev))
 		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
+	clear_bit(GD_ZONE_APPEND_USED, &disk->state);
 }
 
 static void blk_zone_finish_bio_endio(struct bio *bio)
@@ -1474,6 +1487,9 @@ static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
 	struct blk_zone_wplug *zwplug;
 	unsigned long flags;
 
+	if (!test_bit(GD_ZONE_APPEND_USED, &disk->state))
+		set_bit(GD_ZONE_APPEND_USED, &disk->state);
+
 	/*
 	 * We have native support for zone append operations, so we are not
 	 * going to handle @bio through plugging. However, we may already have a
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f0ab02e0a673..6a498aa7f7e7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -173,6 +173,7 @@ struct gendisk {
 #define GD_ADDED			4
 #define GD_SUPPRESS_PART_SCAN		5
 #define GD_OWNS_QUEUE			6
+#define GD_ZONE_APPEND_USED		7
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
-- 
2.47.3

