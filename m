Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7447171CC
	for <linux-block@vger.kernel.org>; Wed, 14 Feb 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707904530; cv=none; b=dc57QiQzd96Z5SMFawK2w5P5IXrgNZKHWvgvovIwa6vXO3ANFosaU7KS/OsnjAVaRUiSV+IdVMJHm9FG+nfSSJnMYGMJLBng7fMK/l9rhuarLuimBR8Z1SR70bp1mzqxY5+89v2S1WmhMqCrBTMnzP9bNn7TCodVsWIcIoqk0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707904530; c=relaxed/simple;
	bh=XxKcDXkogxSapD05u6yVLt6YX4QLdhzbLPyUFiiNymc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTrp6+S59XUWX/FfyPSTjAfdeEz5Bh4MXYp9P4y9+EF2n3s/1L7zdh0OyCEiwFCjmdGEVQYvVKvKM5TJoHRL8VHTIS9W5QPgLpRu1NI05lALRc1JjBik1+OZIL3rO2lJyb4Ehm44vnuJZLPYHo3PpuNsBaACGR4XRZ0OmQfa6fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D0XSzBfN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D0XSzBfN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hskCUUPC668nI9qDKcnhuQu6KHv+gHP9EuLNCbcRHws=; b=D0XSzBfNtvnPFWnwoSAB8v43tJ
	JcsL/uqpxr/LEHgOFF2ARfERxZ+04AP3dSI40Y4TNT4EtcbxsEB2NyfNfAPG1c5ldDnbu/TlB5YCY
	Ghm7B8RvmvEOBgm/7BijQifH0AVG/fWYWWm/ZlJdNAUhGDL52gQnMCKAGPzX5e80hevBMm7IHyJim
	kwBkX80IDTiBRrJK1gt3adToJbgaphpFpBea4nRoTaHNIawH1LjXmCDY0hFIOJ+T89SZzgq84NgJS
	3HFOtKyxZkxiL2uKT+kGVLDEkzTIw/t4oUpuqEp192LoS+Vwz2UH2Qj2dc8olfnV8BmWat64qjAN1
	m89sYCog==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raBzD-0000000CSGq-3S1p;
	Wed, 14 Feb 2024 09:55:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/5] null_blk: pass queue_limits to blk_mq_alloc_disk
Date: Wed, 14 Feb 2024 10:55:01 +0100
Message-Id: <20240214095501.1883819-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214095501.1883819-1-hch@lst.de>
References: <20240214095501.1883819-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the queue limits directly to blk_mq_alloc_disk instead of
setting them one at a time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk/main.c  | 33 ++++++++++++++++++++-------------
 drivers/block/null_blk/zoned.c |  7 -------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 0c8d5042321302..6dd50332514d7c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1694,7 +1694,7 @@ static void null_del_dev(struct nullb *nullb)
 	dev->nullb = NULL;
 }
 
-static void null_config_discard(struct nullb *nullb)
+static void null_config_discard(struct nullb *nullb, struct queue_limits *lim)
 {
 	if (nullb->dev->discard == false)
 		return;
@@ -1711,7 +1711,7 @@ static void null_config_discard(struct nullb *nullb)
 		return;
 	}
 
-	blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
+	lim->max_hw_discard_sectors = UINT_MAX >> 9;
 }
 
 static const struct block_device_operations null_ops = {
@@ -1869,6 +1869,12 @@ static bool null_setup_fault(void)
 
 static int null_add_dev(struct nullb_device *dev)
 {
+	struct queue_limits lim = {
+		.logical_block_size	= dev->blocksize,
+		.physical_block_size	= dev->blocksize,
+		.max_hw_sectors		= dev->max_sectors,
+	};
+
 	struct nullb *nullb;
 	int rv;
 
@@ -1894,7 +1900,18 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_cleanup_queues;
 
-	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, NULL, nullb);
+	if (dev->virt_boundary)
+		lim.virt_boundary_mask = PAGE_SIZE - 1;
+	if (dev->zoned) {
+		lim.zoned = true;
+		lim.chunk_sectors = dev->zone_size_sects;
+		lim.max_zone_append_sectors = dev->zone_size_sects;
+		lim.max_open_zones = dev->zone_max_open;
+		lim.max_active_zones = dev->zone_max_active;
+	}
+	null_config_discard(nullb, &lim);
+
+	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, &lim, nullb);
 	if (IS_ERR(nullb->disk)) {
 		rv = PTR_ERR(nullb->disk);
 		goto out_cleanup_tags;
@@ -1930,16 +1947,6 @@ static int null_add_dev(struct nullb_device *dev)
 	dev->index = rv;
 	mutex_unlock(&lock);
 
-	blk_queue_logical_block_size(nullb->q, dev->blocksize);
-	blk_queue_physical_block_size(nullb->q, dev->blocksize);
-	if (dev->max_sectors)
-		blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
-
-	if (dev->virt_boundary)
-		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
-
-	null_config_discard(nullb);
-
 	if (config_item_name(&dev->group.cg_item)) {
 		/* Use configfs dir name as the device name */
 		snprintf(nullb->disk_name, sizeof(nullb->disk_name),
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 3605afe105dac9..8ece18b0ea30c8 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -156,18 +156,11 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 
 int null_register_zoned_dev(struct nullb *nullb)
 {
-	struct nullb_device *dev = nullb->dev;
 	struct request_queue *q = nullb->q;
 
-	disk_set_zoned(nullb->disk);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
-	blk_queue_chunk_sectors(q, dev->zone_size_sects);
 	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
-	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
-	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
-	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
-
 	return blk_revalidate_disk_zones(nullb->disk, NULL);
 }
 
-- 
2.39.2

