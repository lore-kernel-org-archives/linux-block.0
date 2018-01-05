Return-Path: <keith.busch@intel.com>
Date: Fri, 5 Jan 2018 12:01:35 -0700
From: Keith Busch <keith.busch@intel.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 09/12] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
Message-ID: <20180105190135.GB10657@localhost.localdomain>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-10-logang@deltatee.com>
 <20180105181152.GA10657@localhost.localdomain>
 <6c89e4b4-1854-c251-a5ec-7e54bc8085fc@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6c89e4b4-1854-c251-a5ec-7e54bc8085fc@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 05, 2018 at 11:19:28AM -0700, Logan Gunthorpe wrote:
> Although it is not explicitly stated anywhere, pci_alloc_p2pmem() should
> always be at least 4k aligned. This is because the gen_pool that implements
> it is created with PAGE_SHIFT for its min_alloc_order.

Ah, I see that now. Thanks for the explanation.

Does it need to be created with page sized minimum alloc order? That
granularity makes it difficult to fit SQs in CMB on archs with larger
pages when we only needed 4k alignment.

I was also hoping to extend this for PRP/SGL in CMB where even 4k is
too high a granularity to make it really useful.

It looks like creating the gen pool with a smaller minimum and
gen_pool_first_fit_order_align algo would satisfy my use cases, but I'm
not sure if there's another reason you've set it to page alignment.
