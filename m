Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653533C1406
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896864; cv=none; b=gogppFNh7R340aZsrK0AWvSdLJuWtimRRAfTlf0fALK7xrufW/0Mu0v4fgMfSpT/GBFlpBlMl1wKP0oJ4dq4nkEXxO3Xaw6BRD756OiAQc1y51E+rdwRQnkNfSySWuZhS6855sPcKE5/OdYDwnC1zO2O1Pp8ccC0S8lwkLmMN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896864; c=relaxed/simple;
	bh=hXEyG0QGXfiTXKoPx0bHA1me64MiAwrYNikesH2CFKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcyj7sVe5chwsjuJ8F0PJeOlyAToDTgBp4DoSLE0hFMfgZy/zMlA6OXhL/Nt+Qf3Xvz0SksPXau2VCwhI9X2leH7kHY/h4hbIFfAvOJNceVL4co8a7PVLUVunoEtgpciLnmbIPjTgepLNXp/pixa34OcvSgp7b9U4WL3T7VCVPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gM0JJQDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gM0JJQDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1361F000E9;
	Wed,  5 Aug 2026 02:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896863;
	bh=m7vn8uMI+qZ5F4XX0by/WTTpLHb7gGLXPaE/DfLrBYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gM0JJQDik4cgvFCXvfwKulKJaxq2DOAG3Ze2AoDgpFisbJMk1+mZuP6IGJeDVdGWu
	 Fo8fIE4L+WXLP5KGRRBiIqLrb52hQ0ZmBQxGqPNQdVZW4+2TypuNESBTetboANfGoN
	 YvEFY71cq39gX9kc+Hax7uYZh+0jP4zWp6aU9phvYGknpm7lwqdVAznt0uCkdcDHbM
	 Xy7fAh5q8fkLg3yyYWJGPIwIg78Ut/tNZ4ycCcpAZXqgn/uP7Ycpi4LhCKj6WaSDsI
	 r9qwgPfnuK7ChILrOVj9nHSwdKagkVlWtovGRFUdgo9ignJuNNcDHI1MLE2xzDFYar
	 qwBQOprwQuRzw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/14] block: simplify disk_zone_set_cond()
Date: Wed,  5 Aug 2026 11:27:17 +0900
Message-ID: <20260805022719.735323-13-dlemoal@kernel.org>
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
index 3494f06ec3f1..e900c5d14414 100644
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

