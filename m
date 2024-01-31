Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C05A7A1;
	Wed, 31 Jan 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706261; cv=none; b=RtSkbQ7N0G3DXahfwt7Y/M5LfYbvtJS4Qdsu87Cp1ZZsCSQyezjiDYW/Z0Gru9PM3eYpIFP+Wfb4vJBlKuP5bxf7+KApysbY+paiYjjkyGvx+b7PpM1bLUeplNTDf6brzhblcTssTFRyDrAMSL0Q60aGWTRNSWs1RPhNUw/RVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706261; c=relaxed/simple;
	bh=FDSQLaQOYfUul0ELSJ7p3yJYde5XcqfYxhkm/DBdhxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=smdyob7xsdECrAl4HS2en/I9z0yKA/lk/wqvdefdx/Gx7iNOIkeGoDSnXXPmIcbgM0N0hjUGHZgq79iFS324dKJ14imk8S0aHeeYQ7l3XiQYmBg5oXD+yHidRN1BZXLwO53KtiSdtQiNUtvZTlut1SddPnmSDGVqlVw0rz++RsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ADSC4klr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ADSC4klr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QvYgcCDnDV6B45UcO+y7cOtEkmcXxiY3hFDFlp1G2XE=; b=ADSC4klr7WBb3y/dmqxLJ6GlDK
	gLg0C94PDxpvw8n55nSttOEZ3vysPkvCiOaTOeyz4XAa1udBbp4RzORSgqhTkWFQuo33gCtK0TB/d
	g9ijV7tAPRbt1CTuCCauT+9u6tI8Q7nxImxtHSpQo4aBziLImaa80ZQ+9YxfCc++mDUMtOjJOpMtC
	VgOsKRUbj9LttYEpkE0oL8cZV6hG38gbgZeNgqo7KIfMSEaumDczgLauwj/AsNUgYQGIO5x5vgGui
	FQJw4Ew4izFFh97wWhYamE9X6Grp0t5SnkoKn8KoX60HJF4odjxd3gPb6fy92MYhpTjScs3GHag/L
	AGyNe9CQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVAG9-00000003V1q-2XPJ;
	Wed, 31 Jan 2024 13:04:10 +0000
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
Date: Wed, 31 Jan 2024 14:03:47 +0100
Message-Id: <20240131130400.625836-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131130400.625836-1-hch@lst.de>
References: <20240131130400.625836-1-hch@lst.de>
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

