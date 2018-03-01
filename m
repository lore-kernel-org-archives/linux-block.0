Return-Path: <logang@deltatee.com>
To: Jerome Glisse <jglisse@redhat.com>
Cc: benh@au1.ibm.com, Dan Williams <dan.j.williams@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma <linux-rdma@vger.kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519938210.4592.30.camel@au1.ibm.com>
 <1de70207-40ce-29f0-6093-337112852475@deltatee.com>
 <20180301211817.GC6742@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <25034ee7-de03-ed77-78e0-2333f46897cc@deltatee.com>
Date: Thu, 1 Mar 2018 14:22:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180301211817.GC6742@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 02:18 PM, Jerome Glisse wrote:
> This is pretty easy to do with HMM:
> 
> unsigned long hmm_page_to_phys_pfn(struct page *page)
This is not useful unless you want to go through all the kernel paths we 
are using and replace page_to_phys() and friends with something else 
that calls an HMM function when appropriate...

The problem isn't getting the physical address from a page, it's that we 
are passing these pages through various kernel interfaces which expect 
pages that work in the usual manner. (Look at the code: we quite simply 
provide a way to get the PCI bus address from a page when necessary).

Logan
