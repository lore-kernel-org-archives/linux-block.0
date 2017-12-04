Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:48271 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbdLDQgD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Dec 2017 11:36:03 -0500
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dma-mapping: take dma_pfn_offset into account in dma_max_pfn
Date: Mon,  4 Dec 2017 08:35:59 -0800
Message-Id: <20171204163601.3055-2-hch@lst.de>
In-Reply-To: <20171204163601.3055-1-hch@lst.de>
References: <20171204163601.3055-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This makes sure the generic version can be used with architectures /
devices that have a DMA offset in the direct mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e8f8e8fb244d..86beb9861618 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -692,7 +692,7 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 #ifndef dma_max_pfn
 static inline unsigned long dma_max_pfn(struct device *dev)
 {
-	return *dev->dma_mask >> PAGE_SHIFT;
+	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
 }
 #endif
 
-- 
2.14.2
