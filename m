Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78D7C43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C223720657
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 13:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfAONXI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:23:08 -0500
Received: from 8bytes.org ([81.169.241.247]:57736 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727626AbfAONXC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 08:23:02 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3CF402AF; Tue, 15 Jan 2019 14:23:00 +0100 (CET)
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
Subject: [PATCH 0/3 v2] Fix virtio-blk issue with SWIOTLB
Date:   Tue, 15 Jan 2019 14:22:54 +0100
Message-Id: <20190115132257.6426-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

here is the second version of my patch-set to fix a DMA
mapping size issue triggered by the virtio-blk driver.

The problem is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb.  When
the virtio-blk driver tries to read/write a block larger
than that, the allocation of the dma-handle fails and an IO
error is reported.

v1 of the patch-set can be found here:

https://lore.kernel.org/lkml/20190110134433.15672-1-joro@8bytes.org/

The change to v1 is that the maximum mapping size is now
officially propagated through the DMA-API, as suggested by
Christoph Hellwig.

Please review.

Thanks,

	Joerg

Joerg Roedel (3):
  swiotlb: Introduce swiotlb_max_mapping_size()
  dma: Introduce dma_max_mapping_size()
  virtio-blk: Consider dma_max_mapping_size() for maximum segment size

 drivers/block/virtio_blk.c  | 10 ++++++----
 include/linux/dma-mapping.h | 16 ++++++++++++++++
 include/linux/swiotlb.h     |  5 +++++
 kernel/dma/direct.c         | 10 ++++++++++
 kernel/dma/swiotlb.c        |  5 +++++
 5 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.17.1

