Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A48BFE;
	Mon, 12 Feb 2024 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707720390; cv=none; b=W1BvG1TBvNAWmLxv5tRT820cs1X/QJ3bsqHIY2LSwAynS71/vwYuSiHM41J6c1omqZ17CFu3kK65KFQbpeWxIgQ+OmDhxygPo5csaNCWgXgP8EN6xOgO4/Srwlbr7D6O9khUB2HkK4+X9bHPj+iKuDBzAOFkO6/YmVqgBQPkwqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707720390; c=relaxed/simple;
	bh=VTkBlGQ03p+D1+Ehq51Td3ygYXkm/56ivitFkyW2v+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SzAWN97ef2vP4//e9XWl3j/eCZY8AYQsh3Udy6SInna1hgSHAVQgg4wPK0ROtwAh8yq6Za+mcZMPm0e0RtTZVzXkL/9pCew6zYkbQslXVyx4831stOi5APz+Xy4Gdo7R4LOoTcoj+zf7IuA9+oL0tqgJVOPMXbs8GE3NTZGzm/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OC1eEdeL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OC1eEdeL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BYX8dCXXtJamilTL6lZO+ppRSoMp9rw4hmsj90YbIFo=; b=OC1eEdeLsqT4CchKv1z6NnCu56
	T0SZ89YsWiAlhgTg7bNOAXP8CWNbJE3scHyNjFW50aluDQZORtuuRVu1FvhiPufVbyCmdJnsFEf4R
	b2LFk76Lyj6R1DJ/7KqF8oj6C6nVRrcLwA4UD+L+7S//86VNwee9gX7or564cpdOQtdYVstTYnnzT
	bqwYwt0iDS4hLR7TaYpHxVVD5O5vVFkTONdnyhxgT0aQhBkPSKeeCVblimug0e3SOlsIEACZJoG9w
	uMsbNYoiptQFRk8X1Smg5T8aGShytjdf8Aj4hEOmC2Edl2wcTrK97fccv1a5wVYVhgy+wLmQexR3w
	F//apsRA==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQ56-00000004PYu-44dn;
	Mon, 12 Feb 2024 06:46:21 +0000
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
	Chaitanya Kulkarni <kch@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/15] block: move max_{open,active}_zones to struct queue_limits
Date: Mon, 12 Feb 2024 07:45:55 +0100
Message-Id: <20240212064609.1327143-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212064609.1327143-1-hch@lst.de>
References: <20240212064609.1327143-1-hch@lst.de>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blkdev.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d7cac3de65b31b..de9251922f7583 100644
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

