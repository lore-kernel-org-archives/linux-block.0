Return-Path: <keith.busch@linux.intel.com>
Date: Thu, 27 Sep 2018 11:10:13 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 09/13] nvme-pci: Use PCI p2pmem subsystem to manage
 the CMB
Message-ID: <20180927171013.GC19589@localhost.localdomain>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180927165420.5290-10-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 27, 2018 at 10:54:16AM -0600, Logan Gunthorpe wrote:
> Register the CMB buffer as p2pmem and use the appropriate allocation
> functions to create and destroy the IO submission queues.
> 
> If the CMB supports WDS and RDS, publish it for use as P2P memory
> by other devices.
> 
> Kernels without CONFIG_PCI_P2PDMA will also no longer support NVMe CMB.
> However, seeing the main use-cases for the CMB is P2P operations,
> this seems like a reasonable dependency.
> 
> We drop the __iomem safety on the buffer seeing that, by convention, it's
> safe to directly access memory mapped by memremap()/devm_memremap_pages().
> Architectures where this is not safe will not be supported by memremap()
> and therefore will not be support PCI P2P and have no support for CMB.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks good to me.

Reviewed-by: Keith Busch <keith.busch@intel.com>
