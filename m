Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33368C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 16:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0225C2184C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 16:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfAWQbP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:31:15 -0500
Received: from 8bytes.org ([81.169.241.247]:59196 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbfAWQax (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 11:30:53 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6761243A; Wed, 23 Jan 2019 17:30:51 +0100 (CET)
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
Subject: [PATCH 2/5] swiotlb: Add is_swiotlb_active() function
Date:   Wed, 23 Jan 2019 17:30:46 +0100
Message-Id: <20190123163049.24863-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123163049.24863-1-joro@8bytes.org>
References: <20190123163049.24863-1-joro@8bytes.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

This function will be used from dma_direct code to determine
the maximum segment size of a dma mapping.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/swiotlb.h | 6 ++++++
 kernel/dma/swiotlb.c    | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ceb623321f38..5c087d330b4b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -63,6 +63,7 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 extern int
 swiotlb_dma_supported(struct device *hwdev, u64 mask);
 extern size_t swiotlb_max_mapping_size(struct device *dev);
+bool is_swiotlb_active(void);
 
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
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
index 9cb21259cb0b..9fbd075081d9 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -667,3 +667,8 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 {
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
+
+bool is_swiotlb_active(void)
+{
+	return !no_iotlb_memory;
+}
-- 
2.17.1

