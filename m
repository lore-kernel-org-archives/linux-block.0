Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FFCC43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 14:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33675214DA
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 14:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfAJO0m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:26:42 -0500
Received: from 8bytes.org ([81.169.241.247]:56652 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfAJO0m (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jan 2019 09:26:42 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E1B2D22E; Thu, 10 Jan 2019 15:26:40 +0100 (CET)
Date:   Thu, 10 Jan 2019 15:26:40 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, jfehlig@suse.com,
        jon.grimm@amd.com, brijesh.singh@amd.com
Subject: Re: [PATCH 0/3] Fix virtio-blk issue with SWIOTLB
Message-ID: <20190110142640.GA5825@8bytes.org>
References: <20190110134433.15672-1-joro@8bytes.org>
 <20190110135952.GC9255@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110135952.GC9255@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Thu, Jan 10, 2019 at 02:59:52PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 10, 2019 at 02:44:30PM +0100, Joerg Roedel wrote:

> > The problem is a limitation of the SWIOTLB implementation,
> > which does not support allocations larger than 256kb. When
> > the virtio-blk driver tries to read/write a block larger
> > than that, the allocation of the dma-handle fails and an IO
> > error is reported.
> 
> s/allocations/mappings/, right?  We don't use the swiotlb
> buffer for the coherent allocations anymore, and I don't think
> virtio-blk uses them anyway.

'Allocation' in the sense that there are address ranges allocated, not
memory, but mappings would also be right.

> I really don't like the fact that we hardcode swiotlb specific.
> This needs to be indirect through the dma ops or struct device,
> as various iommu implementations also have limits (although
> usually much larger ones).

I though about exposing it through DMA-API, but didn't go that route as
I didn't want to extend a generic API for some SWIOTLB specifics. But if
there are more implementations that have a size limitation it makes
certainly sense to put it into the DMA-API. I'll change that in the
next version.

Thanks,

	Joerg
