Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0636426409
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445954; cv=none; b=MWddCAJFrEePYDA0uPOYpLVlsgmTHI6Hgco6lbF8SuI3Z/iSavSv0WrH7KGI5STsItt1z2u0IoQLl/6FuMK6d9/f20cFYUhGPDdU00f5zd3PfT18i96L57yruo70uf404g5C7Zt/U5f3n9NLjcZpukwjeMvndV+NTpkhTvcaH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445954; c=relaxed/simple;
	bh=S36I3/D1dxBxygzGEza0osLRLtLuf8p0W1n/SMQeY2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHlbvI9jsnQ7dv37eUBIqzIzxvxDfrG28+QcOQZ7x5Hj+efAgnworBR0uAxfprjmyyxZLYIPqjdl137KaF9DS4Rxn3tIB8AToCDQOEV8+aJeoIXxK8MyrWppmnSNhKp3S+QRCt2LbuOyWlJyvHLa+i6Zn7d0Vx+y3LhtgkHf6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FI6wsNdT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FI6wsNdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F78D1F00A3A;
	Tue, 11 Aug 2026 10:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445952;
	bh=vHBwRLIwpIidfGIgTc082kUB2XHVvaJbk8LpOVhsoXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FI6wsNdTOqmpaYKkkVfl1INVL3TYZxTHEZBcBMpPsrVXMIo9F1C8zZyM/yR48p/vv
	 WCaN6gWEBMfFFa4DfZfTmtv9XMuQyDN6gAyIDpo9MmouWSCwhJufaPOlSerKeWNVeP
	 Mw7e3/CsWPntfLtzN98GKflAA4tSrTfgFqSUeYXYbeoLyNmNmFFIFvrjp5PZD8vkQs
	 3TEJSRqnfY7PoxoeuoAfAf7BP/0qYrpBPXiH2sUiQAs2KEb5xBsuNw/PRnyPGFSnsu
	 zPcdSqqFQrLDCexy1mOTcPX8aWA1PkQJaWBZAbIzu7p5X3fHZPzVuE6Skp7WAwCsas
	 AVAH4sUmyYdvQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 12/13] block: simplify disk_zone_set_cond()
Date: Tue, 11 Aug 2026 19:58:51 +0900
Message-ID: <20260811105852.1245357-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811105852.1245357-1-dlemoal@kernel.org>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index acf60982e6c9..02f92d113d32 100644
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
 
@@ -1306,7 +1291,8 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
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

