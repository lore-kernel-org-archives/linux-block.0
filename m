Return-Path: <logang@deltatee.com>
To: benh@au1.ibm.com, Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma <linux-rdma@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519938210.4592.30.camel@au1.ibm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1de70207-40ce-29f0-6093-337112852475@deltatee.com>
Date: Thu, 1 Mar 2018 14:11:34 -0700
MIME-Version: 1.0
In-Reply-To: <1519938210.4592.30.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 02:03 PM, Benjamin Herrenschmidt wrote:
> However, what happens if anything calls page_address() on them ? Some
> DMA ops do that for example, or some devices might ...

Although we could probably work around it with some pain, we rely on 
page_address() and virt_to_phys(), etc to work on these pages. So on 
x86, yes, it makes it into the linear mapping.

Logan
