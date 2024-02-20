Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CF5D743
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418984; cv=none; b=fvhXl8FTcd0ecUO4S0d4sIruqfHYPX4QN8ZQe65iQ5P9CA1kHJllcVi/Qo92/FWgdK7HK+LRKQURuvlSVZTLR5GWdDAyZxDlfLUls+MwCyG7ZwOmQTJG0NhfuDEaZi3KktHtYCPM1hHxSAcjK3GNZtjbj0iUmX9I4wkesz5ilgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418984; c=relaxed/simple;
	bh=I48pbzwgjajqluzxfECGTw7rb2rjUexIjVeymRf2BXU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLAmQHgsFxHL9vi/635gqSpyxYUO9Dfw9uTQqqrM1Z7trofNNUBwjD6b5xbDp/zhNsvpY03agz9Uw5BHc8bLJDvo20U0lEhAkJUxWpwY2eWyKIS93sxx8wpv+6CjfISIHhT1RPWWI827srPxM6qSkHIUedUnMZfxiqoGFYWCgqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=efXEsm7J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="efXEsm7J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-Type:Content-ID:Content-Description;
	bh=m4XY+o3oHjdzkw4wvaWBW0rkp+IC+rmZPoOQEQCyQz4=; b=efXEsm7JCVBnFfkn7jU1MZ/NFc
	mx9f+yMXUXy0hNPPikyILChtTBHSh0XlQSq8ac8RBIeHbvMaJksVKxk+HmTo2gaPGFMDnl9om2Isl
	w3dXKqPQo1P5Avnwv+qE+OYU6F3kUy2OOT47OtZIjAFeCqBBGE+NGe66Yb/+5+Brfgy/C7d5VmXYW
	QH4P4YTKPMlywHJmCAZpMxe1vgaVZac8kRbVBH6PRTAYo0McQA142uAiWOdB+0pRH6srypy/52W9m
	wvL3iy7q3dZY2Xt4SkPkeeVWwKCM5Umqmcb35w5b1+BSR8L6riFPQerE2vSwenZ38h8ubfhFrCgj5
	3YhiTmqw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLor-0000000DnVL-0v8C;
	Tue, 20 Feb 2024 08:49:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] xen-blkfront: atomically update queue limits
Date: Tue, 20 Feb 2024 09:49:35 +0100
Message-Id: <20240220084935.3282351-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220084935.3282351-1-hch@lst.de>
References: <20240220084935.3282351-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass the initial queue limits to blk_mq_alloc_disk and use the
blkif_set_queue_limits API to update the limits on reconnect.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 41 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 7664638a0abbfa..b77707ca2c5aa6 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -941,37 +941,35 @@ static const struct blk_mq_ops blkfront_mq_ops = {
 	.complete = blkif_complete_rq,
 };
 
-static void blkif_set_queue_limits(struct blkfront_info *info)
+static void blkif_set_queue_limits(struct blkfront_info *info,
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

