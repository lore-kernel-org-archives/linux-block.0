Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46885 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbeIEXus (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Sep 2018 19:50:48 -0400
Date: Wed, 5 Sep 2018 21:22:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v5 10/13] nvme-pci: Add support for P2P memory in
 requests
Message-ID: <20180905192252.GA888@lst.de>
References: <20180830185352.3369-1-logang@deltatee.com> <20180830185352.3369-11-logang@deltatee.com> <20180904151638.GL335@mellanox.com> <d5548f5d-59df-f38e-255d-59b46a17a219@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d5548f5d-59df-f38e-255d-59b46a17a219@deltatee.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 04, 2018 at 09:47:07AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 04/09/18 09:16 AM, Jason Gunthorpe wrote:
> >>  	if (iod->nents) {
> >> -		dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
> >> +		/* P2PDMA requests do not need to be unmapped */
> >> +		if (!is_pci_p2pdma_page(sg_page(iod->sg)))
> >> +			dma_unmap_sg(dev->dev, iod->sg, iod->nents, dma_dir);
> > 
> > This seems like a poor direction, if we add IOMMU hairpin support we
> > will need unmapping.
> 
> It can always be added later. In any case, you'll have to convince
> Christoph who requested the change; I'm not that invested in this decision.

Yes, no point to add dead code here.  In the long run we should
aim for hiding the p2p address translation behind the normal DMA API
anyway, but we're not quite ready for it yet.
