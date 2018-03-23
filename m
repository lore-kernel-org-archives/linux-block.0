Return-Path: <logang@deltatee.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Stephen Bates <sbates@raithlin.com>
Cc: Sinan Kaya <okaya@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <3e738f95-d73c-4182-2fa1-8664aafb1ab7@deltatee.com>
 <703aa92c-0c1c-4852-5887-6f6e6ccde0fb@codeaurora.org>
 <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <C90AA66C-FFC6-4CCA-B959-7BBECA65509C@raithlin.com>
 <20180323215046.GC210003@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dc414fa5-1af9-0ba7-e12e-4cd9df313119@deltatee.com>
Date: Fri, 23 Mar 2018 15:59:14 -0600
MIME-Version: 1.0
In-Reply-To: <20180323215046.GC210003@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
List-ID: <linux-block@vger.kernel.org>



On 23/03/18 03:50 PM, Bjorn Helgaas wrote:
> Popping way up the stack, my original point was that I'm trying to
> remove restrictions on what devices can participate in peer-to-peer
> DMA.  I think it's fairly clear that in conventional PCI, any devices
> in the same PCI hierarchy, i.e., below the same host-to-PCI bridge,
> should be able to DMA to each other.

Yup, we are working on this.

> The routing behavior of PCIe is supposed to be compatible with
> conventional PCI, and I would argue that this effectively requires
> multi-function PCIe devices to have the internal routing required to
> avoid the route-to-self issue.

That would be very nice but many devices do not support the internal
route. We've had to work around this in the past and as I mentioned
earlier that NVMe devices have a flag indicating support. However, if a
device wants to be involved in P2P it must support it and we can exclude
devices that don't support it by simply not enabling their drivers.

Logan
