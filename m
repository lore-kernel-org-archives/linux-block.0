Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46022C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 11:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2066921902
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 11:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfBGL7d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:59:33 -0500
Received: from 8bytes.org ([81.169.241.247]:38792 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfBGL7X (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 06:59:23 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 590E241A; Thu,  7 Feb 2019 12:59:21 +0100 (CET)
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
Subject: [PATCH v7 2/5] swiotlb: Add is_swiotlb_active() function
Date:   Thu,  7 Feb 2019 12:59:14 +0100
Message-Id: <20190207115917.20535-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207115917.20535-1-joro@8bytes.org>
References: <20190207115917.20535-1-joro@8bytes.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This function will be used from dma_direct code to determine
the maximum segment size of a dma mapping.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/swiotlb.h | 6 ++++++
 kernel/dma/swiotlb.c    | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index d3980aeed4a0..29bc3a203283 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -77,6 +77,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
+bool is_swiotlb_active(void);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 static inline bool is_swiotlb_buffer(phys_addr_t paddr)
@@ -100,6 +101,11 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
 {
 	return SIZE_MAX;
 }
+
+static inline bool is_swiotlb_active(void)
+{
+	return false;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9cb21259cb0b..c873f9cc2146 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -667,3 +667,12 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 {
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
+
+bool is_swiotlb_active(void)
+{
+	/*
+	 * When SWIOTLB is initialized, even if io_tlb_start points to physical
+	 * address zero, io_tlb_end surely doesn't.
+	 */
+	return io_tlb_end != 0;
+}
-- 
2.17.1

