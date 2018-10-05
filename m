Return-Path: <logang@deltatee.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org, Stephen Bates <sbates@raithlin.com>,
 Keith Busch <keith.busch@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Steve Wise <swise@opengridcomputing.com>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-14-logang@deltatee.com>
 <a3af4bda-0b73-c964-c7d6-5d59f0710768@grimberg.me>
 <2bcc0927-83ab-1bf2-d584-aebd5274cefa@deltatee.com>
 <20181005070720.GA23725@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <298e6e20-c8b6-de4b-46f5-94d1d3e2445c@deltatee.com>
Date: Fri, 5 Oct 2018 09:42:05 -0600
MIME-Version: 1.0
In-Reply-To: <20181005070720.GA23725@lst.de>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v9 13/13] nvmet: Optionally use PCI P2P memory
List-ID: <linux-block@vger.kernel.org>



On 2018-10-05 1:07 a.m., Christoph Hellwig wrote:
> On Thu, Oct 04, 2018 at 04:29:19PM -0600, Logan Gunthorpe wrote:
>>> This needs to handle non bdev namespaces.
>>
>> As it's coded now the helper never gets called unless ns->bdev is not
>> null. But in general, yes you are right, we should probably return NULL
>> if ns->bdev is NULL.
> 
> I'd rather skip that for now.

Ok, if I do a v10 I'll add it but I don't have anything else queued up
at the moment.


>> Sure, I guess that makes sense. I've never tried it with fc hardware but
>> I assume there's no reason it wouldn't work.
>>
>> I'll queue these changes up for a v10.
> 
> And I'd wait until someone has actually tested this case.

Agreed.

Thanks for the review!

Logan
