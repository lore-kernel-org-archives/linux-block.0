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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ce2e5351-f32a-bd80-1c77-b7fc38842175@deltatee.com>
Date: Thu, 3 May 2018 09:59:54 -0600
MIME-Version: 1.0
In-Reply-To: <3e4e0126-f444-8d88-6793-b5eb97c61f76@amd.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 03/05/18 03:05 AM, Christian König wrote:
> Ok, I'm still missing the big picture here. First question is what is 
> the P2PDMA provider?

Well there's some pretty good documentation in the patchset for this,
but in short, a provider is a device that provides some kind of P2P
resource (ie. BAR memory, or perhaps a doorbell register -- only memory
is supported at this time).

> Second question is how to you want to handle things when device are not 
> behind the same root port (which is perfectly possible in the cases I 
> deal with)?

I think we need to implement a whitelist. If both root ports are in the
white list and are on the same bus then we return a larger distance
instead of -1.

> Third question why multiple clients? That feels a bit like you are 
> pushing something special to your use case into the common PCI 
> subsystem. Something which usually isn't a good idea.

No, I think this will be pretty standard. In the simple general case you
are going to have one provider and at least two clients (one which
writes the memory and one which reads it). However, one client is
likely, but not necessarily, the same as the provider.

In the NVMeof case, we might have N clients: 1 RDMA device and N-1 block
devices. The code doesn't care which device provides the memory as it
could be the RDMA device or one/all of the block devices (or, in theory,
a completely separate device with P2P-able memory). However, it does
require that all devices involved are accessible per
pci_p2pdma_distance() or it won't use P2P transactions.

I could also imagine other use cases: ie. an RDMA NIC sends data to a
GPU for processing and then sends the data to an NVMe device for storage
(or vice-versa). In this case we have 3 clients and one provider.

> As far as I can see we need a function which return the distance between 
> a initiator and target device. This function then returns -1 if the 
> transaction can't be made and a positive value otherwise.

If you need to make a simpler convenience function for your use case I'm
not against it.

> We also need to give the direction of the transaction and have a 
> whitelist root complex PCI-IDs which can handle P2P transactions from 
> different ports for a certain DMA direction.

Yes. In the NVMeof case we need all devices to be able to DMA in both
directions so we did not need the DMA direction. But I can see this
being useful once we add the whitelist.

Logan
