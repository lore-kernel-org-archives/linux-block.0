Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E8C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB7A20866
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbfAONXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:23:02 -0500
Received: from 8bytes.org ([81.169.241.247]:57774 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbfAONXC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 08:23:02 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 60D68433; Tue, 15 Jan 2019 14:23:00 +0100 (CET)
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
        jroedel@suse.de
Subject: [PATCH 2/3] dma: Introduce dma_max_mapping_size()
Date:   Tue, 15 Jan 2019 14:22:56 +0100
Message-Id: <20190115132257.6426-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115132257.6426-1-joro@8bytes.org>
References: <20190115132257.6426-1-joro@8bytes.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function returns the maximum size that can be mapped
using DMA-API functions. The patch also adds the
implementation for direct DMA and a new dma_map_ops pointer
so that other implementations can expose their limit.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/dma-mapping.h | 16 ++++++++++++++++
 kernel/dma/direct.c         | 10 ++++++++++
 2 files changed, 26 insertions(+)

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
index 355d16acee6d..84917e1003c4 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -380,3 +380,13 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	 */
 	return mask >= __phys_to_dma(dev, min_mask);
 }
+
+size_t dma_direct_max_mapping_size(struct device *dev)
+{
+	/*
+	 * Return the minimum of the direct DMA limit and the SWIOTLB limit.
+	 * Since direct DMA has no limit, it is fine to just return the SWIOTLB
+	 * limit.
+	 */
+	return swiotlb_max_mapping_size(dev);
+}
-- 
2.17.1

