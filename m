Return-Path: <logang@deltatee.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180104190137.7654-7-logang@deltatee.com>
 <20180104192225.GS11348@ziepe.ca>
 <1f8fb3fb-e3dc-94d3-e837-0cd942cf5b87@deltatee.com>
 <20180104221337.GV11348@ziepe.ca>
 <3e8391a9-8924-be6d-8c43-162a360d75b6@deltatee.com>
 <20180105045031.GX11348@ziepe.ca> <20180108145901.GA10743@lst.de>
 <20180108180917.GF11348@ziepe.ca> <20180108183434.GA15549@lst.de>
 <cffacbee-477a-fbe9-19cc-373cd2ec6fef@deltatee.com>
 <20180108185743.GA15936@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7d276107-d2ae-530b-3d56-e104e22b4eea@deltatee.com>
Date: Mon, 8 Jan 2018 12:05:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180108185743.GA15936@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 06/12] IB/core: Add optional PCI P2P flag to
 rdma_rw_ctx_[init|destroy]()
List-ID: <linux-block@vger.kernel.org>



On 08/01/18 11:57 AM, Christoph Hellwig wrote:
> It does, sort of - but in a different way then the normal DMA map
> ops.  And only to work around the fact that we need to map our
> P2P space into struct pages.  Without that we could just pass the
> bus address around, but the Linux stack and VM isn't anywhere near
> ready for something that advanced.

Yeah, wouldn't that be nice.

Ok, so if we shouldn't touch the dma_map infrastructure how should the 
workaround to opt-out HFI and QIB look? I'm not that familiar with the 
RDMA code.

Thanks,

Logan
