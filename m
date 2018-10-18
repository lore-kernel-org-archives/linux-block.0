Return-Path: <BATV+8bbc4aa54a9b92872f27+5534+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 5/6] rsxx: switch to the generic DMA API
Date: Thu, 18 Oct 2018 15:15:15 +0200
Message-Id: <20181018131516.10629-6-hch@lst.de>
In-Reply-To: <20181018131516.10629-1-hch@lst.de>
References: <20181018131516.10629-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The PCI DMA API is deprecated, switch to the generic DMA API instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rsxx/core.c |  2 +-
 drivers/block/rsxx/dma.c  | 52 +++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index f2c631ce793c..639051502181 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -782,7 +782,7 @@ static int rsxx_pci_probe(struct pci_dev *dev,
 	pci_set_master(dev);
 	pci_set_dma_max_seg_size(dev, RSXX_HW_BLK_SIZE);
 
-	st = pci_set_dma_mask(dev, DMA_BIT_MASK(64));
+	st = dma_set_mask(&dev->dev, DMA_BIT_MASK(64));
 	if (st) {
 		dev_err(CARD_TO_DEV(card),
 			"No usable DMA configuration,aborting\n");
diff --git a/drivers/block/rsxx/dma.c b/drivers/block/rsxx/dma.c
index 8fbc1bf6db3d..af9cf0215164 100644
--- a/drivers/block/rsxx/dma.c
+++ b/drivers/block/rsxx/dma.c
@@ -224,12 +224,12 @@ static void dma_intr_coal_auto_tune(struct rsxx_cardinfo *card)
 static void rsxx_free_dma(struct rsxx_dma_ctrl *ctrl, struct rsxx_dma *dma)
 {
 	if (dma->cmd != HW_CMD_BLK_DISCARD) {
-		if (!pci_dma_mapping_error(ctrl->card->dev, dma->dma_addr)) {
-			pci_unmap_page(ctrl->card->dev, dma->dma_addr,
+		if (!dma_mapping_error(&ctrl->card->dev->dev, dma->dma_addr)) {
+			dma_unmap_page(&ctrl->card->dev->dev, dma->dma_addr,
 				       get_dma_size(dma),
 				       dma->cmd == HW_CMD_BLK_WRITE ?
-						   PCI_DMA_TODEVICE :
-						   PCI_DMA_FROMDEVICE);
+						   DMA_TO_DEVICE :
+						   DMA_FROM_DEVICE);
 		}
 	}
 
@@ -438,23 +438,23 @@ static void rsxx_issue_dmas(struct rsxx_dma_ctrl *ctrl)
 
 		if (dma->cmd != HW_CMD_BLK_DISCARD) {
 			if (dma->cmd == HW_CMD_BLK_WRITE)
-				dir = PCI_DMA_TODEVICE;
+				dir = DMA_TO_DEVICE;
 			else
-				dir = PCI_DMA_FROMDEVICE;
+				dir = DMA_FROM_DEVICE;
 
 			/*
-			 * The function pci_map_page is placed here because we
+			 * The function dma_map_page is placed here because we
 			 * can only, by design, issue up to 255 commands to the
 			 * hardware at one time per DMA channel. So the maximum
 			 * amount of mapped memory would be 255 * 4 channels *
 			 * 4096 Bytes which is less than 2GB, the limit of a x8
-			 * Non-HWWD PCIe slot. This way the pci_map_page
+			 * Non-HWWD PCIe slot. This way the dma_map_page
 			 * function should never fail because of a lack of
 			 * mappable memory.
 			 */
-			dma->dma_addr = pci_map_page(ctrl->card->dev, dma->page,
+			dma->dma_addr = dma_map_page(&ctrl->card->dev->dev, dma->page,
 					dma->pg_off, dma->sub_page.cnt << 9, dir);
-			if (pci_dma_mapping_error(ctrl->card->dev, dma->dma_addr)) {
+			if (dma_mapping_error(&ctrl->card->dev->dev, dma->dma_addr)) {
 				push_tracker(ctrl->trackers, tag);
 				rsxx_complete_dma(ctrl, dma, DMA_CANCELLED);
 				continue;
@@ -776,10 +776,10 @@ blk_status_t rsxx_dma_queue_bio(struct rsxx_cardinfo *card,
 /*----------------- DMA Engine Initialization & Setup -------------------*/
 int rsxx_hw_buffers_init(struct pci_dev *dev, struct rsxx_dma_ctrl *ctrl)
 {
-	ctrl->status.buf = pci_alloc_consistent(dev, STATUS_BUFFER_SIZE8,
-				&ctrl->status.dma_addr);
-	ctrl->cmd.buf = pci_alloc_consistent(dev, COMMAND_BUFFER_SIZE8,
-				&ctrl->cmd.dma_addr);
+	ctrl->status.buf = dma_alloc_coherent(&dev->dev, STATUS_BUFFER_SIZE8,
+				&ctrl->status.dma_addr, GFP_KERNEL);
+	ctrl->cmd.buf = dma_alloc_coherent(&dev->dev, COMMAND_BUFFER_SIZE8,
+				&ctrl->cmd.dma_addr, GFP_KERNEL);
 	if (ctrl->status.buf == NULL || ctrl->cmd.buf == NULL)
 		return -ENOMEM;
 
@@ -962,12 +962,12 @@ int rsxx_dma_setup(struct rsxx_cardinfo *card)
 			vfree(ctrl->trackers);
 
 		if (ctrl->status.buf)
-			pci_free_consistent(card->dev, STATUS_BUFFER_SIZE8,
-					    ctrl->status.buf,
-					    ctrl->status.dma_addr);
+			dma_free_coherent(&card->dev->dev, STATUS_BUFFER_SIZE8,
+					  ctrl->status.buf,
+					  ctrl->status.dma_addr);
 		if (ctrl->cmd.buf)
-			pci_free_consistent(card->dev, COMMAND_BUFFER_SIZE8,
-					    ctrl->cmd.buf, ctrl->cmd.dma_addr);
+			dma_free_coherent(&card->dev->dev, COMMAND_BUFFER_SIZE8,
+					  ctrl->cmd.buf, ctrl->cmd.dma_addr);
 	}
 
 	return st;
@@ -1023,10 +1023,10 @@ void rsxx_dma_destroy(struct rsxx_cardinfo *card)
 
 		vfree(ctrl->trackers);
 
-		pci_free_consistent(card->dev, STATUS_BUFFER_SIZE8,
-				    ctrl->status.buf, ctrl->status.dma_addr);
-		pci_free_consistent(card->dev, COMMAND_BUFFER_SIZE8,
-				    ctrl->cmd.buf, ctrl->cmd.dma_addr);
+		dma_free_coherent(&card->dev->dev, STATUS_BUFFER_SIZE8,
+				  ctrl->status.buf, ctrl->status.dma_addr);
+		dma_free_coherent(&card->dev->dev, COMMAND_BUFFER_SIZE8,
+				  ctrl->cmd.buf, ctrl->cmd.dma_addr);
 	}
 }
 
@@ -1059,11 +1059,11 @@ int rsxx_eeh_save_issued_dmas(struct rsxx_cardinfo *card)
 				card->ctrl[i].stats.reads_issued--;
 
 			if (dma->cmd != HW_CMD_BLK_DISCARD) {
-				pci_unmap_page(card->dev, dma->dma_addr,
+				dma_unmap_page(&card->dev->dev, dma->dma_addr,
 					       get_dma_size(dma),
 					       dma->cmd == HW_CMD_BLK_WRITE ?
-					       PCI_DMA_TODEVICE :
-					       PCI_DMA_FROMDEVICE);
+					       DMA_TO_DEVICE :
+					       DMA_FROM_DEVICE);
 			}
 
 			list_add_tail(&dma->list, &issued_dmas[i]);
-- 
2.19.1
