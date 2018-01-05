Return-Path: <logang@deltatee.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-2-logang@deltatee.com>
 <20180104215941.GG189897@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <debc98f9-9c31-26a8-08e2-a2e31fc25e34@deltatee.com>
Date: Thu, 4 Jan 2018 17:20:19 -0700
MIME-Version: 1.0
In-Reply-To: <20180104215941.GG189897@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 01/12] pci-p2p: Support peer to peer memory
List-ID: <linux-block@vger.kernel.org>



On 04/01/18 02:59 PM, Bjorn Helgaas wrote:
> On Thu, Jan 04, 2018 at 12:01:26PM -0700, Logan Gunthorpe wrote:
>> Some PCI devices may have memory mapped in a BAR space that's
>> intended for use in Peer-to-Peer transactions. In order to enable
>> such transactions the memory must be registered with ZONE_DEVICE pages
>> so it can be used by DMA interfaces in existing drivers.
>> ...
> 
>> + * pci_p2pmem_alloc_sgl - allocate p2p memory in an sgl
>> + * @pdev:	the device to allocate memory from
>> + * @sgl:	the allocated sgl
>> + * @nents:      the number of sgs in the list
>> + * @length:     number of bytes to allocate
> 
> Your later patches use "SGL" in English text.  If that's the conventional
> capitalization, please use it here, too.
> 

I'm not sure there is a convention. scatterlist.h uses 'sglist' and 
'scatterlist' so I'll just change my comments to use the latter.

Logan
