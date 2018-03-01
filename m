Return-Path: <jglisse@redhat.com>
Date: Thu, 1 Mar 2018 16:10:36 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, linux-kernel@vger.kernel.org,
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
	Alex Williamson <alex.williamson@redhat.com>,
	Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Message-ID: <20180301211036.GB6742@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com>
 <20180301205548.GA6742@redhat.com>
 <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 02:03:26PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 01/03/18 01:55 PM, Jerome Glisse wrote:
> > Well this again a new user of struct page for device memory just for
> > one usecase. I wanted HMM to be more versatile so that it could be use
> > for this kind of thing too. I guess the message didn't go through. I
> > will take some cycles tomorrow to look into this patchset to ascertain
> > how struct page is use in this context.
> 
> We looked at it but didn't see how any of it was applicable to our needs.
> 

It seems people miss-understand HMM :( you do not have to use all of
its features. If all you care about is having struct page then just
use that for instance in your case only use those following 3 functions:

hmm_devmem_add() or hmm_devmem_add_resource() and hmm_devmem_remove()
for cleanup.

You can set the fault callback to an empty stub that always do return
VM_SIGBUS or a patch to allow NULL callback inside HMM.

You don't have to use the free callback if you don't care and if there
is something that doesn't quite match what you want HMM can always be
ajusted to address this.

The intention of HMM is to be useful for all device memory that wish
to have struct page for various reasons.

Cheers,
J�r�me
