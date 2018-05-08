Return-Path: <alex.williamson@redhat.com>
Date: Tue, 8 May 2018 14:13:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Bjorn Helgaas
 <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>, Christoph
 Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
 <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas
 <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy
 <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all
 devices behind switches
Message-ID: <20180508141331.7cd737cb@w520.home>
In-Reply-To: <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
	<20180423233046.21476-5-logang@deltatee.com>
	<20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
	<e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
	<0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
	<a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
	<3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
	<20180508133407.57a46902@w520.home>
	<5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 8 May 2018 13:45:50 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 08/05/18 01:34 PM, Alex Williamson wrote:
> > They are not so unrelated, see the ACS Direct Translated P2P
> > capability, which in fact must be implemented by switch downstream
> > ports implementing ACS and works specifically with ATS.  This appears to
> > be the way the PCI SIG would intend for P2P to occur within an IOMMU
> > managed topology, routing pre-translated DMA directly between peer
> > devices while requiring non-translated requests to bounce through the
> > IOMMU.  Really, what's the value of having an I/O virtual address space
> > provided by an IOMMU if we're going to allow physical DMA between
> > downstream devices, couldn't we just turn off the IOMMU altogether?  Of
> > course ATS is not without holes itself, basically that we trust the
> > endpoint's implementation of ATS implicitly.  Thanks,  
> 
> I agree that this is what the SIG intends, but I don't think hardware
> fully supports this methodology yet. The Direct Translated capability
> just requires switches to forward packets that have the AT request type
> set. It does not require them to do the translation or to support ATS
> such that P2P requests can be translated by the IOMMU. I expect this is
> so that an downstream device can implement ATS and not get messed up by
> an upstream switch that doesn't support it.

Well, I'm a bit confused, this patch series is specifically disabling
ACS on switches, but per the spec downstream switch ports implementing
ACS MUST implement direct translated P2P.  So it seems the only
potential gap here is the endpoint, which must support ATS or else
there's nothing for direct translated P2P to do.  The switch port plays
no part in the actual translation of the request, ATS on the endpoint
has already cached the translation and is now attempting to use it.
For the switch port, this only becomes a routing decision, the request
is already translated, therefore ACS RR and EC can be ignored to
perform "normal" (direct) routing, as if ACS were not present.  It would
be a shame to go to all the trouble of creating this no-ACS mode to find
out the target hardware supports ATS and should have simply used it, or
we should have disabled the IOMMU altogether, which leaves ACS disabled.
Thanks,

Alex
