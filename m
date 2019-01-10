Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE1C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 13:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4AD20660
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 13:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfAJN7y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 08:59:54 -0500
Received: from verein.lst.de ([213.95.11.211]:48595 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbfAJN7x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 08:59:53 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4F62467358; Thu, 10 Jan 2019 14:59:52 +0100 (CET)
Date:   Thu, 10 Jan 2019 14:59:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com, hch@lst.de
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190110135952.GC9255@lst.de>
References: <20190110134433.15672-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110134433.15672-1-joro@8bytes.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 10, 2019 at 02:44:30PM +0100, Joerg Roedel wrote:
> Hi,
> 
> there is a problem with virtio-blk driven devices when
> virtio-ring uses SWIOTLB through the DMA-API. This happens
> for example in AMD-SEV enabled guests, where the guest RAM
> is mostly encrypted and all emulated DMA has to happen
> to/from the SWIOTLB aperture.
> 
> The problem is a limitation of the SWIOTLB implementation,
> which does not support allocations larger than 256kb. When
> the virtio-blk driver tries to read/write a block larger
> than that, the allocation of the dma-handle fails and an IO
> error is reported.

s/allocations/mappings/, right?  We don't use the swiotlb
buffer for the coherent allocations anymore, and I don't think
virtio-blk uses them anyway.

> This patch-set adds a check to the virtio-code whether it
> might be using SWIOTLB bounce buffering and limits the
> maximum segment size in the virtio-blk driver in this case,
> so that it doesn't try to do larger reads/writes.

I really don't like the fact that we hardcode swiotlb specific.
This needs to be indirect through the dma ops or struct device,
as various iommu implementations also have limits (although
usually much larger ones).
