Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <76c1bd8e-6eb4-3238-5cee-7fdeaeccc574@infradead.org>
Date: Mon, 23 Apr 2018 20:33:47 -0700
MIME-Version: 1.0
In-Reply-To: <20180423233046.21476-5-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 04/23/2018 04:30 PM, Logan Gunthorpe wrote:> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>> ---
>  drivers/pci/Kconfig        |  9 +++++++++>  drivers/pci/p2pdma.c       | 45 ++++++++++++++++++++++++++++++--------------->  drivers/pci/pci.c          |  6 ++++++>  include/linux/pci-p2pdma.h |  5 +++++>  4 files changed, 50 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index b2396c22b53e..b6db41d4b708 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -139,6 +139,15 @@ config PCI_P2PDMA
>  	  transations must be between devices behind the same root port.
>  	  (Typically behind a network of PCIe switches).
>  
> +	  Enabling this option will also disable ACS on all ports behind
> +	  any PCIe switch. This effectively puts all devices behind any
> +	  switch heirarchy into the same IOMMU group. Which implies that

	         hierarchy                     group, which

and sames fixes in the commit description...

> +	  individual devices behind any switch will not be able to be
> +	  assigned to separate VMs because there is no isolation between
> +	  them. Additionally, any malicious PCIe devices will be able to
> +	  DMA to memory exposed by other EPs in the same domain as TLPs
> +	  will not be checked by the IOMMU.
> +
>  	  If unsure, say N.
>  
>  config PCI_LABEL


-- 
~Randy
