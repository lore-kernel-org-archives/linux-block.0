Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC70BC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 13:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961C82173B
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 13:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfAJNoo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:44:44 -0500
Received: from 8bytes.org ([81.169.241.247]:56476 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbfAJNoh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 08:44:37 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 55FC0329; Thu, 10 Jan 2019 14:44:35 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Date:   Thu, 10 Jan 2019 14:44:30 +0100
Message-Id: <20190110134433.15672-1-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

there is a problem with virtio-blk driven devices when
virtio-ring uses SWIOTLB through the DMA-API. This happens
for example in AMD-SEV enabled guests, where the guest RAM
is mostly encrypted and all emulated DMA has to happen
to/from the SWIOTLB aperture.

The problem is a limitation of the SWIOTLB implementation,
which does not support allocations larger than 256kb. When
the virtio-blk driver tries to read/write a block larger
than that, the allocation of the dma-handle fails and an IO
error is reported.

This patch-set adds a check to the virtio-code whether it
might be using SWIOTLB bounce buffering and limits the
maximum segment size in the virtio-blk driver in this case,
so that it doesn't try to do larger reads/writes.

Please review.

Thanks,

	Joerg

Joerg Roedel (3):
  swiotlb: Export maximum allocation size
  virtio: Introduce virtio_max_dma_size()
  virtio-blk: Consider virtio_max_dma_size() for maximum segment size

 drivers/block/virtio_blk.c   | 10 ++++++----
 drivers/virtio/virtio_ring.c | 11 +++++++++++
 include/linux/swiotlb.h      | 12 ++++++++++++
 include/linux/virtio.h       |  2 ++
 4 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.17.1

