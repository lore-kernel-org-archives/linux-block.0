Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFBF6996E
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520345; cv=none; b=U0UtT5rC19BkhAPg72DenGISqj+KDAiHkuTE7/6KcvrlwslsFQ3zHCFnV2e+AQmCsoG1PbUUC9r3ADpyPb63BVNd0OM3YrQ5vu9uYkX4JNeAIyf1+0JThqWUyY2pJ82kxZ9dsmwcKEzHYnHkeRhUpQKDY25fhWMVcEet2jXWoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520345; c=relaxed/simple;
	bh=TOgbjfiIJA/1NIwRbBdfXCloME38qlBTdMipceOEa88=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEZyAIfNa0BlgvYSheYP8B61OmXyJDevN7PhSj195zEIAouH1fhcW6Nl0XkUV47wOkIwTg/hnPGa2CGoCOAD8/x+vawIRR97s9SKlT6vQka1TvXs/XHY0MNJocUEd7VL3yTzMgJLqHETw29IxN3uXzC6bcl5gsKaXI90345xE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ry/Nuscq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ry/Nuscq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=ClBF4HdQdZoudt8WElKT+rvsm/9JyMAWyPnUsdGhZ5c=; b=ry/NuscqMOGf4bi5P73rmAi3BH
	HPoTpm+PFte7RXlBzNZupzOIuXurSaaiEbm7qy2KuV5KMgJL3CPZuQMX1HLYQyx/jVc+0q+oXo8fo
	Nh2XDSwkDhKLq7tbFoWLG3kjAQH9wMcD73ZcKyntH/or0abk3OAITizpF0SN9pdXfOeWQ54zRv5CQ
	DPgkDcE6AjceQ9WSGqjn65FdYSPyX9yfkdIUQXV0t3IW9gUy9aNDzxLlYjGDsAADdGNpJScdisyXl
	r/WFMicA2TDsJU1Wmk49a8HpuK1aXbcTK24bvDfDQcI1BmbfauN+fS4N4/BSWPNHMjmO/jDL3yAFv
	eJI5G3hA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmBi-00000000wH4-0Pli;
	Wed, 21 Feb 2024 12:59:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] xen-blkfront: atomically update queue limits
Date: Wed, 21 Feb 2024 13:58:45 +0100
Message-Id: <20240221125845.3610668-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221125845.3610668-1-hch@lst.de>
References: <20240221125845.3610668-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the initial queue limits to blk_mq_alloc_disk and use the
blkif_set_queue_limits API to update the limits on reconnect.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
---
 drivers/block/xen-blkfront.c | 41 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 7664638a0abbfa..fd7c0ff2139cee 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -941,37 +941,35 @@ static const struct blk_mq_ops blkfront_mq_ops = {
 	.complete = blkif_complete_rq,
 };
 
-static void blkif_set_queue_limits(struct blkfront_info *info)
+static void blkif_set_queue_limits(const struct blkfront_info *info,
+		struct queue_limits *lim)
 {
-	struct request_queue *rq = info->rq;
 	unsigned int segments = info->max_indirect_segments ? :
 				BLKIF_MAX_SEGMENTS_PER_REQUEST;
 
-	blk_queue_flag_set(QUEUE_FLAG_VIRT, rq);
-
 	if (info->feature_discard) {
-		blk_queue_max_discard_sectors(rq, UINT_MAX);
+		lim->max_hw_discard_sectors = UINT_MAX;
 		if (info->discard_granularity)
-			rq->limits.discard_granularity = info->discard_granularity;
-		rq->limits.discard_alignment = info->discard_alignment;
+			lim->discard_granularity = info->discard_granularity;
+		lim->discard_alignment = info->discard_alignment;
 		if (info->feature_secdiscard)
-			blk_queue_max_secure_erase_sectors(rq, UINT_MAX);
+			lim->max_secure_erase_sectors = UINT_MAX;
 	}
 
 	/* Hard sector size and max sectors impersonate the equiv. hardware. */
-	blk_queue_logical_block_size(rq, info->sector_size);
-	blk_queue_physical_block_size(rq, info->physical_sector_size);
-	blk_queue_max_hw_sectors(rq, (segments * XEN_PAGE_SIZE) / 512);
+	lim->logical_block_size = info->sector_size;
+	lim->physical_block_size = info->physical_sector_size;
+	lim->max_hw_sectors = (segments * XEN_PAGE_SIZE) / 512;
 
 	/* Each segment in a request is up to an aligned page in size. */
-	blk_queue_segment_boundary(rq, PAGE_SIZE - 1);
-	blk_queue_max_segment_size(rq, PAGE_SIZE);
+	lim->seg_boundary_mask = PAGE_SIZE - 1;
+	lim->max_segment_size = PAGE_SIZE;
 
 	/* Ensure a merged request will fit in a single I/O ring slot. */
-	blk_queue_max_segments(rq, segments / GRANTS_PER_PSEG);
+	lim->max_segments = segments / GRANTS_PER_PSEG;
 
 	/* Make sure buffer addresses are sector-aligned. */
-	blk_queue_dma_alignment(rq, 511);
+	lim->dma_alignment = 511;
 }
 
 static const char *flush_info(struct blkfront_info *info)
@@ -1068,6 +1066,7 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 		struct blkfront_info *info, u16 sector_size,
 		unsigned int physical_sector_size)
 {
+	struct queue_limits lim = {};
 	struct gendisk *gd;
 	int nr_minors = 1;
 	int err;
@@ -1134,11 +1133,13 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 	if (err)
 		goto out_release_minors;
 
-	gd = blk_mq_alloc_disk(&info->tag_set, NULL, info);
+	blkif_set_queue_limits(info, &lim);
+	gd = blk_mq_alloc_disk(&info->tag_set, &lim, info);
 	if (IS_ERR(gd)) {
 		err = PTR_ERR(gd);
 		goto out_free_tag_set;
 	}
+	blk_queue_flag_set(QUEUE_FLAG_VIRT, gd->queue);
 
 	strcpy(gd->disk_name, DEV_NAME);
 	ptr = encode_disk_name(gd->disk_name + sizeof(DEV_NAME) - 1, offset);
@@ -1160,7 +1161,6 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 	info->gd = gd;
 	info->sector_size = sector_size;
 	info->physical_sector_size = physical_sector_size;
-	blkif_set_queue_limits(info);
 
 	xlvbd_flush(info);
 
@@ -2004,14 +2004,19 @@ static int blkfront_probe(struct xenbus_device *dev,
 
 static int blkif_recover(struct blkfront_info *info)
 {
+	struct queue_limits lim;
 	unsigned int r_index;
 	struct request *req, *n;
 	int rc;
 	struct bio *bio;
 	struct blkfront_ring_info *rinfo;
 
+	lim = queue_limits_start_update(info->rq);
 	blkfront_gather_backend_features(info);
-	blkif_set_queue_limits(info);
+	blkif_set_queue_limits(info, &lim);
+	rc = queue_limits_commit_update(info->rq, &lim);
+	if (rc)
+		return rc;
 
 	for_each_rinfo(info, rinfo, r_index) {
 		rc = blkfront_setup_indirect(rinfo);
-- 
2.39.2

