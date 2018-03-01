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
 <20180228234006.21093-2-logang@deltatee.com>
 <20180301173752.GE13722@bhelgaas-glaptop.roam.corp.google.com>
 <b81503c2-9f07-b5f6-df06-64d1fdc53386@deltatee.com>
 <20180301230032.GA74737@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b3121c36-4ef5-0d8e-e8ef-418b48de9589@deltatee.com>
Date: Thu, 1 Mar 2018 16:06:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180301230032.GA74737@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 01/10] PCI/P2PDMA: Support peer to peer memory
List-ID: <linux-block@vger.kernel.org>



> I don't think this is correct.  A Root Port defines a hierarchy domain
> (I'm looking at PCIe r4.0, sec 1.3.1).  The capability to route
> peer-to-peer transactions *between* hierarchy domains is optional.  I
> think this means a Root Complex is not required to route transactions
> from one Root Port to another Root Port.
> 
> This doesn't say anything about routing between two different devices
> below a Root Port.  Those would be in the same hierarchy domain and
> should follow the conventional PCI routing rules.  Of course, since a
> Root Port has one link that leads to one device, they would probably
> be different functions of a single multi-function device, so I don't
> know how practical it would be to test this.

Yes, given that there's only one device below a root port it will either 
be a switch or a multi-function device. In the multi-function device 
case, I'm pretty sure the spec disallows routing-to-self so doing a P2P 
transaction in that sense isn't going to work unless the device 
specifically supports it and intercepts the traffic before it gets to 
the port.

But, if we're talking about multi-function devices it should be able to 
do everything within it's own driver so it's not exactly Peer-to-Peer. 
Still, if someone has such hardware I think it's up to them to add 
support for this odd situation.

Logan
