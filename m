Return-Path: <logang@deltatee.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
 linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jonathan Corbet <corbet@lwn.net>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-7-logang@deltatee.com>
 <59b7762e-6d38-7746-20f3-22fd762ecfe7@infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9e20024d-8b32-61ff-4b9a-c9392082987f@deltatee.com>
Date: Tue, 22 May 2018 15:28:19 -0600
MIME-Version: 1.0
In-Reply-To: <59b7762e-6d38-7746-20f3-22fd762ecfe7@infradead.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v4 06/14] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
List-ID: <linux-block@vger.kernel.org>

Thanks for the review Randy! I'll make the changes for the next time we
post the series.

On 22/05/18 03:24 PM, Randy Dunlap wrote:
>> +The first task an orchestrator driver must do is compile a list of
>> +all client drivers that will be involved in a given transaction. For
>> +example, the NVMe Target driver creates a list including all NVMe drives
>                                                                      ^^^^^^
>                                                                    or drivers ?
> Could be either, I guess, but the previous sentence says "compile a list of drivers."

I did mean "drives". But perhaps "devices" would be more clear. A list
of all NVMe drivers doesn't make much sense as I'm pretty sure there is
only one NVMe driver.

Logan
