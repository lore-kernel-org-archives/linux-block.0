Return-Path: <logang@deltatee.com>
To: Stephen Bates <sbates@raithlin.com>, Bjorn Helgaas <helgaas@kernel.org>
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
References: <a0af83f8-2cbc-862b-6f8b-231991527cfc@deltatee.com>
 <3ea80992-a0fc-08f2-d93d-ae0ec4e3f4ce@codeaurora.org>
 <4eb6850c-df1b-fd44-3ee0-d43a50270b53@deltatee.com>
 <757fca36-dee4-e070-669e-f2788bd78e41@codeaurora.org>
 <4f761f55-4e9a-dccb-d12f-c59d2cd689db@deltatee.com>
 <BB94077B-7EB3-49C4-862D-BF77D0A692CC@raithlin.com>
 <20180313230850.GA45763@bhelgaas-glaptop.roam.corp.google.com>
 <C90AA66C-FFC6-4CCA-B959-7BBECA65509C@raithlin.com>
 <20180323215046.GC210003@bhelgaas-glaptop.roam.corp.google.com>
 <dc414fa5-1af9-0ba7-e12e-4cd9df313119@deltatee.com>
 <20180324034947.GE210003@bhelgaas-glaptop.roam.corp.google.com>
 <121026DC-40C7-4F4E-BE27-BDA652BDEB6A@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3a25744b-daa1-84e3-fbdc-5db2e81d0540@deltatee.com>
Date: Mon, 26 Mar 2018 09:43:17 -0600
MIME-Version: 1.0
In-Reply-To: <121026DC-40C7-4F4E-BE27-BDA652BDEB6A@raithlin.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
List-ID: <linux-block@vger.kernel.org>



On 24/03/18 09:28 AM, Stephen  Bates wrote:
> 1. There is no requirement for a single function to support internal DMAs but in the case of NVMe we do have a protocol specific way for a NVMe function to indicate it supports via the CMB BAR. Other protocols may also have such methods but I am not aware of them at this time.
> 
> 2. For multi-function end-points I think it is a requirement that DMAs *between* functions are supported via an internal path but this can be over-ridden by ACS when supported in the EP.
> 
> 3. For multi-function end-points there is no requirement to support internal DMA within each individual function (i.e. a la point 1 but extended to each function in a MF device). 

Yeah, that make sense. I wasn't making a huge distinction between single
and multi-function devices because from an implementation point of view
it's not that different.

Logan
