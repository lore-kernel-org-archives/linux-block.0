Return-Path: <benh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Logan Gunthorpe <logang@deltatee.com>,
        Dan Williams
	 <dan.j.williams@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Alex Williamson
 <alex.williamson@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-rdma <linux-rdma@vger.kernel.org>, linux-pci@vger.kernel.org,
        Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe
 <jgg@mellanox.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy
 <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
Date: Fri, 02 Mar 2018 10:00:04 +1100
In-Reply-To: <43ba615f-a6e1-9444-65e1-494169cb415d@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
	 <1519876489.4592.3.camel@kernel.crashing.org>
	 <1519876569.4592.4.camel@au1.ibm.com>
	 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
	 <1519936477.4592.23.camel@au1.ibm.com>
	 <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
	 <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
	 <43ba615f-a6e1-9444-65e1-494169cb415d@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519945204.4592.45.camel@au1.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, 2018-03-01 at 14:57 -0700, Logan Gunthorpe wrote:
> 
> On 01/03/18 02:45 PM, Logan Gunthorpe wrote:
> > It handles it fine for many situations. But when you try to map 
> > something that is at the end of the physical address space then the 
> > spares-vmemmap needs virtual address space that's the size of the 
> > physical address space divided by PAGE_SIZE which may be a little bit 
> > too large...
> 
> Though, considering this more, maybe this shouldn't be a problem...
> 
> Lets say you have 56bits of address space.

We use only 52 in practice but yes.

>  That's 64PB. If you use need 
> a sparse vmemmap for the entire space it will take 16TB which leaves you 
> with 63.98PB of address space left. (Similar calculations for other 
> numbers of address bits.)

We only have 52 bits of virtual space for the kernel with the radix
MMU.

> So I'm not sure what the problem with this is.
> 
> We still have to ensure all the arches map the memory with the right 
> cache bits but that should be relatively easy to solve.
> 
> Logan
