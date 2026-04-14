Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC537D10B
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154709; cv=none; b=oVCZbHXTL2S+eNnxRS05gJmksVrbCSQRfHtpcVcZGQzcquVpzPuzUDvnQoIiDct6n4Y/DvbgMUgEjip2aXNCbNND+OVZ2bvkTQoJ8sk5ZyfjUOtbAgydkBjt3CaxniqM+HDjMZWHWmaKnCaRA27ZNlT+sxzIduUrLLlWn0BUDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154709; c=relaxed/simple;
	bh=s8KNgwUyX08Qzf6wXC/okHmJ+8BaqsXoMaOkujDokOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/EznkW7BvF/Wz0M2+Sd1wKil/to9X0H0VqWJ+t7AfAu92oBbsGzEWXB+oWWtEURCQIEzre+k+i1ppo9HNXGWd8PIzS/xzAy/ZoByRqQGFJwTrHInTEDjpaz/QUq/6+3AGn2LloGIcsKF2YmTnbSALh2dMSN/sPUy9Qqj0AWqP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y4/IxCUv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y4/IxCUv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VuT6pisUBF2DhiobwbaJHTq49vQRgI3btBQYms1Ke+A=; b=y4/IxCUvf/J3zfGwckGSY1zCDn
	DMEct31mVeqdVgk+Wf6TzNx1GNT69OUoM4G92Pc56ERA7qxPlP7j1KexGNdBg935+SNwF/mFP26G4
	c0O/0XGv/Jm0PGep13ms+yEdF26mLAN09XziMn3Xk8SwHUVZi0Yi2vtJGxw9jPysQycg0KTEp+inN
	1LakHuOMcqpTm4BR3bAOWKvTGVb4+oMkZ3LS1XkoMvPI6fleq9yGpE/dL+FHem7fCTB8TulUwOCAK
	lSZ5dsXAqkI2gcazw5UC0+xoe7qc8/rJxedNdwwnbR70NnvV+RlXqvKLaDv5bwANGb9PzmUO9v4fd
	kUEaLafQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYya-0000000Gxjm-0ixg;
	Tue, 14 Apr 2026 08:18:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/6] zloop: factor out zloop_mark_{full,empty} helpers
Date: Tue, 14 Apr 2026 10:17:50 +0200
Message-ID: <20260414081811.549755-6-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414081811.549755-1-hch@lst.de>
References: <20260414081811.549755-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move a few chunks of duplicated code into helpers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 48 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 7257188dd3a8..3f69206d674a 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -288,6 +288,24 @@ static bool zloop_do_open_zone(struct zloop_device *zlo,
 	}
 }
 
+static void zloop_mark_full(struct zloop_device *zlo, struct zloop_zone *zone)
+{
+	lockdep_assert_held(&zone->wp_lock);
+
+	zloop_lru_remove_open_zone(zlo, zone);
+	zone->cond = BLK_ZONE_COND_FULL;
+	zone->wp = ULLONG_MAX;
+}
+
+static void zloop_mark_empty(struct zloop_device *zlo, struct zloop_zone *zone)
+{
+	lockdep_assert_held(&zone->wp_lock);
+
+	zloop_lru_remove_open_zone(zlo, zone);
+	zone->cond = BLK_ZONE_COND_EMPTY;
+	zone->wp = zone->start;
+}
+
 static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
@@ -321,13 +339,9 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 
 	spin_lock_irqsave(&zone->wp_lock, flags);
 	if (!file_sectors) {
-		zloop_lru_remove_open_zone(zlo, zone);
-		zone->cond = BLK_ZONE_COND_EMPTY;
-		zone->wp = zone->start;
+		zloop_mark_empty(zlo, zone);
 	} else if (file_sectors == zlo->zone_capacity) {
-		zloop_lru_remove_open_zone(zlo, zone);
-		zone->cond = BLK_ZONE_COND_FULL;
-		zone->wp = ULLONG_MAX;
+		zloop_mark_full(zlo, zone);
 	} else {
 		if (zone->cond != BLK_ZONE_COND_IMP_OPEN &&
 		    zone->cond != BLK_ZONE_COND_EXP_OPEN)
@@ -429,9 +443,7 @@ static int zloop_reset_zone(struct zloop_device *zlo, unsigned int zone_no)
 	}
 
 	spin_lock_irqsave(&zone->wp_lock, flags);
-	zloop_lru_remove_open_zone(zlo, zone);
-	zone->cond = BLK_ZONE_COND_EMPTY;
-	zone->wp = zone->start;
+	zloop_mark_empty(zlo, zone);
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
 	spin_unlock_irqrestore(&zone->wp_lock, flags);
 
@@ -477,9 +489,7 @@ static int zloop_finish_zone(struct zloop_device *zlo, unsigned int zone_no)
 	}
 
 	spin_lock_irqsave(&zone->wp_lock, flags);
-	zloop_lru_remove_open_zone(zlo, zone);
-	zone->cond = BLK_ZONE_COND_FULL;
-	zone->wp = ULLONG_MAX;
+	zloop_mark_full(zlo, zone);
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
 	spin_unlock_irqrestore(&zone->wp_lock, flags);
 
@@ -616,11 +626,8 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
 	 */
 	if (!is_append || !zlo->ordered_zone_append) {
 		zone->wp += nr_sectors;
-		if (zone->wp == zone_end) {
-			zloop_lru_remove_open_zone(zlo, zone);
-			zone->cond = BLK_ZONE_COND_FULL;
-			zone->wp = ULLONG_MAX;
-		}
+		if (zone->wp == zone_end)
+			zloop_mark_full(zlo, zone);
 	}
 out_unlock:
 	spin_unlock_irqrestore(&zone->wp_lock, flags);
@@ -873,11 +880,8 @@ static bool zloop_set_zone_append_sector(struct request *rq)
 
 	rq->__sector = zone->wp;
 	zone->wp += blk_rq_sectors(rq);
-	if (zone->wp >= zone_end) {
-		zloop_lru_remove_open_zone(zlo, zone);
-		zone->cond = BLK_ZONE_COND_FULL;
-		zone->wp = ULLONG_MAX;
-	}
+	if (zone->wp >= zone_end)
+		zloop_mark_full(zlo, zone);
 
 	spin_unlock_irqrestore(&zone->wp_lock, flags);
 
-- 
2.53.0

