Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B92FD1B2
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497760; cv=none; b=gP55j/3mOecll+arHCAjVbq2Cfrlyk9d7hpQVKl1XTXlqskBSDTCaPgE5cgfHhZN65jJuZFtHhzd2j1udfGmOKXzgCo2TI9ifzKFtNkEhsRm2LfKEqL4xiR9RoCaOxy6vyNx4PdmALiDx9Je9iTmp6oQ3eY9wesVedkdl4ZMr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497760; c=relaxed/simple;
	bh=1yuAw+Eq627vltGoMnXJGgxh4DEfuHAppqCydIdY7dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4MupITSQhim7Txxkbo8Vxosc+Th6Aoy3kYIy09zsp5iunTAhlAFgP1qog94NY4PCoRAWJZ08RDadoy2OQIPYWWn9Hr5E8C0kOan7TA6ZIGHZmRAD3fWCp4OXo3SfSuSnn3aNFOBz7S8iugY5FsYjtveHxdwZrIwf/OX+fcreSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rsgEmeIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsgEmeIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F40C16AAE;
	Fri,  7 Nov 2025 06:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762497759;
	bh=1yuAw+Eq627vltGoMnXJGgxh4DEfuHAppqCydIdY7dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rsgEmeIOi6Eka4xZ6ey+fOmq44mGLjRhkcudcSd25U9TL9QJsNgtHPqUX7fPZhMTg
	 9+aXKqJxh24GJt3/Hnpv87B/3me+4T7Bhp6eo34KOlBNWRjiGOCgRBCDD8d6JxCzAk
	 1lhQmhf+6iWPOXZlDi+Ts68AnX2QtmDgCRO6n+C1vzw6Sme3nMUg8mA/xpDpp5Oys+
	 1zTmgMfVtxV3WSz0j4f0pMldHsd8DNbWZTz0WFlL9IMeJzzbf+U2XNDDTklVseMJUs
	 6CxS7Zd2WDwGqaSFUhsHWmI771cMNnwVvbXXo+ZBrGKNxuflq+b6qoNZzj6BvXnhEI
	 Ybp/9njSixC7A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 3/3] block: introduce bdev_zone_start()
Date: Fri,  7 Nov 2025 15:38:44 +0900
Message-ID: <20251107063844.151103-4-dlemoal@kernel.org>
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

Introduce the function bdev_zone_start() as a more explicit (and clear)
replacement for ALIGN_DOWN() to get the start sector of a zone
containing a particular sector of a zoned block device.

Use this new helper in blkdev_get_zone_info() and
blkdev_report_zones_cached().

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c      | 4 ++--
 include/linux/blkdev.h | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index b580d59ce210..3791755bc6ad 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -950,7 +950,7 @@ int blkdev_get_zone_info(struct block_device *bdev, sector_t sector,
 		return -EINVAL;
 
 	memset(zone, 0, sizeof(*zone));
-	sector = ALIGN_DOWN(sector, zone_sectors);
+	sector = bdev_zone_start(bdev, sector);
 
 	if (!blkdev_has_cached_report_zones(bdev))
 		return blkdev_report_zone_fallback(bdev, sector, zone);
@@ -1068,7 +1068,7 @@ int blkdev_report_zones_cached(struct block_device *bdev, sector_t sector,
 		return blkdev_do_report_zones(bdev, sector, nr_zones, &args);
 	}
 
-	for (sector = ALIGN_DOWN(sector, zone_sectors);
+	for (sector = bdev_zone_start(bdev, sector);
 	     sector < capacity && idx < nr_zones;
 	     sector += zone_sectors, idx++) {
 		ret = blkdev_get_zone_info(bdev, sector, &zone);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6a498aa7f7e7..2fff8a80dbd2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1522,6 +1522,12 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return q->limits.chunk_sectors;
 }
 
+static inline sector_t bdev_zone_start(struct block_device *bdev,
+				       sector_t sector)
+{
+	return sector & ~(bdev_zone_sectors(bdev) - 1);
+}
+
 static inline sector_t bdev_offset_from_zone_start(struct block_device *bdev,
 						   sector_t sector)
 {
-- 
2.51.1

