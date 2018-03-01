Return-Path: <logang@deltatee.com>
To: benh@au1.ibm.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Oliver OHalloran <oliveroh@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <8e808448-fc01-5da0-51e7-1a6657d5a23a@deltatee.com>
 <1519936195.4592.18.camel@au1.ibm.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c3014722-c97a-bd23-9939-afd05f4f17e9@deltatee.com>
Date: Thu, 1 Mar 2018 13:55:59 -0700
MIME-Version: 1.0
In-Reply-To: <1519936195.4592.18.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 01/03/18 01:29 PM, Benjamin Herrenschmidt wrote:
> Oliver can you look into this ? You sais the memory was effectively
> hotplug'ed into the system when creating the struct pages. That would
> mean to me that it's a) mapped (which for us is cachable, maybe x86 has
> tricks to avoid that) and b) potentially used to populate userspace
> pages (that will definitely be cachable). Unless there's something in
> there you didn't see that prevents it.

Yes, we've been specifically prohibiting all cases where these pages get 
passed to userspace. We don't want that. Although it works in limited 
cases (ie x86), and we use it for some testing, there are dragons there.

>   - Our MMIO space is very far away from memory (high bits set in the
> address) which causes problem with things like vmmemmap, page_address,
> virt_to_page etc... Do you have similar issues on arm64 ?

No similar issues on arm64. Any chance you could simply not map the PCI 
bars that way? What's the point of that? It may simply mean ppc64 can't 
be supported until either that changes or the kernel infrastructure gets 
more sophisticated.

> Logan, the only reason you need struct page's to begin with is for the
> DMA API right ? Or am I missing something here ?

It's not so much the DMA map API as it is the entire kernel 
infrastructure. Scatter lists (which are universally used to setup DMA 
requests) require pages and bios require pages, etc, etc. In fact, this 
patch set, in its current form, routes around the DMA API entirely.

Myself[1] and others have done prototype work to migrate away from 
struct pages and to use pfn_t instead but this work doesn't seem to get 
very far in the community.

Logan


[1] https://marc.info/?l=linux-kernel&m=149566222124326&w=2
