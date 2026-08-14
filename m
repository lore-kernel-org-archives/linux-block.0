Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCB36F915
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689144; cv=none; b=nBEMJ91/kqXqnNgi7WBh3PnzZVXis9VJ0VXk1WkIjzNYHbbo2yTYXYy36eZuQ2cVsEFBcbJqyif6+OEC6bwS+QYGlTlsneftWQFa+DApTwEZFexGmORG9TerX2QwAdiN2wC+G57SBKxExd3OYWaFoBfCDQWWlVwcyMWlJScXtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689144; c=relaxed/simple;
	bh=eYa05YBAMbb+AT9Q9De/6yRfB65eAmhybdcykDe4fnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=euDXGakefK32+/qtjdu2aqc4B9G/MZicF0iylV4mjXWQf8A+92het6dhcQIEAuepiLTEdPBA5NLNVWEe6zJU8ZY9scBckWrCS+Pnbww8JNZLgvfUHEpef8rUmfKKa4UpQTD4kfULbG4kOhfoEtjDyzzMMvB4qfboJz9z1LMk6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok2FpXVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok2FpXVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6414B1F00A3A;
	Fri, 14 Aug 2026 06:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786689142;
	bh=YU2MyhA+3ewOOILvZ9vYyHwuVCzwJumzhOgntDxfRxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ok2FpXVa4OcN7tkh0F8kf/RXRwMU/MhKGEdiLDJmYhnCC5iCzNtYMp7YA2ZggePaZ
	 qIR72ieqsuPo0weUSbnX1C9OBCTirNnDbdLEJDUKtt/PXhXa1+KQFExt1iSlcZ+mEH
	 WvGdC3wwX2NuY+PRujkYCluBeZi50cZXEpPNJkdNreJ/BLsweYrqAEj6BnIKBV7A+D
	 767UHAQp7SMeDcTEsQq6Ca6zVlMoOZvKcRhXKbPoZyrTJQZ9uQBeUZjDp/575grqiM
	 s5rW8Z+uqj9Gj6t1k+ejGmNFFDAmMVo2K7+zfyw/4ww9hneZnP8/MtZPofkluPmTpO
	 Iud7amuyvGddw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 12/13] block: simplify disk_zone_set_cond()
Date: Fri, 14 Aug 2026 15:32:00 +0900
Message-ID: <20260814063201.1762743-13-dlemoal@kernel.org>
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
index 4333977ad4fc..03470625d268 100644
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
-			blk_zstate_set(zones_state, disk->nr_zones, zno, cond,
-				       blk_zstate_flags(zones_state[zno]));
-			break;
-		}
-	}
+	if (likely(zones_state))
+		blk_zstate_set(zones_state, disk->nr_zones, zno, cond,
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

