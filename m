Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4920B2DCF74
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 07:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413022; cv=none; b=GzFxFeNmDeWP9bRIxlInntSVloAQiDdjfOImWND2HLX5sPHTI6I3dOFML6JzILG046uqiNX1bJktszoVRRzsanhzCNEaD+xxXzxzuPDlvg/2YW/nP1FxJ/QpENnIeNa7JUNcZxVevG7IAw12RnztXD/WwAf+5ZZMsLosCOzTgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413022; c=relaxed/simple;
	bh=M4E1+/ZXiiZoEvMsFbDjYQslMqwpGIEsRzKeYjEcEV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru1W2YHMKgirgbHPcXtjNA8H84yub0DhyYR6UyVGw3tmGpcPQuQVzS1b8ndgT3osvZD0y05Gk0Xslj2+TNFmup6jxPYs2f5UwSqHp2pXKd4HZ1DY4yqVOOlp8SfKkRVX4OwgboCc4EgnrKJ9F0m07cgBjjY8kJ74Rdz6hsuoKos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PukBIdRL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PukBIdRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BC1C116C6;
	Thu,  6 Nov 2025 07:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762413022;
	bh=M4E1+/ZXiiZoEvMsFbDjYQslMqwpGIEsRzKeYjEcEV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PukBIdRLoFii0qaVhmhn+k9Ad6Q47tJZQ/Q0rsqyCWYu2ComPhZhRsipqI8Psfd/2
	 XsCjYe4YTUw6OD0dS3SXhqsVye40XH7NQCoTHyjjaZj8pzi+J5DEcvpmIIoeVZRXwP
	 TWIloIiUHiG2+Tphmd546T2ZYbW6WzFRFpm0Xs8ItQj3N50sF6gXh+LNXSWpf2a3kP
	 /0xFBT3lNBm3XqnBlqZ1YgBx+T5jtSwObiYNnVSSJHbHrHESzPXS5QVgZ9RiPbRqGX
	 kII40b3ARDpKjmGrmLRxIKGMVsjvy/84BjUu97jJA0R7kl8MQ8S2Mmh7slsU1bmxeK
	 x65aD5HQWGKRQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] block: remove blk_zone_wp_offset()
Date: Thu,  6 Nov 2025 16:06:26 +0900
Message-ID: <20251106070627.96995-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106070627.96995-1-dlemoal@kernel.org>
References: <20251106070627.96995-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper function blk_zone_wp_offset() is called from
disk_zone_wplug_sync_wp_offset(), and again called from
blk_revalidate_seq_zone() right after the call to
disk_zone_wplug_sync_wp_offset().

Change disk_zone_wplug_sync_wp_offset() to return the wp_offset it used
for updating the target zone write plug to avoid this double call. With
this change, blk_zone_wp_offset() can be open coded directly in
disk_zone_wplug_sync_wp_offset(). This open-coding introduces 2 changes:
handle the BLK_COND_ZONE_ACTIVE case, and return UINT_MAX as the
wp_offset for a full zone, since the write pointer of full zones is
invalid.

For the case where a zone does not have a zone write plug,
disk_zone_wplug_sync_wp_offset() does nothing and returns 0. This in
turn leads to blk_revalidate_seq_zone() to immediately return, which is
exactly what we want (because there is no need to attempt removing a
zone write plug that does not exist).

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 64 +++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c5226bcaaa94..2f4e45638601 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -794,46 +794,48 @@ static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 		disk_remove_zone_wplug(disk, zwplug);
 }
 
-static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
-{
-	switch (zone->cond) {
-	case BLK_ZONE_COND_IMP_OPEN:
-	case BLK_ZONE_COND_EXP_OPEN:
-	case BLK_ZONE_COND_CLOSED:
-		return zone->wp - zone->start;
-	case BLK_ZONE_COND_FULL:
-		return zone->len;
-	case BLK_ZONE_COND_EMPTY:
-		return 0;
-	case BLK_ZONE_COND_NOT_WP:
-	case BLK_ZONE_COND_OFFLINE:
-	case BLK_ZONE_COND_READONLY:
-	default:
-		/*
-		 * Conventional, offline and read-only zones do not have a valid
-		 * write pointer.
-		 */
-		return UINT_MAX;
-	}
-}
-
-static void disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
-					   struct blk_zone *zone)
+static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
+						   struct blk_zone *zone)
 {
 	struct blk_zone_wplug *zwplug;
 	unsigned long flags;
+	unsigned int wp_offset;
 
 	zwplug = disk_get_zone_wplug(disk, zone->start);
 	if (!zwplug)
-		return;
+		return 0;
 
 	spin_lock_irqsave(&zwplug->lock, flags);
-	if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
-		disk_zone_wplug_set_wp_offset(disk, zwplug,
-					      blk_zone_wp_offset(zone));
+	if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE) {
+		switch (zone->cond) {
+		case BLK_ZONE_COND_IMP_OPEN:
+		case BLK_ZONE_COND_EXP_OPEN:
+		case BLK_ZONE_COND_CLOSED:
+		case BLK_ZONE_COND_ACTIVE:
+			wp_offset = zone->wp - zone->start;
+			break;
+		case BLK_ZONE_COND_EMPTY:
+			wp_offset = 0;
+			break;
+		case BLK_ZONE_COND_FULL:
+		case BLK_ZONE_COND_NOT_WP:
+		case BLK_ZONE_COND_OFFLINE:
+		case BLK_ZONE_COND_READONLY:
+		default:
+			/*
+			 * Conventional, full, offline and read-only zones do
+			 * not have a valid write pointer.
+			 */
+			wp_offset = UINT_MAX;
+			break;
+		}
+		disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
+	}
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	disk_put_zone_wplug(zwplug);
+
+	return wp_offset;
 }
 
 /**
@@ -2095,9 +2097,7 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
 	if (!queue_emulates_zone_append(disk->queue) || !disk->zone_wplugs_hash)
 		return 0;
 
-	disk_zone_wplug_sync_wp_offset(disk, zone);
-
-	wp_offset = blk_zone_wp_offset(zone);
+	wp_offset = disk_zone_wplug_sync_wp_offset(disk, zone);
 	if (!wp_offset || wp_offset >= zone->capacity)
 		return 0;
 
-- 
2.51.1

