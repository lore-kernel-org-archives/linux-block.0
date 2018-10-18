Return-Path: <BATV+8bbc4aa54a9b92872f27+5534+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/6] umem: switch to the generic DMA API
Date: Thu, 18 Oct 2018 15:15:14 +0200
Message-Id: <20181018131516.10629-5-hch@lst.de>
In-Reply-To: <20181018131516.10629-1-hch@lst.de>
References: <20181018131516.10629-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The PCI DMA API is deprecated, switch to the generic DMA API instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/umem.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 9094ca60949c..be3e3ab79950 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -363,12 +363,12 @@ static int add_bio(struct cardinfo *card)
 
 	vec = bio_iter_iovec(bio, card->current_iter);
 
-	dma_handle = pci_map_page(card->dev,
+	dma_handle = dma_map_page(&card->dev->dev,
 				  vec.bv_page,
 				  vec.bv_offset,
 				  vec.bv_len,
 				  bio_op(bio) == REQ_OP_READ ?
-				  PCI_DMA_FROMDEVICE : PCI_DMA_TODEVICE);
+				  DMA_FROM_DEVICE : DMA_TO_DEVICE);
 
 	p = &card->mm_pages[card->Ready];
 	desc = &p->desc[p->cnt];
@@ -448,10 +448,10 @@ static void process_page(unsigned long data)
 				page->iter = page->bio->bi_iter;
 		}
 
-		pci_unmap_page(card->dev, desc->data_dma_handle,
+		dma_unmap_page(&card->dev->dev, desc->data_dma_handle,
 			       vec.bv_len,
 				 (control & DMASCR_TRANSFER_READ) ?
-				PCI_DMA_TODEVICE : PCI_DMA_FROMDEVICE);
+				DMA_TO_DEVICE : DMA_FROM_DEVICE);
 		if (control & DMASCR_HARD_ERROR) {
 			/* error */
 			bio->bi_status = BLK_STS_IOERR;
@@ -817,8 +817,8 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	dev_printk(KERN_INFO, &dev->dev,
 	  "Micro Memory(tm) controller found (PCI Mem Module (Battery Backup))\n");
 
-	if (pci_set_dma_mask(dev, DMA_BIT_MASK(64)) &&
-	    pci_set_dma_mask(dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask(&dev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask(&dev->dev, DMA_BIT_MASK(32))) {
 		dev_printk(KERN_WARNING, &dev->dev, "NO suitable DMA found\n");
 		return  -ENOMEM;
 	}
@@ -871,12 +871,10 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		goto failed_magic;
 	}
 
-	card->mm_pages[0].desc = pci_alloc_consistent(card->dev,
-						PAGE_SIZE * 2,
-						&card->mm_pages[0].page_dma);
-	card->mm_pages[1].desc = pci_alloc_consistent(card->dev,
-						PAGE_SIZE * 2,
-						&card->mm_pages[1].page_dma);
+	card->mm_pages[0].desc = dma_alloc_coherent(&card->dev->dev,
+			PAGE_SIZE * 2, &card->mm_pages[0].page_dma, GFP_KERNEL);
+	card->mm_pages[1].desc = dma_alloc_coherent(&card->dev->dev,
+			PAGE_SIZE * 2, &card->mm_pages[1].page_dma, GFP_KERNEL);
 	if (card->mm_pages[0].desc == NULL ||
 	    card->mm_pages[1].desc == NULL) {
 		dev_printk(KERN_ERR, &card->dev->dev, "alloc failed\n");
@@ -1002,13 +1000,13 @@ static int mm_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
  failed_req_irq:
  failed_alloc:
 	if (card->mm_pages[0].desc)
-		pci_free_consistent(card->dev, PAGE_SIZE*2,
-				    card->mm_pages[0].desc,
-				    card->mm_pages[0].page_dma);
+		dma_free_coherent(&card->dev->dev, PAGE_SIZE * 2,
+				  card->mm_pages[0].desc,
+				  card->mm_pages[0].page_dma);
 	if (card->mm_pages[1].desc)
-		pci_free_consistent(card->dev, PAGE_SIZE*2,
-				    card->mm_pages[1].desc,
-				    card->mm_pages[1].page_dma);
+		dma_free_coherent(&card->dev->dev, PAGE_SIZE * 2,
+				  card->mm_pages[1].desc,
+				  card->mm_pages[1].page_dma);
  failed_magic:
 	iounmap(card->csr_remap);
  failed_remap_csr:
@@ -1027,11 +1025,11 @@ static void mm_pci_remove(struct pci_dev *dev)
 	iounmap(card->csr_remap);
 
 	if (card->mm_pages[0].desc)
-		pci_free_consistent(card->dev, PAGE_SIZE*2,
+		dma_free_coherent(&card->dev->dev, PAGE_SIZE * 2,
 				    card->mm_pages[0].desc,
 				    card->mm_pages[0].page_dma);
 	if (card->mm_pages[1].desc)
-		pci_free_consistent(card->dev, PAGE_SIZE*2,
+		dma_free_coherent(&card->dev->dev, PAGE_SIZE * 2,
 				    card->mm_pages[1].desc,
 				    card->mm_pages[1].page_dma);
 	blk_cleanup_queue(card->queue);
-- 
2.19.1
