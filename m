Return-Path: <BATV+8bbc4aa54a9b92872f27+5534+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/6] sx8: switch to the generic DMA API
Date: Thu, 18 Oct 2018 15:15:13 +0200
Message-Id: <20181018131516.10629-4-hch@lst.de>
In-Reply-To: <20181018131516.10629-1-hch@lst.de>
References: <20181018131516.10629-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The PCI DMA API is deprecated, switch to the generic DMA API instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/sx8.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 377c17e106c3..064b8c5c7a32 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -861,9 +861,9 @@ static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	if (rq_data_dir(rq) == WRITE) {
 		writing = 1;
-		pci_dir = PCI_DMA_TODEVICE;
+		pci_dir = DMA_TO_DEVICE;
 	} else {
-		pci_dir = PCI_DMA_FROMDEVICE;
+		pci_dir = DMA_FROM_DEVICE;
 	}
 
 	/* get scatterlist from block layer */
@@ -877,7 +877,7 @@ static blk_status_t carm_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	/* map scatterlist to PCI bus addresses */
-	n_elem = pci_map_sg(host->pdev, sg, n_elem, pci_dir);
+	n_elem = dma_map_sg(&host->pdev->dev, sg, n_elem, pci_dir);
 	if (n_elem <= 0) {
 		/* request with no s/g entries? */
 		carm_end_rq(host, crq, BLK_STS_IOERR);
@@ -1058,11 +1058,11 @@ static inline void carm_handle_rw(struct carm_host *host,
 	VPRINTK("ENTER\n");
 
 	if (rq_data_dir(crq->rq) == WRITE)
-		pci_dir = PCI_DMA_TODEVICE;
+		pci_dir = DMA_TO_DEVICE;
 	else
-		pci_dir = PCI_DMA_FROMDEVICE;
+		pci_dir = DMA_FROM_DEVICE;
 
-	pci_unmap_sg(host->pdev, &crq->sg[0], crq->n_elem, pci_dir);
+	dma_unmap_sg(&host->pdev->dev, &crq->sg[0], crq->n_elem, pci_dir);
 
 	carm_end_rq(host, crq, error);
 }
@@ -1567,8 +1567,8 @@ static void carm_free_disks(struct carm_host *host)
 
 static int carm_init_shm(struct carm_host *host)
 {
-	host->shm = pci_alloc_consistent(host->pdev, CARM_SHM_SIZE,
-					 &host->shm_dma);
+	host->shm = dma_alloc_coherent(&host->pdev->dev, CARM_SHM_SIZE,
+				       &host->shm_dma, GFP_KERNEL);
 	if (!host->shm)
 		return -ENOMEM;
 
@@ -1598,7 +1598,7 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto err_out;
 
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc) {
 		printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
 			pci_name(pdev));
@@ -1643,7 +1643,7 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		printk(KERN_ERR DRV_NAME "(%s): OOB queue alloc failure\n",
 		       pci_name(pdev));
 		rc = PTR_ERR(q);
-		goto err_out_pci_free;
+		goto err_out_dma_free;
 	}
 	host->oob_q = q;
 	q->queuedata = host;
@@ -1708,8 +1708,8 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 		clear_bit(1, &carm_major_alloc);
 	blk_cleanup_queue(host->oob_q);
 	blk_mq_free_tag_set(&host->tag_set);
-err_out_pci_free:
-	pci_free_consistent(pdev, CARM_SHM_SIZE, host->shm, host->shm_dma);
+err_out_dma_free:
+	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
 err_out_iounmap:
 	iounmap(host->mmio);
 err_out_kfree:
@@ -1740,7 +1740,7 @@ static void carm_remove_one (struct pci_dev *pdev)
 		clear_bit(1, &carm_major_alloc);
 	blk_cleanup_queue(host->oob_q);
 	blk_mq_free_tag_set(&host->tag_set);
-	pci_free_consistent(pdev, CARM_SHM_SIZE, host->shm, host->shm_dma);
+	dma_free_coherent(&pdev->dev, CARM_SHM_SIZE, host->shm, host->shm_dma);
 	iounmap(host->mmio);
 	kfree(host);
 	pci_release_regions(pdev);
-- 
2.19.1
