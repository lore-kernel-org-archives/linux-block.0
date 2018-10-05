Return-Path: <logang@deltatee.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>
References: <20181004212747.6301-1-logang@deltatee.com>
 <20181004212747.6301-12-logang@deltatee.com> <20181005071044.GB23834@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4f844956-fe91-0ace-4f8e-4da3a747e593@deltatee.com>
Date: Fri, 5 Oct 2018 09:39:36 -0600
MIME-Version: 1.0
In-Reply-To: <20181005071044.GB23834@lst.de>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v9 11/13] nvme-pci: Add a quirk for a pseudo CMB
List-ID: <linux-block@vger.kernel.org>



On 2018-10-05 1:10 a.m., Christoph Hellwig wrote:
> On Thu, Oct 04, 2018 at 03:27:45PM -0600, Logan Gunthorpe wrote:
>> Introduce a quirk to use CMB-like memory on older devices that have
>> an exposed BAR but do not advertise support for using CMBLOC and
>> CMBSIZE.
>>
>> We'd like to use some of these older cards to test P2P memory.
> 
> I can't sat that I really like adding support for non-standardized
> "features" (vs bugs) in the nvme driver.
> 

I can live with this patch being dropped.

Logan
