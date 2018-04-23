Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:39204 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbeDWREm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Apr 2018 13:04:42 -0400
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc: x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/12] iommu-helper: unexport iommu_area_alloc
Date: Mon, 23 Apr 2018 19:04:09 +0200
Message-Id: <20180423170419.20330-3-hch@lst.de>
In-Reply-To: <20180423170419.20330-1-hch@lst.de>
References: <20180423170419.20330-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This function is only used by built-in code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 lib/iommu-helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/iommu-helper.c b/lib/iommu-helper.c
index 23633c0fda4a..ded1703e7e64 100644
--- a/lib/iommu-helper.c
+++ b/lib/iommu-helper.c
@@ -3,7 +3,6 @@
  * IOMMU helper functions for the free area management
  */
 
-#include <linux/export.h>
 #include <linux/bitmap.h>
 #include <linux/bug.h>
 
@@ -38,4 +37,3 @@ unsigned long iommu_area_alloc(unsigned long *map, unsigned long size,
 	}
 	return -1;
 }
-EXPORT_SYMBOL(iommu_area_alloc);
-- 
2.17.0
