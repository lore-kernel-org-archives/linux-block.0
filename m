Return-Path: <hch@lst.de>
Date: Fri, 5 Oct 2018 09:09:56 +0200
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
Subject: Re: [PATCH v9 09/13] nvme-pci: Use PCI p2pmem subsystem to manage
 the CMB
Message-ID: <20181005070956.GA23834@lst.de>
References: <20181004212747.6301-1-logang@deltatee.com> <20181004212747.6301-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181004212747.6301-10-logang@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
