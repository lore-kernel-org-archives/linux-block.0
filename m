Return-Path: <hch@lst.de>
Date: Tue, 9 Jan 2018 17:55:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 06/12] IB/core: Add optional PCI P2P flag to
	rdma_rw_ctx_[init|destroy]()
Message-ID: <20180109165549.GC12159@lst.de>
References: <20180104190137.7654-7-logang@deltatee.com> <20180104192225.GS11348@ziepe.ca> <1f8fb3fb-e3dc-94d3-e837-0cd942cf5b87@deltatee.com> <20180104221337.GV11348@ziepe.ca> <3e8391a9-8924-be6d-8c43-162a360d75b6@deltatee.com> <20180105045031.GX11348@ziepe.ca> <20180108145901.GA10743@lst.de> <20180108180917.GF11348@ziepe.ca> <20180108183434.GA15549@lst.de> <20180108190116.GI11348@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180108190116.GI11348@ziepe.ca>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 08, 2018 at 12:01:16PM -0700, Jason Gunthorpe wrote:
> > So I very much disagree about where to place that workaround - the
> > RDMA code is exactly the right place.
> 
> But why? RDMA is using core code to do this. It uses dma_ops in struct
> device and it uses normal dma_map SG. How is it RDMA's problem that
> some PCI drivers provide strange DMA ops?

Because RDMA uses the dma_virt_ops to pretend a device does DMA when
in fact it doesn't - at least not for the exact data mapped, or
as far as I can tell often not all - e.g. the QIB/HFI devices
might do mmio access for data mapped.

This whole problem only exist because a few RDMA HCA drivers lie
with the help of the RDMA core.
