Return-Path: <BATV+e0efdd19ce80d487e3da+5372+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>,
	Geoff Levand <geoff@infradead.org>,
	Maxim Levitsky <maximlevitsky@gmail.com>,
	linux-block@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 7/7] ps3disk: handle highmem pages
Date: Wed,  9 May 2018 15:59:48 +0200
Message-Id: <20180509135948.20329-8-hch@lst.de>
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
References: <20180509135948.20329-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The ps3disk driver already kmaps all pages when copying from/to the
internal bounce buffer, so it can accept highmem pages just fine.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ps3disk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 075662f2cf46..afe1508d82c6 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -465,8 +465,6 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 	priv->queue = queue;
 	queue->queuedata = dev;
 
-	blk_queue_bounce_limit(queue, BLK_BOUNCE_HIGH);
-
 	blk_queue_max_hw_sectors(queue, dev->bounce_size >> 9);
 	blk_queue_segment_boundary(queue, -1UL);
 	blk_queue_dma_alignment(queue, dev->blk_size-1);
-- 
2.17.0
