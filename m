Return-Path: <jglisse@redhat.com>
Date: Thu, 1 Mar 2018 16:18:18 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: benh@au1.ibm.com, Dan Williams <dan.j.williams@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-rdma <linux-rdma@vger.kernel.org>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Oliver OHalloran <oliveroh@au1.ibm.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
Message-ID: <20180301211817.GC6742@redhat.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519938210.4592.30.camel@au1.ibm.com>
 <1de70207-40ce-29f0-6093-337112852475@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1de70207-40ce-29f0-6093-337112852475@deltatee.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 01, 2018 at 02:11:34PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 01/03/18 02:03 PM, Benjamin Herrenschmidt wrote:
> > However, what happens if anything calls page_address() on them ? Some
> > DMA ops do that for example, or some devices might ...
> 
> Although we could probably work around it with some pain, we rely on
> page_address() and virt_to_phys(), etc to work on these pages. So on x86,
> yes, it makes it into the linear mapping.

This is pretty easy to do with HMM:

unsigned long hmm_page_to_phys_pfn(struct page *page)
{
    struct hmm_devmem *devmem;
    unsigned long ppfn;

    /* Sanity test maybe BUG_ON() */
    if (!is_device_private_page(page))
        return -1UL;

    devmem = page->pgmap->data;
    ppfn = page_to_page(page) - devmem->pfn_first;
    return ppfn + devmem->device_phys_base_pfn;
}

Note that last field does not exist in today HMM because i did not need
such helper so far but this can be added.

Cheers,
J�r�me
