Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158693438A1
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715293; cv=none; b=IcEpja54iMFFP4+A2PFctfMtmKOTKWm0kTmz6V6kJ5EPSJ0+dbwV7R5FXeRJE99Ehxb7tBBxscRTqgcABzI1yHactbFxjbtFqRS/R/TMOe+rJIUzK33LEU3LmPS3x8lYinacbQARatJln1kH5GQnwEntw/EW+9xzfpM5tG1+lYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715293; c=relaxed/simple;
	bh=xJLugnOt4h8YIRk1ZO3fAeVO8UWdE5FomvSFGVP+BZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMwU6uvmZqy6ZP109GlqSXA+BfK8WZK4zl3d7kWYLUoghC6SuvUpci5NXSlE6Ns8/i0MONFHkurkMoesoorrH3rUqiHfu3m4FeDm0ZV82tiY/UztZLg+kmeMuZbgJ+vXC2/g7JyWm3ehgO0n3ROK4MitxOeW5Co4QiqpvbByRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL6EFCXQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL6EFCXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887CD1F00A3A;
	Fri, 14 Aug 2026 13:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715291;
	bh=3il/q4pxxU9WtqhueYyMPChDf8O+8SR0upJdE9RQGp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mL6EFCXQ27EWEkxWYAf48RSlE/DavFMkZ7sGBnNQyD9wL83ig99RTGhqDfQRqFi2u
	 e1vBaFzL3woxqnQ2sFQJBooRP+dBEUk0srIZVu9z5GWFd/DqnxD8r4ODglXtYLZSeB
	 wPncHSC+q6SleSQ2b2mkViCHOdKyoPR/LufK7hZ/cb6oFicvSR1Oe6QjSshs9hOBlD
	 Rwxv29R5pF53NOm5hX7T3C79rdRerUy//rOtE4h9Zrd7dbPlDma6QNuLHfu6AfFl5a
	 S061me0eIk3zIvBUT80+W1wXs9frdSiBUpUVyjIRcsuE2JqPEftlxBDOl4r1UVb8WD
	 +ZbcIxFUXTWvw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 12/13] block: simplify disk_zone_set_cond()
Date: Fri, 14 Aug 2026 22:47:49 +0900
Message-ID: <20260814134750.2100304-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814134750.2100304-1-dlemoal@kernel.org>
References: <20260814134750.2100304-1-dlemoal@kernel.org>
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
index 22c47c73414d..ebfd5fc10163 100644
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

