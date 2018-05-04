Return-Path: <Christian.Koenig@amd.com>
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
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
 <2d59aa02-f2fa-bd88-1b6c-923117a6ad28@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <17e7bc28-f499-c7f7-f91a-9f6778de5fd3@amd.com>
Date: Fri, 4 May 2018 16:27:35 +0200
MIME-Version: 1.0
In-Reply-To: <2d59aa02-f2fa-bd88-1b6c-923117a6ad28@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: christian.koenig@amd.com
List-ID: <linux-block@vger.kernel.org>

Am 03.05.2018 um 20:43 schrieb Logan Gunthorpe:
>
> On 03/05/18 11:29 AM, Christian König wrote:
>> Ok, that is the point where I'm stuck. Why do we need that in one
>> function call in the PCIe subsystem?
>>
>> The problem at least with GPUs is that we seriously don't have that
>> information here, cause the PCI subsystem might not be aware of all the
>> interconnections.
>>
>> For example it isn't uncommon to put multiple GPUs on one board. To the
>> PCI subsystem that looks like separate devices, but in reality all GPUs
>> are interconnected and can access each others memory directly without
>> going over the PCIe bus.
>>
>> I seriously don't want to model that in the PCI subsystem, but rather
>> the driver. That's why it feels like a mistake to me to push all that
>> into the PCI function.
> Huh? I'm lost. If you have a bunch of PCI devices you can send them as a
> list to this API, if you want. If the driver is _sure_ they are all the
> same, you only have to send one. In your terminology, you'd just have to
> call the interface with:
>
> pci_p2pdma_distance(target, [initiator, target])

Ok, I expected that something like that would do it.

So just to confirm: When I have a bunch of GPUs which could be the 
initiator I only need to do "pci_p2pdma_distance(target, [first GPU, 
target]);" and not "pci_p2pdma_distance(target, [first GPU, second GPU, 
third GPU, forth...., target])" ?

>> Why can't we model that as two separate transactions?
> You could, but this is more convenient for users of the API that need to
> deal with multiple devices (and manage devices that may be added or
> removed at any time).

Are you sure that this is more convenient? At least on first glance it 
feels overly complicated.

I mean what's the difference between the two approaches?

     sum = pci_p2pdma_distance(target, [A, B, C, target]);

and

     sum = pci_p2pdma_distance(target, A);
     sum += pci_p2pdma_distance(target, B);
     sum += pci_p2pdma_distance(target, C);

>> Yeah, same for me. If Bjorn is ok with that specialized NVM functions
>> that I'm fine with that as well.
>>
>> I think it would just be more convenient when we can come up with
>> functions which can handle all use cases, cause there still seems to be
>> a lot of similarities.
> The way it's implemented is more general and can handle all use cases.
> You are arguing for a function that can handle your case (albeit with a
> bit more fuss) but can't handle mine and is therefore less general.
> Calling my interface specialized is wrong.

Well at the end of the day you only need to convince Bjorn of the 
interface, so I'm perfectly fine with it as long as it serves my use 
case as well :)

But I still would like to understand your intention, cause that really 
helps not to accidentally break something in the long term.

Now when I take a look at the pure PCI hardware level, what I have is a 
transaction between an initiator and a target, and not multiple devices 
in one operation.

I mean you must have a very good reason that you now want to deal with 
multiple devices in the software layer, but neither from the code nor 
from your explanation that reason becomes obvious to me.

Thanks,
Christian.

>
> Logan
