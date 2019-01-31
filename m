Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA66FC169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 13:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD2D218AF
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 13:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfAaNB3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:01:29 -0500
Received: from 8bytes.org ([81.169.241.247]:36214 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732280AbfAaNB3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 08:01:29 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AEA6B5F0; Thu, 31 Jan 2019 14:01:27 +0100 (CET)
Date:   Thu, 31 Jan 2019 14:01:27 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, jroedel@suse.de,
        Thomas.Lendacky@amd.com
Subject: [PATCH] dma: Uninline dma_max_mapping_size()
Message-ID: <20190131130127.GP32526@8bytes.org>
References: <20190130164007.26497-1-joro@8bytes.org>
 <20190130164007.26497-4-joro@8bytes.org>
 <20190131104129.GA9241@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131104129.GA9241@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 31, 2019 at 11:41:29AM +0100, Christoph Hellwig wrote:
> Sorry for not noticing last time, but since 5.0 we keep all non-fast
> path DMA mapping interfaces out of line, so this should move to
> kernel/dma/mapping.c.

Okay, attached patch does that. It applies on-top of this patch-set.

Michael, feel free to either apply this on-top of the patch-set or merge
the diff into patch 3, whatever you prefer.

From 2bb95d2136280c79de9553852ee3370f6d42d7b3 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Thu, 31 Jan 2019 13:55:27 +0100
Subject: [PATCH] dma: Uninline dma_max_mapping_size()

The function is not performance sensitive and doesn't need
to be inlined at every call-site. Move it out of the header
into the appropriate C source file.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/dma-mapping.h | 18 +++++-------------
 kernel/dma/direct.c         |  1 -
 kernel/dma/mapping.c        | 14 ++++++++++++++
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a3ca8a71a704..5b21f14802e1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -443,19 +443,6 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
-static inline size_t dma_max_mapping_size(struct device *dev)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	size_t size = SIZE_MAX;
-
-	if (dma_is_direct(ops))
-		size = dma_direct_max_mapping_size(dev);
-	else if (ops && ops->max_mapping_size)
-		size = ops->max_mapping_size(dev);
-
-	return size;
-}
-
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
@@ -476,6 +463,7 @@ int dma_supported(struct device *dev, u64 mask);
 int dma_set_mask(struct device *dev, u64 mask);
 int dma_set_coherent_mask(struct device *dev, u64 mask);
 u64 dma_get_required_mask(struct device *dev);
+size_t dma_max_mapping_size(struct device *dev);
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -577,6 +565,10 @@ static inline u64 dma_get_required_mask(struct device *dev)
 {
 	return 0;
 }
+static inline size_t dma_max_mapping_size(struct device *dev)
+{
+	return 0;
+}
 #endif /* CONFIG_HAS_DMA */
 
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 81ca8170b928..6310ad01f915 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -391,4 +391,3 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 
 	return size;
 }
-EXPORT_SYMBOL(dma_direct_max_mapping_size);
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index a11006b6d8e8..5753008ab286 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -357,3 +357,17 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		ops->cache_sync(dev, vaddr, size, dir);
 }
 EXPORT_SYMBOL(dma_cache_sync);
+
+size_t dma_max_mapping_size(struct device *dev)
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
+EXPORT_SYMBOL_GPL(dma_max_mapping_size);
-- 
2.16.4

