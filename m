Return-Path: <logang@deltatee.com>
To: Bart Van Assche <bvanassche@acm.org>, linux-kernel@vger.kernel.org,
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
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20180925162231.4354-1-logang@deltatee.com>
 <20180925162231.4354-3-logang@deltatee.com>
 <1537896555.11137.22.camel@acm.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9241a6af-9826-d1ff-c13b-882cb3b6a34a@deltatee.com>
Date: Tue, 25 Sep 2018 12:15:19 -0600
MIME-Version: 1.0
In-Reply-To: <1537896555.11137.22.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v7 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
List-ID: <linux-block@vger.kernel.org>



On 2018-09-25 11:29 a.m., Bart Van Assche wrote:
> On Tue, 2018-09-25 at 10:22 -0600, Logan Gunthorpe wrote:
>> @@ -83,9 +132,14 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
>>  
>>  	pdev->p2pdma = p2p;
>>  
>> +	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
>> +	if (error)
>> +		goto out_pool_destroy;
>> +
>>  	return 0;
>>  
>>  out_pool_destroy:
>> +	pdev->p2pdma = NULL;
>>  	gen_pool_destroy(p2p->pool);
>>  out:
>>  	devm_kfree(&pdev->dev, p2p);
> 
> This doesn't look right to me. Shouldn't devm_remove_action() be called instead
> of devm_kfree() if sysfs_create_group() fails?

That makes no sense to me. We are reversing a devm_kzalloc() not a
custom action....

One could argue we should _also_ remove the pci_p2pdma_release() action,
but seeing it has a NULL check on pdev->p2pdma it's pretty harmless to
leave in.

Logan
