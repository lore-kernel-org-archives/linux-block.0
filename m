Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1747DC43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD85020868
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbfAONXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:23:02 -0500
Received: from 8bytes.org ([81.169.241.247]:57748 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729252AbfAONXB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 08:23:01 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4682F1FC; Tue, 15 Jan 2019 14:23:00 +0100 (CET)
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
Subject: [PATCH 1/3] swiotlb: Introduce swiotlb_max_mapping_size()
Date:   Tue, 15 Jan 2019 14:22:55 +0100
Message-Id: <20190115132257.6426-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115132257.6426-1-joro@8bytes.org>
References: <20190115132257.6426-1-joro@8bytes.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The function returns the maximum size that can be remapped
by the SWIOTLB implementation. This function will be later
exposed to users through the DMA-API.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/swiotlb.h | 5 +++++
 kernel/dma/swiotlb.c    | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7c007ed7505f..ceb623321f38 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -62,6 +62,7 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 
 extern int
 swiotlb_dma_supported(struct device *hwdev, u64 mask);
+extern size_t swiotlb_max_mapping_size(struct device *dev);
 
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
@@ -95,6 +96,10 @@ static inline unsigned int swiotlb_max_segment(void)
 {
 	return 0;
 }
+static inline size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return SIZE_MAX;
+}
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d6361776dc5c..c950b3e9f683 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -660,3 +660,8 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
+
+size_t swiotlb_max_mapping_size(struct device *dev)
+{
+	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
+}
-- 
2.17.1

