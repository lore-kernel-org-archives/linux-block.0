Return-Path: <linux-arch-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ide: remove the PCI_DMA_BUS_IS_PHYS check
Date: Tue, 24 Apr 2018 20:16:23 +0200
Message-Id: <20180424181625.22410-4-hch@lst.de>
In-Reply-To: <20180424181625.22410-1-hch@lst.de>
References: <20180424181625.22410-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

We now have ways to deal with drainage in the block layer, and libata has
been using it for ages.  We also want to get rid of PCI_DMA_BUS_IS_PHYS
now, so just reduce the PCI transfer size for ide - anyone who cares for
performance on PCI controllers should have switched to libata long ago.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ide/ide-probe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 8d8ed036ca0a..56d7bc228cb3 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -796,8 +796,7 @@ static int ide_init_queue(ide_drive_t *drive)
 	 * This will be fixed once we teach pci_map_sg() about our boundary
 	 * requirements, hopefully soon. *FIXME*
 	 */
-	if (!PCI_DMA_BUS_IS_PHYS)
-		max_sg_entries >>= 1;
+	max_sg_entries >>= 1;
 #endif /* CONFIG_PCI */
 
 	blk_queue_max_segments(q, max_sg_entries);
-- 
2.17.0
