Return-Path: <logang@deltatee.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Stephen Bates <sbates@raithlin.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
 <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
 <20180301231536.GB74737@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f876746d-ed91-511d-7fd9-d16232f40bd3@deltatee.com>
Date: Thu, 1 Mar 2018 16:59:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180301231536.GB74737@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 04:15 PM, Bjorn Helgaas wrote:
> The question is what the relevant switch is.  We call pci_enable_acs()
> on every PCI device, including Root Ports.  It looks like this relies
> on get_upstream_bridge_port() to filter out some things.  I don't
> think get_upstream_bridge_port() is doing the right thing, so we need
> to sort that out first, I guess.

Yes, well if a port has an upstream bridge port and that port has an 
upstream bridge port we are almost certainly looking at a port in a 
switch. If you have a better suggestion to only disable ACS bits on 
downstream switch ports I'd be happy to consider it.


> This might be a good start, but whatever the implications are, they
> need to be distilled and made clear directly in the changelog and the
> Kconfig help text.

Well, I tried. I'll expand on it for v3.

Logan
