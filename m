Return-Path: <logang@deltatee.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-8-logang@deltatee.com>
 <0118d3d8-a2f5-047f-6627-04ac3d0371ad@kernel.dk>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5998a8c3-697e-82ac-91d4-a648455a21e9@deltatee.com>
Date: Thu, 13 Sep 2018 10:14:02 -0600
MIME-Version: 1.0
In-Reply-To: <0118d3d8-a2f5-047f-6627-04ac3d0371ad@kernel.dk>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 07/13] block: Add PCI P2P flag for request queue and
 check support for requests
List-ID: <linux-block@vger.kernel.org>



On 12/09/18 06:28 PM, Jens Axboe wrote:
> On 9/12/18 6:11 PM, Logan Gunthorpe wrote:
>> QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
>> supports targeting P2P memory.
>>
>> When a request is submitted we check if PCI P2PDMA memory is assigned
>> to the first page in the bio. If it is, we ensure the queue it's
>> submitted to supports it, and enforce REQ_NOMERGE.
> 
> This changelog is no longer accurate.


Oops, I'll fix this for v7.

Thanks,

Logan
