Return-Path: <logang@deltatee.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma <linux-rdma@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Max Gurtovoy <maxg@mellanox.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com> <1519936815.4592.25.camel@au1.ibm.com>
 <20180301205315.GJ19007@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bfc3a780-4ca5-f52b-665f-7f13142a500f@deltatee.com>
Date: Thu, 1 Mar 2018 13:57:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180301205315.GJ19007@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 01:53 PM, Jason Gunthorpe wrote:
> On Fri, Mar 02, 2018 at 07:40:15AM +1100, Benjamin Herrenschmidt wrote:
>> Also we need to be able to hard block MEMREMAP_WB mappings of non-RAM
>> on ppc64 (maybe via an arch hook as it might depend on the processor
>> family). Server powerpc cannot do cachable accesses on IO memory
>> (unless it's special OpenCAPI or nVlink, but not on PCIe).
> 
> I think you are right on this - even on x86 we must not create
> cachable mappings of PCI BARs - there is no way that works the way
> anyone would expect.

On x86, even if I try to make a cachable mapping of a PCI BAR it always 
ends up being un-cached. The arch code in x86 always does the right 
thing here.... Other arches, not so much.

Logan
