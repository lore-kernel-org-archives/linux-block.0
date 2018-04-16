Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma
Date: Mon, 16 Apr 2018 10:50:31 +0200
Message-Id: <20180416085032.7367-12-hch@lst.de>
In-Reply-To: <20180416085032.7367-1-hch@lst.de>
References: <20180416085032.7367-1-hch@lst.de>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

These days the dma mapping routines must be able to handle any address
supported by the device, be that using an iommu, or swiotlb if none is
supported.  With that the PCI_DMA_BUS_IS_PHYS check in illegal_highdma
is not needed and can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/core/dev.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 969462ebb296..5802cf177b07 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2884,11 +2884,7 @@ void netdev_rx_csum_fault(struct net_device *dev)
 EXPORT_SYMBOL(netdev_rx_csum_fault);
 #endif
 
-/* Actually, we should eliminate this check as soon as we know, that:
- * 1. IOMMU is present and allows to map all the memory.
- * 2. No high memory really exists on this machine.
- */
-
+/* XXX: check that highmem exists at all on the given machine. */
 static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
 {
 #ifdef CONFIG_HIGHMEM
@@ -2902,20 +2898,6 @@ static int illegal_highdma(struct net_device *dev, struct sk_buff *skb)
 				return 1;
 		}
 	}
-
-	if (PCI_DMA_BUS_IS_PHYS) {
-		struct device *pdev = dev->dev.parent;
-
-		if (!pdev)
-			return 0;
-		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-			dma_addr_t addr = page_to_phys(skb_frag_page(frag));
-
-			if (!pdev->dma_mask || addr + PAGE_SIZE - 1 > *pdev->dma_mask)
-				return 1;
-		}
-	}
 #endif
 	return 0;
 }
-- 
2.17.0
