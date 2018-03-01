Return-Path: <benh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI
 Memory
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Dan Williams <dan.j.williams@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens
 Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi
 Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason
 Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Alex Williamson
 <alex.williamson@redhat.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>
Date: Fri, 02 Mar 2018 07:40:15 +1100
In-Reply-To: <1519936477.4592.23.camel@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
	 <1519876489.4592.3.camel@kernel.crashing.org>
	 <1519876569.4592.4.camel@au1.ibm.com>
	 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
	 <1519936477.4592.23.camel@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1519936815.4592.25.camel@au1.ibm.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-03-02 at 07:34 +1100, Benjamin Herrenschmidt wrote:
> 
> But what happens with that PCI memory ? Is it effectively turned into
> nromal memory (ie, usable for normal allocations, potentially used to
> populate user pages etc...) or is it kept aside ?

(What I mean is is it added to the page allocator basically)

Also we need to be able to hard block MEMREMAP_WB mappings of non-RAM
on ppc64 (maybe via an arch hook as it might depend on the processor
family). Server powerpc cannot do cachable accesses on IO memory
(unless it's special OpenCAPI or nVlink, but not on PCIe).

> Also on ppc64, the physical addresses of PCIe make it so far appart
> that there's no way we can map them into the linear mapping at the
> normal offset of PAGE_OFFSET + (pfn << PAGE_SHIFT), so things like
> page_address or virt_to_page cannot work as-is on PCIe addresses.

Talking of which ... is there any documentation on the whole
memremap_page ? my grep turned out empty...

Cheers,
Ben.
