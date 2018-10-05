Return-Path: <hch@lst.de>
Date: Fri, 5 Oct 2018 09:09:13 +0200
From: Christoph Hellwig <hch@lst.de>
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
Subject: Re: [PATCH v9 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
Message-ID: <20181005070913.GD23761@lst.de>
References: <20181004212747.6301-1-logang@deltatee.com> <20181004212747.6301-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181004212747.6301-8-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 04, 2018 at 03:27:41PM -0600, Logan Gunthorpe wrote:
> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
> supports targeting P2P memory. This will be used by P2P providers and
> orchestrators (in subsequent patches) to ensure block devices can
> support P2P memory before submitting P2P backed pages to submit_bio().
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Christoph Hellwig <hch@lst.de>
