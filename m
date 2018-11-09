Return-Path: <BATV+1ef63fdb319281f35549+5556+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 9/9] mtip32xxx: use for_each_sg
Date: Fri,  9 Nov 2018 14:49:02 +0100
Message-Id: <20181109134902.32057-10-hch@lst.de>
In-Reply-To: <20181109134902.32057-1-hch@lst.de>
References: <20181109134902.32057-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Use the proper helper instead of manually iterating the scatterlist,
which is broken in the presence of chained S/G lists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index e99db2c9118f..a4c44db097e0 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -1549,11 +1549,11 @@ static inline void fill_command_sg(struct driver_data *dd,
 	int n;
 	unsigned int dma_len;
 	struct mtip_cmd_sg *command_sg;
-	struct scatterlist *sg = command->sg;
+	struct scatterlist *sg;
 
 	command_sg = command->command + AHCI_CMD_TBL_HDR_SZ;
 
-	for (n = 0; n < nents; n++) {
+	for_each_sg(command->sg, sg, nents, n) {
 		dma_len = sg_dma_len(sg);
 		if (dma_len > 0x400000)
 			dev_err(&dd->pdev->dev,
@@ -1563,7 +1563,6 @@ static inline void fill_command_sg(struct driver_data *dd,
 		command_sg->dba_upper =
 			cpu_to_le32((sg_dma_address(sg) >> 16) >> 16);
 		command_sg++;
-		sg++;
 	}
 }
 
-- 
2.19.1
