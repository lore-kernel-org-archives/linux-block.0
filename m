Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E9C610D
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 00:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747786022; cv=none; b=ULrAX4/AFlLUJSZIX7KNSIPqb8vZIAeysWHf+tuPvxJbzk5xuAUPWC68K0SLn4ejFGcFotqq5P9U8Vnh4Gs3lthHwpwMkaDT1FwGd95aUcTPlVIaolOHJx2CgClkbJebqI5dDGkM/dRSQoBlGqEvyZR742NA+CEXY+QF5sgpqdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747786022; c=relaxed/simple;
	bh=X/mr8se+PZi+RI6vJ6L6PXqQKLtlf512LQEmCFKAvH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK2kKDyHdopncAbyQZwExlxIVRbNuc8wSiveDuSMy5UJhIka7GcGG2ea31LjeKZVHasL9MIFxBrWePrH5Sg4zGQ15Q7awums7zQ4CMuK119O+lQlj+oQfsMX/6yrWLHmCUEfdBz4l6yZ5gCRk3b3Bjf1PpA7QZyHNoNvPMZLq9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rK2FE9/Y; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rK2FE9/Y"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b2BYV3WKJzlvnM2;
	Wed, 21 May 2025 00:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1747786013; x=1750378014; bh=OcwjU
	dnp2wdQxVEeyNtLAZ0OFXE19NjpW1vik2Q/zeI=; b=rK2FE9/YL9gdk9yJypVwB
	TJudZEeSK2Qz1d2ir0zSUYAWB0ydSS9Ko1Aj2o6dka+SrG/O9+iKSab0pPHEAJs9
	Zgh3sLXghGaKu8eFSABxucJ4jOg/o3CFp94KDRrs8BqfOc/jtWvXEDipw3EJssNC
	X8ZrBmNCMAogTg+dZ4x9HzkBeOafuguZEQt6YMwhTeQEVEf3TeluG11tRVJdTJVK
	kj5lkDBk7nT+MeWz+xqe/l5ZiT8X/10ZKXmFj7DL3zkpJWx12d69iSWiolbLp8O0
	v/ntxGGb82yswhQa26Y6gZxl4X40gqJnREcZY2hQJJ2AkCC11xzMHOG26CIrOedl
	A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Dlahm3bZOcrB; Wed, 21 May 2025 00:06:53 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b2BYP38dTzlvkTy;
	Wed, 21 May 2025 00:06:48 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/3] blk-zoned: Move locking into disk_zone_wplug_set_wp_offset()
Date: Tue, 20 May 2025 17:06:24 -0700
Message-ID: <20250521000626.1314859-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
In-Reply-To: <20250521000626.1314859-1-bvanassche@acm.org>
References: <20250521000626.1314859-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead of holding zwplug->lock around disk_zone_wplug_set_wp_offset() ca=
lls,
move zwplug->lock locking into disk_zone_wplug_set_wp_offset(). Prepare f=
or
reducing the amount of code protected by zwplug->lock. No functionality h=
as
been changed.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 8f15d1aa6eb8..75b01068b877 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -624,14 +624,19 @@ static void disk_zone_wplug_abort(struct blk_zone_w=
plug *zwplug)
  */
 static void disk_zone_wplug_set_wp_offset(struct gendisk *disk,
 					  struct blk_zone_wplug *zwplug,
-					  unsigned int wp_offset)
+					  unsigned int wp_offset,
+					  bool only_if_update_needed)
 {
-	lockdep_assert_held(&zwplug->lock);
-
-	/* Update the zone write pointer and abort all plugged BIOs. */
-	zwplug->flags &=3D ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
-	zwplug->wp_offset =3D wp_offset;
-	disk_zone_wplug_abort(zwplug);
+	scoped_guard(spinlock_irqsave, &zwplug->lock) {
+		if (only_if_update_needed &&
+		    !(zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE))
+			return;
+
+		/* Update the zone write pointer and abort all plugged BIOs. */
+		zwplug->flags &=3D ~BLK_ZONE_WPLUG_NEED_WP_UPDATE;
+		zwplug->wp_offset =3D wp_offset;
+		disk_zone_wplug_abort(zwplug);
+	}
=20
 	/*
 	 * The zone write plug now has no BIO plugged: remove it from the
@@ -669,18 +674,13 @@ static void disk_zone_wplug_sync_wp_offset(struct g=
endisk *disk,
 					   struct blk_zone *zone)
 {
 	struct blk_zone_wplug *zwplug;
-	unsigned long flags;
=20
 	zwplug =3D disk_get_zone_wplug(disk, zone->start);
 	if (!zwplug)
 		return;
=20
-	spin_lock_irqsave(&zwplug->lock, flags);
-	if (zwplug->flags & BLK_ZONE_WPLUG_NEED_WP_UPDATE)
-		disk_zone_wplug_set_wp_offset(disk, zwplug,
-					      blk_zone_wp_offset(zone));
-	spin_unlock_irqrestore(&zwplug->lock, flags);
-
+	disk_zone_wplug_set_wp_offset(disk, zwplug, blk_zone_wp_offset(zone),
+				      true);
 	disk_put_zone_wplug(zwplug);
 }
=20
@@ -700,7 +700,6 @@ static bool blk_zone_wplug_handle_reset_or_finish(str=
uct bio *bio,
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 	sector_t sector =3D bio->bi_iter.bi_sector;
 	struct blk_zone_wplug *zwplug;
-	unsigned long flags;
=20
 	/* Conventional zones cannot be reset nor finished. */
 	if (!bdev_zone_is_seq(bio->bi_bdev, sector)) {
@@ -726,9 +725,7 @@ static bool blk_zone_wplug_handle_reset_or_finish(str=
uct bio *bio,
 	 */
 	zwplug =3D disk_get_zone_wplug(disk, sector);
 	if (zwplug) {
-		spin_lock_irqsave(&zwplug->lock, flags);
-		disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
-		spin_unlock_irqrestore(&zwplug->lock, flags);
+		disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset, false);
 		disk_put_zone_wplug(zwplug);
 	}
=20
@@ -739,7 +736,6 @@ static bool blk_zone_wplug_handle_reset_all(struct bi=
o *bio)
 {
 	struct gendisk *disk =3D bio->bi_bdev->bd_disk;
 	struct blk_zone_wplug *zwplug;
-	unsigned long flags;
 	sector_t sector;
=20
 	/*
@@ -751,9 +747,7 @@ static bool blk_zone_wplug_handle_reset_all(struct bi=
o *bio)
 	     sector +=3D disk->queue->limits.chunk_sectors) {
 		zwplug =3D disk_get_zone_wplug(disk, sector);
 		if (zwplug) {
-			spin_lock_irqsave(&zwplug->lock, flags);
-			disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
-			spin_unlock_irqrestore(&zwplug->lock, flags);
+			disk_zone_wplug_set_wp_offset(disk, zwplug, 0, false);
 			disk_put_zone_wplug(zwplug);
 		}
 	}
