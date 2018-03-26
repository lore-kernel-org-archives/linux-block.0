Return-Path: <helgaas@kernel.org>
Date: Mon, 26 Mar 2018 09:01:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Wehage <Eric.Wehage@huawei.com>
Subject: Re: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
Message-ID: <20180326140118.GA221690@bhelgaas-glaptop.roam.corp.google.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180326121138.00005e30@huawei.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 26, 2018 at 12:11:38PM +0100, Jonathan Cameron wrote:
> On Tue, 13 Mar 2018 10:43:55 -0600
> Logan Gunthorpe <logang@deltatee.com> wrote:
> > It turns out that root ports that support P2P are far less common than 
> > anyone thought. So it will likely have to be a white list.
> 
> This came as a bit of a surprise to our PCIe architect.
> 
> His follow up was whether it was worth raising an ECR for the PCIe spec
> to add a capability bit to allow this to be discovered.  This might
> long term avoid the need to maintain the white list for new devices.
> 
> So is it worth having a long term solution for making this discoverable?

It was surprising to me that there's no architected way to discover
this.  It seems like such an obvious thing that I guess I assumed the
omission was intentional, i.e., maybe there's something that makes it
impractical, but it would be worth at least asking somebody in the
SIG.  It seems like for root ports in the same root complex, at least,
there could be a bit somewhere in the root port or the RCRB (which
Linux doesn't support yet).
