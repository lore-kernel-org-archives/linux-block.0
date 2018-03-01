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
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-4-logang@deltatee.com>
 <20180301174941.GG13722@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <731c648d-5af3-1d5c-7169-07df12b79a41@deltatee.com>
Date: Thu, 1 Mar 2018 12:36:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180301174941.GG13722@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Add PCI p2pmem dma mappings to
 adjust the bus offset
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 10:49 AM, Bjorn Helgaas wrote:
>> +int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>> +		      enum dma_data_direction dir)
> 
> Same question as before about why the mixture of "pci_*" interfaces
> that take "struct device *" parameters.

In this case, per the discussion in v1, it was felt the _map_sg() 
function should take the same arguments as dma_map_sg().

Logan
