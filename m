Return-Path: <hch@lst.de>
Date: Tue, 9 Jan 2018 17:47:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <20180109164747.GB12159@lst.de>
References: <1f8fb3fb-e3dc-94d3-e837-0cd942cf5b87@deltatee.com> <20180104221337.GV11348@ziepe.ca> <3e8391a9-8924-be6d-8c43-162a360d75b6@deltatee.com> <20180105045031.GX11348@ziepe.ca> <20180108145901.GA10743@lst.de> <20180108180917.GF11348@ziepe.ca> <20180108183434.GA15549@lst.de> <cffacbee-477a-fbe9-19cc-373cd2ec6fef@deltatee.com> <20180108185743.GA15936@lst.de> <7d276107-d2ae-530b-3d56-e104e22b4eea@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7d276107-d2ae-530b-3d56-e104e22b4eea@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jan 08, 2018 at 12:05:57PM -0700, Logan Gunthorpe wrote:
> Ok, so if we shouldn't touch the dma_map infrastructure how should the 
> workaround to opt-out HFI and QIB look? I'm not that familiar with the RDMA 
> code.

We can add a no_p2p quirk, I'm just not sure what the right place
for it is.  As said they device don't really mind P2P at the PCIe
level, it's just that their RDMA implementation is really strange.

So I'd be tempted to do it in RDMA.
