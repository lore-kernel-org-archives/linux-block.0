Return-Path: <gustavo@embeddedor.com>
Date: Fri, 19 Oct 2018 20:44:17 +0200
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] skd: fix unchecked return values
Message-ID: <20181019184417.GA21154@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Check return values of dma_set_mask_and_coherent().

Otherwise, if dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
fails, the following piece of code will be executed even when the call
to dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)); returns 0:

dev_err(&pdev->dev, "DMA mask error %d\n", rc);
goto err_out_regions;

Addresses-Coverity-ID: 1474553 ("Unchecked return value")
Fixes: 138126214868 ("skd: switch to the generic DMA API")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/block/skd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 7c5fc69..2459dcc 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -3175,7 +3175,7 @@ static int skd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out;
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc)
-		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(&pdev->dev, "DMA mask error %d\n", rc);
 		goto err_out_regions;
@@ -3364,7 +3364,7 @@ static int skd_pci_resume(struct pci_dev *pdev)
 		goto err_out;
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (rc)
-		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(&pdev->dev, "DMA mask error %d\n", rc);
 		goto err_out_regions;
-- 
2.7.4
