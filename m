Return-Path: <corbet@lwn.net>
Date: Mon, 12 Mar 2018 13:41:14 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org, Stephen Bates
 <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, Sagi Grimberg
 <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe
 <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>, Dan Williams
 <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWU=?= Glisse
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 05/11] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
Message-ID: <20180312134114.1e4b12f8@lwn.net>
In-Reply-To: <20180312193525.2855-6-logang@deltatee.com>
References: <20180312193525.2855-1-logang@deltatee.com>
	<20180312193525.2855-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Mon, 12 Mar 2018 13:35:19 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> Add a restructured text file describing how to write drivers
> with support for P2P DMA transactions. The document describes
> how to use the APIs that were added in the previous few
> commits.
> 
> Also adds an index for the PCI documentation tree even though this
> is the only PCI document that has ben converted to restructured text
> at this time.

This all seems good, but...could we consider moving this documentation to
driver-api/PCI as it's converted to RST?  That would keep it together with
similar materials and bring a bit more coherence to Documentation/ as a
whole.

Thanks,

jon
