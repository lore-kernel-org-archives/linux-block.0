Return-Path: <jonathan.cameron@huawei.com>
Date: Tue, 27 Mar 2018 09:47:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Logan Gunthorpe <logang@deltatee.com>
CC: Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@codeaurora.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-rdma@vger.kernel.org>,
	<linux-nvdimm@lists.01.org>, <linux-block@vger.kernel.org>, Stephen Bates
	<sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe
	<axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
	<sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
	<jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
	<dan.j.williams@intel.com>, =?ISO-8859-1?Q?J=E9r=F4me?= Glisse
	<jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Alex Williamson" <alex.williamson@redhat.com>, Eric Wehage
	<Eric.Wehage@huawei.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180327094701.0000300d@huawei.com>
In-Reply-To: <c717eb06-1e83-f0f3-4d6c-15531aa808e0@deltatee.com>
References: <20180312193525.2855-1-logang@deltatee.com>
	<20180312193525.2855-2-logang@deltatee.com>
	<59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
	<24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
	<20180326121138.00005e30@huawei.com>
	<20180326140118.GA221690@bhelgaas-glaptop.roam.corp.google.com>
	<c717eb06-1e83-f0f3-4d6c-15531aa808e0@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-block@vger.kernel.org>

On Mon, 26 Mar 2018 09:46:24 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 26/03/18 08:01 AM, Bjorn Helgaas wrote:
> > On Mon, Mar 26, 2018 at 12:11:38PM +0100, Jonathan Cameron wrote:  
> >> On Tue, 13 Mar 2018 10:43:55 -0600
> >> Logan Gunthorpe <logang@deltatee.com> wrote:  
> >>> It turns out that root ports that support P2P are far less common than 
> >>> anyone thought. So it will likely have to be a white list.  
> >>
> >> This came as a bit of a surprise to our PCIe architect.
> >>
> >> His follow up was whether it was worth raising an ECR for the PCIe spec
> >> to add a capability bit to allow this to be discovered.  This might
> >> long term avoid the need to maintain the white list for new devices.
> >>
> >> So is it worth having a long term solution for making this discoverable?  
> > 
> > It was surprising to me that there's no architected way to discover
> > this.  It seems like such an obvious thing that I guess I assumed the
> > omission was intentional, i.e., maybe there's something that makes it
> > impractical, but it would be worth at least asking somebody in the
> > SIG.  It seems like for root ports in the same root complex, at least,
> > there could be a bit somewhere in the root port or the RCRB (which
> > Linux doesn't support yet).  
> 
> Yes, I agree. It would be a good long term solution to have this bit in
> the spec. That would avoid us needing to create a white list for new
> hardware. However, I expect it would be years before we can rely on it
> so someone may yet implement that white list.
> 
> Logan

I'll see if I can get our PCI SIG people to follow this through and see if
it is just an omission or as Bjorn suggested, there is some reason we
aren't thinking of that makes it hard.

Agreed that it is a somewhat tangential question to what to do with current
hardware, but let's get the ball rolling if possible.

Jonathan
