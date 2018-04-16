Return-Path: <linux-ide-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] memstick: don't call blk_queue_bounce_limit
Date: Mon, 16 Apr 2018 10:50:26 +0200
Message-Id: <20180416085032.7367-7-hch@lst.de>
In-Reply-To: <20180416085032.7367-1-hch@lst.de>
References: <20180416085032.7367-1-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

All in-tree host drivers set up a proper dma mask and use the dma-mapping
helpers.  This means they will be able to deal with any address that we
are throwing at them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/memstick/core/ms_block.c    | 5 -----
 drivers/memstick/core/mspro_block.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/memstick/core/ms_block.c b/drivers/memstick/core/ms_block.c
index 57b13dfbd21e..b2d025f42d14 100644
--- a/drivers/memstick/core/ms_block.c
+++ b/drivers/memstick/core/ms_block.c
@@ -2096,12 +2096,8 @@ static int msb_init_disk(struct memstick_dev *card)
 	struct msb_data *msb = memstick_get_drvdata(card);
 	struct memstick_host *host = card->host;
 	int rc;
-	u64 limit = BLK_BOUNCE_HIGH;
 	unsigned long capacity;
 
-	if (host->dev.dma_mask && *(host->dev.dma_mask))
-		limit = *(host->dev.dma_mask);
-
 	mutex_lock(&msb_disk_lock);
 	msb->disk_id = idr_alloc(&msb_disk_idr, card, 0, 256, GFP_KERNEL);
 	mutex_unlock(&msb_disk_lock);
@@ -2123,7 +2119,6 @@ static int msb_init_disk(struct memstick_dev *card)
 
 	msb->queue->queuedata = card;
 
-	blk_queue_bounce_limit(msb->queue, limit);
 	blk_queue_max_hw_sectors(msb->queue, MS_BLOCK_MAX_PAGES);
 	blk_queue_max_segments(msb->queue, MS_BLOCK_MAX_SEGS);
 	blk_queue_max_segment_size(msb->queue,
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 8897962781bb..a2fadc605750 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -1175,12 +1175,8 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 	struct mspro_sys_info *sys_info = NULL;
 	struct mspro_sys_attr *s_attr = NULL;
 	int rc, disk_id;
-	u64 limit = BLK_BOUNCE_HIGH;
 	unsigned long capacity;
 
-	if (host->dev.dma_mask && *(host->dev.dma_mask))
-		limit = *(host->dev.dma_mask);
-
 	for (rc = 0; msb->attr_group.attrs[rc]; ++rc) {
 		s_attr = mspro_from_sysfs_attr(msb->attr_group.attrs[rc]);
 
@@ -1219,7 +1215,6 @@ static int mspro_block_init_disk(struct memstick_dev *card)
 
 	msb->queue->queuedata = card;
 
-	blk_queue_bounce_limit(msb->queue, limit);
 	blk_queue_max_hw_sectors(msb->queue, MSPRO_BLOCK_MAX_PAGES);
 	blk_queue_max_segments(msb->queue, MSPRO_BLOCK_MAX_SEGS);
 	blk_queue_max_segment_size(msb->queue,
-- 
2.17.0

