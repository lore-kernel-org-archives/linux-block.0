Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85254C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4BE214DA
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 08:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfA2Inr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:43:47 -0500
Received: from 8bytes.org ([81.169.241.247]:35504 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfA2Inq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 03:43:46 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 574DD1F1; Tue, 29 Jan 2019 09:43:44 +0100 (CET)
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
Subject: [PATCH 0/5 v4] Fix virtio-blk issue with SWIOTLB 
Date:   Tue, 29 Jan 2019 09:43:37 +0100
Message-Id: <20190129084342.26030-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi,

here is the fourth version of this patch-set. Previous
versions can be found here:

	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/

	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/

	V3: https://lore.kernel.org/lkml/20190123163049.24863-1-joro@8bytes.org/

The problem solved here is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb.  When the
virtio-blk driver tries to read/write a block larger than that, the
allocation of the dma-handle fails and an IO error is reported.

For all changes to v3, a diff to v3 of the patch-set is at
the end of this email.

Please review.

Thanks,

	Joerg

Joerg Roedel (5):
  swiotlb: Introduce swiotlb_max_mapping_size()
  swiotlb: Add is_swiotlb_active() function
  dma: Introduce dma_max_mapping_size()
  virtio: Introduce virtio_max_dma_size()
  virtio-blk: Consider virtio_max_dma_size() for maximum segment size

 Documentation/DMA-API.txt    |  8 ++++++++
 drivers/block/virtio_blk.c   | 10 ++++++----
 drivers/virtio/virtio_ring.c | 10 ++++++++++
 include/linux/dma-mapping.h  | 16 ++++++++++++++++
 include/linux/swiotlb.h      | 11 +++++++++++
 include/linux/virtio.h       |  2 ++
 kernel/dma/direct.c          | 11 +++++++++++
 kernel/dma/swiotlb.c         | 14 ++++++++++++++
 8 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.17.1

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
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 5c087d330b4b..e9e786b4b598 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -62,7 +62,7 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 
 extern int
 swiotlb_dma_supported(struct device *hwdev, u64 mask);
-extern size_t swiotlb_max_mapping_size(struct device *dev);
+size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
 
 #ifdef CONFIG_SWIOTLB
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9fbd075081d9..c873f9cc2146 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -670,5 +670,9 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 
 bool is_swiotlb_active(void)
 {
-	return !no_iotlb_memory;
+	/*
+	 * When SWIOTLB is initialized, even if io_tlb_start points to physical
+	 * address zero, io_tlb_end surely doesn't.
+	 */
+	return io_tlb_end != 0;
 }
