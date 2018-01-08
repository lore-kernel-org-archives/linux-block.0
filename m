Return-Path: <logang@deltatee.com>
To: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-7-logang@deltatee.com> <20180104192225.GS11348@ziepe.ca>
 <1f8fb3fb-e3dc-94d3-e837-0cd942cf5b87@deltatee.com>
 <20180104221337.GV11348@ziepe.ca>
 <3e8391a9-8924-be6d-8c43-162a360d75b6@deltatee.com>
 <20180105045031.GX11348@ziepe.ca> <20180108145901.GA10743@lst.de>
 <20180108180917.GF11348@ziepe.ca> <20180108183434.GA15549@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cffacbee-477a-fbe9-19cc-373cd2ec6fef@deltatee.com>
Date: Mon, 8 Jan 2018 11:44:41 -0700
MIME-Version: 1.0
In-Reply-To: <20180108183434.GA15549@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 06/12] IB/core: Add optional PCI P2P flag to
 rdma_rw_ctx_[init|destroy]()
List-ID: <linux-block@vger.kernel.org>



On 08/01/18 11:34 AM, Christoph Hellwig wrote:
> But P2P is _not_ a factor of the dma_ops implementation at all,
> it is something that happens behind the dma_map implementation.
> 
> Think about what the dma mapping routines do:
> 
>   (a) translate from host address to bus addresses
> 
> and
> 
>   (b) flush caches (in non-coherent architectures)
> 
> Both are obviously not needed for P2P transfers, as they never reach
> the host.

Isn't pci_p2pdma_map_sg doing (a)? It's just translating from a host 
address to a PCI bus address.

>> Very long term the IOMMUs under the ops will need to care about this,
>> so the wrapper is not an optimal place to put it - but I wouldn't
>> object if it gets it out of RDMA :)
> 
> Unless you have an IOMMU on your PCIe switch and not before/inside
> the root complex that is not correct.

Per the ACS discussion, in the future we might want to implement "ACS 
Direct Translated P2P" as Alex described. I expect it would be the IOMMU 
that needs to set that up. So, I think, we also have the dma_map 
implementations also doing something like:

(c) setup/manage any security permissions on mappings
Which P2P may at some point be concerned with.

Logan
