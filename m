Return-Path: <keith.busch@intel.com>
Date: Tue, 25 Sep 2018 11:48:35 -0600
From: Keith Busch <keith.busch@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v7 10/13] nvme-pci: Add support for P2P memory in requests
Message-ID: <20180925174835.GA12185@localhost.localdomain>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-11-logang@deltatee.com>
 <20180925171147.GB11822@localhost.localdomain>
 <3549a9bb-3604-1739-c008-4e1a95441333@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3549a9bb-3604-1739-c008-4e1a95441333@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 25, 2018 at 11:41:44AM -0600, Logan Gunthorpe wrote:
> Hey,
> 
> On 2018-09-25 11:11 a.m., Keith Busch wrote:
> > Sorry if this was already discussed. Is there a reason the following
> > pattern is not pushed to the generic dma_map_sg_attrs?
> > 
> > 	if (is_pci_p2pdma_page(sg_page(sg)))
> > 		pci_p2pdma_map_sg(dev, sg, nents, dma_dir);
> > 
> > Beyond that, series looks good.
> 
> Yes, this has been discussed. It comes down to a few reasons:
> 
> 1) Intrusiveness on other systems: ie. not needing to pay the cost for
> every single dma_map_sg call
> 
> 2) Consistency: we can add the check to dma_map_sg, but adding similar
> functionality to dma_map_page, etc is difficult seeing it's hard for the
> unmap operation to detect if a dma_addr_t was P2P memory to begin with.
> 
> 3) Safety for developers trying to use P2P memory: Right now developers
> must be careful with P2P pages and ensure they aren't mapped using other
> means (ie dma_map_page). Having them check the drivers that are handling
> the pages to ensure the appropriate map function is always used is and
> that P2P pages aren't being mixed with regular pages is better than
> developers relying on magic in dma_map_sg() and getting things wrong.
> 
> That being said, I think in the future everyone would like to move in
> that direction but it means we will have to solve some difficult
> problems with the existing infrastructure.

Gotchya, thanks for jogging my memory.
