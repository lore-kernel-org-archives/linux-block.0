Return-Path: <BATV+8bbc4aa54a9b92872f27+5534+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/6] skd: switch to the generic DMA API
Date: Thu, 18 Oct 2018 15:15:11 +0200
Message-Id: <20181018131516.10629-2-hch@lst.de>
In-Reply-To: <20181018131516.10629-1-hch@lst.de>
References: <20181018131516.10629-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

The PCI DMA API is deprecated, switch to the generic DMA API instead.
Also make use of the dma_set_mask_and_coherent helper to easily set
the streaming an coherent DMA masks together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/skd_main.c | 63 ++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 80a5806ede03..7c5fc6942f32 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -632,7 +632,7 @@ static bool skd_preop_sg_list(struct skd_device *skdev,
 	 * Map scatterlist to PCI bus addresses.
 	 * Note PCI might change the number of entries.
 	 */
-	n_sg = pci_map_sg(skdev->pdev, sgl, n_sg, skreq->data_dir);
+	n_sg = dma_map_sg(&skdev->pdev->dev, sgl, n_sg, skreq->data_dir);
 	if (n_sg <= 0)
 		return false;
 
@@ -682,7 +682,8 @@ static void skd_postop_sg_list(struct skd_device *skdev,
 	skreq->sksg_list[skreq->n_sg - 1].next_desc_ptr =
 		skreq->sksg_dma_address +
 		((skreq->n_sg) * sizeof(struct fit_sg_descriptor));
-	pci_unmap_sg(skdev->pdev, &skreq->sg[0], skreq->n_sg, skreq->data_dir);
+	dma_unmap_sg(&skdev->pdev->dev, &skreq->sg[0], skreq->n_sg,
+		     skreq->data_dir);
 }
 
 /*
@@ -2632,8 +2633,8 @@ static int skd_cons_skcomp(struct skd_device *skdev)
 		"comp pci_alloc, total bytes %zd entries %d\n",
 		SKD_SKCOMP_SIZE, SKD_N_COMPLETION_ENTRY);
 
-	skcomp = pci_zalloc_consistent(skdev->pdev, SKD_SKCOMP_SIZE,
-				       &skdev->cq_dma_address);
+	skcomp = dma_zalloc_coherent(&skdev->pdev->dev, SKD_SKCOMP_SIZE,
+				     &skdev->cq_dma_address, GFP_KERNEL);
 
 	if (skcomp == NULL) {
 		rc = -ENOMEM;
@@ -2674,10 +2675,10 @@ static int skd_cons_skmsg(struct skd_device *skdev)
 
 		skmsg->id = i + SKD_ID_FIT_MSG;
 
-		skmsg->msg_buf = pci_alloc_consistent(skdev->pdev,
-						      SKD_N_FITMSG_BYTES,
-						      &skmsg->mb_dma_address);
-
+		skmsg->msg_buf = dma_alloc_coherent(&skdev->pdev->dev,
+						    SKD_N_FITMSG_BYTES,
+						    &skmsg->mb_dma_address,
+						    GFP_KERNEL);
 		if (skmsg->msg_buf == NULL) {
 			rc = -ENOMEM;
 			goto err_out;
@@ -2971,8 +2972,8 @@ static struct skd_device *skd_construct(struct pci_dev *pdev)
 static void skd_free_skcomp(struct skd_device *skdev)
 {
 	if (skdev->skcomp_table)
-		pci_free_consistent(skdev->pdev, SKD_SKCOMP_SIZE,
-				    skdev->skcomp_table, skdev->cq_dma_address);
+		dma_free_coherent(&skdev->pdev->dev, SKD_SKCOMP_SIZE,
+				  skdev->skcomp_table, skdev->cq_dma_address);
 
 	skdev->skcomp_table = NULL;
 	skdev->cq_dma_address = 0;
@@ -2991,8 +2992,8 @@ static void skd_free_skmsg(struct skd_device *skdev)
 		skmsg = &skdev->skmsg_table[i];
 
 		if (skmsg->msg_buf != NULL) {
-			pci_free_consistent(skdev->pdev, SKD_N_FITMSG_BYTES,
-					    skmsg->msg_buf,
+			dma_free_coherent(&skdev->pdev->dev, SKD_N_FITMSG_BYTES,
+					  skmsg->msg_buf,
 					    skmsg->mb_dma_address);
 		}
 		skmsg->msg_buf = NULL;
@@ -3172,18 +3173,12 @@ static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
 		goto err_out;
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (!rc) {
-		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64))) {
-			dev_err(&pdev->dev, "consistent DMA mask error %d\n",
-				rc);
-		}
-	} else {
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc) {
-			dev_err(&pdev->dev, "DMA mask error %d\n", rc);
-			goto err_out_regions;
-		}
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc)
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (rc) {
+		dev_err(&pdev->dev, "DMA mask error %d\n", rc);
+		goto err_out_regions;
 	}
 
 	if (!skd_major) {
@@ -3367,20 +3362,12 @@ static int skd_pci_resume(struct pci_dev *pdev)
 	rc = pci_request_regions(pdev, DRV_NAME);
 	if (rc)
 		goto err_out;
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (!rc) {
-		if (pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64))) {
-
-			dev_err(&pdev->dev, "consistent DMA mask error %d\n",
-				rc);
-		}
-	} else {
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc) {
-
-			dev_err(&pdev->dev, "DMA mask error %d\n", rc);
-			goto err_out_regions;
-		}
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc)
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (rc) {
+		dev_err(&pdev->dev, "DMA mask error %d\n", rc);
+		goto err_out_regions;
 	}
 
 	pci_set_master(pdev);
-- 
2.19.1
