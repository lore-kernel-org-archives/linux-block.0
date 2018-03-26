Return-Path: <jgg@mellanox.com>
Date: Mon, 26 Mar 2018 10:41:29 -0600
From: Jason Gunthorpe <jgg@mellanox.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
	linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Wehage <Eric.Wehage@huawei.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180326164129.GF15530@mellanox.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180326121138.00005e30@huawei.com>
Return-Path: jgg@mellanox.com
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 26, 2018 at 12:11:38PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Mar 2018 10:43:55 -0600
> Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> > On 12/03/18 09:28 PM, Sinan Kaya wrote:
> > > On 3/12/2018 3:35 PM, Logan Gunthorpe wrote:
> > > Regarding the switch business, It is amazing how much trouble you went into
> > > limit this functionality into very specific hardware.
> > > 
> > > I thought that we reached to an agreement that code would not impose
> > > any limits on what user wants.
> > > 
> > > What happened to all the emails we exchanged?  
> > 
> > It turns out that root ports that support P2P are far less common than 
> > anyone thought. So it will likely have to be a white list.
> 
> This came as a bit of a surprise to our PCIe architect.

I don't think it is a hardware problem.

I know Mellanox and Nvidia have been doing p2p on Intel root complexes
for something like 5-6 years now.. I don't have the details, but it
does seem to work.

I have heard some chips give poor performance..

Also AMD GPU SLI uses P2P these days, so this isn't exactly a niche
feature in Intel/AMD land.

I think the main issue here is that there is some BIOS involvement to
set things up properly. Eg in GPU land motherboards certify for
'crossfire' support.

> His follow up was whether it was worth raising an ECR for the PCIe spec
> to add a capability bit to allow this to be discovered.  This might
> long term avoid the need to maintain the white list for new devices.

If it is primarily a BIOS issue then it should be an ACPI thing, right?

Jason
