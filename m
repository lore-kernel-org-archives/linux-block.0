Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F39C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 13:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2C120879
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 13:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfAJNoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:44:37 -0500
Received: from 8bytes.org ([81.169.241.247]:56498 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbfAJNog (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 08:44:36 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 63F903BF; Thu, 10 Jan 2019 14:44:35 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/3] swiotlb: Export maximum allocation size
Date:   Thu, 10 Jan 2019 14:44:31 +0100
Message-Id: <20190110134433.15672-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110134433.15672-1-joro@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The SWIOTLB implementation has a maximum size it can
allocate dma-handles for. This needs to be exported so that
device drivers don't try to allocate larger chunks.

This is especially important for block device drivers like
virtio-blk, that might do DMA through SWIOTLB.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/swiotlb.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7c007ed7505f..0bcc80a97036 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -72,6 +72,11 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
 
+static inline size_t swiotlb_max_alloc_size(void)
+{
+	return ((1UL << IO_TLB_SHIFT) * IO_TLB_SEGSIZE);
+}
+
 bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void __init swiotlb_exit(void);
@@ -95,6 +100,13 @@ static inline unsigned int swiotlb_max_segment(void)
 {
 	return 0;
 }
+
+static inline size_t swiotlb_max_alloc_size(void)
+{
+	/* There is no limit when SWIOTLB isn't used */
+	return ~0UL;
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
-- 
2.17.1

