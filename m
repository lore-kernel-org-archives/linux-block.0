Return-Path: <jglisse@redhat.com>
Date: Thu, 1 Mar 2018 16:35:33 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Stephen Bates <sbates@raithlin.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
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
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
Message-ID: <20180301213533.GE6742@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
 <0D05579B-789C-4A19-B3A2-C1A630BE31C0@raithlin.com>
 <20180301142155.5966c4c0@w520.home>
 <EE1B4EB7-D3C0-4916-81CE-E647222D03E4@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <EE1B4EB7-D3C0-4916-81CE-E647222D03E4@raithlin.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 09:32:20PM +0000, Stephen  Bates wrote:
> > your kernel provider needs to decide whether they favor device assignment or p2p
> 
> Thanks Alex! The hardware requirements for P2P (switch, high performance EPs) are such that we really only expect CONFIG_P2P_DMA to be enabled in specific instances and in those instances the users have made a decision to favor P2P over IOMMU isolation. Or they have setup their PCIe topology in a way that gives them IOMMU isolation where they want it and P2P where they want it.
> 
> 

Note that they are usecase for P2P where IOMMU isolation matter and
the traffic through root complex isn't see as an issue. For instance
for GPU the idea is that you want to allow the RDMA device to directly
read or write from GPU memory to avoid having to migrate memory to
system memory. This isn't so much for performance than for ease of
use.

Cheers,
J�r�me
