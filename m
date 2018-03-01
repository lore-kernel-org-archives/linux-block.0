Return-Path: <helgaas@kernel.org>
Date: Thu, 1 Mar 2018 17:45:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stephen Bates <sbates@raithlin.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 01/10] PCI/P2PDMA: Support peer to peer memory
Message-ID: <20180301234519.GC74737@bhelgaas-glaptop.roam.corp.google.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-2-logang@deltatee.com>
 <20180301173752.GE13722@bhelgaas-glaptop.roam.corp.google.com>
 <b81503c2-9f07-b5f6-df06-64d1fdc53386@deltatee.com>
 <20180301230032.GA74737@bhelgaas-glaptop.roam.corp.google.com>
 <b3121c36-4ef5-0d8e-e8ef-418b48de9589@deltatee.com>
 <9B84B347-2CCF-4250-89ED-B29892E76597@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9B84B347-2CCF-4250-89ED-B29892E76597@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 11:14:46PM +0000, Stephen  Bates wrote:
> > I'm pretty sure the spec disallows routing-to-self so doing a P2P 
> > transaction in that sense isn't going to work unless the device 
> > specifically supports it and intercepts the traffic before it gets to 
> > the port.
> 
> This is correct. Unless the device intercepts the TLP before it hits
> the root-port then this would be considered a "route to self"
> violation and an error event would occur. The same holds for the
> downstream port on a PCI switch (unless route-to-self violations are
> disabled which violates the spec but which I have seen done in
> certain applications).

I agree that a function doing DMA to a sibling within the same
multi-function device would probably not generate a TLP for it (I
would be curious to read about this in the spec if you have a
pointer).

More fundamentally, is there some multi-function-specific restriction
on peer-to-peer DMA?  In conventional PCI, single-function devices on
the same bus can DMA to each other.  The transactions will appear on
the bus, but the upstream bridge will ignore them because the address
is inside the bridge's memory window.  As far as I know, the same
should happen on PCIe.

I don't know what happens with functions of a multi-function device,
either in conventional PCI or PCIe.  I don't remember a restriction on
whether they can DMA to each other, but maybe there is.

Bjorn
