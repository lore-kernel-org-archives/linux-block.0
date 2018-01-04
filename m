Return-Path: <helgaas@kernel.org>
Date: Thu, 4 Jan 2018 15:59:42 -0600
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
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/12] pci-p2p: Support peer to peer memory
Message-ID: <20180104215941.GG189897@bhelgaas-glaptop.roam.corp.google.com>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180104190137.7654-2-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jan 04, 2018 at 12:01:26PM -0700, Logan Gunthorpe wrote:
> Some PCI devices may have memory mapped in a BAR space that's
> intended for use in Peer-to-Peer transactions. In order to enable
> such transactions the memory must be registered with ZONE_DEVICE pages
> so it can be used by DMA interfaces in existing drivers.
> ...

> + * pci_p2pmem_alloc_sgl - allocate p2p memory in an sgl
> + * @pdev:	the device to allocate memory from
> + * @sgl:	the allocated sgl
> + * @nents:      the number of sgs in the list
> + * @length:     number of bytes to allocate

Your later patches use "SGL" in English text.  If that's the conventional
capitalization, please use it here, too.
