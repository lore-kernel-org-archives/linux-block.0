Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032842FD1B2
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497759; cv=none; b=lzNTVbxfIqtntyIkluNX7gOF7jxRRmi8g+y6nh23FE1lr0X6ylScBGVDm0QhttLQah8s7Rd7UnImF4epI47ADCk7kCT38pRnDvcuL7REcivuKQPwqtndp4xgiaX2n/bTugJP2xlGPH5Sy0NxLbWE4S5BiYovLtF/XteQy1J2AG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497759; c=relaxed/simple;
	bh=eCeCnK/RPdSLT0gJPf6DI6SrMd5i7WuVr9+GBgGHj0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhdrVE5mbrt74GaQz8aDKPa3FnZtG0ZTN265JIkmaOBz/QGcC6YAovi4pDc4wWh0fHO6kZLwbh5KVJALQ5ZH4Sbwz8XDJc7X1moKDGqAwLL5ZxlTi1P48rmernSbe0pXMieI1L52Vth3WQyFPtmjyZchh0jXWHwpfSp8OKBuA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYR8F4Az; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYR8F4Az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF4FC4CEF8;
	Fri,  7 Nov 2025 06:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762497758;
	bh=eCeCnK/RPdSLT0gJPf6DI6SrMd5i7WuVr9+GBgGHj0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYR8F4Azam2oLXD2py1esoFirugzdBdP8nXpxmKgpsMHl8OuswAwhwV8vyw5qRx7f
	 dzQswe9v/tvdm5dYakoZo0GXKZ2D8s0ucBPA8fh/heEhxUIIjn3PI+0CPJBBubLWiW
	 xuCh7WR/eCOAIY457iTOEn4Es5J9KqL/k6PB5qEzT5Ghzt3zbPmHeQ/4zts2ebW0J2
	 plVO7rdWZA1kX4Zx5APCT5+2Si6FPY8OBbmjIFzp9bPNlcZ63DoramGEt6zj5rMY56
	 6A1b3CZE4/ogbvMZlwjDX5o/RhIllsYsT1VPxgM/m1U3bwVo0Kel5n5toK0u8c/abG
	 1rDeUBFYPLotw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/3] block: refactor disk_zone_wplug_sync_wp_offset()
Date: Fri,  7 Nov 2025 15:38:43 +0900
Message-ID: <20251107063844.151103-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107063844.151103-1-dlemoal@kernel.org>
References: <20251107063844.151103-1-dlemoal@kernel.org>
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

Change disk_zone_wplug_sync_wp_offset() to return the value of obtained
with blk_zone_wp_offset() to avoid this double call, which simplifies a
little blk_revalidate_seq_zone().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7ce7b8ea5a4f..b580d59ce210 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -817,23 +817,24 @@ static unsigned int blk_zone_wp_offset(struct blk_zone *zone)
 	}
 }
 
-static void disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
-					   struct blk_zone *zone)
+static unsigned int disk_zone_wplug_sync_wp_offset(struct gendisk *disk,
+						   struct blk_zone *zone)
 {
 	struct blk_zone_wplug *zwplug;
-	unsigned long flags;
+	unsigned int wp_offset = blk_zone_wp_offset(zone);
 
 	zwplug = disk_get_zone_wplug(disk, zone->start);
-	if (!zwplug)
-		return;
+	if (zwplug) {
+		unsigned long flags;
 
-	spin_lock_irqsave(&zwplug->lock, flags);
-	if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
-		disk_zone_wplug_set_wp_offset(disk, zwplug,
-					      blk_zone_wp_offset(zone));
-	spin_unlock_irqrestore(&zwplug->lock, flags);
+		spin_lock_irqsave(&zwplug->lock, flags);
+		if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
+			disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
+		spin_unlock_irqrestore(&zwplug->lock, flags);
+		disk_put_zone_wplug(zwplug);
+	}
 
-	disk_put_zone_wplug(zwplug);
+	return wp_offset;
 }
 
 /**
@@ -2101,9 +2102,7 @@ static int blk_revalidate_seq_zone(struct blk_zone *zone, unsigned int idx,
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

