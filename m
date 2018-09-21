Return-Path: <helgaas@kernel.org>
Date: Fri, 21 Sep 2018 14:47:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
Message-ID: <20180921194700.GM224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-7-logang@deltatee.com>
 <20180921164126.GI224714@bhelgaas-glaptop.roam.corp.google.com>
 <e9739430-b238-2078-a51f-d76bae5342d1@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e9739430-b238-2078-a51f-d76bae5342d1@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 21, 2018 at 12:03:12PM -0600, Logan Gunthorpe wrote:
> On 2018-09-21 10:41 AM, Bjorn Helgaas wrote:
> >> +away, the one returned will be chosen at random. This function returns the PCI
> > 
> > s/the one returned will be chosen at random/one will be chosen
> > arbitrarily/ ?  (I doubt it's really random)
> 
> You're the second person to ask this, but yes, we really do it randomly.
> Such that if there are multiple drivers getting resources they should be
> evenly distributed. It's not the ideal solution but if it were to do it
> arbitrarily then the code would likely return the same device all the
> time and any additional devices would not get used.

Ah, I see, I should have searched for "random" in that patch and answered
my own question :)  Sorry for the noise.

Bjorn
