Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EC480328
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032307; cv=none; b=WZpSFDvGaNSmFAqt++qzAvVHv0DiCvMTa5zPklOFISYMluRmnjFRLfcRQ20MoAyqtn59pDuNpgZ6tTSjhZe0A7WGSPrxpzj5q6a8R8dHMid3Sp3i58wfjAOFjCHzHR+R6kcN9ZvNgf1E8kRt9m2CfD2EIzuX/zD+s/HeF5GIxBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032307; c=relaxed/simple;
	bh=krEkedN0dtBbtRuDN45hisU1utHLlxe2yJR4yjDMdJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVyqUsKGdoRa9+GAc59gnpwy1rih4JyT4EVfLNtSpJ/fOif5xb0/5HAUDL+yy1wpT/StRn4sA0QQ/lj7wqxTwXByNABOezk5oiTmdMZBCiJ3rNw9qSHPNZ++lG7L47E3sTP6r/RJNi4kKHeIy9/2c3tdmPNawPWSbU0TkP8rwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTIPtqgN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTIPtqgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FA11F000E9;
	Thu,  6 Aug 2026 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032306;
	bh=hUDPt4bBUXX/r9t+tynrXQT075fCH65WjR1qv2X/+H8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GTIPtqgNmjHFgA5YCnYqFYMWHfNlGn4Yxr7QPvLIGZp8C+mTuvXjawLAPVmbIlUAt
	 KYEOQ0mQm0hdL8ZtCASO1QQgTI35fPByXKYV7M6PlVesDmwYufUJwxq0M4mMyJ4QLe
	 NwJnh/V/T0f6ve3H/G288DZuvazialKh9iwO18EBAJ9p0aC98BEF9W5tblFTiJDXQI
	 yEGKAVlgustSm1xk7aTcNNxTQSKwD2uDFNbgXvbI9JF2TIkxav/Sa9QYG4SOHsMr0o
	 Inno4AVFwxmhKqFgCskBo/a3+5V9EIqUo6t0S8bm8xjVX+uD7VJWhNMy60z8NPulzF
	 cekesW4hpZiKw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/13] block: simplify disk_zone_set_cond()
Date: Fri,  7 Aug 2026 01:04:44 +0900
Message-ID: <20260806160445.848337-13-dlemoal@kernel.org>
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

disk_zone_set_cond() is used to set a zone condition afer a reset, a
finish or a reset all operation. For a single zone reset or finish, we are
guaranteed that the target zone is a sequential one that is not offline
nor read-only (otherwise, the operation would have failed). For a reset
all operation, there is no point in calling this function for offline and
read-only zones since the condition checks in disk_zone_set_cond() will
result in nothing being done.

Simplify all this using disk_zone_is_offline_or_readonly() in
blk_zone_reset_all_bio_endio() to skip zones that are offline or
read-only. This change allows simplifying disk_zone_set_cond() by removing
the zone condition checks. This change is also consistent with the fact
that conventional zones can now have the offline or read-only condition.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d0bdef1a5774..f17069309ac9 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -235,29 +235,14 @@ EXPORT_SYMBOL_GPL(blk_zone_cond_str);
 static void disk_zone_set_cond(struct gendisk *disk, sector_t sector,
 			       enum blk_zone_cond cond)
 {
+	unsigned int zno = disk_zone_no(disk, sector);
 	u8 *zones_state;
 
 	rcu_read_lock();
 	zones_state = rcu_dereference(disk->zones_state);
-	if (zones_state) {
-		unsigned int zno = disk_zone_no(disk, sector);
-
-		/*
-		 * The condition of a conventional, readonly and offline zones
-		 * never changes, so do nothing if the target zone is in one of
-		 * these conditions.
-		 */
-		switch (zones_state[zno] & BLK_ZSTATE_COND_MASK) {
-		case BLK_ZSTATE_NOT_WP:
-		case BLK_ZSTATE_READONLY:
-		case BLK_ZSTATE_OFFLINE:
-			break;
-		default:
-			blk_zstate_set(zones_state, zno, cond,
-				       blk_zstate_flags(zones_state[zno]));
-			break;
-		}
-	}
+	if (likely(zones_state && zno < disk->nr_zones))
+		blk_zstate_set(zones_state, zno, cond,
+			       blk_zstate_flags(zones_state[zno]));
 	rcu_read_unlock();
 }
 
@@ -1304,7 +1289,8 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 	/* Update the cached zone conditions. */
 	for (sector = 0; sector < get_capacity(disk);
 	     sector += bdev_zone_sectors(bio->bi_bdev)) {
-		if (disk_zone_is_offline_or_readonly(disk, sector))
+		if (!disk_zone_is_seq(disk, sector) ||
+		    disk_zone_is_offline_or_readonly(disk, sector))
 			continue;
 		disk_zone_set_cond(disk, sector, BLK_ZONE_COND_EMPTY);
 	}
-- 
2.55.0

