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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3e4e0126-f444-8d88-6793-b5eb97c61f76@amd.com>
Date: Thu, 3 May 2018 11:05:21 +0200
MIME-Version: 1.0
In-Reply-To: <805645c1-ea40-2e57-88eb-5dd34e579b2e@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: christian.koenig@amd.com
List-ID: <linux-block@vger.kernel.org>

Am 02.05.2018 um 17:56 schrieb Logan Gunthorpe:
> Hi Christian,
>
> On 5/2/2018 5:51 AM, Christian König wrote:
>> it would be rather nice to have if you could separate out the 
>> functions to detect if peer2peer is possible between two devices.
>
> This would essentially be pci_p2pdma_distance() in the existing 
> patchset. It returns the sum of the distance between a list of clients 
> and a P2PDMA provider. It returns -1 if peer2peer is not possible 
> between the devices (presently this means they are not behind the same 
> root port).

Ok, I'm still missing the big picture here. First question is what is 
the P2PDMA provider?

Second question is how to you want to handle things when device are not 
behind the same root port (which is perfectly possible in the cases I 
deal with)?

Third question why multiple clients? That feels a bit like you are 
pushing something special to your use case into the common PCI 
subsystem. Something which usually isn't a good idea.



As far as I can see we need a function which return the distance between 
a initiator and target device. This function then returns -1 if the 
transaction can't be made and a positive value otherwise.

We also need to give the direction of the transaction and have a 
whitelist root complex PCI-IDs which can handle P2P transactions from 
different ports for a certain DMA direction.


Christian.

>
> Logan
