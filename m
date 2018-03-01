Return-Path: <logang@deltatee.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <90b658d9-da8a-af36-ad8f-a72ef0c6e3c1@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <112b6d99-8aac-3d45-486e-ebea62fb8670@deltatee.com>
Date: Thu, 1 Mar 2018 12:33:59 -0700
MIME-Version: 1.0
In-Reply-To: <90b658d9-da8a-af36-ad8f-a72ef0c6e3c1@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 03:31 AM, Sagi Grimberg wrote:
>> * We also reject using devices that employ 'dma_virt_ops' which should
>>    fairly simply handle Jason's concerns that this work might break with
>>    the HFI, QIB and rxe drivers that use the virtual ops to implement
>>    their own special DMA operations.
> 
> That's good, but what would happen for these devices? simply fail the
> mapping causing the ulp to fail its rdma operation? I would think
> that we need a capability flag for devices that support it.

pci_p2pmem_find() will simply not return any devices when any client 
that uses dma_virt_ops. So in the NVMe target case it simply will not 
use P2P memory.

And just in case, pci_p2pdma_map_sg() will also return 0 if the device 
passed to it uses dma_virt_ops as well. So if someone bypasses 
pci_p2pmem_find() they will get a failure during map.

Logan
