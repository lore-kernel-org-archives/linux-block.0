Return-Path: <logang@deltatee.com>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <b8acf835-df94-9967-2327-8f0e39d88511@amd.com>
 <805645c1-ea40-2e57-88eb-5dd34e579b2e@deltatee.com>
 <3e4e0126-f444-8d88-6793-b5eb97c61f76@amd.com>
 <ce2e5351-f32a-bd80-1c77-b7fc38842175@deltatee.com>
 <38d866cf-f7b4-7118-d737-5a5dcd9f3784@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2d59aa02-f2fa-bd88-1b6c-923117a6ad28@deltatee.com>
Date: Thu, 3 May 2018 12:43:21 -0600
MIME-Version: 1.0
In-Reply-To: <38d866cf-f7b4-7118-d737-5a5dcd9f3784@amd.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 03/05/18 11:29 AM, Christian König wrote:
> Ok, that is the point where I'm stuck. Why do we need that in one 
> function call in the PCIe subsystem?
> 
> The problem at least with GPUs is that we seriously don't have that 
> information here, cause the PCI subsystem might not be aware of all the 
> interconnections.
> 
> For example it isn't uncommon to put multiple GPUs on one board. To the 
> PCI subsystem that looks like separate devices, but in reality all GPUs 
> are interconnected and can access each others memory directly without 
> going over the PCIe bus.
> 
> I seriously don't want to model that in the PCI subsystem, but rather 
> the driver. That's why it feels like a mistake to me to push all that 
> into the PCI function.

Huh? I'm lost. If you have a bunch of PCI devices you can send them as a
list to this API, if you want. If the driver is _sure_ they are all the
same, you only have to send one. In your terminology, you'd just have to
call the interface with:

pci_p2pdma_distance(target, [initiator, target])

> Why can't we model that as two separate transactions?

You could, but this is more convenient for users of the API that need to
deal with multiple devices (and manage devices that may be added or
removed at any time).

> Yeah, same for me. If Bjorn is ok with that specialized NVM functions 
> that I'm fine with that as well.
> 
> I think it would just be more convenient when we can come up with 
> functions which can handle all use cases, cause there still seems to be 
> a lot of similarities.

The way it's implemented is more general and can handle all use cases.
You are arguing for a function that can handle your case (albeit with a
bit more fuss) but can't handle mine and is therefore less general.
Calling my interface specialized is wrong.

Logan
