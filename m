Return-Path: <helgaas@kernel.org>
Date: Mon, 7 May 2018 18:02:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v4 03/14] PCI/P2PDMA: Add PCI p2pmem dma mappings to
 adjust the bus offset
Message-ID: <20180507230208.GF161390@bhelgaas-glaptop.roam.corp.google.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180423233046.21476-4-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

s/dma/DMA/ (in subject)

On Mon, Apr 23, 2018 at 05:30:35PM -0600, Logan Gunthorpe wrote:
> The DMA address used when mapping PCI P2P memory must be the PCI bus
> address. Thus, introduce pci_p2pmem_[un]map_sg() to map the correct
> addresses when using P2P memory.
> 
> For this, we assume that an SGL passed to these functions contain all
> P2P memory or no P2P memory.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
