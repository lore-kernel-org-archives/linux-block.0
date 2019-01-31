Return-Path: <SRS0=cAVD=QH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54646C169C4
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ED920863
	for <linux-block@archiver.kernel.org>; Thu, 31 Jan 2019 16:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388505AbfAaQe3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:34:29 -0500
Received: from 8bytes.org ([81.169.241.247]:36314 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733294AbfAaQeG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Jan 2019 11:34:06 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BD46322D; Thu, 31 Jan 2019 17:34:04 +0100 (CET)
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
Subject: [PATCH 0/5 v6] Fix virtio-blk issue with SWIOTLB 
Date:   Thu, 31 Jan 2019 17:33:58 +0100
Message-Id: <20190131163403.11363-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

here is the next version of this patch-set. Previous
versions can be found here:

	V1: https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/

	V2: https://lore.kernel.org/lkml/20190115132257.6426-1-joro@8bytes.org/

	V3: https://lore.kernel.org/lkml/20190123163049.24863-1-joro@8bytes.org/

	V4: https://lore.kernel.org/lkml/20190129084342.26030-1-joro@8bytes.org/

	V5: https://lore.kernel.org/lkml/20190130164007.26497-1-joro@8bytes.org/

The problem solved here is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb.  When the
virtio-blk driver tries to read/write a block larger than that, the
allocation of the dma-handle fails and an IO error is reported.

Changes to v5 are:

	- Changed patch 3 to uninline dma_max_mapping_size()

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
 drivers/virtio/virtio_ring.c | 11 +++++++++++
 include/linux/dma-mapping.h  |  8 ++++++++
 include/linux/swiotlb.h      | 11 +++++++++++
 include/linux/virtio.h       |  2 ++
 kernel/dma/direct.c          | 11 +++++++++++
 kernel/dma/mapping.c         | 14 ++++++++++++++
 kernel/dma/swiotlb.c         | 14 ++++++++++++++
 9 files changed, 85 insertions(+), 4 deletions(-)

-- 
2.17.1

