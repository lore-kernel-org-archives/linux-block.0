Return-Path: <helgaas@kernel.org>
Date: Fri, 21 Sep 2018 15:00:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvdimm@lists.01.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 03/13] PCI/P2PDMA: Add PCI p2pmem DMA mappings to
 adjust the bus offset
Message-ID: <20180921200021.GN224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-4-logang@deltatee.com>
 <20180921131550.GG224714@bhelgaas-glaptop.roam.corp.google.com>
 <20180921164813.GJ224714@bhelgaas-glaptop.roam.corp.google.com>
 <506dd00c-35e9-e285-bc97-c689c766b4cf@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <506dd00c-35e9-e285-bc97-c689c766b4cf@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 21, 2018 at 12:13:21PM -0600, Logan Gunthorpe wrote:
> On 2018-09-21 10:48 AM, Bjorn Helgaas wrote:
> >> I think the use of "map" in this context is slightly confusing because the
> >> general expectation is that map/unmap must be balanced.
> 
> Yeah, Jason said the same thing, but having an empty unmap function
> seems wasteful and Christoph said to just remove it. My opinion is that
> it's not that big an issue one way or another -- if we have to add an
> unmap later it's not really that hard.
> 
> >> If you keep "map", maybe add a sentence or two about why there's no
> >> corresponding unmap?
> 
> Will do.
> 
> > Another wrinkle is that "map" usually takes an A and gives you back a
> > B.  Now the caller has both A and B and both are still valid.
> > Here we pass in an SGL and the SGL is transformed, so the caller only
> > has B and A has been destroyed, i.e., the SGL can no longer be used as
> > it was before, and there's no way to get A back.
> 
> I wouldn't say that. Our map_sg function is doing the same thing
> dma_map_sg is: it sets the DMA address and length in the scatter list.
> So B is still A just with other fields set. If the caller wanted to map
> this SG in a different way they can still do so and the new DMA
> address/length would override the old values. (Normally, you'd want to
> unmap before doing something like that, but seeing our unmap is an empty
> operation, we wouldn't have to do that.)

Ok.  I was assuming s->dma_address would have been already set before
the call and would be overwritten by pci_p2pmem_map_sg().  But I guess
that's not the case -- sounds like s->dma_address is undefined before
the call.

Bjorn
