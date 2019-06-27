Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBBBC48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 09:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8EB2083B
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 09:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfF0JJS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 05:09:18 -0400
Received: from verein.lst.de ([213.95.11.211]:50859 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0JJR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 05:09:17 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7C50668B20; Thu, 27 Jun 2019 11:08:43 +0200 (CEST)
Date:   Thu, 27 Jun 2019 11:08:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190627090843.GB11548@lst.de>
References: <20190624072752.GA3954@lst.de> <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com> <20190625072008.GB30350@lst.de> <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com> <20190625170115.GA9746@lst.de> <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com> <20190626065708.GB24531@lst.de> <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com> <20190626202107.GA5850@ziepe.ca> <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 26, 2019 at 02:45:38PM -0600, Logan Gunthorpe wrote:
> > The bar info would give the exporting struct device and any other info
> > we need to make the iommu mapping.
> 
> Well, the IOMMU mapping is the normal thing the mapping driver will
> always do. We'd really just need the submitting driver to, when
> appropriate, inform the mapping driver that this is a pci bus address
> and not to call dma_map_xxx(). Then, for special mappings for the CMB
> like Christoph is talking about, it's simply a matter of doing a range
> compare on the PCI Bus address and converting the bus address to a BAR
> and offset.

Well, range compare on the physical address.  We have a few different
options here:

 (a) a range is normal RAM, DMA mapping works as usual
 (b) a range is another devices BAR, in which case we need to do a
     map_resource equivalent (which really just means don't bother with
     cache flush on non-coherent architectures) and apply any needed
     offset, fixed or iommu based
 (c) a range points to a BAR on the acting device. In which case we
     don't need to DMA map at all, because no dma is happening but just an
     internal transfer.  And depending on the device that might also require
     a different addressing mode

I guess it might make sense to just have a block layer flag that (b) or
(c) might be contained in a bio.  Then we always look up the data
structure, but can still fall back to (a) if nothing was found.  That
even allows free mixing and matching of memory types, at least as long
as they are contained to separate bio_vec segments.
