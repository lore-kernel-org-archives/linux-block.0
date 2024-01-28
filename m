Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B2823745;
	Sun, 28 Jan 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706461109; cv=none; b=VeXfhDxBZ7131e+PrmJEnVaezYMXd4Rtq11wcVG2Fdgz1wKngKGWkKNW/3pKnSE3h+eBP8OunTa8LRbgXe7idOmqtnn89eA0rHE+6u/Xh6WsF9QmbGknMBcpLAPlujKG8jTYBS8Sjv0CNVNIsh+MXhj76rC9PGDXPtfF+5VPRro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706461109; c=relaxed/simple;
	bh=FDSQLaQOYfUul0ELSJ7p3yJYde5XcqfYxhkm/DBdhxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVUj4wguPxV/D02wxwb7AcTIr3NMUGyJkr81ZZdEOR3S3Pi6Zd7s+nC3TBqIihe8YuwjBm7TpynYHUIFLdjVbS4+n4QhLvWX3KqoQNBo9bTXw5I6FyU1o/tDHXsvEd4BJVmMig6YiPfeV2qzaWOyLFiiu9fhzKBlzJ+eHu33IeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BGBOn2A0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGBOn2A0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QvYgcCDnDV6B45UcO+y7cOtEkmcXxiY3hFDFlp1G2XE=; b=BGBOn2A04gHyXGeJzE8dxbxpqe
	vrhCm4oq2lSEUjRsXhQAKzMjrUp2VRZLAB0HW3RbWRfNh+kN9GT6HJCsaN786/9mvOQXrp/WYqc09
	/QvCxr2Sx3e6vEI22LL3u4/liBtRQBeCfO1v3aqgLw1HAqmzXmQX2/SRfg5B74ojfmbqX1nJxEW4B
	jS8kXwD12RRLb3tHqtdlzkvZrDytuc5cHJ8IO6tNzx+Bhn1G8a8WfDhUkxDYLqRVhtSE8Qkl/pa/e
	DI8quFRIYjWtnxUFky+Hs2Up2hOKfhjsln0KiGI0qxbM432oaXv+HmJ3Cf4xyFvUMvcRbGjhai1Iz
	KHmi6vWg==;
Received: from [2001:4bb8:182:6550:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU8U8-0000000A1xL-0eem;
	Sun, 28 Jan 2024 16:58:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/14] block: move max_{open,active}_zones to struct queue_limits
Date: Sun, 28 Jan 2024 17:58:00 +0100
Message-Id: <20240128165813.3213508-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128165813.3213508-1-hch@lst.de>
References: <20240128165813.3213508-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The maximum number of open and active zones is a limit on the queue
and should be places there so that we can including it in the upcoming
queue limits batch update API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blkdev.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 99e4f5e722132c..4a2e82c7971c86 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -189,8 +189,6 @@ struct gendisk {
 	 * blk_mq_unfreeze_queue().
 	 */
 	unsigned int		nr_zones;
-	unsigned int		max_open_zones;
-	unsigned int		max_active_zones;
 	unsigned long		*conv_zones_bitmap;
 	unsigned long		*seq_zones_wlock;
 #endif /* CONFIG_BLK_DEV_ZONED */
@@ -307,6 +305,8 @@ struct queue_limits {
 	unsigned char		discard_misaligned;
 	unsigned char		raid_partial_stripes_expensive;
 	bool			zoned;
+	unsigned int		max_open_zones;
+	unsigned int		max_active_zones;
 
 	/*
 	 * Drivers that set dma_alignment to less than 511 must be prepared to
@@ -639,23 +639,23 @@ static inline bool disk_zone_is_seq(struct gendisk *disk, sector_t sector)
 static inline void disk_set_max_open_zones(struct gendisk *disk,
 		unsigned int max_open_zones)
 {
-	disk->max_open_zones = max_open_zones;
+	disk->queue->limits.max_open_zones = max_open_zones;
 }
 
 static inline void disk_set_max_active_zones(struct gendisk *disk,
 		unsigned int max_active_zones)
 {
-	disk->max_active_zones = max_active_zones;
+	disk->queue->limits.max_active_zones = max_active_zones;
 }
 
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
-	return bdev->bd_disk->max_open_zones;
+	return bdev->bd_disk->queue->limits.max_open_zones;
 }
 
 static inline unsigned int bdev_max_active_zones(struct block_device *bdev)
 {
-	return bdev->bd_disk->max_active_zones;
+	return bdev->bd_disk->queue->limits.max_active_zones;
 }
 
 #else /* CONFIG_BLK_DEV_ZONED */
-- 
2.39.2

