Return-Path: <helgaas@kernel.org>
Date: Fri, 21 Sep 2018 08:07:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
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
Subject: Re: [PATCH v6 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
Message-ID: <20180921130705.GF224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180913001156.4115-3-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 12, 2018 at 06:11:45PM -0600, Logan Gunthorpe wrote:
> Add a sysfs group to display statistics about P2P memory that is
> registered in each PCI device.
> 
> Attributes in the group display the total amount of P2P memory, the
> amount available and whether it is published or not.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +What:		/sys/bus/pci/devices/.../p2pmem/available
> +Date:		November 2017
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		If the device has any Peer-to-Peer memory registered, this
> +	        file contains the amount of memory that has not been
> +		allocated (in decimal).
> +
> +What:		/sys/bus/pci/devices/.../p2pmem/size
> +Date:		November 2017
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		If the device has any Peer-to-Peer memory registered, this
> +	        file contains the total amount of memory that the device
> +		provides (in decimal).

Maybe reorder this so the "size" (total amount) is documented before
"available" (some subset of "size")?

> +
> +What:		/sys/bus/pci/devices/.../p2pmem/published
> +Date:		November 2017
> +Contact:	Logan Gunthorpe <logang@deltatee.com>
> +Description:
> +		If the device has any Peer-to-Peer memory registered, this
> +	        file contains a '1' if the memory has been published for
> +		use inside the kernel or a '0' if it is only intended
> +		for use within the driver that published it.

It doesn't read quite right to talk about "use within the driver that
*published* it".  Is it really published in that case?  That sounds more
like "private".  I expected something like the following (but I don't claim
to understand the whole use model here):

  ... this file contains a '1' if the memory has been published for use
  outside the driver that owns the device.
