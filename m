Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B13B6354
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147709; cv=none; b=Xpl9ooCKZLDIj1uS7/cUXWqFvRxPHl6L2bS6VoSIpS1L3VYUuTSmrTvhRjTbeDEuF2Q/+in90oWHU4+bUV7QJI3dZc0YVkNUJPZVI9k7491xOWorueBXB3olMmfc3O9pUi45GfZcfZc8IMx1I6KHYMFrY3ZbmGQcGogUD0iGeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147709; c=relaxed/simple;
	bh=r5UXK5OAAKwLrqUIaFeFpFyyMqOH+GkX04WAcOIRyH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OXnniLVLN2eBk7dPRPdMUcJfYsJs/DVILIJ3p057ayn3Td9FlH/AT6dtvY2Rw+gnAA5T24n3q+qTVlpn5D0qmlUCdFgGzrNKai3JsaNImODA29CK0Okhty8CZO7bmPk+QgAZPMSlOfW6ArD0ELQlNljREXpZOyx5C6uluSCaeCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0jnjAWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0jnjAWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725F91F0155B;
	Mon, 31 Aug 2026 03:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788147691;
	bh=Uc6n93UAZ36ieaKyPiE8YPW6KFmJJHkOANrrM4POGEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d0jnjAWoSbeKCXD0Bi+rnNTR8xpuegGI097CNyM9M2c9459If4S4dKfe1hTGKO45d
	 h3uEvVj62jitePMJgO4rPMSngpwjtVN0ruTavdF8bZO+vcmQCjTTh6SxY0dB01cqu6
	 ngqTC6PuYttBaJYvY4J8j6PBjMetfbjVszAzyifKmNYbz3uqQmthKlaKjlrBvt2ByA
	 SPhHSSWg8Rq5KDLzUI56o45lkBtuZtzBpph+LUBSZLxEVD/KppWXmfEXJO2pTCnsod
	 l6EWnEtUwnUFO6G4wU9yKqzk8uo8va63F/rp/ICHcJoSyO+gDwMKXLR/tl824EOl+3
	 qhaEwhejSPwrA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 12/12] block: simplify disk_zone_set_cond()
Date: Mon, 31 Aug 2026 12:41:09 +0900
Message-ID: <20260831034109.744039-13-dlemoal@kernel.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c3b56dc947af..66560374b996 100644
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
 
@@ -1307,7 +1292,8 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
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

