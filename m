Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:33323 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbdLDQgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 11:36:03 -0500
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: don't override dma_max_pfn
Date: Mon,  4 Dec 2017 08:36:00 -0800
Message-Id: <20171204163601.3055-3-hch@lst.de>
In-Reply-To: <20171204163601.3055-1-hch@lst.de>
References: <20171204163601.3055-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The generic version now takes dma_pfn_offset into account, so there is no
more need for an architecture override.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/dma-mapping.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index 0df756b24863..eada887a93bf 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -76,14 +76,5 @@ static inline void dma_mark_clean(void *addr, size_t size)
 {
 }
 
-/* Override for dma_max_pfn() */
-static inline unsigned long dma_max_pfn(struct device *dev)
-{
-	dma_addr_t dma_max = (dma_addr_t)*dev->dma_mask;
-
-	return (ulong)dma_to_phys(dev, dma_max) >> PAGE_SHIFT;
-}
-#define dma_max_pfn(dev) dma_max_pfn(dev)
-
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_DMA_MAPPING_H */
-- 
2.14.2
