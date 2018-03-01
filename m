Return-Path: <logang@deltatee.com>
To: Jerome Glisse <jglisse@redhat.com>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com> <20180301205548.GA6742@redhat.com>
 <a512edf9-2d96-9229-fe60-e0ea60b3922b@deltatee.com>
 <20180301211036.GB6742@redhat.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8ed955f8-55c9-a2bd-1d58-90bf1dcfa055@deltatee.com>
Date: Thu, 1 Mar 2018 14:15:01 -0700
MIME-Version: 1.0
In-Reply-To: <20180301211036.GB6742@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 02:10 PM, Jerome Glisse wrote:
> It seems people miss-understand HMM :( you do not have to use all of
> its features. If all you care about is having struct page then just
> use that for instance in your case only use those following 3 functions:
> 
> hmm_devmem_add() or hmm_devmem_add_resource() and hmm_devmem_remove()
> for cleanup.

To what benefit over just using devm_memremap_pages()? If I'm using the 
hmm interface and disabling all the features, I don't see the point. 
We've also cleaned up the devm_memremap_pages() interface to be more 
usefully generic in such a way that I'd hope HMM starts using it too and 
gets rid of the code duplication.

Logan
