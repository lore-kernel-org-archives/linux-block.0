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
 <1519946767.4592.49.camel@kernel.crashing.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <0181dbb9-0b63-5a99-0425-ec77fe5b1e3f@deltatee.com>
Date: Thu, 1 Mar 2018 16:54:51 -0700
MIME-Version: 1.0
In-Reply-To: <1519946767.4592.49.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 04:26 PM, Benjamin Herrenschmidt wrote:
> The big problem is not the vmemmap, it's the linear mapping.

Ah, yes, ok.

Logan
