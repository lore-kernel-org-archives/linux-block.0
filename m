Return-Path: <BATV+8bbc4aa54a9b92872f27+5534+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Joshua Morris <josh.h.morris@us.ibm.com>,
	Philip Kelleher <pjk1939@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/6] sx8: remove dead IF_64BIT_DMA_IS_POSSIBLE code
Date: Thu, 18 Oct 2018 15:15:12 +0200
Message-Id: <20181018131516.10629-3-hch@lst.de>
In-Reply-To: <20181018131516.10629-1-hch@lst.de>
References: <20181018131516.10629-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

This code has effectively been commented out since the first commit,
so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/sx8.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 16f37254bcf4..377c17e106c3 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -197,7 +197,6 @@ enum {
 	FL_NON_RAID		= FW_VER_NON_RAID,
 	FL_4PORT		= FW_VER_4PORT,
 	FL_FW_VER_MASK		= (FW_VER_NON_RAID | FW_VER_4PORT),
-	FL_DAC			= (1 << 16),
 	FL_DYN_MAJOR		= (1 << 17),
 };
 
@@ -1585,7 +1584,6 @@ static int carm_init_shm(struct carm_host *host)
 static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct carm_host *host;
-	unsigned int pci_dac;
 	int rc;
 	struct request_queue *q;
 	unsigned int i;
@@ -1600,28 +1598,12 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto err_out;
 
-#ifdef IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
-	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
-	if (!rc) {
-		rc = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
-		if (rc) {
-			printk(KERN_ERR DRV_NAME "(%s): consistent DMA mask failure\n",
-				pci_name(pdev));
-			goto err_out_regions;
-		}
-		pci_dac = 1;
-	} else {
-#endif
-		rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
-		if (rc) {
-			printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
-				pci_name(pdev));
-			goto err_out_regions;
-		}
-		pci_dac = 0;
-#ifdef IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
+	rc = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
+	if (rc) {
+		printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
+			pci_name(pdev));
+		goto err_out_regions;
 	}
-#endif
 
 	host = kzalloc(sizeof(*host), GFP_KERNEL);
 	if (!host) {
@@ -1632,7 +1614,6 @@ static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	host->pdev = pdev;
-	host->flags = pci_dac ? FL_DAC : 0;
 	spin_lock_init(&host->lock);
 	INIT_WORK(&host->fsm_task, carm_fsm_task);
 	init_completion(&host->probe_comp);
-- 
2.19.1
