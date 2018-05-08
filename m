Return-Path: <alex.williamson@redhat.com>
Date: Tue, 8 May 2018 14:43:41 -0600
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
Message-ID: <20180508144341.0441b676@w520.home>
In-Reply-To: <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
	<20180423233046.21476-5-logang@deltatee.com>
	<20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
	<e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
	<0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
	<a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
	<3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
	<20180508133407.57a46902@w520.home>
	<5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
	<20180508141331.7cd737cb@w520.home>
	<d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Tue, 8 May 2018 14:19:05 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 08/05/18 02:13 PM, Alex Williamson wrote:
> > Well, I'm a bit confused, this patch series is specifically disabling
> > ACS on switches, but per the spec downstream switch ports implementing
> > ACS MUST implement direct translated P2P.  So it seems the only
> > potential gap here is the endpoint, which must support ATS or else
> > there's nothing for direct translated P2P to do.  The switch port plays
> > no part in the actual translation of the request, ATS on the endpoint
> > has already cached the translation and is now attempting to use it.
> > For the switch port, this only becomes a routing decision, the request
> > is already translated, therefore ACS RR and EC can be ignored to
> > perform "normal" (direct) routing, as if ACS were not present.  It would
> > be a shame to go to all the trouble of creating this no-ACS mode to find
> > out the target hardware supports ATS and should have simply used it, or
> > we should have disabled the IOMMU altogether, which leaves ACS disabled.  
> 
> Ah, ok, I didn't think it was the endpoint that had to implement ATS.
> But in that case, for our application, we need NVMe cards and RDMA NICs
> to all have ATS support and I expect that is just as unlikely. At least
> none of the endpoints on my system support it. Maybe only certain GPUs
> have this support.

Yes, GPUs seem to be leading the pack in implementing ATS.  So now the
dumb question, why not simply turn off the IOMMU and thus ACS?  The
argument of using the IOMMU for security is rather diminished if we're
specifically enabling devices to poke one another directly and clearly
this isn't favorable for device assignment either.  Are there target
systems where this is not a simple kernel commandline option?  Thanks,

Alex
