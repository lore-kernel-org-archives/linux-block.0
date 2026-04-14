Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF7391E41
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154712; cv=none; b=k0G2FtaTy/7/nqRxoD/vKr9r4202Doe8q3SYY2XZoO5b3Rqs27kv0veooSwcnndzfu3ewW72Hf7XSlbP5fFzjGnloAGaCA6gJfcDQ1S6qj+10UGxrZqdxzYMVIW8FfTInh66yQTnv6dAWgJA2Xv7ZpHXm7dGVkhdvhvv0cyqMDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154712; c=relaxed/simple;
	bh=GD9/1evtsL7JaYoPLylEBe5mtPBFUvDjycum71g//wM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXIl+1QD3gvID2OLJrgz1dQPoZrhnjLFTHxe6QMMJvYdg2SuIVrigq2sXDFtxbVdwFDklEFbpqVR37k3WliXBnK28hSD3PTjM8oE0zeNEDZf4FP3Eg0ASGyHHh/Np08whB7oms5u26M1mLl2YiXODwZ0JVF992SmNl2y0FYGhLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S/jHBac6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S/jHBac6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ED2cEWjoCVTHWflDuAmTNe7bhS4tVbxTXpC1gIjxAmA=; b=S/jHBac6TjfWh2xTScS+yxaSQp
	mD45OxRw3LwSls0YXj44rLQTwyt7Zmh5V/KUuJxq1Ruiajqbs/wJ6WO+PA5duYbrxjUja1p8mgwlM
	l9/X+JKbNCEmokl+gz7nMdbCa07JxEANi+/3Vr1CGgC4kanOynV9d0Sav3W7n0uDk58kMrZwURwNS
	K3T+T8Cg4Y1fJhzj0fnFQho+CLrB9q83ZoS8h47a5esTM+pDhZ7Hp6rjMKqsP1+tcLH6r0P2XW3Ws
	A0J/OCKMYUaDMtavv64HfAMEP3IVPsyXV+bb/iZd24ec6fkHYZHe+gvqWjwn6cB0X44NuvX3gE72Z
	VcddyEsg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYyc-0000000Gxjy-40Ad;
	Tue, 14 Apr 2026 08:18:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 6/6] zloop: remove irq-safe locking
Date: Tue, 14 Apr 2026 10:17:51 +0200
Message-ID: <20260414081811.549755-7-hch@lst.de>
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

All of zloop runs in user context, so drop the irq-safe locking.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 3f69206d674a..55eeb6aac0ea 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -311,7 +311,6 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 	struct zloop_zone *zone = &zlo->zones[zone_no];
 	struct kstat stat;
 	sector_t file_sectors;
-	unsigned long flags;
 	int ret;
 
 	lockdep_assert_held(&zone->lock);
@@ -337,7 +336,7 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&zone->wp_lock, flags);
+	spin_lock(&zone->wp_lock);
 	if (!file_sectors) {
 		zloop_mark_empty(zlo, zone);
 	} else if (file_sectors == zlo->zone_capacity) {
@@ -348,7 +347,7 @@ static int zloop_update_seq_zone(struct zloop_device *zlo, unsigned int zone_no)
 			zone->cond = BLK_ZONE_COND_CLOSED;
 		zone->wp = zone->start + file_sectors;
 	}
-	spin_unlock_irqrestore(&zone->wp_lock, flags);
+	spin_unlock(&zone->wp_lock);
 
 	return 0;
 }
@@ -381,7 +380,6 @@ static int zloop_open_zone(struct zloop_device *zlo, unsigned int zone_no)
 static int zloop_close_zone(struct zloop_device *zlo, unsigned int zone_no)
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
-	unsigned long flags;
 	int ret = 0;
 
 	if (test_bit(ZLOOP_ZONE_CONV, &zone->flags))
@@ -400,13 +398,13 @@ static int zloop_close_zone(struct zloop_device *zlo, unsigned int zone_no)
 		break;
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
-		spin_lock_irqsave(&zone->wp_lock, flags);
+		spin_lock(&zone->wp_lock);
 		zloop_lru_remove_open_zone(zlo, zone);
 		if (zone->wp == zone->start)
 			zone->cond = BLK_ZONE_COND_EMPTY;
 		else
 			zone->cond = BLK_ZONE_COND_CLOSED;
-		spin_unlock_irqrestore(&zone->wp_lock, flags);
+		spin_unlock(&zone->wp_lock);
 		break;
 	case BLK_ZONE_COND_EMPTY:
 	case BLK_ZONE_COND_FULL:
@@ -424,7 +422,6 @@ static int zloop_close_zone(struct zloop_device *zlo, unsigned int zone_no)
 static int zloop_reset_zone(struct zloop_device *zlo, unsigned int zone_no)
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
-	unsigned long flags;
 	int ret = 0;
 
 	if (test_bit(ZLOOP_ZONE_CONV, &zone->flags))
@@ -442,10 +439,10 @@ static int zloop_reset_zone(struct zloop_device *zlo, unsigned int zone_no)
 		goto unlock;
 	}
 
-	spin_lock_irqsave(&zone->wp_lock, flags);
+	spin_lock(&zone->wp_lock);
 	zloop_mark_empty(zlo, zone);
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
-	spin_unlock_irqrestore(&zone->wp_lock, flags);
+	spin_unlock(&zone->wp_lock);
 
 unlock:
 	mutex_unlock(&zone->lock);
@@ -470,7 +467,6 @@ static int zloop_reset_all_zones(struct zloop_device *zlo)
 static int zloop_finish_zone(struct zloop_device *zlo, unsigned int zone_no)
 {
 	struct zloop_zone *zone = &zlo->zones[zone_no];
-	unsigned long flags;
 	int ret = 0;
 
 	if (test_bit(ZLOOP_ZONE_CONV, &zone->flags))
@@ -488,10 +484,10 @@ static int zloop_finish_zone(struct zloop_device *zlo, unsigned int zone_no)
 		goto unlock;
 	}
 
-	spin_lock_irqsave(&zone->wp_lock, flags);
+	spin_lock(&zone->wp_lock);
 	zloop_mark_full(zlo, zone);
 	clear_bit(ZLOOP_ZONE_SEQ_ERROR, &zone->flags);
-	spin_unlock_irqrestore(&zone->wp_lock, flags);
+	spin_unlock(&zone->wp_lock);
 
  unlock:
 	mutex_unlock(&zone->lock);
@@ -581,10 +577,9 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
 	bool is_append = req_op(rq) == REQ_OP_ZONE_APPEND;
 	struct zloop_zone *zone = &zlo->zones[zone_no];
 	sector_t zone_end = zone->start + zlo->zone_capacity;
-	unsigned long flags;
 	int ret = 0;
 
-	spin_lock_irqsave(&zone->wp_lock, flags);
+	spin_lock(&zone->wp_lock);
 
 	/*
 	 * Zone append operations always go at the current write pointer, but
@@ -630,7 +625,7 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
 			zloop_mark_full(zlo, zone);
 	}
 out_unlock:
-	spin_unlock_irqrestore(&zone->wp_lock, flags);
+	spin_unlock(&zone->wp_lock);
 	return ret;
 }
 
@@ -868,13 +863,12 @@ static bool zloop_set_zone_append_sector(struct request *rq)
 	struct zloop_zone *zone = &zlo->zones[zone_no];
 	sector_t zone_end = zone->start + zlo->zone_capacity;
 	sector_t nr_sectors = blk_rq_sectors(rq);
-	unsigned long flags;
 
-	spin_lock_irqsave(&zone->wp_lock, flags);
+	spin_lock(&zone->wp_lock);
 
 	if (zone->cond == BLK_ZONE_COND_FULL ||
 	    zone->wp + nr_sectors > zone_end) {
-		spin_unlock_irqrestore(&zone->wp_lock, flags);
+		spin_unlock(&zone->wp_lock);
 		return false;
 	}
 
@@ -883,7 +877,7 @@ static bool zloop_set_zone_append_sector(struct request *rq)
 	if (zone->wp >= zone_end)
 		zloop_mark_full(zlo, zone);
 
-	spin_unlock_irqrestore(&zone->wp_lock, flags);
+	spin_unlock(&zone->wp_lock);
 
 	return true;
 }
@@ -944,7 +938,6 @@ static int zloop_report_zones(struct gendisk *disk, sector_t sector,
 	struct zloop_device *zlo = disk->private_data;
 	struct blk_zone blkz = {};
 	unsigned int first, i;
-	unsigned long flags;
 	int ret;
 
 	first = disk_zone_no(disk, sector);
@@ -968,9 +961,9 @@ static int zloop_report_zones(struct gendisk *disk, sector_t sector,
 
 		blkz.start = zone->start;
 		blkz.len = zlo->zone_size;
-		spin_lock_irqsave(&zone->wp_lock, flags);
+		spin_lock(&zone->wp_lock);
 		blkz.wp = zone->wp;
-		spin_unlock_irqrestore(&zone->wp_lock, flags);
+		spin_unlock(&zone->wp_lock);
 		blkz.cond = zone->cond;
 		if (test_bit(ZLOOP_ZONE_CONV, &zone->flags)) {
 			blkz.type = BLK_ZONE_TYPE_CONVENTIONAL;
-- 
2.53.0

