Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6889685C79
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 13:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646047; cv=none; b=naWywfUlkIjKMqPIXDHcexqIl/RonkPlfGm+vDqnzvUqkqIKCE+bfX2f8A14nCC82wtTXVvPFRk3Ew4tCRcQwcBEzanNDcG5Zz5qpavbRwTQp5OVnhS2A9kZE47YArYXhwvNt1yOY+iEvPXIYEkS/CafEjUKwGjBl8253EdNTMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646047; c=relaxed/simple;
	bh=YEE0K3C4YljkDRp3e1N4QWFxGsJWb+5rxLnM57XLEB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUSeoU37Zr8bjhk2ComRqlzY+BAUUOdVtuQE8rzO7Dx0agd6LAX1LS/hEBcTzDE+tTs1tbLzOC+HlChcEsL0l9zBrETmn3k9EOAWKtcc5ICE9Vwo065JEKiU+L2qsEoMEWbyGSbtrH/B4XfMkA9tJ6nmr7c41UE4gV868Y8y678=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1TNntUgE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1TNntUgE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oCgQZaiF/v38Xtofqeuu4eAUS7fzPBaKg2U7fjijjbw=; b=1TNntUgEzKJE7T+k4owIJpt1qM
	1GdQyaTvG6M2I7Kj3J8p3HA5vdC7ym8oEXX0QV/Y70doQGszK1qddpUfi7rw5MFHxf5Xcr8CeNYvK
	51wj+h3+xRfpXwbMPKqCvsjCqntTuKZCTvn1hA82zE8AfscdisXXfh7w5s/bS45NwGhcAL8PaiDuz
	HvYIP1DH+q1X6PlmhGp1GjoGpjaEXj7XESgW8Q7d4JsV5TytTpZjDE23JdbjVr9UXlVHCE2jxaULC
	KVQgCWRQwEBHnlUarmxUoU2FEEizXPHazlbO2FI3KPW+YsrWAcv5iQXkuJW/vpURdED+ocoKizK2f
	MBm9rmVw==;
Received: from [50.219.53.154] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV2D-0000000Dqxt-2hjl;
	Tue, 05 Mar 2024 13:40:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Subject: [PATCH 4/7] drbd: merge drbd_setup_queue_param into drbd_reconsider_queue_parameters
Date: Tue,  5 Mar 2024 06:40:38 -0700
Message-Id: <20240305134041.137006-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

drbd_setup_queue_param is only called by drbd_reconsider_queue_parameters
and there is no really clear boundary of responsibilities between the
two.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 56 ++++++++++++++----------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 0326b7322ceb48..0f40fdee089971 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1309,45 +1309,16 @@ static unsigned int drbd_backing_dev_max_segments(struct drbd_device *device)
 	return max_segments;
 }
 
-static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backing_dev *bdev,
-				   unsigned int max_bio_size, struct o_qlim *o)
-{
-	struct request_queue * const q = device->rq_queue;
-	unsigned int max_hw_sectors = max_bio_size >> 9;
-	unsigned int max_segments = BLK_MAX_SEGMENTS;
-	struct request_queue *b = NULL;
-
-	if (bdev) {
-		b = bdev->backing_bdev->bd_disk->queue;
-
-		max_hw_sectors = min(queue_max_hw_sectors(b), max_bio_size >> 9);
-		max_segments = drbd_backing_dev_max_segments(device);
-
-		blk_set_stacking_limits(&q->limits);
-	}
-
-	blk_queue_max_hw_sectors(q, max_hw_sectors);
-	blk_queue_max_segments(q, max_segments);
-	blk_queue_segment_boundary(q, PAGE_SIZE-1);
-	decide_on_discard_support(device, bdev);
-
-	if (b) {
-		blk_stack_limits(&q->limits, &b->limits, 0);
-		disk_update_readahead(device->vdisk);
-	}
-	fixup_write_zeroes(device, q);
-	fixup_discard_support(device, q);
-}
-
 void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		struct drbd_backing_dev *bdev, struct o_qlim *o)
 {
-	unsigned int now = queue_max_hw_sectors(device->rq_queue) <<
-			SECTOR_SHIFT;
+	struct request_queue * const q = device->rq_queue;
+	unsigned int now = queue_max_hw_sectors(q) << 9;
+	struct request_queue *b = NULL;
 	unsigned int new;
 
 	if (bdev) {
-		struct request_queue *b = bdev->backing_bdev->bd_disk->queue;
+		b = bdev->backing_bdev->bd_disk->queue;
 
 		device->local_max_bio_size =
 			queue_max_hw_sectors(b) << SECTOR_SHIFT;
@@ -1369,7 +1340,24 @@ void drbd_reconsider_queue_parameters(struct drbd_device *device,
 		drbd_info(device, "max BIO size = %u\n", new);
 	}
 
-	drbd_setup_queue_param(device, bdev, new, o);
+	if (bdev) {
+		blk_set_stacking_limits(&q->limits);
+		blk_queue_max_segments(q,
+			drbd_backing_dev_max_segments(device));
+	} else {
+		blk_queue_max_segments(q, BLK_MAX_SEGMENTS);
+	}
+
+	blk_queue_max_hw_sectors(q, new >> SECTOR_SHIFT);
+	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
+	decide_on_discard_support(device, bdev);
+
+	if (bdev) {
+		blk_stack_limits(&q->limits, &b->limits, 0);
+		disk_update_readahead(device->vdisk);
+	}
+	fixup_write_zeroes(device, q);
+	fixup_discard_support(device, q);
 }
 
 /* Starts the worker thread */
-- 
2.39.2

