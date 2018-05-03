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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <38d866cf-f7b4-7118-d737-5a5dcd9f3784@amd.com>
Date: Thu, 3 May 2018 19:29:11 +0200
MIME-Version: 1.0
In-Reply-To: <ce2e5351-f32a-bd80-1c77-b7fc38842175@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: christian.koenig@amd.com
List-ID: <linux-block@vger.kernel.org>

Am 03.05.2018 um 17:59 schrieb Logan Gunthorpe:
> On 03/05/18 03:05 AM, Christian König wrote:
>> Second question is how to you want to handle things when device are not
>> behind the same root port (which is perfectly possible in the cases I
>> deal with)?
> I think we need to implement a whitelist. If both root ports are in the
> white list and are on the same bus then we return a larger distance
> instead of -1.

Sounds good.

>> Third question why multiple clients? That feels a bit like you are
>> pushing something special to your use case into the common PCI
>> subsystem. Something which usually isn't a good idea.
> No, I think this will be pretty standard. In the simple general case you
> are going to have one provider and at least two clients (one which
> writes the memory and one which reads it). However, one client is
> likely, but not necessarily, the same as the provider.

Ok, that is the point where I'm stuck. Why do we need that in one 
function call in the PCIe subsystem?

The problem at least with GPUs is that we seriously don't have that 
information here, cause the PCI subsystem might not be aware of all the 
interconnections.

For example it isn't uncommon to put multiple GPUs on one board. To the 
PCI subsystem that looks like separate devices, but in reality all GPUs 
are interconnected and can access each others memory directly without 
going over the PCIe bus.

I seriously don't want to model that in the PCI subsystem, but rather 
the driver. That's why it feels like a mistake to me to push all that 
into the PCI function.

> In the NVMeof case, we might have N clients: 1 RDMA device and N-1 block
> devices. The code doesn't care which device provides the memory as it
> could be the RDMA device or one/all of the block devices (or, in theory,
> a completely separate device with P2P-able memory). However, it does
> require that all devices involved are accessible per
> pci_p2pdma_distance() or it won't use P2P transactions.
>
> I could also imagine other use cases: ie. an RDMA NIC sends data to a
> GPU for processing and then sends the data to an NVMe device for storage
> (or vice-versa). In this case we have 3 clients and one provider.

Why can't we model that as two separate transactions?

E.g. one from the RDMA NIC to the GPU memory. And another one from the 
GPU memory to the NVMe device.

That would also match how I get this information from userspace.

>> As far as I can see we need a function which return the distance between
>> a initiator and target device. This function then returns -1 if the
>> transaction can't be made and a positive value otherwise.
> If you need to make a simpler convenience function for your use case I'm
> not against it.

Yeah, same for me. If Bjorn is ok with that specialized NVM functions 
that I'm fine with that as well.

I think it would just be more convenient when we can come up with 
functions which can handle all use cases, cause there still seems to be 
a lot of similarities.

>
>> We also need to give the direction of the transaction and have a
>> whitelist root complex PCI-IDs which can handle P2P transactions from
>> different ports for a certain DMA direction.
> Yes. In the NVMeof case we need all devices to be able to DMA in both
> directions so we did not need the DMA direction. But I can see this
> being useful once we add the whitelist.

Ok, I agree that can be added later on. For simplicity let's assume for 
now we always to bidirectional transfers.

Thanks for the explanation,
Christian.

>
> Logan
