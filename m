Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <1519876569.4592.4.camel@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com> <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 1 Mar 2018 11:21:13 -0800
Message-ID: <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
To: benh@au1.ibm.com
Cc: Logan Gunthorpe <logang@deltatee.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma <linux-rdma@vger.kernel.org>,
	linux-nvdimm <linux-nvdimm@lists.01.org>, linux-block@vger.kernel.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>, Oliver OHalloran <oliveroh@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 28, 2018 at 7:56 PM, Benjamin Herrenschmidt
<benh@au1.ibm.com> wrote:
> On Thu, 2018-03-01 at 14:54 +1100, Benjamin Herrenschmidt wrote:
>> On Wed, 2018-02-28 at 16:39 -0700, Logan Gunthorpe wrote:
>> > Hi Everyone,
>>
>>
>> So Oliver (CC) was having issues getting any of that to work for us.
>>
>> The problem is that acccording to him (I didn't double check the latest
>> patches) you effectively hotplug the PCIe memory into the system when
>> creating struct pages.
>>
>> This cannot possibly work for us. First we cannot map PCIe memory as
>> cachable. (Note that doing so is a bad idea if you are behind a PLX
>> switch anyway since you'd ahve to manage cache coherency in SW).
>
> Note: I think the above means it won't work behind a switch on x86
> either, will it ?

The devm_memremap_pages() infrastructure allows placing the memmap in
"System-RAM" even if the hotplugged range is in PCI space. So, even if
it is an issue on some configurations, it's just a simple adjustment
to where the memmap is placed.
