Return-Path: <keith.busch@linux.intel.com>
Date: Thu, 27 Sep 2018 11:09:26 -0600
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
Subject: Re: [PATCH v8 11/13] nvme-pci: Add a quirk for a pseudo CMB
Message-ID: <20180927170925.GB19589@localhost.localdomain>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-12-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180927165420.5290-12-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 27, 2018 at 10:54:18AM -0600, Logan Gunthorpe wrote:
> Introduce a quirk to use CMB-like memory on older devices that have
> an exposed BAR but do not advertise support for using CMBLOC and
> CMBSIZE.
> 
> We'd like to use some of these older cards to test P2P memory.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

The implementation looks fine, and this is why we have quirks ... but
CMB has existed since 2014! :)

Reviewed-by: Keith Busch <keith.busch@intel.com>
