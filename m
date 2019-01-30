Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DAFC282D8
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 16:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355762087F
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 16:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbfA3QkM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:40:12 -0500
Received: from 8bytes.org ([81.169.241.247]:36044 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfA3QkL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 11:40:11 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 31BFD6C4; Wed, 30 Jan 2019 17:40:09 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, joro@8bytes.org,
        jroedel@suse.de, Thomas.Lendacky@amd.com
Subject: [PATCH 3/5] dma: Introduce dma_max_mapping_size()
Date:   Wed, 30 Jan 2019 17:40:05 +0100
Message-Id: <20190130164007.26497-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130164007.26497-1-joro@8bytes.org>
References: <20190130164007.26497-1-joro@8bytes.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function returns the maximum size that can be mapped
using DMA-API functions. The patch also adds the
implementation for direct DMA and a new dma_map_ops pointer
so that other implementations can expose their limit.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 Documentation/DMA-API.txt   |  8 ++++++++
 include/linux/dma-mapping.h | 16 ++++++++++++++++
 kernel/dma/direct.c         | 12 ++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index e133ccd60228..acfe3d0f78d1 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -195,6 +195,14 @@ Requesting the required mask does not alter the current mask.  If you
 wish to take advantage of it, you should issue a dma_set_mask()
 call to set the mask to the value returned.
 
+::
+
+	size_t
+	dma_direct_max_mapping_size(struct device *dev);
+
+Returns the maximum size of a mapping for the device. The size parameter
+of the mapping functions like dma_map_single(), dma_map_page() and
+others should not be larger than the returned value.
 
 Part Id - Streaming DMA mappings
 --------------------------------
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f6ded992c183..a3ca8a71a704 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,6 +130,7 @@ struct dma_map_ops {
 			enum dma_data_direction direction);
 	int (*dma_supported)(struct device *dev, u64 mask);
 	u64 (*get_required_mask)(struct device *dev);
+	size_t (*max_mapping_size)(struct device *dev);
 };
 
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
@@ -257,6 +258,8 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 }
 #endif
 
+size_t dma_direct_max_mapping_size(struct device *dev);
+
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
 
@@ -440,6 +443,19 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
+static inline size_t dma_max_mapping_size(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	size_t size = SIZE_MAX;
+
+	if (dma_is_direct(ops))
+		size = dma_direct_max_mapping_size(dev);
+	else if (ops && ops->max_mapping_size)
+		size = ops->max_mapping_size(dev);
+
+	return size;
+}
+
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..81ca8170b928 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -380,3 +380,15 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 */
 	return mask >= __phys_to_dma(dev, min_mask);
 }
+
+size_t dma_direct_max_mapping_size(struct device *dev)
+{
+	size_t size = SIZE_MAX;
+
+	/* If SWIOTLB is active, use its maximum mapping size */
+	if (is_swiotlb_active())
+		size = swiotlb_max_mapping_size(dev);
+
+	return size;
+}
+EXPORT_SYMBOL(dma_direct_max_mapping_size);
-- 
2.17.1

