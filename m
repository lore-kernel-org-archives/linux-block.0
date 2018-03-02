Return-Path: <logang@deltatee.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Oliver OHalloran <oliveroh@au1.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, linux-pci@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com>
 <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
 <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
 <43ba615f-a6e1-9444-65e1-494169cb415d@deltatee.com>
 <1519945204.4592.45.camel@au1.ibm.com>
 <595acefb-18fc-e650-e172-bae271263c4c@deltatee.com>
 <1519946734.4592.48.camel@au1.ibm.com>
 <1520027052.4592.60.camel@kernel.crashing.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cd3ff8cf-a5a7-1a92-d92a-689edcde51d6@deltatee.com>
Date: Fri, 2 Mar 2018 15:24:36 -0700
MIME-Version: 1.0
In-Reply-To: <1520027052.4592.60.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 02/03/18 02:44 PM, Benjamin Herrenschmidt wrote:
> Allright, so, I think I have a plan to fix this, but it will take a
> little bit of time.
> 
> Basically the idea is to have firmware pass to Linux a region that's
> known to not have anything in it that it can use for the vmalloc space
> rather than have linux arbitrarily cut the address space in half.
> 
> I'm pretty sure I can always find large enough "holes" in the physical
> address space that are outside of both RAM/OpenCAPI/Nvlink and
> PCIe/MMIO space. If anything, unused chip IDs. But I don't want Linux
> to have to know about the intimate HW details so I'll pass it from FW.
> 
> It will take some time to adjust Linux and get updated FW around
> though.
> 
> Once that's done, I'll be able to have the linear mapping go through
> the entire 52-bit space (minus that hole). Of course the hole need to
> be large enough to hold a vmemmap for a 52-bit space, so that's about
> 4TB. So I probably need a hole that's at least 8TB.
> 
> As for the mapping attributes, it should be easy for my linear mapping
> code to ensure anything that isn't actual RAM is mapped NC.

Very cool. I'm glad to hear you found a way to fix this.

Thanks,

Logan
