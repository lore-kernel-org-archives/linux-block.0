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
 <2d59aa02-f2fa-bd88-1b6c-923117a6ad28@deltatee.com>
 <17e7bc28-f499-c7f7-f91a-9f6778de5fd3@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aa542739-17c1-870d-bac8-1d53eb32ff70@deltatee.com>
Date: Fri, 4 May 2018 09:52:26 -0600
MIME-Version: 1.0
In-Reply-To: <17e7bc28-f499-c7f7-f91a-9f6778de5fd3@amd.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
List-ID: <linux-block@vger.kernel.org>



On 04/05/18 08:27 AM, Christian König wrote:
> Are you sure that this is more convenient? At least on first glance it 
> feels overly complicated.
> 
> I mean what's the difference between the two approaches?
> 
>      sum = pci_p2pdma_distance(target, [A, B, C, target]);
> 
> and
> 
>      sum = pci_p2pdma_distance(target, A);
>      sum += pci_p2pdma_distance(target, B);
>      sum += pci_p2pdma_distance(target, C);

Well, it's more for consistency with the pci_p2pdma_find() which has to
take a list of devices to find a resource which matches all of them.
(You can't use multiple calls in that case because all the devices in
the list might not have the same set of compatible providers.) That way
we can use the same list to check the distance (when the user specifies
a device) as we do to find a compatible device (when the user wants to
automatically find one.

Logan
