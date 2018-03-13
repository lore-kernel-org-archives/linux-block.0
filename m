Return-Path: <logang@deltatee.com>
To: Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
Date: Tue, 13 Mar 2018 10:43:55 -0600
MIME-Version: 1.0
In-Reply-To: <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
List-ID: <linux-block@vger.kernel.org>



On 12/03/18 09:28 PM, Sinan Kaya wrote:
> On 3/12/2018 3:35 PM, Logan Gunthorpe wrote:
> Regarding the switch business, It is amazing how much trouble you went into
> limit this functionality into very specific hardware.
> 
> I thought that we reached to an agreement that code would not impose
> any limits on what user wants.
> 
> What happened to all the emails we exchanged?

It turns out that root ports that support P2P are far less common than 
anyone thought. So it will likely have to be a white list. Nobody else 
seems keen on allowing the user to enable this on hardware that doesn't 
work. The easiest solution is still limiting it to using a switch. From 
there, if someone wants to start creating a white-list then that's 
probably the way forward to support root ports.

And there's also the ACS problem which means if you want to use P2P on 
the root ports you'll have to disable ACS on the entire system. (Or 
preferably, the IOMMU groups need to get more sophisticated to allow for 
dynamic changes).

Additionally, once you allow for root ports you may find the IOMMU 
getting in the way.

So there are great deal more issues to sort out if you don't restrict to 
devices behind switches.

Logan
