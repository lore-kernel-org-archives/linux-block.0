Return-Path: <logang@deltatee.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@mellanox.com>,
 Max Gurtovoy <maxg@mellanox.com>, Dan Williams <dan.j.williams@intel.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-2-logang@deltatee.com>
 <20180920223829.GD224714@bhelgaas-glaptop.roam.corp.google.com>
 <ab733346-9518-ed68-492d-e52929586293@deltatee.com>
 <20180921130010.GE224714@bhelgaas-glaptop.roam.corp.google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a7e2b2cb-ea35-0a97-498b-1f5753e406aa@deltatee.com>
Date: Fri, 21 Sep 2018 09:37:33 -0600
MIME-Version: 1.0
In-Reply-To: <20180921130010.GE224714@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v6 01/13] PCI/P2PDMA: Support peer-to-peer memory
List-ID: <linux-block@vger.kernel.org>

On 2018-09-21 7:00 AM, Bjorn Helgaas wrote:
> On Thu, Sep 20, 2018 at 04:47:49PM -0600, Logan Gunthorpe wrote:
>> On 2018-09-20 4:38 PM, Bjorn Helgaas wrote:
>>>> +#define pr_fmt(fmt) "pci-p2pdma: " fmt
>>>
>>> Is pr_fmt() actually used anywhere?
>>
>> It's used in a Patch 4 to print errors in the configfs helpers.
> 
> Ideally pr_fmt() would be added in the same patch that uses it, but
> obviously pretty trivial.

Hmm, well Christoph asked me to do it this way. ;)

Logan
