Return-Path: <keith.busch@linux.intel.com>
Date: Thu, 27 Sep 2018 11:12:30 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Steve Wise <swise@opengridcomputing.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 13/13] nvmet: Optionally use PCI P2P memory
Message-ID: <20180927171230.GE19589@localhost.localdomain>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-14-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180927165420.5290-14-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 27, 2018 at 10:54:20AM -0600, Logan Gunthorpe wrote:
> We create a configfs attribute in each nvme-fabrics target port to
> enable p2p memory use. When enabled, the port will only then use the
> p2p memory if a p2p memory device can be found which is behind the
> same switch hierarchy as the RDMA port and all the block devices in
> use. If the user enabled it and no devices are found, then the system
> will silently fall back on using regular memory.
> 
> If appropriate, that port will allocate memory for the RDMA buffers
> for queues from the p2pmem device falling back to system memory should
> anything fail.
> 
> Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
> save an extra PCI transfer as the NVME card could just take the data
> out of it's own memory. However, at this time, only a limited number
> of cards with CMB buffers seem to be available.
> 
> Signed-off-by: Stephen Bates <sbates@raithlin.com>
> Signed-off-by: Steve Wise <swise@opengridcomputing.com>
> [hch: partial rewrite of the initial code]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

I haven't the necessary hardware to try this out, but looking forward
to it in the future. Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
